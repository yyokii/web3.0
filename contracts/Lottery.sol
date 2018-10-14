pragma solidity ^0.4.0;

contract Lottery{
    address public manager;
    address[] public participants;
    
    constructor () public {
        manager = msg.sender;
    }
    
    function enterLottery() public payable {
        require(msg.value > 0.01 ether);
        participants.push(msg.sender);
    }
    
    function pickWinner() public{
        require(msg.sender == manager);
        uint index = random() % participants.length; 
        participants[index].transfer(this.balance);
        participants = new address[](0);
    }
    
    function random() private view returns(uint256){
        return uint(keccak256(block.difficulty, now, participants));
    }
}