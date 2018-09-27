Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4736DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C685E216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685E216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeI0WLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:11:54 -0400
Received: from foss.arm.com ([217.140.101.70]:36642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0WLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397E27A9;
        Thu, 27 Sep 2018 08:52:59 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.emea.arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10BC93F5B3;
        Thu, 27 Sep 2018 08:52:55 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] arm64: make arm uprobes code reusable by arm64
To:     Maciej Slodczyk <m.slodczyk2@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb@eucas1p2.samsung.com>
 <1537963925-25313-6-git-send-email-m.slodczyk2@partner.samsung.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <9abe9091-f305-a446-c93f-6418d35a7dee@arm.com>
Date:   Thu, 27 Sep 2018 16:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1537963925-25313-6-git-send-email-m.slodczyk2@partner.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

I think that it would be good to move the renaming changes out of this 
patch.

On 26/09/18 13:12, Maciej Slodczyk wrote:
> There are many segments of ARM32 uprobes code that is very specific to
> 32-bit ARM arch and many differences between the two architectures that
> could be made portable (e.g. register numbers). Exclude the ARM32 specific
> code from ARM64 compilation process and make adjustments in ARM32 uprobes
> code to be accessible by ARM64 code.
> 
> Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
> ---
>   arch/arm/include/asm/probes.h            |   8 ++
>   arch/arm/include/asm/ptrace.h            |  32 ++++++++
>   arch/arm/include/asm/uprobes.h           |   2 +-
>   arch/arm/probes/uprobes/core.c           |   6 +-
>   arch/arm64/include/asm/probes.h          |  24 ++++--
>   arch/arm64/include/asm/ptrace.h          |  21 +++++
>   arch/arm64/include/asm/uprobes.h         |  21 ++++-
>   arch/arm64/kernel/probes/Makefile        |   2 +
>   arch/arm64/kernel/probes/decode-insn.c   |  28 +++----
>   arch/arm64/kernel/probes/decode-insn.h   |  15 ++--
>   arch/arm64/kernel/probes/kprobes.c       |   4 +-
>   arch/arm64/kernel/probes/simulate-insn.c |  16 ++--
>   arch/arm64/kernel/probes/simulate-insn.h |  16 ++--
>   arch/arm64/kernel/probes/uprobes.c       |  12 +--
>   lib/probes/Makefile                      |   1 +
>   lib/probes/arm/Makefile                  |   5 ++
>   lib/probes/arm/actions-arm.c             | 130 ++++++++++++++++++++++++++++---
>   lib/probes/arm/decode-arm.c              |  47 ++++++-----
>   lib/probes/arm/decode.c                  |  12 ++-
>   lib/probes/arm/decode.h                  |  41 ++++++----
>   20 files changed, 335 insertions(+), 108 deletions(-)
> 
> diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
> index 991c912..b24938f 100644
> --- a/arch/arm/include/asm/probes.h
> +++ b/arch/arm/include/asm/probes.h
> @@ -21,6 +21,13 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +enum probes_insn {
> +	INSN_REJECTED,
> +	INSN_GOOD_NO_SLOT,
> +	INSN_GOOD,
> +};
> +
> +
>   typedef u32 probes_opcode_t;
>   
>   struct arch_probes_insn;
> @@ -45,6 +52,7 @@ struct arch_probes_insn {
>   	bool				kprobe_direct_exec;
>   };
>   
> +extern probes_check_cc * const probes_condition_checks[];
>   #endif /* __ASSEMBLY__ */
>   
>   /*
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index c7cdbb4..99f19f2 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -93,6 +93,8 @@ static inline long regs_return_value(struct pt_regs *regs)
>   }
>   
>   #define instruction_pointer(regs)	(regs)->ARM_pc
> +#define link_register(regs)			((regs)->ARM_lr)
           ^ here you have a space

> +#define	state_register(regs)		((regs)->ARM_cpsr)
           ^ here you have a tab, you probably want a space here
>   
>   #ifdef CONFIG_THUMB2_KERNEL
>   #define frame_pointer(regs) (regs)->ARM_r7
> @@ -106,6 +108,35 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
>   	instruction_pointer(regs) = val;
>   }
>   
> +static inline void link_register_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	link_register(regs) = val;
> +}
> +
> +static inline void state_register_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	state_register(regs) = val;
> +}
> +
> +/*
> + * Read a register given an architectural register index r.
> + */
> +static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
> +{
> +	return regs->uregs[r];
> +}
> +
> +/*
> + * Write a register given an architectural register index r.
> + */
> +static inline void pt_regs_write_reg(struct pt_regs *regs, int r,
> +				     unsigned long val)
> +{
> +	regs->uregs[r] = val;
> +}
> +
>   #ifdef CONFIG_SMP
>   extern unsigned long profile_pc(struct pt_regs *regs);
>   #else
> @@ -167,5 +198,6 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
>   		((current_stack_pointer | (THREAD_SIZE - 1)) - 7) - 1;	\
>   })
>   
> +#define ARM_COMPAT_LR_OFFSET	0

