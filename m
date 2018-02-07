Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeBGKiU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:38:20 -0500
Received: from foss.arm.com ([217.140.101.70]:48486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeBGKiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:38:18 -0500
Date: Wed, 7 Feb 2018 10:38:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        dave.martin@arm.com
Subject: Re: [PATCH v2 06/20] arm64: capabilities: Unify the verification
Message-ID: <20180207103813.GW5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-7-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-7-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:27:53PM +0000, Suzuki K Poulose wrote:
> Now that each capability describes how to treat the conflicts
> of CPU cap state vs System wide cap state, we can unify the
> verification logic to a single place.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  1 +
>  arch/arm64/kernel/cpufeature.c      | 89 +++++++++++++++++++++++--------------
>  2 files changed, 57 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1b29b3f0a1bc..5e4d581c97f1 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1233,6 +1233,56 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
>  	}
>  }
>  
> +/*
> + * Run through the list of capabilities to check for conflicts.
> + * If the system has already detected a capability, take necessary
> + * action on this CPU.
> + *
> + * Returns "false" on conflicts.
> + */
> +static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
> +{
> +	bool cpu_has_cap, system_has_cap;
> +	const struct arm64_cpu_capabilities *caps = caps_list;
> +
> +	for (; caps->matches; caps++) {
> +		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> +		system_has_cap =  cpus_have_cap(caps->capability);

Nit: Odd spacing?

[...]

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
