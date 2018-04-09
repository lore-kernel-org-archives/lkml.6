Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDIPyc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:54:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDIPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:54:30 -0400
Date: Mon, 9 Apr 2018 17:54:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180409155420.GB4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
 <20180409145409.GA9661@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409145409.GA9661@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 03:54:09PM +0100, Will Deacon wrote:

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 19261af9f61e..71eb5e3a3d91 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -139,6 +139,20 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>  }
>  
> +/**
> + * set_pending_fetch_acquire - set the pending bit and return the old lock
> + *                             value with acquire semantics.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,*,* -> *,1,*
> + */
> +static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
> +{
> +	u32 val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;
> +	val |= (atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK);
> +	return val;
> +}

> @@ -289,18 +315,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		return;
>  
>  	/*
> -	 * If we observe any contention; queue.
> +	 * If we observe queueing, then queue ourselves.
>  	 */
> -	if (val & ~_Q_LOCKED_MASK)
> +	if (val & _Q_TAIL_MASK)
>  		goto queue;
>  
>  	/*
> +	 * We didn't see any queueing, so have one more try at snatching
> +	 * the lock in case it became available whilst we were taking the
> +	 * slow path.
> +	 */
> +	if (queued_spin_trylock(lock))
> +		return;
> +
> +	/*
>  	 * trylock || pending
>  	 *
>  	 * 0,0,0 -> 0,0,1 ; trylock
>  	 * 0,0,1 -> 0,1,1 ; pending
>  	 */
> +	val = set_pending_fetch_acquire(lock);
>  	if (!(val & ~_Q_LOCKED_MASK)) {

So, if I remember that partial paper correctly, the atomc_read_acquire()
can see 'arbitrary' old values for everything except the pending byte,
which it just wrote and will fwd into our load, right?

But I think coherence requires the read to not be older than the one
observed by the trylock before (since it uses c-cas its acquire can be
elided).

I think this means we can miss a concurrent unlock vs the fetch_or. And
I think that's fine, if we still see the lock set we'll needlessly 'wait'
for it go become unlocked.
