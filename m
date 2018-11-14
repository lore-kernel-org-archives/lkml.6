Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F50E223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3snnbKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F50E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbeKNSjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbeKNSjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:39:48 -0500
Received: from devnote (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAAD21582;
        Wed, 14 Nov 2018 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542184651;
        bh=xpgvujKl6MsiOcDRJYvT+oTRDgORjQdH0lMp9QldhrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W3snnbKNbkJstpNgnV7lParB+InGYUbHTpzvCDUkBhj33A3MybaslDBQzEYqeK5+B
         G8GZ6PZSZoAESpQgTSUP6UYrq1Y+5vblEHIGrYe/k8Z1EEIJhzP4UeMcUFb+bR8HL4
         f3Lj6qJDz4DCOpadxMTO7coIWVHEXH8s7FpmmGcE=
Date:   Wed, 14 Nov 2018 00:37:30 -0800
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>, Zong Li <zong@andestech.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jim Wilson <jimw@sifive.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC/RFT 2/2] RISC-V: kprobes/kretprobe support
Message-Id: <20181114003730.06f810517a270070734df4ce@kernel.org>
In-Reply-To: <20181113195804.22825-3-me@packi.ch>
References: <20181113195804.22825-1-me@packi.ch>
        <20181113195804.22825-3-me@packi.ch>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

Thank you very much for implementing kprobes on RISC-V :)

On Tue, 13 Nov 2018 20:58:04 +0100
Patrick Stählin <me@packi.ch> wrote:

> First implementation, adapted from arm64. The C.ADDISP16 instruction
> gets simulated and the kprobes-handler called by inserting a C.EBREAK
> instruction.
> 
> C.ADDISP16 was chosen as it sets-up the stack frame for functions.
> Some work has been done to support probes on non-compressed
> instructions but there is no support yet for decoding those.

Does this only support C.ADDISP16? No other insns are supported?
Supporting 1 insn is too few I think.

Can RISC-V do single stepping? If not, we need to prepare emulator
as match as possible, or for ALU instructions, we can run it on
buffer and hook it.

> The way forward should be to uncompress the instructions for simulation
> to reduce the number of instructions used to decode  the immediate
> values on probe hit.

I have some comments on the patch, please review.

