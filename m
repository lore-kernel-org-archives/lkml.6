Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF468ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612321528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jU6/je9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8612321528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJRA1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:27:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeJRA1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VSZCaDVhI2aNXE1sv2BKCY80aboktKZNgQDwEs0QIo4=; b=jU6/je9EHMDB6GHnglgeVeOlO
        kEO/nIj/YrOJxOZe+oRhkHtFJiUgqjkT7U0vKql9bhDVCcCFJg1HY4W2dOABY8mFR5j54vjHbzdDI
        pr+K5q/So8sq1latvlKpBgh0Wdqyez5dk7zMudTXj+iIqTwdHkdNCeS98wA7ekbmjPyBOavdjX3KX
        a4fKr7g0dWWp6F6Czdi6Cl4AmXfhT+SRGoWHgIs1rhwuIUe8N4GHO3LqaxJzEXYiTkU6lBNTbF2Kw
        aCWPoqgu35nr97dsiw6ZtUoa3jrj4MNjMBTiFJK6bUApZaqaTsG+nGRX1L/N2ZLKYlOq8wrLdw2jS
        6IE+rwIWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCoiF-00068Q-G6; Wed, 17 Oct 2018 16:30:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7F2220298568; Wed, 17 Oct 2018 18:30:21 +0200 (CEST)
Date:   Wed, 17 Oct 2018 18:30:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181017163021.GP3121@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:57:49AM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 10.10.2018 13:45, Peter Zijlstra wrote:
> <SNIP>
> > -static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
> > +/*
> > + * XXX somewhat completely buggered; this is in cpu_pmu_context, but we need
> > + * event_pmu_context for rotations. We also need event_pmu_context specific
> > + * scheduling routines. ARGH
> > + *
> > + *  - fixed the cpu_pmu_context vs event_pmu_context thingy
> > + *    (cpu_pmu_context embeds an event_pmu_context)
> > + *
> > + *  - need nr_events/nr_active in epc to do per epc rotation
> > + *    (done)
> > + *
> > + *  - need cpu and task pmu ctx together...
> > + *    (cpc->task_epc)
> > + */
> > +static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
> 
> Since it reduces to single cpu context (and single task context) at all times, 
> ideally, it would probably be coded as simple as this: 
> 
> 	perf_rotate_context()
> 	{
>             cpu = this_cpu_ptr(&cpu_context)
>             for_every_pmu(pmu, cpu)

Can't do that, because we have per PMU rotation periods..

>                     for_every_event_ctx(event_ctx, pmu)
> 	                    rotate(event_ctx, pmu)
> 	}

I'm also not sure I get the rest that follows... you only have to rotate
_one_ event per PMU.

I'll try and understand the rest of you email later; brain has checked
out for the day.
