Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeBIS6q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:58:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeBIS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:58:45 -0500
Date: Fri, 9 Feb 2018 18:58:41 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 21/22] arm64: Delay enabling hardware DBM feature
Message-ID: <20180209185840.GJ5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-43-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209175513.17100-43-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:55:12PM +0000, Suzuki K Poulose wrote:
> We enable hardware DBM bit in a capable CPU, very early in the
> boot via __cpu_setup. This doesn't give us a flexibility of
> optionally disable the feature, as the clearing the bit
> is a bit costly as the TLB can cache the settings. Instead,
> we delay enabling the feature until the CPU is brought up
> into the kernel. We use the feature capability mechanism
> to handle it.
> 
> The hardware DBM is a non-conflicting feature. i.e, the kernel
> can safely run with a mix of CPUs with some using the feature
> and the others don't. So, it is safe for a late CPU to have
> this capability and enable it, even if the active CPUs don't.
> 
> To get this handled properly by the infrastructure, we
> unconditionally set the capability and only enable it
> on CPUs which really have the feature. Also, we print the
> feature detection from the "matches" call back to make sure
> we don't mislead the user when none of the CPUs could use the
> feature.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2
>  - Print the feature detection message only when at least one CPU
>    is actually using it.
> ---
>  arch/arm64/include/asm/cpucaps.h |  3 +-
>  arch/arm64/kernel/cpufeature.c   | 71 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/proc.S             | 13 ++++----
>  3 files changed, 79 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bb263820de13..8df80cc828ac 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -45,7 +45,8 @@
>  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
>  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
>  #define ARM64_HAS_RAS_EXTN			26
> +#define ARM64_HW_DBM				27
>  
> -#define ARM64_NCAPS				27
> +#define ARM64_NCAPS				28
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d8663822c604..a96a1f94f427 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -939,6 +939,57 @@ static int __init parse_kpti(char *str)
>  __setup("kpti=", parse_kpti);
>  #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +static inline void __cpu_enable_hw_dbm(void)
> +{
> +	u64 tcr = read_sysreg(tcr_el1) | TCR_HD;
> +
> +	write_sysreg(tcr, tcr_el1);
> +	isb();
> +}
> +
> +static bool cpu_can_use_dbm(const struct arm64_cpu_capabilities *cap)
> +{
> +	return has_cpuid_feature(cap, SCOPE_LOCAL_CPU);
> +}
> +
> +static void cpu_enable_hw_dbm(struct arm64_cpu_capabilities const *cap)
> +{
> +	if (cpu_can_use_dbm(cap))
> +		__cpu_enable_hw_dbm();
> +}
> +
> +static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
> +		       int __unused)
> +{
> +	static bool detected = false;
> +	/*
> +	 * DBM is a non-conflicting feature. i.e, the kernel can safely
> +	 * run a mix of CPUs with and without the feature. So, we
> +	 * unconditionally enable the capability to allow any late CPU
> +	 * to use the feature. We only enable the control bits on the
> +	 * CPU, if it actually supports.
> +	 *
> +	 * We have to make sure we print the "feature" detection only
> +	 * when at least one CPU actually uses it. So check if this CPU
> +	 * can actually use it and print the message exactly once.
> +	 *
> +	 * This is safe as all CPUs (including secondary CPUs - due to the
> +	 * LOCAL_CPU scope - and the hotplugged CPUs - via verification)
> +	 * goes through the "matches" check exactly once. Also if a CPU
> +	 * matches the criteria, it is guaranteed that the CPU will turn
> +	 * the DBM on, as the capability is unconditionally enabled.
> +	 */
> +	if (!detected && cpu_can_use_dbm(cap)) {
> +		detected = true;
> +		pr_info("detected feature: Hardware dirty bit management\n");
> +	}

Can we just do

	if (cpu_can_use_dbm(cap))
		pr_info_once(...);

Then we can get rid of "detected".

[...]

Cheers
---Dave
