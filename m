Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeBGKi2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:38:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeBGKi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:38:26 -0500
Date: Wed, 7 Feb 2018 10:38:22 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 07/20] arm64: capabilities: Filter the entries based
 on a given mask
Message-ID: <20180207103821.GX5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-8-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:27:54PM +0000, Suzuki K Poulose wrote:
> While processing the list of capabilities, it is useful to
> filter out some of the entries based on the given mask for the
> scope of the capabilities to allow better control. This can be
> used later for handling LOCAL vs SYSTEM wide capabilities and more.
> All capabilities should have their scope set to either LOCAL_CPU or
> SYSTEM. No functional/flow change.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 35 ++++++++++++++++++++++++-----------
>  2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 69b5ce366598..cda62b70d338 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -198,6 +198,8 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>  /* Is it safe for a late CPU to miss this capability when system has it */
>  #define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
>  
> +#define ARM64_CPUCAP_SCOPE_ALL			 \
> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SCOPE_SYSTEM)

Perhaps we could just use _MASK rather than having a separate #define,
but it's good either way.

Is there a situation in which _ALL and _MASK would need to be
different?

>  /*
>   * CPU errata detected at boot time based on feature of one or more CPUs.
>   * It is not safe for a late CPU to have this feature when the system doesn't
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 5e4d581c97f1..5163dc51b975 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1185,10 +1185,12 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
>  }
>  
>  static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> -			    const char *info)
> +				    u16 scope_mask, const char *info)
>  {
> +	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>  	for (; caps->matches; caps++) {
> -		if (!caps->matches(caps, cpucap_default_scope(caps)))
> +		if (!(caps->type & scope_mask) ||
> +		    !caps->matches(caps, cpucap_default_scope(caps)))
>  			continue;
>  
>  		if (!cpus_have_cap(caps->capability) && caps->desc)
> @@ -1210,12 +1212,14 @@ static int __enable_cpu_capability(void *arg)
>   * Run through the enabled capabilities and enable() it on all active
>   * CPUs
>   */
> -static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
> +static void __init
> +enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
>  {
> +	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>  	for (; caps->matches; caps++) {
>  		unsigned int num = caps->capability;
>  
> -		if (!cpus_have_cap(num))
> +		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
>  			continue;
>  
>  		/* Ensure cpus_have_const_cap(num) works */
> @@ -1240,12 +1244,18 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
>   *
>   * Returns "false" on conflicts.
>   */
> -static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
> +static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
> +				    u16 scope_mask)
>  {
>  	bool cpu_has_cap, system_has_cap;
>  	const struct arm64_cpu_capabilities *caps = caps_list;
>  
> +	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>  	for (; caps->matches; caps++) {
> +

Nit: extra blank line?

[...]

With that fixed,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
