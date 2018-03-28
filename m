Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeC1Tt7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:49:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753290AbeC1Tty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:49:54 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/livepatch: introduce tests
Date: Wed, 28 Mar 2018 15:49:48 -0400
Message-Id: <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
References: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few livepatch modules and simple target modules that the included
regression suite can run tests against.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 lib/Kconfig.debug                                  |  12 +
 lib/Makefile                                       |   2 +
 lib/livepatch/Makefile                             |  18 +
 lib/livepatch/test_klp_atomic_replace.c            |  69 +++
 lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
 lib/livepatch/test_klp_callbacks_demo.c            | 132 ++++++
 lib/livepatch/test_klp_callbacks_demo2.c           | 104 ++++
 lib/livepatch/test_klp_callbacks_mod.c             |  24 +
 lib/livepatch/test_klp_livepatch.c                 |  62 +++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/livepatch/Makefile         |   8 +
 tools/testing/selftests/livepatch/config           |   1 +
 tools/testing/selftests/livepatch/functions.sh     | 202 ++++++++
 .../testing/selftests/livepatch/test-callbacks.sh  | 526 +++++++++++++++++++++
 .../testing/selftests/livepatch/test-livepatch.sh  | 177 +++++++
 .../selftests/livepatch/test-shadow-vars.sh        |  13 +
 16 files changed, 1394 insertions(+)
 create mode 100644 lib/livepatch/Makefile
 create mode 100644 lib/livepatch/test_klp_atomic_replace.c
 create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
 create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
 create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
 create mode 100644 lib/livepatch/test_klp_livepatch.c
 create mode 100644 tools/testing/selftests/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/config
 create mode 100644 tools/testing/selftests/livepatch/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
 create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a9f..e4a0e81542ff 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1932,6 +1932,18 @@ config TEST_DEBUG_VIRTUAL
 
 	  If unsure, say N.
 
