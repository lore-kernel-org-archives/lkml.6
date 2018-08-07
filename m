Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89832217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T7Z+ctA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89832217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbeHGQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:14:18 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57533 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHGQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:14:17 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 376ED10C0FAC;
        Tue,  7 Aug 2018 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533650390; bh=4o19958GKQmmJBaUI34s+VPBXc4afI7y5fkP0F8/lrU=;
        h=From:To:Cc:Subject:Date:From;
        b=T7Z+ctA+lfSTGSel/Xyo+kAL9UgI12+HTNLrM4lNh1ZjJhtajjqsFeS5c3dH5I+Vr
         IQVmuxmMX0oqqr1Co5/nFktSRCqRR7qjZEpYLaYF392zJOWz+CdiQbr6jHvp31QGiZ
         JREgLkff/gr1sQaJCuPndHZ1BG+7fJiP8YjBi+UX6++uDu7YuNyUp7rFzRY9XUGtqE
         v3zapr+HJSrMMqInMUoNvSNQr+uv42CdJbgMLVNCarNSL4mPSBQ4WP3ZsCYsiWliak
         9hvYpvt5Lxx5tgMkQBINnTwhBSxDYtStHLbgRpRCSjmIj09PHkjL6ui4DLWmSjM8Ne
         mhgkCBgfDANBQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id C44EE3B69;
        Tue,  7 Aug 2018 06:59:48 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: prevent showing irrelevant exception info in signal message
Date:   Tue,  7 Aug 2018 16:59:45 +0300
Message-Id: <20180807135945.2948-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We process signals in the end of syscall/exception handler.
It the signal is fatal we print register's content using
show_regs function. show_regs() also prints information about
last exception happened.

In case of multicore system we can catch the situation when we
will print wrong information about exception. See the example:
______________________________
CPU-0: started to handle page fault
CPU-1: sent signal to process, which is executed on CPU-0
CPU-0: ended page fault handle. Started to process signal before
       returnig to userspace. Process signal, which is send from
       CPU-0. As th signal is fatal we call show_regs().
       show_regs() will show information about last exception
       which is *page fault* (instead of "trap" which is used for
       signals and happened on CPU-0)

So we will get message like this:
   # ./waitpid02
  potentially unexpected fatal signal 8.
  Path: /home/waitpid02
  CPU: 0 PID: 100 Comm: waitpid02 Not tainted 4.10.0-rc4 #2
  task: 9f11c200 task.stack: 9f3ae000

  [ECR   ]: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x000123ec
  [EFA   ]: 0x00000000
  [BLINK ]: 0x123ea
  [ERET  ]: 0x123ec
    @off 0x123ec in [/home/waitpid02]
    VMA: 0x00010000 to 0x00016000
  [STAT32]: 0x80080882 : IE U
  BTA: 0x000123ea  SP: 0x5ffd3db0  FP: 0x00000000
  LPS: 0x20031684 LPE: 0x2003169a LPC: 0x00000006
  [-----other-info-----]

This message is confusing because it show information about page fault
( [ECR   ]: 0x00050200 => Invalid Write ) which is absolutely irrelevant
to signal.

This situation was reproduced with waitpid02 LTP test.
_____________________________

So remove printing information about exceptions from show_regs()
to avoid confusing messages. Print information about exceptions
only in required places instead of show_regs()

Now we don't print information about exceptions if signal is simply
send by another userspace app. So in case of waitpid02 we will print
next message:
_____________________________
   # ./waitpid02
  potentially unexpected fatal signal 8.
  Path: /root/waitpid02
  CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
  [ECR   ]: 0x00050100
  [EFA   ]: 0x00000000
  [BLINK ]: 0x20001486
  [-----other-info-----]
_____________________________

This patch fix
STAR 9001146055: waitpid02: Invalid Write @ 0x00000000 by insn @ 0x000123ec

NOTE:
To be more clear I give examples of different faults (signal-based,
userspace/kernelspace exception-based) with different values of
"/proc/sys/kernel/print-fatal-signals" option.

0) NULL pointer access from user space, print-fatal-signals == 1:
------------>8---------------
 # ./arc_hell
Exception: arc_hell[103]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
  ECR: 0x00050100 => Invalid Read @ 0x00000000 by insn @ 0x2003a35c
