Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeDDUff (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:35:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57910 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751654AbeDDUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:35:34 -0400
Date: Wed, 4 Apr 2018 16:35:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Daniel Jordan <daniel.m.jordan@oracle.com>
cc: parri.andrea@gmail.com, <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <paulmck@linux.vnet.ibm.com>, <akiyks@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Re: Control dependency between prior load in while condition and
 later store?
In-Reply-To: <087a5ca4-e788-60ee-9145-3a078781cf05@oracle.com>
Message-ID: <Pine.LNX.4.44L0.1804041623530.1401-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018, Daniel Jordan wrote:

> A question for memory-barriers.txt aficionados.
> 
> Is there a control dependency between the prior load of 'a' and the 
> later store of 'c'?:
> 
>    while (READ_ONCE(a));
>    WRITE_ONCE(c, 1);

I would say that yes, there is.

> I have my doubts because memory-barriers.txt doesn't talk much about 
> loops and because of what that document says here:
> 
>    In addition, control dependencies apply only to the then-clause and
>    else-clause of the if-statement in question.  In particular, it does
>    not necessarily apply to code following the if-statement:
> 
>    	q = READ_ONCE(a);
>    	if (q) {
>    		WRITE_ONCE(b, 1);
>    	} else {
>    		WRITE_ONCE(b, 2);
>    	}
>    	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */

This refers to situations where the two code paths meet up at the end
of the "if" statement.  If they don't meet up (because one of the paths
branches away -- especially if it branches backward) then the 
disclaimer doesn't apply, and everything following the "if" is 
dependent.

The reason is because the compiler knows that code following the "if" 
statement will be executed unconditionally if the paths meet up, so it 
can move that code back before the "if" (provided nothing else prevents 
such motion).  But if the paths don't meet up, the compiler can't 
perform the code motion -- if it did then the program might end up 
executing something that should not have been executed!

> It's not obvious to me how the then-clause/else-clause idea maps onto 
> loops, but if we think of the example at the top like this...
> 
>    while (1) {
>        if (!READ_ONCE(a)) {
>            WRITE_ONCE(c, 1);
>            break;
>        }
>    }
> 
> ...then the dependent store is within the then-clause.  Viewed this way, 
> it seems there would be a control dependency between a and c.
> 
> Is that right?

Yes, except that a more accurate view of the object code would be
something like this:

Loop:	r1 = READ_ONCE(a);
	if (r1)
		goto Loop;
	else
		;	// Do nothing
	WRITE_ONCE(c, 1);

Here you can see that one path branches backward, so everything 
following the "if" is dependent on the READ_ONCE.

Alan
