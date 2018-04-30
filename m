Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeD3Iwv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:52:51 -0400
Received: from foss.arm.com ([217.140.101.70]:56342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeD3Iws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:52:48 -0400
Date: Mon, 30 Apr 2018 09:53:08 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com
Subject: Re: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
Message-ID: <20180430085307.GB15504@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <20180426155335.GL4064@hirez.programming.kicks-ass.net>
 <20180426165518.GC898@arm.com>
 <20180428124537.GD4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428124537.GD4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 02:45:37PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 05:55:19PM +0100, Will Deacon wrote:
> > On Thu, Apr 26, 2018 at 05:53:35PM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 26, 2018 at 11:34:19AM +0100, Will Deacon wrote:
> > > > @@ -290,58 +312,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > > >  	}
> > > >  
> > > >  	/*
> > > > +	 * If we observe any contention; queue.
> > > > +	 */
> > > > +	if (val & ~_Q_LOCKED_MASK)
> > > > +		goto queue;
> > > > +
> > > > +	/*
> > > >  	 * trylock || pending
> > > >  	 *
> > > >  	 * 0,0,0 -> 0,0,1 ; trylock
> > > >  	 * 0,0,1 -> 0,1,1 ; pending
> > > >  	 */
> > > > +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> > > > +	if (!(val & ~_Q_LOCKED_MASK)) {
> > > >  		/*
> > > > +		 * we're pending, wait for the owner to go away.
> > > > +		 *
> > > > +		 * *,1,1 -> *,1,0
> > > 
> > > Tail must be 0 here, right?
> > 
> > Not necessarily. If we're concurrently setting pending with another slowpath
> > locker, they could queue in the tail behind us, so we can't mess with those
> > upper bits.
> 
> Could be my brain just entirely stopped working; but I read that as:
> 
> 	!(val & ~0xFF) := !(val & 0xFFFFFF00)
> 
> which then pretty much mandates the top bits are empty, no?

Only if there isn't a concurrent locker. For example:


T0:
// fastpath fails to acquire the lock, returns val == _Q_LOCKED_VAL

if (val & ~_Q_LOCKED_MASK)
	goto queue;

// Fallthrough

T1:
// fastpath fails to acquire the lock, returns val == _Q_LOCKED_VAL

if (val & ~_Q_LOCKED_MASK)
	goto queue;

// Fallthrough

T0:
val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
// val == _Q_LOCKED_VAL

T1:
val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
// val == _Q_PENDING_VAL | _Q_LOCKED_VAL
// Queue into tail

T0:
// Spins for _Q_LOCKED_MASK to go to zero, but tail is *non-zero*


So it's really down to whether the state transitions in the comments refer
to the lockword in memory, or the local "val" variable. I think the former
is more instructive, because the whole thing is concurrent.

Will
