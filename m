Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D5C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1A120869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfA3SFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:05:12 -0500
Received: from foss.arm.com ([217.140.101.70]:59286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfA3SFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:05:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A17C15AD;
        Wed, 30 Jan 2019 10:05:10 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F403F3F7D7;
        Wed, 30 Jan 2019 10:05:07 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:05:04 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 05/12] arm64: remove the ability to build a kernel
 without kpti
Message-ID: <20190130180504.78a7e274@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-6-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-6-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:04 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> Buried behind EXPERT is the ability to build a kernel without
> hardened branch predictors, this needlessly clutters up the
> code as well as creates the opportunity for bugs. It also
> removes the kernel's ability to determine if the machine its
> running on is vulnerable.
> 
> Since its also possible to disable it at boot time, lets remove
> the config option.

Same comment as for the other two before: Disabling at boot time is not
the same as not configuring.

Otherwise looks good to me.

Cheers,
Andre.

> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/Kconfig              | 12 ------------
>  arch/arm64/include/asm/fixmap.h |  2 --
>  arch/arm64/include/asm/mmu.h    |  7 +------
>  arch/arm64/include/asm/sdei.h   |  2 +-
>  arch/arm64/kernel/asm-offsets.c |  2 --
>  arch/arm64/kernel/cpufeature.c  |  4 ----
>  arch/arm64/kernel/entry.S       | 11 +----------
>  arch/arm64/kernel/sdei.c        |  2 --
>  arch/arm64/kernel/vmlinux.lds.S |  8 --------
>  arch/arm64/mm/context.c         |  6 ------
>  arch/arm64/mm/mmu.c             |  2 --
>  arch/arm64/mm/proc.S            |  2 --
>  12 files changed, 3 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6b4c6d3fdf4d..09a85410d814 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -993,18 +993,6 @@ config FORCE_MAX_ZONEORDER
>  	  However for 4K, we choose a higher default value, 11 as
> opposed to 10, giving us 4M allocations matching the default size
> used by generic code. 
> -config UNMAP_KERNEL_AT_EL0
> -	bool "Unmap kernel when running in userspace (aka
> \"KAISER\")" if EXPERT
> -	default y
> -	help
> -	  Speculation attacks against some high-performance
> processors can
> -	  be used to bypass MMU permission checks and leak kernel
> data to
> -	  userspace. This can be defended against by unmapping the
> kernel
> -	  when running in userspace, mapping it back in on exception
> entry
> -	  via a trampoline page in the vector table.
> -
> -	  If unsure, say Y.
> -
>  config HARDEN_EL2_VECTORS
>  	bool "Harden EL2 vector mapping against system register
> leak" if EXPERT default y
> diff --git a/arch/arm64/include/asm/fixmap.h
> b/arch/arm64/include/asm/fixmap.h index ec1e6d6fa14c..62371f07d4ce
> 100644 --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -58,11 +58,9 @@ enum fixed_addresses {
>  	FIX_APEI_GHES_NMI,
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	FIX_ENTRY_TRAMP_DATA,
>  	FIX_ENTRY_TRAMP_TEXT,
>  #define TRAMP_VALIAS
> (__fix_to_virt(FIX_ENTRY_TRAMP_TEXT)) -#endif /*
> CONFIG_UNMAP_KERNEL_AT_EL0 */ __end_of_permanent_fixed_addresses,
>  
>  	/*
> diff --git a/arch/arm64/include/asm/mmu.h
> b/arch/arm64/include/asm/mmu.h index 20fdf71f96c3..9d689661471c 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -42,18 +42,13 @@ typedef struct {
>  
>  static inline bool arm64_kernel_unmapped_at_el0(void)
>  {
> -	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) &&
> -	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> +	return cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>  }
>  
>  static inline bool arm64_kernel_use_ng_mappings(void)
>  {
>  	bool tx1_bug;
>  
> -	/* What's a kpti? Use global mappings if we don't know. */
> -	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> -		return false;
> -
>  	/*
>  	 * Note: this function is called before the CPU capabilities
> have
>  	 * been configured, so our early mappings will be global. If
> we diff --git a/arch/arm64/include/asm/sdei.h
> b/arch/arm64/include/asm/sdei.h index ffe47d766c25..82c3e9b6a4b0
> 100644 --- a/arch/arm64/include/asm/sdei.h
> +++ b/arch/arm64/include/asm/sdei.h
> @@ -23,7 +23,7 @@ extern unsigned long sdei_exit_mode;
>  asmlinkage void __sdei_asm_handler(unsigned long event_num, unsigned
> long arg, unsigned long pc, unsigned long pstate);
>  
> -/* and its CONFIG_UNMAP_KERNEL_AT_EL0 trampoline */
> +/* and its unmap kernel at el0 trampoline */
>  asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
>  						   unsigned long arg,
>  						   unsigned long pc,
> diff --git a/arch/arm64/kernel/asm-offsets.c
> b/arch/arm64/kernel/asm-offsets.c index 65b8afc84466..6a6f83de91b8
> 100644 --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -165,9 +165,7 @@ int main(void)
>    DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
>    DEFINE(ARM64_FTR_SYSVAL,	offsetof(struct arm64_ftr_reg,
> sys_val)); BLANK();
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>    DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);
> -#endif
>  #ifdef CONFIG_ARM_SDE_INTERFACE
>    DEFINE(SDEI_EVENT_INTREGS,	offsetof(struct
> sdei_registered_event, interrupted_regs));
> DEFINE(SDEI_EVENT_PRIORITY,	offsetof(struct
> sdei_registered_event, priority)); diff --git
> a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d1a7fd7972f9..a9e18b9cdc1e 100644 ---
> a/arch/arm64/kernel/cpufeature.c +++ b/arch/arm64/kernel/cpufeature.c
> @@ -944,7 +944,6 @@ has_useable_cnp(const struct
> arm64_cpu_capabilities *entry, int scope) return
> has_cpuid_feature(entry, scope); } 
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0:
> forced off */ 
>  static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities
> *entry, @@ -1035,7 +1034,6 @@ static int __init parse_kpti(char *str)
>  	return 0;
>  }
>  early_param("kpti", parse_kpti);
> -#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  #ifdef CONFIG_ARM64_HW_AFDBM
>  static inline void __cpu_enable_hw_dbm(void)
> @@ -1284,7 +1282,6 @@ static const struct arm64_cpu_capabilities
> arm64_features[] = { .field_pos = ID_AA64PFR0_EL0_SHIFT,
>  		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
>  	},
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	{
>  		.desc = "Kernel page table isolation (KPTI)",
>  		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
> @@ -1300,7 +1297,6 @@ static const struct arm64_cpu_capabilities
> arm64_features[] = { .matches = unmap_kernel_at_el0,
>  		.cpu_enable = kpti_install_ng_mappings,
>  	},
> -#endif
>  	{
>  		/* FP/SIMD is not implemented */
>  		.capability = ARM64_HAS_NO_FPSIMD,
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 3f0eaaf704c8..1d8efc144b04 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -70,7 +70,6 @@
>  
>  	.macro kernel_ventry, el, label, regsize = 64
>  	.align 7
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  alternative_if ARM64_UNMAP_KERNEL_AT_EL0
>  	.if	\el == 0
>  	.if	\regsize == 64
> @@ -81,7 +80,6 @@ alternative_if ARM64_UNMAP_KERNEL_AT_EL0
>  	.endif
>  	.endif
>  alternative_else_nop_endif
> -#endif
>  
>  	sub	sp, sp, #S_FRAME_SIZE
>  #ifdef CONFIG_VMAP_STACK
> @@ -345,7 +343,6 @@ alternative_else_nop_endif
>  
>  	.if	\el == 0
>  alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	bne	4f
>  	msr	far_el1, x30
>  	tramp_alias	x30, tramp_exit_native
> @@ -353,7 +350,7 @@ alternative_insn eret, nop,
> ARM64_UNMAP_KERNEL_AT_EL0 4:
>  	tramp_alias	x30, tramp_exit_compat
>  	br	x30
> -#endif
> +
>  	.else
>  	eret
>  	.endif
> @@ -913,7 +910,6 @@ ENDPROC(el0_svc)
>  
>  	.popsection				// .entry.text
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  /*
>   * Exception vectors trampoline.
>   */
> @@ -1023,7 +1019,6 @@ __entry_tramp_data_start:
>  	.quad	vectors
>  	.popsection				// .rodata
>  #endif /* CONFIG_RANDOMIZE_BASE */
> -#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  /*
>   * Register switch for AArch64. The callee-saved registers need to
> be saved @@ -1086,7 +1081,6 @@ NOKPROBE(ret_from_fork)
>  	b	.
>  .endm
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  /*
>   * The regular SDEI entry point may have been unmapped along with
> the rest of
>   * the kernel. This trampoline restores the kernel mapping to make
> the x1 memory @@ -1146,7 +1140,6 @@
> __sdei_asm_trampoline_next_handler: .quad	__sdei_asm_handler
>  .popsection		// .rodata
>  #endif /* CONFIG_RANDOMIZE_BASE */
> -#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  /*
>   * Software Delegated Exception entry point.
> @@ -1240,10 +1233,8 @@ alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
>  	sdei_handler_exit exit_mode=x2
>  alternative_else_nop_endif
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	tramp_alias	dst=x5, sym=__sdei_asm_exit_trampoline
>  	br	x5
> -#endif
>  ENDPROC(__sdei_asm_handler)
>  NOKPROBE(__sdei_asm_handler)
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index 5ba4465e44f0..a0dbdb962019 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -157,7 +157,6 @@ unsigned long sdei_arch_get_entry_point(int
> conduit) 
>  	sdei_exit_mode = (conduit == CONDUIT_HVC) ? SDEI_EXIT_HVC :
> SDEI_EXIT_SMC; 
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	if (arm64_kernel_unmapped_at_el0()) {
>  		unsigned long offset;
>  
> @@ -165,7 +164,6 @@ unsigned long sdei_arch_get_entry_point(int
> conduit) (unsigned long)__entry_tramp_text_start;
>  		return TRAMP_VALIAS + offset;
>  	} else
> -#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  		return (unsigned long)__sdei_asm_handler;
>  
>  }
> diff --git a/arch/arm64/kernel/vmlinux.lds.S
> b/arch/arm64/kernel/vmlinux.lds.S index 7fa008374907..a4dbee11bcb5
> 100644 --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -57,16 +57,12 @@ jiffies = jiffies_64;
>  #define HIBERNATE_TEXT
>  #endif
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  #define TRAMP_TEXT					\
>  	. = ALIGN(PAGE_SIZE);				\
>  	__entry_tramp_text_start = .;			\
>  	*(.entry.tramp.text)				\
>  	. = ALIGN(PAGE_SIZE);				\
>  	__entry_tramp_text_end = .;
> -#else
> -#define TRAMP_TEXT
> -#endif
>  
>  /*
>   * The size of the PE/COFF section that covers the kernel image,
> which @@ -143,10 +139,8 @@ SECTIONS
>  	idmap_pg_dir = .;
>  	. += IDMAP_DIR_SIZE;
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	tramp_pg_dir = .;
>  	. += PAGE_SIZE;
> -#endif
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  	reserved_ttbr0 = .;
> @@ -257,10 +251,8 @@ ASSERT(__idmap_text_end - (__idmap_text_start &
> ~(SZ_4K - 1)) <= SZ_4K, ASSERT(__hibernate_exit_text_end -
> (__hibernate_exit_text_start & ~(SZ_4K - 1)) <= SZ_4K, "Hibernate
> exit text too big or misaligned") #endif
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) ==
> PAGE_SIZE, "Entry trampoline text too big")
> -#endif
>  /*
>   * If padding is applied before .head.text, virt<->phys conversions
> will fail. */
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 1f0ea2facf24..e99f3e645e06 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -40,15 +40,9 @@ static cpumask_t tlb_flush_pending;
>  #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
>  #define ASID_FIRST_VERSION	(1UL << asid_bits)
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  #define NUM_USER_ASIDS		(ASID_FIRST_VERSION >> 1)
>  #define asid2idx(asid)		(((asid) & ~ASID_MASK) >> 1)
>  #define idx2asid(idx)		(((idx) << 1) & ~ASID_MASK)
> -#else
> -#define NUM_USER_ASIDS		(ASID_FIRST_VERSION)
> -#define asid2idx(asid)		((asid) & ~ASID_MASK)
> -#define idx2asid(idx)		asid2idx(idx)
> -#endif
>  
>  /* Get the ASIDBits supported by the current CPU */
>  static u32 get_cpu_asid_bits(void)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa52ac67..97252baf4700 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -570,7 +570,6 @@ static int __init parse_rodata(char *arg)
>  }
>  early_param("rodata", parse_rodata);
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __init map_entry_trampoline(void)
>  {
>  	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX :
> PAGE_KERNEL_EXEC; @@ -597,7 +596,6 @@ static int __init
> map_entry_trampoline(void) return 0;
>  }
>  core_initcall(map_entry_trampoline);
> -#endif
>  
>  /*
>   * Create fine-grained mappings for the kernel.
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 73886a5f1f30..e9ca5cbb93bc 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -217,7 +217,6 @@ ENTRY(idmap_cpu_replace_ttbr1)
>  ENDPROC(idmap_cpu_replace_ttbr1)
>  	.popsection
>  
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	.pushsection ".idmap.text", "awx"
>  
>  	.macro	__idmap_kpti_get_pgtable_ent, type
> @@ -406,7 +405,6 @@ __idmap_kpti_secondary:
>  	.unreq	pte
>  ENDPROC(idmap_kpti_install_ng_mappings)
>  	.popsection
> -#endif
>  
>  /*
>   *	__cpu_setup

