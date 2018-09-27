Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA3C216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3C216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeI0WhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:37:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeI0WhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A19E7A9;
        Thu, 27 Sep 2018 09:18:19 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.emea.arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792283F5B3;
        Thu, 27 Sep 2018 09:18:16 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
To:     Maciej Slodczyk <m.slodczyk2@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
 <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <918e1f6e-ab89-cae9-fb9c-9402f79bf1b4@arm.com>
Date:   Thu, 27 Sep 2018 17:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 26/09/18 13:12, Maciej Slodczyk wrote:
> Detect what kind of instruction is being probed and depending on the
> result:
> - if an A64 instruction handle it the old way, using existing A64
> instructions probing code,
> - if an A32 instruction decode it and handle using the new code, moved
> from 32 bit arm kernel tree.
> 
> Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
> ---
>   arch/arm64/kernel/debug-monitors.c |   8 +++
>   arch/arm64/kernel/probes/uprobes.c | 111 ++++++++++++++++++++++++++++++++++---
>   lib/probes/arm/actions-arm.c       |  35 ++++++++----
>   lib/probes/arm/decode-arm.c        |  16 +++++-
>   4 files changed, 148 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 06ca574..ee10c0b 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -366,6 +366,14 @@ int aarch32_break_handler(struct pt_regs *regs)
>   	if (!bp)
>   		return -EFAULT;
>   
> +	/*
> +	 * Since bp != false, a sofware breakpoint instruction is being handled.
> +	 * If in user mode (compat_user_mode() few lines above),
> +	 * try to handle it by an uprobe handler, if registered.
> +	 */
> +	if (!brk_handler((unsigned long)pc, BRK64_ESR_UPROBES, regs))
> +		return 0;
> +
>   	send_user_sigtrap(TRAP_BRKPT);
>   	return 0;
>   }
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index e7b8912..872c8ec 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -11,9 +11,49 @@
>   #include <asm/cacheflush.h>
>   
>   #include "decode-insn.h"
> +#include "decode.h"
> +#include "decode-arm.h"
> +#include <../../../arm/include/asm/opcodes.h>

I'm almost positive this is frowned upon. I don't see any headers from 
arch/arm every being included in arch/arm64.

