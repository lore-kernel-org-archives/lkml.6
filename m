Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24245254D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24245254D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeGBQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:03:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeGBQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:02:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0604E80D;
        Mon,  2 Jul 2018 09:02:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBAAC3F2EA;
        Mon,  2 Jul 2018 09:02:57 -0700 (PDT)
Date:   Mon, 2 Jul 2018 17:02:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, boris.ostrovsky@oracle.com
Subject: Re: [RFC PATCH] perf/core: don't sample kernel regs upon skid
Message-ID: <20180702160249.qck45h76galxrckn@lakrids.cambridge.arm.com>
References: <20180702151250.14536-1-mark.rutland@arm.com>
 <20180702154655.GR2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702154655.GR2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:46:55PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 04:12:50PM +0100, Mark Rutland wrote:
> > Users can request that general purpose registers, instruction pointer,
> > etc, are sampled when a perf event counter overflows. To try to avoid
> > this resulting in kernel state being leaked, unprivileged users are
> > usually forbidden from opening events which count while the kernel is
> > running.
> > 
> > Unfortunately, this is not sufficient to avoid leading kernel state.
> 
> 'leaking' surely.
> 
> > 
> > For various reasons, there can be a delay between the overflow occurring
> > and the resulting overflow exception (e.g. an NMI) being taken. During
> > this window, other instructions may be executed, resulting in skid.
> > 
> > This skid means that a userspace-only event overflowing may result in an
> > exception being taken *after* entry to the kernel, allowing kernel
> > registers to be sampled. Depending on the amount of skid, this may only
> > leak the PC (breaking KASLR), or it may leak secrets which are currently
> > live in GPRs.
> > 
> > Let's avoid this by only sampling from the user registers when an event
> > is supposed to exclude the kernel, providing the illusion that the
> > overflow exception is taken from userspace.
> > 
> > We also have similar cases when sampling a guest, where we get the host
> > regs in some cases. It's not entirely clear to me how we should handle
> > these.
> 
> Would not a similar:
> 
> 	if ((event->attr.exclude_hv || event->attr.exclude_host) /* WTF both !? */ &&
> 	    perf_guest_cbs && !perf_guest_cbs->is_in_guest())
> 		return perf_guest_cbs->guest_pt_regs();
>
> work there? 

Mostly. It's fun if the user also passed exclude_guest -- I have no idea
what should be sampled there, if anything.

It's easy to get stuck in a rabbit hole looking at this.

> Of course, perf_guest_info_callbacks is currently lacking that
> guest_pt_regs() thingy..

Yeah; I started looking at implementing it, but ran away since it wasn't
clear to me how to build that on most architectures.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  kernel/events/core.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f0434a9951a..2ab2548b2e66 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6361,6 +6361,32 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
> >  	return callchain ?: &__empty_callchain;
> >  }
> >  
> > +static struct pt_regs *perf_get_sample_regs(struct perf_event *event,
> > +					    struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * Due to interrupt latency (AKA "skid"), we may enter the kernel
> > +	 * before taking an overflow, even if the PMU is only counting user
> > +	 * events.
> > +	 *
> > +	 * If we're not counting kernel events, always use the user regs when
> > +	 * sampling.
> > +	 *
> > +	 * TODO: what do we do about sampling a guest's registers? The IP is
> > +	 * special-cased, but for the rest of the regs they'll get the
> > +	 * user/kernel regs depending on whether exclude_kernel is set, which
> > +	 * is nonsensical.
> > +	 *
> > +	 * We can't get at the full set of regs in all cases (e.g. Xen's PV PMU
> > +	 * can't provide the GPRs), so should we just zero the GPRs when in a
> > +	 * guest? Or skip outputting the regs in perf_output_sample?
> 
> Seems daft Xen cannot provide registers; why is that? Boris?

The xen_pmu_regs structure simply doesn't have them, so I assume there's
no API to get them.

Given we don't currently sample the guest regs, I'd be tempted to just
zero them for now, or skip the sample at output time (if that doesn't
break some other case).

Thanks,
Mark.
