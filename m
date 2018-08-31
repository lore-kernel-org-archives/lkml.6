Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C4FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F5B20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz0tvJh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F5B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeHaVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34173 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeHaVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id j25-v6so3822108wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MattRFtonwDaxU1QdB3LlHBD2lClNUTulWxSVvPqfV4=;
        b=Oz0tvJh81l/+cJktUQCCwgeDOu87PT/dPzt13F8UfNf73t3NjAjYQaAGwRCs6jyF6n
         3bnuksa1siQ69roacdWrTdxyLJJXFNitbRgLhESDExwMmueXUzcLKpwWmciTrxdMTPLj
         fN32YbX3QJ2u671IOm5rbZ24wk9a10QzpXqPFaDE4mgrh6+8XcGrx6edeaDhLp8UjEKr
         It2V0wgg/sevhu1zjj9iwhV7GzWsYFlz/mb8HHiHi5zoE0n4ugaVpgHtl8fYL0F+bvaF
         WpS35ma5OiKishAgPp8+A6cBs4MDZvrKbfEjn7KpoEXbBGOsMgAoWYJ/CR/7jSR8LH57
         rwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MattRFtonwDaxU1QdB3LlHBD2lClNUTulWxSVvPqfV4=;
        b=jKbd8fcFaz2Uign6dxwJ4qHsn/oZ0Edef3eXy/KDnbFewFouQN+xmUiRZF1Cwm9Jc2
         obULhnrAp3Sga5gyn0Yct3lq1cXdLjpiyF4nrVnsKgJFRdlVPJe6jQ8ujywK/C6z1dOL
         oCRA/OCl4cfSximCIlNMMwvDA9qq8TUsl9QbFH3lnMYqArtEPxYuBmQyt+sHAb89tvuh
         Y4u7fANK3lThjr+Ecg0HXXUn/PEyNI7GBZkSN0NI2Gtz3IL8GVp7zlH3N1AVdhkwu0pw
         YMwP84+WFkl2Aeio3K40POkkrcg9z4fCX2HyRi4jGuLzma9xe4K79CrJONUGbbl8yeDx
         oAqg==
X-Gm-Message-State: APzg51B9/aL0dPYMID1mT6TXVnHO8HAB4ieFXAYfnrRH4PCnJ83A5Q4t
        HibbsIWtEhUCPpOEjs4+XTA=
X-Google-Smtp-Source: ANB0VdZ0BCZ6JAxIt20dA+J1XJcgIxkDeQr1T7wLV4u/sF6nMKuI3fPOIf2t0xugmTxT6yQsV7+8Wg==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr5402205wmo.84.1535735122249;
        Fri, 31 Aug 2018 10:05:22 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:21 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
Date:   Fri, 31 Aug 2018 19:05:09 +0200
Message-Id: <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute syntax optionally allows to surround attribute names
with "__" in order to avoid collisions with macros of the same name
(see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).

This homogenizes all attributes to use the syntax without underscores.

Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-clang.h | 2 +-
 include/linux/compiler-gcc.h   | 4 ++--
 include/linux/compiler.h       | 4 ++--
 include/linux/compiler_types.h | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..efda74f4eeba 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -43,4 +43,4 @@
 #define barrier() __asm__ __volatile__("" : : : "memory")
 #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #define __assume_aligned(a, ...)	\
-	__attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
+	__attribute__((assume_aligned(a, ## __VA_ARGS__)))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0a2d06677d83..dbfbecf703f8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -132,7 +132,7 @@
 	} while (0)
 
 /* Mark a function definition as prohibited from being cloned. */
-#define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
+#define __noclone	__attribute__((noclone, optimize("no-tracer")))
 
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
 #define __randomize_layout __attribute__((randomize_layout))
@@ -165,7 +165,7 @@
  * compiler should see some alignment anyway, when the return value is
  * massaged by 'flags = ptr & 3; ptr &= ~3;').
  */
-#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
+#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
 #endif
 
 /*
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7c0157d50964..e0e55eb3f242 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -23,7 +23,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __branch_check__(x, expect, is_constant) ({			\
 			long ______r;					\
 			static struct ftrace_likely_data		\
-				__attribute__((__aligned__(4)))		\
+				__attribute__((aligned(4)))		\
 				__attribute__((section("_ftrace_annotated_branch"))) \
 				______f = {				\
 				.data.func = __func__,			\
@@ -59,7 +59,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	({								\
 		int ______r;						\
 		static struct ftrace_branch_data			\
-			__attribute__((__aligned__(4)))			\
+			__attribute__((aligned(4)))			\
 			__attribute__((section("_ftrace_branch")))	\
 			______f = {					\
 				.func = __func__,			\
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6534292ea33..7cd958360ead 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -159,7 +159,7 @@ struct ftrace_likely_data {
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
 #ifndef __attribute_const__
-#define __attribute_const__	__attribute__((__const__))
+#define __attribute_const__	__attribute__((const))
 #endif
 
 #ifndef __noclone
@@ -203,14 +203,14 @@ struct ftrace_likely_data {
 #define __maybe_unused		__attribute__((unused))
 #define __always_unused		__attribute__((unused))
 #define __mode(x)		__attribute__((mode(x)))
-#define __malloc		__attribute__((__malloc__))
-#define __used			__attribute__((__used__))
+#define __malloc		__attribute__((malloc))
+#define __used			__attribute__((used))
 #define __noreturn		__attribute__((noreturn))
 #define __packed		__attribute__((packed))
 #define __weak			__attribute__((weak))
 #define __alias(symbol)		__attribute__((alias(#symbol)))
 #define __cold			__attribute__((cold))
-#define __section(S)		__attribute__((__section__(#S)))
+#define __section(S)		__attribute__((section(#S)))
 
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
-- 
2.17.1

