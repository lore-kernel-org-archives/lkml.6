Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE983206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE983206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJBUCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:02:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeJBUCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:02:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BACB7A9;
        Tue,  2 Oct 2018 06:19:29 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BB8D3F5B3;
        Tue,  2 Oct 2018 06:19:29 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4D27C1AE2DE4; Tue,  2 Oct 2018 14:19:53 +0100 (BST)
Date:   Tue, 2 Oct 2018 14:19:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181002131952.GD16422@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
 <20181001200028.GO3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001200028.GO3439@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 10:00:28PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 01, 2018 at 06:17:00PM +0100, Will Deacon wrote:
> > Thanks for chewing up my afternoon ;)
> 
> I'll get you a beer in EDI ;-)

Just one?!

> > But actually,
> > consider this scenario with your patch:
> > 
> > 1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
> >    pending.
> > 
> > 2. CPU1 comes in and sets pending, spins on locked
> > 
> > 3. CPU2 sees a pending and locked val, and is about to enter the head of
> >    the waitqueue (i.e. it's right before xchg_tail()).
> > 
> > 4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
> >    it, so pending and locked are now 0.
> > 
> > 5. CPU0 sets pending and reads back zeroes for the other fields
> > 
> > 6. CPU0 clears pending and sets locked -- it now has the lock
> > 
> > 7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
> >    for locked and pending to go clear. However, it reads a stale value
> >    from step (4) and attempts the atomic_try_cmpxchg() to take the lock.
> > 
> > 8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
> >    point we're hosed, because both CPU2 and CPU0 have the lock.
> 
> Let me draw a picture of that..
> 
> 
>   CPU0		CPU1		CPU2		CPU3
> 
> 0)						lock
> 						  trylock -> (0,0,1)
> 1)lock
>     trylock /* fail */
> 
> 2)		lock
> 		  trylock /* fail */
> 		  tas-pending -> (0,1,1)
> 		  wait-locked
> 
> 3)				lock
> 				  trylock /* fail */
> 				  tas-pending /* fail */
> 
> 4)						unlock -> (0,1,0)
> 		  clr_pnd_set_lck -> (0,0,1)
> 		  unlock -> (0,0,0)
> 
> 5)  tas-pending -> (0,1,0)
>     read-val -> (0,1,0)
> 6)  clr_pnd_set_lck -> (0,0,1)
> 7)				  xchg_tail -> (n,0,1)
> 				  load_acquire <- (n,0,0) (from-4)
> 8)				  cmpxchg /* fail */
> 				  set_locked()
> 
> > Is there something I'm missing that means this can't happen? I suppose
> > cacheline granularity ends up giving serialisation between (4) and (7),
> > but I'd *much* prefer not to rely on that because it feels horribly
> > fragile.
> 
> Well, on x86 atomics are fully ordered, so the xchg_tail() does in
> fact have smp_mb() in and that should order it sufficient for that not
> to happen I think.

Hmm, does that actually help, though? I still think you're relying on the
cache-coherence protocol to serialise the xchg() on pending before the
xchg_tail(), which I think is fragile because they don't actually overlap.

> But in general, yes ick. Alternatively, making xchg_tail an ACQUIRE
> doesn't seem too far out..
> 
> > Another idea I was playing with was adding test_and_set_bit_acquire()
> > for this, because x86 has an instruction for that, right?
> 
> LOCK BTS, yes. So it can do a full 32bit RmW, but it cannot return the
> old value of the word, just the old bit (in CF).
> 
> I suppose you get rid of the whole mixed size thing, but you still have
> the whole two instruction thing.

I really think we need that set of pending to operate on the whole lock
word.

> > > +	/*
> > > +	 * Ensures the tail load happens after the xchg().
> > > +	 *
> > > +	 *	   lock  unlock    (a)
> > > +	 *   xchg ---------------.
> > > +	 *    (b)  lock  unlock  +----- fetch_or
> > > +	 *   load ---------------'
> > > +	 *	   lock  unlock    (c)
> > > +	 *
> > 
> > I failed miserably at parsing this comment :(
> > 
> > I think the main issue is that I don't understand how to read the little
> > diagram you've got.
> 
> Where fetch_or() is indivisible and has happens-before (a) and
> happens-after (c), the new thing is in fact divisible and has
> happens-in-between (b).
> 
> Of the happens-in-between (b), we can either get a new concurrent
> locker, or make progress of an extant concurrent locker because an
> unlock happened.
> 
> But the rest of the text might indeed be very confused. I think I wrote
> the bulk of that when I was in fact doing a xchg16 on locked_pending,
> but that's fundamentally broken. I did edit it afterwards, but that
> might have just made it worse.

Ok, maybe just remove it :)

Will
