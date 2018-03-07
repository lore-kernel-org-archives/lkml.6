Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCGHXl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 02:23:41 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35066 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCGHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 02:23:36 -0500
X-Google-Smtp-Source: AG47ELssuBYUXl+8BQPVg7TPPcJf8XB6hpoFsSOjJVpZs0kJbJe1pXcEVpwcIgv5yK7goJVCMLxHOg==
From: Sargun Dhillon <sargun@sargun.me>
X-Google-Original-From: Sargun Dhillon <sargun@netflix.com>
Date: Wed, 7 Mar 2018 07:23:33 +0000
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com
Subject: [PATCH v4 3/3] security: Add an example sample dynamic LSM
Message-ID: <d62571895f667d70839ef5d5b2b0571e245110dc.1520407240.git.sargun@sargun.me>
References: <cover.1520407240.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520407240.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an example LSM that utilizes the features added by the
dynamically loadable LSMs patch. Once the module is unloaded, the
command is once again allowed. It prevents the user from running:
date --set="October 21 2015 16:29:00 PDT"

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 samples/Kconfig           |  6 ++++++
 samples/Makefile          |  2 +-
 samples/lsm/Makefile      |  4 ++++
 samples/lsm/lsm_example.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b9de05..022242c0b50b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -117,4 +117,10 @@ config SAMPLE_STATX
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
+config SAMPLE_DYNAMIC_LSM
+	tristate "Build LSM examples -- loadable modules only"
+	depends on SECURITY_DYNAMIC_HOOKS && m
+	help
+	  This builds an example dynamic LSM
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index db54e766ddb1..9d23835d6e6d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
-			   vfio-mdev/ statx/
+			   vfio-mdev/ statx/ lsm/
diff --git a/samples/lsm/Makefile b/samples/lsm/Makefile
new file mode 100644
index 000000000000..d4ccb940f18b
--- /dev/null
+++ b/samples/lsm/Makefile
@@ -0,0 +1,4 @@
+# builds the loadable LSM example kernel modules;
+# then to use one (as root):  insmod <module_name.ko>
+# and to unload: rmmod module_name
+obj-$(CONFIG_SAMPLE_DYNAMIC_LSM) += lsm_example.o
diff --git a/samples/lsm/lsm_example.c b/samples/lsm/lsm_example.c
new file mode 100644
index 000000000000..95c56ebd4d16
--- /dev/null
+++ b/samples/lsm/lsm_example.c
@@ -0,0 +1,33 @@
+/*
+ * This sample hooks into the "settime"
+ *
+ * Once you run it, the following will not be allowed:
+ * date --set="October 21 2015 16:29:00 PDT"
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+
+static int settime_cb(const struct timespec *ts, const struct timezone *tz)
+{
+	/* We aren't allowed to travel to October 21 2015 16:29 PDT */
+	if (ts->tv_sec >= 1445470140 && ts->tv_sec < 1445470200)
+		return -EPERM;
+
+	return 0;
+}
+
+static struct security_hook_list sample_hooks[] = {
+	LSM_HOOK_INIT(settime, settime_cb),
+};
+
+static int __init lsm_init(void)
+{
+	return security_add_dynamic_hooks(sample_hooks,
+					  ARRAY_SIZE(sample_hooks),
+					  "sample");
+}
+
+module_init(lsm_init)
+MODULE_LICENSE("GPL");
-- 
2.14.1
