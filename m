Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5637AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BEF20C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BEF20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeHTXcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:32:32 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:37383 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbeHTXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:32:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 805FE18041932;
        Mon, 20 Aug 2018 20:15:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent81_12b0c73fb3f00
X-Filterd-Recvd-Size: 8568
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Aug 2018 20:15:28 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Raise the minimum required gcc version to 4.6
Date:   Mon, 20 Aug 2018 13:15:26 -0700
Message-Id: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various architectures fail to build properly with older versions
of the gcc compiler.

An example from Guenter Roeck via this thread:
https://lore.kernel.org/lkml/20180814170904.GA12768@roeck-us.net/

----------------------
In file included from ./include/linux/mm.h:17:0,
                 from ./include/linux/pid_namespace.h:7,
                 from ./include/linux/ptrace.h:10,
                 from arch/openrisc/kernel/asm-offsets.c:32:
./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct

This is just an example with gcc 4.5.1 for or32. I have seen the problem
with gcc 4.4 (for unicore32) as well.
----------------------

So update the minimum required version of gcc to 4.6.

Miscellanea:

o Update Documentation/process/changes.rst
o Remove and consolidate version test blocks in compiler-gcc.h
  for versions lower than 4.6

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/process/changes.rst |  2 +-
 include/linux/compiler-gcc.h      | 86 ++++++++-------------------------------
 2 files changed, 19 insertions(+), 69 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 7a92a06f90de..61f918b10a0c 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -29,7 +29,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
-GNU C                  3.2              gcc --version
+GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
 binutils               2.20             ld -v
 flex                   2.5.35           flex --version
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3e70b7d4e9ed..250b9b7cfd60 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -10,6 +10,10 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
+#if GCC_VERSION < 40600
+# error Sorry, your compiler is too old - please upgrade it.
+#endif
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
@@ -58,6 +62,12 @@
 #define OPTIMIZER_HIDE_VAR(var)						\
 	__asm__ ("" : "=r" (var) : "0" (var))
 
+/*
+ * A trick to suppress uninitialized variable warning without generating any
+ * code
+ */
+#define uninitialized_var(x) x = x
+
 #ifdef __CHECKER__
 #define __must_be_array(a)	0
 #else
@@ -91,7 +101,7 @@
  * A lot of inline functions can cause havoc with function tracing.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
-    !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
+    !defined(CONFIG_OPTIMIZE_INLINING)
 #define inline \
 	inline __attribute__((always_inline, unused)) notrace __gnu_inline
 #else
@@ -147,47 +157,13 @@
 #define __always_unused		__attribute__((unused))
 #define __mode(x)               __attribute__((mode(x)))
 
-/* gcc version specific checks */
-
-#if GCC_VERSION < 30200
-# error Sorry, your compiler is too old - please upgrade it.
-#endif
-
-#if GCC_VERSION < 30300
-# define __used			__attribute__((__unused__))
-#else
-# define __used			__attribute__((__used__))
-#endif
-
-#ifdef CONFIG_GCOV_KERNEL
-# if GCC_VERSION < 30400
-#   error "GCOV profiling support for gcc versions below 3.4 not included"
-# endif /* __GNUC_MINOR__ */
-#endif /* CONFIG_GCOV_KERNEL */
-
-#if GCC_VERSION >= 30400
 #define __must_check		__attribute__((warn_unused_result))
 #define __malloc		__attribute__((__malloc__))
-#endif
-
-#if GCC_VERSION >= 40000
-
-/* GCC 4.1.[01] miscompiles __weak */
-#ifdef __KERNEL__
-# if GCC_VERSION >= 40100 &&  GCC_VERSION <= 40101
-#  error Your version of gcc miscompiles the __weak directive
-# endif
-#endif
 
 #define __used			__attribute__((__used__))
 #define __compiler_offsetof(a, b)					\
 	__builtin_offsetof(a, b)
 
-#if GCC_VERSION >= 40100
-# define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-#endif
-
-#if GCC_VERSION >= 40300
 /* Mark functions as cold. gcc will assume any path leading to a call
  * to them will be unlikely.  This means a lot of manual unlikely()s
  * are unnecessary now for any paths leading to the usual suspects
@@ -206,24 +182,19 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#ifndef __CHECKER__
-# define __compiletime_warning(message) __attribute__((warning(message)))
-# define __compiletime_error(message) __attribute__((error(message)))
-#endif /* __CHECKER__ */
-#endif /* GCC_VERSION >= 40300 */
-
-#if GCC_VERSION >= 40400
 #define __optimize(level)	__attribute__((__optimize__(level)))
 #define __nostackprotector	__optimize("no-stack-protector")
-#endif /* GCC_VERSION >= 40400 */
 
-#if GCC_VERSION >= 40500
+#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
+#define __compiletime_warning(message) __attribute__((warning(message)))
+#define __compiletime_error(message) __attribute__((error(message)))
+
 #ifdef LATENT_ENTROPY_PLUGIN
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
-#endif
+#endif /* __CHECKER__ */
 
 /*
  * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
@@ -261,10 +232,6 @@
 #define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
-#endif /* GCC_VERSION >= 40500 */
-
-#if GCC_VERSION >= 40600
-
 /*
  * When used with Link Time Optimization, gcc can optimize away C functions or
  * variables which are referenced only from assembly code.  __visible tells the
@@ -273,8 +240,7 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-#endif /* GCC_VERSION >= 40600 */
-
+/* gcc version specific checks */
 
 #if GCC_VERSION >= 40900 && !defined(__CHECKER__)
 /*
@@ -308,10 +274,8 @@
  * folding in __builtin_bswap*() (yet), so don't set these for it.
  */
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
-#if GCC_VERSION >= 40400
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
-#endif
 #if GCC_VERSION >= 40800
 #define __HAVE_BUILTIN_BSWAP16__
 #endif
@@ -340,10 +304,9 @@
  * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
  */
 #define __designated_init __attribute__((designated_init))
+#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
-#endif	/* gcc version >= 40000 specific checks */
-
 #if !defined(__noclone)
 #define __noclone	/* not needed */
 #endif
@@ -352,16 +315,6 @@
 #define __no_sanitize_address
 #endif
 
-/*
- * A trick to suppress uninitialized variable warning without generating any
- * code
- */
-#define uninitialized_var(x) x = x
-
-#if GCC_VERSION >= 50100
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
@@ -374,12 +327,9 @@
 #define __diag_GCC_warn		warning
 #define __diag_GCC_error	error
 
-/* Compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
-#if GCC_VERSION >= 40600
 #define __diag_str1(s)		#s
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
-#endif
 
 #if GCC_VERSION >= 80000
 #define __diag_GCC_8(s)		__diag(s)
-- 
2.15.0