> 
> Signed-off-by: Patrick Stählin <me@packi.ch>
> ---
>  arch/riscv/Kconfig                            |   5 +-
>  arch/riscv/include/asm/kprobes.h              |  30 ++
>  arch/riscv/include/asm/probes.h               |  26 ++
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/probes/Makefile             |   3 +
>  arch/riscv/kernel/probes/decode-insn.c        |  38 ++
>  arch/riscv/kernel/probes/decode-insn.h        |  23 +
>  arch/riscv/kernel/probes/kprobes.c            | 401 ++++++++++++++++++
>  arch/riscv/kernel/probes/kprobes_trampoline.S |  91 ++++
>  arch/riscv/kernel/probes/simulate-insn.c      |  33 ++
>  arch/riscv/kernel/probes/simulate-insn.h      |   8 +
>  arch/riscv/kernel/traps.c                     |  13 +-
>  arch/riscv/mm/fault.c                         |  28 +-
>  13 files changed, 694 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/probes.h
>  create mode 100644 arch/riscv/kernel/probes/Makefile
>  create mode 100644 arch/riscv/kernel/probes/decode-insn.c
>  create mode 100644 arch/riscv/kernel/probes/decode-insn.h
>  create mode 100644 arch/riscv/kernel/probes/kprobes.c
>  create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
>  create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
>  create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b157ac82d486..11ef4030e8f2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -44,6 +44,8 @@ config RISCV
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_KPROBES
> +	select HAVE_KRETPROBES
>  
>  config MMU
>  	def_bool y
> @@ -89,9 +91,6 @@ config PGTABLE_LEVELS
>  	default 3 if 64BIT
>  	default 2
>  
> -config HAVE_KPROBES
> -	def_bool n
> -
>  menu "Platform type"
>  
>  choice
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> index c7eb010d1528..657adcd35a3d 100644
> --- a/arch/riscv/include/asm/kprobes.h
> +++ b/arch/riscv/include/asm/kprobes.h
> @@ -19,4 +19,34 @@
>  
>  #include <asm-generic/kprobes.h>
>  
> +#ifdef CONFIG_KPROBES
> +#include <linux/types.h>
> +#include <linux/ptrace.h>
> +#include <linux/percpu.h>
> +
> +#define flush_insn_slot(p)		do { } while (0)
> +#define kretprobe_blacklist_size	0
> +
> +#include <asm/probes.h>
> +
> +struct prev_kprobe {
> +	struct kprobe *kp;
> +	unsigned int status;
> +};
> +
> +/* per-cpu kprobe control block */
> +struct kprobe_ctlblk {
> +	unsigned int kprobe_status;
> +	struct prev_kprobe prev_kprobe;
> +};
> +
> +void arch_remove_kprobe(struct kprobe *p);
> +int kprobe_fault_handler(struct pt_regs *regs, unsigned int cause);
> +int kprobe_exceptions_notify(struct notifier_block *self,
> +			     unsigned long val, void *data);
> +int kprobe_breakpoint_handler(struct pt_regs *regs);
> +void kretprobe_trampoline(void);
> +void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
> +
> +#endif /* CONFIG_KPROBES */
>  #endif /* _RISCV_KPROBES_H */
> diff --git a/arch/riscv/include/asm/probes.h b/arch/riscv/include/asm/probes.h
> new file mode 100644
> index 000000000000..64cf12567539
> --- /dev/null
> +++ b/arch/riscv/include/asm/probes.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Based on arch/arm64/include/asm/probes.h
> + *
> + * Copyright (C) 2013 Linaro Limited
> + */
> +#ifndef _RISCV_PROBES_H
> +#define _RISCV_PROBES_H
> +
> +typedef u32 probe_opcode_t;
> +typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
> +
> +/* architecture specific copy of original instruction */
> +struct arch_probe_insn {
> +	probes_handler_t *handler;
> +	/* restore address after simulation */
> +	unsigned long restore;
> +};
> +#ifdef CONFIG_KPROBES
> +typedef u32 kprobe_opcode_t;
> +struct arch_specific_insn {
> +	struct arch_probe_insn api;
> +};
> +#endif

Are there any reason of putting this kprobes dedicated data structure here?

> +
> +#endif /* _RISCV_PROBES_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f13f7f276639..5360a445b9d3 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -28,6 +28,7 @@ obj-y	+= stacktrace.o
>  obj-y	+= vdso.o
>  obj-y	+= cacheinfo.o
>  obj-y	+= vdso/
> +obj-y	+= probes/
>  
>  CFLAGS_setup.o := -mcmodel=medany
>  
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> new file mode 100644
> index 000000000000..144d1c1743fb
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o \
> +				   decode-insn.o simulate-insn.o
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
> new file mode 100644
> index 000000000000..2d8f46f4c2e7
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/module.h>
> +#include <linux/kallsyms.h>
> +#include <asm/sections.h>
> +
> +#include "decode-insn.h"
> +#include "simulate-insn.h"
> +
> +#define C_ADDISP16_MASK 0x6F83
> +#define C_ADDISP16_VAL  0x6101
> +
> +/* Return:
> + *   INSN_REJECTED     If instruction is one not allowed to kprobe,
> + *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
> + */
> +enum probe_insn __kprobes
> +riscv_probe_decode_insn(kprobe_opcode_t *addr, struct arch_probe_insn *api)

Please don't use __kprobes anymore. That is old stlye, instead, please
use NOKPROBE_SYMBOL() or nokprobe_inline for static-inline function.
(NOKPROBE_SYMBOL() will make the symbol non-inline always)

