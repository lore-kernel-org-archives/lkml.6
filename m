Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeBSRPE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:15:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33116 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753265AbeBSROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:14:46 -0500
Date: Mon, 19 Feb 2018 12:14:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrea Parri <parri.andrea@gmail.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep, smp_read_barrier_depends,
 and lockless_dereference
In-Reply-To: <20180217151413.GA3785@andrea>
Message-ID: <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018, Andrea Parri wrote:

> > Akira's observation about READ_ONCE extends to all (annotated) loads.  In
> > fact, it also applies to loads corresponding to unsuccessful RMW operations;
> > consider, for example, the following variation of MP+onceassign+derefonce:
> > 
> > C T
> > 
> > {
> > y=z;
> > z=0;
> > }
> > 
> > P0(int *x, int **y)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	smp_store_release(y, x);
> > }
> > 
> > P1(int **y, int *z)
> > {
> > 	int *r0;
> > 	int r1;
> > 
> > 	r0 = cmpxchg_relaxed(y, z, z);
> > 	r1 = READ_ONCE(*r0);
> > }
> > 
> > exists (1:r0=x /\ 1:r1=0)
> > 
> > The final state is allowed w/o the patch, and forbidden w/ the patch.
> > 
> > This also reminds me of
> > 
> >    5a8897cc7631fa544d079c443800f4420d1b173f
> >    ("locking/atomics/alpha: Add smp_read_barrier_depends() to _release()/_relaxed() atomics")
> > 
> > (that we probably want to mention in the commit message).
> 
> Please also notice that 5a8897cc7631f only touched alpha's atomic.h:
> I see no corresponding commit/change on {,cmp}xchg.h (where the "mb"
> is currently conditionally executed).

This leaves us with a question: Do we want to change the kernel by
adding memory barriers after unsuccessful RMW operations on Alpha, or
do we want to change the model by excluding such operations from
address dependencies?

Note that operations like atomic_add_unless() already include memory 
barriers.

Alan
