Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FD8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFC821534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppquJvPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFC821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbeITXID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeITXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so6474443wrw.5;
        Thu, 20 Sep 2018 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMnY+D2rvRttdz/lDFt2k/B+x2fQEuW2ApMkA3gPht0=;
        b=ppquJvPvKK9eF+QXE59VIdiXqSuRGb+gtQ6DHsp2txsDOHtFB9WilsF9kTQFW5tUgm
         fFTp+Kzy3uk4p6D874LuADCJ+uaYE6m50CQpvzZ9/atrDtZHGewLOB3AIIKBPuNE/Qzu
         +1HdEnTEGVlDXGxZEiqTj6ZpQrejTFmF+AtssR3WuayXkzYx9Jnok0dYDd5SomGm/btR
         /+QxmHjqE7vdX/SPw8KYY6r66/7ejzmghm6RQWCWBnW6uZu3sHjWVtTBWetlX/w82cA2
         amw/WGKpXgqhuXXq5hcHN3SmiaNKNwtU/0Ezdnx3NOIhb2atrESnNwDABFt8EPRc7MmK
         4Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMnY+D2rvRttdz/lDFt2k/B+x2fQEuW2ApMkA3gPht0=;
        b=pMF1ALgorndIX8eGuwb7YEIGdo8DQ1s6TKIv/M8Pw7l91AUqdy7q/NLeA59mqkCgrB
         HSaxTeU1yjWgGL76pzXZfLBLPzrS3N+zBHjFFLmGI3R2htZZBhWBzjzAGPd03qbbrgqO
         GxrV+C9t0++kU1IL7Lzi37KO12ozozNi+i3LjbPp8/Nak4cQtBc6bTi6hweU+Et02pEp
         MIetUYMt9w6ZQdXnaLjzQRoE/HNrIJeALle/6/uJwBZoV4ZaU+ORmr22DRPaDVw3xSxA
         c3256PfjtFAlxOYGslB/14H6lmYImBzojE4yFgSth5VQpYXkj82xyj1ZwxCS1134vqEK
         CHvA==
X-Gm-Message-State: APzg51CcDOwoiVWtjPll/vt6RSdUxEEOhTDlsH0YWaSCXFth263h0owo
        x0YaD1uZV2/DeoZUO3lwVaI=
X-Google-Smtp-Source: ANB0VdaLlP6giKyij4jDYPAG855j804DEyuIgdptpTIxLqVeASCSkMzDwBDp1h49ZRDKyX5GFvDn4A==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr34707941wrd.207.1537464208660;
        Thu, 20 Sep 2018 10:23:28 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:27 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 02/15] Compiler Attributes: always use the extra-underscores syntax
Date:   Thu, 20 Sep 2018 19:22:48 +0200
Message-Id: <20180920172301.21868-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute syntax optionally allows to surround attribute names
with "__" in order to avoid collisions with macros of the same name
(see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).

This homogenizes all attributes to use the syntax with underscores.
While there are currently only a handful of cases of some TUs defining
macros like "error" which may collide with the attributes,
this should prevent futures surprises.

This has been done only for "standard" attributes supported by
the major compilers. In other words, those of third-party tools
(e.g. sparse, plugins...) have not been changed for the moment.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler-gcc.h   | 12 +++++-----
 include/linux/compiler-intel.h |  2 +-
 include/linux/compiler.h       |  8 +++----
 include/linux/compiler_types.h | 42 +++++++++++++++++-----------------
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..d11cad61ba5c 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -21,7 +21,7 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
-#define __no_sanitize_address __attribute__((no_sanitize("address")))
+#define __no_sanitize_address __attribute__((__no_sanitize__("address")))
 
 /*
  * Not all versions of clang implement the the type-generic versions
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 1302b425e625..7a1de7683df5 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,7 +76,7 @@
 #endif
 
 #ifdef RETPOLINE
-#define __noretpoline __attribute__((indirect_branch("keep")))
+#define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
@@ -84,8 +84,8 @@
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
-#define __compiletime_warning(message) __attribute__((warning(message)))
-#define __compiletime_error(message) __attribute__((error(message)))
+#define __compiletime_warning(message) __attribute__((__warning__(message)))
+#define __compiletime_error(message) __attribute__((__error__(message)))
 
 #ifdef LATENT_ENTROPY_PLUGIN
 #define __latent_entropy __attribute__((latent_entropy))
@@ -134,7 +134,7 @@
  * optimizer that something else uses this function or variable, thus preventing
  * this.
  */
-#define __visible	__attribute__((externally_visible))
+#define __visible	__attribute__((__externally_visible__))
 
 /* gcc version specific checks */
 
@@ -191,7 +191,7 @@
  * should not be applied to that function.
  * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
  */
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #endif
 
 #if GCC_VERSION >= 50100
@@ -199,7 +199,7 @@
  * Mark structures as requiring designated initializers.
  * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
  */