> +{
> +	probe_opcode_t insn = le32_to_cpu(*addr);
> +
> +	if (!is_compressed_insn(insn)) {
> +		pr_warn("Can't handle non-compressed instruction %x\n", insn);
> +		return INSN_REJECTED;
> +	}
> +
> +	/* c.addisp16 imm */
> +	if ((insn & C_ADDISP16_MASK) == C_ADDISP16_VAL) {
> +		api->handler = simulate_caddisp16;
> +	} else {
> +		pr_warn("Rejected unknown instruction %x\n", insn);
> +		return INSN_REJECTED;
> +	}
> +
> +	return INSN_GOOD_NO_SLOT;
> +}
> diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
> new file mode 100644
> index 000000000000..0053ed6a308a
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/decode-insn.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _RISCV_KERNEL_KPROBES_DECODE_INSN_H
> +#define _RISCV_KERNEL_KPROBES_DECODE_INSN_H
> +
> +#include <asm/sections.h>
> +#include <asm/kprobes.h>
> +
> +enum probe_insn {
> +	INSN_REJECTED,
> +	INSN_GOOD_NO_SLOT,
> +};
> +
> +/*
> + * Compressed instruction format:
> + * xxxxxxxxxxxxxxaa where aa != 11
> + */
> +#define is_compressed_insn(insn) ((insn & 0x3) != 0x3)
> +
> +#ifdef CONFIG_KPROBES
> +enum probe_insn __kprobes
> +riscv_probe_decode_insn(kprobe_opcode_t *addr, struct arch_probe_insn *asi);
> +#endif
> +#endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> new file mode 100644
> index 000000000000..3c7b5cf72ee1
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Kprobes support for RISC-V
> + *
> + * Author: Patrick Stählin <me@packi.ch>
> + */
> +#include <linux/kprobes.h>
> +#include <linux/extable.h>
> +#include <linux/slab.h>
> +#include <asm/ptrace.h>
> +#include <linux/uaccess.h>
> +#include <asm/sections.h>
> +
> +#include "decode-insn.h"
> +
> +DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> +
> +static void __kprobes
> +post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> +
> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +{
> +	if (is_compressed_insn(opcode))
> +		*(u16 *)addr = cpu_to_le16(opcode);
> +	else
> +		*addr = cpu_to_le32(opcode);
> +
> +	return 0;
> +}
> +
> +static void __kprobes arch_prepare_simulate(struct kprobe *p)
> +{
> +	unsigned long offset = is_compressed_insn(p->opcode) ? 2 : 4;
> +
> +	p->ainsn.api.restore = (unsigned long)p->addr + offset;
> +}
> +
> +static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	if (p->ainsn.api.handler)
> +		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);

it seems api.handler must be here, 

> +
> +	/* single instruction simulated, now go for post processing */
> +	post_kprobe_handler(kcb, regs);
> +}
> +
> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
> +{
> +	unsigned long probe_addr = (unsigned long)p->addr;
> +	extern char __start_rodata[];
> +	extern char __end_rodata[];
> +
> +	if (probe_addr & 0x1) {
> +		pr_warn("Address not aligned.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* copy instruction */
> +	p->opcode = le32_to_cpu(*p->addr);
> +
> +	if (probe_addr >= (unsigned long) __start_rodata &&
> +	    probe_addr <= (unsigned long) __end_rodata) {
> +		return -EINVAL;
> +	}
> +
> +	/* decode instruction */
> +	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
> +	case INSN_REJECTED:	/* insn not supported */
> +		return -EINVAL;
> +
> +	case INSN_GOOD_NO_SLOT:	/* insn needs simulation */
> +		break;
> +	}
> +
> +	arch_prepare_simulate(p);
> +
> +	return 0;
> +}
> +
> +#define C_EBREAK_OPCODE 0x9002
> +
> +/* arm kprobe: install breakpoint in text */
> +void __kprobes arch_arm_kprobe(struct kprobe *p)
> +{
> +	patch_text(p->addr, C_EBREAK_OPCODE);
> +}
> +
> +/* disarm kprobe: remove breakpoint from text */
> +void __kprobes arch_disarm_kprobe(struct kprobe *p)
> +{
> +	patch_text(p->addr, p->opcode);
> +}
> +
> +void __kprobes arch_remove_kprobe(struct kprobe *p)
> +{
> +}
> +
> +static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	kcb->prev_kprobe.kp = kprobe_running();
> +	kcb->prev_kprobe.status = kcb->kprobe_status;
> +}
> +
> +static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
> +{
> +	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
> +	kcb->kprobe_status = kcb->prev_kprobe.status;
> +}
> +
> +static void __kprobes set_current_kprobe(struct kprobe *p)
> +{
> +	__this_cpu_write(current_kprobe, p);
> +}
> +
> +static void __kprobes simulate(struct kprobe *p,
> +			       struct pt_regs *regs,
> +			       struct kprobe_ctlblk *kcb, int reenter)
> +{
> +	if (reenter) {
> +		save_previous_kprobe(kcb);
> +		set_current_kprobe(p);
> +		kcb->kprobe_status = KPROBE_REENTER;
> +	} else {
> +		kcb->kprobe_status = KPROBE_HIT_SS;
> +	}
> +
> +	arch_simulate_insn(p, regs);
> +}
> +
> +static int __kprobes reenter_kprobe(struct kprobe *p,
> +				    struct pt_regs *regs,
> +				    struct kprobe_ctlblk *kcb)
> +{
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SSDONE:
> +	case KPROBE_HIT_ACTIVE:
> +		kprobes_inc_nmissed_count(p);
> +		simulate(p, regs, kcb, 1);
> +		break;
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		pr_warn("Unrecoverable kprobe detected.\n");
> +		dump_kprobe(p);
> +		BUG();
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return 0;
> +	}
> +
> +	return 1;