potentially unexpected fatal signal 11.
Path: /root/arc_hell
CPU: 1 PID: 103 Comm: arc_hell Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
[ECR   ]: 0x00050100
[EFA   ]: 0x00000000
[BLINK ]: 0x20039ef8
[ERET  ]: 0x2003a35c
[STAT32]: 0x80080882 : IE U
BTA: 0x2003a358  SP: 0x5fa27dc4  FP: 0x5fa27de8
LPS: 0x2003a628 LPE: 0x2003a62c LPC: 0x00000000
r00: 0x00000000 r01: 0x200740b0 r02: 0x00000001
r03: 0x00000007 r04: 0x80808080 r05: 0x2f2f2f2f
r06: 0x7c7a2f43 r07: 0x00000000 r08: 0x1a131100
r09: 0x2008b1e0 r10: 0x20003a5c r11: 0x20004038
r12: 0x20039ef8 r13: 0x200740b0 r14: 0x00000000
r15: 0x200740b0 r16: 0x00000000 r17: 0x0007d468
r18: 0x0009313a r19: 0x00000000 r20: 0x0009c22c
r21: 0x0009c23c r22: 0x0009ab64 r23: 0x00000000
r24: 0x0009dfc5 r25: 0x20004b70

Segmentation fault
------------>8---------------

1) NULL pointer access from user space, print-fatal-signals == 0:
------------>8---------------
 # ./arc_hell
Exception: arc_hell[107]: at 0x2003a35c [off 0x2e35c in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
  ECR: 0x00050100 => Invalid Read @ 0x00000000 by insn @ 0x2003a35c
Segmentation fault
------------>8---------------

2) Process killed by signal (waitpid02 test), print-fatal-signals == 1:
------------>8---------------
 # ./waitpid02
potentially unexpected fatal signal 8.
Path: /root/waitpid02
CPU: 2 PID: 105 Comm: waitpid02 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #17
[ECR   ]: 0x00050100
[EFA   ]: 0x00000000
[BLINK ]: 0x20001486
[ERET  ]: 0x2000146c
[STAT32]: 0x80080082 : IE U
BTA: 0x20000fc4  SP: 0x5fa21d64  FP: 0x00000000
LPS: 0x200524a0 LPE: 0x200524b6 LPC: 0x00000006
r00: 0x2000c0dc r01: 0x00000018 r02: 0x0001159a
r03: 0x00000001 r04: 0x00000000 r05: 0x00000045
r06: 0x0000004e r07: 0x01010101 r08: 0x000000dc
r09: 0x200a31e0 r10: 0x20003a5c r11: 0x20004038
r12: 0x20001486 r13: 0x20004174 r14: 0x07ca2bc0
r15: 0x20004078 r16: 0x00000000 r17: 0x20004038
r18: 0x00000001 r19: 0x00000000 r20: 0x0001159a
r21: 0x00000001 r22: 0x00000000 r23: 0x00000004
r24: 0x2000d1fc r25: 0x20004cd0
------------>8---------------

3) Process killed by signal (waitpid02 test), print-fatal-signals == 0:
------------>8---------------
 # ./waitpid02
------------>8---------------

4) NULL pointer access from kernel space, regardless print-fatal-signals
value:
------------>8---------------
Oops
Exception: at stmmac_dvr_probe+0x40/0x7e0:
  ECR: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x90575254
Path: (null)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc8-00002-gde0f6d6aeb53-dirty #11
[EFA   ]: 0x00000000
[BLINK ]: stmmac_dvr_probe+0x2a/0x7e0
[ERET  ]: stmmac_dvr_probe+0x40/0x7e0
[STAT32]: 0x80080402 : IE K
BTA: 0x9057523e  SP: 0xbf02be40  FP: 0x00000000
LPS: 0x9073dbcc LPE: 0x9073dbe0 LPC: 0x00000000
r00: 0xbf1f0000 r01: 0x00000000 r02: 0x00000008
r03: 0x00000000 r04: 0x00000064 r05: 0x00000000
r06: 0x00000003 r07: 0x00000004 r08: 0x01010101
r09: 0x00000031 r10: 0xbf1f0006 r11: 0x00000000
r12: 0x9057523e

Stack Trace:
  stmmac_dvr_probe+0x40/0x7e0
  dwmac_generic_probe+0x50/0xbc
  platform_drv_probe+0x26/0x5c
  really_probe+0x3b0/0x464
  __driver_attach+0xd4/0xd8
  bus_for_each_dev+0x3a/0x70
  bus_add_driver+0x12a/0x18c
  driver_register+0x56/0xe8
  do_one_initcall+0x2e/0x118
  kernel_init_freeable+0x102/0x194
