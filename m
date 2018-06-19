Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B2120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="08IumoFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B2120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967129AbeFSQLW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966480AbeFSQLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:11:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872AB20652;
        Tue, 19 Jun 2018 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424679;
        bh=yXHp+gHjnUtp6PJ0eI5OXBNNNDqSGffcH7gfSJKJs9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08IumoFBZbn07SR8gp0R9OjhxY9VCdV9zGaXFxP3pXDVYTUyWsVM/yqQ8hOjj7g95
         JGFVStUWs5GcS1BsVJCtFPLUaOHlfcpqLYW86Jt3LBhBBq8xAEf1JGx25Hfgdxe0UR
         2pEZklF37S3B0KwgBJTfMtHVvdyXr+5Cb0Gxz5O8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH -tip v6 14/27] kprobes/x86: Don't call ->break_handler() in x86 kprobes
Date:   Wed, 20 Jun 2018 01:10:55 +0900
Message-Id: <152942465549.15209.15889693025972771135.stgit@devbox>
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

Don't call ->break_handler() and remove break_handler
related code from x86 since that was only used by jprobe
which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Changes in v6:
  - Move post handler emulation code into kprobe_ftrace_handler()
---
 arch/x86/include/asm/kprobes.h   |    2 +-
 arch/x86/kernel/kprobes/common.h |   10 ---------
 arch/x86/kernel/kprobes/core.c   |    7 ------
 arch/x86/kernel/kprobes/ftrace.c |   42 ++++++++++----------------------------
 4 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 06782c2efa04..c8cec1b39b88 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -78,7 +78,7 @@ struct arch_specific_insn {
 	 * boostable = true: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
-	 * a post_handler or break_handler).
+	 * a post_handler).
 	 */
 	bool boostable;
 	bool if_modifier;
diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index ae38dccf0c8f..2b949f4fd4d8 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -105,14 +105,4 @@ static inline unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsig
 }
 #endif
 
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
 #endif
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 1b2d1acba810..0ac16a0d93e5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -709,13 +709,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		regs->ip = (unsigned long)addr;
 		preempt_enable_no_resched();
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			if (!skip_singlestep(p, regs, kcb))
-				setup_singlestep(p, regs, kcb, 0);
-			return 1;
-		}
 	} /* else: not a kprobe fault; let the kernel handle it */
 
 	preempt_enable_no_resched();
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 8dc0161cec8f..02a6dd1b6bd0 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -25,36 +25,6 @@
 
 #include "common.h"
 
-static nokprobe_inline
-void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		      struct kprobe_ctlblk *kcb, unsigned long orig_ip)
-{
-	/*
-	 * Emulate singlestep (and also recover regs->ip)
-	 * as if there is a 5byte nop
-	 */
-	regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
-	if (unlikely(p->post_handler)) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		p->post_handler(p, regs, 0);
-	}
-	__this_cpu_write(current_kprobe, NULL);
-	if (orig_ip)
-		regs->ip = orig_ip;
-}
-
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p)) {
-		__skip_singlestep(p, regs, kcb, 0);
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -80,7 +50,17 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			__skip_singlestep(p, regs, kcb, orig_ip);
+			/*
+			 * Emulate singlestep (and also recover regs->ip)
+			 * as if there is a 5byte nop
+			 */
+			regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			regs->ip = orig_ip;
+			__this_cpu_write(current_kprobe, NULL);
 			preempt_enable_no_resched();
 		}
 		/*

