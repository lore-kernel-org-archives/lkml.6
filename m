Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeBLRRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:17:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbeBLRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:17:21 -0500
Date: Mon, 12 Feb 2018 17:17:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, dave.martin@arm.com
Subject: Re: [PATCH v3 14/22] arm64: capabilities: Add support for features
 enabled early
Message-ID: <20180212171712.GK5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-28-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-28-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:54:57PM +0000, Suzuki K Poulose wrote:
> The kernel detects and uses some of the features based on the boot
> CPU and expects that all the following CPUs conform to it. e.g,
> with VHE and the boot CPU running at EL2, the kernel decides to
> keep the kernel running at EL2. If another CPU is brought up without
> this capability, we use custom hooks (via check_early_cpu_features())
> to handle it. To handle such capabilities add support for detecting
> and enabling capabilities based on the boot CPU.
> 
> A bit is added to indicate if the capability should be detected
> early on the boot CPU. The infrastructure then ensures that such
> capabilities are probed and "enabled" early on in the boot CPU
> and, enabled on the subsequent CPUs.
> 
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 46 +++++++++++++++++++++++++++++-------
>  arch/arm64/kernel/cpufeature.c      | 47 +++++++++++++++++++++++++++----------
>  2 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 383c69c95f23..5f56a8342065 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -104,7 +104,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   *    some checks at runtime. This could be, e.g, checking the value of a field
>   *    in CPU ID feature register or checking the cpu model. The capability
>   *    provides a call back ( @matches() ) to perform the check.
> - *    Scope defines how the checks should be performed. There are two cases:
> + *    Scope defines how the checks should be performed. There are three cases:
>   *
>   *     a) SCOPE_LOCAL_CPU: check all the CPUs and "detect" if at least one
>   *        matches. This implies, we have to run the check on all the booting
> @@ -117,6 +117,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   *        field in one of the CPU ID feature registers, we use the sanitised
>   *        value of the register from the CPU feature infrastructure to make
>   *        the decision.
> + *		Or
> + *     c) SCOPE_BOOT_CPU: Check only on the primary boot CPU to detect the feature.
> + *        This category is for features that are "finalised" (or used) by the kernel
> + *        very early even before the SMP cpus are brought up.
> + *

Nit: the overlong lines bring no benefit here.  Please wrap them if
possible -- but to avoid patch churn only bother for lines actually
changed/added by this patch.

