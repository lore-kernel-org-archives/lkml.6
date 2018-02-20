Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeBTKfG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:35:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeBTKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:35:03 -0500
Date: Tue, 20 Feb 2018 02:29:38 -0800
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-87358710c1fb4f1bf96bbe2349975ff9953fc9b2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        dwmw@amazon.co.uk
Reply-To: mingo@kernel.org, dwmw@amazon.co.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <1519037457-7643-5-git-send-email-dwmw@amazon.co.uk>
References: <1519037457-7643-5-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/retpoline: Support retpoline builds with Clang
Git-Commit-ID: 87358710c1fb4f1bf96bbe2349975ff9953fc9b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  87358710c1fb4f1bf96bbe2349975ff9953fc9b2
Gitweb:     https://git.kernel.org/tip/87358710c1fb4f1bf96bbe2349975ff9953fc9b2
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Mon, 19 Feb 2018 10:50:57 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 11:17:58 +0100

x86/retpoline: Support retpoline builds with Clang

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1519037457-7643-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
