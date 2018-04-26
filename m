Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757065AbeDZQzF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:55:05 -0400
Received: from foss.arm.com ([217.140.101.70]:56530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757043AbeDZQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:54:59 -0400
Date: Thu, 26 Apr 2018 17:55:19 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com
Subject: Re: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
Message-ID: <20180426165518.GC898@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <20180426155335.GL4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426155335.GL4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Apr 26, 2018 at 05:53:35PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 11:34:19AM +0100, Will Deacon wrote:
> > @@ -290,58 +312,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  	}
> >  
> >  	/*
> > +	 * If we observe any contention; queue.
> > +	 */
> > +	if (val & ~_Q_LOCKED_MASK)
> > +		goto queue;
> > +
> > +	/*
> >  	 * trylock || pending
> >  	 *
> >  	 * 0,0,0 -> 0,0,1 ; trylock
> >  	 * 0,0,1 -> 0,1,1 ; pending
> >  	 */
> > +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> > +	if (!(val & ~_Q_LOCKED_MASK)) {
> >  		/*
> > +		 * we're pending, wait for the owner to go away.
> > +		 *
> > +		 * *,1,1 -> *,1,0
> 
> Tail must be 0 here, right?

Not necessarily. If we're concurrently setting pending with another slowpath
locker, they could queue in the tail behind us, so we can't mess with those
upper bits.

> > +		 *
> > +		 * this wait loop must be a load-acquire such that we match the
> > +		 * store-release that clears the locked bit and create lock
> > +		 * sequentiality; this is because not all
> > +		 * clear_pending_set_locked() implementations imply full
> > +		 * barriers.
> >  		 */
> > +		if (val & _Q_LOCKED_MASK) {
> > +			smp_cond_load_acquire(&lock->val.counter,
> > +					      !(VAL & _Q_LOCKED_MASK));
> > +		}
> >  
> >  		/*
> > +		 * take ownership and clear the pending bit.
> > +		 *
> > +		 * *,1,0 -> *,0,1
> >  		 */
> 
> Idem.

Same here, hence why clear_pending_set_locked is either a 16-bit store or an
RmW (we can't just clobber the tail with 0).

> > +		clear_pending_set_locked(lock);
> >  		return;
> > +	}
> >  
> >  	/*
> > +	 * If pending was clear but there are waiters in the queue, then
> > +	 * we need to undo our setting of pending before we queue ourselves.
> >  	 */
> > +	if (!(val & _Q_PENDING_MASK))
> > +		clear_pending(lock);
> 
> This is the branch for when we have !0 tail.

That's the case where "val" has a !0 tail, but I think the comments are
trying to talk about the status of the lockword in memory, no?

> >  	/*
> >  	 * End of pending bit optimistic spinning and beginning of MCS
> 
> > @@ -445,15 +459,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >  	 * claim the lock:
> >  	 *
> >  	 * n,0,0 -> 0,0,1 : lock, uncontended
> > +	 * *,*,0 -> *,*,1 : lock, contended
> >  	 *
> > +	 * If the queue head is the only one in the queue (lock value == tail)
> > +	 * and nobody is pending, clear the tail code and grab the lock.
> > +	 * Otherwise, we only need to grab the lock.
> >  	 */
> >  	for (;;) {
> >  		/* In the PV case we might already have _Q_LOCKED_VAL set */
> > +		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
> >  			set_locked(lock);
> >  			break;
> >  		}
> 
> This one hunk is terrible on the brain. I'm fairly sure I get it, but I
> feel that comment can use help. Or at least, I need help reading it.
> 
> I'll try and cook up something when my brain starts working again.

Cheers. I think the code is a bit easier to read if you look at it after the
whole series is applied, but the comments could probably still be improved.

Will
