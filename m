Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeBGKhn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:37:43 -0500
Received: from foss.arm.com ([217.140.101.70]:48386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbeBGKhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:37:42 -0500
Date: Wed, 7 Feb 2018 10:37:37 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 02/20] arm64: capabilities: Move errata work around
 check on boot CPU
Message-ID: <20180207103737.GS5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:27:49PM +0000, Suzuki K Poulose wrote:
> We trigger CPU errata work around check on the boot CPU from
> smp_prepare_boot_cpu() to make sure that we run the checks only
> after the CPU feature infrastructure is initialised. While this
> is correct, we can also do this from init_cpu_features() which
> initilisation of the infrastructure, and is called only on the

Typo or missing words here?

Should this be "which initialises the infrastructure" or "which is
called to initialise the infrastructure"?

With that (or any suitable rewording):

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> Boot CPU. This helps to consolidate the CPU capability handling
> to cpufeature.c. No functional changes.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 6 ++++++
>  arch/arm64/kernel/smp.c        | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0b881d9fcde2..ef3cc48bc925 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -545,6 +545,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
>  		sve_init_vq_map();
>  	}
> +
> +	/*
> +	 * Run the errata work around checks on the boot CPU, once we have
> +	 * initialised the cpu feature infrastructure.
> +	 */
> +	update_cpu_errata_workarounds();
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3b8ad7be9c33..5cef11450183 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -448,12 +448,6 @@ void __init smp_prepare_boot_cpu(void)
>  	jump_label_init();
>  	cpuinfo_store_boot_cpu();
>  	save_boot_cpu_run_el();
> -	/*
> -	 * Run the errata work around checks on the boot CPU, once we have
> -	 * initialised the cpu feature infrastructure from
> -	 * cpuinfo_store_boot_cpu() above.
> -	 */
> -	update_cpu_errata_workarounds();
>  }
>  
>  static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
