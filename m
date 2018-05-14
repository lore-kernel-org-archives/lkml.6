Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeENSz3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:55:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:55031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244628"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 03/15] x86/split_lock: Handle #AC exception for split lock in kernel mode
Date: Mon, 14 May 2018 11:52:13 -0700
Message-Id: <1526323945-211107-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When #AC exception for split lock happens in kernel code, disable
further #AC exception for split lock in the handler. Then the
faulting instruction is re-executed after exiting from the handler
without triggering another #AC exception. Re-enable #AC exception
for split lock later (after 1 ms).

During the period between disabling and re-enabling #AC exception for
split lock, some split locked accesses may not be captured. And since
the MSR_TEST_CTL is per core, disabling #AC exception for split
lock on one thread disables the feature on all threads in the
same core.

Although it's not an accurate way, the delayed re-enabling code is
simpler and cleaner than another possible method which sets single
step execution in the #AC exception and re-enables #AC for split lock
in debug trap triggered by the next instruction after the faulting
instruction. The delayed re-enabling code can prevent split lock #AC
flood caused by a lot split locks in short time (e.g. faulting
instruction in a loop). And there is no missing split lock because
the following few blocked split locks will show up once the first split
lock issue is fixed

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h       |  3 ++
 arch/x86/kernel/cpu/split_lock.c | 67 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/traps.c          | 12 +++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index b4fe6496bb15..80dc27d73e81 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -43,8 +43,11 @@ unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_SPLIT_LOCK_AC
 int __init enumerate_split_lock(void);
 void setup_split_lock(void);
+bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline int enumerate_split_lock(void) { return 0; }
 static inline void setup_split_lock(void) {}
+static inline bool
+do_split_lock_exception(struct pt_regs *regs, unsigned long error_code) {}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 98bbfb176cf4..efe6f39353d1 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -11,6 +11,8 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/printk.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
 #include <asm/msr.h>
 
 static bool split_lock_ac_supported;
@@ -20,6 +22,11 @@ static bool split_lock_ac_supported;
 
 static int split_lock_ac = DISABLE_SPLIT_LOCK_AC;
 
+static DEFINE_SPINLOCK(sl_lock);
+
+static void delayed_reenable_split_lock(struct work_struct *w);
+static DECLARE_DELAYED_WORK(delayed_work, delayed_reenable_split_lock);
+
 /*
  * On processors not supporting #AC exception for split lock feature,
  * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
@@ -76,6 +83,13 @@ static bool _setup_split_lock(int split_lock_ac_val)
 {
 	u32 l, h;
 
+	/*
+	 * The MSR_TEST_CTL is per core.
+	 *
+	 * We use spin lock to solve race condition when multiple threads
+	 * on the same core generate #AC exception at the same time.
+	 */
+	spin_lock(&sl_lock);
 	rdmsr(MSR_TEST_CTL, l, h);
 
 	/* No need to update MSR if same value. */
@@ -90,11 +104,17 @@ static bool _setup_split_lock(int split_lock_ac_val)
 		/* Clear the split lock bit to disable the feature. */
 		l &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
 	else
-		return false;
+		goto out_fail;
 
 	wrmsr(MSR_TEST_CTL, l, h);
 out:
+	spin_unlock(&sl_lock);
+
 	return true;
+out_fail:
+	spin_unlock(&sl_lock);
+
+	return false;
 }
 
 void setup_split_lock(void)
@@ -114,3 +134,48 @@ void setup_split_lock(void)
 out_fail:
 	pr_warn("fail to set split lock #AC\n");
 }
+
+#define	delay_ms	1
+
+static void delayed_reenable_split_lock(struct work_struct *w)
+{
+	if (split_lock_ac == ENABLE_SPLIT_LOCK_AC)
+		_setup_split_lock(ENABLE_SPLIT_LOCK_AC);
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
+/*
+ * #AC handler for kernel split lock is called by generic #AC handler.
+ *
+ * Disable #AC for split lock on this CPU so that the faulting instruction
+ * gets executed. The #AC for split lock is re-enabled later.
+ */
+bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	unsigned long delay = msecs_to_jiffies(delay_ms);
+	unsigned long address = read_cr2(); /* Get the faulting address */
+	int this_cpu = smp_processor_id();
+
+	if (!re_execute(regs))
+		return false;
+
+	pr_info_ratelimited("Alignment check for split lock at %lx\n", address);
+
+	_setup_split_lock(DISABLE_SPLIT_LOCK_AC);
+
+	schedule_delayed_work_on(this_cpu, &delayed_work, delay);
+
+	return true;
+}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 03f3d7695dac..c07b817bbbe9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -286,10 +287,21 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 			  unsigned long trapnr, int signr)
 {
 	siginfo_t info;
+	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
 	/*
+	 * #AC exception could be handled by split lock handler.
+	 * If the handler can't handle the exception, go to generic #AC handler.
+	 */
+	if (trapnr == X86_TRAP_AC) {
+		ret = do_split_lock_exception(regs, error_code);
+		if (ret)
+			return;
+	}
+
+	/*
 	 * WARN*()s end up here; fix them up before we call the
 	 * notifier chain.
 	 */
-- 
2.5.0
