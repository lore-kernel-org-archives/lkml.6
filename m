Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCCDqw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 22:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbeCCDqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 22:46:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE16421783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH -tip] x86: kprobes: Cleanup preempt disabling and enabling
Date: Sat,  3 Mar 2018 12:46:23 +0900
Message-Id: <152004878307.12012.17534094592580782444.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup x86/kprobes preempt counts so that preemt_disable()
and preempt_enable_no_sched() are called from kprobe_int3_handler().
Only if a kprobe runs single-stepping, preemption is kept
disabled and that is enabled when
 - single-stepping is finished
 - a fault occurs on single-steped instruction
 - jprobe handler is finished
 - Or, in user handler which changes regs->ip
   (e.g. function-based error injection)

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c   |   64 +++++++++++++++++++++++---------------
 arch/x86/kernel/kprobes/ftrace.c |    1 -
 arch/x86/kernel/kprobes/opt.c    |    1 -
 3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index bd36f3c33cd0..7d63a3b8c8b2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -592,7 +592,6 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		 * stepping.
 		 */
 		regs->ip = (unsigned long)p->ainsn.insn;
-		preempt_enable_no_resched();
 		return;
 	}
 #endif
@@ -650,29 +649,13 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
-/*
- * Interrupts are disabled on entry as trap3 is an interrupt gate and they
- * remain disabled throughout this function.
- */
-int kprobe_int3_handler(struct pt_regs *regs)
+static nokprobe_inline int
+kprobe_int3_dispatcher(struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	kprobe_opcode_t *addr;
 	struct kprobe *p;
-	struct kprobe_ctlblk *kcb;
-
-	if (user_mode(regs))
-		return 0;
 
 	addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));
-	/*
-	 * We don't want to be preempted for the entire
-	 * duration of kprobe processing. We conditionally
-	 * re-enable preemption at the end of this function,
-	 * and also in reenter_kprobe() and setup_singlestep().
-	 */
-	preempt_disable();
-
-	kcb = get_kprobe_ctlblk();
 	p = get_kprobe(addr);
 
 	if (p) {
@@ -706,7 +689,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		 * the original instruction.
 		 */
 		regs->ip = (unsigned long)addr;
-		preempt_enable_no_resched();
 		return 1;
 	} else if (kprobe_running()) {
 		p = __this_cpu_read(current_kprobe);
@@ -717,9 +699,41 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		}
 	} /* else: not a kprobe fault; let the kernel handle it */
 
-	preempt_enable_no_resched();
 	return 0;
 }
+
+static nokprobe_inline bool
+kprobe_ready_for_singlestep(struct pt_regs *regs)
+{
+	return kprobe_running() && (regs->flags & X86_EFLAGS_TF);
+}
+
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate and they
+ * remain disabled throughout this function.
+ */
+int kprobe_int3_handler(struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb;
+	int ret;
+
+	if (user_mode(regs))
+		return 0;
+
+	/*
+	 * We don't want to be preempted for the entire
+	 * duration of kprobe processing.
+	 */
+	preempt_disable();
+
+	kcb = get_kprobe_ctlblk();
+	ret = kprobe_int3_dispatcher(regs, kcb);
+
+	if (!kprobe_ready_for_singlestep(regs))
+		preempt_enable_no_resched();
+
+	return ret;
+}
 NOKPROBE_SYMBOL(kprobe_int3_handler);
 
 /*
@@ -962,12 +976,10 @@ int kprobe_debug_handler(struct pt_regs *regs)
 	}
 
 	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER) {
+	if (kcb->kprobe_status == KPROBE_REENTER)
 		restore_previous_kprobe(kcb);
-		goto out;
-	}
-	reset_current_kprobe();
-out:
+	else
+		reset_current_kprobe();
 	preempt_enable_no_resched();
 
 	/*
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 8dc0161cec8f..24cb3b676240 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -48,7 +48,6 @@ int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 {
 	if (kprobe_ftrace(p)) {
 		__skip_singlestep(p, regs, kcb, 0);
-		preempt_enable_no_resched();
 		return 1;
 	}
 	return 0;
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 203d398802a3..eaf02f2e7300 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -491,7 +491,6 @@ int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter)
 		regs->ip = (unsigned long)op->optinsn.insn + TMPL_END_IDX;
 		if (!reenter)
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 	return 0;
