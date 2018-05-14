Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeENSwu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:45335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeENSwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244663"
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
Subject: [PATCH 14/15] x86/split_lock: Add CONFIG and testing sysfs interface
Date: Mon, 14 May 2018 11:52:24 -0700
Message-Id: <1526323945-211107-15-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SPLIT_LOCK_AC_TEST is added to enable sysfs interface
/sys/kernel/split_lock/test_kernel to test split lock in kernel.

Writing 1 to the file triggers a split locked access in kernel.
User can use this interface to test how split locked access
happening in kernel is handled.

The file is not readable.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig                 | 10 ++++++
 arch/x86/kernel/cpu/split_lock.c | 71 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 38baf5fb8556..018596d80424 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -460,6 +460,16 @@ config SPLIT_LOCK_AC
 
 	  Say N if unsure.
 
+config SPLIT_LOCK_AC_TEST
+	bool "Test #AC exception for split locked accesses"
+	default n
+	depends on SPLIT_LOCK_AC
+	help
+	  Select to enable testing #AC exception for split lock accesses.
+	  This adds interface /sys/kernel/split_lock/trigger_kernel to
+	  allow user to trigger split locked access in kernel and test
+	  split lock handling.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 948a7fa948a2..eef69283aa5d 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -490,10 +490,81 @@ bios_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute split_lock_ac_bios_enable = __ATTR_RW(bios);
 
+#ifdef CONFIG_SPLIT_LOCK_AC_TEST
+/* Execute locked cmpxchg with split locked address. */
+static void split_lock_test_kernel(void)
+{
+	char cptr[128] __aligned(64);
+	int *iptr, a = 10, b = 11;
+
+	/* Increment the pointer, making it misaligned */
+	iptr = (int *)(cptr + 61);
+
+	/* Initial value 1 in iptr */
+	*iptr = 1;
+
+	pr_info("split lock test: misaligned address=%lx\n",
+		(unsigned long)iptr);
+	/*
+	 * Since eax is equal to *iptr, the instruction loads value in b
+	 * (i.e. 11) into iptr. If the instruction is executed correctly,
+	 * the content of *iptr is changed to 11 from previous value 1.
+	 *
+	 * Accessing iptr cross two cache lines will trigger #AC in hardware.
+	 * The instruction is re-executed during split lock is disabled and
+	 * re-enabled later.
+	 */
+	asm volatile ("movl %1, %%eax\n\t"
+		      "movl %1, %0\n\t"
+		      "lock\n cmpxchgl %2, %0\n\t"
+		      : "=m" (*iptr)
+		      : "r"(a), "r"(b)
+		      : "%eax");
+
+	if (*iptr == b)
+		pr_info("split lock kernel test passes\n");
+	else
+		pr_info("split lock kernel test fails\n");
+}
+
+/*
+ * Writing 1 to /sys/kernel/split_lock/test_kernel triggers split locked
+ * access in kernel mode.
+ */
+static ssize_t
+test_kernel_store(struct kobject *kobj, struct kobj_attribute *attr,
+		  const char *buf, size_t count)
+{
+	u32 val;
+	int ret;
+
+	if (split_lock_ac == DISABLE_SPLIT_LOCK_AC)
+		return -ENODEV;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	mutex_lock(&split_lock_mutex);
+	split_lock_test_kernel();
+	mutex_unlock(&split_lock_mutex);
+
+	return count;
+}
+
+static struct kobj_attribute split_lock_ac_test = __ATTR_WO(test_kernel);
+#endif /* CONFIG_SPLIT_LOCK_AC_TEST */
+
 static struct attribute *split_lock_attrs[] = {
 	&split_lock_ac_enable.attr,
 	&split_lock_ac_user.attr,
 	&split_lock_ac_bios_enable.attr,
+#ifdef CONFIG_SPLIT_LOCK_AC_TEST
+	&split_lock_ac_test.attr,
+#endif
 	NULL,
 };
 
-- 
2.5.0
