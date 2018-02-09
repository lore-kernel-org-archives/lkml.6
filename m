Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeBISLc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:11:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51350 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBISLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:11:30 -0500
Date: Fri, 9 Feb 2018 18:11:25 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 08/22] arm64: capabilities: Prepare for grouping
 features and errata work arounds
Message-ID: <20180209181125.GF5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-16-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:54:45PM +0000, Suzuki K Poulose wrote:
> We are about to group the handling of all capabilities (features
> and errata workarounds). This patch open codes the wrapper routines
> to make it easier to merge the handling.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

This seems to make sense as a no-functional-change bit of refactoring.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 60 +++++++++++++-----------------------------
>  1 file changed, 19 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 3447821bec5a..9f52678a4df1 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -504,7 +504,8 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  }
>  
>  extern const struct arm64_cpu_capabilities arm64_errata[];
> -static void update_cpu_errata_workarounds(void);
> +static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> +				    u16 scope_mask, const char *info);
>  
>  void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  {
> @@ -553,7 +554,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	 * Run the errata work around checks on the boot CPU, once we have
>  	 * initialised the cpu feature infrastructure.
>  	 */
> -	update_cpu_errata_workarounds();
> +	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
> +				"enabling workaround for");
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -1350,12 +1352,6 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
>  		}
>  }
>  
> -static void verify_local_cpu_features(void)
> -{
> -	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
> -		cpu_die_early();
> -}
> -
>  static void verify_sve_features(void)
>  {
>  	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
> @@ -1373,27 +1369,6 @@ static void verify_sve_features(void)
>  	/* Add checks on other ZCR bits here if necessary */
>  }
>  
> -/*
> - * The CPU Errata work arounds are detected and applied at boot time
> - * and the related information is freed soon after. If the new CPU requires
> - * an errata not detected at boot, fail this CPU.
> - */
> -static void verify_local_cpu_errata_workarounds(void)
> -{
> -	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
> -		cpu_die_early();
> -}
> -
> -static void update_cpu_errata_workarounds(void)
> -{
> -	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
> -				"enabling workaround for");
> -}
> -
> -static void __init enable_errata_workarounds(void)
> -{
> -	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
> -}
>  
>  /*
>   * Run through the enabled system capabilities and enable() it on this CPU.
> @@ -1405,8 +1380,15 @@ static void __init enable_errata_workarounds(void)
>   */
>  static void verify_local_cpu_capabilities(void)
>  {
> -	verify_local_cpu_errata_workarounds();
> -	verify_local_cpu_features();
> +	/*
> +	 * The CPU Errata work arounds are detected and applied at boot time
> +	 * and the related information is freed soon after. If the new CPU
> +	 * requires an errata not detected at boot, fail this CPU.
> +	 */
> +	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
> +		cpu_die_early();
> +	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
> +		cpu_die_early();
>  	verify_local_elf_hwcaps(arm64_elf_hwcaps);
>  
>  	if (system_supports_32bit_el0())
> @@ -1434,18 +1416,12 @@ void check_local_cpu_capabilities(void)
>  	 * advertised capabilities.
>  	 */
>  	if (!sys_caps_initialised)
> -		update_cpu_errata_workarounds();
> +		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
> +					"enabling workaround for");
>  	else
>  		verify_local_cpu_capabilities();
>  }
>  
> -static void __init setup_feature_capabilities(void)
> -{
> -	update_cpu_capabilities(arm64_features, SCOPE_ALL,
> -				"detected feature:");
> -	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
> -}
> -
>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
>  EXPORT_SYMBOL(arm64_const_caps_ready);
>  
> @@ -1468,8 +1444,10 @@ void __init setup_cpu_features(void)
>  	int cls;
>  
>  	/* Set the CPU feature capabilies */
> -	setup_feature_capabilities();
> -	enable_errata_workarounds();
> +	update_cpu_capabilities(arm64_features, SCOPE_ALL,
> +				"detected feature:");
> +	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
> +	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
>  	mark_const_caps_ready();
>  	setup_elf_hwcaps(arm64_elf_hwcaps);
>  
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
