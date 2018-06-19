Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56653C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xntQ7L+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECCF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966997AbeFSQI4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:08:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9336D20652;
        Tue, 19 Jun 2018 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424534;
        bh=oWJaCDLTi+igdzV+vF4jWbvfReFewdO7c6illdHDiUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xntQ7L+a8bT8gIBoUZP69a+tvPEZiHyGkA1wUGuC9JddlHMPbBcTd/tGBkMKPYRaN
         59+ZNytfIKK4AX15vXIm/EEQovfSGX2FjQ2kk1RXi8dalJ9OPQEBeVq9UIOed4kPXI
         IuCDDgymN2ZsJ9fAPTCk6gKKta8jSU/uncmui0q0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH -tip v6 09/27] MIPS: kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:08:30 +0900
Message-Id: <152942451058.15209.3459785416221980965.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/mips.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kprobes.h |   13 -----------
 arch/mips/kernel/kprobes.c      |   45 ---------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index ad1a99948f27..a72dfbf1babb 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -68,16 +68,6 @@ struct prev_kprobe {
 	unsigned long saved_epc;
 };
 
-#define MAX_JPROBES_STACK_SIZE 128
-#define MAX_JPROBES_STACK_ADDR \
-	(((unsigned long)current_thread_info()) + THREAD_SIZE - 32 - sizeof(struct pt_regs))
-
-#define MIN_JPROBES_STACK_SIZE(ADDR)					\
-	((((ADDR) + MAX_JPROBES_STACK_SIZE) > MAX_JPROBES_STACK_ADDR)	\
-		? MAX_JPROBES_STACK_ADDR - (ADDR)			\
-		: MAX_JPROBES_STACK_SIZE)
-
-
 #define SKIP_DELAYSLOT 0x0001
 
 /* per-cpu kprobe control block */
@@ -86,12 +76,9 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_old_SR;
 	unsigned long kprobe_saved_SR;
 	unsigned long kprobe_saved_epc;
-	unsigned long jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
 	/* Per-thread fields, used while emulating branches */
 	unsigned long flags;
 	unsigned long target_epc;
-	u8 jprobes_stack[MAX_JPROBES_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index f5c8bce70db2..efdcd0b1ce12 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -468,51 +468,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = regs->regs[29];
-
-	memcpy(kcb->jprobes_stack, (void *)kcb->jprobe_saved_sp,
-	       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-
-	regs->cp0_epc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-/* Defined in the inline asm below. */
-void jprobe_return_end(void);
-
-void __kprobes jprobe_return(void)
-{
-	/* Assembler quirk necessitates this '0,code' business.	 */
-	asm volatile(
-		"break 0,%0\n\t"
-		".globl jprobe_return_end\n"
-		"jprobe_return_end:\n"
-		: : "n" (BRK_KPROBE_BP) : "memory");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->cp0_epc >= (unsigned long)jprobe_return &&
-	    regs->cp0_epc <= (unsigned long)jprobe_return_end) {
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)kcb->jprobe_saved_sp, kcb->jprobes_stack,
-		       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-		preempt_enable_no_resched();
-
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Function return probe trampoline:
  *	- init_kprobes() establishes a probepoint here

