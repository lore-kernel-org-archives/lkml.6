Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBSKvX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:51:23 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:8610 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBSKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:51:17 -0500
X-IronPort-AV: E=Sophos;i="5.46,534,1511827200";
   d="scan'208";a="720268878"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com, mingo@kernel.org
Subject: [PATCH v3 4/4] x86/retpoline: Support retpoline build with Clang
Date: Mon, 19 Feb 2018 10:50:57 +0000
Message-Id: <1519037457-7643-5-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/Makefile              | 5 ++++-
 include/linux/compiler-clang.h | 5 +++++
 include/linux/compiler-gcc.h   | 4 ++++
 include/linux/init.h           | 8 ++++----
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fad5516..dbc7d0e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,7 +232,10 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+    RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+
+    RETPOLINE_CFLAGS += $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
     ifneq ($(RETPOLINE_CFLAGS),)
         KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
     endif
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index d02a4df..d3f264a 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -27,3 +27,8 @@
 #if __has_feature(address_sanitizer)
 #define __SANITIZE_ADDRESS__
 #endif
+
+/* Clang doesn't have a way to turn it off per-function, yet. */
+#ifdef __noretpoline
+#undef __noretpoline
+#endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 73bc63e..673fbf9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -93,6 +93,10 @@
 #define __weak		__attribute__((weak))
 #define __alias(symbol)	__attribute__((alias(#symbol)))
 
+#ifdef RETPOLINE
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#endif
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
diff --git a/include/linux/init.h b/include/linux/init.h
index 506a981..bc27cf0 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -6,10 +6,10 @@
 #include <linux/types.h>
 
 /* Built-in __init functions needn't be compiled with retpoline */
-#if defined(RETPOLINE) && !defined(MODULE)
-#define __noretpoline __attribute__((indirect_branch("keep")))
+#if defined(__noretpoline) && !defined(MODULE)
+#define __noinitretpoline __noretpoline
 #else
-#define __noretpoline
+#define __noinitretpoline
 #endif
 
 /* These macros are used to mark some functions or 
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy __noretpoline
+#define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
-- 
2.7.4
