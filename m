Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033109AbeE0Psw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:48:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032795AbeE0PqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741095"
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
Subject: [RFC PATCH 10/16] x86/split_lock: Add a debugfs interface to allow user to enable or disable #AC for split lock during run time
Date: Sun, 27 May 2018 08:45:59 -0700
Message-Id: <1527435965-202085-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wants to enable or disable #AC for split lock during run time.

The interface /sys/kernel/debug/x86/split_lock/enable is added to allow
user to control #AC for split lock and show current split lock status
during run time.

Writing 1 to the file enables #AC for split lock and writing 0 disables
#AC for split lock.

Reading the file shows current eanbled/disabled status of #AC for split
lock:
0: disabled and 1: enabled.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/test_ctl.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index a2f84fcd4da1..e8b3032f3db0 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/reboot.h>
 #include <linux/syscore_ops.h>
+#include <linux/debugfs.h>
 #include <asm/msr.h>
 
 #define DISABLE_SPLIT_LOCK_AC		0
@@ -34,6 +35,14 @@ static DEFINE_MUTEX(reexecute_split_lock_mutex);
 static int split_lock_ac_kernel = DISABLE_SPLIT_LOCK_AC;
 static int split_lock_ac_firmware = DISABLE_SPLIT_LOCK_AC;
 
+static DEFINE_MUTEX(split_lock_mutex);
+
+struct debugfs_file {
+	char				name[32];
+	int				mode;
+	const struct file_operations	*fops;
+};
+
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
 {
@@ -292,6 +301,85 @@ static struct syscore_ops split_lock_syscore_ops = {
 	.resume		= split_lock_bsp_resume,
 };
 
+static int enable_show(void *data, u64 *val)
+{
+	*val = split_lock_ac_kernel;
+
+	return 0;
+}
+
+static int enable_store(void *data, u64 val)
+{
+	u64 msr_val;
+	int cpu;
+
+	if (val != DISABLE_SPLIT_LOCK_AC && val != ENABLE_SPLIT_LOCK_AC)
+		return -EINVAL;
+
+	/* No need to update MSR if new setting is the same as old one. */
+	if (val == split_lock_ac_kernel)
+		return 0;
+
+	mutex_lock(&split_lock_mutex);
+	mutex_lock(&reexecute_split_lock_mutex);
+
+	/*
+	 * Wait until it's out of any re-executed split lock instruction
+	 * window.
+	 */
+	wait_for_reexecution();
+
+	split_lock_ac_kernel = val;
+	/* Read split lock setting on the current CPU. */
+	rdmsrl(MSR_TEST_CTL, msr_val);
+	/* Change the split lock setting. */
+	if (split_lock_ac_kernel == DISABLE_SPLIT_LOCK_AC)
+		msr_val &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	else
+		msr_val |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	/* Update the split lock setting on all online CPUs. */
+	for_each_online_cpu(cpu)
+		wrmsrl_on_cpu(cpu, MSR_TEST_CTL, msr_val);
+
+	mutex_unlock(&reexecute_split_lock_mutex);
+	mutex_unlock(&split_lock_mutex);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(enable_ops, enable_show, enable_store, "%llx\n");
+
+static int __init debugfs_setup_split_lock(void)
+{
+	struct debugfs_file debugfs_files[] = {
+		{"enable",      0600, &enable_ops},
+	};
+	struct dentry *split_lock_dir, *fd;
+	int i;
+
+	split_lock_dir = debugfs_create_dir("split_lock", arch_debugfs_dir);
+	if (!split_lock_dir)
+		goto out;
+
+	/*  Create files under split_lock_dir. */
+	for (i = 0; i < ARRAY_SIZE(debugfs_files); i++) {
+		fd = debugfs_create_file(debugfs_files[i].name,
+					 debugfs_files[i].mode,
+					 split_lock_dir, NULL,
+					 debugfs_files[i].fops);
+		if (!fd)
+			goto out_cleanup;
+	}
+
+	return 0;
+
+out_cleanup:
+	debugfs_remove_recursive(split_lock_dir);
+out:
+
+	return -ENOMEM;
+}
+
 static int __init split_lock_init(void)
 {
 	int ret;
@@ -299,6 +387,10 @@ static int __init split_lock_init(void)
 	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
 		return -ENODEV;
 
+	ret = debugfs_setup_split_lock();
+	if (ret)
+		pr_warn("debugfs for #AC for split lock cannot be set up\n");
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/split_lock:online",
 				split_lock_online, split_lock_offline);
 	if (ret < 0)
-- 
2.5.0
