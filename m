Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeDEOfY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:35:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47078 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751195AbeDEOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:35:23 -0400
Date: Thu, 5 Apr 2018 10:35:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Peter Zijlstra <peterz@infradead.org>
cc: Daniel Jordan <daniel.m.jordan@oracle.com>, <parri.andrea@gmail.com>,
        <will.deacon@arm.com>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <paulmck@linux.vnet.ibm.com>, <akiyks@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Re: Control dependency between prior load in while condition and
 later store?
In-Reply-To: <20180405073204.GP4043@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1804051022170.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018, Peter Zijlstra wrote:

> On Wed, Apr 04, 2018 at 04:35:32PM -0400, Alan Stern wrote:
> > On Wed, 4 Apr 2018, Daniel Jordan wrote:
> > 
> > > A question for memory-barriers.txt aficionados.
> > > 
> > > Is there a control dependency between the prior load of 'a' and the 
> > > later store of 'c'?:
> > > 
> > >    while (READ_ONCE(a));
> > >    WRITE_ONCE(c, 1);
> > 
> > I would say that yes, there is.
> 
> Indeed.
> 
> > Yes, except that a more accurate view of the object code would be
> > something like this:
> > 
> > Loop:	r1 = READ_ONCE(a);
> > 	if (r1)
> > 		goto Loop;
> > 	else
> > 		;	// Do nothing
> > 	WRITE_ONCE(c, 1);
> > 
> > Here you can see that one path branches backward, so everything 
> > following the "if" is dependent on the READ_ONCE.
> 
> Agreed, and I think I even have code that relies on such a pattern
> somewhere.. Ah.. yes, see smp_cond_load_acquire().

One does have to be very careful when talking about compiler behavior.  
This happens to be a particularly delicate point.  My old copy of the
C++11 draft standard says (section 1.10 paragraph 24):


The implementation may assume that any thread will eventually do one of 
the following:

â- terminate,
â- make a call to a library I/O function,
â- access or modify a volatile object, or
â- perform a synchronization operation or an atomic operation.

[ Note: This is intended to allow compiler transformations such as 
removal of empty loops, even when termination cannot be proven. - end 
note ]


In this example, READ_ONCE() is in fact a volatile access, so we're 
okay.  But if it weren't, the compiler might decide to assume the loop 
will eventually terminate, meaning that the WRITE_ONCE() would always 
be executed eventually.  Then there would be nothing to prevent the 
compiler from moving the WRITE_ONCE() up before the start of the loop, 
which would of course destroy the control dependency.

Alan
