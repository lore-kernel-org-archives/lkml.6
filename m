Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDB420651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RrJcPmx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbfAPNOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:14:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38312 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfAPNOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:14:10 -0500
Received: from zn.tnic (p200300EC2BC98A0041D453747D657AA8.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:41d4:5374:7d65:7aa8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F5B21EC0842;
        Wed, 16 Jan 2019 14:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547644449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5NPow+C3SwZLlVDZsJDE8YVUU6UTrP5Aq+6PSmRtaCM=;
        b=RrJcPmx5Q8w9RFS2jLm0I6WRK3xxUeZMAs8IOm66k0WFizVmuDyhQWGq9SmCjr+lR2Nk0c
        VaBEDJg7/LYRI3rDXRl+/tjrJNU/2nca86yltApkQpOBMs8qDnvRcSp+hki+LHzcZs5WtH
        S1oKNoJLCmbOvNQaeRuHMaaHMpDAeHI=
Date:   Wed, 16 Jan 2019 14:14:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V5 2/4] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190116131401.GG15409@zn.tnic>
References: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
 <1546900465-5121-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546900465-5121-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:34:23PM -0800, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> KVM added a workaround for PEBS events leaking into guests with
> commit 26a4f3c08de4 ("perf/x86: disable PEBS on a guest entry.")
> This uses the VT entry/exit list to add an extra disable of the
> PEBS_ENABLE MSR.
> 
> Intel also added a fix for this issue to microcode updates on
> Haswell/Broadwell/Skylake.
> 
> It turns out using the MSR entry/exit list makes VM exits
> significantly slower. The list is only needed for disabling
> PEBS, because the GLOBAL_CTRL change gets optimized by
> KVM into changing the VMCS.
> 
> Check for the microcode updates that have the microcode
> fix for leaking PEBS, and disable the extra entry/exit list
> entry for PEBS_ENABLE. In addition we always clear the
> GLOBAL_CTRL for the PEBS counter while running in the guest,
> which is enough to make them never fire at the wrong
> side of the host/guest transition.
> 
> We see significantly reduced overhead for VM exits with the

No "We" in commit messages pls.

> filtering active with the patch from 8% to 4%.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Your SOB is missing.

> ---
> 
> Changes since V4:
> - Use new name x86_cpu_has_min_microcode_rev() and INTEL_CHECK_UCODE
> 
>  arch/x86/events/intel/core.c | 80 +++++++++++++++++++++++++++++++++++++++-----
>  arch/x86/events/perf_event.h |  3 +-
>  2 files changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ecc3e34..587d83e 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -18,6 +18,7 @@
>  #include <asm/hardirq.h>
>  #include <asm/intel-family.h>
>  #include <asm/apic.h>
> +#include <asm/cpu_device_id.h>
>  
>  #include "../perf_event.h"
>  
> @@ -3206,16 +3207,27 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
>  	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
>  	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
>  	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
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
> +	if (!x86_pmu.pebs_isolated) {
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
>  	return arr;
>  }
>  
> @@ -3733,6 +3745,45 @@ static __init void intel_clovertown_quirk(void)
>  	x86_pmu.pebs_constraints = NULL;
>  }
>  
> +static const struct x86_cpu_check isolation_ucodes[] = {
> +	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_CORE,	 3, 0x0000001f),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_ULT,	 1, 0x0000001e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_GT3E,	 1, 0x00000015),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 5, 0x0e000002),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_X,	 2, 0x0b000014),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     10, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     11, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     12, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    10, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    11, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    12, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    13, 0x0000004e),
> +	INTEL_CHECK_UCODE(INTEL_FAM6_CANNONLAKE_MOBILE,    3, 0x00000000),

Align vertically.

> +	{}
> +};
> +
> +static void intel_check_isolation(void)
> +{
> +	if (!x86_cpu_has_min_microcode_rev(isolation_ucodes)) {
> +		x86_pmu.pebs_isolated = 0;
> +		return;
> +	}
> +	x86_pmu.pebs_isolated = 1;
> +}

Simply:

static void intel_check_isolation(void)
{
        x86_pmu.pebs_isolated = x86_cpu_has_min_microcode_rev(isolation_ucodes);
}

> +
>  static int intel_snb_pebs_broken(int cpu)
>  {
>  	u32 rev = UINT_MAX; /* default to broken for unknown models */
> @@ -3757,6 +3808,8 @@ static void intel_snb_check_microcode(void)
>  	int pebs_broken = 0;
>  	int cpu;
>  
> +	intel_check_isolation();

That looks strange:

on the one hand, this function gets assigned to x86_pmu.check_microcode
but then, on the other, it gets called in intel_snb_check_microcode()
too, where latter gets assigned to that ->check_microcode pointer too.

This needs a cleanup to introduce a single microcode callback function
in this file and that function picks apart what to do based on the
models, etc.

Also, intel_snb_pebs_broken() needs to be converted to this new stepping
checking scheme too, says peterz.

> +
>  	for_each_online_cpu(cpu) {
>  		if ((pebs_broken = intel_snb_pebs_broken(cpu)))
>  			break;
> @@ -3838,6 +3891,12 @@ static __init void intel_sandybridge_quirk(void)
>  	cpus_read_unlock();
>  }
>  
> +static __init void intel_isolation_quirk(void)
> +{
> +	x86_pmu.check_microcode = intel_check_isolation;
> +	intel_check_isolation();
> +}
> +
>  static const struct { int id; char *name; } intel_arch_events_map[] __initconst = {
>  	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
>  	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
> @@ -4424,6 +4483,7 @@ __init int intel_pmu_init(void)
>  	case INTEL_FAM6_HASWELL_X:
>  	case INTEL_FAM6_HASWELL_ULT:
>  	case INTEL_FAM6_HASWELL_GT3E:
> +		x86_add_quirk(intel_isolation_quirk);

And reportedly, the quirks are one-off things - not what this one
needs to do. So you need to run this unconditionally at the end of
intel_pmu_init() and get rid of all that quirks indirection.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
