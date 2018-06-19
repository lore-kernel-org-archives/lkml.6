Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE9DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A262075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2HXlZ2GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A262075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967198AbeFSQNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967182AbeFSQNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E36720874;
        Tue, 19 Jun 2018 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424795;
        bh=FnAqwDcpCUAd2FDcFypDu5PmX5v2tfhEayhDMiZn9dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HXlZ2GI71ZomFhPs8UiiP9WiStw6rjXCU0nhouSGTaDv2LtfWzkV9j7Zjf05ojPW
         4hyu2kpbwqRHS+XW3etwCCgoK283joZUn4uEMyhX5/7EbfG8itETYLUICO0MxHS/El
         Vwk7Ad/FY4xtq1YX8Sl+lfhlbwz/3wq1BedzcE1Q=
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -tip v6 18/27] powerpc/kprobes: Don't call the ->break_handler() in powerpc kprobes code
Date:   Wed, 20 Jun 2018 01:12:51 +0900
Message-Id: <152942477127.15209.8982613703787878618.stgit@devbox>
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

Don't call the ->break_handler() from the powerpc kprobes code,
because it was only used by jprobes which got removed.

This also removes skip_singlestep() and embeds it in the
caller, kprobe_ftrace_handler(), which simplifies regs->nip
operation around there.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 Changes in v6
   - Fix patch description
   - Move post handler emulation into kprobe_ftrace_handler().
---
 arch/powerpc/include/asm/kprobes.h   |   10 -------
 arch/powerpc/kernel/kprobes-ftrace.c |   46 +++++++++-------------------------
 arch/powerpc/kernel/kprobes.c        |   31 ++++++++---------------
 3 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 674036db558b..785c464b6588 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
-#ifdef CONFIG_KPROBES_ON_FTRACE
-extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-			   struct kprobe_ctlblk *kcb);
-#else
-static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-				  struct kprobe_ctlblk *kcb)
-{
-	return 0;
-}
-#endif
 #else
 static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 1b316331c2d9..070d1d862444 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,35 +25,6 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
-static nokprobe_inline
-int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
-{
-	/*
-	 * Emulate singlestep (and also recover regs->nip)
-	 * as if there is a nop
-	 */
-	regs->nip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
-	if (unlikely(p->post_handler)) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		p->post_handler(p, regs, 0);
-	}
-	__this_cpu_write(current_kprobe, NULL);
-	if (orig_nip)
-		regs->nip = orig_nip;
-	return 1;
-}
-
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p))
-		return __skip_singlestep(p, regs, kcb, 0);
-	else
-		return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes */
 void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -71,8 +42,6 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_nip = regs->nip;
-
 		/*
 		 * On powerpc, NIP is *before* this instruction for the
 		 * pre handler
@@ -81,9 +50,18 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs))
-			__skip_singlestep(p, regs, kcb, orig_nip);
-		else {
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->nip)
+			 * as if there is a nop
+			 */
+			regs->nip += MCOUNT_INSN_SIZE;
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			__this_cpu_write(current_kprobe, NULL);
+		} else {
 			/*
 			 * If pre_handler returns !0, it sets regs->nip and
 			 * resets current kprobe. In this case, we should not
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 600678fce0a8..f06747e2e70d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -317,25 +317,17 @@ int kprobe_handler(struct pt_regs *regs)
 			}
 			prepare_singlestep(p, regs);
 			return 1;
-		} else {
-			if (*addr != BREAKPOINT_INSTRUCTION) {
-				/* If trap variant, then it belongs not to us */
-				kprobe_opcode_t cur_insn = *addr;
-				if (is_trap(cur_insn))
-		       			goto no_kprobe;
-				/* The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
+		} else if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* If trap variant, then it belongs not to us */
+			kprobe_opcode_t cur_insn = *addr;
+
+			if (is_trap(cur_insn))
 				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				if (!skip_singlestep(p, regs, kcb))
-					goto ss_probe;
-				ret = 1;
-			}
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -350,7 +342,7 @@ int kprobe_handler(struct pt_regs *regs)
 			 */
 			kprobe_opcode_t cur_insn = *addr;
 			if (is_trap(cur_insn))
-		       		goto no_kprobe;
+				goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
@@ -370,7 +362,6 @@ int kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	if (p->ainsn.boostable >= 0) {
 		ret = try_to_emulate(p, regs);
 

