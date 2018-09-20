Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849BBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EED21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QYAYvVlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EED21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbeITRtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:49:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732554AbeITRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9IkYJkjPz3lS9f2YHweB9Mntzn47ElmVGbAVyVfKtoc=; b=QYAYvVlZZzs7ZU936hScrRA5b
        /6RTy9pdoJeEQvSCl9IB7lPxcV9+ze6HWyfAls0Nzrh8LgVZ3GFnqFMBcEuFB/M/U/ajnkubQfYmK
        xMTNOJzlZy+s6EX7wKu2WI1MqxNuVYcQ6cKO16EtzjEdeIdguahhoBV1ko+Dmi6K7CPk48YpUrh7f
        LJRpySyoVITRtYaYJwuEsOiMdm8sznN57+0LVnq2wGuyw3Pc7rI02YGJOLejAwveDzsvLf+nKWz1R
        vf8m7+RcX6i9ozp2HAvNl0F20gKD6R0qBXvFzPqBPHe6safblfUujQNI/N7aWGaEUJMM3mJihvwo3
        OusCeawaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2xiQ-0001bG-3g; Thu, 20 Sep 2018 12:05:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0B3C2015F390; Thu, 20 Sep 2018 14:05:45 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:05:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 1/5] perf/x86: add a function to get the lbr stack
Message-ID: <20180920120545.GP24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:05:55PM +0800, Wei Wang wrote:
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index c88ed39..c81f160 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1277,3 +1277,26 @@ void intel_pmu_lbr_init_knl(void)
>  	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
>  		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
>  }
> +
> +/**
> + * perf_get_lbr_stack - get the lbr stack related MSRs
> + *
> + * @stack: the caller's memory to get the lbr stack
> + *
> + * Returns: 0 indicates that the lbr stack has been successfully obtained.
> + */
> +int perf_get_lbr_stack(struct perf_lbr_stack *stack)
> +{
> +	stack->nr = x86_pmu.lbr_nr;
> +	stack->tos = x86_pmu.lbr_tos;
> +	stack->from = x86_pmu.lbr_from;
> +	stack->to = x86_pmu.lbr_to;
> +
> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
> +		stack->info = MSR_LBR_INFO_0;
> +	else
> +		stack->info = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(perf_get_lbr_stack);

Blergh, I know KVM is a module but it really sucks having to export
everything :/

> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 12f5408..84cc8cb 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -267,7 +267,16 @@ struct perf_guest_switch_msr {
>  	u64 host, guest;
>  };
>  
> +struct perf_lbr_stack {
> +	int		nr;

Do we need a negative number of LBR entries?

> +	unsigned long	tos;
> +	unsigned long	from;
> +	unsigned long	to;
> +	unsigned long	info;

These are all MSR values, that can be 'unsigned int', right? If so,
please also fix struct x86_pmu for that.

> +};
> +
>  extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
> +extern int perf_get_lbr_stack(struct perf_lbr_stack *stack);
>  extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
>  extern void perf_check_microcode(void);
>  #else

I would like to use the x86_perf namespace or something along those
lines, this is very much not a generic perf interface -- it is very much
x86 (or rather even Intel) specific.
