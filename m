Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756908AbeDKTe3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:34:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754249AbeDKTe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:34:26 -0400
Subject: Re: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <674fd9c0-e3f3-9ae0-dd0a-7ccc085c1706@redhat.com>
Date: Wed, 11 Apr 2018 15:34:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1523469680-17699-5-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 02:01 PM, Will Deacon wrote:
> The qspinlock locking slowpath utilises a "pending" bit as a simple form
> of an embedded test-and-set lock that can avoid the overhead of explicit
> queuing in cases where the lock is held but uncontended. This bit is
> managed using a cmpxchg loop which tries to transition the uncontended
> lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
>
> Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> indefinitely if the lock word is seen to oscillate between unlocked
> (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> able to take the lock in the cmpxchg loop without queuing and pass it
> around amongst themselves.
>
> This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> using atomic_fetch_or, and then inspecting the old value to see whether
> we need to spin on the current lock owner, or whether we now effectively
> hold the lock. The tricky scenario is when concurrent lockers end up
> queuing on the lock and the lock becomes available, causing us to see
> a lockword of (n,0,0). With pending now set, simply queuing could lead
> to deadlock as the head of the queue may not have observed the pending
> flag being cleared. Conversely, if the head of the queue did observe
> pending being cleared, then it could transition the lock from (n,0,0) ->
> (0,0,1) meaning that any attempt to "undo" our setting of the pending
> bit could race with a concurrent locker trying to set it.
>
> We handle this race by preserving the pending bit when taking the lock
> after reaching the head of the queue and leaving the tail entry intact
> if we saw pending set, because we know that the tail is going to be
> updated shortly.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/locking/qspinlock.c | 102 ++++++++++++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 44 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 396701e8c62d..a8fc402b3f3a 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -162,6 +162,17 @@ struct __qspinlock {
>  
>  #if _Q_PENDING_BITS == 8
>  /**
> + * clear_pending - clear the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,1,* -> *,0,*
> + */
> +static __always_inline void clear_pending(struct qspinlock *lock)
> +{
> +	WRITE_ONCE(lock->pending, 0);
> +}
> +
> +/**
>   * clear_pending_set_locked - take ownership and clear the pending bit.
>   * @lock: Pointer to queued spinlock structure
>   *
> @@ -201,6 +212,17 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  #else /* _Q_PENDING_BITS == 8 */
>  
>  /**
> + * clear_pending - clear the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,1,* -> *,0,*
> + */
> +static __always_inline void clear_pending(struct qspinlock *lock)
> +{
> +	atomic_andnot(_Q_PENDING_VAL, &lock->val);
> +}
> +
> +/**
>   * clear_pending_set_locked - take ownership and clear the pending bit.
>   * @lock: Pointer to queued spinlock structure
>   *
> @@ -306,7 +328,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>  void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  {
>  	struct mcs_spinlock *prev, *next, *node;
> -	u32 new, old, tail;
> +	u32 old, tail;
>  	int idx;
>  
>  	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
> @@ -330,58 +352,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	}
>  
>  	/*
> +	 * If we observe any contention; queue.
> +	 */
> +	if (val & ~_Q_LOCKED_MASK)
> +		goto queue;
> +
> +	/*
>  	 * trylock || pending
>  	 *
>  	 * 0,0,0 -> 0,0,1 ; trylock
>  	 * 0,0,1 -> 0,1,1 ; pending
>  	 */
> -	for (;;) {
> +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +	if (!(val & ~_Q_LOCKED_MASK)) {
>  		/*
> -		 * If we observe any contention; queue.
> +		 * we're pending, wait for the owner to go away.
> +		 *
> +		 * *,1,1 -> *,1,0
> +		 *
> +		 * this wait loop must be a load-acquire such that we match the
> +		 * store-release that clears the locked bit and create lock
> +		 * sequentiality; this is because not all
> +		 * clear_pending_set_locked() implementations imply full
> +		 * barriers.
>  		 */
> -		if (val & ~_Q_LOCKED_MASK)
> -			goto queue;
> -
> -		new = _Q_LOCKED_VAL;
> -		if (val == new)
> -			new |= _Q_PENDING_VAL;
> +		if (val & _Q_LOCKED_MASK) {
> +			smp_cond_load_acquire(&lock->val.counter,
> +					      !(VAL & _Q_LOCKED_MASK));
> +		}
>  
>  		/*
> -		 * Acquire semantic is required here as the function may
> -		 * return immediately if the lock was free.
> +		 * take ownership and clear the pending bit.
> +		 *
> +		 * *,1,0 -> *,0,1
>  		 */
> -		old = atomic_cmpxchg_acquire(&lock->val, val, new);
> -		if (old == val)
> -			break;
> -
> -		val = old;
> -	}
> -
> -	/*
> -	 * we won the trylock
> -	 */
> -	if (new == _Q_LOCKED_VAL)
> +		clear_pending_set_locked(lock);
>  		return;
> +	}
>  
>  	/*
> -	 * we're pending, wait for the owner to go away.
> -	 *
> -	 * *,1,1 -> *,1,0
> -	 *
> -	 * this wait loop must be a load-acquire such that we match the
> -	 * store-release that clears the locked bit and create lock
> -	 * sequentiality; this is because not all clear_pending_set_locked()
> -	 * implementations imply full barriers.
> -	 */
> -	smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
> -
> -	/*
> -	 * take ownership and clear the pending bit.
> -	 *
> -	 * *,1,0 -> *,0,1
> +	 * If pending was clear but there are waiters in the queue, then
> +	 * we need to undo our setting of pending before we queue ourselves.
>  	 */
> -	clear_pending_set_locked(lock);
> -	return;
> +	if (!(val & _Q_PENDING_MASK))
> +		clear_pending(lock);
>  
>  	/*
>  	 * End of pending bit optimistic spinning and beginning of MCS
> @@ -485,15 +499,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 * claim the lock:
>  	 *
>  	 * n,0,0 -> 0,0,1 : lock, uncontended
> -	 * *,0,0 -> *,0,1 : lock, contended
> +	 * *,*,0 -> *,*,1 : lock, contended
>  	 *
> -	 * If the queue head is the only one in the queue (lock value == tail),
> -	 * clear the tail code and grab the lock. Otherwise, we only need
> -	 * to grab the lock.
> +	 * If the queue head is the only one in the queue (lock value == tail)
> +	 * and nobody is pending, clear the tail code and grab the lock.
> +	 * Otherwise, we only need to grab the lock.
>  	 */
>  	for (;;) {
>  		/* In the PV case we might already have _Q_LOCKED_VAL set */
> -		if ((val & _Q_TAIL_MASK) != tail) {
> +		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
>  			set_locked(lock);
>  			break;
>  		}

I don't think it is right to just grab the lock when the pending bit is
set. I believe it will cause problem.

Preserving the the pending bit should be just

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 35367cc..76d9124 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -511,7 +511,8 @@ void queued_spin_lock_slowpath(struct qspinlock
*lock, u32 v
                 * necessary acquire semantics required for locking. At most
                 * two iterations of this loop may be ran.
                 */
-               old = atomic_cmpxchg_relaxed(&lock->val, val,
_Q_LOCKED_VAL);
+               old = atomic_cmpxchg_relaxed(&lock->val, val,
+                       _Q_LOCKED_VAL | (val & _Q_PENDING_MASK));
                if (old == val)
                        goto release;   /* No contention */

Cheers,
Longman
