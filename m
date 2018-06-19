Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA00C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6220875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEV75zfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D6220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966978AbeFSQHa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:07:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3738C20874;
        Tue, 19 Jun 2018 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424447;
        bh=NKFAj55pNVuv7ETScfsj1O31LLXZqIj0JYon+H/KpPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEV75zfhnwONhnYvQacJUNoZOq2eE9NBqwE258ho5MRPRass+aKwYZ5xM2NzfBnS1
         DHpz3Ft51rbaZxrL94TOpAiuat5/exndMDZ/PKWfHdYXoJdkUb9MQULLynTwEfuWPy
         pApXowjaBdHvQ1JrgnRQpB/CmeN5AeVYpwrvoh8Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -tip v6 06/27] arm64: kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:07:03 +0900
Message-Id: <152942442318.15209.17767976282305601884.stgit@devbox>
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
from arch/arm64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kprobes.h   |    1 -
 arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 6deb8d726041..d5a44cf859e9 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -48,7 +48,6 @@ struct kprobe_ctlblk {
 	unsigned long saved_irqflag;
 	struct prev_kprobe prev_kprobe;
 	struct kprobe_step_ctx ss_ctx;
-	struct pt_regs jprobe_saved_regs;
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..3ca2351109a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,74 +465,6 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	/*
-	 * Since we can't be sure where in the stack frame "stacked"
-	 * pass-by-value arguments are stored we just don't try to
-	 * duplicate any of the stack. Do not use jprobes on functions that
-	 * use more than 64 bytes (after padding each to an 8 byte boundary)
-	 * of arguments, or pass individual arguments larger than 16 bytes.
-	 */
-
-	instruction_pointer_set(regs, (unsigned long) jp->entry);
-	preempt_disable();
-	pause_graph_tracing();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/*
-	 * Jprobe handler return by entering break exception,
-	 * encoded same as kprobe, but with following conditions
-	 * -a special PC to identify it from the other kprobes.
-	 * -restore stack addr to original saved pt_regs
-	 */
-	asm volatile("				mov sp, %0	\n"
-		     "jprobe_return_break:	brk %1		\n"
-		     :
-		     : "r" (kcb->jprobe_saved_regs.sp),
-		       "I" (BRK64_ESR_KPROBES)
-		     : "memory");
-
-	unreachable();
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.sp;
-	long orig_sp = kernel_stack_pointer(regs);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	extern const char jprobe_return_break[];
-
-	if (instruction_pointer(regs) != (u64) jprobe_return_break)
-		return 0;
-
-	if (orig_sp != stack_addr) {
-		struct pt_regs *saved_regs =
-		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
-		pr_err("current sp %lx does not match saved sp %lx\n",
-		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
-		__show_regs(saved_regs);
-		pr_err("Current registers\n");
-		__show_regs(regs);
-		BUG();
-	}
-	unpause_graph_tracing();
-	*regs = kcb->jprobe_saved_regs;
-	preempt_enable_no_resched();
-	return 1;
-}
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	if ((addr >= (unsigned long)__kprobes_text_start &&

