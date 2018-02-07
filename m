Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeBGKjS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:39:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbeBGKjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:39:16 -0500
Date: Wed, 7 Feb 2018 10:39:11 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 13/20] arm64: capabilities: Clean up midr range helpers
Message-ID: <20180207103911.GD5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-14-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-14-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:28:00PM +0000, Suzuki K Poulose wrote:
> We are about to introduce generic MIDR range helpers. Clean
> up the existing helpers in erratum handling, preparing them
> to use generic version.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 100 +++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 22ec3960a0c5..4351d48b0b0f 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -174,20 +174,35 @@ static void qcom_enable_link_stack_sanitization(
>  }
>  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
> -#define MIDR_RANGE(model, min, max) \
> -	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
> -	.matches = is_affected_midr_range, \
> -	.midr_model = model, \
> -	.midr_range_min = min, \
> -	.midr_range_max = max
> +#define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
> +	.matches = is_affected_midr_range,			\
> +	.midr_model = model,					\
> +	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
> +	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
>  
> -#define MIDR_ALL_VERSIONS(model) \
> -	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
> -	.matches = is_affected_midr_range, \
> -	.midr_model = model, \
> -	.midr_range_min = 0, \
> +#define CAP_MIDR_ALL_VERSIONS(model)					\
> +	.matches = is_affected_midr_range,				\
> +	.midr_model = model,						\
> +	.midr_range_min = MIDR_CPU_VAR_REV(0, 0),			\
>  	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
>  
> +#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
> +	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
> +
> +/* Errata affecting a range of revisions of  given model variant */
> +#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
> +	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
> +
> +/* Errata affecting a single variant/revision of a model */
> +#define ERRATA_MIDR_REV(model, var, rev)	\
> +	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
> +
> +/* Errata affecting all variants/revisions of a given a model */
> +#define ERRATA_MIDR_ALL_VERSIONS(model)				\
> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
> +	CAP_MIDR_ALL_VERSIONS(model)
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
>  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> @@ -196,7 +211,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	/* Cortex-A53 r0p[012] */
>  		.desc = "ARM errata 826319, 827319, 824069",
>  		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
> -		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
> +		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x2),

Nit: since you're mostly ommiting the redundant 0x0* prefixes in new
ERRATA_MIDR_RANGE(), maybe it's worth getting rid of all of them.
Not a big deal though.

The prefixes are a bit random prior to this patch (0x00 versus 0x0
etc.)

[...]

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