+config TEST_LIVEPATCH
+	tristate "Test livepatching"
+	default n
+	depends on LIVEPATCH
+	depends on m
+	help
+	  Test various kernel livepatching features for correctness.
+	  The tests will load test modules that will be livepatched
+	  in various scenarios.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd748f..98a38441afb0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,6 +67,8 @@ obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 
+obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
new file mode 100644
index 000000000000..3c588564e518
--- /dev/null
+++ b/lib/livepatch/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for livepatch test code.
+
+obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
+				test_klp_callbacks_demo.o \
+				test_klp_callbacks_demo2.o \
+				test_klp_callbacks_busy.o \
+				test_klp_callbacks_mod.o \
+				test_klp_livepatch.o
+
+# Livepatch modules require CC_FLAGS_FTRACE to hook functions
+CFLAGS_test_klp_atomic_replace.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_demo.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_demo2.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_busy.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_mod.o		+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_livepatch.o		+= $(CC_FLAGS_FTRACE)
diff --git a/lib/livepatch/test_klp_atomic_replace.c b/lib/livepatch/test_klp_atomic_replace.c
new file mode 100644
index 000000000000..481941050e60
--- /dev/null
+++ b/lib/livepatch/test_klp_atomic_replace.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int replace;
+module_param(replace, int, 0644);
+MODULE_PARM_DESC(replace, "replace (default=0)");
+
+#include <linux/seq_file.h>
+static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
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
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: atomic replace");
diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/lib/livepatch/test_klp_callbacks_busy.c
new file mode 100644
index 000000000000..707e882710ea
--- /dev/null
+++ b/lib/livepatch/test_klp_callbacks_busy.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+
+static int sleep_secs;
+module_param(sleep_secs, int, 0644);
+MODULE_PARM_DESC(sleep_secs, "sleep_secs (default=0)");
+
+static void busymod_work_func(struct work_struct *work);
+static DECLARE_DELAYED_WORK(work, busymod_work_func);
+
+static void busymod_work_func(struct work_struct *work)
+{
+	pr_info("%s, sleeping %d seconds ...\n", __func__, sleep_secs);
+	msleep(sleep_secs * 1000);
+	pr_info("%s exit\n", __func__);
+}
+
+static int livepatch_callbacks_mod_init(void)
+{
+	pr_info("%s\n", __func__);
+	schedule_delayed_work(&work,
+		msecs_to_jiffies(1000 * 0));
+	return 0;
+}
+
+static void livepatch_callbacks_mod_exit(void)
+{
+	cancel_delayed_work_sync(&work);
+	pr_info("%s\n", __func__);
+}
+
+module_init(livepatch_callbacks_mod_init);
+module_exit(livepatch_callbacks_mod_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: busy target module");
diff --git a/lib/livepatch/test_klp_callbacks_demo.c b/lib/livepatch/test_klp_callbacks_demo.c
new file mode 100644
index 000000000000..4b17b91aee5f
--- /dev/null
+++ b/lib/livepatch/test_klp_callbacks_demo.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int pre_patch_ret;
+module_param(pre_patch_ret, int, 0644);
+MODULE_PARM_DESC(pre_patch_ret, "pre_patch_ret (default=0)");
+
+static const char *const module_state[] = {
+	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
+	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
+	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
+	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+};
+
+static void callback_info(const char *callback, struct klp_object *obj)
+{
+	if (obj->mod)
+		pr_info("%s: %s -> %s\n", callback, obj->mod->name,
+			module_state[obj->mod->state]);
+	else
+		pr_info("%s: vmlinux\n", callback);
+}
+
+/* Executed on object patching (ie, patch enablement) */
+static int pre_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	return pre_patch_ret;
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void pre_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+static void patched_work_func(struct work_struct *work)
+{
+	pr_info("%s\n", __func__);
+}
+
+static struct klp_func no_funcs[] = {
+	{ }
+};
+
+static struct klp_func busymod_funcs[] = {
+	{
+		.old_name = "busymod_work_func",
+		.new_func = patched_work_func,
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = NULL,	/* vmlinux */
+		.funcs = no_funcs,
+		.callbacks = {
+			.pre_patch = pre_patch_callback,
+			.post_patch = post_patch_callback,
+			.pre_unpatch = pre_unpatch_callback,
+			.post_unpatch = post_unpatch_callback,
+		},
+	},	{
+		.name = "test_klp_callbacks_mod",
+		.funcs = no_funcs,
+		.callbacks = {
+			.pre_patch = pre_patch_callback,
+			.post_patch = post_patch_callback,
+			.pre_unpatch = pre_unpatch_callback,
+			.post_unpatch = post_unpatch_callback,
+		},
+	},	{
+		.name = "test_klp_callbacks_busy",
+		.funcs = busymod_funcs,
+		.callbacks = {
+			.pre_patch = pre_patch_callback,
+			.post_patch = post_patch_callback,
+			.pre_unpatch = pre_unpatch_callback,
+			.post_unpatch = post_unpatch_callback,
+		},
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int livepatch_callbacks_demo_init(void)
+{
+	int ret;
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
+static void livepatch_callbacks_demo_exit(void)
+{
+	WARN_ON(klp_unregister_patch(&patch));
+}
+
+module_init(livepatch_callbacks_demo_init);
+module_exit(livepatch_callbacks_demo_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: livepatch demo");
diff --git a/lib/livepatch/test_klp_callbacks_demo2.c b/lib/livepatch/test_klp_callbacks_demo2.c
new file mode 100644
index 000000000000..9651b2067c83
--- /dev/null
+++ b/lib/livepatch/test_klp_callbacks_demo2.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int replace;
+module_param(replace, int, 0644);
+MODULE_PARM_DESC(replace, "replace (default=0)");
+
+static const char *const module_state[] = {
+	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
+	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
+	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
+	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+};
+
+static void callback_info(const char *callback, struct klp_object *obj)
+{
+	if (obj->mod)
+		pr_info("%s: %s -> %s\n", callback, obj->mod->name,
+			module_state[obj->mod->state]);
+	else
+		pr_info("%s: vmlinux\n", callback);
+}
+
+/* Executed on object patching (ie, patch enablement) */
+static int pre_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	return 0;
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void pre_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+}
+
+static struct klp_func no_funcs[] = {
+	{ }
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = NULL,	/* vmlinux */
+		.funcs = no_funcs,
+		.callbacks = {
+			.pre_patch = pre_patch_callback,
+			.post_patch = post_patch_callback,
+			.pre_unpatch = pre_unpatch_callback,
+			.post_unpatch = post_unpatch_callback,
+		},
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int livepatch_callbacks_demo2_init(void)
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
+static void livepatch_callbacks_demo2_exit(void)
+{
+	WARN_ON(klp_unregister_patch(&patch));
+}
+
+module_init(livepatch_callbacks_demo2_init);
+module_exit(livepatch_callbacks_demo2_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: livepatch demo2");
diff --git a/lib/livepatch/test_klp_callbacks_mod.c b/lib/livepatch/test_klp_callbacks_mod.c
new file mode 100644
index 000000000000..628dd56e89cb
--- /dev/null
+++ b/lib/livepatch/test_klp_callbacks_mod.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+static int livepatch_callbacks_mod_init(void)
+{
+	pr_info("%s\n", __func__);
+	return 0;
+}
+
+static void livepatch_callbacks_mod_exit(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+module_init(livepatch_callbacks_mod_init);
+module_exit(livepatch_callbacks_mod_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: target module");
diff --git a/lib/livepatch/test_klp_livepatch.c b/lib/livepatch/test_klp_livepatch.c
new file mode 100644
index 000000000000..36cc3c1e1c88
--- /dev/null
+++ b/lib/livepatch/test_klp_livepatch.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+#include <linux/seq_file.h>
+static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "cmdline_proc_show",
+		.new_func = livepatch_cmdline_proc_show,
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
+};
+
+static int livepatch_init(void)
+{
+	int ret;
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
+MODULE_AUTHOR("Seth Jennings <sjenning@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: livepatch module");
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..d92c63bde9b6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,6 +15,7 @@ TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += kcmp
 TARGETS += lib
+TARGETS += livepatch
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
new file mode 100644
index 000000000000..af4aee79bebb
--- /dev/null
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := \
+	test-livepatch.sh \
+	test-callbacks.sh \
+	test-shadow-vars.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
new file mode 100644
index 000000000000..0dd7700464a8
--- /dev/null
+++ b/tools/testing/selftests/livepatch/config
@@ -0,0 +1 @@
+CONFIG_TEST_LIVEPATCH=m
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
new file mode 100644
index 000000000000..609344d5e4ec
--- /dev/null
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -0,0 +1,202 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+# Shell functions for the rest of the scripts.
+
+MAX_RETRIES=30
+RETRY_INTERVAL=2	# seconds
+BETWEEN_TESTS=2		# seconds
+
+MOD_LIVEPATCH=test_klp_callbacks_demo
+MOD_LIVEPATCH2=test_klp_callbacks_demo2
+MOD_TARGET=test_klp_callbacks_mod
+MOD_TARGET_BUSY=test_klp_callbacks_busy
+
+# die(msg) - game over, man
+#	msg - dying words
+function die() {
+	echo "ERROR: $1" >&2
+	exit 1
+}
+
+# set_dynamic_debug() - setup kernel dynamic debug
+#	TODO - push and pop this config?
+function set_dynamic_debug() {
+	cat << EOF > /sys/kernel/debug/dynamic_debug/control
+file kernel/livepatch/* +p
+func klp_try_switch_task -p
+EOF
+}
+
+# wait_for_transition(modname)
+#	modname - livepatch module name
+wait_for_transition() {
+	local mod="$1"; shift
+
+	# Wait for livepatch transition  ...
+	local i=0
+	while [[ $(cat /sys/kernel/livepatch/"$mod"/transition) != "0" ]]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to complete transition for module $mod"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+}
+
+# load_mod(modname, params) - load a kernel module
+#	modname - module name to load
+#       params  - module parameters to pass to modprobe
+function load_mod() {
+	local mod="$1"; shift
+	local args="$*"
+
+	local msg="% modprobe $mod $args"
+	echo "${msg%% }" > /dev/kmsg
+	ret=$(modprobe "$mod" "$args" 2>&1)
+	if [[ "$ret" != "" ]]; then
+		echo "$ret" > /dev/kmsg
+		die "$ret"
+	fi
+
+	# Wait for module in sysfs ...
+	local i=0
+	while [ ! -e /sys/module/"$mod" ]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to load module $mod"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+
+	# Wait for livepatch ...
+	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
+
+		# Wait for livepatch in sysfs ...
+		local i=0
+		while [ ! -e /sys/kernel/livepatch/"$mod" ]; do
+			i=$((i+1))
+			if [[ $i -eq $MAX_RETRIES ]]; then
+				die "failed to load module $mod (sysfs)"
+			fi
+			sleep $RETRY_INTERVAL
+		done
+	fi
+}
+
+# load_failing_mod(modname, params) - load a kernel module, expect to fail
+#	modname - module name to load
+#       params  - module parameters to pass to modprobe
+function load_failing_mod() {
+	local mod="$1"; shift
+	local args="$*"
+
+	local msg="% modprobe $mod $args"
+	echo "${msg%% }" > /dev/kmsg
+	ret=$(modprobe "$mod" "$args" 2>&1)
+	if [[ "$ret" == "" ]]; then
+		echo "$mod unexpectedly loaded" > /dev/kmsg
+		die "$mod unexpectedly loaded"
+	fi
+	echo "$ret" > /dev/kmsg
+}
+
+# unload_mod(modname) - unload a kernel module
+#	modname - module name to unload
+function unload_mod() {
+	local mod="$1"
+
+	# Wait for module reference count to clear ...
+	local i=0
+	while [[ $(cat /sys/module/"$mod"/refcnt) != "0" ]]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to unload module $mod (refcnt)"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+
+	echo "% rmmod $mod" > /dev/kmsg
+	ret=$(rmmod "$mod" 2>&1)
+	if [[ "$ret" != "" ]]; then
+		echo "$ret" > /dev/kmsg
+		die "$ret"
+	fi
+
+	# Wait for module in sysfs ...
+	local i=0
+	while [ -e /sys/module/"$mod" ]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to unload module $mod (/sys/module)"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+
+	# Wait for livepatch sysfs if applicable ...
+	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
+
+		local i=0
+		while [ -e /sys/kernel/livepatch/"$mod" ]; do
+			i=$((i+1))
+			if [[ $i -eq $MAX_RETRIES ]]; then
+				die "failed to unload module $mod (/sys/livepatch)"
+			fi
+			sleep $RETRY_INTERVAL
+		done
+	fi
+}
+
+# display_lp(modname) - disable a livepatch
+#	modname - module name to unload
+function disable_lp() {
+	local mod="$1"
+
+        echo "% echo 0 > /sys/kernel/livepatch/$mod/enabled" > /dev/kmsg
+        echo 0 > /sys/kernel/livepatch/"$mod"/enabled
+
+	# Wait for livepatch enable to clear ...
+	local i=0
+	while [[ $(cat /sys/kernel/livepatch/"$mod"/enabled) != "0" ]]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to disable livepatch $mod"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+}
+
+# set_pre_patch_ret(modname, pre_patch_ret)
+#	modname - module name to set
+#	pre_patch_ret - new pre_patch_ret value
+function set_pre_patch_ret {
+	local mod="$1"; shift
+        local ret="$1"
+
+        echo "% echo $1 > /sys/module/$mod/parameters/pre_patch_ret" > /dev/kmsg
+        echo "$1" > /sys/module/"$mod"/parameters/pre_patch_ret
+
+	local i=0
+	while [[ $(cat /sys/module/"$mod"/parameters/pre_patch_ret) != "$1" ]]; do
+		i=$((i+1))
+		if [[ $i -eq $MAX_RETRIES ]]; then
+			die "failed to set pre_patch_ret parameter for $mod module"
+		fi
+		sleep $RETRY_INTERVAL
+	done
+}
+
+# filter_dmesg() - print a filtered dmesg
+#	TODO - better filter, out of order msgs, etc?
+function check_result {
+	local expect="$*"
+	local result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
+
+	if [[ "$expect" == "$result" ]] ; then
+		echo "PASS"
+	else
+		echo -e "FAIL\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))"
+		die "livepatch kselftest(s) failed"
+	fi
+}
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
new file mode 100755
index 000000000000..35bd0d8b49ec
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -0,0 +1,526 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+. functions.sh
+
+MOD_LIVEPATCH=test_klp_callbacks_demo
+MOD_LIVEPATCH2=test_klp_callbacks_demo2
+MOD_TARGET=test_klp_callbacks_mod
+MOD_TARGET_BUSY=test_klp_callbacks_busy
+
+set_dynamic_debug
+
+
+# TEST: target module before livepatch
+#
+# Test a combination of loading a kernel module and a livepatch that
+# patches a function in the first module.  Load the target module
+# before the livepatch module.  Unload them in the same order.
+
+echo -n "TEST: target module before livepatch ... "
+dmesg -C
+
+load_mod $MOD_TARGET
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+disable_lp $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_init
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit"
+
+
+# TEST: module_coming notifier
+#
+# This test is similar to the previous test, but (un)load the livepatch
+# module before the target kernel module.  This tests the livepatch core's
+# module_coming handler.
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: module_coming notifier ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+load_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% modprobe $MOD_TARGET
+livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_TARGET: livepatch_callbacks_mod_init
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit"
+
+
+# TEST: module_going notifier
+#
+# Test loading the livepatch after a targeted kernel module, then unload
+# the kernel module before disabling the livepatch.  This tests the
+# livepatch core's module_going handler.
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: module_going notifier ... "
+dmesg -C
+
+load_mod $MOD_TARGET
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_init
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: module_coming and module_going notifiers
+#
+# This test is similar to the previous test, however the livepatch is
+# loaded first.  This tests the livepatch core's module_coming and
+# module_going handlers.
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: module_coming and module_going notifiers ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+load_mod $MOD_TARGET
+unload_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% modprobe $MOD_TARGET
+livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_TARGET: livepatch_callbacks_mod_init
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: target module not present
+#
+# A simple test of loading a livepatch without one of its patch target
+# klp_objects ever loaded (livepatch_callbacks_mod).
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: target module not present ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: pre-patch callback -ENODEV
+#
+# Test a scenario where a vmlinux pre-patch callback returns a non-zero
+# status (ie, failure).
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: pre-patch callback -ENODEV ... "
+dmesg -C
+
+load_mod $MOD_TARGET
+load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_init
+% modprobe $MOD_LIVEPATCH pre_patch_ret=-19
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
+livepatch: pre-patch callback failed for object '$MOD_TARGET'
+livepatch: failed to enable patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit"
+
+
+# TEST: module_coming + pre-patch callback -ENODEV
+#
+# Similar to the previous test, setup a livepatch such that its vmlinux
+# pre-patch callback returns success.  However, when a targeted kernel
+# module is later loaded, have the livepatch return a failing status code.
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: module_coming + pre-patch callback -ENODEV ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+set_pre_patch_ret $MOD_LIVEPATCH -19
+load_failing_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo -19 > /sys/module/$MOD_LIVEPATCH/parameters/pre_patch_ret
+% modprobe $MOD_TARGET
+livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+livepatch: pre-patch callback failed for object '$MOD_TARGET'
+livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
+modprobe: ERROR: could not insert '$MOD_TARGET': No such device
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: multiple target modules
+#
+# Test loading multiple targeted kernel modules.  This test-case is
+# mainly for comparing with the next test-case
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: multiple target modules ... "
+dmesg -C
+
+load_mod $MOD_TARGET_BUSY sleep_secs=0
+# give $MOD_TARGET_BUSY::busymod_work_func() a chance to run
+sleep 5
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+load_mod $MOD_TARGET
+unload_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+unload_mod $MOD_TARGET_BUSY
+
+check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=0
+$MOD_TARGET_BUSY: livepatch_callbacks_mod_init
+$MOD_TARGET_BUSY: busymod_work_func, sleeping 0 seconds ...
+$MOD_TARGET_BUSY: busymod_work_func exit
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% modprobe $MOD_TARGET
+livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_TARGET: livepatch_callbacks_mod_init
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET_BUSY
+$MOD_TARGET_BUSY: livepatch_callbacks_mod_exit"
+
+sleep $BETWEEN_TESTS
+
+
+# TEST: busy target module
+#
+# A similar test as the previous one, but force the "busy" kernel module
+# to do longer work.
+#
+# The livepatching core will refuse to patch a task that is currently
+# executing a to-be-patched function -- the consistency model stalls the
+# current patch transition until this safety-check is met.  Test a
+# scenario where one of a livepatch's target klp_objects sits on such a
+# function for a long time.  Meanwhile, load and unload other target
+# kernel modules while the livepatch transition is in progress.
+
+echo -n "TEST: busy target module ... "
+dmesg -C
+
+load_mod $MOD_TARGET_BUSY sleep_secs=60
+load_mod $MOD_LIVEPATCH
+# Don't wait for transition, load $MOD_TARGET while the transition
+# is still stalled in $MOD_TARGET_BUSY::busymod_work_func()
+sleep 5
+load_mod $MOD_TARGET
+unload_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+unload_mod $MOD_TARGET_BUSY
+
+check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=60
+$MOD_TARGET_BUSY: livepatch_callbacks_mod_init
+$MOD_TARGET_BUSY: busymod_work_func, sleeping 60 seconds ...
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+% modprobe $MOD_TARGET
+livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
+$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
+$MOD_TARGET: livepatch_callbacks_mod_init
+% rmmod $MOD_TARGET
+$MOD_TARGET: livepatch_callbacks_mod_exit
+livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET_BUSY
+$MOD_TARGET_BUSY: busymod_work_func exit
+$MOD_TARGET_BUSY: livepatch_callbacks_mod_exit"
+
+
+# TEST: multiple livepatches
+#
+# Test loading multiple livepatches.  This test-case is mainly for comparing
+# with the next test-case
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: multiple livepatches ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+load_mod $MOD_LIVEPATCH2
+wait_for_transition $MOD_LIVEPATCH2
+disable_lp $MOD_LIVEPATCH2
+wait_for_transition $MOD_LIVEPATCH2
+disable_lp $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH2
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% modprobe $MOD_LIVEPATCH2
+livepatch: enabling patch '$MOD_LIVEPATCH2'
+livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': starting patching transition
+livepatch: '$MOD_LIVEPATCH2': completing patching transition
+$MOD_LIVEPATCH2: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': unpatching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH2
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: atomic replace
+#
+# Load multiple livepatches, but the second as an 'atomic-replace'
+# patch.  When the latter laods, the original livepatch should be
+# disabled and *none* of its pre/post-unpatch callbacks executed.  On
+# the other hand, when the atomic-replace livepatch is disabled, its
+# pre/post-unpatch callbacks *should* be executed.
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: atomic replace ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+load_mod $MOD_LIVEPATCH2 replace=1
+wait_for_transition $MOD_LIVEPATCH2
+disable_lp $MOD_LIVEPATCH2
+wait_for_transition $MOD_LIVEPATCH2
+unload_mod $MOD_LIVEPATCH2
+unload_mod $MOD_LIVEPATCH
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH': patching complete
+% modprobe $MOD_LIVEPATCH2 replace=1
+livepatch: enabling patch '$MOD_LIVEPATCH2'
+livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': starting patching transition
+livepatch: '$MOD_LIVEPATCH2': completing patching transition
+$MOD_LIVEPATCH2: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH2': unpatching complete
+% rmmod $MOD_LIVEPATCH2
+% rmmod $MOD_LIVEPATCH"
+
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
new file mode 100755
index 000000000000..ec7779fe8354
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -0,0 +1,177 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+. functions.sh
+
+MOD_LIVEPATCH=test_klp_livepatch
+MOD_REPLACE=test_klp_atomic_replace
+
+set_dynamic_debug
+
+
+# TEST: basic function patching
+# - load a livepatch that modifies the output from /proc/cmdline and
+#   verify correct behavior
+# - unload the livepatch and make sure the patch was removed
+
+echo -n "TEST: basic function patching ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+disable_lp $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: multiple livepatches
+# - load a livepatch that modifies the output from /proc/cmdline and
+#   verify correct behavior
+# - load another livepatch and verify that both livepatches are active
+# - unload the second livepatch and verify that the first is still active
+# - unload the first livepatch and verify none are active
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: multiple livepatches ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+load_mod $MOD_REPLACE replace=0
+wait_for_transition $MOD_REPLACE
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+disable_lp $MOD_REPLACE
+unload_mod $MOD_REPLACE
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+disable_lp $MOD_LIVEPATCH
+unload_mod $MOD_LIVEPATCH
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+$MOD_LIVEPATCH: this has been live patched
+% modprobe $MOD_REPLACE replace=0
+livepatch: enabling patch '$MOD_REPLACE'
+livepatch: '$MOD_REPLACE': initializing patching transition
+livepatch: '$MOD_REPLACE': starting patching transition
+livepatch: '$MOD_REPLACE': completing patching transition
+livepatch: '$MOD_REPLACE': patching complete
+$MOD_LIVEPATCH: this has been live patched
+$MOD_REPLACE: this has been live patched
+% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+livepatch: '$MOD_REPLACE': initializing unpatching transition
+livepatch: '$MOD_REPLACE': starting unpatching transition
+livepatch: '$MOD_REPLACE': completing unpatching transition
+livepatch: '$MOD_REPLACE': unpatching complete
+% rmmod $MOD_REPLACE
+$MOD_LIVEPATCH: this has been live patched
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+# TEST: atomic replace livepatch
+# - load a livepatch that modifies the output from /proc/cmdline and
+#   verify correct behavior
+# - load an atomic replace livepatch and verify that only the second is active
+# - remove the first livepatch and verify that the atomic replace livepatch
+#   is still active
+# - remove the atomic replace livepatch and verify that none are active
+
+sleep $BETWEEN_TESTS
+
+echo -n "TEST: atomic replace livepatch ... "
+dmesg -C
+
+load_mod $MOD_LIVEPATCH
+wait_for_transition $MOD_LIVEPATCH
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+load_mod $MOD_REPLACE replace=1
+wait_for_transition $MOD_REPLACE
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+unload_mod $MOD_LIVEPATCH
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+disable_lp $MOD_REPLACE
+unload_mod $MOD_REPLACE
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+check_result "% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+$MOD_LIVEPATCH: this has been live patched
+% modprobe $MOD_REPLACE replace=1
+livepatch: enabling patch '$MOD_REPLACE'
+livepatch: '$MOD_REPLACE': initializing patching transition
+livepatch: '$MOD_REPLACE': starting patching transition
+livepatch: '$MOD_REPLACE': completing patching transition
+livepatch: '$MOD_REPLACE': patching complete
+$MOD_REPLACE: this has been live patched
+% rmmod $MOD_LIVEPATCH
+$MOD_REPLACE: this has been live patched
+% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+livepatch: '$MOD_REPLACE': initializing unpatching transition
+livepatch: '$MOD_REPLACE': starting unpatching transition
+livepatch: '$MOD_REPLACE': completing unpatching transition
+livepatch: '$MOD_REPLACE': unpatching complete
+% rmmod $MOD_REPLACE"
+
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
new file mode 100755
index 000000000000..625810aa476c
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+. functions.sh
+
+set_dynamic_debug
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST1 ... "
+
+exit 0
-- 
1.8.3.1
