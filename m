Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73993C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ED52084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ED52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeJERQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:16:56 -0400
Received: from foss.arm.com ([217.140.101.70]:49462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeJERQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE72480D;
        Fri,  5 Oct 2018 03:18:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBFF93F5A0;
        Fri,  5 Oct 2018 03:18:46 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:18:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Manjeet Pawar <manjeet.p@samsung.com>
Cc:     linux@armlinux.org.uk, ebiederm@xmission.com, arnd@arndb.de,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Rohit Thapliyal <r.thapliyal@samsung.com>
Subject: Re: [PATCH] traps:Recover undefined user instruction on ARM
Message-ID: <20181005101843.5tmvf4hwld5dbotj@lakrids.cambridge.arm.com>
References: <CGME20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba@epcas5p3.samsung.com>
 <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:15:57AM +0530, Manjeet Pawar wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com> 
> 
> During user undefined instruction exception, the arm exception
> handler currently results in application crash through SIGILL.
> The bad instruction can be due to ddr/hardware issue.

If the DDR controller can return invalid data, then there is simply no
software workaround.

What if the invalid data happens to be valid opcodes? Those would be
executed by the CPU resulting in invalid behaviour, no matter what this
patch does.

What if this occurs for kernel text? The kernel will die.

What about data, in kernel or userspace? Erroneous behaviour would
result.

What about the page tables? Very bad things would happen if those were
corrupted.

> For such cases, exception trap handler could try to recover the corrupted
> text by clearing pagetable entry of undefined instruction pc and trying to fetch
> the instruction opcode by generating major page fault.
> Resulting in loading the page with correct instruction from mapped file.
> If there is no error in root filesystem i.e. the opcode is intact
> in file, then filemap fault shall be able to recover
> the instruction and continue execution normally instead of crashing.
> 
> Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>

I appreciate it's frustrating to have hardware which is very close to
working, but unfortunately this patch cannot solve the problem it sets
out to, and I don't think that it makes sense to have this in mainline.

Thanks,
Mark.

> ---
>  arch/arm/kernel/traps.c | 100 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index badf02c..d971834 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/irq.h>
> +#include <linux/rmap.h>
>  
>  #include <linux/atomic.h>
>  #include <asm/cacheflush.h>
> @@ -51,6 +52,9 @@
>  };
>  
>  void *vectors_page;
> +#define MAX_UNDEF_RECOVERY_ATTEMPT     NR_CPUS
> +static DEFINE_RATELIMIT_STATE(undef_recov_rs, 10 * HZ, NR_CPUS);
> +static int undef_recovery_attempt;
>  
>  #ifdef CONFIG_DEBUG_USER
>  unsigned int user_debug;
> @@ -435,14 +439,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
>  	return fn ? fn(regs, instr) : 1;
>  }
>  
> -asmlinkage void do_undefinstr(struct pt_regs *regs)
> +static unsigned int getInstr(void __user *pc, struct pt_regs *regs)
>  {
> -	unsigned int instr;
> -	siginfo_t info;
> -	void __user *pc;
> -
> -	clear_siginfo(&info);
> -	pc = (void __user *)instruction_pointer(regs);
> +	unsigned int instr = 0;
>  
>  	if (processor_mode(regs) == SVC_MODE) {
>  #ifdef CONFIG_THUMB2_KERNEL
> @@ -472,11 +471,32 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>  			goto die_sig;
>  		instr = __mem_to_opcode_arm(instr);
>  	}
> +die_sig:
> +	return instr;
> +}
> +
> +asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
> +{
> +	unsigned int instr, instr2;
> +	siginfo_t info;
> +	void __user *pc;
> +	unsigned long addr;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +	clear_siginfo(&info);
>  
> -	if (call_undef_hook(regs, instr) == 0)
> +	pc = (void __user *)instruction_pointer(regs);
> +
> +	instr = getInstr(pc, regs);
> +
> +	if (instr && call_undef_hook(regs, instr) == 0)
>  		return;
>  
> -die_sig:
>  #ifdef CONFIG_DEBUG_USER
>  	if (user_debug & UDBG_UNDEFINED) {
>  		pr_info("%s (%d): undefined instruction: pc=%p\n",
> @@ -485,7 +505,67 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>  		dump_instr(KERN_INFO, regs);
>  	}
>  #endif
> -
> +	/* Trying to recover an invalid userspace instruction from here */
> +	if ((undef_recovery_attempt < MAX_UNDEF_RECOVERY_ATTEMPT) && __ratelimit(&undef_recov_rs)) {
> +		addr = (unsigned long) pc;
> +		if (processor_mode(regs) == USR_MODE) {
> +			struct page *page = NULL;
> +
> +			mm = current->mm;
> +			vma = find_vma(mm, (unsigned long)pc);
> +			if (!vma)
> +				goto fail_recovery;
> +
> +			if (!vma->vm_file)
> +				goto fail_recovery;
> +
> +			dump_instr(KERN_ALERT, regs);
> +			down_write(&mm->mmap_sem);
> +			/* Check first, just in case, recovery already done by some other thread simultaneously */
> +			flush_cache_range(vma, vma->vm_start, vma->vm_end);
> +			instr2 = getInstr(pc, regs);
> +			if (instr != instr2) {
> +				up_write(&mm->mmap_sem);
> +				return;
> +			}
> +			pgd = pgd_offset(vma->vm_mm, addr);
> +			pud = pud_offset(pgd, addr);
> +			if (!pud_present(*pud)) {
> +				up_write(&mm->mmap_sem);
> +				goto fail_recovery;
> +			}
> +			pmd = pmd_offset(pud, addr);
> +			if (!pmd_present(*pmd)) {
> +				up_write(&mm->mmap_sem);
> +				goto fail_recovery;
> +			}
> +			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +			if (!pte_present(*pte)) {
> +				pte_unmap_unlock(pte, ptl);
> +				up_write(&mm->mmap_sem);
> +				goto fail_recovery;
> +			}
> +			page = pte_page(*pte);
> +
> +			pte_clear(mm, address, pte);
> +			pte_unmap_unlock(pte, ptl);
> +			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +			page_remove_rmap(page, false);
> +			put_page(page);
> +			pte_unmap_unlock(pte, ptl);
> +
> +			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
> +			up_write(&mm->mmap_sem);
> +
> +			instr2 = getInstr(pc, regs);
> +			dump_instr(KERN_ALERT, regs);
> +			if (instr != instr2) {
> +				undef_recovery_attempt++;
> +				return;
> +			}
> +		}
> +	}
> +fail_recovery:
>  	info.si_signo = SIGILL;
>  	info.si_errno = 0;
>  	info.si_code  = ILL_ILLOPC;
> -- 
> 1.9.1
> 