>   
>   #define UPROBE_INV_FAULT_CODE	UINT_MAX
>   
> +uprobe_opcode_t get_swbp_insn(void)
> +{
> +	if (is_compat_task())
> +		return AARCH32_BREAK_ARM;
> +	else
> +		return UPROBE_SWBP_INSN;
> +}
> +
> +bool is_swbp_insn(uprobe_opcode_t *insn)
> +{
> +	return ((__mem_to_opcode_arm(*insn) & 0x0fffffff) ==
> +				(AARCH32_BREAK_ARM & 0x0fffffff)) ||
> +				*insn == UPROBE_SWBP_INSN;
> +}
> +
> +int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +	     unsigned long vaddr)
> +{
> +	if (auprobe->arch == UPROBE_AARCH32)
> +		return uprobe_write_opcode(auprobe, mm, vaddr,
> +				__opcode_to_mem_arm(auprobe->bp_insn));
> +	else
> +		return uprobe_write_opcode(auprobe, mm, vaddr,
> +				UPROBE_SWBP_INSN);
> +}
> +
> +int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +		unsigned long vaddr)
> +{
> +	if (auprobe->arch == UPROBE_AARCH32)
> +		return uprobe_write_opcode(auprobe, mm, vaddr,
> +				auprobe->orig_insn);
> +	else
> +		return uprobe_write_opcode(auprobe, mm, vaddr,
> +				*(uprobe_opcode_t *)&auprobe->insn);
> +}
> +
>   void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>   		void *src, unsigned long len)
>   {
> @@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   		unsigned long addr)
>   {
>   	probes_opcode_t insn;
> +	enum probes_insn retval;
> +	unsigned int bpinsn;
>   
> -	/* TODO: Currently we do not support AARCH32 instruction probing */
> -	if (mm->context.flags & MMCF_AARCH32)
> -		return -ENOTSUPP;
> -	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
> +	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
> +
> +	if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>   		return -EINVAL;
>   
> -	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
> +	/* check if AARCH32 */
> +	if (is_compat_task()) {
> +
> +		/* Thumb is not supported yet */
> +		if (addr & 0x3)
> +			return -EINVAL;

-ENOTSUPP?

Cheers,

Julien

> +
> +		retval = arm_probes_decode_insn(insn, &auprobe->api, false,
> +					     uprobes_probes_actions, NULL);
> +		auprobe->arch = UPROBE_AARCH32;
> +
> +		/*
> +		 * original instruction could have been modified
> +		 * when preparing for xol on AArch32
> +		 */
> +		auprobe->orig_insn = insn;
> +
> +		bpinsn = AARCH32_BREAK_ARM & 0x0fffffff;
> +		if (insn >= 0xe0000000) /* Unconditional instruction */
> +			bpinsn |= 0xe0000000;
> +		else /* Copy condition from insn */
> +			bpinsn |= insn & 0xf0000000;
> +
> +		auprobe->bp_insn = bpinsn;
> +	} else {
> +		retval = arm64_probes_decode_insn(insn, &auprobe->api);
> +		auprobe->arch = UPROBE_AARCH64;
> +	}
>   
> -	switch (arm64_probes_decode_insn(insn, &auprobe->api)) {
> +	switch (retval) {
>   	case INSN_REJECTED:
>   		return -EINVAL;
>   
> @@ -66,6 +134,9 @@ int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   {
>   	struct uprobe_task *utask = current->utask;
>   
> +	if (auprobe->prehandler)
> +		auprobe->prehandler(auprobe, &utask->autask, regs);
> +
>   	/* Initialize with an invalid fault code to detect if ol insn trapped */
>   	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
>   
> @@ -88,6 +159,9 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   
>   	user_disable_single_step(current);
>   
> +	if (auprobe->posthandler)
> +		auprobe->posthandler(auprobe, &utask->autask, regs);
> +
>   	return 0;
>   }
>   bool arch_uprobe_xol_was_trapped(struct task_struct *t)
> @@ -103,10 +177,24 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
>   	return false;
>   }
>   
> +bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
> +{
> +	probes_opcode_t insn = *(probes_opcode_t *)(&auprobe->insn[0]);
> +	pstate_check_t *check = (*aarch32_opcode_cond_checks[insn >> 28]);
> +
> +	if (auprobe->arch == UPROBE_AARCH64)
> +		return false;
> +
> +	if (!check(regs->pstate & 0xffffffff)) {
> +		instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> +		return true;
> +	}
> +	return false;
> +}
> +
>   bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   {
>   	probes_opcode_t insn;
> -	unsigned long addr;
>   
>   	if (!auprobe->simulate)
>   		return false;
> @@ -154,9 +242,14 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>   {
>   	unsigned long orig_ret_vaddr;
>   
> -	orig_ret_vaddr = procedure_link_pointer(regs);
>   	/* Replace the return addr with trampoline addr */
> -	procedure_link_pointer_set(regs, trampoline_vaddr);
> +	if (is_compat_task()) {
> +		orig_ret_vaddr = link_register(regs);
> +		link_register_set(regs, trampoline_vaddr);
> +	} else {
> +		orig_ret_vaddr = procedure_link_pointer(regs);
> +		procedure_link_pointer_set(regs, trampoline_vaddr);
> +	}
>   
>   	return orig_ret_vaddr;
>   }
> diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
> index 2393573..cee1496 100644
> --- a/lib/probes/arm/actions-arm.c
> +++ b/lib/probes/arm/actions-arm.c
> @@ -15,10 +15,7 @@
>   
>   #include "decode.h"
>   #include "decode-arm.h"
> -
> -#ifdef CONFIG_ARM64
>   #include <../../../arm/include/asm/opcodes.h>
> -#endif /* CONFIG_ARM64  */
>   
>   static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
>   {
> @@ -75,8 +72,13 @@ static void uprobe_set_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	autask->backup = pt_regs_read_reg(regs, pcreg);
> -	pt_regs_write_reg(regs, pcreg, instruction_pointer(regs) + 8);
> +	if (pcreg == 15) {
> +		autask->backup = instruction_pointer(regs);
> +		instruction_pointer_set(regs, instruction_pointer(regs) + 8);
> +	} else {
> +		autask->backup = pt_regs_read_reg(regs, pcreg);
> +		pt_regs_write_reg(regs, pcreg, instruction_pointer(regs) + 8);
> +	}
>   }
>   
>   static void uprobe_unset_pc(struct arch_uprobe *auprobe,
> @@ -84,7 +86,10 @@ static void uprobe_unset_pc(struct arch_uprobe *auprobe,
>   			    struct pt_regs *regs)
>   {
>   	/* PC will be taken care of by common code */
> -	pt_regs_write_reg(regs, auprobe->pcreg, autask->backup);
> +	if (auprobe->pcreg == 15)
> +		instruction_pointer_set(regs, autask->backup);
> +	else
> +		pt_regs_write_reg(regs, auprobe->pcreg, autask->backup);
>   }
>   
>   static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
> @@ -93,8 +98,13 @@ static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	alu_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> -	pt_regs_write_reg(regs, pcreg, autask->backup);
> +	if (pcreg == 15) {
> +		alu_write_pc(instruction_pointer(regs), regs);
> +		instruction_pointer_set(regs, autask->backup);
> +	} else {
> +		alu_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> +		pt_regs_write_reg(regs, pcreg, autask->backup);
> +	}
>   }
>   
>   static void uprobe_write_pc(struct arch_uprobe *auprobe,
> @@ -103,8 +113,13 @@ static void uprobe_write_pc(struct arch_uprobe *auprobe,
>   {
>   	u32 pcreg = auprobe->pcreg;
>   
> -	load_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> -	pt_regs_write_reg(regs, pcreg, autask->backup);
> +	if (pcreg == 15) {
> +		load_write_pc(instruction_pointer(regs), regs);
> +		instruction_pointer_set(regs, autask->backup);
> +	} else {
> +		load_write_pc(pt_regs_read_reg(regs, pcreg), regs);
> +		pt_regs_write_reg(regs, pcreg, autask->backup);
> +	}
>   }
>   
>   enum probes_insn
> diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
> index 36eb939..2f2a810 100644
> --- a/lib/probes/arm/decode-arm.c
> +++ b/lib/probes/arm/decode-arm.c
> @@ -87,11 +87,18 @@ void __kprobes simulate_blx2bx(probes_opcode_t insn,
>   		struct arch_probes_insn *asi, struct pt_regs *regs)
>   {
>   	int rm = insn & 0xf;
> -	long rmv = pt_regs_read_reg(regs, rm);
> +	long rmv;
>   	long cpsr;
>   
> +	if (rm == 15)
> +		rmv = (long) instruction_pointer(regs);
> +	else
> +		rmv = pt_regs_read_reg(regs, rm);
> +
>   	if (insn & (1 << 5))
> -		link_register_set(regs, (long) instruction_pointer(regs));
> +		link_register_set(regs,
> +				(long) instruction_pointer(regs)
> +					+ ARM_COMPAT_LR_OFFSET);
>   
>   	instruction_pointer_set(regs, rmv & ~0x1);
>   	cpsr = state_register(regs) & ~PSR_T_BIT;
> @@ -108,7 +115,10 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
>   	int rd = (insn >> 12) & 0xf;
>   	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
>   
> -	pt_regs_write_reg(regs, rd, state_register(regs) & mask);
> +	if (rd == 15)
> +		instruction_pointer_set(regs, state_register(regs) & mask);
> +	else
> +		pt_regs_write_reg(regs, rd, state_register(regs) & mask);
>   }
>   
>   void __kprobes simulate_mov_ipsp(probes_opcode_t insn,
> 

-- 
Julien Thierry
