Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeBGKjt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:39:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753927AbeBGKjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:39:47 -0500
Date: Wed, 7 Feb 2018 10:39:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 17/20] arm64: bp hardening: Allow late CPUs to enable
 work around
Message-ID: <20180207103942.GH5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-18-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-18-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:28:04PM +0000, Suzuki K Poulose wrote:
> We defend against branch predictor training based exploits by
> taking specific actions (based on the CPU model) to invalidate
> the Branch predictor buffer (BPB). This is implemented by per-CPU
> ptr, which installs the specific actions for the CPU model.
> 
> The core code can handle the following cases where:
>  1) some CPUs doesn't need any work around
>  2) a CPU can install the work around, when it is brought up,
>     irrespective of how late that happens.
> 
> This concludes that it is safe to bring up a CPU which requires
> bp hardening defense. However, with the current settings, we
> reject a late CPU, if none of the active CPUs didn't need it.

Should this be "[...] reject a late CPU that needs the defense, if none
of the active CPUs needed it." ?

> 
> This patch solves issue by changing the flags for the capability
> to indicate that it is safe for a late CPU to turn up with the
> capability. This is not sufficient to get things working, as
> we cannot change the system wide state of the capability established
> at the kernel boot. So, we "set" the capability unconditionally
> and make sure that the call backs are only installed for those
> CPUs which actually needs them. This is done by adding a dummy
> entry at the end of the list of shared entries, which :
>  a) Always returns true for matches, to ensure we turn this on.
>  b) has an empty "cpu_enable" call back, so that we don't take
>     any action on the CPUs which weren't matched with the real
>     entries.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
>  arch/arm64/kernel/cpu_errata.c      | 19 ++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b73247c27f00..262fa213b1b1 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -252,6 +252,16 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>  	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
>  	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
>  
> +/*
> + * CPU errata work around detected at boot time based on one or more CPUs.
> + * All conflicts are ignored. This implies any work around shouldn't
> + * depend when a CPU could be brought up.
> + */
> +#define ARM64_CPUCAP_WEAK_LOCAL_CPU_ERRATUM		\
> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
> +	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
> +	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
> +
>  /*
>   * CPU feature detected at boot time, on one or more CPUs. A late CPU
>   * is not allowed to have the capability when the system doesn't have it.
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index b4f1c1c1f8ca..7f714a628480 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -259,6 +259,12 @@ static const struct midr_range arm64_bp_harden_psci_cpus[] = {
>  	{},
>  };
>  
> +static bool bp_hardening_always_on(const struct arm64_cpu_capabilities *cap,
> +				   int scope)
> +{
> +	return true;
> +}
> +
>  static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
>  	{
>  		CAP_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
> @@ -268,6 +274,17 @@ static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
>  		CAP_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
>  		.cpu_enable = qcom_enable_link_stack_sanitization,
>  	},
> +	/*
> +	 * Always enable the capability to make sure a late CPU can
> +	 * safely use the BP hardening call backs. Since we use per-CPU
> +	 * pointers for the call backs, the work around only affects the
> +	 * CPUs which have some methods installed by any real matching entries
> +	 * above. As such we don't have any specific cpu_enable() callback
> +	 * for this entry, as it is just to make sure we always "detect" it.
> +	 */
> +	{
> +		.matches = bp_hardening_always_on,

This function could simply be called "always_on", since it expresses
something entirely generic and is static.

> +	},

This feels like a bit of a hack: really there is no global on/off
state for a cap like this: it's truly independent for each cpu.

OTOH, your code does achieve that, and the comment gives a good
explanation.

The alternative would be to add a cap type flag to indicate that
this cap is purely CPU-local, but it may not be worth it at this
stage.

[...]

Cheers
---Dave
