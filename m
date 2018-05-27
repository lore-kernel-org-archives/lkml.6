Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033085AbeE0PsV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:48:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032816AbeE0PqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741105"
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
Subject: [RFC PATCH 13/16] x86/split_lock: Add debugfs interface to control user mode behavior
Date: Sun, 27 May 2018 08:46:02 -0700
Message-Id: <1527435965-202085-14-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes user wants to change how to handle user mode split lock during
run time.

Add interface /sys/kernel/debug/x86/split_lock/user_mode to allow user
to choose to either generate SIGBUS (default) when hitting split lock in
user or re-execute the user faulting instruction without generating
SIGBUS signal.

By default, user process is killed by SIGBUS after hitting split lock.
This ensures no user process can generate bus lock to block memory access
from other CPUs.

If user just wants to log split lock and continue to run the user process,
the user can configure "re-execute" in the interface.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/test_ctl.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 0212a7979a14..d774485a5ca4 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -57,6 +57,19 @@ static const char * const kernel_modes[KERNEL_MODE_LAST] = {
 
 static int kernel_mode_reaction = KERNEL_MODE_RE_EXECUTE;
 
+enum {
+	USER_MODE_SIGBUS,
+	USER_MODE_RE_EXECUTE,
+	USER_MODE_LAST
+};
+
+static const char * const user_modes[USER_MODE_LAST] = {
+	[USER_MODE_SIGBUS]     = "sigbus",
+	[USER_MODE_RE_EXECUTE] = "re-execute",
+};
+
+static int user_mode_reaction = USER_MODE_SIGBUS;
+
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
 {
@@ -220,6 +233,16 @@ static void delayed_reenable_split_lock(struct work_struct *w)
 	mutex_unlock(&reexecute_split_lock_mutex);
 }
 
+static unsigned long eflags_ac(struct pt_regs *regs)
+{
+	return regs->flags & X86_EFLAGS_AC;
+}
+
+static unsigned long cr0_am(struct pt_regs *regs)
+{
+	return read_cr0() & X86_CR0_AM;
+}
+
 /* Will the faulting instruction be re-executed? */
 static bool re_execute(struct pt_regs *regs)
 {
@@ -230,6 +253,24 @@ static bool re_execute(struct pt_regs *regs)
 	if (!user_mode(regs))
 		return true;
 
+	/*
+	 * Now check if the user faulting instruction can be re-executed.
+	 *
+	 * If both CR0.AM (Alignment Mask) and EFLAGS.AC (Alignment Check)
+	 * are set in user space, any misalignment including split lock
+	 * can trigger #AC. In this case, we just issue SIGBUS as standard
+	 * #AC handler to the user process because split lock is not the
+	 * definite reason for triggering this #AC.
+	 *
+	 * If either CR0.AM or EFLAGS.AC is zero, the only reason for
+	 * triggering this #AC is split lock. So the faulting instruction
+	 * can be re-executed if required by user.
+	 */
+	if (cr0_am(regs) == 0 || eflags_ac(regs) == 0)
+		/* User faulting instruction will be re-executed if required. */
+		if (user_mode_reaction == USER_MODE_RE_EXECUTE)
+			return true;
+
 	return false;
 }
 
@@ -449,11 +490,38 @@ static const struct file_operations kernel_mode_ops = {
 	.llseek	= default_llseek,
 };
 
+static ssize_t user_mode_show(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	return mode_show(user_buf, user_modes, USER_MODE_SIGBUS,
+			 USER_MODE_LAST, user_mode_reaction, count, ppos);
+}
+
+static ssize_t user_mode_store(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	int ret;
+
+	ret = mode_store(user_buf, count, user_modes, USER_MODE_SIGBUS,
+			 USER_MODE_LAST, &user_mode_reaction);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations user_mode_ops = {
+	.read	= user_mode_show,
+	.write	= user_mode_store,
+	.llseek	= default_llseek,
+};
+
 static int __init debugfs_setup_split_lock(void)
 {
 	struct debugfs_file debugfs_files[] = {
 		{"enable",      0600, &enable_ops},
 		{"kernel_mode",	0600, &kernel_mode_ops },
+		{"user_mode",	0600, &user_mode_ops },
 	};
 	struct dentry *split_lock_dir, *fd;
 	int i;
-- 
2.5.0
