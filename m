Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1DD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ges6gMuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1DD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966984AbeFSQH6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:07:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5247620652;
        Tue, 19 Jun 2018 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424476;
        bh=06r7XUqMUN55qiq72/24G3U2jptnhRFniV/ynkMkC+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ges6gMuCK0v/uYzS00GXD6s8I9ARLGeG7d7Ejx6U//7oz6EdQyk/YzF3rTouD1No1
         l5/nycuzi5DE0kRi6e6rDAajWZgDACXFMm64YwaoxDI5P40qNLYUhrr+xa7SeDUW25
         JlEvFIS5Le2avhJzL+co721ljJGiSn68ESVOjA3I=
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
Subject: [PATCH -tip v6 07/27] powerpc/kprobes: Remove jprobe powerpc implementation
Date:   Wed, 20 Jun 2018 01:07:32 +0900
Message-Id: <152942445234.15209.12868722778364739753.stgit@devbox>
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
from arch/powerpc. This also reverts commits
related __is_active_jprobe() function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/kprobes.h             |    2 -
 arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
 arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
 4 files changed, 5 insertions(+), 105 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 9f3be5c8a4a3..674036db558b 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -88,7 +88,6 @@ struct prev_kprobe {
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_saved_msr;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
@@ -104,7 +103,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
 #ifdef CONFIG_KPROBES_ON_FTRACE
-extern int __is_active_jprobe(unsigned long addr);
 extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 			   struct kprobe_ctlblk *kcb);
 #else
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 7a1f99f1b47f..1b316331c2d9 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,21 +25,6 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
-/*
- * This is called from ftrace code after invoking registered handlers to
- * disambiguate regs->nip changes done by jprobes and livepatch. We check if
- * there is an active jprobe at the provided address (mcount location).
- */
-int __is_active_jprobe(unsigned long addr)
-{
-	if (!preemptible()) {
-		struct kprobe *p = raw_cpu_read(current_kprobe);
-		return (p && (unsigned long)p->addr == addr) ? 1 : 0;
-	}
-
-	return 0;
-}
-
 static nokprobe_inline
 int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e4c5bf33970b..600678fce0a8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -611,60 +611,6 @@ unsigned long arch_deref_entry_point(void *entry)
 }
 NOKPROBE_SYMBOL(arch_deref_entry_point);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
-
-	/* setup return addr to the jprobe handler routine */
-	regs->nip = arch_deref_entry_point(jp->entry);
-#ifdef PPC64_ELF_ABI_v2
-	regs->gpr[12] = (unsigned long)jp->entry;
-#elif defined(PPC64_ELF_ABI_v1)
-	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
-#endif
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void __used jprobe_return(void)
-{
-	asm volatile("jprobe_return_trap:\n"
-		     "trap\n"
-		     ::: "memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
-		pr_debug("longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
-				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
-		return 0;
-	}
-
-	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	/* It's OK to start function graph tracing again */
-	unpause_graph_tracing();
-	preempt_enable_no_resched();
-	return 1;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 9a5b5a513604..32476a6e4e9c 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -104,39 +104,13 @@ ftrace_regs_call:
 	bl	ftrace_stub
 	nop
 
-	/* Load the possibly modified NIP */
-	ld	r15, _NIP(r1)
-
+	/* Load ctr with the possibly modified NIP */
+	ld	r3, _NIP(r1)
+	mtctr	r3
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14, r15	/* has NIP been altered? */
+	cmpd	r14, r3		/* has NIP been altered? */
 #endif
 
-#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
-	/* NIP has not been altered, skip over further checks */
-	beq	1f
-
-	/* Check if there is an active jprobe on us */
-	subi	r3, r14, 4
-	bl	__is_active_jprobe
-	nop
-
-	/*
-	 * If r3 == 1, then this is a kprobe/jprobe.
-	 * else, this is livepatched function.
-	 *
-	 * The conditional branch for livepatch_handler below will use the
-	 * result of this comparison. For kprobe/jprobe, we just need to branch to
-	 * the new NIP, not call livepatch_handler. The branch below is bne, so we
-	 * want CR0[EQ] to be true if this is a kprobe/jprobe. Which means we want
-	 * CR0[EQ] = (r3 == 1).
-	 */
-	cmpdi	r3, 1
-1:
-#endif
-
-	/* Load CTR with the possibly modified NIP */
-	mtctr	r15
-
 	/* Restore gprs */
 	REST_GPR(0,r1)
 	REST_10GPRS(2,r1)
@@ -154,10 +128,7 @@ ftrace_regs_call:
 	addi r1, r1, SWITCH_FRAME_SIZE
 
 #ifdef CONFIG_LIVEPATCH
-        /*
-	 * Based on the cmpd or cmpdi above, if the NIP was altered and we're
-	 * not on a kprobe/jprobe, then handle livepatch.
-	 */
+        /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
 #endif
 

