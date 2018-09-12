Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A76C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4878120854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4878120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:38:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:23511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeILSiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:38:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 06:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,364,1531810800"; 
   d="scan'208";a="262842905"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2018 06:33:39 -0700
Received: from [10.254.81.196] (kliang2-mobl1.ccr.corp.intel.com [10.254.81.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 68F92580145;
        Wed, 12 Sep 2018 06:33:38 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI
 handler
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
 <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6316c9aa-005e-e01a-8a54-b3a9c241da7c@linux.intel.com>
Date:   Wed, 12 Sep 2018 09:33:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Any comments for the patch series regarding to v4 PMI handler?

Thanks,
Kan

On 8/8/2018 3:12 AM, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Implements counter freezing for Arch Perfmon v4 (Skylake and
> newer). This allows to speed up the PMI handler by avoiding
> unnecessary MSR writes and make it more accurate.
> 
> The Arch Perfmon v4 PMI handler is substantially different than
> the older PMI handler.
> 
> Differences to the old handler:
> - It relies on counter freezing, which eliminates several MSR
> writes from the PMI handler and lowers the overhead significantly.
> 
> It makes the PMI handler more accurate, as all counters get
> frozen atomically as soon as any counter overflows. So there is
> much less counting of the PMI handler itself.
> 
> With the freezing we don't need to disable or enable counters or
> PEBS. Only BTS which does not support auto-freezing still needs to
> be explicitly managed.
> 
> - The PMU acking is done at the end, not the beginning.
> This makes it possible to avoid manual enabling/disabling
> of the PMU, instead we just rely on the freezing/acking.
> 
> - The APIC is acked before reenabling the PMU, which avoids
> problems with LBRs occasionally not getting unfreezed on Skylake.
> 
> - Looping is only needed to workaround a corner case which several PMIs
> are very close to each other. For common cases, the counters are freezed
> during PMI handler. It doesn't need to do re-check.
> 
> This patch
> - Adds code to enable v4 counter freezing
> - Fork <=v3 and >=v4 PMI handlers into separate functions.
> - Add kernel parameter to disable counter freezing. It took some time to
>    debug counter freezing, so in case there are new problems we added an
>    option to turn it off. Would not expect this to be used until there
>    are new bugs.
> - Only for big core. The patch for small core will be posted later
>    separately.
> 
> Performance:
> 
> When profiling a kernel build on Kabylake with different perf options,
> measuring the length of all NMI handlers using the nmi handler
> trace point:
> 
> V3 is without counter freezing.
> V4 is with counter freezing.
> The value is the average cost of the PMI handler.
> (lower is better)
> 
> perf options    `           V3(ns) V4(ns)  delta
> -c 100000                   1088   894     -18%
> -g -c 100000                1862   1646    -12%
> --call-graph lbr -c 100000  3649   3367    -8%
> --c.g. dwarf -c 100000      2248   1982    -12%
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V1:
>   - Move enable_counter_freeze() to intel_pmu_cpu_starting().
>   - Remove frozen_enabled. The state of counter-freeze feature doesn't
>     change after initialization.
>   - Use __setup() to replace of module_param
>   - Don't print "counter freezing" to log
>   - Use bit fields to replace bool for all PMI handler knobs.
>   - Update comments and document
> 
>   Documentation/admin-guide/kernel-parameters.txt |   5 ++
>   arch/x86/events/intel/core.c                    | 112 ++++++++++++++++++++++++
>   arch/x86/events/perf_event.h                    |   4 +-
>   arch/x86/include/asm/msr-index.h                |   1 +
>   4 files changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 533ff5c..cb2a6f68 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -828,6 +828,11 @@
>   			causing system reset or hang due to sending
>   			INIT from AP to BSP.
>   
> +	disable_counter_freezing [HW]
> +			Disable Intel PMU counter freezing feature.
> +			The feature only exists starting from
> +			Arch Perfmon v4 (Skylake and newer).
> +
>   	disable_ddw	[PPC/PSERIES]
>   			Disable Dynamic DMA Window support. Use this if
>   			to workaround buggy firmware.
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a7d7759..fdd2f99 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -1995,6 +1995,18 @@ static void intel_pmu_nhm_enable_all(int added)
>   	intel_pmu_enable_all(added);
>   }
>   
> +static void enable_counter_freeze(void)
> +{
> +	update_debugctlmsr(get_debugctlmsr() |
> +			DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI);
> +}
> +
> +static void disable_counter_freeze(void)
> +{
> +	update_debugctlmsr(get_debugctlmsr() &
> +			~DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI);
> +}
> +
>   static inline u64 intel_pmu_get_status(void)
>   {
>   	u64 status;
> @@ -2290,6 +2302,91 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>   	return handled;
>   }
>   
> +static bool disable_counter_freezing;
> +static int __init intel_perf_counter_freezing_setup(char *s)
> +{
> +	disable_counter_freezing = true;
> +	pr_info("Intel PMU Counter freezing feature disabled\n");
> +	return 1;
> +}
> +__setup("disable_counter_freezing", intel_perf_counter_freezing_setup);
> +
> +/*
> + * Simplified handler for Arch Perfmon v4:
> + * - We rely on counter freezing/unfreezing to enable/disable the PMU.
> + * This is done automatically on PMU ack.
> + * - Ack the PMU only after the APIC.
> + */
> +
> +static int intel_pmu_handle_irq_v4(struct pt_regs *regs)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int handled = 0;
> +	bool bts = false;
> +	u64 status;
> +	int pmu_enabled = cpuc->enabled;
> +	int loops = 0;
> +
> +	/* PMU has been disabled because of counter freezing */
> +	cpuc->enabled = 0;
> +	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
> +		bts = true;
> +		intel_bts_disable_local();
> +		handled = intel_pmu_drain_bts_buffer();
> +		handled += intel_bts_interrupt();
> +	}
> +	status = intel_pmu_get_status();
> +	if (!status)
> +		goto done;
> +again:
> +	intel_pmu_lbr_read();
> +	if (++loops > 100) {
> +		static bool warned;
> +
> +		if (!warned) {
> +			WARN(1, "perfevents: irq loop stuck!\n");
> +			perf_event_print_debug();
> +			warned = true;
> +		}
> +		intel_pmu_reset();
> +		goto done;
> +	}
> +
> +
> +	handled += handle_pmi_common(regs, status);
> +done:
> +	/* Ack the PMI in the APIC */
> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +
> +	/*
> +	 * The counters start counting immediately while ack the status.
> +	 * Make it as close as possible to IRET. This avoids bogus
> +	 * freezing on Skylake CPUs.
> +	 */
> +	if (status) {
> +		intel_pmu_ack_status(status);
> +	} else {
> +		/*
> +		 * CPU may issues two PMIs very close to each other.
> +		 * When the PMI handler services the first one, the
> +		 * GLOBAL_STATUS is already updated to reflect both.
> +		 * When it IRETs, the second PMI is immediately
> +		 * handled and it sees clear status. At the meantime,
> +		 * there may be a third PMI, because the freezing bit
> +		 * isn't set since the ack in first PMI handlers.
> +		 * Double check if there is more work to be done.
> +		 */
> +		status = intel_pmu_get_status();
> +		if (status)
> +			goto again;
> +	}
> +
> +	if (bts)
> +		intel_bts_enable_local();
> +	cpuc->enabled = pmu_enabled;
> +	return handled;
> +}
> +
>   /*
>    * This handler is triggered by the local APIC, so the APIC IRQ handling
>    * rules apply:
> @@ -3361,6 +3458,9 @@ static void intel_pmu_cpu_starting(int cpu)
>   	if (x86_pmu.version > 1)
>   		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
>   
> +	if (x86_pmu.counter_freezing)
> +		enable_counter_freeze();
> +
>   	if (!cpuc->shared_regs)
>   		return;
>   
> @@ -3432,6 +3532,9 @@ static void intel_pmu_cpu_dying(int cpu)
>   	free_excl_cntrs(cpu);
>   
>   	fini_debug_store_on_cpu(cpu);
> +
> +	if (x86_pmu.counter_freezing)
> +		disable_counter_freeze();
>   }
>   
>   static void intel_pmu_sched_task(struct perf_event_context *ctx,
> @@ -4325,6 +4428,8 @@ __init int intel_pmu_init(void)
>   		x86_pmu.extra_regs = intel_skl_extra_regs;
>   		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
>   		x86_pmu.pebs_prec_dist = true;
> +		x86_pmu.counter_freezing = disable_counter_freezing ?
> +					   false : true;
>   		/* all extra regs are per-cpu when HT is on */
>   		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>   		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> @@ -4442,6 +4547,13 @@ __init int intel_pmu_init(void)
>   		pr_cont("full-width counters, ");
>   	}
>   
> +	/*
> +	 * For arch perfmon 4 use counter freezing to avoid
> +	 * several MSR accesses in the PMI.
> +	 */
> +	if (x86_pmu.counter_freezing)
> +		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
> +
>   	kfree(to_free);
>   	return 0;
>   }
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 1562863..adae087 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -560,9 +560,11 @@ struct x86_pmu {
>   	struct event_constraint *event_constraints;
>   	struct x86_pmu_quirk *quirks;
>   	int		perfctr_second_write;
> -	bool		late_ack;
>   	u64		(*limit_period)(struct perf_event *event, u64 l);
>   
> +	/* PMI handler bits */
> +	unsigned int	late_ack		:1,
> +			counter_freezing	:1;
>   	/*
>   	 * sysfs attrs
>   	 */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 68b2c31..4ae4a59 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -157,6 +157,7 @@
>   #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
>   #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
>   #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
> +#define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
>   #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
>   #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
>   
> 
