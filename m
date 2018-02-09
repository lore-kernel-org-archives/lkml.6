Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBISSk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:18:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBISSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:18:39 -0500
Date: Fri, 9 Feb 2018 18:18:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 09/22] arm64: capabilities: Split the processing of
 errata work arounds
Message-ID: <20180209181834.GG5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-19-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-19-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:54:48PM +0000, Suzuki K Poulose wrote:
> Right now we run through the errata workarounds check on all boot
> active CPUs, with SCOPE_ALL. This doesn't help with detecting the
> errata's with a SYSTEM_SCOPE. While nobody uses it, let us clean
> this up in preparation for merging capability handling.

errata; and SCOPE_SYSTEM (if I'm being pedantic)

To make it clearer this this is adding support for new behaviour rather
than changing old behaviour, perhaps change "This doesn't help ...
While nobody uses it ..." to something like:

"This wouldn't help for detecting erratum workarounds with SCOPE_SYSTEM.
There are none yet, but we plan to introduce some: let us clean this up
so that such workarounds can be detected and enabled correctly."

> 
> So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
> checks are run only once after all the boot time CPUs are active.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9f52678a4df1..a6e124063e21 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -554,7 +554,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	 * Run the errata work around checks on the boot CPU, once we have
>  	 * initialised the cpu feature infrastructure.
>  	 */
> -	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
> +	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
>  				"enabling workaround for");
>  }
>  
> @@ -1416,7 +1416,7 @@ void check_local_cpu_capabilities(void)
>  	 * advertised capabilities.
>  	 */
>  	if (!sys_caps_initialised)
> -		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
> +		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
>  					"enabling workaround for");
>  	else
>  		verify_local_cpu_capabilities();
> @@ -1446,6 +1446,8 @@ void __init setup_cpu_features(void)
>  	/* Set the CPU feature capabilies */
>  	update_cpu_capabilities(arm64_features, SCOPE_ALL,
>  				"detected feature:");
> +	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
> +				"enabling workaround for");
>  	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
>  	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
>  	mark_const_caps_ready();
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
