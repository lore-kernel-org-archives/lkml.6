Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2073CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfA3SEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:04:55 -0500
Received: from foss.arm.com ([217.140.101.70]:59260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfA3SEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B3180D;
        Wed, 30 Jan 2019 10:04:54 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C6B3F557;
        Wed, 30 Jan 2019 10:04:51 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:04:47 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 04/12] arm64: remove the ability to build a kernel
 without hardened branch predictors
Message-ID: <20190130180447.70373425@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-5-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-5-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:03 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> Buried behind EXPERT is the ability to build a kernel without
> hardened branch predictors, this needlessly clutters up the
> code as well as creates the opportunity for bugs. It also
> removes the kernel's ability to determine if the machine its
> running on is vulnerable.
> 
> Since its also possible to disable it at boot time, lets remove
> the config option.

Same comment as before about removing the CONFIG_ options here.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/Kconfig               | 17 -----------------
>  arch/arm64/include/asm/kvm_mmu.h | 12 ------------
>  arch/arm64/include/asm/mmu.h     | 12 ------------
>  arch/arm64/kernel/cpu_errata.c   | 19 -------------------
>  arch/arm64/kernel/entry.S        |  2 --
>  arch/arm64/kvm/Kconfig           |  3 ---
>  arch/arm64/kvm/hyp/hyp-entry.S   |  2 --
>  7 files changed, 67 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0baa632bf0a8..6b4c6d3fdf4d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1005,23 +1005,6 @@ config UNMAP_KERNEL_AT_EL0
>  
>  	  If unsure, say Y.
>  
> -config HARDEN_BRANCH_PREDICTOR
> -	bool "Harden the branch predictor against aliasing attacks"
> if EXPERT
> -	default y
> -	help
> -	  Speculation attacks against some high-performance
> processors rely on
> -	  being able to manipulate the branch predictor for a victim
> context by
> -	  executing aliasing branches in the attacker context.  Such
> attacks
> -	  can be partially mitigated against by clearing internal
> branch
> -	  predictor state and limiting the prediction logic in some
> situations. -
> -	  This config option will take CPU-specific actions to
> harden the
> -	  branch predictor against aliasing attacks and may rely on
> specific
> -	  instruction sequences or control bits being set by the
> system
> -	  firmware.
> -
> -	  If unsure, say Y.
> -
>  config HARDEN_EL2_VECTORS
>  	bool "Harden EL2 vector mapping against system register
> leak" if EXPERT default y
> diff --git a/arch/arm64/include/asm/kvm_mmu.h
> b/arch/arm64/include/asm/kvm_mmu.h index a5c152d79820..9dd680194db9
> 100644 --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -444,7 +444,6 @@ static inline int kvm_read_guest_lock(struct kvm
> *kvm, return ret;
>  }
>  
> -#ifdef CONFIG_KVM_INDIRECT_VECTORS
>  /*
>   * EL2 vectors can be mapped and rerouted in a number of ways,
>   * depending on the kernel configuration and CPU present:

Directly after this comment there is a #include line, can you please
move this up to the beginning of this file, now that it is
unconditional?

> @@ -529,17 +528,6 @@ static inline int kvm_map_vectors(void)
>  
>  	return 0;
>  }
> -#else
> -static inline void *kvm_get_hyp_vector(void)
> -{
> -	return kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
> -}
> -
> -static inline int kvm_map_vectors(void)
> -{
> -	return 0;
> -}
> -#endif
>  
>  DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  
> diff --git a/arch/arm64/include/asm/mmu.h
> b/arch/arm64/include/asm/mmu.h index 3e8063f4f9d3..20fdf71f96c3 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -95,13 +95,9 @@ struct bp_hardening_data {
>  	bp_hardening_cb_t	fn;
>  };
>  
> -#if (defined(CONFIG_HARDEN_BRANCH_PREDICTOR) ||	\
> -     defined(CONFIG_HARDEN_EL2_VECTORS))
>  extern char __bp_harden_hyp_vecs_start[], __bp_harden_hyp_vecs_end[];
>  extern atomic_t arm64_el2_vector_last_slot;
> -#endif  /* CONFIG_HARDEN_BRANCH_PREDICTOR ||
> CONFIG_HARDEN_EL2_VECTORS */ 
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data,
> bp_hardening_data); 
>  static inline struct bp_hardening_data
> *arm64_get_bp_hardening_data(void) @@ -120,14 +116,6 @@ static inline
> void arm64_apply_bp_hardening(void) if (d->fn)
>  		d->fn();
>  }
> -#else
> -static inline struct bp_hardening_data
> *arm64_get_bp_hardening_data(void) -{
> -	return NULL;
> -}
> -
> -static inline void arm64_apply_bp_hardening(void)	{ }
> -#endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
>  extern void paging_init(void);
>  extern void bootmem_init(void);
> diff --git a/arch/arm64/kernel/cpu_errata.c
> b/arch/arm64/kernel/cpu_errata.c index 934d50788ca3..de09a3537cd4
> 100644 --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -109,13 +109,11 @@ cpu_enable_trap_ctr_access(const struct
> arm64_cpu_capabilities *__unused) 
>  atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
>  
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  #include <asm/mmu_context.h>
>  #include <asm/cacheflush.h>

