Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640E520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/OBA3A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640E520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967028AbeFSQJz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966587AbeFSQJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:09:53 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12B12075E;
        Tue, 19 Jun 2018 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424592;
        bh=K7kEAO3Jt4AJTsbmyo1rRoLPNu7xYXxiw9XM1VZV+UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/OBA3A4txV1ZBS14L3Y2K3DcfRbXDBQExKkAZZU7ivBvViS701mAK7xdrpghvWul
         wJJPv3ugsL4pWifHj07iU6JfsAuqBs5WQfsL41fFD/zZ3LUDpDs9KjSQMWwSG9HoUG
         n8Y6Xtep9Qso0C8EQgcs0Hd/iQ+G0voS4/d1FZ/w=
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH -tip v6 11/27] sh: kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:09:28 +0900
Message-Id: <152942456877.15209.5482537226935729621.stgit@devbox>
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
from arch/sh.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/kprobes.h |    4 ---
 arch/sh/kernel/kprobes.c      |   51 -----------------------------------------
 2 files changed, 55 deletions(-)

diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index 85d8bcaa8493..6171682f7798 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -27,7 +27,6 @@ struct kprobe;
 
 void arch_remove_kprobe(struct kprobe *);
 void kretprobe_trampoline(void);
-void jprobe_return_end(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
@@ -43,9 +42,6 @@ struct prev_kprobe {
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
-	unsigned long jprobe_saved_r15;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 52a5e11247d1..2b5e58873b96 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -523,57 +523,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_r15 = regs->regs[15];
-	addr = kcb->jprobe_saved_r15;
-
-	/*
-	 * TBD: As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 */
-	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *) addr,
-	       MIN_STACK_SIZE(addr));
-
-	regs->pc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	asm volatile ("trapa #0x3a\n\t" "jprobe_return_end:\n\t" "nop\n\t");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack_addr = kcb->jprobe_saved_r15;
-	u8 *addr = (u8 *)regs->pc;
-
-	if ((addr >= (u8 *)jprobe_return) &&
-	    (addr <= (u8 *)jprobe_return_end)) {
-		*regs = kcb->jprobe_saved_regs;
-
-		memcpy((kprobe_opcode_t *)stack_addr, kcb->jprobes_stack,
-		       MIN_STACK_SIZE(stack_addr));
-
-		kcb->kprobe_status = KPROBE_HIT_SS;
-		preempt_enable_no_resched();
-		return 1;
-	}
-
-	return 0;
-}
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *)&kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler

