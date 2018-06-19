Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9069EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C54820661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yK63aQAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C54820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966970AbeFSQJZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:09:24 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A961C20652;
        Tue, 19 Jun 2018 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424563;
        bh=BhalnsFHXvccmzMxgKAEEVXQmWVAJSXUNtR3P5nbmxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yK63aQAf02Y6RuXH75u8ArCXt61mCNUYwarBoScTdiMw7CH39pMFqdoZMjhtxyjui
         oHoM3YGaOwPrYk3amUiQ9ijijLr+rdNUXwR0fLTK6vWgpQ0tahJqa/moG/xZxs/f07
         gkE10krJOWAJiSNgQjUhxeJeZkx+5QVpicxvTB6g=
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH -tip v6 10/27] s390/kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:08:59 +0900
Message-Id: <152942453967.15209.8535227381029256754.stgit@devbox>
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
from arch/s390.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/kprobes.h |    2 -
 arch/s390/kernel/kprobes.c      |   59 +--------------------------------------
 2 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 13de80cf741c..b106aa29bf55 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -68,8 +68,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_saved_imask;
 	unsigned long kprobe_saved_ctl[3];
 	struct prev_kprobe prev_kprobe;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 };
 
 void arch_remove_kprobe(struct kprobe *p);
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 60f60afa645c..0967de19f53d 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -321,9 +321,8 @@ static int kprobe_handler(struct pt_regs *regs)
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with single stepping. If we have a
 			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry
-			 * for jprobe processing, so get out doing nothing
-			 * more here.
+			 * for changing execution path, so get out doing
+			 * nothing more here.
 			 */
 			push_kprobe(kcb, p);
 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
@@ -661,60 +660,6 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack;
-
-	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
-
-	/* setup return addr to the jprobe handler routine */
-	regs->psw.addr = (unsigned long) jp->entry;
-	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT);
-
-	/* r15 is the stack pointer */
-	stack = (unsigned long) regs->gprs[15];
-
-	memcpy(kcb->jprobes_stack, (void *) stack, MIN_STACK_SIZE(stack));
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer to get messed up.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void jprobe_return(void)
-{
-	asm volatile(".word 0x0002");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack;
-
-	/* It's OK to start function graph tracing again */
-	unpause_graph_tracing();
-
-	stack = (unsigned long) kcb->jprobe_saved_regs.gprs[15];
-
-	/* Put the regs back */
-	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	/* put the stack back */
-	memcpy((void *) stack, kcb->jprobes_stack, MIN_STACK_SIZE(stack));
-	preempt_enable_no_resched();
-	return 1;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 static struct kprobe trampoline = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler

