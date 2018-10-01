Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5DA21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f023MubY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5DA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeJBBtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:49:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41950 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeJBBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XSIPo5XTYma74Gs4FlsKj1QTEmicGED5k/z4/PzTjjg=; b=f023MubYCciajxi9xUErdSccl
        XoHPuQEoMZnrO5K/GGmy/HXW1Jdr5OCRVRJHXis+AQdb0+GA75qql4FHD7pDRhXUk2VIKozdPmR4Q
        nT9p6hXcdj7kjDTPD38PV8raZW2cMnFawLoDwB60Z56p+GTu7fc4gRMF1tdU1LSZX+vHiQ6ROor0f
        2UTMWOBkYk6SEdvk+mDAWKlbvDzVXUCbdy8noQ1ETWT2OgJyNdD5FFBnlKeRwHgMPo3gyGErixE55
        euiVxwI3OtiR+InVInRDou/krgmfTViP3zMGwg2q7yKsc53slta9IrG6XSJxoFkt/f03zJVWEEmK+
        o3IUXTT7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g73aL-0000OT-3E; Mon, 01 Oct 2018 19:10:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 303262075FAA1; Mon,  1 Oct 2018 21:10:22 +0200 (CEST)
Date:   Mon, 1 Oct 2018 21:10:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/3] locking/qspinlock: Rework some comments
Message-ID: <20181001191022.GN3439@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.457488877@infradead.org>
 <20181001171707.GE13918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001171707.GE13918@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:17:08PM +0100, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 01:01:19PM +0200, Peter Zijlstra wrote:
> > +
> >  	/*
> > -	 * If we observe any contention; undo and queue.
> > +	 * If we observe contention, there was a concurrent lock.
> 
> Nit: I think "concurrent lock" is confusing here, because that implies to
> me that the lock was actually taken behind our back, which isn't necessarily
> the case. How about "there is a concurrent locker"?

Yes, that's better.

> > +	 *
> > +	 * Undo and queue; our setting of PENDING might have made the
> > +	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
> > +	 * on @next to become !NULL.
> >  	 */
> 
> Hmm, but it could also fail another concurrent set of PENDING (and the lock
> could just be held the entire time).

Right. What I wanted to convey was that is we observe _any_ contention,
we must abort and queue, because of that above condition failing and
waiting on @next.

The other cases weren't as critical, but that one really does require us
to queue in order to make forward progress.

Or did I misunderstand your concern?

> >  	if (unlikely(val & ~_Q_LOCKED_MASK)) {
> > +
> > +		/* Undo PENDING if we set it. */
> >  		if (!(val & _Q_PENDING_MASK))
> >  			clear_pending(lock);
> > +
> >  		goto queue;
> >  	}
> >  
> > @@ -466,7 +473,7 @@ void queued_spin_lock_slowpath(struct qs
> >  	 * claim the lock:
> >  	 *
> >  	 * n,0,0 -> 0,0,1 : lock, uncontended
> > -	 * *,*,0 -> *,*,1 : lock, contended
> > +	 * *,0,0 -> *,0,1 : lock, contended
> 
> Pending can be set behind our back in the contended case, in which case
> we take the lock with a single byte store and don't clear pending. You
> mention this in the updated comment below, but I think we should leave this
> comment alone.

Ah, so the reason I write it like so is because when we get here,
val.locked_pending == 0, per the atomic_cond_read_acquire() condition.


