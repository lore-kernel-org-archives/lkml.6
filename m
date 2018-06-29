Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF790C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5222A27D8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KDrZYLNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5222A27D8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936708AbeF2TjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:39:13 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54895 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeF2TjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:39:12 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A519524E0710;
        Fri, 29 Jun 2018 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530301151; bh=+WVB5VrNFr5ox+tYnVUXNPZoRTeKsMRfz8en9PAykJE=;
        h=From:To:Cc:Subject:Date:From;
        b=KDrZYLNLZRxz6N4mQivPNA+eKqLxcW5lGpDQzAL8kHH818IBiECZ6q0GjkDJzEpYy
         xWlIegcR9JhI0K3MOOi0kl17LaqwCqGnJC1enzI1TU6OaPF+3btyk97uZfLrtTc5pp
         XGXntcJ8c927z7n2Gk2veuxxXimq8k13lh/LDnEHrSPIq8d/F6Nw0RNOA4g4j2XMXk
         RwZfb+xO4qRSRBvf8fICMB8pG0ztFNTalINQY2F4/Y4IPSWrcZWYiv2YnwcunL7WnQ
         0N8PzU1KxXeNWEhUY2bAatY2gDFFAjQ3WGBY4ygQBNJ2QjEEQoo+lgdkaNAEHMyL3j
         fwSUgv5MQlRYw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.53])
        by mailhost.synopsys.com (Postfix) with ESMTP id 01B065AE9;
        Fri, 29 Jun 2018 12:39:09 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: prevent showing irrelevant exception info in signal message
Date:   Fri, 29 Jun 2018 22:39:07 +0300
Message-Id: <20180629193907.17227-1-Eugeniy.Paltsev@synopsys.com>
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
    /home/waitpid02
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
    ./waitpid02
  potentially unexpected fatal signal 8.
  [STAT32]: 0x80080082 : IE U
  BTA: 0x20000fc4	 SP: 0x5ff8bd64	 FP: 0x00000000
  LPS: 0x200524a0	LPE: 0x200524b6	LPC: 0x00000006
  [-----other-info-----]
_____________________________

This patch fix
STAR 9001146055: waitpid02: Invalid Write @ 0x00000000 by insn @ 0x000123ec

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/bug.h     |  1 +
 arch/arc/kernel/traps.c        |  1 +
 arch/arc/kernel/troubleshoot.c | 27 ++++++++++++++++++++-------
 arch/arc/mm/fault.c            |  2 ++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index 21ec82466d62..b9fd60f7d36b 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -16,6 +16,7 @@
 struct task_struct;
 
 void show_regs(struct pt_regs *regs);
+void show_exception_regs(struct pt_regs *regs);
 void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 			    unsigned long address);
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index b123558bf0bb..fe41f0d9488f 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -50,6 +50,7 @@ unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
 		tsk->thread.fault_address = (__force unsigned int)info->si_addr;
 
 		force_sig_info(info->si_signo, info, tsk);
+		show_exception_regs(regs);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 783b20354f8b..313aea25e638 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -170,14 +170,9 @@ static void show_ecr_verbose(struct pt_regs *regs)
 	}
 }
 
-/************************************************************************
- *  API called by rest of kernel
- ***********************************************************************/
-
-void show_regs(struct pt_regs *regs)
+void show_exception_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
-	struct callee_regs *cregs;
 	char *buf;
 
 	buf = (char *)__get_free_page(GFP_KERNEL);
@@ -190,12 +185,28 @@ void show_regs(struct pt_regs *regs)
 	show_ecr_verbose(regs);
 
 	pr_info("[EFA   ]: 0x%08lx\n[BLINK ]: %pS\n[ERET  ]: %pS\n",
-		current->thread.fault_address,
+		tsk->thread.fault_address,
 		(void *)regs->blink, (void *)regs->ret);
 
 	if (user_mode(regs))
 		show_faulting_vma(regs->ret, buf); /* faulting code, not data */
 
+	free_page((unsigned long)buf);
+}
+
+/************************************************************************
+ *  API called by rest of kernel
+ ***********************************************************************/
+
+void show_regs(struct pt_regs *regs)
+{
+	struct callee_regs *cregs;
+	char *buf;
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return;
+
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
 #define STS_BIT(r, bit)	r->status32 & STATUS_##bit##_MASK ? #bit" " : ""
@@ -238,6 +249,8 @@ void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
 	/* Show fault description */
 	pr_info("\n%s\n", str);
 
+	show_exception_regs(regs);
+
 	/* Caller and Callee regs */
 	show_regs(regs);
 
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index a0b7bd6d030d..7e0e2591bb27 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -200,6 +200,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		/* info.si_code has been set above */
 		info.si_addr = (void __user *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		show_exception_regs(regs);
 		return;
 	}
 
@@ -239,4 +240,5 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
+	show_exception_regs(regs);
 }
-- 
2.14.4

