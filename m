Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E538C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E0F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NeZ+RNpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeKGWfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:35:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGWfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LX38V2snMzi7Z0f79R9pskMuYEeIMOrNQmAvtTr/MuI=; b=NeZ+RNpE2+HGv4SM4KaPVpwN9
        +zXcfoatTP9yoIzKvlDn6Ew7jeW4lisfwYYWaW7c+r98+DAdIHtNKnubENg8Xhzi8oiLW031uXEgi
        iA6/9L/lW/7S2LtwG4T1Ndu/8FGnbamq2J3NCC4lunMrg4pe4zsba44ZZMn7dIMgHNKGwrBIKNzS4
        NrqDiKI+EK0nu6X2uNo4EKKqsQBTYfSRpt4uY/Y1/fJUwX66o/S/Xorry4U1AwQLSkqxfA1mf0mbq
        nawLsn/hNg77OuaGkZTBcoWHzZR4oCKVmI13rY+K7Ojw5q4SFJBGzGzHpXM/BZ3s42VR9jPgZpsWV
        7A9lTOsvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKNW9-0006X6-GR; Wed, 07 Nov 2018 13:05:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE85A20284F98; Wed,  7 Nov 2018 14:05:07 +0100 (CET)
Date:   Wed, 7 Nov 2018 14:05:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] irq/timings: Fix model validity
Message-ID: <20181107130507.GD9761@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
 <20181107094624.GB9828@hirez.programming.kicks-ass.net>
 <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:52:31AM +0100, Daniel Lezcano wrote:
> > @@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
> >  	 */
> >  	diff = interval - irqs->avg;
> >  
> > +	/*
> > +	 * Online average algorithm:
> > +	 *
> > +	 *  new_average = average + ((value - average) / count)
> > +	 *
> > +	 * The variance computation depends on the new average
> > +	 * to be computed here first.
> > +	 *
> > +	 */
> > +	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
> > +
> > +	/*
> > +	 * Online variance algorithm:
> > +	 *
> > +	 *  new_variance = variance + (value - average) x (value - new_average)
> > +	 *
> > +	 * Warning: irqs->avg is updated with the line above, hence
> > +	 * 'interval - irqs->avg' is no longer equal to 'diff'
> > +	 */
> > +	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
> > +
> >  	/*
> >  	 * Increment the number of samples.
> >  	 */
> >  	irqs->nr_samples++;

FWIW, I'm confused on this. The normal (Welford's) online algorithm
does:

	count++;
	delta = value - mean;
	mean += delta / count;
	M2 += delta * (value - mean);

But the above uses:

	mean += delta / 32;

Which, for count >> 32, over-estimates the mean adjustment. But worse,
it significantly under-estimates the mean during training.

How is the computed variance still correct with this? I can not find any
comments that clarifies this. I'm thinking that since the mean will
slowly wander towards it's actual location (assuming an actual standard
distribution input) the resulting variance will be far too large, since
the (value - mean) term will be much larger than 'expected'.

> > @@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
> >  	 * more than 32 and dividing by 32 instead of 31 is enough
> >  	 * precise.
> >  	 */
> > +	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;

Worse; variance is actually (as the comment states):

	s^2 = M2 / (count -1)

But instead you compute:

	s^2 = M2 / 32;

Which is again much larger than the actual result; assuming count >> 32.

So you compute a variance that is inflated in two different ways.


I'm not seeing how this thing works reliably.
