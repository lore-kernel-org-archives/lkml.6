Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeBGKiv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:38:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48576 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753696AbeBGKiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:38:50 -0500
Date: Wed, 7 Feb 2018 10:38:45 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 10/20] arm64: capabilities: Restrict KPTI detection to
 boot-time CPUs
Message-ID: <20180207103845.GA5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-11-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:27:57PM +0000, Suzuki K Poulose wrote:
> KPTI is treated as a system wide feature, where we enable the feature
> when all the CPUs on the system suffers from the security vulnerability,

Should that be "when any CPU"?

> unless it is forced via kernel command line. Also, if a late CPU needs
> KPTI but KPTI was not enabled at boot time, the CPU is currently allowed
> to boot, which is a potential security vulnerability.  This patch ensures
> that late CPUs are rejected as appropriate if they need KPTI but it wasn't
> enabled.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  9 +++++++++
>  arch/arm64/kernel/cpufeature.c      | 11 ++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7bb3fdec827e..71993dd4afae 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -223,6 +223,15 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>  	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
>  	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
>  
> +/*
> + * CPU feature detected at boot time, on one or more CPUs. A late CPU
> + * is not allowed to have the capability when the system doesn't have it.
> + * It is Ok for a late CPU to miss the feature.
> + */
> +#define ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE	\
> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
> +	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
> +
>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ecc87aa74c64..4a55492784b7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -862,9 +862,8 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>  
>  static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> -				int __unused)
> +				int scope)
>  {
> -	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
>  
>  	/* Forced on command line? */
>  	if (__kpti_forced) {
> @@ -885,8 +884,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  	}
>  
>  	/* Defer to CPU feature registers */
> -	return !cpuid_feature_extract_unsigned_field(pfr0,
> -						     ID_AA64PFR0_CSV3_SHIFT);
> +	return !has_cpuid_feature(entry, scope);
>  }
>  
>  static int __init parse_kpti(char *str)
> @@ -1008,7 +1006,10 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  	{
>  		.desc = "Kernel page table isolation (KPTI)",
>  		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
> +		.min_field_value = 1,
>  		.matches = unmap_kernel_at_el0,

Minor nit, but:

Can we have a comment here to explain that .min_field_value is the
minimum value that indicates that KPTI is _not_ required by this cpu?
This is the opposite of the usual semantics for this field.

Otherwise, this inversion of meaning is not obvious without digging into
unmap_kernel_at_el0() and spotting the ! in !has_cpuid_feature().

With that, or if this usage of !has_cpuid_feature() is already well-
established so that a comment is deemed unnecessary:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
