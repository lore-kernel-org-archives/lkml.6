Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeBGPJL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:09:11 -0500
Received: from foss.arm.com ([217.140.101.70]:51988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeBGPJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:09:10 -0500
Date: Wed, 7 Feb 2018 15:09:06 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH v2 1/2] arm64: Relax constraints on ID feature bits
Message-ID: <20180207150906.GQ5862@e103592.cambridge.arm.com>
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207142106.10716-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:21:05PM +0000, Suzuki K Poulose wrote:
> We treat most of the feature bits in the ID registers as STRICT,
> implying that all CPUs should match it the boot CPU state. However,
> for most of the features, we can handle if there are any mismatches
> by using the safe value. e.g, HWCAPs and other features used by the
> kernel. Relax the constraint on the feature bits whose mismatch can
> be handled by the kernel.
> 
> For VHE, if there is a mismatch we don't care if the kernel is
> not using it. If the kernel is indeed running in EL2 mode, then
> the mismatches results in a panic. Similarly for ASID bits we
> take care of conflicts.
> 
> For other features like, PAN, UAO we only enable it only if we
> have it on all the CPUs. For IESB, we set the SCTLR bit unconditionally
> anyways.
> 
> For features that aren't currently used by kernel
>  (e.g ID_AA64MFMR1:{LOR,HPD}, ID_AA64MMFR2:LSM) make them NONSTRICT.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>  - Make ID_AA64MMFR1_EL1:LOR/HPD, ID_AA64MMFR1_EL1:LSM non-strict
>    as they aren't used by the kernel.
>  - Added comments around different fields.
>  - Make ID_AA64MMFR2:CNP non-strict, as we could decide to use it
>    only when it is available on all the CPUs.
> ---
>  arch/arm64/kernel/cpufeature.c | 83 ++++++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c

[...]

> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
> +	/*
> +	 * We handle differing ASID widths by explicit checks to make sure the system is
> +	 * safe via verify_cpu_asid_bits()

I guess that's sufficient.

Although I had suggested adding a comment to verify_cpu_asid_bits()
cross-referencing back to here, it now seems superfluous.  It's fairly
obvious what that function is supported to do.


[...]

> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),

[...]

> +	/*
> +	 * When CONFIG_ARM64_VHE is enabled, we ensure that there is no conflict in run
> +	 * levels via verify_cpu_run_el()
> +	 */
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),

Similarly ack.


[...]

> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),

[...]

> +	/*
> +	 * Lacking implicit ESB on exception boundaries on a subset of CPUs is no worse than
> +	 * lacking it on all of them.
> +	 */
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),

And again.  Thanks.

[...]

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
