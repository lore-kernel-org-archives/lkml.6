Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99223C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfANRGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:06:17 -0500
Received: from foss.arm.com ([217.140.101.70]:37786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANRGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:06:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D939A78;
        Mon, 14 Jan 2019 09:06:16 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC67E3F5BD;
        Mon, 14 Jan 2019 09:06:15 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm64: Advertise mitigation of Spectre-v2, or lack
 thereof
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190114103528.52931-1-marc.zyngier@arm.com>
 <20190114103528.52931-2-marc.zyngier@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <7f79add0-c173-4921-2dfb-b2e1ac4dd032@arm.com>
Date:   Mon, 14 Jan 2019 11:06:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190114103528.52931-2-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 01/14/2019 04:35 AM, Marc Zyngier wrote:
> We currently have a list of CPUs affected by Spectre-v2, for which
> we check that the firmware implements ARCH_WORKAROUND_1. It turns
> out that not all firmwares do implement the required mitigation,
> and that we fail to let the user know about it.
> 
> Instead, let's slightly revamp our checks, and rely on a whitelist
> of cores that are known to be non-vulnerable, and let the user know
> the status of the mitigation in the kernel log.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/kernel/cpu_errata.c | 111 +++++++++++++++------------------
>   1 file changed, 52 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index c8ff96158b94..145f8b5d093d 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -138,9 +138,9 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>   	__flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
>   }
>   
> -static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
> -				      const char *hyp_vecs_start,
> -				      const char *hyp_vecs_end)
> +static void install_bp_hardening_cb(bp_hardening_cb_t fn,
> +				    const char *hyp_vecs_start,
> +				    const char *hyp_vecs_end)
>   {
>   	static DEFINE_RAW_SPINLOCK(bp_lock);
>   	int cpu, slot = -1;
> @@ -176,31 +176,14 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
>   #define __smccc_workaround_1_smc_start		NULL
>   #define __smccc_workaround_1_smc_end		NULL
>   
> -static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
> -				      const char *hyp_vecs_start,
> -				      const char *hyp_vecs_end)
> +static void install_bp_hardening_cb(bp_hardening_cb_t fn,
> +				    const char *hyp_vecs_start,
> +				    const char *hyp_vecs_end)
>   {
>   	__this_cpu_write(bp_hardening_data.fn, fn);
>   }
>   #endif	/* CONFIG_KVM_INDIRECT_VECTORS */
>   
> -static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
> -				     bp_hardening_cb_t fn,
> -				     const char *hyp_vecs_start,
> -				     const char *hyp_vecs_end)
> -{
> -	u64 pfr0;
> -
> -	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
> -		return;
> -
> -	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> -	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
> -		return;
> -
> -	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
> -}
> -
>   #include <uapi/linux/psci.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/psci.h>
> @@ -227,20 +210,21 @@ static void qcom_link_stack_sanitization(void)
>   		     : "=&r" (tmp));
>   }
>   
> -static void
> -enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
> +/*
> + * -1: No workaround
> + *  0: No workaround required
> + *  1: Workaround installed
> + */
> +static int detect_harden_bp_fw(void)
>   {
>   	bp_hardening_cb_t cb;
>   	void *smccc_start, *smccc_end;
>   	struct arm_smccc_res res;
>   	u32 midr = read_cpuid_id();
>   
> -	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
> -		return;
> -
>   	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
>   		__hardenbp_enab = false;
> -		return;
> +		return -1;
>   	}
>   
>   	switch (psci_ops.conduit) {
> @@ -249,7 +233,7 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>   				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>   		if ((int)res.a0 < 0) {
>   			__hardenbp_enab = false;
> -			return;
> +			return -1;
>   		}
>   		cb = call_hvc_arch_workaround_1;
>   		/* This is a guest, no need to patch KVM vectors */
> @@ -262,7 +246,7 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>   				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>   		if ((int)res.a0 < 0) {
>   			__hardenbp_enab = false;
> -			return;
> +			return -1;
>   		}
>   		cb = call_smc_arch_workaround_1;
>   		smccc_start = __smccc_workaround_1_smc_start;
> @@ -271,16 +255,22 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>   
>   	default:
>   		__hardenbp_enab = false;
> -		return;
> +		return -1;
>   	}
>   
>   	if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
>   	    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1))
>   		cb = qcom_link_stack_sanitization;
>   
> -	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
> +	install_bp_hardening_cb(cb, smccc_start, smccc_end);
>   
> -	return;
> +	return 1;
> +}
> +#else
> +static int detect_harden_bp_fw(void)
> +{
> +	/* Sorry, can't do a thing */
> +	return -1;
>   }
>   #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>   
> @@ -544,7 +534,15 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>   
>   #if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
>   	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
> -
> +/*
> + * List of CPUs that do not need any Spectre-v2 mitigation at all.
> + */
> +static const struct midr_range spectre_v2_safe_list[] = {
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
> +	{ /* sentinel */ }
> +};
>   
>   static bool __spectrev2_safe = true;
>   
> @@ -555,37 +553,34 @@ static bool __spectrev2_safe = true;
>   static bool __maybe_unused
>   check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>   {
> -	bool is_vul;
> +	int need_wa;
>   
>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>   
> -	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
> +	/* If the CPU has CSV2 set, we're safe */
> +	if (cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64PFR0_EL1),
> +						 ID_AA64PFR0_CSV2_SHIFT))
> +		return false;
>   
> -	if (is_vul)
> -		__spectrev2_safe = false;
> +	/* Alternatively, we have a list of unaffected CPUs */
> +	if (is_midr_in_range_list(read_cpuid_id(), spectre_v2_safe_list))
> +		return false;
> +
> +	/* Fallback to firmware detection */
> +	need_wa = detect_harden_bp_fw();
> +	if (!need_wa)
> +		return false;
> +
> +	__spectrev2_safe = false;
> +
> +	if (need_wa < 0)
> +		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
>   
>   	arm64_requested_vuln_attrs |= VULN_SPECTREV2;

This bit here, is what turns on the sysfs entry. So it needs to be 
hoisted before the first return. Also, I think that since 
detect_harden_bp_fw() is now returning the firmware state, we can check 
once for failure and set `__hardenbp_enab = false;` here rather the half 
dozen times it happens in what is now detect_harden_bp_fw();


Thanks,


>   
> -	return is_vul;
> +	return (need_wa > 0);
>   }
>   
> -/*
> - * List of CPUs where we need to issue a psci call to
> - * harden the branch predictor.
> - */
> -static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
> -	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> -	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> -	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> -	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> -	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
> -	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
> -	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
> -	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
> -	MIDR_ALL_VERSIONS(MIDR_NVIDIA_DENVER),
> -	{},
> -};
> -
>   #endif
>   
>   #ifdef CONFIG_HARDEN_EL2_VECTORS
> @@ -764,10 +759,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>   	{
>   		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> -		.cpu_enable = enable_smccc_arch_workaround_1,
>   		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>   		.matches = check_branch_predictor,
> -		.midr_range_list = arm64_bp_harden_smccc_cpus,
>   	},
>   #endif
>   #ifdef CONFIG_HARDEN_EL2_VECTORS
> 

