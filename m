Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeBWVeB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:34:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeBWVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:33:57 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: [PATCH v0 2/3] livepatch: update documentation/samples for callbacks
Date: Fri, 23 Feb 2018 16:33:49 -0500
Message-Id: <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update livepatch callback documentation and samples with respect to new
atomic replace / cumulative patch functionality.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 Documentation/livepatch/callbacks.txt         | 102 ++++++++++++++++
 samples/livepatch/Makefile                    |   1 +
 samples/livepatch/livepatch-callbacks-demo2.c | 162 ++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 samples/livepatch/livepatch-callbacks-demo2.c

diff --git a/Documentation/livepatch/callbacks.txt b/Documentation/livepatch/callbacks.txt
index c9776f48e458..b5e67975c5a9 100644
--- a/Documentation/livepatch/callbacks.txt
+++ b/Documentation/livepatch/callbacks.txt
@@ -86,6 +86,13 @@ If the object did successfully patch, but the patch transition never
 started for some reason (e.g., if another object failed to patch),
 only the post-unpatch callback will be called.
 
+If a livepatch is replaced by a cumulative patch, then only the
+callbacks belonging to the cumulative patch will be executed.  This
+simplifies the livepatching core for it is the responsibility of the
+cumulative patch to safely revert whatever needs to be reverted.  See
+Documentation/livepatch/cumulative.txt for more information on such
+patches.
+
 
 Example Use-cases
 =================
@@ -603,3 +610,98 @@ pre-unpatch callbacks are skipped:
   % rmmod samples/livepatch/livepatch-callbacks-busymod.ko
   [  141.279111] livepatch_callbacks_busymod: busymod_work_func exit
   [  141.279760] livepatch_callbacks_busymod: livepatch_callbacks_mod_exit
+
+
+Test 10
+-------
+
+Test loading multiple livepatch modules containing callback routines.
+The livepatching core executes callbacks for all modules.
+
+- load livepatch
+- load second livepatch
+- disable livepatch
+- disable second livepatch
+- unload livepatch
+- unload second livepatch
+
+  % insmod samples/livepatch/livepatch-callbacks-demo.ko
+  [  216.448208] livepatch: enabling patch 'livepatch_callbacks_demo'
+  [  216.448211] livepatch: 'livepatch_callbacks_demo': initializing patching transition
+  [  216.448330] livepatch_callbacks_demo: pre_patch_callback: vmlinux
+  [  216.448341] livepatch: 'livepatch_callbacks_demo': starting patching transition
+  [  218.720099] livepatch: 'livepatch_callbacks_demo': completing patching transition
+  [  218.720179] livepatch_callbacks_demo: post_patch_callback: vmlinux
+  [  218.720180] livepatch: 'livepatch_callbacks_demo': patching complete
+
+  % insmod samples/livepatch/livepatch-callbacks-demo2.ko
+  [  220.126552] livepatch: enabling patch 'livepatch_callbacks_demo2'
+  [  220.126554] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
+  [  220.126592] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
+  [  220.126593] livepatch: 'livepatch_callbacks_demo2': starting patching transition
+  [  221.728091] livepatch: 'livepatch_callbacks_demo2': completing patching transition
+  [  221.728254] livepatch_callbacks_demo2: post_patch_callback: vmlinux
+  [  221.728255] livepatch: 'livepatch_callbacks_demo2': patching complete
+
+  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
+  [  223.434556] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
+  [  223.434616] livepatch_callbacks_demo2: pre_unpatch_callback: vmlinux
+  [  223.434617] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
+  [  224.736159] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
+  [  224.736660] livepatch_callbacks_demo2: post_unpatch_callback: vmlinux
+  [  224.736662] livepatch: 'livepatch_callbacks_demo2': unpatching complete
+
+  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+  [  227.284070] livepatch: 'livepatch_callbacks_demo': initializing unpatching transition
+  [  227.284111] livepatch_callbacks_demo: pre_unpatch_callback: vmlinux
+  [  227.284112] livepatch: 'livepatch_callbacks_demo': starting unpatching transition
+  [  228.704142] livepatch: 'livepatch_callbacks_demo': completing unpatching transition
+  [  228.704215] livepatch_callbacks_demo: post_unpatch_callback: vmlinux
+  [  228.704216] livepatch: 'livepatch_callbacks_demo': unpatching complete
+
+  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
+  % rmmod samples/livepatch/livepatch-callbacks-demo.ko
+
+
+Test 11
+-------
+
+A similar test as the previous one, except this time load the second
+callback demo module as a cumulative (ie, replacement) patch.  The
+livepatching core will only execute klp_object callbacks for the latest
+cumulative patch on the patch stack.
+
+- load livepatch
+- load second livepatch (atomic replace)
+- disable livepatch
+- disable second livepatch
+- unload livepatch
+- unload second livepatch
+
+  % insmod samples/livepatch/livepatch-callbacks-demo.ko
+  [16435.711175] livepatch: enabling patch 'livepatch_callbacks_demo'
+  [16435.711185] livepatch: 'livepatch_callbacks_demo': initializing patching transition
+  [16435.711271] livepatch_callbacks_demo: pre_patch_callback: vmlinux
+  [16435.711297] livepatch: 'livepatch_callbacks_demo': starting patching transition
+  [16436.704092] livepatch: 'livepatch_callbacks_demo': completing patching transition
+  [16436.704363] livepatch_callbacks_demo: post_patch_callback: vmlinux
+  [16436.704364] livepatch: 'livepatch_callbacks_demo': patching complete
+
+  % insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=1
+  [16442.760963] livepatch: enabling patch 'livepatch_callbacks_demo2'
+  [16442.760966] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
+  [16442.761018] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
+  [16442.761018] livepatch: 'livepatch_callbacks_demo2': starting patching transition
+  [16444.704092] livepatch: 'livepatch_callbacks_demo2': completing patching transition
+  [16444.704181] livepatch_callbacks_demo2: post_patch_callback: vmlinux
+  [16444.704181] livepatch: 'livepatch_callbacks_demo2': patching complete
+
+  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
+  [16448.434672] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
+  [16448.434712] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
+  [16449.760134] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
+  [16449.760338] livepatch: 'livepatch_callbacks_demo2': unpatching complete
+  ** TODO ** where are the demo2 unpatch callbacks?
+
+  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
+  % rmmod samples/livepatch/livepatch-callbacks-demo.ko
diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
index dd0e2a8af1af..9fb4d9b845bb 100644
--- a/samples/livepatch/Makefile
+++ b/samples/livepatch/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
+obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo2.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
diff --git a/samples/livepatch/livepatch-callbacks-demo2.c b/samples/livepatch/livepatch-callbacks-demo2.c
new file mode 100644
index 000000000000..bc07ba7e0568
--- /dev/null
+++ b/samples/livepatch/livepatch-callbacks-demo2.c
@@ -0,0 +1,162 @@
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
+ * livepatch-callbacks-demo2.c - (un)patching callbacks livepatch demo
+ *
+ *
+ * Purpose
+ * -------
+ *
+ * Demonstration of registering livepatch (un)patching callbacks and
+ * their behavior in cumulative patches.
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
+ * Step 1 - load two livepatch callback demos (cumulative behavior)
+ *
+ *   insmod samples/livepatch/livepatch-callbacks-demo.ko
+ *   insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=1
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
+ *   echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
+ *
+ * Check dmesg output again and notice that when a cumulative patch is
+ * loaded, only its pre and post unpatch callbacks are executed.
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
-- 
1.8.3.1
