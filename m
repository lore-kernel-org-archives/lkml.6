Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeA3Oyy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:54:54 -0500
Received: from terminus.zytor.com ([65.50.211.136]:50957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeA3Oyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:54:53 -0500
Date: Tue, 30 Jan 2018 06:50:34 -0800
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-37a8f7c38339b22b69876d6f5a0ab851565284e3@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org
Reply-To: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, luto@kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <03148bcc1b217100e6e8ecf6a5468c45cf4304b6.1517164461.git.luto@kernel.org>
References: <03148bcc1b217100e6e8ecf6a5468c45cf4304b6.1517164461.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/asm: Move 'status' from thread_struct to
 thread_info
Git-Commit-ID: 37a8f7c38339b22b69876d6f5a0ab851565284e3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  37a8f7c38339b22b69876d6f5a0ab851565284e3
Gitweb:     https://git.kernel.org/tip/37a8f7c38339b22b69876d6f5a0ab851565284e3
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 28 Jan 2018 10:38:50 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 15:30:36 +0100

x86/asm: Move 'status' from thread_struct to thread_info

The TS_COMPAT bit is very hot and is accessed from code paths that mostly
also touch thread_info::flags.  Move it into struct thread_info to improve
cache locality.

The only reason it was in thread_struct is that there was a brief period
during which arch-specific fields were not allowed in struct thread_info.

Linus suggested further changing:

  ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);

to:

  if (unlikely(ti->status & (TS_COMPAT|TS_I386_REGS_POKED)))
          ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);

on the theory that frequently dirtying the cacheline even in pure 64-bit
code that never needs to modify status hurts performance.  That could be a
reasonable followup patch, but I suspect it matters less on top of this
patch.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/03148bcc1b217100e6e8ecf6a5468c45cf4304b6.1517164461.git.luto@kernel.org

---
 arch/x86/entry/common.c            | 4 ++--
 arch/x86/include/asm/processor.h   | 2 --
 arch/x86/include/asm/syscall.h     | 6 +++---
 arch/x86/include/asm/thread_info.h | 3 ++-
 arch/x86/kernel/process_64.c       | 4 ++--
 arch/x86/kernel/ptrace.c           | 2 +-
 arch/x86/kernel/signal.c           | 2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d7d3cc2..9908134 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -206,7 +206,7 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	 * special case only applies after poking regs and before the
 	 * very next return to user mode.
 	 */
-	current->thread.status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
+	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
 #endif
 
 	user_enter_irqoff();
@@ -304,7 +304,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 	unsigned int nr = (unsigned int)regs->orig_ax;
 
 #ifdef CONFIG_IA32_EMULATION
-	current->thread.status |= TS_COMPAT;
+	ti->status |= TS_COMPAT;
 #endif
 
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index efbde08..513f960 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -460,8 +460,6 @@ struct thread_struct {
 	unsigned short		gsindex;
 #endif
 
-	u32			status;		/* thread synchronous flags */
-
 #ifdef CONFIG_X86_64
 	unsigned long		fsbase;
 	unsigned long		gsbase;
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index e3c95e8..03eedc2 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -60,7 +60,7 @@ static inline long syscall_get_error(struct task_struct *task,
 	 * TS_COMPAT is set for 32-bit syscall entries and then
 	 * remains set until we return to user mode.
 	 */
-	if (task->thread.status & (TS_COMPAT|TS_I386_REGS_POKED))
+	if (task->thread_info.status & (TS_COMPAT|TS_I386_REGS_POKED))
 		/*
 		 * Sign-extend the value so (int)-EFOO becomes (long)-EFOO
 		 * and will match correctly in comparisons.
@@ -116,7 +116,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread.status & TS_COMPAT)
+	if (task->thread_info.status & TS_COMPAT)
 		switch (i) {
 		case 0:
 			if (!n--) break;
@@ -177,7 +177,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 					 const unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread.status & TS_COMPAT)
+	if (task->thread_info.status & TS_COMPAT)
 		switch (i) {
 		case 0:
 			if (!n--) break;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0022333..eda3b68 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -55,6 +55,7 @@ struct task_struct;
 
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	u32			status;		/* thread synchronous flags */
 };
 
 #define INIT_THREAD_INFO(tsk)			\
@@ -221,7 +222,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 #define in_ia32_syscall() true
 #else
 #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
-			   current->thread.status & TS_COMPAT)
+			   current_thread_info()->status & TS_COMPAT)
 #endif
 
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c754662..9eb448c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -557,7 +557,7 @@ static void __set_personality_x32(void)
 	 * Pretend to come from a x32 execve.
 	 */
 	task_pt_regs(current)->orig_ax = __NR_x32_execve | __X32_SYSCALL_BIT;
-	current->thread.status &= ~TS_COMPAT;
+	current_thread_info()->status &= ~TS_COMPAT;
 #endif
 }
 
@@ -571,7 +571,7 @@ static void __set_personality_ia32(void)
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
-	current->thread.status |= TS_COMPAT;
+	current_thread_info()->status |= TS_COMPAT;
 #endif
 }
 
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f37d181..ed5c4cd 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -935,7 +935,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 		 */
 		regs->orig_ax = value;
 		if (syscall_get_nr(child, regs) >= 0)
-			child->thread.status |= TS_I386_REGS_POKED;
+			child->thread_info.status |= TS_I386_REGS_POKED;
 		break;
 
 	case offsetof(struct user32, regs.eflags):
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index b9e00e8..4cdc0b2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -787,7 +787,7 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
 	 * than the tracee.
 	 */
 #ifdef CONFIG_IA32_EMULATION
-	if (current->thread.status & (TS_COMPAT|TS_I386_REGS_POKED))
+	if (current_thread_info()->status & (TS_COMPAT|TS_I386_REGS_POKED))
 		return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
