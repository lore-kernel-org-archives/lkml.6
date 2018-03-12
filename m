Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeCLOnt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbeCLOnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:43:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF88204EF
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
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH -tip v2 5/5] x86: kprobes: Do not disable preempt on int3 path
Date: Mon, 12 Mar 2018 23:43:23 +0900
Message-Id: <152086580283.32679.14053977636883583533.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152086565510.32679.6953754320525763743.stgit@devbox>
References: <152086565510.32679.6953754320525763743.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since int3 and debug exception(for singlestep) are run with
IRQ disabled and while running single stepping we drop IF
from regs->flags, that path must not be preemptible. So we
can remove the preempt disable/enable calls from that path.

Note that, this changes the behavior of execution path override
which is done by modifying regs->ip in pre_handler().
Previously it requires reset_current_kprobe(), enable preempt
and return !0.
With this change, preempt count is not changed on int3 path, so
user no need to enable preempt. To fit this behavior, this
modifies ftrace-based kprobe too. In total, pre_handler() does
not need to recover preempt count even if it changes regs->ip.

>From above reason, this includes 2 kprobes-users which changes
regs->ip changes. Both depend on CONFIG_FUNCTION_ERROR_INJECTION
which is currently implemented only on x86. This means it is
enough to change x86 kprobes implementation just for these
users.

Of course, since this changes the kprobes behavior when it
changes execution path, we also have to update kprobes on
each arch before implementing CONFIG_FUNCTION_ERROR_INJECTION.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 Changes in v2:
  - Include user-side changes.
---
 Documentation/kprobes.txt        |   11 +++++------
 arch/x86/kernel/kprobes/core.c   |   14 +++-----------
 arch/x86/kernel/kprobes/ftrace.c |    5 ++---
 arch/x86/kernel/kprobes/opt.c    |    1 -
 kernel/fail_function.c           |    1 -
 kernel/trace/trace_kprobe.c      |    3 ---
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 94df43224c6c..679cba3380e4 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -566,12 +566,11 @@ the same handler) may run concurrently on different CPUs.
 Kprobes does not use mutexes or allocate memory except during
 registration and unregistration.
 
-Probe handlers are run with preemption disabled.  Depending on the
-architecture and optimization state, handlers may also run with
-interrupts disabled (e.g., kretprobe handlers and optimized kprobe
-handlers run without interrupt disabled on x86/x86-64).  In any case,
-your handler should not yield the CPU (e.g., by attempting to acquire
-a semaphore).
+Probe handlers are run with preemption disabled or interrupt disabled,
+which depends on the architecture and optimization state.  (e.g.,
+kretprobe handlers and optimized kprobe handlers run without interrupt
+disabled on x86/x86-64).  In any case, your handler should not yield
+the CPU (e.g., by attempting to acquire a semaphore, or waiting I/O).
 
 Since a return probe is implemented by replacing the return
 address with the trampoline's address, stack backtraces and calls
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e7adc2fd8a16..985e7eb839e6 100644
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
@@ -665,12 +664,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 
 	addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));
 	/*
-	 * We don't want to be preempted for the entire
-	 * duration of kprobe processing. We conditionally
-	 * re-enable preemption at the end of this function,
-	 * and also in reenter_kprobe() and setup_singlestep().
+	 * We don't want to be preempted for the entire duration of kprobe
+	 * processing. Since int3 and debug trap disables irqs and we clear
+	 * IF while singlestepping, it must be no preemptible.
 	 */
-	preempt_disable();
 
 	kcb = get_kprobe_ctlblk();
 	p = get_kprobe(addr);
@@ -704,11 +701,9 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		 * the original instruction.
 		 */
 		regs->ip = (unsigned long)addr;
-		preempt_enable_no_resched();
 		return 1;
 	} /* else: not a kprobe fault; let the kernel handle it */
 
-	preempt_enable_no_resched();
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
@@ -959,8 +954,6 @@ int kprobe_debug_handler(struct pt_regs *regs)
 	}
 	reset_current_kprobe();
 out:
-	preempt_enable_no_resched();
-
 	/*
 	 * if somebody else is singlestepping across a probe point, flags
 	 * will have TF set, in which case, continue the remaining processing
@@ -1007,7 +1000,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 			restore_previous_kprobe(kcb);
 		else
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
 		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
 		/*
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index c8696f2a583f..f1ac65d6b352 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -67,10 +67,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		preempt_disable();
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+		if (!p->pre_handler || !p->pre_handler(p, regs))
 			skip_singlestep(p, regs, kcb, orig_ip);
-			preempt_enable_no_resched();
-		}
+		preempt_enable_no_resched();
 		/*
 		 * If pre_handler returns !0, it sets regs->ip and
 		 * resets current kprobe, and keep preempt count +1.
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
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 21b0122cb39c..b1713521f096 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -176,7 +176,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 		override_function_with_return(regs);
 		/* Kprobe specific fixup */
 		reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5ce9b8cf7be3..6c894e2be8d6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1221,12 +1221,9 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 		 * We need to check and see if we modified the pc of the
 		 * pt_regs, and if so clear the kprobe and return 1 so that we
 		 * don't do the single stepping.
-		 * The ftrace kprobe handler leaves it up to us to re-enable
-		 * preemption here before returning if we've modified the ip.
 		 */
 		if (orig_ip != instruction_pointer(regs)) {
 			reset_current_kprobe();
-			preempt_enable_no_resched();
 			return 1;
 		}
 		if (!ret)
