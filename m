Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeDDVQT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:16:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDDVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:16:18 -0400
Subject: Re: Control dependency between prior load in while condition and
 later store?
To: Alan Stern <stern@rowland.harvard.edu>
Cc: parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
References: <Pine.LNX.4.44L0.1804041623530.1401-100000@iolanthe.rowland.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle
Message-ID: <4fa47ea8-e208-16d6-3b78-747049e3ee53@oracle.com>
Date: Wed, 4 Apr 2018 17:10:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1804041623530.1401-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 04:35 PM, Alan Stern wrote:
> On Wed, 4 Apr 2018, Daniel Jordan wrote:
> 
>> A question for memory-barriers.txt aficionados.
>>
>> Is there a control dependency between the prior load of 'a' and the
>> later store of 'c'?:
>>
>>     while (READ_ONCE(a));
>>     WRITE_ONCE(c, 1);
> 
> I would say that yes, there is.
> 
>> I have my doubts because memory-barriers.txt doesn't talk much about
>> loops and because of what that document says here:
>>
>>     In addition, control dependencies apply only to the then-clause and
>>     else-clause of the if-statement in question.  In particular, it does
>>     not necessarily apply to code following the if-statement:
>>
>>     	q = READ_ONCE(a);
>>     	if (q) {
>>     		WRITE_ONCE(b, 1);
>>     	} else {
>>     		WRITE_ONCE(b, 2);
>>     	}
>>     	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */
> 
> This refers to situations where the two code paths meet up at the end
> of the "if" statement.  If they don't meet up (because one of the paths
> branches away -- especially if it branches backward) then the
> disclaimer doesn't apply, and everything following the "if" is
> dependent.

Ok, that's the part I wasn't getting: this is how the while loop changes 
the situation.

> The reason is because the compiler knows that code following the "if"
> statement will be executed unconditionally if the paths meet up, so it
> can move that code back before the "if" (provided nothing else prevents
> such motion).  But if the paths don't meet up, the compiler can't
> perform the code motion -- if it did then the program might end up
> executing something that should not have been executed!
> 
>> It's not obvious to me how the then-clause/else-clause idea maps onto
>> loops, but if we think of the example at the top like this...
>>
>>     while (1) {
>>         if (!READ_ONCE(a)) {
>>             WRITE_ONCE(c, 1);
>>             break;
>>         }
>>     }
>>
>> ...then the dependent store is within the then-clause.  Viewed this way,
>> it seems there would be a control dependency between a and c.
>>
>> Is that right?
> 
> Yes, except that a more accurate view of the object code would be
> something like this:
> 
> Loop:	r1 = READ_ONCE(a);
> 	if (r1)
> 		goto Loop;
> 	else
> 		;	// Do nothing
> 	WRITE_ONCE(c, 1);
> 
> Here you can see that one path branches backward, so everything
> following the "if" is dependent on the READ_ONCE.

That clears it up, thanks very much!
