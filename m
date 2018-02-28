Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbeB1PQh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:16:37 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53700 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752395AbeB1PQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:16:35 -0500
Date: Wed, 28 Feb 2018 10:16:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Will Deacon <will.deacon@arm.com>
cc: Andrea Parri <parri.andrea@gmail.com>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] Documentation/locking: Document the semantics of
 spin_is_locked()
In-Reply-To: <20180228105631.GA7681@arm.com>
Message-ID: <Pine.LNX.4.44L0.1802281004220.1421-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Will Deacon wrote:

> On Wed, Feb 28, 2018 at 11:39:32AM +0100, Andrea Parri wrote:
> > There appeared to be a certain, recurrent uncertainty concerning the
> > semantics of spin_is_locked(), likely a consequence of the fact that
> > this semantics remains undocumented or that it has been historically
> > linked to the (likewise unclear) semantics of spin_unlock_wait().
> > 
> > Document this semantics.
> > 
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > ---
> >  include/linux/spinlock.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > index 4894d322d2584..2639fdc9a916c 100644
> > --- a/include/linux/spinlock.h
> > +++ b/include/linux/spinlock.h
> > @@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> >  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> >  })
> >  
> > +/**
> > + * spin_is_locked() - Check whether a spinlock is locked.
> > + * @lock: Pointer to the spinlock.
> > + *
> > + * This function is NOT required to provide any memory ordering
> > + * guarantees; it could be used for debugging purposes or, when
> > + * additional synchronization is needed, accompanied with other
> > + * constructs (memory barriers) enforcing the synchronization.
> > + *
> > + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> > + */
> 
> I also don't think this is quite right, since the spin_is_locked check
> must be ordered after all prior lock acquisitions (to any lock) on the same
> CPU. That's why we have an smp_mb() in there on arm64 (see 38b850a73034f).

Pardon me for being a little slow ... I often have trouble 
understanding what people mean when they talk about ordering.

In this case it sounds like you're referring to situations where we 
want to avoid ABBA deadlocks, and we want to avoid the overhead of 
actually taking a lock when all that's really needed is to check that 
nobody else owns the lock.

spinlock_t a, b;

P0() {
	spin_lock(&a);
	while (spin_is_locked(&b))
		cpu_relax();
	/* Assert P1 isn't in its critical section and won't enter it */
	...
	spin_unlock(&a);
}

P1() {
	spin_lock(&b);
	if (spin_is_locked(&a)) {
		spin_unlock(&b);	/* P0 wants us not to do anything */
		return;
	}
	...
	spin_unlock(&b);
}

Is this what you meant?

If so, the basic pattern is essentially SB.  Taking a lock involves 
doing a store, and testing a lock involves doing a read.  So ignoring 
all the extraneous stuff and any memory barriers, this looks like:

P0() {
	WRITE_ONCE(a, 1);
	r0 = READ_ONCE(b);
}

P1() {
	WRITE_ONCE(b, 1);
	r1 = READ_ONCE(a);
}

exists (0:r0=0 /\ 1:r1=0)

And of course it is well known that the SB pattern requires full memory
barriers on both sides.  Hence the original code should have been
written more like this:

P0() {
	spin_lock(&a);
	smp_mb__after_spinlock();
	while (spin_is_locked(&b))
		cpu_relax();
	/* Assert P1 won't enter its critical section */
	...
	spin_unlock(&a);
}

P1() {
	spin_lock(&b);
	smp_mb__after_spinlock();
	if (spin_is_locked(&a)) {
		spin_unlock(&b);	/* P0 wants us not to do anything */
		return;
	}
	...
	spin_unlock(&b);
}

with no need for any particular ordering of the spin_is_locked calls.

Or have I completely misunderstood your point?

Alan
