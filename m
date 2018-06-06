Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeFFAnI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:43:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:57109 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752980AbeFFAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:43:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,481,1520924400";
   d="scan'208";a="55064226"
From: "Brett T. Warden" <brett.t.warden@intel.com>
To: linux-kernel@vger.kernel.org, jeyu@kernel.org
Subject: [PATCH] module: Implement sig_unenforce parameter
Date: Tue,  5 Jun 2018 17:43:06 -0700
Message-Id: <20180606004306.18899-1-brett.t.warden@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULE_SIG_FORCE is enabled, also provide a boot-time-only
parameter, module.sig_unenforce, to disable signature enforcement. This
allows distributions to ship with signature verification enforcement
enabled by default, but for users to elect to disable it without
recompiling, to support building and loading out-of-tree modules.

Signed-off-by: Brett T. Warden <brett.t.warden@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 kernel/module.c                               | 25 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1beb30d8d7fc..87909e021558 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2380,6 +2380,10 @@
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
+	module.sig_unenforce
+			[KNL] This parameter allows modules without signatures
+			to be loaded, overriding CONFIG_MODULE_SIG_FORCE.
+
 	module_blacklist=  [KNL] Do not load a comma-separated list of
 			modules.  Useful for debugging problem modules.
 
diff --git a/kernel/module.c b/kernel/module.c
index c9bea7f2b43e..53cd6cd52dc6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/efi.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -274,9 +275,13 @@ static void module_assert_mutex_or_preempt(void)
 }
 
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-#ifndef CONFIG_MODULE_SIG_FORCE
+#ifdef CONFIG_MODULE_SIG_FORCE
+/* Allow disabling module signature requirement by adding boot param */
+static bool sig_unenforce;
+module_param(sig_unenforce, bool_enable_only, 0444);
+#else /* !CONFIG_MODULE_SIG_FORCE */
 module_param(sig_enforce, bool_enable_only, 0644);
-#endif /* !CONFIG_MODULE_SIG_FORCE */
+#endif /* CONFIG_MODULE_SIG_FORCE */
 
 /*
  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
@@ -415,6 +420,8 @@ extern const s32 __start___kcrctab_unused[];
 extern const s32 __start___kcrctab_unused_gpl[];
 #endif
 
+extern struct boot_params boot_params;
+
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
 #else
@@ -4243,6 +4250,20 @@ static const struct file_operations proc_modules_operations = {
 static int __init proc_modules_init(void)
 {
 	proc_create("modules", 0, NULL, &proc_modules_operations);
+
+#ifdef CONFIG_MODULE_SIG_FORCE
+	switch (boot_params.secure_boot) {
+	case efi_secureboot_mode_unset:
+	case efi_secureboot_mode_unknown:
+	case efi_secureboot_mode_disabled:
+		/*
+		 * sig_unenforce is only applied if SecureBoot is not
+		 * enabled.
+		 */
+		sig_enforce = !sig_unenforce;
+	}
+#endif
+
 	return 0;
 }
 module_init(proc_modules_init);
-- 
2.17.1
