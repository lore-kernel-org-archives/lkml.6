Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbeBPDhz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:37:55 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46935 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeBPDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:37:51 -0500
X-Google-Smtp-Source: AH8x225ndL064Mcum2NCifMGKdjTtkPRbwQ/IuzCsNhb7ivtDDSTrZp10nmL7pdqVPKuCUMSEVjqiw==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/3] taint: Consolidate documentation
Date: Thu, 15 Feb 2018 19:37:43 -0800
Message-Id: <1518752264-47238-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518752264-47238-1-git-send-email-keescook@chromium.org>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidates the taint bit documentation into a single place with
both numeric and letter values. Additionally adds the missing TAINT_AUX
documentation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/sysctl/kernel.txt | 53 +++++++++++++++++++++--------------------
 kernel/panic.c                  | 23 ++++--------------
 2 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 412314eebda6..4a890c7fb6c3 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -964,32 +964,33 @@ detect a hard lockup condition.
 
 tainted:
 
-Non-zero if the kernel has been tainted.  Numeric values, which
-can be ORed together:
-
-   1 - A module with a non-GPL license has been loaded, this
-       includes modules with no license.
-       Set by modutils >= 2.4.9 and module-init-tools.
-   2 - A module was force loaded by insmod -f.
-       Set by modutils >= 2.4.9 and module-init-tools.
-   4 - Unsafe SMP processors: SMP with CPUs not designed for SMP.
-   8 - A module was forcibly unloaded from the system by rmmod -f.
-  16 - A hardware machine check error occurred on the system.
-  32 - A bad page was discovered on the system.
-  64 - The user has asked that the system be marked "tainted".  This
-       could be because they are running software that directly modifies
-       the hardware, or for other reasons.
- 128 - The system has died.
- 256 - The ACPI DSDT has been overridden with one supplied by the user
-        instead of using the one provided by the hardware.
- 512 - A kernel warning has occurred.
-1024 - A module from drivers/staging was loaded.
-2048 - The system is working around a severe firmware bug.
-4096 - An out-of-tree module has been loaded.
-8192 - An unsigned module has been loaded in a kernel supporting module
-       signature.
-16384 - A soft lockup has previously occurred on the system.
-32768 - The kernel has been live patched.
+Non-zero if the kernel has been tainted. Numeric values, which can be
+ORed together. The letters are seen in "Tainted" line of Oops reports.
+
+     1 (P):  A module with a non-GPL license has been loaded, this
+             includes modules with no license.
+             Set by modutils >= 2.4.9 and module-init-tools.
+     2 (F): A module was force loaded by insmod -f.
+            Set by modutils >= 2.4.9 and module-init-tools.
+     4 (S): Unsafe SMP processors: SMP with CPUs not designed for SMP.
+     8 (R): A module was forcibly unloaded from the system by rmmod -f.
+    16 (M): A hardware machine check error occurred on the system.
+    32 (B): A bad page was discovered on the system.
+    64 (U): The user has asked that the system be marked "tainted". This
+            could be because they are running software that directly modifies
+            the hardware, or for other reasons.
+   128 (D): The system has died.
+   256 (A): The ACPI DSDT has been overridden with one supplied by the user
+            instead of using the one provided by the hardware.
+   512 (W): A kernel warning has occurred.
+  1024 (C): A module from drivers/staging was loaded.
+  2048 (I): The system is working around a severe firmware bug.
+  4096 (O): An out-of-tree module has been loaded.
+  8192 (E): An unsigned module has been loaded in a kernel supporting module
+            signature.
+ 16384 (L): A soft lockup has previously occurred on the system.
+ 32768 (K): The kernel has been live patched.
+ 65536 (X): Auxiliary taint, defined and used by for distros.
 
 ==============================================================
 
diff --git a/kernel/panic.c b/kernel/panic.c
index c5e0fd5a188e..15d333a54ece 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -328,27 +328,12 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 };
 
 /**
- *	print_tainted - return a string to represent the kernel taint state.
+ * print_tainted - return a string to represent the kernel taint state.
  *
- *  'P' - Proprietary module has been loaded.
- *  'F' - Module has been forcibly loaded.
- *  'S' - SMP with CPUs not designed for SMP.
- *  'R' - User forced a module unload.
- *  'M' - System experienced a machine check exception.
- *  'B' - System has hit bad_page.
- *  'U' - Userspace-defined naughtiness.
- *  'D' - Kernel has oopsed before
- *  'A' - ACPI table overridden.
- *  'W' - Taint on warning.
- *  'C' - modules from drivers/staging are loaded.
- *  'I' - Working around severe firmware bug.
- *  'O' - Out-of-tree module has been loaded.
- *  'E' - Unsigned module has been loaded.
- *  'L' - A soft lockup has previously occurred.
- *  'K' - Kernel has been live patched.
- *  'X' - Auxiliary taint, for distros' use.
+ * For individual taint flag meanings, see Documentation/sysctl/kernel.txt
  *
- *	The string is overwritten by the next call to print_tainted().
+ * The string is overwritten by the next call to print_tainted(),
+ * but is always NULL terminated.
  */
 const char *print_tainted(void)
 {
-- 
2.7.4
