Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2472084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdeH1y5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2472084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJBCkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:40:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJBCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jRPZa+e7Sxe/JeEEH/qq2QQ3EdI9erdQekVh4WtYgHI=; b=bdeH1y5B/02O0KcpFIJIDbo8O
        S1RqxeQTjaSXr9dtm2RuKeBqxeoyc/TSU1kXo94WrGsqWZW3y1YcZchBy1Af8G+p6pczLgyxKHqQe
        Q+4M4IW8K40Mg6/tnm3EY2NdLrXavI9vwgsEWJpyWYy+MNtcd7ma3EL1zCC8zSX4OOuQz5c6fRovw
        wVhnvVENZ7zXW0VIk4hkWN8EOvsMhw/+lzuSWqDon48GP+LFXyuVxmYQqG+WosOda2C84T0Rw0Wqm
        lqN4ae5ItYPLcdwSvFgn0iajwjBwONlFfyO9v7pq9DPtxuJOGboy0dDQ3OmpIl2jz0xCkA20s3oDm
        PUkMRp5Ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74Mo-0003RH-Ox; Mon, 01 Oct 2018 20:00:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67DAE2075FAA9; Mon,  1 Oct 2018 22:00:28 +0200 (CEST)
Date:   Mon, 1 Oct 2018 22:00:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181001200028.GO3439@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001171700.GC13918@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:17:00PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> Thanks for chewing up my afternoon ;)

I'll get you a beer in EDI ;-)

> On Wed, Sep 26, 2018 at 01:01:20PM +0200, Peter Zijlstra wrote:

> >  /**
> > + * set_pending_fetch_acquire - fetch the whole lock value and set pending and locked
> > + * @lock : Pointer to queued spinlock structure
> > + * Return: The previous lock value
> > + *
> > + * *,*,* -> *,1,*
> > + */
> > +static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
> > +{
> > +#if defined(_Q_NO_FETCH_OR) && _Q_PENDING_BITS == 8
> > +	u32 val;
> > +
> > +	/*
> > +	 * For the !LL/SC archs that do not have a native atomic_fetch_or
> > +	 * but do have a native xchg (x86) we can do trickery and avoid the
> > +	 * cmpxchg-loop based fetch-or to improve determinism.
> > +	 *
> > +	 * We first xchg the pending byte to set PENDING, and then issue a load
> > +	 * for the rest of the word and mask out the pending byte to compute a
> > +	 * 'full' value.
> > +	 */
> > +	val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;
> 
> If we make this an xchg_acquire(), can we drop the smp_mb__after_atomic()
> and use a plain atomic_read() to get the rest of the word? 

I did consider that; but I confused myself so many times I stuck with
this one. Primarily because on x86 it doesn't matter one way or the
other and smp_mb() are 'easier' to reason about.

> But actually,
> consider this scenario with your patch:
> 
> 1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
>    pending.
> 
> 2. CPU1 comes in and sets pending, spins on locked
> 
> 3. CPU2 sees a pending and locked val, and is about to enter the head of
>    the waitqueue (i.e. it's right before xchg_tail()).
> 
> 4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
>    it, so pending and locked are now 0.
> 
> 5. CPU0 sets pending and reads back zeroes for the other fields
> 
> 6. CPU0 clears pending and sets locked -- it now has the lock
> 
> 7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
>    for locked and pending to go clear. However, it reads a stale value
>    from step (4) and attempts the atomic_try_cmpxchg() to take the lock.
> 
> 8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
>    point we're hosed, because both CPU2 and CPU0 have the lock.

Let me draw a picture of that..


  CPU0		CPU1		CPU2		CPU3

0)						lock
						  trylock -> (0,0,1)
1)lock
    trylock /* fail */

2)		lock
		  trylock /* fail */
		  tas-pending -> (0,1,1)
		  wait-locked

3)				lock
				  trylock /* fail */
				  tas-pending /* fail */

4)						unlock -> (0,1,0)
		  clr_pnd_set_lck -> (0,0,1)
		  unlock -> (0,0,0)

5)  tas-pending -> (0,1,0)
    read-val -> (0,1,0)
6)  clr_pnd_set_lck -> (0,0,1)
7)				  xchg_tail -> (n,0,1)
				  load_acquire <- (n,0,0) (from-4)
8)				  cmpxchg /* fail */
				  set_locked()

> Is there something I'm missing that means this can't happen? I suppose
> cacheline granularity ends up giving serialisation between (4) and (7),
> but I'd *much* prefer not to rely on that because it feels horribly
> fragile.

Well, on x86 atomics are fully ordered, so the xchg_tail() does in
fact have smp_mb() in and that should order it sufficient for that not
to happen I think.

But in general, yes ick. Alternatively, making xchg_tail an ACQUIRE
doesn't seem too far out..

> Another idea I was playing with was adding test_and_set_bit_acquire()
> for this, because x86 has an instruction for that, right?

LOCK BTS, yes. So it can do a full 32bit RmW, but it cannot return the
old value of the word, just the old bit (in CF).

I suppose you get rid of the whole mixed size thing, but you still have
the whole two instruction thing.

> > +	/*
> > +	 * Ensures the tail load happens after the xchg().
> > +	 *
> > +	 *	   lock  unlock    (a)
> > +	 *   xchg ---------------.
> > +	 *    (b)  lock  unlock  +----- fetch_or
> > +	 *   load ---------------'
> > +	 *	   lock  unlock    (c)
> > +	 *
> 
> I failed miserably at parsing this comment :(
> 
> I think the main issue is that I don't understand how to read the little
> diagram you've got.

Where fetch_or() is indivisible and has happens-before (a) and
happens-after (c), the new thing is in fact divisible and has
happens-in-between (b).

Of the happens-in-between (b), we can either get a new concurrent
locker, or make progress of an extant concurrent locker because an
unlock happened.

But the rest of the text might indeed be very confused. I think I wrote
the bulk of that when I was in fact doing a xchg16 on locked_pending,
but that's fundamentally broken. I did edit it afterwards, but that
might have just made it worse.