-#define __designated_init __attribute__((designated_init))
+#define __designated_init __attribute__((__designated_init__))
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 4c7f9befa9f6..fef8bb3e53ef 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -42,4 +42,4 @@
  * and may be redefined here because they should not be shared with other
  * compilers, like clang.
  */
-#define __visible	__attribute__((externally_visible))
+#define __visible	__attribute__((__externally_visible__))
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7c0157d50964..ec4a28bad2c6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -24,7 +24,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			long ______r;					\
 			static struct ftrace_likely_data		\
 				__attribute__((__aligned__(4)))		\
-				__attribute__((section("_ftrace_annotated_branch"))) \
+				__attribute__((__section__("_ftrace_annotated_branch"))) \
 				______f = {				\
 				.data.func = __func__,			\
 				.data.file = __FILE__,			\
@@ -60,7 +60,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 		int ______r;						\
 		static struct ftrace_branch_data			\
 			__attribute__((__aligned__(4)))			\
-			__attribute__((section("_ftrace_branch")))	\
+			__attribute__((__section__("_ftrace_branch")))	\
 			______f = {					\
 				.func = __func__,			\
 				.file = __FILE__,			\
@@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((section("___kentry" "+" #sym ), used))	\
+	__attribute__((__section__("___kentry" "+" #sym ), used))	\
 	= (unsigned long)&sym;
 #endif
 
@@ -287,7 +287,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-	static void * __attribute__((section(".discard.addressable"), used)) \
+	static void * __attribute__((__section__(".discard.addressable"), used)) \
 		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
 
 /**
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a19562cb047c..8fbdd47dd3d0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -195,26 +195,26 @@ struct ftrace_likely_data {
  * would be.
  * [...]
  */
-#define __pure			__attribute__((pure))
-#define __aligned(x)		__attribute__((aligned(x)))
-#define __aligned_largest	__attribute__((aligned))
-#define __printf(a, b)		__attribute__((format(printf, a, b)))
-#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
-#define __maybe_unused		__attribute__((unused))
-#define __always_unused		__attribute__((unused))
-#define __mode(x)		__attribute__((mode(x)))
+#define __pure			__attribute__((__pure__))
+#define __aligned(x)		__attribute__((__aligned__(x)))
+#define __aligned_largest	__attribute__((__aligned__))
+#define __printf(a, b)		__attribute__((__format__(printf, a, b)))
+#define __scanf(a, b)		__attribute__((__format__(scanf, a, b)))
+#define __maybe_unused		__attribute__((__unused__))
+#define __always_unused		__attribute__((__unused__))
+#define __mode(x)		__attribute__((__mode__(x)))
 #define __malloc		__attribute__((__malloc__))
 #define __used			__attribute__((__used__))
-#define __noreturn		__attribute__((noreturn))
-#define __packed		__attribute__((packed))
-#define __weak			__attribute__((weak))
-#define __alias(symbol)		__attribute__((alias(#symbol)))
-#define __cold			__attribute__((cold))
+#define __noreturn		__attribute__((__noreturn__))
+#define __packed		__attribute__((__packed__))
+#define __weak			__attribute__((__weak__))
+#define __alias(symbol)		__attribute__((__alias__(#symbol)))
+#define __cold			__attribute__((__cold__))
 #define __section(S)		__attribute__((__section__(#S)))
 
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
-#define __must_check		__attribute__((warn_unused_result))
+#define __must_check		__attribute__((__warn_unused_result__))
 #else
 #define __must_check
 #endif
@@ -222,7 +222,7 @@ struct ftrace_likely_data {
 #if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
-#define notrace			__attribute__((no_instrument_function))
+#define notrace			__attribute__((__no_instrument_function__))
 #endif
 
 /*
@@ -231,7 +231,7 @@ struct ftrace_likely_data {
  * stack and frame pointer being set up and there is no chance to
  * restore the lr register to the value before mcount was called.
  */
-#define __naked			__attribute__((naked)) notrace
+#define __naked			__attribute__((__naked__)) notrace
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
@@ -242,7 +242,7 @@ struct ftrace_likely_data {
  * defined so the gnu89 semantics are the default.
  */
 #ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((gnu_inline))
+# define __gnu_inline	__attribute__((__gnu_inline__))
 #else
 # define __gnu_inline
 #endif
@@ -262,17 +262,17 @@ struct ftrace_likely_data {
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
 	!defined(CONFIG_OPTIMIZE_INLINING)
 #define inline \
-	inline __attribute__((always_inline, unused)) notrace __gnu_inline
+	inline __attribute__((__always_inline__, __unused__)) notrace __gnu_inline
 #else
-#define inline inline	__attribute__((unused)) notrace __gnu_inline
+#define inline inline	__attribute__((__unused__)) notrace __gnu_inline
 #endif
 
 #define __inline__ inline
 #define __inline inline
-#define noinline	__attribute__((noinline))
+#define noinline	__attribute__((__noinline__))
 
 #ifndef __always_inline
-#define __always_inline inline __attribute__((always_inline))
+#define __always_inline inline __attribute__((__always_inline__))
 #endif
 
 /*
-- 
2.17.1