------------>8---------------

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---

NOTE:
  This patch has prerequisites:
  https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03938.html
  https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03937.html

Changes v1->v2:
 * Change format of message about exception.

 arch/arc/include/asm/bug.h     |  1 +
 arch/arc/kernel/traps.c        |  1 +
 arch/arc/kernel/troubleshoot.c | 51 +++++++++++++++++++++++++++++++++---------
 arch/arc/mm/fault.c            |  2 ++
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index 21ec82466d62..b68f7f82f2d8 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -16,6 +16,7 @@
 struct task_struct;
 
 void show_regs(struct pt_regs *regs);
+void show_exception_mesg(struct pt_regs *regs);
 void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 			    unsigned long address);
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index b123558bf0bb..5d83b2fe5f12 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -50,6 +50,7 @@ unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
 		tsk->thread.fault_address = (__force unsigned int)info->si_addr;
 
 		force_sig_info(info->si_signo, info, tsk);
+		show_exception_mesg(regs);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index e8d9fb452346..fdfba1942a06 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -101,13 +101,13 @@ static void show_faulting_vma(unsigned long address, char *buf)
 			if (IS_ERR(nm))
 				nm = "?";
 		}
-		pr_info("    @off 0x%lx in [%s]\n"
-			"    VMA: 0x%08lx to 0x%08lx\n",
+
+		pr_cont("[off 0x%lx in %s, VMA: %08lx:%08lx] ",
 			vma->vm_start < TASK_UNMAPPED_BASE ?
 				address : address - vma->vm_start,
 			nm, vma->vm_start, vma->vm_end);
 	} else
-		pr_info("    @No matching VMA found\n");
+		pr_cont("[No matching VMA found] ");
 
 	up_read(&active_mm->mmap_sem);
 }
@@ -117,7 +117,7 @@ static void show_ecr_verbose(struct pt_regs *regs)
 	unsigned int vec, cause_code;
 	unsigned long address;
 
-	pr_info("\n[ECR   ]: 0x%08lx => ", regs->event);
+	pr_cont("\n  ECR: 0x%08lx => ", regs->event);
 
 	/* For Data fault, this is data address not instruction addr */
 	address = current->thread.fault_address;
@@ -165,10 +165,42 @@ static void show_ecr_verbose(struct pt_regs *regs)
 	}
 }
 
+static inline void show_exception_mesg_u(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	char *buf;
+
+	pr_info("Exception: %s[%d]: at %pS ",
+		tsk->comm, task_pid_nr(tsk), (void *)regs->ret);
+
+	buf = (char *)__get_free_page(GFP_NOWAIT);
+	if (buf) {
+		show_faulting_vma(regs->ret, buf);
+		free_page((unsigned long)buf);
+	}
+
+	show_ecr_verbose(regs);
+}
+
+static inline void show_exception_mesg_k(struct pt_regs *regs)
+{
+	pr_info("Exception: at %pS:", (void *)regs->ret);
+
+	show_ecr_verbose(regs);
+}
+
 /************************************************************************
  *  API called by rest of kernel
  ***********************************************************************/
 
+void show_exception_mesg(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		show_exception_mesg_u(regs);
+	else
+		show_exception_mesg_k(regs);
+}
+
 void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
@@ -182,15 +214,10 @@ void show_regs(struct pt_regs *regs)
 	print_task_path_n_nm(tsk, buf);
 	show_regs_print_info(KERN_INFO);
 
-	show_ecr_verbose(regs);
-
-	pr_info("[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",
-		current->thread.fault_address,
+	pr_info("[ECR   ]: 0x%08lx\n[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",
+		regs->event, current->thread.fault_address,
 		(void *)regs->blink, (void *)regs->ret);
 
-	if (user_mode(regs))
-		show_faulting_vma(regs->ret, buf); /* faulting code, not data */
-
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
 #define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit" " : ""
@@ -233,6 +260,8 @@ void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 	/* Show fault description */
 	pr_info("\n%s\n", str);
 
+	show_exception_mesg(regs);
+
 	/* Caller and Callee regs */
 	show_regs(regs);
 
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index b884bbd6f354..d9c6958a1702 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -202,6 +202,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		/* info.si_code has been set above */
 		info.si_addr = (void __user *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		show_exception_mesg(regs);
 		return;
 	}
 
@@ -241,4 +242,5 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
+	show_exception_mesg(regs);
 }
-- 
2.14.4

