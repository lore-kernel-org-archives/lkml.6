Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78318214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UmEeRRMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78318214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeHUKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:08:34 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:21560 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:08:34 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7L6mA2a011149;
        Tue, 21 Aug 2018 15:48:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7L6mA2a011149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534834091;
        bh=9uIc3QcRIoszUTUNj1elJxtIjS/bvNPoEAYdfC6wQMo=;
        h=From:To:Cc:Subject:Date:From;
        b=UmEeRRMfhdIXBj4PwpHMiXaYXAJPUiHjpQHU6e+88e6QSguJcFCC8SFJUX0XE5U6j
         zbDEjyvGU9OBGO/KqVdkvzU6dWNfh3bIu3kFtt6YA30nZjRCON05uOvSkmlBVrovww
         dahF3OYScp1Stvin9T6lLuGRRuiBoF64WZCDEhhTkIe838QNOtTy/m5o5PqFUoOdAM
         mTnQCHHLiiWpbP6QT02+pd5+WNUNEWjL+igRgVowT2CFMlSiXH/6cqgTM0hjJyT03f
         FyJu5d08hWSYaXjLqYgh8C+FwPhsGVX0GA0kHWFNfDTV2BN94j2dUcGJyQpUgkiS9I
         xOBQl7+2+/MQg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] compiler-gcc: get back Clang build
Date:   Tue, 21 Aug 2018 15:48:08 +0900
Message-Id: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
missed the fact that <linux/compiler-gcc.h> is included by Clang
as well as by GCC.

Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
and it looks like GCC 4.2.1.

  $ scripts/gcc-version.sh -p clang
  040201

If you try to build the kernel with Clang, you will get the
"Sorry, your compiler is too old - please upgrade it."
followed by a bunch of "unknown attribute" warnings.

Add !defined(__clang__) to the minimum version check.

Also, revive the version test blocks for versions >= 4.2.1
in order to disable features not supported by Clang.

Fixes: cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/compiler-gcc.h | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 250b9b7..8e41fd2 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -10,7 +10,7 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
-#if GCC_VERSION < 40600
+#if !defined(__clang__) && GCC_VERSION < 40600
 # error Sorry, your compiler is too old - please upgrade it.
 #endif
 
@@ -163,7 +163,16 @@
 #define __used			__attribute__((__used__))
 #define __compiler_offsetof(a, b)					\
 	__builtin_offsetof(a, b)
+#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
+/*
+ * GCC version specific checks
+ *
+ * Keep the version checks for 4.2.1 or newer
+ * because Clang defines GCC_VERSION as 40201
+ */
+
+#if GCC_VERSION >= 40300
 /* Mark functions as cold. gcc will assume any path leading to a call
  * to them will be unlikely.  This means a lot of manual unlikely()s
  * are unnecessary now for any paths leading to the usual suspects
@@ -182,15 +191,20 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
+#ifndef __CHECKER__
+# define __compiletime_warning(message) __attribute__((warning(message)))
+# define __compiletime_error(message) __attribute__((error(message)))
+#endif /* __CHECKER__ */
+#endif /* GCC_VERSION >= 40300 */
+
+#if GCC_VERSION >= 40400
 #define __optimize(level)	__attribute__((__optimize__(level)))
 #define __nostackprotector	__optimize("no-stack-protector")
+#endif /* GCC_VERSION >= 40400 */
 
-#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
+#if GCC_VERSION >= 40500
 
 #ifndef __CHECKER__
-#define __compiletime_warning(message) __attribute__((warning(message)))
-#define __compiletime_error(message) __attribute__((error(message)))
-
 #ifdef LATENT_ENTROPY_PLUGIN
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
@@ -232,6 +246,9 @@
 #define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
+#endif /* GCC_VERSION >= 40500 */
+
+#if GCC_VERSION >= 40600
 /*
  * When used with Link Time Optimization, gcc can optimize away C functions or
  * variables which are referenced only from assembly code.  __visible tells the
@@ -240,7 +257,7 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-/* gcc version specific checks */
+#endif /* GCC_VERSION >= 40600 */
 
 #if GCC_VERSION >= 40900 && !defined(__CHECKER__)
 /*
@@ -274,8 +291,10 @@
  * folding in __builtin_bswap*() (yet), so don't set these for it.
  */
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
+#if GCC_VERSION >= 40400
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
+#endif
 #if GCC_VERSION >= 40800
 #define __HAVE_BUILTIN_BSWAP16__
 #endif
@@ -327,9 +346,12 @@
 #define __diag_GCC_warn		warning
 #define __diag_GCC_error	error
 
+/* Compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
+#if GCC_VERSION >= 40600
 #define __diag_str1(s)		#s
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
+#endif
 
 #if GCC_VERSION >= 80000
 #define __diag_GCC_8(s)		__diag(s)
-- 
2.7.4

