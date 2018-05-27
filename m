Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032775AbeE0PqT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032700AbeE0PqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741066"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split lock in kernel mode
Date: Sun, 27 May 2018 08:45:51 -0700
Message-Id: <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When #AC exception for split lock is triggered from a kernel instruction,
by default we don't want the exception to panic the whole system. Instead,
the exception handler should log the fault information for debug and
continue the instruction execution.

CPU generates #AC exception if split lock operand is found before CPU
executes a locked instruction. When returning from #AC handler,
instruction pointer still points to the faulting instruction. So to
re-execute the instruction, the #AC handler needs to disable #AC to
avoid to trigger another #AC for split lock before returning to the
faulting instruction. To capture future split lock, #AC for split
lock will be re-enabled (after 1 msec).

During the period between disabling and re-enabling #AC exception for
split lock, some split locked accesses may not be captured. And since
the MSR_TEST_CTL is per core, disabling #AC exception for split
lock on one thread disables the feature on all threads in the
same core.

Although it's not an accurate way, the delayed re-enabling code is
simpler and cleaner than another possible method which disables #AC
for split lock in the handler, sets single step execution to execute
the faulting instruction, and re-enables #AC for split lock
in debug trap triggered by the next instruction after the faulting
instruction. The delayed re-enabling code can prevent flood of #AC
for split lock caused by a lot of split locks in short time (e.g.
the faulting instruction in a loop). And there is no missing split
lock because the following few blocked split locks will show up once
the first split lock issue is fixed.

Define helper re_execute() to check if the faulting instruction
can be re-executed. Currently it only checks kernel faulting
instruction. Checking user faulting instruction will be added later.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h     |   6 ++
 arch/x86/kernel/cpu/test_ctl.c | 164 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c        |  30 +++++++-
 3 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 8e224956e3e2..083ef6d05c45 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -42,7 +42,13 @@ unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_SPLIT_LOCK_AC
 void detect_split_lock_ac(void);
+bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline void detect_split_lock_ac(void) {}
+static inline bool
+do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	return false;
+}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 46fa8e21f9f6..82f110759662 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -12,8 +12,22 @@
 
 #include <linux/printk.h>
 #include <linux/cpufeature.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <linux/mm.h>
 #include <asm/msr.h>
 
+#define DISABLE_SPLIT_LOCK_AC		0
+#define ENABLE_SPLIT_LOCK_AC		1
+
+/* After disabling #AC for split lock in handler, re-enable it 1 msec later. */
+#define reenable_split_lock_delay	msecs_to_jiffies(1)
+
+static void delayed_reenable_split_lock(struct work_struct *w);
+static DEFINE_PER_CPU(struct delayed_work, reenable_delayed_work);
+static unsigned long disable_split_lock_jiffies;
+static DEFINE_MUTEX(reexecute_split_lock_mutex);
+
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
 {
@@ -47,3 +61,153 @@ void detect_split_lock_ac(void)
 	 */
 	wrmsrl(MSR_TEST_CTL, orig_val);
 }
