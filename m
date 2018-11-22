Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9840720672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9840720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbeKVXiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:38:17 -0500
Received: from foss.arm.com ([217.140.101.70]:47862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbeKVXiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:38:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31753622;
        Thu, 22 Nov 2018 04:59:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EE93F5A0;
        Thu, 22 Nov 2018 04:59:02 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:59:00 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] perf/core: Generalise event exclusion checking
Message-ID: <20181122125859.GJ42987@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <20181119130800.GE9761@hirez.programming.kicks-ass.net>
 <20181122122142.GI42987@e119886-lin.cambridge.arm.com>
 <20181122122637.GS2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122122637.GS2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:26:37PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 22, 2018 at 12:21:43PM +0000, Andrew Murray wrote:
> > On Mon, Nov 19, 2018 at 02:08:00PM +0100, Peter Zijlstra wrote:
> 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 84530ab358c3..d76b724177b9 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -9772,6 +9772,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> > >  	if (ctx)
> > >  		perf_event_ctx_unlock(event->group_leader, ctx);
> > >  
> > > +	if (!ret) {
> > > +		if ((pmu->capabilities & PERF_PMU_CAP_EXCLUDE) ||
> > > +		    event_has_exclude_flags(event)) {
> > > +			event->destroy(event);
> > > +			ret = -EINVAL;
> > > +		}
> > > +	}
> > > +
> > 
> > I don't quite follow this logic. Should that not have been:
> > 
> > if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
> >      event_has_exclude_flags(event)) {
> > 
> > Meaning that if an event has any exclude flags but the pmu doesn't
> > have the capability to handle them then error.
> 
> Uhm, yes. Brainfart on my side that.
> 
> > If you're happy with my proposed logic, then would it also make
> > sense to move this before the call to the pmu->event_init ?
> 
> I'm not sure that can work; I think we need ->event_init() first such
> that it can -ENOENT. Only after ->event_init() returns success can we be
> certain of @pmu.

Ah yes I see now. Until event_init doesn't return -ENOENT we can't be sure
that this will be the PMU we use (as per the other calls to
perf_try_init_event in perf_init_event).

Thanks,

Andrew Murray
