Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBISWT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:22:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeBISWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:22:18 -0500
Date: Fri, 9 Feb 2018 18:22:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 10/22] arm64: capabilities: Allow features based on
 local CPU scope
Message-ID: <20180209182213.GH5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-20-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-20-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:54:49PM +0000, Suzuki K Poulose wrote:
> So far we have treated the feature capabilities as system wide
> and this doesn't help with features that could be detected on

doesn't -> wouldn't (since no such features exist yet)

detected to "detected locally" (maybe)

> one or more CPUs (e.g, KPTI, Software prefetch). This patch
> splits the feature detection to two phases :
> 
>  1) Local CPU features are checked on all boot time active CPUs.
>  2) System wide features are checked only once after all CPUs are
>     active.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index a6e124063e21..45bac0c4ae91 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -551,11 +551,13 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	}
>  
>  	/*
> -	 * Run the errata work around checks on the boot CPU, once we have
> -	 * initialised the cpu feature infrastructure.
> +	 * Run the errata work around and local feature checks on the
> +	 * boot CPU, once we have initialised the cpu feature infrastructure.
>  	 */
>  	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
>  				"enabling workaround for");
> +	update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
> +				"detected feature:");
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -1411,15 +1413,18 @@ void check_local_cpu_capabilities(void)
>  
>  	/*
>  	 * If we haven't finalised the system capabilities, this CPU gets
> -	 * a chance to update the errata work arounds.
> +	 * a chance to update the errata work arounds and local features.
>  	 * Otherwise, this CPU should verify that it has all the system
>  	 * advertised capabilities.
>  	 */
> -	if (!sys_caps_initialised)
> +	if (!sys_caps_initialised) {
>  		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
>  					"enabling workaround for");
> -	else
> +		update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
> +					"detected feature:");
> +	} else {
>  		verify_local_cpu_capabilities();
> +	}
>  }
>  
>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
> @@ -1444,7 +1449,7 @@ void __init setup_cpu_features(void)
>  	int cls;
>  
>  	/* Set the CPU feature capabilies */
> -	update_cpu_capabilities(arm64_features, SCOPE_ALL,
> +	update_cpu_capabilities(arm64_features, SCOPE_SYSTEM,
>  				"detected feature:");
>  	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
>  				"enabling workaround for");
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