+
+static void _setup_split_lock(int split_lock_ac_val)
+{
+	u64 val;
+
+	rdmsrl(MSR_TEST_CTL, val);
+
+	/* No need to update MSR if same value. */
+	if ((val >> MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT & 0x1) ==
+	    split_lock_ac_val)
+		return;
+
+	if (split_lock_ac_val == ENABLE_SPLIT_LOCK_AC) {
+		/* Set the split lock bit to enable the feature. */
+		val |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	} else {
+		/* Clear the split lock bit to disable the feature. */
+		val &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	}
+
+	wrmsrl(MSR_TEST_CTL, val);
+}
+
+static void wait_for_reexecution(void)
+{
+	while (time_before(jiffies, disable_split_lock_jiffies +
+			   reenable_split_lock_delay))
+		cpu_relax();
+}
+
+/*
+ * TEST_CTL MSR is shared among threads on the same core. To simplify
+ * situation, disable_split_lock_jiffies is global instead of per core.
+ *
+ * Multiple threads may generate #AC for split lock at the same time.
+ * disable_split_lock_jiffies is updated by those threads. This may
+ * postpone re-enabling split lock on this thread. But that's OK
+ * because we need to make sure all threads on the same core re-execute
+ * their faulting instructions before re-enabling split lock on the core.
+ *
+ * We want to avoid the situation when split lock is disabled on one
+ * thread (thus on the whole core), then split lock is re-enabled on
+ * another thread (thus on the whole core), and the faulting instruction
+ * generates another #AC on the first thread.
+ *
+ * Before re-enabling split lock, wait until there is no re-executed
+ * split lock instruction which may only exist before
+ * disable_split_lock_jiffies + reenable_split_lock_delay.
+ */
+static void delayed_reenable_split_lock(struct work_struct *w)
+{
+	mutex_lock(&reexecute_split_lock_mutex);
+	wait_for_reexecution();
+	_setup_split_lock(ENABLE_SPLIT_LOCK_AC);
+	mutex_unlock(&reexecute_split_lock_mutex);
+}
+
+/* Will the faulting instruction be re-executed? */
+static bool re_execute(struct pt_regs *regs)
+{
+	/*
+	 * The only reason for generating #AC from kernel is because of
+	 * split lock. The kernel faulting instruction will be re-executed.
+	 */
+	if (!user_mode(regs))
+		return true;
+
+	return false;
+}
+
+static void disable_split_lock(void *unused)
+{
+	_setup_split_lock(DISABLE_SPLIT_LOCK_AC);
+}
+
+/*
+ * #AC handler for split lock is called by generic #AC handler.
+ *
+ * Disable #AC for split lock on the CPU that the current task runs on
+ * in order for the faulting instruction to get executed. The #AC for split
+ * lock is re-enabled later.
+ */
+bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 5);
+	char str[] = "alignment check for split lock";
+	struct task_struct *tsk = current;
+	int cpu = task_cpu(tsk);
+
+	if (!re_execute(regs))
+		return false;
+
+	/* Pace logging with jiffies. */
+	if (__ratelimit(&ratelimit)) {
+		pr_info("%s[%d] %s ip:%lx sp:%lx error:%lx",
+			tsk->comm, tsk->pid, str,
+			regs->ip, regs->sp, error_code);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	mutex_lock(&reexecute_split_lock_mutex);
+	smp_call_function_single(cpu, disable_split_lock, NULL, 1);
+	/*
+	 * Mark the time when split lock is disabled for re-executing the
+	 * faulting instruction.
+	 */
+	disable_split_lock_jiffies = jiffies;
+	mutex_unlock(&reexecute_split_lock_mutex);
+
+	/* The faulting instruction will be re-executed when
+	 * split lock is re-enabled 1 HZ later.
+	 */
+	schedule_delayed_work_on(cpu, &per_cpu(reenable_delayed_work, cpu),
+				 reenable_split_lock_delay);
+
+	return true;
+}
+
+static int split_lock_online(unsigned int cpu)
+{
+	INIT_DELAYED_WORK(&per_cpu(reenable_delayed_work, cpu),
+			  delayed_reenable_split_lock);
+
+	return 0;
+}
+
+static int split_lock_offline(unsigned int cpu)
+{
+	cancel_delayed_work(&per_cpu(reenable_delayed_work, cpu));
+
+	return 0;
+}
+
+static int __init split_lock_init(void)
+{
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
+		return -ENODEV;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/split_lock:online",
+				split_lock_online, split_lock_offline);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+late_initcall(split_lock_init);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 03f3d7695dac..971664134094 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -317,7 +318,34 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_seg
 DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",		invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",	segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",		stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",		alignment_check)
+
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	unsigned int trapnr = X86_TRAP_AC;
+	char str[] = "alignment check";
+	int signr = SIGBUS;
+	siginfo_t info;
+	int ret;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
+			NOTIFY_STOP) {
+		cond_local_irq_enable(regs);
+
+		/* #AC exception could be handled by split lock handler. */
+		ret = do_split_lock_exception(regs, error_code);
+		if (ret)
+			return;
+
+		/*
+		 * If not processed by split lock handler, go to generic
+		 * #AC handler.
+		 */
+		do_trap(trapnr, signr, str, regs, error_code,
+			fill_trap_info(regs, signr, trapnr, &info));
+	}
+}
 
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
-- 
2.5.0
