Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeBGKhx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:37:53 -0500
Received: from foss.arm.com ([217.140.101.70]:48414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753613AbeBGKhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:37:51 -0500
Date: Wed, 7 Feb 2018 10:37:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 03/20] arm64: capabilities: Move errata processing code
Message-ID: <20180207103746.GT5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-4-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:27:50PM +0000, Suzuki K Poulose wrote:
> We have errata work around processing code in cpu_errata.c,
> which calls back into helpers defined in cpufeature.c. Now
> that we are going to make the handling of capabilities
> generic, by adding the information to each capability,
> move the errata work around specific processing code.
> No functional changes.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/cpufeature.h |  7 -------
>  arch/arm64/kernel/cpu_errata.c      | 33 ------------------------------
>  arch/arm64/kernel/cpufeature.c      | 40 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index f46eb7d1625f..7925e40c6ded 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -238,15 +238,8 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
>  }
>  
>  void __init setup_cpu_features(void);
> -
> -void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> -			    const char *info);
> -void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
>  void check_local_cpu_capabilities(void);
>  
> -void update_cpu_errata_workarounds(void);
> -void __init enable_errata_workarounds(void);
> -void verify_local_cpu_errata_workarounds(void);
>  
>  u64 read_sanitised_ftr_reg(u32 id);
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index e34bee500692..9de0ee5d73c0 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -366,36 +366,3 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	{
>  	}
>  };
> -
> -/*
> - * The CPU Errata work arounds are detected and applied at boot time
> - * and the related information is freed soon after. If the new CPU requires
> - * an errata not detected at boot, fail this CPU.
> - */
> -void verify_local_cpu_errata_workarounds(void)
> -{
> -	const struct arm64_cpu_capabilities *caps = arm64_errata;
> -
> -	for (; caps->matches; caps++) {
> -		if (cpus_have_cap(caps->capability)) {
> -			if (caps->cpu_enable)
> -				caps->cpu_enable(caps);
> -		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
> -			pr_crit("CPU%d: Requires work around for %s, not detected"
> -					" at boot time\n",
> -				smp_processor_id(),
> -				caps->desc ? : "an erratum");
> -			cpu_die_early();
> -		}
> -	}
> -}
> -
> -void update_cpu_errata_workarounds(void)
> -{
> -	update_cpu_capabilities(arm64_errata, "enabling workaround for");
> -}
> -
> -void __init enable_errata_workarounds(void)
> -{
> -	enable_cpu_capabilities(arm64_errata);
> -}
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ef3cc48bc925..f0cd165c75e9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -503,6 +503,9 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  	reg->user_mask = user_mask;
>  }
>  
> +extern const struct arm64_cpu_capabilities arm64_errata[];
> +static void update_cpu_errata_workarounds(void);
> +
>  void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  {
>  	/* Before we start using the tables, make sure it is sorted */
> @@ -1181,7 +1184,7 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
>  	return false;
>  }
>  
> -void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> +static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  			    const char *info)
>  {
>  	for (; caps->matches; caps++) {
> @@ -1207,7 +1210,7 @@ static int __enable_cpu_capability(void *arg)
>   * Run through the enabled capabilities and enable() it on all active
>   * CPUs
>   */
> -void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
> +static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>  {
>  	for (; caps->matches; caps++) {
>  		unsigned int num = caps->capability;
> @@ -1290,6 +1293,39 @@ static void verify_sve_features(void)
>  	/* Add checks on other ZCR bits here if necessary */
>  }
>  
> +/*
> + * The CPU Errata work arounds are detected and applied at boot time
> + * and the related information is freed soon after. If the new CPU requires
> + * an errata not detected at boot, fail this CPU.
> + */
> +static void verify_local_cpu_errata_workarounds(void)
> +{
> +	const struct arm64_cpu_capabilities *caps = arm64_errata;
> +
> +	for (; caps->matches; caps++) {
> +		if (cpus_have_cap(caps->capability)) {
> +			if (caps->cpu_enable)
> +				caps->cpu_enable(caps);
> +		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
> +			pr_crit("CPU%d: Requires work around for %s, not detected"
> +					" at boot time\n",
> +				smp_processor_id(),
> +				caps->desc ? : "an erratum");
> +			cpu_die_early();
> +		}
> +	}
> +}
> +
> +static void update_cpu_errata_workarounds(void)
> +{
> +	update_cpu_capabilities(arm64_errata, "enabling workaround for");
> +}
> +
> +static void __init enable_errata_workarounds(void)
> +{
> +	enable_cpu_capabilities(arm64_errata);
> +}
> +
>  /*
>   * Run through the enabled system capabilities and enable() it on this CPU.
>   * The capabilities were decided based on the available CPUs at the boot time.
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
