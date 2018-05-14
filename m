Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeENKFY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:05:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeENKFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:05:23 -0400
Date: Mon, 14 May 2018 11:05:18 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] arm64: kill config_sctlr_el1()
Message-ID: <20180514100517.GZ7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-5-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:26AM +0100, Mark Rutland wrote:
> Now that we have sysreg_clear_set(), we can consistently use this
> instead of config_sctlr_el1().
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/sysreg.h      | 10 ----------
>  arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
>  arch/arm64/kernel/cpu_errata.c       |  3 +--
>  arch/arm64/kernel/traps.c            |  2 +-
>  arch/arm64/mm/fault.c                |  2 +-
>  5 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index b52762769329..3493c7048994 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -740,16 +740,6 @@ asm(
>  		write_sysreg(__scs_new, sysreg);			\
>  } while (0)
>  
> -static inline void config_sctlr_el1(u32 clear, u32 set)
> -{
> -	u32 val;
> -
> -	val = read_sysreg(sctlr_el1);
> -	val &= ~clear;
> -	val |= set;
> -	write_sysreg(val, sctlr_el1);
> -}
> -
>  #endif
>  
>  #endif	/* __ASM_SYSREG_H */
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 6e47fc3ab549..778cf810f0d8 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -512,9 +512,9 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>  static int cp15_barrier_set_hw_mode(bool enable)
>  {
>  	if (enable)
> -		config_sctlr_el1(0, SCTLR_EL1_CP15BEN);
> +		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_CP15BEN);
>  	else
> -		config_sctlr_el1(SCTLR_EL1_CP15BEN, 0);
> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_CP15BEN, 0);
>  	return 0;
>  }
>  
> @@ -549,9 +549,9 @@ static int setend_set_hw_mode(bool enable)
>  		return -EINVAL;
>  
>  	if (enable)
> -		config_sctlr_el1(SCTLR_EL1_SED, 0);
> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_SED, 0);
>  	else
> -		config_sctlr_el1(0, SCTLR_EL1_SED);
> +		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_SED);
>  	return 0;
>  }
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index a900befadfe8..879daf8ea0f8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -74,8 +74,7 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
>  static void
>  cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
>  {
> -	/* Clear SCTLR_EL1.UCT */
> -	config_sctlr_el1(SCTLR_EL1_UCT, 0);
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
>  }
>  
>  atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 8bbdc17e49df..b8d3e0d8c616 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -411,7 +411,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>  
>  void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>  {
> -	config_sctlr_el1(SCTLR_EL1_UCI, 0);
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCI, 0);
>  }
>  
>  #define __user_cache_maint(insn, address, res)			\
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 4165485e8b6e..e7977d932038 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -812,7 +812,7 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>  	 */
>  	WARN_ON_ONCE(in_interrupt());
>  
> -	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
>  	asm(SET_PSTATE_PAN(1));
>  }
>  #endif /* CONFIG_ARM64_PAN */
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
