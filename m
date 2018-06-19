Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDC20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wo1VipNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CDC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966916AbeFSQGb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:06:28 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADBB20652;
        Tue, 19 Jun 2018 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424388;
        bh=Uz4Z3RRUWaeLOKY/Hlol1zS+UbfKYkxI12umsmWoEDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wo1VipNvcLkdVaVf7768jzGg0MFz8A3WUKkzlDlRroDqnNH7ITRKcNTqbk+6ZAbzg
         zKvJtK0KmPzL9RyaNdUvUJgSP5KDIQCIm8UWWu2hlXk4jhPBSScmhYizIasnxZr3Lh
         RemrsSRiXeM+epZ6xnedMAyTtgDI+h8nBNBi6mLw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH -tip v6 04/27] ARC: kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:06:04 +0900
Message-Id: <152942436460.15209.3038881268172249579.stgit@devbox>
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
from arch/arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/kprobes.h |    2 --
 arch/arc/kernel/kprobes.c      |   38 ++------------------------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/arc/include/asm/kprobes.h b/arch/arc/include/asm/kprobes.h
index 2e52d18e6bc7..2c1b479d5aea 100644
--- a/arch/arc/include/asm/kprobes.h
+++ b/arch/arc/include/asm/kprobes.h
@@ -45,8 +45,6 @@ struct prev_kprobe {
 
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 42b05046fad9..7811a6bbe8f0 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -225,10 +225,8 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 
 		/* If we have no pre-handler or it returned 0, we continue with
 		 * normal processing. If we have a pre-handler and it returned
-		 * non-zero - which is expected from setjmp_pre_handler for
-		 * jprobe, we return without single stepping and leave that to
-		 * the break-handler which is invoked by a kprobe from
-		 * jprobe_return
+		 * non-zero - which means user handler setup registers to exit
+		 * to another instruction, we must skip the single stepping.
 		 */
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			setup_singlestep(p, regs);
@@ -386,38 +384,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr = regs->sp;
-
-	kcb->jprobe_saved_regs = *regs;
-	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
-	regs->ret = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	__asm__ __volatile__("unimp_s");
-	return;
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr;
-
-	*regs = kcb->jprobe_saved_regs;
-	sp_addr = regs->sp;
-	memcpy((void *)sp_addr, kcb->jprobes_stack, MIN_STACK_SIZE(sp_addr));
-	preempt_enable_no_resched();
-
-	return 1;
-}
-
 static void __used kretprobe_trampoline_holder(void)
 {
 	__asm__ __volatile__(".global kretprobe_trampoline\n"

