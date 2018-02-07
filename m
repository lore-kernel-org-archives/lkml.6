Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeBGLbe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:31:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49534 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753796AbeBGLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:31:33 -0500
Subject: Re: [PATCH v2 05/20] arm64: capabilities: Add flags to handle the
 conflicts on late CPU
To: Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-6-suzuki.poulose@arm.com>
 <20180207103804.GV5862@e103592.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7221b67c-6581-93bd-ebb3-7e48736ecb02@arm.com>
Date: Wed, 7 Feb 2018 11:31:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207103804.GV5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:38, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:52PM +0000, Suzuki K Poulose wrote:
>> When a CPU is brought up, it is checked against the caps that are
>> known to be enabled on the system (via verify_local_cpu_capabilities()).
>> Based on the state of the capability on the CPU vs. that of System we
>> could have the following combinations of conflict.
>>
>> 	x-----------------------------x
>> 	| Type  | System   | Late CPU |
>> 	|-----------------------------|
>> 	|  a    |   y      |    n     |
>> 	|-----------------------------|
>> 	|  b    |   n      |    y     |
>> 	x-----------------------------x
>>
>> Case (a) is not permitted for caps which are system features, which the
>> system expects all the CPUs to have (e.g VHE). While (a) is ignored for
>> all errata work arounds. However, there could be exceptions to the plain
>> filtering approach. e.g, KPTI is an optional feature for a late CPU as
>> long as the system already enables it.
>>
>> Case (b) is not permitted for errata work arounds which requires some work
>> around, which cannot be delayed. And we ignore (b) for features. Here, yet
> 
> Nit, maybe:
> 
> "Case (b) is not permitted for any errata workaround that cannot be
> activated if the kernel has finished booting and has not already enabled
> it."

Nit^2: I think it would suffice to say "...that cannot be activated 
after the kernel has finished booting." - since we don't really have the 
concept of *de*activating workarounds, it is already implicit in that 
statement that the one in question wasn't activated *before* the kernel 
finished booting.

Robin.

>> again, KPTI is an exception, where if a late CPU needs KPTI we are too late
>> to enable it (because we change the allocation of ASIDs etc).
>>
>> Add two different flags to indicate how the conflict should be handled.
>>
>>   ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU - CPUs may have the capability
>>   ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU - CPUs may not have the cappability.
>>
>> Now that we have the flags to describe the behavior of the errata and
>> the features, as we treat them, define types for ERRATUM and FEATURE.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> All my suggestions in this patch are rewordings of comments, so they're
> not vital, and anyway you may disagree that they make the meaning
> clearer.  So I don't think they're essential.
> 
> For the actual code
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 61 ++++++++++++++++++++++++++++++++++++-
>>   arch/arm64/kernel/cpu_errata.c      |  8 ++---
>>   arch/arm64/kernel/cpufeature.c      | 30 +++++++++---------
>>   3 files changed, 79 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 05da54f1b4c7..7460b1f7e611 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -142,7 +142,8 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *    capabilities and if there is a conflict, the kernel takes an action, based
>>    *    on the severity (e.g, a CPU could be prevented from booting or cause a
>>    *    kernel panic). The CPU is allowed to "affect" the state of the capability,
>> - *    if it has not been finalised already.
>> + *    if it has not been finalised already. See section 5 for more details on
>> + *    conflicts.
>>    *
>>    * 4) Action: As mentioned in (2), the kernel can take an action for each detected
>>    *    capability, on all CPUs on the system. This is always initiated only after
>> @@ -155,6 +156,32 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>    *	b) Any late CPU, brought up after (1), the action is triggered via:
>>    *		check_local_cpu_capabilities() -> verify_local_cpu_capabilities()
>>    *
>> + * 5) Conflicts: Based on the state of the capability on a late CPU vs. the system
>> + *    state, we could have the following combinations :
>> + *
>> + *		x-----------------------------x
>> + *		| Type  | System   | Late CPU |
>> + *		|-----------------------------|
>> + *		|  a    |   y      |    n     |
>> + *		|-----------------------------|
>> + *		|  b    |   n      |    y     |
>> + *		x-----------------------------x
> 
> Nit: I find this a bit hard to follow.  Maybe reordering things a bit
> would help but putting the rule (the precise bit) first, and the
> rationale (necessarily more vague) afterward:
> 
> "Two capability type flag bits are defined to indicate whether each kind
> of conflict can be tolerated:
> 
> 		ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU - Case (a) is allowed
> 		ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU - Case (b) is allowed."
> 
>> + *
>> + *     Case (a) is not permitted for capabilities which are usually system
>> + *     features, which the system expects all CPUs to have. While (a) is ignored
>> + *     for capabilities which represents an erratum work around.
> 
> Similarly "Case (a) is not permitted for a capability that the system
> requires all CPUs to have in order for the capability to be enabled.
> This is typical for capabilities that represent enhanced functionality."
> 
>> + *
>> + *     Case (b) is not permitted for erratum capabilities, which might require
>> + *     some work arounds which cannot be applied really late. Meanwhile, most
>> + *     of the features could safely ignore (b), as the system doesn't use it
>> + *     anyway.
> 
> and
> 
> "Case (b) is not permitted for a capability that the system must enable
> during boot if any CPU in the system requires it in order to run safely.
> This is typical for erratum workarounds that cannot be enabled after the
> corresponding capability is finalised.
> 
> In some non-typical cases, either both (a) and (b), or neither, should
> be permitted.  This can be described by including neither or both flags
> in the capability's type field."
> 
> [...]
> 
>>   
>>   
>> @@ -165,6 +192,26 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>   #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
>>   #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
>>   
>> +/* Is it permitted for a late CPU to have this capability when system doesn't already have */
> 
> "doesn't already have" -> "hasn't already enabled it"?
> 
>> +#define ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU	((u16)BIT(4))
>> +/* Is it safe for a late CPU to miss this capability when system has it */
>> +#define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
>> +
>> +/*
>> + * CPU errata detected at boot time based on feature of one or more CPUs.
>> + * It is not safe for a late CPU to have this feature when the system doesn't
> 
> Can we around using the word "feature" to describe errata here?
> 
> Maybe "CPU errata workarounds that need to be enabled at boot time if
> one or more CPUs in the system requires the workaround.  When one of
> these workaround capabilities has been enabled, it is safe to allow any
> CPU to boot that does not require the workaround."
> 
>> + * have it. But it is safe to miss the feature if the system has it.
>> + */
>> +#define ARM64_CPUCAP_LOCAL_CPU_ERRATUM		\
>> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
>> +/*
>> + * CPU feature detected at boot time based on system-wide value of a feature.
>> + * It is safe for a late CPU to have this feature even though the system doesn't
>> + * have it already. But the CPU must have this feature if the system does.
> 
> "hasn't enabled it, although the feature will not be used by Linux
> in this case.  If the system has enabled this feature already then every
> late CPU must have it."
> 
>> + */
>> +#define ARM64_CPUCAP_SYSTEM_FEATURE	\
>> +	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
>> +
>>   struct arm64_cpu_capabilities {
>>   	const char *desc;
>>   	u16 capability;
>> @@ -198,6 +245,18 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
>>   	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
>>   }
>>   
>> +static inline bool
>> +cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
>> +{
>> +	return !!(cap->type & ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU);
>> +}
>> +
>> +static inline bool
>> +cpucap_late_cpu_permitted(const struct arm64_cpu_capabilities *cap)
>> +{
>> +	return !!(cap->type & ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU);
>> +}
>> +
>>   extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>   extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>>   extern struct static_key_false arm64_const_caps_ready;
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 328c5a031e45..22ec3960a0c5 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -175,14 +175,14 @@ static void qcom_enable_link_stack_sanitization(
>>   #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>>   
>>   #define MIDR_RANGE(model, min, max) \
>> -	.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU, \
>> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
>>   	.matches = is_affected_midr_range, \
>>   	.midr_model = model, \
>>   	.midr_range_min = min, \
>>   	.midr_range_max = max
>>   
>>   #define MIDR_ALL_VERSIONS(model) \
>> -	.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU, \
>> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
>>   	.matches = is_affected_midr_range, \
>>   	.midr_model = model, \
>>   	.midr_range_min = 0, \
>> @@ -286,7 +286,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>   		.desc = "Mismatched cache line size",
>>   		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
>>   		.matches = has_mismatched_cache_line_size,
>> -		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
>> +		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>>   		.cpu_enable = cpu_enable_trap_ctr_access,
>>   	},
>>   #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
>> @@ -300,7 +300,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>   	{
>>   		.desc = "Qualcomm Technologies Kryo erratum 1003",
>>   		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
>> -		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
>> +		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>>   		.midr_model = MIDR_QCOM_KRYO,
>>   		.matches = is_kryo_midr,
>>   	},
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 8d22f0ef0927..1b29b3f0a1bc 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -921,7 +921,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "GIC system register CPU interface",
>>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_useable_gicv3_cpuif,
>>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
>> @@ -932,7 +932,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "Privileged Access Never",
>>   		.capability = ARM64_HAS_PAN,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64MMFR1_EL1,
>>   		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
>> @@ -945,7 +945,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "LSE atomic instructions",
>>   		.capability = ARM64_HAS_LSE_ATOMICS,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64ISAR0_EL1,
>>   		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
>> @@ -956,14 +956,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "Software prefetching using PRFM",
>>   		.capability = ARM64_HAS_NO_HW_PREFETCH,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_no_hw_prefetch,
>>   	},
>>   #ifdef CONFIG_ARM64_UAO
>>   	{
>>   		.desc = "User Access Override",
>>   		.capability = ARM64_HAS_UAO,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64MMFR2_EL1,
>>   		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
>> @@ -977,21 +977,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   #ifdef CONFIG_ARM64_PAN
>>   	{
>>   		.capability = ARM64_ALT_PAN_NOT_UAO,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = cpufeature_pan_not_uao,
>>   	},
>>   #endif /* CONFIG_ARM64_PAN */
>>   	{
>>   		.desc = "Virtualization Host Extensions",
>>   		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = runs_at_el2,
>>   		.cpu_enable = cpu_copy_el2regs,
>>   	},
>>   	{
>>   		.desc = "32-bit EL0 Support",
>>   		.capability = ARM64_HAS_32BIT_EL0,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>   		.sign = FTR_UNSIGNED,
>> @@ -1001,21 +1001,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "Reduced HYP mapping offset",
>>   		.capability = ARM64_HYP_OFFSET_LOW,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = hyp_offset_low,
>>   	},
>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>   	{
>>   		.desc = "Kernel page table isolation (KPTI)",
>>   		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = unmap_kernel_at_el0,
>>   	},
>>   #endif
>>   	{
>>   		/* FP/SIMD is not implemented */
>>   		.capability = ARM64_HAS_NO_FPSIMD,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.min_field_value = 0,
>>   		.matches = has_no_fpsimd,
>>   	},
>> @@ -1023,7 +1023,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "Data cache clean to Point of Persistence",
>>   		.capability = ARM64_HAS_DCPOP,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64ISAR1_EL1,
>>   		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
>> @@ -1033,7 +1033,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   #ifdef CONFIG_ARM64_SVE
>>   	{
>>   		.desc = "Scalable Vector Extension",
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.capability = ARM64_SVE,
>>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>   		.sign = FTR_UNSIGNED,
>> @@ -1047,7 +1047,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		.desc = "RAS Extension Support",
>>   		.capability = ARM64_HAS_RAS_EXTN,
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>   		.matches = has_cpuid_feature,
>>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>   		.sign = FTR_UNSIGNED,
>> @@ -1062,7 +1062,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   #define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
>>   	{							\
>>   		.desc = #cap,					\
>> -		.type = ARM64_CPUCAP_SCOPE_SYSTEM,		\
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,		\
>>   		.matches = has_cpuid_feature,			\
>>   		.sys_reg = reg,					\
>>   		.field_pos = field,				\
>> -- 
>> 2.14.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
