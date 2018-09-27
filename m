Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C020C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B360B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niDmxcYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B360B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0Ney (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:34:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0Ney (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kXrUhltrPvBstYu2G3tnlKIsq4Y7OF9hPJ8wrBjJ6l8=; b=niDmxcYu3JBRBdiuyTYGAI1nN
        4dSr8xGoB8Hy8YTmV8siHLAJMMztSGuKmDSda+fZJzuyxgnsMSUJbcODDSegpusRtlNZ0GQc77+hB
        5xD1T3cGN86heqbtqG68beHicywPBne3Jx8sCcocGoC9K1SgNQhYuym1lDTIKYVGXmo0DJtDMacJb
        /0zIOdrmIkFRdvhA8FWcq0KUjneAQCot+AViA4BIhrcWMMoRBY8HTiMQn84NqVO3QgcwPRd0Kloye
        fj+wCSbANhqoLGwXhgbEnA5w87NFdBTrKvrRFaOgLNypV1jgQBMAsAA1K1MJR7YPBRehZTA1TUuZ/
        kk8STJ+uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5QYW-0005LU-M9; Thu, 27 Sep 2018 07:17:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A3C020696FC3; Thu, 27 Sep 2018 09:17:47 +0200 (CEST)
Date:   Thu, 27 Sep 2018 09:17:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927071747.GD5254@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20180926205208.GA4864@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926205208.GA4864@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:52:08PM +0200, Andrea Parri wrote:
> On Wed, Sep 26, 2018 at 01:01:20PM +0200, Peter Zijlstra wrote:
> > On x86 we cannot do fetch_or with a single instruction and end up
> > using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> > with a very tricky composite xchg8 + load.
> > 
> > The basic idea is that we use xchg8 to test-and-set the pending bit
> > (when it is a byte) and then a load to fetch the whole word. Using
> > two instructions of course opens a window we previously did not have.
> > In particular the ordering between pending and tail is of interrest,
> > because that is where the split happens.
> > 
> > The claim is that if we order them, it all works out just fine. There
> > are two specific cases where the pending,tail state changes:
> > 
> >  - when the 3rd lock(er) comes in and finds pending set, it'll queue
> >    and set tail; since we set tail while pending is set, the ordering
> >    is split is not important (and not fundamentally different form
> >    fetch_or). [*]
> > 
> >  - when the last queued lock holder acquires the lock (uncontended),
> >    we clear the tail and set the lock byte. By first setting the
> >    pending bit this cmpxchg will fail and the later load must then
> >    see the remaining tail.
> > 
> > Another interesting scenario is where there are only 2 threads:
> > 
> > 	lock := (0,0,0)
> > 
> > 	CPU 0			CPU 1
> > 
> > 	lock()			lock()
> > 	  trylock(-> 0,0,1)       trylock() /* fail */
> > 	    return;               xchg_relaxed(pending, 1) (-> 0,1,1)
> > 				  mb()
> > 				  val = smp_load_acquire(*lock);
> > 
> > Where, without the mb() the load would've been allowed to return 0 for
> > the locked byte.
> 
> If this were true, we would have a violation of "coherence":

The thing is, this is mixed size, see:

  https://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf

If I remember things correctly (I've not reread that paper recently) it
is allowed for:

	old = xchg(pending,1);
	val = smp_load_acquire(*lock);

to be re-ordered like:

	val = smp_load_acquire(*lock);
	old = xchg(pending, 1);

with the exception that it will fwd the pending byte into the later
load, so we get:

	val = (val & _Q_PENDING_MASK) | (old << _Q_PENDING_OFFSET);

for 'free'.

LKMM in particular does _NOT_ deal with mixed sized atomics _at_all_.

With the addition of smp_mb__after_atomic(), we disallow the load to be
done prior to the xchg(). It might still fwd the more recent pending
byte from its store buffer, but at least the other bytes must not be
earlier.
