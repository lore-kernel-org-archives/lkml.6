Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CADC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97F620BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97F620BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeGKGCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:02:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeGKGCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:02:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7828E80D;
        Tue, 10 Jul 2018 22:59:32 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE033F318;
        Tue, 10 Jul 2018 22:59:31 -0700 (PDT)
Date:   Wed, 11 Jul 2018 06:59:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [RFC PATCH] perf/core: don't sample kernel regs upon skid
Message-ID: <20180711055927.wcfcfkninfjwox3n@salmiak>
References: <20180702151250.14536-1-mark.rutland@arm.com>
 <20180702154655.GR2494@hirez.programming.kicks-ass.net>
 <20180702160249.qck45h76galxrckn@lakrids.cambridge.arm.com>
 <ec514ab8-cf18-6fa7-d2b5-5f81e1a70983@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec514ab8-cf18-6fa7-d2b5-5f81e1a70983@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:42:29PM -0400, Boris Ostrovsky wrote:
> On 07/02/2018 12:02 PM, Mark Rutland wrote:
> > On Mon, Jul 02, 2018 at 05:46:55PM +0200, Peter Zijlstra wrote:
> >> On Mon, Jul 02, 2018 at 04:12:50PM +0100, Mark Rutland wrote:
> >>> +static struct pt_regs *perf_get_sample_regs(struct perf_event *event,
> >>> +					    struct pt_regs *regs)
> >>> +{
> >>> +	/*
> >>> +	 * Due to interrupt latency (AKA "skid"), we may enter the kernel
> >>> +	 * before taking an overflow, even if the PMU is only counting user
> >>> +	 * events.
> >>> +	 *
> >>> +	 * If we're not counting kernel events, always use the user regs when
> >>> +	 * sampling.
> >>> +	 *
> >>> +	 * TODO: what do we do about sampling a guest's registers? The IP is
> >>> +	 * special-cased, but for the rest of the regs they'll get the
> >>> +	 * user/kernel regs depending on whether exclude_kernel is set, which
> >>> +	 * is nonsensical.
> >>> +	 *
> >>> +	 * We can't get at the full set of regs in all cases (e.g. Xen's PV PMU
> >>> +	 * can't provide the GPRs), so should we just zero the GPRs when in a
> >>> +	 * guest? Or skip outputting the regs in perf_output_sample?
> >> Seems daft Xen cannot provide registers; why is that? Boris?
> > The xen_pmu_regs structure simply doesn't have them, so I assume there's
> > no API to get them.
> >
> > Given we don't currently sample the guest regs, I'd be tempted to just
> > zero them for now, or skip the sample at output time (if that doesn't
> > break some other case).
> 
> (Was out on vacation, couldn't respond earlier)
> 
> Yes, PV guests only get a limited set of registers passed to the handler
> by the hypervisor. GPRs are not part of this set.

Is that also true for Dom0?

> I think we need do
> 
> diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
> index 7d00d4a..95997e6 100644
> --- a/arch/x86/xen/pmu.c
> +++ b/arch/x86/xen/pmu.c
> @@ -478,7 +478,7 @@ static void xen_convert_regs(const struct
> xen_pmu_regs *xen_regs,
>  irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
>  {
>         int err, ret = IRQ_NONE;
> -       struct pt_regs regs;
> +       struct pt_regs regs = {0};
>         const struct xen_pmu_data *xenpmu_data = get_xenpmu_data();
>         uint8_t xenpmu_flags = get_xenpmu_flags();
> 
> 
> Do you want me to submit a separate patch or can you make this part of
> yours?

I think this is going to become a series rather than a single patch, but I can
have a go. I need to get my head around how the various cases interact with
each other.

Thanks,
Mark.
