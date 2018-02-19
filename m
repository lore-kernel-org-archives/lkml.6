Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeBSOnj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:43:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbeBSOni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:43:38 -0500
Date: Mon, 19 Feb 2018 14:43:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH] arm64: Add support for new control bits CTR_EL0.IDC and
 CTR_EL0.IDC
Message-ID: <20180219144346.GF30394@arm.com>
References: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

On Fri, Feb 16, 2018 at 06:57:46PM -0600, Shanker Donthineni wrote:
> Two point of unification cache maintenance operations 'DC CVAU' and
> 'IC IVAU' are optional for implementors as per ARMv8 specification.
> This patch parses the updated CTR_EL0 register definition and adds
> the required changes to skip POU operations if the hardware reports
> CTR_EL0.IDC and/or CTR_EL0.IDC.
> 
> CTR_EL0.DIC: Instruction cache invalidation requirements for
>  instruction to data coherence. The meaning of this bit[29].
>   0: Instruction cache invalidation to the point of unification
>      is required for instruction to data coherence.
>   1: Instruction cache cleaning to the point of unification is
>       not required for instruction to data coherence.
> 
> CTR_EL0.IDC: Data cache clean requirements for instruction to data
>  coherence. The meaning of this bit[28].
>   0: Data cache clean to the point of unification is required for
>      instruction to data coherence, unless CLIDR_EL1.LoC == 0b000
>      or (CLIDR_EL1.LoUIS == 0b000 && CLIDR_EL1.LoUU == 0b000).
>   1: Data cache clean to the point of unification is not required
>      for instruction to data coherence.
> 
> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  arch/arm64/include/asm/assembler.h | 48 ++++++++++++++++++++++++--------------
>  arch/arm64/include/asm/cache.h     |  2 ++
>  arch/arm64/kernel/cpufeature.c     |  2 ++
>  arch/arm64/mm/cache.S              | 26 ++++++++++++++-------
>  4 files changed, 51 insertions(+), 27 deletions(-)

I was looking at our CTR_EL0 code last week but forgot to post the patch I
wrote fixing up some of the fields. I just send it now, so please can
you rebase on top of:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/560488.html

Also:

> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index ea9bb4e..aea533b 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -22,6 +22,8 @@
>  #define CTR_L1IP_MASK		3
>  #define CTR_CWG_SHIFT		24
>  #define CTR_CWG_MASK		15
> +#define CTR_IDC_SHIFT		28
> +#define CTR_DIC_SHIFT		29
>  
>  #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 29b1f87..f42bb5a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -200,6 +200,8 @@ static int __init register_cpu_hwcaps_dumper(void)
>  
>  static const struct arm64_ftr_bits ftr_ctr[] = {
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_DIC_SHIFT, 1, 0),	/* DIC */
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IDC_SHIFT, 1, 0),	/* IDC */
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */

Could you update the other table entries here to use the CTR_*_SHIFT values
as well?

Thanks,

Will
