Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A66C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98912082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfBDPoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:44:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:59030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfBDPoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:44:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 07:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="140539994"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2019 07:43:43 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D425458044E;
        Mon,  4 Feb 2019 07:43:42 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d1161b7f-0f2c-4219-4f6d-225f12a333a2@linux.intel.com>
Date:   Mon, 4 Feb 2019 10:43:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204153827.GG17528@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 10:38 AM, Peter Zijlstra wrote:
> 
> 
> This then? That's nearly what you had; except a lot less noisy.
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -18,6 +18,7 @@
>   #include <asm/hardirq.h>
>   #include <asm/intel-family.h>
>   #include <asm/apic.h>
> +#include <asm/cpu_device_id.h>
>   
>   #include "../perf_event.h"
>   
> @@ -3206,16 +3207,27 @@ static struct perf_guest_switch_msr *int
>   	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
>   	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
>   	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
> -	/*
> -	 * If PMU counter has PEBS enabled it is not enough to disable counter
> -	 * on a guest entry since PEBS memory write can overshoot guest entry
> -	 * and corrupt guest memory. Disabling PEBS solves the problem.
> -	 */
> -	arr[1].msr = MSR_IA32_PEBS_ENABLE;
> -	arr[1].host = cpuc->pebs_enabled;
> -	arr[1].guest = 0;
> +	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
> +		arr[0].guest &= ~cpuc->pebs_enabled;
> +	else
> +		arr[0].guest &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
> +	*nr = 1;
> +
> +	if (x86_pmu.pebs && x86_pmu.pebs_no_isolation) {
> +		/*
> +		 * If PMU counter has PEBS enabled it is not enough to
> +		 * disable counter on a guest entry since PEBS memory
> +		 * write can overshoot guest entry and corrupt guest
> +		 * memory. Disabling PEBS solves the problem.
> +		 *
> +		 * Don't do this if the CPU already enforces it.
> +		 */
> +		arr[1].msr = MSR_IA32_PEBS_ENABLE;
> +		arr[1].host = cpuc->pebs_enabled;
> +		arr[1].guest = 0;
> +		*nr = 2;
> +	}
>   
> -	*nr = 2;
>   	return arr;
>   }
>   
> @@ -3739,6 +3751,48 @@ static __init void intel_clovertown_quir
>   	x86_pmu.pebs_constraints = NULL;
>   }
>   
> +static const struct x86_cpu_desc isolation_ucodes[] = {
> +	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_CORE,		 3, 0x0000001f),
> +	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
> +	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
> +	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
> +	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 5, 0x0e000002),
> +	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
> +	INTEL_CPU_DESC(INTEL_FAM6_CANNONLAKE_MOBILE,	 3, 0x00000000),
> +	{}
> +};
> +
> +static void intel_check_pebs_isolation(void)
> +{
> +	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
> +}
> +
> +static __init void intel_pebs_isolation_quirk(void)
> +{
> +	WARN_ON_ONCE(x86_pmu.check_microcode);
> +	x86_pmu.check_microcode = intel_check_pebs_isolation;
> +	intel_check_pebs_isolation();
> +}
> +
>   static int intel_snb_pebs_broken(int cpu)
>   {
>   	u32 rev = UINT_MAX; /* default to broken for unknown models */
> @@ -4433,6 +4487,7 @@ __init int intel_pmu_init(void)
>   	case INTEL_FAM6_HASWELL_ULT:
>   	case INTEL_FAM6_HASWELL_GT3E:
>   		x86_add_quirk(intel_ht_bug);
> +		x86_add_quirk(intel_pebs_isolation_quirk);
>   		x86_pmu.late_ack = true;
>   		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>   		memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> @@ -4464,6 +4519,7 @@ __init int intel_pmu_init(void)
>   	case INTEL_FAM6_BROADWELL_XEON_D:
>   	case INTEL_FAM6_BROADWELL_GT3E:
>   	case INTEL_FAM6_BROADWELL_X:
> +		x86_add_quirk(intel_pebs_isolation_quirk);
>   		x86_pmu.late_ack = true;
>   		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>   		memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> @@ -4526,6 +4582,7 @@ __init int intel_pmu_init(void)
>   	case INTEL_FAM6_SKYLAKE_X:
>   	case INTEL_FAM6_KABYLAKE_MOBILE:
>   	case INTEL_FAM6_KABYLAKE_DESKTOP:
> +		x86_add_quirk(intel_pebs_isolation_quirk);
>   		x86_pmu.late_ack = true;
>   		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>   		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1628,6 +1628,7 @@ void __init intel_ds_init(void)
>   	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
>   	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
>   	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
> +	x86_pmu.pebs_no_isolation = 1;

We will submit the Icelake support soon (probably next week).
That will be a problem for Icelake.

Thanks,
Kan

>   	if (x86_pmu.pebs) {
>   		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
>   		int format = x86_pmu.intel_cap.pebs_format;
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -601,13 +601,14 @@ struct x86_pmu {
>   	/*
>   	 * Intel DebugStore bits
>   	 */
> -	unsigned int	bts		:1,
> -			bts_active	:1,
> -			pebs		:1,
> -			pebs_active	:1,
> -			pebs_broken	:1,
> -			pebs_prec_dist	:1,
> -			pebs_no_tlb	:1;
> +	unsigned int	bts			:1,
> +			bts_active		:1,
> +			pebs			:1,
> +			pebs_active		:1,
> +			pebs_broken		:1,
> +			pebs_prec_dist		:1,
> +			pebs_no_tlb		:1,
> +			pebs_no_isolation	:1;
>   	int		pebs_record_size;
>   	int		pebs_buffer_size;
>   	void		(*drain_pebs)(struct pt_regs *regs);
> 
