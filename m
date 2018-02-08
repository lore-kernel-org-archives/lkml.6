Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBHQKV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:10:21 -0500
Received: from foss.arm.com ([217.140.101.70]:37012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeBHQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:10:20 -0500
Date: Thu, 8 Feb 2018 16:10:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: capabilities: Allow flexibility in scope
Message-ID: <20180208161015.GZ5862@e103592.cambridge.arm.com>
References: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
 <20180208121238.18792-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208121238.18792-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:12:37PM +0000, Suzuki K Poulose wrote:
> So far we have restricted the scopes for the capabilities
> as follows :
>  1) Errata workaround check are run all CPUs (i.e, always
>     SCOPE_LOCAL_CPU)
>  2) Arm64 features are run only once after the sanitised
>     feature registers are available using the SCOPE_SYSTEM.
> 
> This prevents detecting cpu features that can be detected
> on one or more CPUs with SCOPE_LOCAL_CPU (e.g KPTI). Similarly
> for errata workaround with SCOPE_SYSTEM.
> 
> This patch makes sure that we allow flexibility of having
> any scope for a capability. So, we now run through both
> arm64_features and arm64_errata in two phases for detection:
> 
>  a) with SCOPE_LOCAL_CPU filter on each boot time enabled
>     CPUs.
>  b) with SCOPE_SYSTEM filter only once after all boot time
>     enabled CPUs are active.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 61d4c3cfb1cc..e1a56fa889a5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -505,6 +505,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  
>  extern const struct arm64_cpu_capabilities arm64_errata[];
>  static void update_cpu_errata_workarounds(void);
> +static void update_cpu_local_features(void);
>  
>  void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  {
> @@ -554,6 +555,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	 * initialised the cpu feature infrastructure.
>  	 */
>  	update_cpu_errata_workarounds();
> +	update_cpu_local_features();
>  }
>  
>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -1387,13 +1389,15 @@ static void verify_local_cpu_errata_workarounds(void)
>  static void update_cpu_errata_workarounds(void)
>  {
>  	update_cpu_capabilities(arm64_errata,
> -				ARM64_CPUCAP_SCOPE_ALL,
> +				ARM64_CPUCAP_SCOPE_LOCAL_CPU,

In isolation, this looks strange because it seems to handle only a
subset of arm64_errata now.

I think I understand the change as follows:

 * all previously-existing errata workarounds SCOPE_LOCAL_CPU
   anyway, so the behavior here doesn't change for any existing
   caps;

 * the non SCOPE_SYSTEM workarounds (which this patch prepares for)
   are handled by the new setup_errata_workaround() path.

Similarly, the features handling is split into two: one mirroring
the current behaviour (for SCOPE_SYSTEM this time) and one handling
the rest, for supporting SCOPE_CPU_LOCAL features in subsequent
patches.

Does that sound right?

I'm not sure we need extra comments or documentation; I just want
to check that I've understood the patch correctly.

Cheers
---Dave

>  				"enabling workaround for");
>  }
>  
> -static void __init enable_errata_workarounds(void)
> +static void update_cpu_local_features(void)
>  {
> -	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
> +	update_cpu_capabilities(arm64_features,
> +				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
> +				"detected feature:");
>  }
>  
>  /*
> @@ -1430,23 +1434,34 @@ void check_local_cpu_capabilities(void)
>  
>  	/*
>  	 * If we haven't finalised the system capabilities, this CPU gets
> -	 * a chance to update the errata work arounds.
> +	 * a chance to update the errata work arounds and local CPU features.
>  	 * Otherwise, this CPU should verify that it has all the system
>  	 * advertised capabilities.
>  	 */
> -	if (!sys_caps_initialised)
> +	if (!sys_caps_initialised) {
>  		update_cpu_errata_workarounds();
> -	else
> +		update_cpu_local_features();
> +	} else {
>  		verify_local_cpu_capabilities();
> +	}
>  }
>  
>  static void __init setup_feature_capabilities(void)
>  {
>  	update_cpu_capabilities(arm64_features,
> -				ARM64_CPUCAP_SCOPE_ALL, "detected feature:");
> +				ARM64_CPUCAP_SCOPE_SYSTEM,
> +				"detected feature:");
>  	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_SCOPE_ALL);
>  }
>  
> +static void __init setup_errata_workarounds(void)
> +{
> +	update_cpu_capabilities(arm64_errata,
> +				ARM64_CPUCAP_SCOPE_SYSTEM,
> +				"enabling workaround for");
> +	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
> +}
> +
>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
>  EXPORT_SYMBOL(arm64_const_caps_ready);
>  
> @@ -1468,9 +1483,9 @@ void __init setup_cpu_features(void)
>  	u32 cwg;
>  	int cls;
>  
> -	/* Set the CPU feature capabilies */
> +	/* Finalise the CPU capabilities */
>  	setup_feature_capabilities();
> -	enable_errata_workarounds();
> +	setup_errata_workarounds();
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
