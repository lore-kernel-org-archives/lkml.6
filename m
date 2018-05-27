Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033041AbeE0Prz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:47:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:28381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032825AbeE0PqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741112"
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
Subject: [RFC PATCH 15/16] x86/split_lock: Add CONFIG and debugfs interface for testing #AC for split lock in kernel mode
Date: Sun, 27 May 2018 08:46:04 -0700
Message-Id: <1527435965-202085-16-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes user wants to test how split lock in kernel mode is process.

debugfs interface /sys/kernel/debug/x86/split_lock/test_kernel is provided
to do the test. The interface is enabled by CONFIG_SPLIT_LOCK_AC_TEST.

Writing 1 to the interface file triggers a split locked access in kernel
and procedure of handling the split lock.

The file is not readable.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig               | 10 +++++++
 arch/x86/kernel/cpu/test_ctl.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d42d90abd644..5d44cc86aecf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -488,6 +488,16 @@ config SPLIT_LOCK_AC_PANIC_ON_KERNEL
 
 	  Say N if unsure.
 
+config SPLIT_LOCK_AC_TEST
+	bool "Test #AC exception for split locked accesses"
+	default n
+	depends on SPLIT_LOCK_AC
+	help
+	  Select to enable testing #AC exception for split lock accesses.
+	  This adds interface /sys/kernel/debug/x86/split_lock/test_kernel
+	  to allow user to trigger split locked access in kernel and test
+	  split lock handling.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 8bdc01067be9..910ff19c2a3e 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -541,6 +541,64 @@ static int firmware_store(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(firmware_ops, firmware_show, firmware_store, "%llx\n");
 
+#ifdef CONFIG_SPLIT_LOCK_AC_TEST
+/* Execute locked btsl instruction with split lock operand. */
+static void split_lock_test_kernel(void)
+{
+	char cptr[128] __aligned(64);
+	int *iptr;
+
+	/*
+	 * Change the pointer, making it 3-byte away from the next cache
+	 * line.
+	 */
+	iptr = (int *)(cptr + 61);
+
+	/* Initial value 0 in iptr */
+	*iptr = 0;
+
+	pr_info("split lock test: split lock address=0x%lx\n",
+		(unsigned long)iptr);
+
+	/*
+	 * The distance between iptr and next cache line is 3 bytes.
+	 * Operand size in "btsl" is 4 bytes. So iptr will span two cache
+	 * lines. "lock btsl" instruction will trigger #AC in hardware
+	 * and kernel will either re-execute the instruction or go to panic
+	 * depending on user configuration in
+	 * /sys/kernel/debug/x86/split_lock/kernel_mode.
+	 */
+	asm volatile ("lock btsl $0, %0\n\t"
+		      : "=m" (*iptr));
+
+	if (*iptr == 1)
+		pr_info("split lock kernel test passes\n");
+	else
+		pr_info("split lock kernel test fails\n");
+}
+
+/*
+ * Writing 1 to /sys/kernel/debug/x86/split_lock/test_kernel triggers
+ * split locke daccess in kernel mode.
+ */
+static int test_kernel_store(void *data, u64 val)
+{
+	if (split_lock_ac_kernel == DISABLE_SPLIT_LOCK_AC)
+		return -ENODEV;
+
+	if (val != 1)
+		return -EINVAL;
+
+	mutex_lock(&split_lock_mutex);
+	split_lock_test_kernel();
+	mutex_unlock(&split_lock_mutex);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(test_kernel_ops, NULL, test_kernel_store, "%llx\n");
+#endif /* CONFIG_SPLIT_LOCK_AC_TEST */
+
 static int __init debugfs_setup_split_lock(void)
 {
 	struct debugfs_file debugfs_files[] = {
@@ -548,6 +606,9 @@ static int __init debugfs_setup_split_lock(void)
 		{"kernel_mode",	0600, &kernel_mode_ops },
 		{"user_mode",	0600, &user_mode_ops },
 		{"firmware",	0600, &firmware_ops },
+#ifdef CONFIG_SPLIT_LOCK_AC_TEST
+		{"test_kernel",	0200, &test_kernel_ops },
+#endif
 	};
 	struct dentry *split_lock_dir, *fd;
 	int i;
-- 
2.5.0
