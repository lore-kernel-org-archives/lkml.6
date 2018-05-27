Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032924AbeE0Pqf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:28381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032815AbeE0PqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741102"
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
Subject: [RFC PATCH 12/16] x86/split_lock: Add a debugfs interface to allow user to change how to handle split lock in kernel mode during run time
Date: Sun, 27 May 2018 08:46:01 -0700
Message-Id: <1527435965-202085-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SPLIT_LOCK_AC_PANIC_ON_KERNEL defines how to handle split lock in
kernel mode by default. But sometimes user wants to change the default
behavior.

The interface /sys/kernel/debug/x86/split_lock/kernel_mode is added
to allow user to do so.

For example, the interface shows "[re-execute] panic" which
means two behaviors: re-execute kernel faulting instruction
after #AC (default) and panic in #AC.

User can change the default behavior by writing "re-execute" or "panic"
to the interface.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/test_ctl.c | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 6784f68af26a..0212a7979a14 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/syscore_ops.h>
 #include <linux/debugfs.h>
+#include <linux/uaccess.h>
 #include <asm/msr.h>
 
 #define DISABLE_SPLIT_LOCK_AC		0
@@ -49,6 +50,11 @@ enum {
 	KERNEL_MODE_LAST
 };
 
+static const char * const kernel_modes[KERNEL_MODE_LAST] = {
+	[KERNEL_MODE_RE_EXECUTE]	= "re-execute",
+	[KERNEL_MODE_PANIC]		= "panic",
+};
+
 static int kernel_mode_reaction = KERNEL_MODE_RE_EXECUTE;
 
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
@@ -361,10 +367,93 @@ static int enable_store(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(enable_ops, enable_show, enable_store, "%llx\n");
 
+static ssize_t
+mode_show(char __user *user_buf, const char * const *modes, int start_reaction,
+	  int last_reaction, int mode_reaction, size_t count, loff_t *ppos)
+{
+	char buf[32], *s = buf;
+	int reaction, len;
+
+	mutex_lock(&split_lock_mutex);
+	for (reaction = start_reaction; reaction < last_reaction; reaction++) {
+		if (reaction == mode_reaction)
+			s += sprintf(s, "[%s] ", modes[reaction]);
+		else
+			s += sprintf(s, "%s ", modes[reaction]);
+	}
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s - 1) = '\n';
+	mutex_unlock(&split_lock_mutex);
+
+	len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t
+mode_store(const char __user *user_buf, size_t count, const char * const *modes,
+	   int start_reaction, int last_reaction, int *mode_reaction)
+{
+	int reaction, len, ret = -EINVAL;
+	const char * const *s, *p;
+	char buf[32];
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+
+	mutex_lock(&split_lock_mutex);
+	p = memchr(buf, '\n', count);
+	len = p ? p - buf : count;
+
+	reaction = start_reaction;
+	for (s = &modes[reaction]; reaction < last_reaction; s++, reaction++) {
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len)) {
+			*mode_reaction = reaction;
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&split_lock_mutex);
+
+	return ret;
+}
+
+static ssize_t kernel_mode_show(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	return mode_show(user_buf, kernel_modes, KERNEL_MODE_RE_EXECUTE,
+			 KERNEL_MODE_LAST, kernel_mode_reaction, count, ppos);
+}
+
+static ssize_t kernel_mode_store(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	int ret;
+
+	ret = mode_store(user_buf, count, kernel_modes, KERNEL_MODE_RE_EXECUTE,
+			 KERNEL_MODE_LAST, &kernel_mode_reaction);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations kernel_mode_ops = {
+	.read	= kernel_mode_show,
+	.write	= kernel_mode_store,
+	.llseek	= default_llseek,
+};
+
 static int __init debugfs_setup_split_lock(void)
 {
 	struct debugfs_file debugfs_files[] = {
 		{"enable",      0600, &enable_ops},
+		{"kernel_mode",	0600, &kernel_mode_ops },
 	};
 	struct dentry *split_lock_dir, *fd;
 	int i;
-- 
2.5.0