If this always return 1, we can make it void return.

> +}
> +
> +static void __kprobes
> +post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
> +{
> +	struct kprobe *cur = kprobe_running();
> +
> +	if (!cur)
> +		return;
> +
> +	/* return addr restore if non-branching insn */
> +	if (cur->ainsn.api.restore != 0)
> +		instruction_pointer_set(regs, cur->ainsn.api.restore);
> +
> +	/* restore back original saved kprobe variables and continue */
> +	if (kcb->kprobe_status == KPROBE_REENTER) {
> +		restore_previous_kprobe(kcb);
> +		return;
> +	}
> +	/* call post handler */
> +	kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +	if (cur->post_handler)	{
> +		/* post_handler can hit breakpoint and single step
> +		 * again, so we enable D-flag for recursive exception.
> +		 */
> +		cur->post_handler(cur, regs, 0);
> +	}
> +
> +	reset_current_kprobe();
> +}
> +
> +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int cause)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		/*
> +		 * We are here because the instruction being single
> +		 * stepped caused a page fault. We reset the current
> +		 * kprobe and the ip points back to the probe address
> +		 * and allow the page fault handler to continue as a
> +		 * normal page fault.
> +		 */
> +		instruction_pointer_set(regs, (unsigned long) cur->addr);
> +		if (!instruction_pointer(regs))
> +			BUG();

Use BUG_ON().

> +
> +		if (kcb->kprobe_status == KPROBE_REENTER)
> +			restore_previous_kprobe(kcb);
> +		else
> +			reset_current_kprobe();
> +
> +		break;
> +	case KPROBE_HIT_ACTIVE:
> +	case KPROBE_HIT_SSDONE:
> +		/*
> +		 * We increment the nmissed count for accounting,
> +		 * we can also use npre/npostfault count for accounting
> +		 * these specific fault cases.
> +		 */
> +		kprobes_inc_nmissed_count(cur);
> +
> +		/*
> +		 * We come here because instructions in the pre/post
> +		 * handler caused the page_fault, this could happen
> +		 * if handler tries to access user space by
> +		 * copy_from_user(), get_user() etc. Let the
> +		 * user-specified handler try to fix it first.
> +		 */
> +		if (cur->fault_handler && cur->fault_handler(cur, regs, cause))
> +			return 1;
> +
> +		/*
> +		 * In case the user-specified fault handler returned
> +		 * zero, try to fix up.
> +		 */
> +		if (fixup_exception(regs))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void __kprobes kprobe_handler(struct pt_regs *regs)
> +{

Does this handler run under local IRQ disabled? (for making sure)

> +	struct kprobe *p, *cur_kprobe;
> +	struct kprobe_ctlblk *kcb;
> +	unsigned long addr = instruction_pointer(regs);
> +
> +	kcb = get_kprobe_ctlblk();
> +	cur_kprobe = kprobe_running();
> +
> +	p = get_kprobe((kprobe_opcode_t *) addr);
> +
> +	if (p) {
> +		if (cur_kprobe) {
> +			if (reenter_kprobe(p, regs, kcb))
> +				return;
> +		} else {
> +			/* Probe hit */
> +			set_current_kprobe(p);
> +			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +
> +			/*
> +			 * If we have no pre-handler or it returned 0, we
> +			 * continue with normal processing.  If we have a
> +			 * pre-handler and it returned non-zero, it will
> +			 * modify the execution path and no need to single
> +			 * stepping. Let's just reset current kprobe and exit.
> +			 *
> +			 * pre_handler can hit a breakpoint and can step thru
> +			 * before return, keep PSTATE D-flag enabled until
> +			 * pre_handler return back.

Is this true on RISC-V too?

> +			 */
> +			if (!p->pre_handler || !p->pre_handler(p, regs))
> +				simulate(p, regs, kcb, 0);
> +			else
> +				reset_current_kprobe();
> +		}
> +	}
> +	/*
> +	 * The breakpoint instruction was removed right
> +	 * after we hit it.  Another cpu has removed
> +	 * either a probepoint or a debugger breakpoint
> +	 * at this address.  In either case, no further
> +	 * handling of this interrupt is appropriate.
> +	 * Return back to original instruction, and continue.
> +	 */

This should return 0 if it doesn't handle anything, but if it handles c.break
should return 1.

> +}
> +
> +int __kprobes
> +kprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +	kprobe_handler(regs);
> +	return 1;

