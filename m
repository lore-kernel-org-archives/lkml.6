Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A55C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E5120895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrANRvTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJMVHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:07:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xu8sr8Y8Vnh1cOR9GYZAhrWRVAzLQ5jidbbhlxgn1VQ=; b=UrANRvTJLAfsuw39+caJFbbkB
        +a4RlXb91+Z1077wrNt+hQQEhKRUfvgOJzpVpplTVhz73TtMC3JEYqLfq8m3OdGQxRXX1Go4mBZZ6
        Sf8/pp9023DwphsqLR1I4Wl5CV8HsghmZh93F8CBZkf1l67IZHrCKWW04K8FIpdz6zyNc/uWaEkWO
        hrnXhiYzgTZLpTKDbJBMH6hFsKGDhQORJBJqiaY2UpH/hUwCLgtA3AK1oAN+wDwDt7N7ePOOy+T3m
        4mYe8AOZbN/4fVL+a+4K2sZ1rAPwYyMF8A+3zOgpWnInQ4gSpLvbA3fySDqGc2AdXJPFSUPIdYLe8
        iJlzfEHfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBJzk-0005rP-7K; Sat, 13 Oct 2018 13:30:16 +0000
Received: by worktop (Postfix, from userid 1000)
        id 98CB46E079E; Sat, 13 Oct 2018 15:30:13 +0200 (CEST)
Date:   Sat, 13 Oct 2018 15:30:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Message-ID: <20181013133013.GA15612@worktop.programming.kicks-ass.net>
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:20:17PM +0800, Wei Wang wrote:
> Guest changing MSR_CORE_PERF_GLOBAL_CTRL causes KVM to reprogram pmc
> counters, which re-allocates a host perf event. This process is

Yea gawds, that's horrific. Why does it do that? We have
PERF_EVENT_IOC_PERIOD which does that much better. Still, what you're
proposing is faster still -- if it is correct.

> This patch implements a fast path to handle the guest change of
> MSR_CORE_PERF_GLOBAL_CTRL for the guest pmi case. Guest change of the
> msr will be applied to the hardware when entering the guest, and the
> old perf event will continue to be used. The guest setting of the
> perf counter for the next irq period in pmi will also be written
> directly to the hardware counter when entering the guest.

What you're failing to explain here is why exactly it is ok to write to
the MSR directly without updating the perf_event state. I didn't take
the time to go through all that, but it certainly needs documenting.

This is something that can certainly get broken by accident.

Is there any documentation/comment that explains how this virtual PMU
crud works in general?

> +u64 intel_pmu_disable_guest_counters(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u64 mask = cpuc->intel_ctrl_host_mask;
> +
> +	cpuc->intel_ctrl_host_mask = ULONG_MAX;
> +
> +	return mask;
> +}
> +EXPORT_SYMBOL_GPL(intel_pmu_disable_guest_counters);

OK, this them gets the MSR written when we re-enter the guest, after the
WRMSR trap, right?

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 58ead7d..210e5df 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -80,6 +80,7 @@ static void kvm_perf_overflow_intr(struct perf_event *perf_event,
>  			      (unsigned long *)&pmu->reprogram_pmi)) {
>  		__set_bit(pmc->idx, (unsigned long *)&pmu->global_status);
>  		kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
> +		pmu->in_pmi = true;
>  
>  		/*
>  		 * Inject PMI. If vcpu was in a guest mode during NMI PMI
> diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
> index 5ab4a36..5f6ac3c 100644
> --- a/arch/x86/kvm/pmu_intel.c
> +++ b/arch/x86/kvm/pmu_intel.c
> @@ -55,6 +55,27 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  	pmu->fixed_ctr_ctrl = data;
>  }
>  
> +static void fast_global_ctrl_changed(struct kvm_pmu *pmu, u64 data)
> +{
> +	pmu->global_ctrl = data;
> +
> +	if (!data) {
> +		/*
> +		 * The guest PMI handler is asking for disabling all the perf
> +		 * counters
> +		 */
> +		pmu->counter_mask = intel_pmu_disable_guest_counters();
> +	} else {
> +		/*
> +		 * The guest PMI handler is asking for enabling the perf
> +		 * counters. This happens at the end of the guest PMI handler,
> +		 * so clear in_pmi.
> +		 */
> +		intel_pmu_enable_guest_counters(pmu->counter_mask);
> +		pmu->in_pmi = false;
> +	}
> +}

The v4 PMI handler does not in fact do that I think.

> @@ -237,9 +267,23 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_fixed_pmc(pmu, msr))) {
> -			if (!msr_info->host_initiated)
> -				data = (s64)(s32)data;
> -			pmc->counter += data - pmc_read_counter(pmc);
> +			if (pmu->in_pmi) {
> +				/*
> +				 * Since we are not re-allocating a perf event
> +				 * to reconfigure the sampling time when the
> +				 * guest pmu is in PMI, just set the value to
> +				 * the hardware perf counter. Counting will
> +				 * continue after the guest enables the
> +				 * counter bit in MSR_CORE_PERF_GLOBAL_CTRL.
> +				 */
> +				struct hw_perf_event *hwc =
> +						&pmc->perf_event->hw;
> +				wrmsrl(hwc->event_base, data);

But all this relies on the event calling the overflow handler; how does
this not corrupt the event state such that x86_perf_event_set_period()
might decide that the generated PMI is a spurious one?

> +			} else {
> +				if (!msr_info->host_initiated)
> +					data = (s64)(s32)data;
> +				pmc->counter += data - pmc_read_counter(pmc);
> +			}
>  			return 0;
>  		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
>  			if (data == pmc->eventsel)
> -- 
> 2.7.4
> 
