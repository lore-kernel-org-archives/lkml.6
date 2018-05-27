Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032962AbeE0Pst (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:48:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:28379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032803AbeE0PqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741099"
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
Subject: [RFC PATCH 11/16] x86/split_lock: Add CONFIG to control #AC for split lock from kernel at boot time
Date: Sun, 27 May 2018 08:46:00 -0700
Message-Id: <1527435965-202085-12-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, faulting kernel instruction that generates #AC due to
split locked access is re-executed and doesn't block system.

But in cases when user doesn't tolerate any split lock (e.g. in hard real
time system), CONFIG_SPLIT_LOCK_AC_PANIC_ON_KERNEL is added to opt-in panic
when #AC for split lock is triggered from kernel.

If it's configured as N (default), faulting instruction in kernel mode
will be recorded in #AC handler and re-executed. Split lock is not
treated as fatal fault.

If configured as Y, kernel will panic if #AC triggered by split lock
is from a kernel instruction.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig               | 13 +++++++++++++
 arch/x86/kernel/cpu/test_ctl.c | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d0dcd6fa69a..d42d90abd644 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -475,6 +475,19 @@ config SPLIT_LOCK_AC_ENABLE_DEFAULT
 
 	  Leave this to the default value of 2 if you are unsure.
 
+config SPLIT_LOCK_AC_PANIC_ON_KERNEL
+	bool "Panic on #AC for split lock in kernel mode"
+	default n
+	depends on SPLIT_LOCK_AC
+	help
+	  If you enable this option, kernel goes to panic when hitting
+	  #AC for split lock from kernel.
+
+	  If you disable this option, the kernel faulting instruction
+	  is re-executed after hitting #AC for split lock.
+
+	  Say N if unsure.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index e8b3032f3db0..6784f68af26a 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -43,6 +43,14 @@ struct debugfs_file {
 	const struct file_operations	*fops;
 };
 
+enum {
+	KERNEL_MODE_RE_EXECUTE,
+	KERNEL_MODE_PANIC,
+	KERNEL_MODE_LAST
+};
+
+static int kernel_mode_reaction = KERNEL_MODE_RE_EXECUTE;
+
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
 {
@@ -238,6 +246,10 @@ bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 	struct task_struct *tsk = current;
 	int cpu = task_cpu(tsk);
 
+	/* If configured as panic for split lock in kernel mode, panic. */
+	if (kernel_mode_reaction == KERNEL_MODE_PANIC && !user_mode(regs))
+		panic("Alignment Check exception for split lock in kernel.");
+
 	if (!re_execute(regs))
 		return false;
 
@@ -391,6 +403,9 @@ static int __init split_lock_init(void)
 	if (ret)
 		pr_warn("debugfs for #AC for split lock cannot be set up\n");
 
+	if (IS_ENABLED(CONFIG_SPLIT_LOCK_AC_PANIC_ON_KERNEL))
+		kernel_mode_reaction = KERNEL_MODE_PANIC;
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/split_lock:online",
 				split_lock_online, split_lock_offline);
 	if (ret < 0)
-- 
2.5.0