Same here, those should move up.

>  DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data,
> bp_hardening_data); 
> -#ifdef CONFIG_KVM_INDIRECT_VECTORS
>  extern char __smccc_workaround_1_smc_start[];
>  extern char __smccc_workaround_1_smc_end[];
>  
> @@ -165,17 +163,6 @@ static void
> __install_bp_hardening_cb(bp_hardening_cb_t fn,
> __this_cpu_write(bp_hardening_data.fn, fn); raw_spin_unlock(&bp_lock);
>  }
> -#else
> -#define __smccc_workaround_1_smc_start		NULL
> -#define __smccc_workaround_1_smc_end		NULL
> -
> -static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
> -				      const char *hyp_vecs_start,
> -				      const char *hyp_vecs_end)
> -{
> -	__this_cpu_write(bp_hardening_data.fn, fn);
> -}
> -#endif	/* CONFIG_KVM_INDIRECT_VECTORS */
>  
>  static void  install_bp_hardening_cb(const struct
> arm64_cpu_capabilities *entry, bp_hardening_cb_t fn,
> @@ -279,7 +266,6 @@ enable_smccc_arch_workaround_1(const struct
> arm64_cpu_capabilities *entry) 
>  	return;
>  }
> -#endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
>  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  
> @@ -516,7 +502,6 @@ cpu_enable_cache_maint_trap(const struct
> arm64_cpu_capabilities *__unused) .type =
> ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
> CAP_MIDR_RANGE_LIST(midr_list) 
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  
>  /*
>   * List of CPUs where we need to issue a psci call to
> @@ -535,8 +520,6 @@ static const struct midr_range
> arm64_bp_harden_smccc_cpus[] = { {},
>  };
>  
> -#endif
> -
>  #ifdef CONFIG_HARDEN_EL2_VECTORS
>  
>  static const struct midr_range arm64_harden_el2_vectors[] = {
> @@ -710,13 +693,11 @@ const struct arm64_cpu_capabilities
> arm64_errata[] = { ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>  	},
>  #endif
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  	{
>  		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>  		.cpu_enable = enable_smccc_arch_workaround_1,
>  		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
>  	},
> -#endif
>  #ifdef CONFIG_HARDEN_EL2_VECTORS
>  	{
>  		.desc = "EL2 vector hardening",
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index bee54b7d17b9..3f0eaaf704c8 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -842,11 +842,9 @@ el0_irq_naked:
>  #endif
>  
>  	ct_user_exit
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  	tbz	x22, #55, 1f
>  	bl	do_el0_irq_bp_hardening
>  1:
> -#endif
>  	irq_handler
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index a3f85624313e..402bcfb85f25 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -58,9 +58,6 @@ config KVM_ARM_PMU
>  	  Adds support for a virtual Performance Monitoring Unit
> (PMU) in virtual machines.
>  
> -config KVM_INDIRECT_VECTORS
> -       def_bool KVM && (HARDEN_BRANCH_PREDICTOR ||
> HARDEN_EL2_VECTORS) -

That sounds tempting, but breaks compilation when CONFIG_KVM is not
defined (in arch/arm64/kernel/cpu_errata.c). So either we keep
CONFIG_KVM_INDIRECT_VECTORS or we replace the guards in the code with
CONFIG_KVM.

Cheers,
Andre.

>  source "drivers/vhost/Kconfig"
>  
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S
> b/arch/arm64/kvm/hyp/hyp-entry.S index 53c9344968d4..e02ddf40f113
> 100644 --- a/arch/arm64/kvm/hyp/hyp-entry.S
> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> @@ -272,7 +272,6 @@ ENTRY(__kvm_hyp_vector)
>  	valid_vect	el1_error		// Error 32-bit
> EL1 ENDPROC(__kvm_hyp_vector)
>  
> -#ifdef CONFIG_KVM_INDIRECT_VECTORS
>  .macro hyp_ventry
>  	.align 7
>  1:	.rept 27
> @@ -331,4 +330,3 @@ ENTRY(__smccc_workaround_1_smc_start)
>  	ldp	x0, x1, [sp, #(8 * 2)]
>  	add	sp, sp, #(8 * 4)
>  ENTRY(__smccc_workaround_1_smc_end)
> -#endif

