Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeENKA7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:00:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeENKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:00:58 -0400
Date: Mon, 14 May 2018 11:00:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
Message-ID: <20180514100053.GX7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-3-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:24AM +0100, Mark Rutland wrote:
> Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
> self-consistent with an assertion in config_sctlr_el1(). This is a bit
> unusual, since config_sctlr_el1() doesn't make use of these definitions,
> and is far away from the definitions themselves.
> 
> We can use the CPP #error directive to have equivalent assertions in
> <asm/sysreg.h>, next to the definitions of the set/clear bits, which is
> a bit clearer and simpler.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6171178075dc..bd1d1194a5e7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -452,9 +452,9 @@
>  			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
>  			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
>  
> -/* Check all the bits are accounted for */
> -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
> -
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
> +#error "Inconsistent SCTLR_EL2 set/clear bits"
> +#endif

Can we have a comment on the != 0xffffffff versus != ~0 here?

The subtle differences in evaluation semantics between #if and
other contexts here may well trip people up during maintenance...


With that, Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

>  
>  /* SCTLR_EL1 specific flags. */
>  #define SCTLR_EL1_UCI		(1 << 26)
> @@ -492,8 +492,9 @@
>  			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
>  			 SCTLR_EL1_RES0)
>  
> -/* Check all the bits are accounted for */
> -#define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
> +#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffff
> +#error "Inconsistent SCTLR_EL1 set/clear bits"
> +#endif
>  
>  /* id_aa64isar0 */
>  #define ID_AA64ISAR0_TS_SHIFT		52
> @@ -732,9 +733,6 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
>  {
>  	u32 val;
>  
> -	SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS;
> -	SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS;
> -
>  	val = read_sysreg(sctlr_el1);
>  	val &= ~clear;
>  	val |= set;
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
