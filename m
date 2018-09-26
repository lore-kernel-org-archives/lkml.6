Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7763EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FF52154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eL7MLyrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FF52154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeI0DHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:07:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33319 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0DHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:07:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id g26-v6so3143671edp.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G4xMxAAf1wbpRXgI9Baw6y3Dc74TJPkMUxhPqwlof0U=;
        b=eL7MLyrLy2j6v88NRa2tlucT4ZJpQjev6yQ2zYZdybQY1yAW8Xsc9PrSCR/9HfJonu
         kLSc38ceuqpwO3TgQDTGVVgKELezy/2mf1vLjXj31tZ865+jZPCFByzXGTwsdViJeLRR
         FkiXNrkfNU0lo8HVv+9IrmCGpl+QAmKE01Hlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G4xMxAAf1wbpRXgI9Baw6y3Dc74TJPkMUxhPqwlof0U=;
        b=kS9L+WG+vCp1T3eK5oim5pUu43Fh26lJmh4gw0fdixNP3Ah/XO+d4roQO6eElDjbBP
         SWNQIMa32jT/b0ILdVw1/foUPULNOAoek9/NkBlscBoULEhLCUW/ThPlb7dPArnxuxlu
         3JCFAhPNzJM1nLic4my3VRPj5KnPsqEn7DVxaytWt+9A0b2nebS5Kn1ndl0GRSGD1IN6
         Eb+aAonV4KmxnTNG03TGbcnKd8MPS9RTw7dLoEzf9Hz0nUxaizsPN1XP1e8L3veUdRjH
         WcE1S9CdYvFgXLVGvXRP3gPo/sk1zpDs5xzzMQBzuo8+z+E9wpTFW8OtlpzLDJbm09Za
         +HcA==
X-Gm-Message-State: ABuFfohIdN2QjruCuA98BXme1liaupig9HDDJK+1iOQGW0vt5gcKufZ/
        gfocDjmi52ZFLDTaj2rGbSK+FQ==
X-Google-Smtp-Source: ACcGV62Dl3C7V3x7zKpm0wK34JKAotNE/wTXQFUAwVXpmDfENCz7VkIyy14AKbLdUmkjpQok44hOlA==
X-Received: by 2002:a50:b5e6:: with SMTP id a93-v6mr12128050ede.94.1537995136439;
        Wed, 26 Sep 2018 13:52:16 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id s12-v6sm178950edr.9.2018.09.26.13.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:52:15 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:52:08 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180926205208.GA4864@andrea>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926111307.513429499@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

If this were true, we would have a violation of "coherence":

C peterz

{}

P0(atomic_t *val)
{
	int r0;

	/* in queued_spin_trylock() */
	r0 = atomic_cmpxchg_acquire(val, 0, 1);
}

P1(atomic_t *val)
{
	int r0;
	int r1;

	/* in queued_spin_trylock() */
	r0 = atomic_cmpxchg_acquire(val, 0, 1); /* or atomic_read(val) */

	/* in queued_spin_lock_slowpath)() -- set_pending_fetch_acquire() */
	r1 = atomic_read_acquire(val);
}

exists (0:r0=0 /\ ~1:r0=0 /\ 1:r1=0)

  Andrea


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
> +	smp_mb__after_atomic();
> +	val |= atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK;
> +
> +	return val;
> +#else
> +	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +#endif
> +}
> +
> +/**
>   * set_locked - Set the lock bit and own the lock
>   * @lock: Pointer to queued spinlock structure
>   *
> @@ -328,7 +382,7 @@ void queued_spin_lock_slowpath(struct qs
>  	 *
>  	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
>  	 */
> -	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +	val = set_pending_fetch_acquire(lock);
>  
>  	/*
>  	 * If we observe contention, there was a concurrent lock.
> 
> 
