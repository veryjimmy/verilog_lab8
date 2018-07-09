module pingpong(clk,rst,hold,seg1,seg2);
	
	reg [3:0]count1;
	reg [3:0]count2;
	reg [30:0]cnt;
	reg [30:0]newclk;
	reg det;
	input rst;	//reset
	input clk;  //clock
	input hold;	//pause
	output [0:7]seg1;
	output [0:7]seg2;
	initial count1 = 4'b0000; //0
	initial count2 = 4'b0000; //0
		
	always @(posedge clk) 
	begin
		if(rst == 0)  
			begin
			count1 <= 4'b0000;
			count2 <= 4'b0000;
			end 
		if( hold == 0) 
		begin
			if(cnt > 5000000) 
			begin
				if( det == 0 ) 
				begin
					
						if(count1+1  == 10) 
						begin
							if(count2 != 9) 
							begin
							count2 <= (count2 +1);
							count1 <= 0;
							end
							else 
							begin
							det <= 1;
							count1 <= count1-1;
							end
						end
						else
						count1 <= (count1 + 1);
				end
				else 
				begin
						if(count1 == 0) 
						begin
							if(count2 != 0) 
							begin
							count2 <= (count2 -1);
							count1 <= 9;
							end
							else begin
							det <= 0;
							count1 <= count1+1;
							end
						end
						else
						count1 <= (count1 - 1);
				end		
			cnt <= 30'b0;
			end
			else 
			cnt <= cnt +1;
		end
	end
	Seg7 A(count1,seg1);
	Seg7 B(count2,seg2);
endmodule 
 

module Seg7(input [3:0] num, output [0:7] seg);
	reg [7:0] nseg;
    always @(num) 
    begin
        case (num)
            4'b0000: nseg = 8'b11111100; // 0
            4'b0001: nseg = 8'b01100000; // 1
            4'b0010: nseg = 8'b11011010; // 2
            4'b0011: nseg = 8'b11110010; // 3
            4'b0100: nseg = 8'b01100110; // 4
            4'b0101: nseg = 8'b10110110; // 5
            4'b0110: nseg = 8'b10111110; // 6
            4'b0111: nseg = 8'b11100100; // 7
            4'b1000: nseg = 8'b11111110; // 8
            4'b1001: nseg = 8'b11110110; // 9
            default: nseg = 8'b00000000; //  
        endcase
    end
	assign seg = ~nseg;
endmodule 