Not sure this should be defined here. What's the meaning of compat for 
arch/arm ?

>   #endif /* __ASSEMBLY__ */
>   #endif
> diff --git a/arch/arm/include/asm/uprobes.h b/arch/arm/include/asm/uprobes.h
> index 9472c20..536af7f 100644
> --- a/arch/arm/include/asm/uprobes.h
> +++ b/arch/arm/include/asm/uprobes.h
> @@ -39,7 +39,7 @@ struct arch_uprobe {
>   	void (*posthandler)(struct arch_uprobe *auprobe,
>   			    struct arch_uprobe_task *autask,
>   			    struct pt_regs *regs);
> -	struct arch_probes_insn asi;
> +	struct arch_probes_insn api;

It would be easier to follow thing by making this change in its own 
patch. (Probably before you move arm32 code to lib/probes)

>   };
>   
>   #endif
> diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
> index 90d0954..8abec17 100644
> --- a/arch/arm/probes/uprobes/core.c
> +++ b/arch/arm/probes/uprobes/core.c
> @@ -38,7 +38,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   
>   bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   {
> -	if (!auprobe->asi.insn_check_cc(regs->ARM_cpsr)) {
> +	if (!auprobe->api.insn_check_cc(regs->ARM_cpsr)) {
>   		regs->ARM_pc += 4;
>   		return true;
>   	}
> @@ -55,7 +55,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   
>   	opcode = __mem_to_opcode_arm(*(unsigned int *) auprobe->insn);
>   
> -	auprobe->asi.insn_singlestep(opcode, &auprobe->asi, regs);
> +	auprobe->api.insn_singlestep(opcode, &auprobe->api, regs);
>   
>   	return true;
>   }
> @@ -87,7 +87,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   	auprobe->ixol[0] = __opcode_to_mem_arm(insn);
>   	auprobe->ixol[1] = __opcode_to_mem_arm(UPROBE_SS_ARM_INSN);
>   
> -	ret = arm_probes_decode_insn(insn, &auprobe->asi, false,
> +	ret = arm_probes_decode_insn(insn, &auprobe->api, false,
>   				     uprobes_probes_actions, NULL);
>   	switch (ret) {
>   	case INSN_REJECTED:
> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
> index 1747e9a..78c0788 100644
> --- a/arch/arm64/include/asm/probes.h
> +++ b/arch/arm64/include/asm/probes.h
> @@ -15,25 +15,33 @@
>   #ifndef _ARM_PROBES_H
>   #define _ARM_PROBES_H
>   
> -typedef u32 probe_opcode_t;
> -struct arch_probe_insn;
> +enum probes_insn {
> +	INSN_REJECTED,
> +	INSN_GOOD_NO_SLOT,
> +	INSN_GOOD,
> +};

Why have two definitions of this enum rather than a common one in 
lib/probes?

> +
> +typedef u32 probes_opcode_t;
> +struct arch_probes_insn;
>   
> -typedef void (probes_handler_t) (u32 opcode,
> -			   struct arch_probe_insn *api,
> +typedef void (probes_insn_handler_t) (u32 opcode,
> +			   struct arch_probes_insn *api,

In the previous patch you were already aligning this handler the ARM32's 
equivalent. Why not fix the name (for the handler and struct 
arch_probes_insn) in the previous patch?

>   			   struct pt_regs *);
>   
> +typedef unsigned long (probes_check_cc)(unsigned long);
> +
>   /* architecture specific copy of original instruction */
> -struct arch_probe_insn {
> -	probe_opcode_t *insn;
> +struct arch_probes_insn {
> +	probes_opcode_t *insn;
>   	pstate_check_t *pstate_cc;
> -	probes_handler_t *handler;
> +	probes_insn_handler_t *insn_handler;
>   	/* restore address after step xol */
>   	unsigned long restore;
>   };
>   #ifdef CONFIG_KPROBES
>   typedef u32 kprobe_opcode_t;
>   struct arch_specific_insn {
> -	struct arch_probe_insn api;
> +	struct arch_probes_insn api;
>   };
>   #endif
>   
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 177b851..a884fd6 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -301,8 +301,29 @@ static inline void procedure_link_pointer_set(struct pt_regs *regs,
>   	procedure_link_pointer(regs) = val;
>   }
>   
> +
> +#define link_register(regs)			((regs)->compat_lr)
> +
> +static inline void link_register_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	link_register(regs) = val;
> +}

pstate.h isn't really related to compat mode and whichever compat 
definition it contains the relations are made explicit through their names.

I don't think a macro "link_register" defined in arch/arm64 and visible 
to any file including ptrace.h (which is a lot) should return 
"compat_lr" instead of the actual link register.

I'd say have the link_register macro check whether "regs" refers to a 
compat mode context or not and provide the adequate link register.

Otherwise maybe you can get away with naming the macro 
"arm_link_register" and the macro "arm_link_register_set". But I would 
prefer the previous approach.

> +
> +#define	state_register(regs)		((regs)->pstate)
> +
> +static inline void state_register_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	state_register(regs) = val;
> +}
> +
> +
>   #undef profile_pc
>   extern unsigned long profile_pc(struct pt_regs *regs);
>   
> +
> +#define ARM_COMPAT_LR_OFFSET	4
> +
>   #endif /* __ASSEMBLY__ */
>   #endif
> diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
> index 8d00407..b984634 100644
> --- a/arch/arm64/include/asm/uprobes.h
> +++ b/arch/arm64/include/asm/uprobes.h
> @@ -22,6 +22,12 @@
>   typedef u32 uprobe_opcode_t;
>   
>   struct arch_uprobe_task {
> +	u64 backup;
> +};
> +
> +enum uprobe_arch {
> +	UPROBE_AARCH64,
> +	UPROBE_AARCH32
>   };
>   
>   struct arch_uprobe {
> @@ -29,8 +35,21 @@ struct arch_uprobe {
>   		u8 insn[MAX_UINSN_BYTES];
>   		u8 ixol[MAX_UINSN_BYTES];
>   	};
> -	struct arch_probe_insn api;
> +
> +	probes_opcode_t orig_insn;
> +	probes_opcode_t bp_insn;
> +
> +	struct arch_probes_insn api;
>   	bool simulate;
> +	u64 pcreg;
> +	enum uprobe_arch arch;
> +
> +	void (*prehandler)(struct arch_uprobe *auprobe,
> +			   struct arch_uprobe_task *autask,
> +			   struct pt_regs *regs);
> +	void (*posthandler)(struct arch_uprobe *auprobe,
> +		    struct arch_uprobe_task *autask,
> +		    struct pt_regs *regs);
>   };
>   
>   #endif
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index 8e4be92..c5d57e3 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -1,4 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
> +ccflags-y	+= -I$(srctree)/lib/probes/arm/
> +ccflags-y	+= -I$(srctree)/arch/arm64/kernel/probes/
>   obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>   				   kprobes_trampoline.o		\
>   				   simulate-insn.o
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> index 6bf6657..a0597a2 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -77,8 +77,8 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>    *   INSN_GOOD         If instruction is supported and uses instruction slot,
>    *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
>    */
> -enum probe_insn __kprobes
> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
> +enum probes_insn __kprobes
> +arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
>   {
>   	/*
>   	 * Instructions reading or modifying the PC won't work from the XOL
> @@ -88,26 +88,26 @@ arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
>   		return INSN_GOOD;
>   
>   	if (aarch64_insn_is_bcond(insn)) {
> -		api->handler = simulate_b_cond;
> +		api->insn_handler = simulate_b_cond;
>   	} else if (aarch64_insn_is_cbz(insn) ||
>   	    aarch64_insn_is_cbnz(insn)) {
> -		api->handler = simulate_cbz_cbnz;
> +		api->insn_handler = simulate_cbz_cbnz;
>   	} else if (aarch64_insn_is_tbz(insn) ||
>   	    aarch64_insn_is_tbnz(insn)) {
> -		api->handler = simulate_tbz_tbnz;
> +		api->insn_handler = simulate_tbz_tbnz;
>   	} else if (aarch64_insn_is_adr_adrp(insn)) {
> -		api->handler = simulate_adr_adrp;
> +		api->insn_handler = simulate_adr_adrp;
>   	} else if (aarch64_insn_is_b(insn) ||
>   	    aarch64_insn_is_bl(insn)) {
> -		api->handler = simulate_b_bl;
> +		api->insn_handler = simulate_b_bl;
>   	} else if (aarch64_insn_is_br(insn) ||
>   	    aarch64_insn_is_blr(insn) ||
>   	    aarch64_insn_is_ret(insn)) {
> -		api->handler = simulate_br_blr_ret;
> +		api->insn_handler = simulate_br_blr_ret;
>   	} else if (aarch64_insn_is_ldr_lit(insn)) {
> -		api->handler = simulate_ldr_literal;
> +		api->insn_handler = simulate_ldr_literal;
>   	} else if (aarch64_insn_is_ldrsw_lit(insn)) {
> -		api->handler = simulate_ldrsw_literal;
> +		api->insn_handler = simulate_ldrsw_literal;
>   	} else {
>   		/*
>   		 * Instruction cannot be stepped out-of-line and we don't
> @@ -138,12 +138,12 @@ is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
>   	return false;
>   }
>   
> -enum probe_insn __kprobes
> +enum probes_insn __kprobes
>   arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>   {
> -	enum probe_insn decoded;
> -	probe_opcode_t insn = le32_to_cpu(*addr);
> -	probe_opcode_t *scan_end = NULL;
> +	enum probes_insn decoded;
> +	probes_opcode_t insn = le32_to_cpu(*addr);
> +	probes_opcode_t *scan_end = NULL;
>   	unsigned long size = 0, offset = 0;
>   
>   	/*
> diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
> index 192ab00..93e021f 100644
> --- a/arch/arm64/kernel/probes/decode-insn.h
> +++ b/arch/arm64/kernel/probes/decode-insn.h
> @@ -16,7 +16,9 @@
>   #ifndef _ARM_KERNEL_KPROBES_ARM64_H
>   #define _ARM_KERNEL_KPROBES_ARM64_H
>   
> +#include <asm/probes.h>
>   #include <asm/kprobes.h>
> +#include "decode.h"
>   
>   /*
>    * ARM strongly recommends a limit of 128 bytes between LoadExcl and
> @@ -25,17 +27,12 @@
>    */
>   #define MAX_ATOMIC_CONTEXT_SIZE	(128 / sizeof(kprobe_opcode_t))
>   
> -enum probe_insn {
> -	INSN_REJECTED,
> -	INSN_GOOD_NO_SLOT,
> -	INSN_GOOD,
> -};
> -
>   #ifdef CONFIG_KPROBES
> -enum probe_insn __kprobes
> +enum probes_insn __kprobes
>   arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
>   #endif
> -enum probe_insn __kprobes
> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
> +enum probes_insn __kprobes
> +arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
>   
> +extern const union decode_action uprobes_probes_actions[];
>   #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 3988967..6b392e1 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -68,8 +68,8 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>   {
>   	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>   
> -	if (p->ainsn.api.handler)
> -		p->ainsn.api.handler((u32)p->opcode, &p->ainsn.api, regs);
> +	if (p->ainsn.api.insn_handler)
> +		p->ainsn.api.insn_handler((u32)p->opcode, &p->ainsn.api, regs);
>   
>   	/* single step simulated, now go for post processing */
>   	post_kprobe_handler(kcb, regs);
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 22dc7a7..9898c41 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -92,7 +92,7 @@ static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
>    * instruction simulation functions
>    */
>   void __kprobes
> -simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
> +simulate_adr_adrp(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	long imm, xn, val;
> @@ -112,7 +112,7 @@ simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
> +simulate_b_bl(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	int disp = bbl_displacement(opcode);
> @@ -126,7 +126,7 @@ simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
> +simulate_b_cond(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	int disp = 4;
> @@ -139,7 +139,7 @@ simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
> +simulate_br_blr_ret(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	int xn = (opcode >> 5) & 0x1f;
> @@ -154,7 +154,7 @@ simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
> +simulate_cbz_cbnz(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	int disp = 4;
> @@ -171,7 +171,7 @@ simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
> +simulate_tbz_tbnz(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	int disp = 4;
> @@ -188,7 +188,7 @@ simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
> +simulate_ldr_literal(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	u64 *load_addr;
> @@ -208,7 +208,7 @@ simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
>   }
>   
>   void __kprobes
> -simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
> +simulate_ldrsw_literal(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs)
>   {
>   	s32 *load_addr;
> diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
> index 31b3840..822c3c4 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.h
> +++ b/arch/arm64/kernel/probes/simulate-insn.h
> @@ -16,21 +16,21 @@
>   #ifndef _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
>   #define _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
>   
> -void simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
> +void simulate_adr_adrp(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
> +void simulate_b_bl(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
> +void simulate_b_cond(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
> +void simulate_br_blr_ret(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
> +void simulate_cbz_cbnz(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
> +void simulate_tbz_tbnz(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
> +void simulate_ldr_literal(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
> -void simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
> +void simulate_ldrsw_literal(u32 opcode, struct arch_probes_insn *api,
>   		struct pt_regs *regs);
>   
>   #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index a83642c..f99b50b 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -37,7 +37,7 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
>   int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   		unsigned long addr)
>   {
> -	probe_opcode_t insn;
> +	probes_opcode_t insn;
>   
>   	/* TODO: Currently we do not support AARCH32 instruction probing */
>   	if (mm->context.flags & MMCF_AARCH32)
> @@ -45,7 +45,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>   		return -EINVAL;
>   
> -	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
> +	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>   
>   	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
>   	case INSN_REJECTED:
> @@ -105,16 +105,16 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
>   
>   bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   {
> -	probe_opcode_t insn;
> +	probes_opcode_t insn;
>   	unsigned long addr;
>   
>   	if (!auprobe->simulate)
>   		return false;
>   
> -	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
> +	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>   
> -	if (auprobe->api.handler)
> -		auprobe->api.handler(insn, &auprobe->api, regs);
> +	if (auprobe->api.insn_handler)
> +		auprobe->api.insn_handler(insn, &auprobe->api, regs);
>   
>   	return true;
>   }
> diff --git a/lib/probes/Makefile b/lib/probes/Makefile
> index 534a2b7..682e2df 100644
> --- a/lib/probes/Makefile
> +++ b/lib/probes/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_ARM)		+= arm/
> +obj-$(CONFIG_ARM64)		+= arm/
> diff --git a/lib/probes/arm/Makefile b/lib/probes/arm/Makefile
> index 1c97b8f..239deac 100644
> --- a/lib/probes/arm/Makefile
> +++ b/lib/probes/arm/Makefile
> @@ -1,4 +1,9 @@
> +ccflags-y	+= -I$(srctree)/lib/uprobes/arm/
> +ifdef CONFIG_ARM64
> +ccflags-y += -I$(srctree)/arch/arm64/kernel/probes/
> +else
>   ccflags-y += -I$(srctree)/arch/arm/probes/uprobes/
> +endif
>   obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o actions-arm.o
>   obj-$(CONFIG_KPROBES)		+= decode.o
>   ifndef CONFIG_THUMB2_KERNEL
> diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
> index db6017d..2393573 100644
> --- a/lib/probes/arm/actions-arm.c
> +++ b/lib/probes/arm/actions-arm.c
> @@ -15,7 +15,10 @@
>   
>   #include "decode.h"
>   #include "decode-arm.h"
> -#include "core.h"
> +
> +#ifdef CONFIG_ARM64
> +#include <../../../arm/include/asm/opcodes.h>

Hmmm not sure this is something that is accepted.

> +#endif /* CONFIG_ARM64  */
>   
>   static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
>   {
> @@ -72,8 +75,8 @@ static void uprobe_set_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	autask->backup = regs->uregs[pcreg];
> -	regs->uregs[pcreg] = regs->ARM_pc + 8;
> +	autask->backup = pt_regs_read_reg(regs, pcreg);
> +	pt_regs_write_reg(regs, pcreg, instruction_pointer(regs) + 8);
>   }
>   
>   static void uprobe_unset_pc(struct arch_uprobe *auprobe,
> @@ -81,7 +84,7 @@ static void uprobe_unset_pc(struct arch_uprobe *auprobe,
>   			    struct pt_regs *regs)
>   {
>   	/* PC will be taken care of by common code */
> -	regs->uregs[auprobe->pcreg] = autask->backup;
> +	pt_regs_write_reg(regs, auprobe->pcreg, autask->backup);
>   }
>   
>   static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
> @@ -90,8 +93,8 @@ static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	alu_write_pc(regs->uregs[pcreg], regs);
> -	regs->uregs[pcreg] = autask->backup;
> +	alu_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> +	pt_regs_write_reg(regs, pcreg, autask->backup);
>   }
>   
>   static void uprobe_write_pc(struct arch_uprobe *auprobe,
> @@ -100,8 +103,8 @@ static void uprobe_write_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	load_write_pc(regs->uregs[pcreg], regs);
> -	regs->uregs[pcreg] = autask->backup;
> +	load_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> +	pt_regs_write_reg(regs, pcreg, autask->backup);
>   }
>   
>   enum probes_insn
> @@ -109,12 +112,13 @@ decode_pc_ro(probes_opcode_t insn, struct arch_probes_insn *asi,
>   	     const struct decode_header *d)
>   {
>   	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
> -						   asi);
> +							api);
> +
>   	struct decode_emulate *decode = (struct decode_emulate *) d;
>   	u32 regs = decode->header.type_regs.bits >> DECODE_TYPE_BITS;
>   	int reg;
>   
> -	reg = uprobes_substitute_pc(&auprobe->ixol[0], regs);
> +	reg = uprobes_substitute_pc((unsigned long *)&auprobe->ixol[0], regs);
>   	if (reg == 15)
>   		return INSN_GOOD;
>   
> @@ -133,7 +137,8 @@ decode_wb_pc(probes_opcode_t insn, struct arch_probes_insn *asi,
>   	     const struct decode_header *d, bool alu)
>   {
>   	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
> -						   asi);
> +						   api);
> +
>   	enum probes_insn ret = decode_pc_ro(insn, asi, d);
>   
>   	if (((insn >> 12) & 0xf) == 15)
> @@ -158,13 +163,110 @@ decode_ldr(probes_opcode_t insn, struct arch_probes_insn *asi,
>   	return decode_wb_pc(insn, asi, d, false);
>   }
>   
> +/*
> + * based on arm kprobes implementation
> + */
> +static void __kprobes simulate_ldm1stm1(probes_opcode_t insn,
> +		struct arch_probes_insn *asi,

The whole asi/api mix become a bit confusing IMO.
Should we have api when the argument is of type "arch_probes_insn" and 
asi when the type is "arch_specific_insn"?
Should we have more coherent definitions of those structures between arm 
and arm64 if we are going to share functions between them?

> +		struct pt_regs *regs)
> +{
> +	int rn = (insn >> 16) & 0xf;
> +	int lbit = insn & (1 << 20);
> +	int wbit = insn & (1 << 21);
> +	int ubit = insn & (1 << 23);
> +	int pbit = insn & (1 << 24);
> +	int reg;
> +	u32 *addr = (u32 *)pt_regs_read_reg(regs, rn);
> +	unsigned int reg_bit_vector;
> +	unsigned int reg_count;
> +
> +	reg_count = 0;
> +	reg_bit_vector = insn & 0xffff;
> +
> +	while (reg_bit_vector) {
> +		reg_bit_vector &= (reg_bit_vector - 1);
> +		++reg_count;
> +	}
> +	if (!ubit)
> +		addr -= reg_count;
> +	addr += (!pbit == !ubit);
> +
> +	reg_bit_vector = insn & 0xffff;
> +
> +	while (reg_bit_vector) {
> +		reg = __ffs(reg_bit_vector);
> +		reg_bit_vector &= (reg_bit_vector - 1);
> +		if (lbit) {	/* LDM */
> +			if (reg == 15)
> +				instruction_pointer_set(regs, (*addr++) - 4);
> +			else
> +				pt_regs_write_reg(regs, reg, *addr++);
> +		} else { /* STM */
> +			if (reg == 15)
> +				*addr++ = instruction_pointer(regs);
> +			else
> +				*addr++ = pt_regs_read_reg(regs, reg);
> +		}
> +	}
> +
> +	/* write back new value of Rn */
> +	if (wbit) {
> +		if (!ubit)
> +			addr -= reg_count;
> +		addr -= (!pbit == !ubit);
> +		if (rn == 15)
> +			instruction_pointer_set(regs, (long)addr);
> +		else
> +			pt_regs_write_reg(regs, rn, (long)addr);
> +	}
> +
> +	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> +}
> +
> +static void __kprobes simulate_stm1_pc(probes_opcode_t insn,
> +		struct arch_probes_insn *asi,
> +		struct pt_regs *regs)
> +{
> +	unsigned long addr = instruction_pointer(regs) - 4;
> +
> +	instruction_pointer_set(regs, (long)addr + str_pc_offset);
> +	simulate_ldm1stm1(insn, asi, regs);
> +	instruction_pointer_set(regs, (long)addr + 4);
> +}
> +
> +static void __kprobes simulate_ldm1_pc(probes_opcode_t insn,
> +		struct arch_probes_insn *asi,
> +		struct pt_regs *regs)
> +{
> +	simulate_ldm1stm1(insn, asi, regs);
> +	load_write_pc(instruction_pointer(regs), regs);
> +}
> +

#ifdef CONFIG_ARM64

> +enum probes_insn
> +uprobe_decode_ldmstm_aarch64(probes_opcode_t insn,
> +	     struct arch_probes_insn *asi,
> +	     const struct decode_header *d)

Should be static.

> +{
> +	probes_insn_handler_t *handler = 0;
> +	unsigned int reglist = insn & 0xffff;
> +	int is_ldm = insn & 0x100000;
> +
> +	/* PC on a reglist? */
> +	if (reglist & 0x8000)
> +		handler = is_ldm ? simulate_ldm1_pc : simulate_stm1_pc;
> +	else
> +		handler = simulate_ldm1stm1;
> +	asi->insn_handler = handler;
> +	return INSN_GOOD_NO_SLOT;
> +}
> +

#endif


#endofreview

Cheers,

Julien

>   enum probes_insn
>   uprobe_decode_ldmstm(probes_opcode_t insn,
>   		     struct arch_probes_insn *asi,
>   		     const struct decode_header *d)
>   {
>   	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
> -						   asi);
> +			api);
>   	unsigned int reglist = insn & 0xffff;
>   	int rn = (insn >> 16) & 0xf;
>   	int lbit = insn & (1 << 20);
> @@ -228,5 +330,9 @@ const union decode_action uprobes_probes_actions[] = {
>   	[PROBES_MUL_ADD] = {.handler = probes_simulate_nop},
>   	[PROBES_BITFIELD] = {.handler = probes_simulate_nop},
>   	[PROBES_BRANCH] = {.handler = simulate_bbl},
> +#ifdef CONFIG_ARM64
> +	[PROBES_LDMSTM] = {.decoder = uprobe_decode_ldmstm_aarch64}
> +#else
>   	[PROBES_LDMSTM] = {.decoder = uprobe_decode_ldmstm}
> +#endif
>   };
> diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
> index 3aa2e58..36eb939 100644
> --- a/lib/probes/arm/decode-arm.c
> +++ b/lib/probes/arm/decode-arm.c
> @@ -61,39 +61,45 @@
>   void __kprobes simulate_bbl(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
> -	long iaddr = (long) regs->ARM_pc - 4;
> -	int disp  = branch_displacement(insn);
> +	long iaddr = (long) instruction_pointer(regs) + ARM_COMPAT_LR_OFFSET;
> +	int disp = branch_displacement(insn);
>   
>   	if (insn & (1 << 24))
> -		regs->ARM_lr = iaddr + 4;
> +		link_register_set(regs, iaddr);
>   
> -	regs->ARM_pc = iaddr + 8 + disp;
> +	instruction_pointer_set(regs, iaddr + 4 + disp);
>   }
>   
>   void __kprobes simulate_blx1(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
> -	long iaddr = (long) regs->ARM_pc - 4;
> +	long iaddr = (long) instruction_pointer(regs) + ARM_COMPAT_LR_OFFSET;
>   	int disp = branch_displacement(insn);
> +	long cpsr;
>   
> -	regs->ARM_lr = iaddr + 4;
> -	regs->ARM_pc = iaddr + 8 + disp + ((insn >> 23) & 0x2);
> -	regs->ARM_cpsr |= PSR_T_BIT;
> +	link_register_set(regs, iaddr);
> +	instruction_pointer_set(regs, iaddr + 4 + disp + ((insn >> 23) & 0x2));
> +	cpsr = state_register(regs) | PSR_T_BIT;
> +	state_register_set(regs, cpsr);
>   }
>   
>   void __kprobes simulate_blx2bx(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
>   	int rm = insn & 0xf;
> -	long rmv = regs->uregs[rm];
> +	long rmv = pt_regs_read_reg(regs, rm);
> +	long cpsr;
>   
>   	if (insn & (1 << 5))
> -		regs->ARM_lr = (long) regs->ARM_pc;
> -
> -	regs->ARM_pc = rmv & ~0x1;
> -	regs->ARM_cpsr &= ~PSR_T_BIT;
> -	if (rmv & 0x1)
> -		regs->ARM_cpsr |= PSR_T_BIT;
> +		link_register_set(regs, (long) instruction_pointer(regs));
> +
> +	instruction_pointer_set(regs, rmv & ~0x1);
> +	cpsr = state_register(regs) & ~PSR_T_BIT;
> +	state_register_set(regs, cpsr);
> +	if (rmv & 0x1) {
> +		cpsr = state_register(regs) | PSR_T_BIT;
> +		state_register_set(regs, cpsr);
> +	}
>   }
>   
>   void __kprobes simulate_mrs(probes_opcode_t insn,
> @@ -102,13 +108,13 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
>   	int rd = (insn >> 12) & 0xf;
>   	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
>   
> -	regs->uregs[rd] = regs->ARM_cpsr & mask;
> +	pt_regs_write_reg(regs, rd, state_register(regs) & mask);
>   }
>   
>   void __kprobes simulate_mov_ipsp(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
> -	regs->uregs[12] = regs->uregs[13];
> +	pt_regs_write_reg(regs, 12, pt_regs_read_reg(regs, 13));
>   }
>   
>   /*
> @@ -246,13 +252,14 @@ static const union decode_item arm_cccc_0000_____1001_table[] = {
>   
>   static const union decode_item arm_cccc_0001_____1001_table[] = {
>   	/* Synchronization primitives					*/
> -
> +#ifndef CONFIG_ARM64
>   #if __LINUX_ARM_ARCH__ < 6
>   	/* Deprecated on ARMv6 and may be UNDEFINED on v7		*/
>   	/* SMP/SWPB		cccc 0001 0x00 xxxx xxxx xxxx 1001 xxxx */
>   	DECODE_EMULATEX	(0x0fb000f0, 0x01000090, PROBES_SWP,
>   						 REGS(NOPC, NOPC, 0, 0, NOPC)),
>   #endif
> +#endif /* CONFIG_ARM64 */
>   	/* LDREX/STREX{,D,B,H}	cccc 0001 1xxx xxxx xxxx xxxx 1001 xxxx */
>   	/* And unallocated instructions...				*/
>   	DECODE_END
> @@ -709,7 +716,7 @@ EXPORT_SYMBOL_GPL(probes_decode_arm_table);
>   static void __kprobes arm_singlestep(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
> -	regs->ARM_pc += 4;
> +	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>   	asi->insn_handler(insn, asi, regs);
>   }
>   
> @@ -730,8 +737,10 @@ arm_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
>   		       bool emulate, const union decode_action *actions,
>   		       const struct decode_checker *checkers[])
>   {
> +#ifndef CONFIG_ARM64
>   	asi->insn_singlestep = arm_singlestep;
>   	asi->insn_check_cc = probes_condition_checks[insn>>28];
> +#endif
>   	return probes_decode_insn(insn, asi, probes_decode_arm_table, false,
>   				  emulate, actions, checkers);
>   }
> diff --git a/lib/probes/arm/decode.c b/lib/probes/arm/decode.c
> index 6840054..7a31042 100644
> --- a/lib/probes/arm/decode.c
> +++ b/lib/probes/arm/decode.c
> @@ -13,13 +13,18 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/types.h>
> +#ifdef CONFIG_ARM64
> +#include <asm/insn.h>
> +#include <../../../arm/include/asm/opcodes.h>
> +#else /* CONFIG_ARM64 */
>   #include <asm/system_info.h>
>   #include <asm/ptrace.h>
> +#endif /* CONFIG_ARM64 */
>   #include <linux/bug.h>
> -
>   #include "decode.h"
>   
>   
> +
>   #ifndef find_str_pc_offset
>   
>   /*
> @@ -189,7 +194,9 @@ void __kprobes probes_emulate_none(probes_opcode_t opcode,
>   	struct arch_probes_insn *asi,
>   	struct pt_regs *regs)
>   {
> +#ifndef CONFIG_ARM64
>   	asi->insn_fn();
> +#endif /* CONFIG_ARM64 */
>   }
>   
>   /*
> @@ -430,6 +437,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
>   	 */
>   	probes_opcode_t origin_insn = insn;
>   
> +#ifndef CONFIG_ARM64
>   	/*
>   	 * stack_space is initialized to 0 here. Checker functions
>   	 * should update is value if they find this is a stack store
> @@ -446,7 +454,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
>   	 * registers are used', to prevent any potential optimization.
>   	 */
>   	asi->register_usage_flags = ~0UL;
> -
> +#endif /* CONFIG_ARM64 */
>   	if (emulate)
>   		insn = prepare_emulated_insn(insn, asi, thumb);
>   
> diff --git a/lib/probes/arm/decode.h b/lib/probes/arm/decode.h
> index 43b02fd..b1fd9ab 100644
> --- a/lib/probes/arm/decode.h
> +++ b/lib/probes/arm/decode.h
> @@ -23,10 +23,20 @@
>   #include <linux/stddef.h>
>   #include <asm/probes.h>
>   #include <asm/kprobes.h>
> +#ifdef CONFIG_ARM64
> +#include <asm/ptrace.h>
> +#include <asm/insn.h>
>   
> -void __init arm_probes_decode_init(void);
> +#define PSR_T_BIT	PSR_AA32_T_BIT
> +
> +#define str_pc_offset 8
> +#define load_write_pc_interworks true
> +#define alu_write_pc_interworks true
> +#define find_str_pc_offset()
> +#define test_load_write_pc_interworking()
> +#define test_alu_write_pc_interworking()
>   
> -extern probes_check_cc * const probes_condition_checks[16];
> +#else /* CONFIG_ARM64 */
>   
>   #if __LINUX_ARM_ARCH__ >= 7
>   
> @@ -40,8 +50,7 @@ extern probes_check_cc * const probes_condition_checks[16];
>   extern int str_pc_offset;
>   void __init find_str_pc_offset(void);
>   
> -#endif
> -
> +#endif /* __LINUX_ARM_ARCH__ */
>   
>   /*
>    * Update ITSTATE after normal execution of an IT block instruction.
> @@ -69,9 +78,13 @@ static inline unsigned long it_advance(unsigned long cpsr)
>   	return cpsr;
>   }
>   
> +#endif /* CONFIG_ARM64 */
> +
> +void __init arm_probes_decode_init(void);
> +
>   static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
>   {
> -	long cpsr = regs->ARM_cpsr;
> +	long cpsr = state_register(regs);
>   
>   	if (pcv & 0x1) {
>   		cpsr |= PSR_T_BIT;
> @@ -80,11 +93,11 @@ static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
>   		cpsr &= ~PSR_T_BIT;
>   		pcv &= ~0x2;	/* Avoid UNPREDICTABLE address allignment */
>   	}
> -	regs->ARM_cpsr = cpsr;
> -	regs->ARM_pc = pcv;
> +	state_register_set(regs, cpsr);
> +	instruction_pointer_set(regs, pcv);
>   }
>   
> -
> +#ifndef CONFIG_ARM64
>   #if __LINUX_ARM_ARCH__ >= 6
>   
>   /* Kernels built for >= ARMv6 should never run on <= ARMv5 hardware, so... */
> @@ -98,16 +111,18 @@ extern bool load_write_pc_interworks;
>   void __init test_load_write_pc_interworking(void);
>   
>   #endif
> +#endif /* CONFIG_ARM64 */
>   
>   static inline void __kprobes load_write_pc(long pcv, struct pt_regs *regs)
>   {
>   	if (load_write_pc_interworks)
>   		bx_write_pc(pcv, regs);
>   	else
> -		regs->ARM_pc = pcv;
> +		instruction_pointer_set(regs, pcv);
>   }
>   
>   
> +#ifndef CONFIG_ARM64
>   #if __LINUX_ARM_ARCH__ >= 7
>   
>   #define alu_write_pc_interworks true
> @@ -126,13 +141,14 @@ extern bool alu_write_pc_interworks;
>   void __init test_alu_write_pc_interworking(void);
>   
>   #endif /* __LINUX_ARM_ARCH__ == 6 */
> +#endif /* CONFIG_ARM64 */
>   
>   static inline void __kprobes alu_write_pc(long pcv, struct pt_regs *regs)
>   {
>   	if (alu_write_pc_interworks)
>   		bx_write_pc(pcv, regs);
>   	else
> -		regs->ARM_pc = pcv;
> +		instruction_pointer_set(regs, pcv);
>   }
>   
>   
> @@ -395,11 +411,6 @@ struct decode_or {
>   #define DECODE_OR(_mask, _value)				\
>   	DECODE_HEADER(DECODE_TYPE_OR, _mask, _value, 0)
>   
> -enum probes_insn {
> -	INSN_REJECTED,
> -	INSN_GOOD,
> -	INSN_GOOD_NO_SLOT
> -};
>   
>   struct decode_reject {
>   	struct decode_header	header;
> 

-- 
Julien Thierry
