Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17816C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC81E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC81E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeJAXzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:55:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53074 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeJAXzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:55:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B9715AD;
        Mon,  1 Oct 2018 10:16:44 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A8413F5B7;
        Mon,  1 Oct 2018 10:16:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 427E61AE3C57; Mon,  1 Oct 2018 18:17:08 +0100 (BST)
Date:   Mon, 1 Oct 2018 18:17:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/3] locking/qspinlock: Rework some comments
Message-ID: <20181001171707.GE13918@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.457488877@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926111307.457488877@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:01:19PM +0200, Peter Zijlstra wrote:
> While working my way through the code again; I felt the comments could
> use help.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/qspinlock.c |   40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -326,16 +326,23 @@ void queued_spin_lock_slowpath(struct qs
>  	/*
>  	 * trylock || pending
>  	 *
> -	 * 0,0,0 -> 0,0,1 ; trylock
> -	 * 0,0,1 -> 0,1,1 ; pending
> +	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
>  	 */
>  	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +
>  	/*
> -	 * If we observe any contention; undo and queue.
> +	 * If we observe contention, there was a concurrent lock.

Nit: I think "concurrent lock" is confusing here, because that implies to
me that the lock was actually taken behind our back, which isn't necessarily
the case. How about "there is a concurrent locker"?

> +	 *
> +	 * Undo and queue; our setting of PENDING might have made the
> +	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
> +	 * on @next to become !NULL.
>  	 */

Hmm, but it could also fail another concurrent set of PENDING (and the lock
could just be held the entire time).

>  	if (unlikely(val & ~_Q_LOCKED_MASK)) {
> +
> +		/* Undo PENDING if we set it. */
>  		if (!(val & _Q_PENDING_MASK))
>  			clear_pending(lock);
> +
>  		goto queue;
>  	}
>  
> @@ -466,7 +473,7 @@ void queued_spin_lock_slowpath(struct qs
>  	 * claim the lock:
>  	 *
>  	 * n,0,0 -> 0,0,1 : lock, uncontended
> -	 * *,*,0 -> *,*,1 : lock, contended
> +	 * *,0,0 -> *,0,1 : lock, contended

Pending can be set behind our back in the contended case, in which case
we take the lock with a single byte store and don't clear pending. You
mention this in the updated comment below, but I think we should leave this
comment alone.

Will

>  	 *
>  	 * If the queue head is the only one in the queue (lock value == tail)
>  	 * and nobody is pending, clear the tail code and grab the lock.
> @@ -474,16 +481,25 @@ void queued_spin_lock_slowpath(struct qs
>  	 */
>  
>  	/*
> -	 * In the PV case we might already have _Q_LOCKED_VAL set.
> +	 * In the PV case we might already have _Q_LOCKED_VAL set, because
> +	 * of lock stealing; therefore we must also allow:
>  	 *
> -	 * The atomic_cond_read_acquire() call above has provided the
> -	 * necessary acquire semantics required for locking.
> -	 */
> -	if (((val & _Q_TAIL_MASK) == tail) &&
> -	    atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
> -		goto release; /* No contention */
> +	 * n,0,1 -> 0,0,1
> +	 *
> +	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
> +	 *       above wait condition, therefore any concurrent setting of
> +	 *       PENDING will make the uncontended transition fail.
> +	 */
> +	if ((val & _Q_TAIL_MASK) == tail) {
> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
> +			goto release; /* No contention */
> +	}
>  
> -	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
> +	/*
> +	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
> +	 * which will then detect the remaining tail and queue behind us
> +	 * ensuring we'll see a @next.
> +	 */
>  	set_locked(lock);
>  
>  	/*
> 
> 
