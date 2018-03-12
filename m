Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCLS5J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeCLS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:57:07 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
Date: Mon, 12 Mar 2018 14:57:04 -0400
Message-Id: <1520881024-29386-1-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com>
References: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

These are the callback tests that I hacked up into a livepatch
kselftest.  (Basically I copied a bunch of the sample modules and
verified the expected dmesg output as I had listed in in the
Documentation/livepatch/callbacks.txt file.)  The script is still a
little rough and maybe this isn't the direction we want to go for proper
kselftests, but perhaps it saves you some time/sanity for verifying this
patchset.

Hope this helps,

-- Joe

-- >8 -- >8 -- >8 -- >8 --

>From 0364430c53e12e21923bed20cb651374b4cf9ba9 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Tue, 6 Mar 2018 17:32:25 -0500
Subject: WIP - livepatch kselftest

CONFIG_TEST_LIVEPATCH=m
% make -C tools/testing/selftests TARGETS=livepatch run_tests

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 lib/Kconfig.debug                                |  11 +
 lib/Makefile                                     |   9 +
 lib/test_klp_callbacks_busy.c                    |  58 ++
 lib/test_klp_callbacks_demo.c                    | 205 +++++++
 lib/test_klp_callbacks_demo2.c                   | 149 +++++
 lib/test_klp_callbacks_mod.c                     |  39 ++
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/livepatch/Makefile       |   5 +
 tools/testing/selftests/livepatch/config         |   1 +
 tools/testing/selftests/livepatch/livepatch-test | 658 +++++++++++++++++++++++
 10 files changed, 1136 insertions(+)
 create mode 100644 lib/test_klp_callbacks_busy.c
 create mode 100644 lib/test_klp_callbacks_demo.c
 create mode 100644 lib/test_klp_callbacks_demo2.c
 create mode 100644 lib/test_klp_callbacks_mod.c
 create mode 100644 tools/testing/selftests/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/config
 create mode 100755 tools/testing/selftests/livepatch/livepatch-test

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a9f..cd2a2d25314e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1932,6 +1932,17 @@ config TEST_DEBUG_VIRTUAL
 
 	  If unsure, say N.
 