>   *    The process of detection is usually denoted by "update" capability state
>   *    in the code.
>   *
> @@ -133,6 +138,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   *    w.r.t the capability. e.g, all secondary CPUs are treated "late CPUs" for
>   *    capabilities determined by the boot CPU.
>   *
> + *    At the moment there are two passes of finalising the capabilities.
> + *      a) Boot CPU scope capabilities - Finalised by primary boot CPU via
> + *         setup_boot_cpu_capabilities().
> + *      b) Everything except (a) - Run via setup_system_capabilities().
> + *
>   * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
>   *    the kernel should make sure that it is safe to use the CPU, by verifying
>   *    that the CPU is compliant with the state of the capabilities finalised
> @@ -141,12 +151,19 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   *	secondary_start_kernel()-> check_local_cpu_capabilities()
>   *
>   *    As explained in (2) above, capabilities could be finalised at different
> - *    points in the execution. Each CPU is verified against the "finalised"
> - *    capabilities and if there is a conflict, the kernel takes an action, based
> - *    on the severity (e.g, a CPU could be prevented from booting or cause a
> - *    kernel panic). The CPU is allowed to "affect" the state of the capability,
> - *    if it has not been finalised already. See section 5 for more details on
> - *    conflicts.
> + *    points in the execution. Each newly booted CPU is verified against those
> + *    capabilities that have been finalised by the time it boots.
> + *
> + *	a) SCOPE_BOOT_CPU : All CPUs are verified against the capability except
> + *	for the primary boot CPU.
> + *
> + *	b) SCOPE_LOCAL_CPU, SCOPE_SYSTEM: All CPUs hotplugged on by the user
> + *	after the kernel boot are verified against the capability.
> + *
> + *    If there is a conflict, the kernel takes an action, based on the severity
> + *    (e.g, a CPU could be prevented from booting or cause a kernel panic).
> + *    The CPU is allowed to "affect" the state of the capability, if it has not
> + *    been finalised already. See section 5 for more details on conflicts.
>   *
>   * 4) Action: As mentioned in (2), the kernel can take an action for each detected
>   *    capability, on all CPUs on the system. Appropriate actions include, turning
> @@ -193,15 +210,26 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   */
>  
>  
> -/* Decide how the capability is detected. On a local CPU vs System wide */
> +/*
> + * Decide how the capability is detected.
> + * On any local CPU vs System wide vs the primary boot CPU
> + */
>  #define ARM64_CPUCAP_SCOPE_LOCAL_CPU		((u16)BIT(0))
>  #define ARM64_CPUCAP_SCOPE_SYSTEM		((u16)BIT(1))
> +/*
> + * The capabilitiy is detected on the Boot CPU and is used by kernel
> + * during early boot. i.e, the capability should be "detected" and "enabled"
> + * as early as possibly on all booting CPUs.
> + */
> +#define ARM64_CPUCAP_SCOPE_BOOT_CPU		((u16)BIT(2))
>  #define ARM64_CPUCAP_SCOPE_MASK			\
>  	(ARM64_CPUCAP_SCOPE_SYSTEM	|	\
> -	 ARM64_CPUCAP_SCOPE_LOCAL_CPU)
> +	 ARM64_CPUCAP_SCOPE_LOCAL_CPU	|	\
> +	 ARM64_CPUCAP_SCOPE_BOOT_CPU)
>  
>  #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
>  #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
> +#define SCOPE_BOOT_CPU				ARM64_CPUCAP_SCOPE_BOOT_CPU
>  #define SCOPE_ALL				ARM64_CPUCAP_SCOPE_MASK
>  
>  /*
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index a15be4db6bf4..7625e2962e2b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -504,7 +504,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  }
>  
>  extern const struct arm64_cpu_capabilities arm64_errata[];
> -static void update_cpu_capabilities(u16 scope_mask);
> +static void __init setup_boot_cpu_capabilities(void);
>  
>  void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  {
> @@ -550,10 +550,10 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	}
>  
>  	/*
> -	 * Run the errata work around and local feature checks on the
> -	 * boot CPU, once we have initialised the cpu feature infrastructure.
> +	 * Detect and enable early CPU capabilities based on the boot CPU,
> +	 * after we have initialised the CPU feature infrastructure.
>  	 */
> -	update_cpu_capabilities(SCOPE_LOCAL_CPU);
> +	setup_boot_cpu_capabilities();
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -1277,12 +1277,21 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_m
>  
>  		if (caps->cpu_enable) {
>  			/*
> -			 * Use stop_machine() as it schedules the work allowing
> -			 * us to modify PSTATE, instead of on_each_cpu() which
> -			 * uses an IPI, giving us a PSTATE that disappears when
> -			 * we return.
> +			 * If we are dealing with a boot CPU capability, we
> +			 * have to enable this only on the Boot CPU, where it
> +			 * is detected. All the secondaries enable it via
> +			 * check_local_cpu_capabilities().

I found this confusing to read, because it's not 100% clear whether the
"If we are dealing with a boot CPU capability" applies to the second
sentence as well.

Maybe this would be clearer as:

"Capabilities with SCOPE_BOOT_CPU are finalised before any secondary
CPU boots.  Thus, each secondary will enable the capability as
appropriate via check_local_cpu_capabilities().  The only exception is
the boot CPU, for which the capability must be enabled here.  This
approach avoids costly stop_machine() calls for this case."

Thoughts?

> +			 *
> +			 * Otherwise, use stop_machine() as it schedules the
> +			 * work allowing us to modify PSTATE, instead of
> +			 * on_each_cpu() which uses an IPI, giving us a PSTATE
> +			 * that disappears when we return.
>  			 */
> -			stop_machine(__enable_cpu_capability, (void *)caps, cpu_online_mask);
> +			if (scope_mask & SCOPE_BOOT_CPU)
> +				caps->cpu_enable(caps);
> +			else
> +				stop_machine(__enable_cpu_capability,
> +					(void *)caps, cpu_online_mask);
>  		}
>  	}
>  }
> @@ -1362,6 +1371,12 @@ static void check_early_cpu_features(void)
>  {
>  	verify_cpu_run_el();
>  	verify_cpu_asid_bits();
> +	/*
> +	 * Early features are used by the kernel already. If there
> +	 * is a conflict, we cannot proceed further.
> +	 */
> +	if (!verify_local_cpu_caps(SCOPE_BOOT_CPU))
> +		cpu_panic_kernel();
>  }
>  
>  static void
> @@ -1403,9 +1418,8 @@ static void verify_sve_features(void)
>   */
>  static void verify_local_cpu_capabilities(void)
>  {

Nit: Maybe add a comment saying where SCOPE_BOOT_CPU capabilities are
checked.

> -	if (!verify_local_cpu_caps(SCOPE_ALL))
> +	if (!verify_local_cpu_caps(SCOPE_ALL & ~SCOPE_BOOT_CPU))
>  		cpu_die_early();
> -

Nit: keep blank line?

Otherwise it looks like the if() falls through, where really
cpu_die_early() does not return.

>  	verify_local_elf_hwcaps(arm64_elf_hwcaps);
>  
>  	if (system_supports_32bit_el0())
> @@ -1438,6 +1452,14 @@ void check_local_cpu_capabilities(void)
>  		verify_local_cpu_capabilities();
>  }
>  
> +static void __init setup_boot_cpu_capabilities(void)
> +{
> +	/* Detect capabilities with either SCOPE_BOOT_CPU or SCOPE_LOCAL_CPU */
> +	update_cpu_capabilities(SCOPE_BOOT_CPU | SCOPE_LOCAL_CPU);
> +	/* Enable the SCOPE_BOOT_CPU capabilities alone right away */
> +	enable_cpu_capabilities(SCOPE_BOOT_CPU);
> +}
> +
>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
>  EXPORT_SYMBOL(arm64_const_caps_ready);
>  
> @@ -1462,7 +1484,8 @@ static void __init setup_system_capabilities(void)
>  	 * on it. Also enable all the available capabilities.
>  	 */
>  	update_cpu_capabilities(SCOPE_SYSTEM);
> -	enable_cpu_capabilities(SCOPE_ALL);
> +	/* Enable all the available capabilities, which are not already enabled. */
> +	enable_cpu_capabilities(SCOPE_ALL & ~SCOPE_BOOT_CPU);
>  }
>  
>  void __init setup_cpu_features(void)
> -- 
> 2.14.3

With fair consideration given to the nits above:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
