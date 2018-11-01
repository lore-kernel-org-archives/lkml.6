Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A722064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G5RCsMXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A722064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeKAX4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:56:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeKAX4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uOVNhGl4Z1QIXBmrdydzgXSEPy4jBCVQW7cJoXNev+4=; b=G5RCsMXxLu9APGXpYqVkqRG6X
        wTVFc39kAAZqxCYIKbHXzBWr0P9Hs6NxifVE6KFHlFj3JzQyqulpc6RQz1nCC4cUIeakIFe4lNx5O
        0srlFp/5vTgKTuh1HZVt0BQ8qmiXYX/6Ggr6McHCqMraX22OnPEbPB/SY6kNFHP7i7WxtvItt2wMs
        02vCdIMe5dxEfT1jKy4Bj91UjYUllyeuRNBd5ZR7/5KBn37SksCtcLVhU8gsd8fzJcIo8LjZfy0S8
        /mdGcUz3z/PIPDzhjvZwR9IaX5uteENuDNdixns7k82bubl15gSVlHBtTI0Azm9JeTc1hjsDIVOwh
        dNSZsRtrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIELG-0003tQ-4n; Thu, 01 Nov 2018 14:53:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB1F120296EED; Thu,  1 Nov 2018 15:52:57 +0100 (CET)
Date:   Thu, 1 Nov 2018 15:52:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Message-ID: <20181101145257.GD3178@hirez.programming.kicks-ass.net>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 06:04:01PM +0800, Wei Wang wrote:
> Add x86_perf_mask_perf_counters to reserve counters from the host perf
> subsystem. The masked counters will not be assigned to any host perf
> events. This can be used by the hypervisor to reserve perf counters for
> a guest to use.
> 
> This function is currently supported on Intel CPUs only, but put in x86
> perf core because the counter assignment is implemented here and we need
> to re-enable the pmu which is defined in the x86 perf core in the case
> that a counter to be masked happens to be used by the host.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/events/core.c            | 37 +++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/perf_event.h |  1 +
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 106911b..e73135a 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -716,6 +716,7 @@ struct perf_sched {
>  static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
>  			    int num, int wmin, int wmax, int gpmax)
>  {
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int idx;
>  
>  	memset(sched, 0, sizeof(*sched));
> @@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
>  	sched->max_weight	= wmax;
>  	sched->max_gp		= gpmax;
>  	sched->constraints	= constraints;
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
> +#endif

NAK.  This completely undermines the whole purpose of event scheduling.


