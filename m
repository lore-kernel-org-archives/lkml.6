Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeB0VQs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:16:48 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:39936 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeB0VQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:16:45 -0500
X-Google-Smtp-Source: AG47ELtnLOe+4pcONwWLsOqyt8vOL48irYbSSDoMVQ8qUY0ePVnSckH5UaF3TBZr+q4QohhMWIOpxEi02zZuHPgcZmehAA==
MIME-Version: 1.0
Date: Tue, 27 Feb 2018 13:16:36 -0800
In-Reply-To: <20180220225146.27650-1-mjg59@google.com>
Message-Id: <20180227211636.163241-1-mjg59@google.com>
References: <20180220225146.27650-1-mjg59@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Subject: [PATCH V3] Allow configuring whether unsigned modules taint the kernel
From: Matthew Garrett <mjg59@google.com>
To: jeyu@redhat.com
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distributions build kernels that are intended to satisfy multiple
use-cases. One is that kernels must be usable in scenarios where module
signing is required (such as many Secure Boot policies) and scenarios
where it isn't (such as booting the same kernel on a legacy BIOS
system). This requires that CONFIG_MODULE_SIG be set, but this causes a
change in behaviour for the legacy platform case - loading an unsigned
module now taints the kernel. This is a change in behaviour, and may
cause users to file bugs, increasing distribution support load.

This patch adds a CONFIG_MODULE_UNSIGNED_TAINT option, which controls
the default behaviour of the kernel. If set (the default) then behaviour
is unchanged - loading an unsigned module on a CONFIG_MODULE_SIG kernel
will taint the kernel. If not set, CONFIG_MODULE_SIG will have no impact
(ie, unloading unsigned modules will not cause taint) until module
signature enforcement is enabled, at which point the kernel will still
refuse to allow unsigned modules to load.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 Documentation/admin-guide/module-signing.rst    | 14 ++++++++++----
 init/Kconfig                                    | 13 ++++++++++++-
 kernel/module.c                                 |  7 ++++++-
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..6aa01ec01b81 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2339,6 +2339,13 @@
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
+	module.sig_unsigned_taint
+			[KNL] When CONFIG_MODULE_SIG is set, setting this
+			option means that loading modules without (valid)
+			signatures will taint the kernel. Note that if
+			CONFIG_MODULE_UNSIGNED_TAINT is set, that is always
+			true, so this option does nothing.
+
 	module_blacklist=  [KNL] Do not load a comma-separated list of
 			modules.  Useful for debugging problem modules.
 
diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 27e59498b487..e2dc4519972c 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -52,10 +52,12 @@ This has a number of options available:
      This specifies how the kernel should deal with a module that has a
      signature for which the key is not known or a module that is unsigned.
 
-     If this is off (ie. "permissive"), then modules for which the key is not
-     available and modules that are unsigned are permitted, but the kernel will
-     be marked as being tainted, and the concerned modules will be marked as
-     tainted, shown with the character 'E'.
+     If this is off (ie. "permissive"), then modules for which the key
+     is not available and modules that are unsigned are permitted. If
+     ``CONFIG_MODULE_UNSIGNED_TAINT`` is enabled or the unsigned_taint
+     parameter is set the kernel will be marked as being tainted, and
+     the concerned modules will be marked as tainted, shown with the
+     character 'E'.
 
      If this is on (ie. "restrictive"), only modules that have a valid
      signature that can be verified by a public key in the kernel's possession
@@ -266,6 +268,10 @@ for which it has a public key.   Otherwise, it will also load modules that are
 unsigned.   Any module for which the kernel has a key, but which proves to have
 a signature mismatch will not be permitted to load.
 
+If ``CONFIG_MODULE_SIG_TAINT`` is enabled or module.sig_taint=1 is
+supplied on the kernel command line, the kernel will be tainted if an
+invalidly signed or unsigned module is loaded.
+
 Any module that has an unparseable signature will be rejected.
 
 
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..5de9725325f3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1775,12 +1775,23 @@ config MODULE_SIG
 	  debuginfo strip done by some packagers (such as rpmbuild) and
 	  inclusion into an initramfs that wants the module size reduced.
 
+config MODULE_UNSIGNED_TAINT
+	bool "Taint the kernel on unsigned or incorrectly signed module load"
+	default y
+	depends on MODULE_SIG
+	help
+	  Taint the kernel if an unsigned or untrusted kernel module is loaded.
+	  If this option is enabled, the kernel will be tainted on an attempt
+	  to load an unsigned module or signed modules for which we don't have
+	  a key.
+
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
 	depends on MODULE_SIG
 	help
 	  Reject unsigned modules or signed modules for which we don't have a
-	  key.  Without this, such modules will simply taint the kernel.
+	  key. Without this, such modules will be loaded successfully but will
+	  (if MODULE_SIG_TAINT is set) taint the kernel.
 
 config MODULE_SIG_ALL
 	bool "Automatically sign all modules"
diff --git a/kernel/module.c b/kernel/module.c
index ad2d420024f6..1cef39088f6b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -288,6 +288,11 @@ bool is_module_sig_enforced(void)
 }
 EXPORT_SYMBOL(is_module_sig_enforced);
 
+static bool unsigned_taint = IS_ENABLED(CONFIG_MODULE_UNSIGNED_TAINT);
+#ifndef CONFIG_MODULE_UNSIGNED_TAINT
+module_param(unsigned_taint, bool_enable_only, 0644);
+#endif /* !CONFIG_MODULE_UNSIGNED_TAINT */
+
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
@@ -3685,7 +3690,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 #ifdef CONFIG_MODULE_SIG
 	mod->sig_ok = info->sig_ok;
-	if (!mod->sig_ok) {
+	if (!mod->sig_ok && unsigned_taint) {
 		pr_notice_once("%s: module verification failed: signature "
 			       "and/or required key missing - tainting "
 			       "kernel\n", mod->name);
-- 
2.16.2.395.g2e18187dfd-goog
