Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WD27DmY5GFt7bQAAmS7hNA
	; Wed, 06 Jun 2018 19:44:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2F20160861; Wed,  6 Jun 2018 19:44:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8306C601C3;
	Wed,  6 Jun 2018 19:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8306C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeFFToQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:44:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:43169 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbeFFToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:44:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 12:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="45793122"
Received: from btwarden-clr.jf.intel.com ([10.54.74.129])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2018 12:44:14 -0700
From: "Brett T. Warden" <brett.t.warden@intel.com>
To: linux-kernel@vger.kernel.org, jeyu@kernel.org
Subject: [PATCH v2] module: Implement sig_unenforce parameter
Date: Wed,  6 Jun 2018 12:44:14 -0700
Message-Id: <20180606194414.14500-1-brett.t.warden@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <201806062114.40uzFbuB%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULE_SIG_FORCE is enabled, also provide a boot-time-only
parameter, module.sig_unenforce, to disable signature enforcement. This
allows distributions to ship with signature verification enforcement
enabled by default, but for users to elect to disable it without
recompiling, to support building and loading out-of-tree modules.

Signed-off-by: Brett T. Warden <brett.t.warden@intel.com>
---

Added CONFIG_X86 guards around use of boot_params since this structure
is arch-specific.

 .../admin-guide/kernel-parameters.txt         |  4 +++
 kernel/module.c                               | 31 +++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

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
index c9bea7f2b43e..27f23d85e1ba 100644
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
@@ -415,6 +420,10 @@ extern const s32 __start___kcrctab_unused[];
 extern const s32 __start___kcrctab_unused_gpl[];
 #endif
 
+#ifdef CONFIG_X86
+extern struct boot_params boot_params;
+#endif
+
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
 #else
@@ -4243,6 +4252,24 @@ static const struct file_operations proc_modules_operations = {
 static int __init proc_modules_init(void)
 {
 	proc_create("modules", 0, NULL, &proc_modules_operations);
+
+#ifdef CONFIG_MODULE_SIG_FORCE
+#ifdef CONFIG_X86
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
+#else
+	sig_enforce = !sig_unenforce;
+#endif
+#endif
+
 	return 0;
 }
 module_init(proc_modules_init);
-- 
2.17.1
