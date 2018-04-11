Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756638AbeDKTxT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:53:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755722AbeDKTxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:53:17 -0400
Subject: Re: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
To: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6e6989d0-a6b1-e6fb-4f70-ab6849b715da@redhat.com>
Date: Wed, 11 Apr 2018 15:53:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1523469680-17699-5-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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

BTW, there is a similar clear_pending() function in
qspinlock_paravirt.c. I think you need to remove that with this patch.

Cheers,
Longman
