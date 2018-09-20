Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D2C21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N0fmlKNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D2C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeITVw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:52:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeITVw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/gpfOBNZnWGgsj+dZdJs/T3r1esUAHB1xk4upg89xNw=; b=N0fmlKNVrF0Un14k6pjaHKBrD
        PJwFgXIU8kdbc9+De03DrzBvXUMUiqauBTfBYG2TM+HoObRkMqyoKACCHC6tPU5uQ/MLC1HjEL60j
        X04XmscHl6Q9I2DaqCQnUauqWljY8SWQeGl3z/QQ8cva3GViAREzOrkpvv7q9BVhuhA/tcvQY0o9y
        4yUfYujYvM9ddu+h/S8JXWbnTqVY3GMIKlz/KgCUJ/BpNV/iRIPXTLJ1CEsw/HRgNOjVQEwdbC6DZ
        1zjJ5YyRX9sif2IgN7G9diTe9fMe1hGalUvgE5oVuFgc6geveCMOGfhrrO5l/6Waaqt2C0/tMk4C0
        nKyHOCMGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g31VM-0003dr-ML; Thu, 20 Sep 2018 16:08:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86ED22024E44B; Thu, 20 Sep 2018 18:08:32 +0200 (CEST)
Date:   Thu, 20 Sep 2018 18:08:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180920160832.GZ24124@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
 <20180409145409.GA9661@arm.com>
 <20180409155420.GB4082@hirez.programming.kicks-ass.net>
 <20180409171959.GB9661@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409171959.GB9661@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 06:19:59PM +0100, Will Deacon wrote:
> On Mon, Apr 09, 2018 at 05:54:20PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 03:54:09PM +0100, Will Deacon wrote:

> > > +/**
> > > + * set_pending_fetch_acquire - set the pending bit and return the old lock
> > > + *                             value with acquire semantics.
> > > + * @lock: Pointer to queued spinlock structure
> > > + *
> > > + * *,*,* -> *,1,*
> > > + */
> > > +static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
> > > +{
> > > +       u32 val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;

	smp_mb();

> > > +       val |= (atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK);
> > > +       return val;
> > > +}

> > > @@ -289,18 +315,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  		return;
> > >  
> > >  	/*
> > > -	 * If we observe any contention; queue.
> > > +	 * If we observe queueing, then queue ourselves.
> > >  	 */
> > > -	if (val & ~_Q_LOCKED_MASK)
> > > +	if (val & _Q_TAIL_MASK)
> > >  		goto queue;
> > >  
> > >  	/*
> > > +	 * We didn't see any queueing, so have one more try at snatching
> > > +	 * the lock in case it became available whilst we were taking the
> > > +	 * slow path.
> > > +	 */
> > > +	if (queued_spin_trylock(lock))
> > > +		return;
> > > +
> > > +	/*
> > >  	 * trylock || pending
> > >  	 *
> > >  	 * 0,0,0 -> 0,0,1 ; trylock
> > >  	 * 0,0,1 -> 0,1,1 ; pending
> > >  	 */
> > > +	val = set_pending_fetch_acquire(lock);
> > >  	if (!(val & ~_Q_LOCKED_MASK)) {
> > 
> > So, if I remember that partial paper correctly, the atomc_read_acquire()
> > can see 'arbitrary' old values for everything except the pending byte,
> > which it just wrote and will fwd into our load, right?
> > 
> > But I think coherence requires the read to not be older than the one
> > observed by the trylock before (since it uses c-cas its acquire can be
> > elided).
> > 
> > I think this means we can miss a concurrent unlock vs the fetch_or. And
> > I think that's fine, if we still see the lock set we'll needlessly 'wait'
> > for it go become unlocked.
> 
> Ah, but there is a related case that doesn't work. If the lock becomes
> free just before we set pending, then another CPU can succeed on the
> fastpath. We'll then set pending, but the lockword we get back may still
> have the locked byte of 0, so two people end up holding the lock.
> 
> I think it's worth giving this a go with the added trylock, but I can't
> see a way to avoid the atomic_fetch_or at the moment.

So IIRC the addition of the smp_mb() above should ensure the @val load
is later than the @pending store.

Which makes the thing work again, right?

Now, obviously you don't actually want that on ARM64, but I can do that
on x86 just fine (our xchg() implies smp_mb() after all).


Another approach might be to use something like:

	val = xchg_relaxed(&lock->locked_pending, _Q_PENDING_VAL | _Q_LOCKED_VAL);
	val |= atomic_read_acquire(&lock->val) & _Q_TAIL_MASK;

combined with something like:

	/* 0,0,0 -> 0,1,1 - we won trylock */
	if (!(val & _Q_LOCKED_MASK)) {
		clear_pending(lock);
		return;
	}

	/* 0,0,1 -> 0,1,1 - we won pending */
	if (!(val & ~_Q_LOCKED_MASK)) {
		...
	}

	/* *,0,1 -> *,1,1 - we won pending, but there's queueing */
	if (!(val & _Q_PENDING_VAL))
		clear_pending(lock);

	...


Hmmm?
