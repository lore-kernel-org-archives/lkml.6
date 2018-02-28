Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeB1Le4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:34:56 -0500
Received: from foss.arm.com ([217.140.101.70]:48118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeB1Lez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:34:55 -0500
Date: Wed, 28 Feb 2018 11:34:56 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] Documentation/locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180228113456.GC7681@arm.com>
References: <1519814372-19941-1-git-send-email-parri.andrea@gmail.com>
 <20180228105631.GA7681@arm.com>
 <20180228112403.GA32228@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228112403.GA32228@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 12:24:03PM +0100, Andrea Parri wrote:
> On Wed, Feb 28, 2018 at 10:56:32AM +0000, Will Deacon wrote:
> > On Wed, Feb 28, 2018 at 11:39:32AM +0100, Andrea Parri wrote:
> > > There appeared to be a certain, recurrent uncertainty concerning the
> > > semantics of spin_is_locked(), likely a consequence of the fact that
> > > this semantics remains undocumented or that it has been historically
> > > linked to the (likewise unclear) semantics of spin_unlock_wait().
> > > 
> > > Document this semantics.
> > > 
> > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > > Cc: Luc Maranget <luc.maranget@inria.fr>
> > > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > Cc: Akira Yokosawa <akiyks@gmail.com>
> > > ---
> > >  include/linux/spinlock.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > > index 4894d322d2584..2639fdc9a916c 100644
> > > --- a/include/linux/spinlock.h
> > > +++ b/include/linux/spinlock.h
> > > @@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> > >  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> > >  })
> > >  
> > > +/**
> > > + * spin_is_locked() - Check whether a spinlock is locked.
> > > + * @lock: Pointer to the spinlock.
> > > + *
> > > + * This function is NOT required to provide any memory ordering
> > > + * guarantees; it could be used for debugging purposes or, when
> > > + * additional synchronization is needed, accompanied with other
> > > + * constructs (memory barriers) enforcing the synchronization.
> > > + *
> > > + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> > > + */
> > 
> > I also don't think this is quite right, since the spin_is_locked check
> > must be ordered after all prior lock acquisitions (to any lock) on the same
> > CPU. That's why we have an smp_mb() in there on arm64 (see 38b850a73034f).
> 
> So, arm64 (and powerpc) complies to the semantics I _have_ in mind ...

Sure, but they're offering more than that at present. If I can remove the
smp_mb() in our spin_is_locked implementation, I will, but we need to know
what that will break even if you consider that code to be broken because it
relies on something undocumented.

> > So this is a change in semantics and we need to audit the users before
> > proceeding. We should also keep spin_is_locked consistent with the versions
> > for mutex, rwsem, bit_spin.
> 
> Well, strictly speaking, it isn't (given that the current semantics is,
> as reported above, currently undocumented); for the same reason, cases
> relying on anything more than _nothing_ (if any) are already broken ...

I suppose it depends on whether you consider the code or the documentation
to be authoritative. I tend to err on the side of the former for the kernel.
To be clear: I'm perfectly ok relaxing the semantics, but only if there's
some evidence that you've looked at the callsites and determined that they
won't break.  That's why I think a better first step would be to convert a
bunch of them to using lockdep for the "assert that I hold this lock"
checks, so we can start to see where the interesting cases are.

Will