Why don't you call kprobe_handler directly?

> +}
> +
> +bool arch_within_kprobe_blacklist(unsigned long addr)
> +{
> +	if ((addr >= (unsigned long)__kprobes_text_start &&
> +	    addr < (unsigned long)__kprobes_text_end) ||
> +	    (addr >= (unsigned long)__entry_text_start &&
> +	    addr < (unsigned long)__entry_text_end) ||
> +	    !!search_exception_tables(addr))
> +		return true;
> +
> +	return false;
> +}
> +
> +void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> +{
> +	struct kretprobe_instance *ri = NULL;
> +	struct hlist_head *head, empty_rp;
> +	struct hlist_node *tmp;
> +	unsigned long flags, orig_ret_address = 0;
> +	unsigned long trampoline_address =
> +		(unsigned long)&kretprobe_trampoline;
> +	kprobe_opcode_t *correct_ret_addr = NULL;
> +

	It seems you don't setup instruction_pointer.

> +	INIT_HLIST_HEAD(&empty_rp);
> +	kretprobe_hash_lock(current, &head, &flags);
> +
> +	/*
> +	 * It is possible to have multiple instances associated with a given
> +	 * task either because multiple functions in the call path have
> +	 * return probes installed on them, and/or more than one
> +	 * return probe was registered for a target function.
> +	 *
> +	 * We can handle this because:
> +	 *     - instances are always pushed into the head of the list
> +	 *     - when multiple return probes are registered for the same
> +	 *	 function, the (chronologically) first instance's ret_addr
> +	 *	 will be the real return address, and all the rest will
> +	 *	 point to kretprobe_trampoline.
> +	 */
> +	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> +		if (ri->task != current)
> +			/* another task is sharing our hash bucket */
> +			continue;
> +
> +		orig_ret_address = (unsigned long)ri->ret_addr;
> +
> +		if (orig_ret_address != trampoline_address)
> +			/*
> +			 * This is the real return address. Any other
> +			 * instances associated with this task are for
> +			 * other calls deeper on the call stack
> +			 */
> +			break;
> +	}
> +
> +	kretprobe_assert(ri, orig_ret_address, trampoline_address);
> +
> +	correct_ret_addr = ri->ret_addr;
> +	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> +		if (ri->task != current)
> +			/* another task is sharing our hash bucket */
> +			continue;
> +
> +		orig_ret_address = (unsigned long)ri->ret_addr;
> +		if (ri->rp && ri->rp->handler) {
> +			__this_cpu_write(current_kprobe, &ri->rp->kp);
> +			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> +			ri->ret_addr = correct_ret_addr;
> +			ri->rp->handler(ri, regs);
> +			__this_cpu_write(current_kprobe, NULL);
> +		}
> +
> +		recycle_rp_inst(ri, &empty_rp);
> +
> +		if (orig_ret_address != trampoline_address)
> +			/*
> +			 * This is the real return address. Any other
> +			 * instances associated with this task are for
> +			 * other calls deeper on the call stack
> +			 */
> +			break;
> +	}
> +
> +	kretprobe_hash_unlock(current, &flags);
> +
> +	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> +		hlist_del(&ri->hlist);
> +		kfree(ri);
> +	}
> +	return (void *)orig_ret_address;
> +}
> +
> +void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> +				      struct pt_regs *regs)
> +{
> +	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> +	regs->ra = (long)&kretprobe_trampoline;
> +}
> +
> +int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> +{
> +	return 0;
> +}
> +
> +int __init arch_init_kprobes(void)
> +{
> +	return 0;
> +}
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
> new file mode 100644
> index 000000000000..c7ceda9556a3
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +
> +	.text
> +	.altmacro
> +
> +	.macro save_all_base_regs
> +	REG_S x1,  PT_RA(sp)
> +	REG_S x3,  PT_GP(sp)
> +	REG_S x4,  PT_TP(sp)
> +	REG_S x5,  PT_T0(sp)
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
> +	REG_S x10, PT_A0(sp)
> +	REG_S x11, PT_A1(sp)
> +	REG_S x12, PT_A2(sp)
> +	REG_S x13, PT_A3(sp)
> +	REG_S x14, PT_A4(sp)
> +	REG_S x15, PT_A5(sp)
> +	REG_S x16, PT_A6(sp)
> +	REG_S x17, PT_A7(sp)
> +	REG_S x18, PT_S2(sp)
> +	REG_S x19, PT_S3(sp)
> +	REG_S x20, PT_S4(sp)
> +	REG_S x21, PT_S5(sp)
> +	REG_S x22, PT_S6(sp)
> +	REG_S x23, PT_S7(sp)
> +	REG_S x24, PT_S8(sp)
> +	REG_S x25, PT_S9(sp)
> +	REG_S x26, PT_S10(sp)
> +	REG_S x27, PT_S11(sp)
> +	REG_S x28, PT_T3(sp)
> +	REG_S x29, PT_T4(sp)
> +	REG_S x30, PT_T5(sp)
> +	REG_S x31, PT_T6(sp)
> +	.endm
> +
> +	.macro restore_all_base_regs
> +	REG_L x3,  PT_GP(sp)
> +	REG_L x4,  PT_TP(sp)
> +	REG_L x5,  PT_T0(sp)
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
> +	REG_L x10, PT_A0(sp)
> +	REG_L x11, PT_A1(sp)
> +	REG_L x12, PT_A2(sp)
> +	REG_L x13, PT_A3(sp)
> +	REG_L x14, PT_A4(sp)
> +	REG_L x15, PT_A5(sp)
> +	REG_L x16, PT_A6(sp)
> +	REG_L x17, PT_A7(sp)
> +	REG_L x18, PT_S2(sp)
> +	REG_L x19, PT_S3(sp)
> +	REG_L x20, PT_S4(sp)
> +	REG_L x21, PT_S5(sp)
> +	REG_L x22, PT_S6(sp)
> +	REG_L x23, PT_S7(sp)
> +	REG_L x24, PT_S8(sp)
> +	REG_L x25, PT_S9(sp)
> +	REG_L x26, PT_S10(sp)
> +	REG_L x27, PT_S11(sp)
> +	REG_L x28, PT_T3(sp)
> +	REG_L x29, PT_T4(sp)
> +	REG_L x30, PT_T5(sp)
> +	REG_L x31, PT_T6(sp)
> +	.endm
> +
> +ENTRY(kretprobe_trampoline)
> +	addi sp, sp, -(PT_SIZE_ON_STACK)
> +	save_all_base_regs
> +
> +	move a0, sp /* pt_regs */
> +
> +	call trampoline_probe_handler
> +
> +	/* use the result as the return-address */
> +	move ra, a0
> +
> +	restore_all_base_regs
> +	addi sp, sp, PT_SIZE_ON_STACK
> +
> +	ret
> +ENDPROC(kretprobe_trampoline)
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> new file mode 100644
> index 000000000000..5734d9bae22f
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +
> +#include "simulate-insn.h"
> +
> +#define bit_at(value, bit)		((value) & (1 << (bit)))
> +#define move_bit_at(value, bit, to)	((bit_at(value, bit) >> bit) << to)
> +
> +void __kprobes
> +simulate_caddisp16(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	s16 imm;
> +
> +	/*
> +	 * Immediate value layout in c.addisp16:
> +	 * xxx9 xxxx x468 75xx
> +	 * 1  1    8    4    0
> +	 * 5  2
> +	 */
> +	imm = sign_extend32(
> +		move_bit_at(opcode, 12, 9) |
> +		move_bit_at(opcode, 6, 4) |
> +		move_bit_at(opcode, 5, 6) |
> +		move_bit_at(opcode, 4, 8) |
> +		move_bit_at(opcode, 3, 7) |
> +		move_bit_at(opcode, 2, 5),
> +		9);
> +
> +	regs->sp += imm;

What about updating regs->sepc?

> +}
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
> new file mode 100644
> index 000000000000..dc2c06c30167
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H
> +#define _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H
> +
> +void simulate_caddisp16(u32 opcode, long addr, struct pt_regs *regs);
> +
> +#endif /* _RISCV_KERNEL_KPROBES_SIMULATE_INSN_H */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 24a9333dda2c..d7113178d401 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/signal.h>
>  #include <linux/kdebug.h>
> +#include <linux/kprobes.h>
>  #include <linux/uaccess.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> @@ -120,8 +121,14 @@ DO_ERROR_INFO(do_trap_ecall_m,
>  
>  asmlinkage void do_trap_break(struct pt_regs *regs)
>  {
> +	bool handler_found = false;
> +
> +#ifdef CONFIG_KPROBES
> +	if (kprobe_breakpoint_handler(regs))
> +		handler_found = 1;

Why don't you just return from here?

> +#endif
>  #ifdef CONFIG_GENERIC_BUG
> -	if (!user_mode(regs)) {
> +	if (!handler_found && !user_mode(regs)) {
>  		enum bug_trap_type type;
>  
>  		type = report_bug(regs->sepc, regs);
> @@ -137,7 +144,9 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
>  	}
>  #endif /* CONFIG_GENERIC_BUG */
>  
> -	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc), current);
> +	if (!handler_found)
> +		force_sig_fault(SIGTRAP, TRAP_BRKPT,
> +			(void __user *)(regs->sepc), current);
>  }
>  
>  #ifdef CONFIG_GENERIC_BUG
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 88401d5125bc..eff816e33479 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/kernel.h>
> +#include <linux/kprobes.h>
>  #include <linux/interrupt.h>
>  #include <linux/perf_event.h>
>  #include <linux/signal.h>
> @@ -30,11 +31,33 @@
>  #include <asm/pgalloc.h>
>  #include <asm/ptrace.h>
>  
> +#ifdef CONFIG_KPROBES
> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int cause)

please use nokprobe_inline.

> +{
> +	int ret = 0;
> +
> +	/* kprobe_running() needs smp_processor_id() */
> +	if (!user_mode(regs)) {
> +		preempt_disable();
> +		if (kprobe_running() && kprobe_fault_handler(regs, cause))
> +			ret = 1;
> +		preempt_enable();
> +	}
> +
> +	return ret;
> +}
> +#else
> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int cause)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * This routine handles page faults.  It determines the address and the
>   * problem, and then passes it off to one of the appropriate routines.
>   */
> -asmlinkage void do_page_fault(struct pt_regs *regs)
> +asmlinkage void __kprobes do_page_fault(struct pt_regs *regs)
>  {
>  	struct task_struct *tsk;
>  	struct vm_area_struct *vma;
> @@ -47,6 +70,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	cause = regs->scause;
>  	addr = regs->sbadaddr;
>  
> +	if (notify_page_fault(regs, cause))
> +		return;
> +
>  	tsk = current;
>  	mm = tsk->mm;
>  
> -- 
> 2.17.1
> 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
