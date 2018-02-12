Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeBLRRe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:17:34 -0500
Received: from foss.arm.com ([217.140.101.70]:43832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753058AbeBLRRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:17:32 -0500
Date: Mon, 12 Feb 2018 17:17:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 15/22] arm64: capabilities: Change scope of VHE to
 Boot CPU feature
Message-ID: <20180212171727.GL5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-30-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-30-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:54:59PM +0000, Suzuki K Poulose wrote:
> We expect all CPUs to be running at the same EL inside the kernel
> with or without VHE enabled and we have strict checks to ensure
> that any mismatch triggers a kernel panic. If VHE is enabled,
> we use the feature based on the boot CPU and all other CPUs
> should follow. This makes it a perfect candidate for a cpability

capability

> based on the boot CPU,  which should be matched by all the CPUs
> (both when is ON and OFF). This saves us some not-so-pretty
> hooks and special code, just for verifying the conflict.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  7 +++++++
>  arch/arm64/include/asm/virt.h       |  6 ------
>  arch/arm64/kernel/cpufeature.c      |  5 +++--
>  arch/arm64/kernel/smp.c             | 38 -------------------------------------
>  4 files changed, 10 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 5f56a8342065..dfce93f79ae7 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -276,6 +276,13 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>  	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
>  	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
>  
> +/*
> + * Critical CPU feature used early in the boot based on the boot CPU.
> + * The feature should be matched by all booting CPU (both miss and hit
> + * cases).
> + */
> +#define ARM64_CPUCAP_CRITICAL_BOOT_CPU_FEATURE ARM64_CPUCAP_SCOPE_BOOT_CPU
> +

Nit: would it be consistent with the uses we already have for the word
"strict" to use that word here?  i.e.,
ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE.
Or do you think that would be more confusing?


Otherwise, "critical" sounds a bit like we depend on the capability
being available.

If "strict" doesn't fit though and no other option suggests itself,
it's probably not worth changing this.

>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index c5f89442785c..9d1e24e030b3 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -102,12 +102,6 @@ static inline bool has_vhe(void)
>  	return false;
>  }
>  
> -#ifdef CONFIG_ARM64_VHE
> -extern void verify_cpu_run_el(void);
> -#else
> -static inline void verify_cpu_run_el(void) {}
> -#endif
> -
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* ! __ASM__VIRT_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7625e2962e2b..f66e66c79916 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1016,11 +1016,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  	},
>  #endif /* CONFIG_ARM64_PAN */
>  	{
> +#ifdef CONFIG_ARM64_VHE
>  		.desc = "Virtualization Host Extensions",
>  		.capability = ARM64_HAS_VIRT_HOST_EXTN,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_CRITICAL_BOOT_CPU_FEATURE,
>  		.matches = runs_at_el2,
>  		.cpu_enable = cpu_copy_el2regs,
> +#endif

Shouldn't the #ifdef...#endif be outside the { ... },?

Otherwise this yields an empty block that will truncate the list in the
CONFIG_ARM64_VHE case...


Removal of this block for !CONFIG_ARM64_VHE is a change rather than just
refactoring, so the commit message should explain it.

[...]

Cheers
---Dave
