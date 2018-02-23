Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBWVe3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:34:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752083AbeBWVd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:33:56 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: [PATCH v0 1/3] livepatch: add sample cumulative patch
Date: Fri, 23 Feb 2018 16:33:48 -0500
Message-Id: <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple atomic replace / cumulative livepatch example.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 samples/livepatch/Makefile               |   1 +
 samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 samples/livepatch/livepatch-cumulative.c

diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
index 2472ce39a18d..dd0e2a8af1af 100644
--- a/samples/livepatch/Makefile
+++ b/samples/livepatch/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
+obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
new file mode 100644
index 000000000000..ab036439e08c
--- /dev/null
+++ b/samples/livepatch/livepatch-cumulative.c
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * livepatch-callbacks-cumulative.c - atomic replace / cumulative livepatch demo
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Demonstration of atomic replace / cumulative livepatching.
+ *
+ *
+ * Usage
+ * -----
+ *
+ * Step 1 - Load the sample livepatch demo
+ *
+ *   insmod samples/livepatch/livepatch-sample.ko
+ *
+ * Notice that /proc/cmdline was modified by the patch.  For the moment,
+ * /proc/meminfo remains unmodified.
+ *
+ *   head /proc/cmdline /proc/meminfo
+ *   ==> /proc/cmdline <==
+ *   this has been live patched
+ *
+ *   ==> /proc/meminfo <==
+ *   MemTotal:        4041368 kB
+ *   MemFree:         3323504 kB
+ *   MemAvailable:    3619968 kB
+ *   Buffers:            2108 kB
+ *   Cached:           484696 kB
+ *   SwapCached:            0 kB
+ *   Active:           297960 kB
+ *   Inactive:         262964 kB
+ *   Active(anon):      74296 kB
+ *   Inactive(anon):     8300 kB
+ *
+ *
+ * Step 2 - Load a second patch (on top of sample)
+ *
+ *   insmod samples/livepatch/livepatch-cumulative.ko replace=0
+ *
+ * The second livepatch adds a modification to meminfo_proc_show(),
+ * changing the output of /proc/meminfo.  In this case, the second
+ * livepatch *supplements* the features of the first:
+ *
+ *   head /proc/cmdline /proc/meminfo
+ *   ==> /proc/cmdline <==
+ *   this has been live patched
+ *
+ *   ==> /proc/meminfo <==
+ *   this has been live patched
+ *
+ * and module references and livepatch enable counts reflect both
+ * livepatches accordingly:
+ *
+ *   lsmod | grep livepatch
+ *   livepatch_cumulative    16384  1
+ *   livepatch_sample       16384  1
+ *
+ *   head /sys/kernel/livepatch/livepatch_{cumulative,sample}/enabled
+ *   ==> /sys/kernel/livepatch/livepatch_cumulative/enabled <==
+ *   1
+ *
+ *   ==> /sys/kernel/livepatch/livepatch_sample/enabled <==
+ *   1
+ *
+ *
+ * Step 3 - Remove the second patch
+ *
+ *   echo 0 > /sys/kernel/livepatch/livepatch_cumulative/enabled
+ *   rmmod livepatch-cumulative
+ *
+ *
+ * Step 4 - Load a second patch in atomic replace mode
+ *
+ *   insmod samples/livepatch/livepatch-cumulative.ko replace=1
+ *
+ * This time, notice that the second patch has *replaced* the features of
+ * the first place:
+ *
+ *   head /proc/cmdline /proc/meminfo
+ *   ==> /proc/cmdline <==
+ *   BOOT_IMAGE=/vmlinuz-4.16.0-rc2+ root=/dev/mapper/centos-root ro console=tty0 console=ttyS0,115200 rd_NO_PLYMOUTH crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet LANG=en_US.UTF-8
+ *
+ *   ==> /proc/meminfo <==
+ *   this has been live patched
+ *
+ * The first patch is automatically disabled:
+ *
+ *   lsmod | grep livepatch
+ *   livepatch_cumulative    16384  1
+ *   livepatch_sample       16384  0
+ *
+ *   head /sys/kernel/livepatch/livepatch_{cumulative,sample}/enabled
+ *   ==> /sys/kernel/livepatch/livepatch_cumulative/enabled <==
+ *   1
+ *
+ *   ==> /sys/kernel/livepatch/livepatch_sample/enabled <==
+ *   0
+ *
+ *
+ * Step 5 - Clean up
+ *
+ * Since the first patch was replaced, it is already disabled and its
+ * module may be removed:
+ *
+ *   rmmod livepatch_sample
+ *   echo 0 > /sys/kernel/livepatch/livepatch_cumulative/enabled
+ *   rmmod livepatch-cumulative
+ */
+
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch atomic replace demo");
+
+static int replace;
+module_param(replace, int, 0644);
+MODULE_PARM_DESC(replace, "replace (default=0)");
+
+#if 0
+/* Cumulative patches don't need to re-introduce original functions in
+ * order to "revert" them from previous livepatches.
+ *
+ * - If this module is loaded in atomic replace mode, the ftrace
+ *   handlers (and therefore previous livepatches) will be removed from
+ *   cmdline_proc_show().  The latest cumulative patch contains all
+ *   modified code.
+ *
+ * - Otherwise, by default livepatches supplement each other, and we'd
+ *   need to provide a fresh copy of cmdline_proc_show() to revert its
+ *   behavior.
+ */
+static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", saved_command_line);
+	return 0;
+}
+#endif
+
+#include <linux/seq_file.h>
+static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", "this has been live patched");
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "meminfo_proc_show",
+		.new_func = livepatch_meminfo_proc_show,
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+	/* set .replace in the init function below for demo purposes */
+};
+
+static int livepatch_init(void)
+{
+	int ret;
+
+	patch.replace = replace;
+
+	ret = klp_register_patch(&patch);
+	if (ret)
+		return ret;
+	ret = klp_enable_patch(&patch);
+	if (ret) {
+		WARN_ON(klp_unregister_patch(&patch));
+		return ret;
+	}
+	return 0;
+}
+
+static void livepatch_exit(void)
+{
+	WARN_ON(klp_unregister_patch(&patch));
+}
+
+module_init(livepatch_init);
+module_exit(livepatch_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
-- 
1.8.3.1
