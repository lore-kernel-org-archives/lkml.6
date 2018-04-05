Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeDERNP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:13:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeDERNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:13:14 -0400
Date: Thu, 5 Apr 2018 19:13:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180405171308.GD4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:58:59PM +0100, Will Deacon wrote:
> @@ -306,58 +306,48 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		return;
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
> +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +	if (!(val & ~_Q_LOCKED_MASK)) {
>  		/*
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
> +		if (val & _Q_LOCKED_MASK)
> +			smp_cond_load_acquire(&lock->val.counter,
> +					      !(VAL & _Q_LOCKED_MASK));

I much prefer { } for multi-line statements like this.

>  		/*
> +		 * take ownership and clear the pending bit.
> +		 *
> +		 * *,1,0 -> *,0,1
>  		 */
> +		clear_pending_set_locked(lock);
>  		return;
> +	}
