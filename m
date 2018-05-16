Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeEPX7a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeEPX73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:59:29 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH -tip v3 5/7] x86: kprobes: Ignore break_handler
Date: Thu, 17 May 2018 08:59:04 +0900
Message-Id: <152651514451.25583.15475048007255467863.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152651499561.25583.14488389770693278906.stgit@devbox>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove break_handler related code since that was used
only for jprobe and jprobe is removed now.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/common.h |   10 ----------
 arch/x86/kernel/kprobes/core.c   |   13 ++-----------
 arch/x86/kernel/kprobes/ftrace.c |   16 ++--------------
 3 files changed, 4 insertions(+), 35 deletions(-)

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
index 7d4b8e870635..4badf22bb11f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -690,10 +690,8 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			/*
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry
-			 * for jprobe processing, so get out doing nothing
-			 * more here.
+			 * pre-handler and it returned non-zero, it modified
+			 * regs->ip so no singlestep is needed.
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
@@ -712,13 +710,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
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
index 8dc0161cec8f..c8696f2a583f 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -26,7 +26,7 @@
 #include "common.h"
 
 static nokprobe_inline
-void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+void skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_ip)
 {
 	/*
@@ -43,18 +43,6 @@ void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->ip = orig_ip;
 }
 
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
@@ -80,7 +68,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			__skip_singlestep(p, regs, kcb, orig_ip);
+			skip_singlestep(p, regs, kcb, orig_ip);
 			preempt_enable_no_resched();
 		}
 		/*
