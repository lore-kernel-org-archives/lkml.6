Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeEPX77 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeEPX76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:59:58 -0400
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
Subject: [PATCH -tip v3 6/7] bpf: error-inject: x86: Fix unbalanced preempt-count for function override
Date: Thu, 17 May 2018 08:59:34 +0900
Message-Id: <152651517390.25583.9806851313096021442.stgit@devbox>
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

Fix unbalanced preempt-count for function override
using kprobes on x86.

Jprobe requires to keep preemption disabled and keep
current kprobes until it recovers to original function
entry. For this reason kprobe_int3_handler() makes
preempt-count unbalanced when user handler returns !0.

After removing the jprobe, Kprobes does not need to
keep preempt disabled even if user handler returns !0.

But since the function override handler is also returns
!0 if it overrides a function, to balancing the preempt
count, it enables preemption and reset current kprobe
by itself.

That is a bad design that is very buggy. This fixes
the unbalanced preempt-count in both kprobes and
function override on x86.
Of course we have to fix same code of kprobes on other
archs to keep the kprobes behavior consistent. But this
is bisect-safe because the function override
(CONFIG_FUNCTION_ERROR_INJECTION) implemented only
on x86 at this moment.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c   |    4 ++++
 arch/x86/kernel/kprobes/ftrace.c |   15 ++++++++-------
 kernel/fail_function.c           |    3 ---
 kernel/trace/trace_kprobe.c      |   11 +++--------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4badf22bb11f..215a28bdd9df 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -695,6 +695,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
+			else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+			}
 			return 1;
 		}
 	} else if (*addr != BREAKPOINT_INSTRUCTION) {
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index c8696f2a583f..310ef737b9d4 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -63,18 +63,19 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
 		regs->ip = ip + sizeof(kprobe_opcode_t);
 
-		/* To emulate trap based kprobes, preempt_disable here */
-		preempt_disable();
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			skip_singlestep(p, regs, kcb, orig_ip);
-			preempt_enable_no_resched();
+		} else {
+			/*
+			 * If pre_handler returns !0, this handler
+			 * modifies regs->ip and goes back to there
+			 * directly without single stepping.
+			 * So let's just clear current kprobe.
+			 */
+			__this_cpu_write(current_kprobe, NULL);
 		}
-		/*
-		 * If pre_handler returns !0, it sets regs->ip and
-		 * resets current kprobe, and keep preempt count +1.
-		 */
 	}
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 1d5632d8bbcc..b090688df94f 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -184,9 +184,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 	if (should_fail(&fei_fault_attr, 1)) {
 		regs_set_return_value(regs, attr->retval);
 		override_function_with_return(regs);
-		/* Kprobe specific fixup */
-		reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 02aed76e0978..b65cd6834450 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1217,16 +1217,11 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 		/*
 		 * We need to check and see if we modified the pc of the
-		 * pt_regs, and if so clear the kprobe and return 1 so that we
-		 * don't do the single stepping.
-		 * The ftrace kprobe handler leaves it up to us to re-enable
-		 * preemption here before returning if we've modified the ip.
+		 * pt_regs, and if so return 1 so that we don't do the
+		 * single stepping.
 		 */
-		if (orig_ip != instruction_pointer(regs)) {
-			reset_current_kprobe();
-			preempt_enable_no_resched();
+		if (orig_ip != instruction_pointer(regs))
 			return 1;
-		}
 		if (!ret)
 			return 0;
 	}
