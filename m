Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA42C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF83B2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF83B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeJAXzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:55:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJAXzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:55:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3058A18A;
        Mon,  1 Oct 2018 10:16:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00D433F5B7;
        Mon,  1 Oct 2018 10:16:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AC8281AE3C57; Mon,  1 Oct 2018 18:17:00 +0100 (BST)
Date:   Mon, 1 Oct 2018 18:17:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181001171700.GC13918@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926111307.513429499@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for chewing up my afternoon ;)

On Wed, Sep 26, 2018 at 01:01:20PM +0200, Peter Zijlstra wrote:
> On x86 we cannot do fetch_or with a single instruction and end up
> using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> with a very tricky composite xchg8 + load.
> 
> The basic idea is that we use xchg8 to test-and-set the pending bit
> (when it is a byte) and then a load to fetch the whole word. Using
> two instructions of course opens a window we previously did not have.
> In particular the ordering between pending and tail is of interrest,
> because that is where the split happens.
> 
> The claim is that if we order them, it all works out just fine. There
> are two specific cases where the pending,tail state changes:
> 
>  - when the 3rd lock(er) comes in and finds pending set, it'll queue
>    and set tail; since we set tail while pending is set, the ordering
>    is split is not important (and not fundamentally different form
>    fetch_or). [*]
> 
>  - when the last queued lock holder acquires the lock (uncontended),
>    we clear the tail and set the lock byte. By first setting the
>    pending bit this cmpxchg will fail and the later load must then
>    see the remaining tail.
> 
> Another interesting scenario is where there are only 2 threads:
> 
> 	lock := (0,0,0)
> 
> 	CPU 0			CPU 1
> 
> 	lock()			lock()
> 	  trylock(-> 0,0,1)       trylock() /* fail */
> 	    return;               xchg_relaxed(pending, 1) (-> 0,1,1)
> 				  mb()
> 				  val = smp_load_acquire(*lock);
> 
> Where, without the mb() the load would've been allowed to return 0 for
> the locked byte.
> 
> [*] there is a fun scenario where the 3rd locker observes the pending
> bit, but before it sets the tail, the 1st lock (owner) unlocks and the
> 2nd locker acquires the lock, leaving us with a temporary 0,0,1 state.
> But this is not different between fetch_or or this new method.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/qspinlock.h |    2 +
>  kernel/locking/qspinlock.c       |   56 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -9,6 +9,8 @@
>  
>  #define _Q_PENDING_LOOPS	(1 << 9)
>  
> +#define _Q_NO_FETCH_OR
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __pv_init_lock_hash(void);
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -232,6 +232,60 @@ static __always_inline u32 xchg_tail(str
>  #endif /* _Q_PENDING_BITS == 8 */
>  
>  /**
> + * set_pending_fetch_acquire - fetch the whole lock value and set pending and locked
> + * @lock : Pointer to queued spinlock structure
> + * Return: The previous lock value
> + *
> + * *,*,* -> *,1,*
> + */
> +static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
> +{
> +#if defined(_Q_NO_FETCH_OR) && _Q_PENDING_BITS == 8
> +	u32 val;
> +
> +	/*
> +	 * For the !LL/SC archs that do not have a native atomic_fetch_or
> +	 * but do have a native xchg (x86) we can do trickery and avoid the
> +	 * cmpxchg-loop based fetch-or to improve determinism.
> +	 *
> +	 * We first xchg the pending byte to set PENDING, and then issue a load
> +	 * for the rest of the word and mask out the pending byte to compute a
> +	 * 'full' value.
> +	 */
> +	val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;

If we make this an xchg_acquire(), can we drop the smp_mb__after_atomic()
and use a plain atomic_read() to get the rest of the word? But actually,
consider this scenario with your patch:

1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
   pending.

2. CPU1 comes in and sets pending, spins on locked

3. CPU2 sees a pending and locked val, and is about to enter the head of
   the waitqueue (i.e. it's right before xchg_tail()).

4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
   it, so pending and locked are now 0.

5. CPU0 sets pending and reads back zeroes for the other fields

6. CPU0 clears pending and sets locked -- it now has the lock

7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
   for locked and pending to go clear. However, it reads a stale value
   from step (4) and attempts the atomic_try_cmpxchg() to take the lock.

8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
   point we're hosed, because both CPU2 and CPU0 have the lock.

Is there something I'm missing that means this can't happen? I suppose
cacheline granularity ends up giving serialisation between (4) and (7),
but I'd *much* prefer not to rely on that because it feels horribly
fragile.

Another idea I was playing with was adding test_and_set_bit_acquire()
for this, because x86 has an instruction for that, right?

> +	/*
> +	 * Ensures the tail load happens after the xchg().
> +	 *
> +	 *	   lock  unlock    (a)
> +	 *   xchg ---------------.
> +	 *    (b)  lock  unlock  +----- fetch_or
> +	 *   load ---------------'
> +	 *	   lock  unlock    (c)
> +	 *
> +	 * For both lock and unlock, (a) and (c) are the same as fetch_or(),
> +	 * since either are fully before or after. The only new case is (b),
> +	 * where a concurrent lock or unlock can interleave with the composite
> +	 * operation.
> +	 *
> +	 * In either case, it is the queueing case that is of interrest, otherwise
> +	 * the whole operation is covered by the xchg() and the tail will be 0.
> +	 *
> +	 * For lock-(b); we only care if we set the PENDING bit or not. If we lost
> +	 * the PENDING race, we queue. Otherwise we'd observe the tail anyway.
> +	 *
> +	 * For unlock-(b); since we'll have set PENDING, the uncontended claim
> +	 * will fail and we'll observe a !0 tail.
> +	 */

I failed miserably at parsing this comment :(

I think the main issue is that I don't understand how to read the little
diagram you've got.

Will
