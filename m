Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeEHNiS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbeEHNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:38:16 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: mhiramat@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 3/4] kprobes: x86: Remove jprobe x86 port
Date: Tue,  8 May 2018 22:37:52 +0900
Message-Id: <152578667261.31022.14252779586668860292.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152578658468.31022.8952561651556318637.stgit@devbox>
References: <152578658468.31022.8952561651556318637.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove jprobe related functions and ignore break_handler
since the break_handler is used only from jprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/kprobes.h |    3 -
 arch/x86/kernel/kprobes/core.c |   94 ----------------------------------------
 2 files changed, 97 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 367d99cff426..06782c2efa04 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -111,9 +111,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_old_flags;
 	unsigned long kprobe_saved_flags;
-	unsigned long *jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..29c11c8d79ab 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -708,13 +708,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
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
@@ -1079,93 +1072,6 @@ int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = stack_addr(regs);
-	addr = (unsigned long)(kcb->jprobe_saved_sp);
-
-	/*
-	 * As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 * Use __memcpy() to avoid KASAN stack out-of-bounds reports as we copy
-	 * raw stack chunk with redzones:
-	 */
-	__memcpy(kcb->jprobes_stack, (kprobe_opcode_t *)addr, MIN_STACK_SIZE(addr));
-	regs->ip = (unsigned long)(jp->entry);
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
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/* Unpoison stack redzones in the frames we are going to jump over. */
-	kasan_unpoison_stack_above_sp_to(kcb->jprobe_saved_sp);
-
-	asm volatile (
-#ifdef CONFIG_X86_64
-			"       xchg   %%rbx,%%rsp	\n"
-#else
-			"       xchgl   %%ebx,%%esp	\n"
-#endif
-			"       int3			\n"
-			"       .globl jprobe_return_end\n"
-			"       jprobe_return_end:	\n"
-			"       nop			\n"::"b"
-			(kcb->jprobe_saved_sp):"memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-NOKPROBE_SYMBOL(jprobe_return_end);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	u8 *addr = (u8 *) (regs->ip - 1);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	void *saved_sp = kcb->jprobe_saved_sp;
-
-	if ((addr > (u8 *) jprobe_return) &&
-	    (addr < (u8 *) jprobe_return_end)) {
-		if (stack_addr(regs) != saved_sp) {
-			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
-			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
-			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
-			show_regs(regs);
-			BUG();
-		}
-		/* It's OK to start function graph tracing again */
-		unpause_graph_tracing();
-		*regs = kcb->jprobe_saved_regs;
-		__memcpy(saved_sp, kcb->jprobes_stack, MIN_STACK_SIZE(saved_sp));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	bool is_in_entry_trampoline_section = false;
