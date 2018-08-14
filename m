Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6186BC46473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F3E21738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F3E21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391305AbeHNUg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:36:27 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:46879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390418AbeHNUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:36:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0CC4C1803EF28;
        Tue, 14 Aug 2018 17:48:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: metal85_81bf613c2b717
X-Filterd-Recvd-Size: 8597
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 17:48:11 +0000 (UTC)
Message-ID: <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com>
Subject: Re: Build failures with gcc 4.5 and older
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 14 Aug 2018 10:48:10 -0700
In-Reply-To: <20180814170904.GA12768@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 10:09 -0700, Guenter Roeck wrote:
> Hi,
> 
> Since commit c1a2f7f0c0645 ("mm: Allocate the mm_cpumask
> (mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"), building
> the Linux kernel with gcc version 4.5 and older fails as follows.
> 
> In file included from ./include/linux/mm.h:17:0,
>                  from ./include/linux/pid_namespace.h:7,
> 		 from ./include/linux/ptrace.h:10,
> 		 from arch/openrisc/kernel/asm-offsets.c:32:
> ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct
> 
> This is just an example with gcc 4.5.1 for or32. I have seen the problem
> with gcc 4.4 (for unicore32) as well.
> 
> Does that mean that gcc 4.5 and older are now officially no longer
> supported for compiling the kernel ?
> 
> If so, would it make sense to update include/linux/compiler-gcc.h
> accordingly ?

And Documentation/process/changes.rst which shows a
minimum version required of gcc as 3.2, etc...

With cleaning up now unnecessary version tests in
compiler-gcc.h, something like:
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
index 573f5a7d42d4..020e4b9eee5c 100644
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
@@ -148,47 +158,13 @@
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
@@ -207,24 +183,19 @@
 
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
@@ -262,10 +233,6 @@
 #define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
-#endif /* GCC_VERSION >= 40500 */
-
-#if GCC_VERSION >= 40600
-
 /*
  * When used with Link Time Optimization, gcc can optimize away C functions or
  * variables which are referenced only from assembly code.  __visible tells the
@@ -274,8 +241,7 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-#endif /* GCC_VERSION >= 40600 */
-
+/* gcc version specific checks */
 
 #if GCC_VERSION >= 40900 && !defined(__CHECKER__)
 /*
@@ -309,10 +275,8 @@
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
@@ -341,10 +305,9 @@
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
@@ -353,16 +316,6 @@
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
@@ -375,12 +328,9 @@
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