+config TEST_LIVEPATCH
+	tristate "Test livepatching"
+	default n
+	depends on LIVEPATCH
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
index a90d4fcd748f..919de0acf1a8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,6 +67,15 @@ obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 
+obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_callbacks_demo.o \
+				test_klp_callbacks_demo2.o \
+				test_klp_callbacks_busy.o \
+				test_klp_callbacks_mod.o
+CFLAGS_test_klp_callbacks_demo.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_demo2.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_busy.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_test_klp_callbacks_mod.o		+= $(CC_FLAGS_FTRACE)
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
diff --git a/lib/test_klp_callbacks_busy.c b/lib/test_klp_callbacks_busy.c
new file mode 100644
index 000000000000..f76a7e6bed00
--- /dev/null
+++ b/lib/test_klp_callbacks_busy.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+/*
+ * livepatch-callbacks-busymod.c - (un)patching callbacks demo support module
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Simple module to demonstrate livepatch (un)patching callbacks.
+ *
+ *
+ * Usage
+ * -----
+ *
+ * This module is not intended to be standalone.  See the "Usage"
+ * section of livepatch-callbacks-mod.c.
+ */
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
diff --git a/lib/test_klp_callbacks_demo.c b/lib/test_klp_callbacks_demo.c
new file mode 100644
index 000000000000..dfbedef232a5
--- /dev/null
+++ b/lib/test_klp_callbacks_demo.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+/*
+ * livepatch-callbacks-demo.c - (un)patching callbacks livepatch demo
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Demonstration of registering livepatch (un)patching callbacks.
+ *
+ *
+ * Usage
+ * -----
+ *
+ * Step 1 - load the simple module
+ *
+ *   insmod samples/livepatch/livepatch-callbacks-mod.ko
+ *
+ *
+ * Step 2 - load the demonstration livepatch (with callbacks)
+ *
+ *   insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *
+ *
+ * Step 3 - cleanup
+ *
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+ *   rmmod livepatch_callbacks_demo
+ *   rmmod livepatch_callbacks_mod
+ *
+ * Watch dmesg output to see livepatch enablement, callback execution
+ * and patching operations for both vmlinux and module targets.
+ *
+ * NOTE: swap the insmod order of livepatch-callbacks-mod.ko and
+ *       livepatch-callbacks-demo.ko to observe what happens when a
+ *       target module is loaded after a livepatch with callbacks.
+ *
+ * NOTE: 'pre_patch_ret' is a module parameter that sets the pre-patch
+ *       callback return status.  Try setting up a non-zero status
+ *       such as -19 (-ENODEV):
+ *
+ *       # Load demo livepatch, vmlinux is patched
+ *       insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *
+ *       # Setup next pre-patch callback to return -ENODEV
+ *       echo -19 > /sys/module/livepatch_callbacks_demo/parameters/pre_patch_ret
+ *
+ *       # Module loader refuses to load the target module
+ *       insmod samples/livepatch/livepatch-callbacks-mod.ko
+ *       insmod: ERROR: could not insert module samples/livepatch/livepatch-callbacks-mod.ko: No such device
+ *
+ * NOTE: There is a second target module,
+ *       livepatch-callbacks-busymod.ko, available for experimenting
+ *       with livepatch (un)patch callbacks.  This module contains
+ *       a 'sleep_secs' parameter that parks the module on one of the
+ *       functions that the livepatch demo module wants to patch.
+ *       Modifying this value and tweaking the order of module loads can
+ *       effectively demonstrate stalled patch transitions:
+ *
+ *       # Load a target module, let it park on 'busymod_work_func' for
+ *       # thirty seconds
+ *       insmod samples/livepatch/livepatch-callbacks-busymod.ko sleep_secs=30
+ *
+ *       # Meanwhile load the livepatch
+ *       insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *
+ *       # ... then load and unload another target module while the
+ *       # transition is in progress
+ *       insmod samples/livepatch/livepatch-callbacks-mod.ko
+ *       rmmod samples/livepatch/livepatch-callbacks-mod.ko
+ *
+ *       # Finally cleanup
+ *       echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+ *       rmmod samples/livepatch/livepatch-callbacks-demo.ko
+ */
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
diff --git a/lib/test_klp_callbacks_demo2.c b/lib/test_klp_callbacks_demo2.c
new file mode 100644
index 000000000000..8283c77bf780
--- /dev/null
+++ b/lib/test_klp_callbacks_demo2.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+/*
+ * livepatch-callbacks-demo2.c - (un)patching callbacks livepatch demo
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Demonstration of registering livepatch (un)patching callbacks and
+ * their behavior in atomic replace patches.
+ *
+ *
+ * Usage
+ * -----
+ *
+ * Step 1 - load two livepatch callback demos (default behavior)
+ *
+ *   insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *   insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=0
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+ *
+ * Watch dmesg output to see pre and post (un)patch callbacks made for
+ * both livepatch-callbacks-demo and livepatch-callbacks-demo2.
+ *
+ * Remove the modules to prepare for the next step:
+ *
+ *   rmmod samples/livepatch/livepatch-callbacks-demo2.ko
+ *   rmmod samples/livepatch/livepatch-callbacks-demo.ko
+ *
+ * Step 1 - load two livepatch callback demos (atomic replace behavior)
+ *
+ *   insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *   insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=1
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+ *
+ * Check dmesg output again and notice that when an atomic replace
+ * patch is loaded, only its pre and post unpatch callbacks are
+ * executed.
+ *
+ * Final cleanup:
+ *
+ *   rmmod samples/livepatch/livepatch-callbacks-demo2.ko
+ *   rmmod samples/livepatch/livepatch-callbacks-demo.ko
+ *
+ */
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
diff --git a/lib/test_klp_callbacks_mod.c b/lib/test_klp_callbacks_mod.c
new file mode 100644
index 000000000000..b6953d8d0c37
--- /dev/null
+++ b/lib/test_klp_callbacks_mod.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+/*
+ * livepatch-callbacks-mod.c - (un)patching callbacks demo support module
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Simple module to demonstrate livepatch (un)patching callbacks.
+ *
+ *
+ * Usage
+ * -----
+ *
+ * This module is not intended to be standalone.  See the "Usage"
+ * section of livepatch-callbacks-demo.c.
+ */
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
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..5dea4632a297 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,6 +15,7 @@ TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += kcmp
 TARGETS += lib
+TARGETS += livepatching
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
new file mode 100644
index 000000000000..d2cb02b95be7
--- /dev/null
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := livepatch-test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
new file mode 100644
index 000000000000..d16e7bc0033d
--- /dev/null
+++ b/tools/testing/selftests/livepatch/config
@@ -0,0 +1 @@
+CONFIG_TEST_LIVEPATCH=y
diff --git a/tools/testing/selftests/livepatch/livepatch-test b/tools/testing/selftests/livepatch/livepatch-test
new file mode 100755
index 000000000000..798317bf69f6
--- /dev/null
+++ b/tools/testing/selftests/livepatch/livepatch-test
@@ -0,0 +1,658 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+MAX_RETRIES=30
+RETRY_INTERVAL=2	# seconds
+BETWEEN_TESTS=20	# seconds
+
+MOD_LIVEPATCH=test_klp_callbacks_demo
+MOD_LIVEPATCH2=test_klp_callbacks_demo2
+MOD_TARGET=test_klp_callbacks_mod
+MOD_TARGET_BUSY=test_klp_callbacks_busy
+
+# die() - game over, man
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+			if [[ $i = "$MAX_RETRIES" ]]; then
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+			if [[ $i = "$MAX_RETRIES" ]]; then
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+		if [[ $i = "$MAX_RETRIES" ]]; then
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
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+set_dynamic_debug
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST1 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST2 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST3 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST4 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST5 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST6 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST7 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST8 ... "
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
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST9 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST10 ... "
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
+sleep $BETWEEN_TESTS
+
+# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
+
+echo -n "TEST11 ... "
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
+echo "livepatch kselftest(s) success"
+exit 0
-- 
1.8.3.1
