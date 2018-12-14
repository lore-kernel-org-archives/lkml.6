Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03819C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF90206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="AayBWhx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeLNOQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:16:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36538 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:16:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so2915082pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtWilRGInAcb/NUhcDtH7YAZJfSIOGwgW3nzbl0W9IQ=;
        b=AayBWhx++Id141XiJ1IRtNF9YuU3agBHdXxOd/3mOX9QI5Ixe/HgEdjR4+SlOnKkXY
         +WDDlWrGdSxw+eFCqbIIudDT1/TRbHsj5Wxs463ESrzam65sJ/qC8qeQKonGRmydjIrn
         p8uwLJCPKAQzfyEP/c58CwnRfDMnzxGZTLrUpTsNC/zaQz714nS3entYsTi/3wAGjUNC
         V0niZMkIlV25xdb32l/SnuK1ASUrMgBaUWQXFchI8jhSMAJx6g8m6CVKGd9EFi+apb0w
         5YeGhODEsObV9Y2yFQOSb9LlroItQZwyPidfiv9HqGx3B0I1c9PLg7Q3Ko8WWDk5iIFj
         ZaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtWilRGInAcb/NUhcDtH7YAZJfSIOGwgW3nzbl0W9IQ=;
        b=VN3CbWL4W1KhRPgVIJC9M8oUuhWiIbdGPFkRbryNyh0GJV8oHzXbtgYIK0UPXda0/j
         iUlsgRxznpfNK/3xU2pcCHWqQVwXt5o2tRAm6XUbPM3j0OkUFoqEiCtWt3WUG2mFeGJM
         vxYDShw92VtPYPgseU5cJiUo8KY6EQTnEj5hEnYW3+GDrvcrd2cCwv/ieuiQC22WLNPv
         PcooqdRvw8DUf/BoShLJTDRXeE7jUy1F0eHvaDFaOM8owsnU7VviuO7Sa4pi5if+GuJN
         eiKTJMxUvkKh0ObDPwpyxUH3Z1/gIwOCUkE4oBLr/xI3S6v6QT4LpuI8bRyB6lxpnyG5
         EcSA==
X-Gm-Message-State: AA+aEWaSbWG5WcEkOK1nC+Mcy7ciAqI+syScBtfH86yfmCh0C6QURe2k
        CMCvm48OXuPHKXGP7gjpt6qj0Q==
X-Google-Smtp-Source: AFSGD/VnPa7Ilyi4kELEkXmfJKFhQuKG28lsBk2a1kq2ePcVpNkxNhrwRr5S56tE2s4SiysKSVkyTg==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr3026717pfl.106.1544796989893;
        Fri, 14 Dec 2018 06:16:29 -0800 (PST)
Received: from n3-021-216.byted.org ([122.14.241.109])
        by smtp.gmail.com with ESMTPSA id d6sm6199939pgc.89.2018.12.14.06.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 06:16:29 -0800 (PST)
From:   Xiaozhou Liu <liuxiaozhou@bytedance.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Xiaozhou Liu <liuxiaozhou@bytedance.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Compiler Attributes: don't pollute userspace with macro definitions
Date:   Fri, 14 Dec 2018 22:14:31 +0800
Message-Id: <20181214141433.466991-1-liuxiaozhou@bytedance.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros 'inline' and '__gnu_inline' used to be defined in compiler-gcc.h,
which was (and is) included entirely in (__KERNEL__ && !__ASSEMBLY__).
Commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
exclusive") had those macros exposed to userspace, unintentionally.

Then commit a3f8a30f3f00 ("Compiler Attributes: use feature checks
instead of version checks") moved '__gnu_inline' back into
(__KERNEL__ && !__ASSEMBLY__) and 'inline' was left behind. Since 'inline'
depends on '__gnu_inline', compiling error showing "unknown type name
‘__gnu_inline’" will pop up, if userspace somehow includes
<linux/compiler.h>.

Other macros like __must_check, notrace, etc. are in a similar situation.
So just move all these macros back into (__KERNEL__ && !__ASSEMBLY__).

Note:
  1. This patch only affects what userspace sees.
  2. __must_check (when !CONFIG_ENABLE_MUST_CHECK) and noinline_for_stack
     were once defined in __KERNEL__ only, but we believe that they can
     be put into !__ASSEMBLY__ too.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>
---

v3: move macros into !__ASSEMBLY__ too. (Miguel Ojeda)
v2: update commit message.

 include/linux/compiler_types.h | 108 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4a3f9c09c92d..ba814f18cb4c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -104,6 +104,60 @@ struct ftrace_likely_data {
 	unsigned long			constant;
 };
 
+#ifdef CONFIG_ENABLE_MUST_CHECK
+#define __must_check		__attribute__((__warn_unused_result__))
+#else
+#define __must_check
+#endif
+
+#if defined(CC_USING_HOTPATCH)
+#define notrace			__attribute__((hotpatch(0, 0)))
+#else
+#define notrace			__attribute__((__no_instrument_function__))
+#endif
+
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((__naked__)) notrace
+
+#define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
+
+/*
+ * Force always-inline if the user requests it so via the .config.
+ * GCC does not warn about unused static inline functions for
+ * -Wunused-function.  This turns out to avoid the need for complex #ifdef
+ * directives.  Suppress the warning in clang as well by using "unused"
+ * function attribute, which is redundant but not harmful for gcc.
+ * Prefer gnu_inline, so that extern inline functions do not emit an
+ * externally visible function. This makes extern inline behave as per gnu89
+ * semantics rather than c99. This prevents multiple symbol definition errors
+ * of extern inline functions at link time.
+ * A lot of inline functions can cause havoc with function tracing.
+ * Do not use __always_inline here, since currently it expands to inline again
+ * (which would break users of __always_inline).
+ */
+#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
+	!defined(CONFIG_OPTIMIZE_INLINING)
+#define inline inline __attribute__((__always_inline__)) __gnu_inline \
+	__maybe_unused notrace
+#else
+#define inline inline                                    __gnu_inline \
+	__maybe_unused notrace
+#endif
+
+#define __inline__ inline
+#define __inline   inline
+
+/*
+ * Rather then using noinline to prevent stack consumption, use
+ * noinline_for_stack instead.  For documentation reasons.
+ */
+#define noinline_for_stack noinline
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
@@ -161,58 +215,4 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
-#ifdef CONFIG_ENABLE_MUST_CHECK
-#define __must_check		__attribute__((__warn_unused_result__))
-#else
-#define __must_check
-#endif
-
-#if defined(CC_USING_HOTPATCH)
-#define notrace			__attribute__((hotpatch(0, 0)))
-#else
-#define notrace			__attribute__((__no_instrument_function__))
-#endif
-
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked			__attribute__((__naked__)) notrace
-
-#define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
-
-/*
- * Force always-inline if the user requests it so via the .config.
- * GCC does not warn about unused static inline functions for
- * -Wunused-function.  This turns out to avoid the need for complex #ifdef
- * directives.  Suppress the warning in clang as well by using "unused"
- * function attribute, which is redundant but not harmful for gcc.
- * Prefer gnu_inline, so that extern inline functions do not emit an
- * externally visible function. This makes extern inline behave as per gnu89
- * semantics rather than c99. This prevents multiple symbol definition errors
- * of extern inline functions at link time.
- * A lot of inline functions can cause havoc with function tracing.
- * Do not use __always_inline here, since currently it expands to inline again
- * (which would break users of __always_inline).
- */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-	!defined(CONFIG_OPTIMIZE_INLINING)
-#define inline inline __attribute__((__always_inline__)) __gnu_inline \
-	__maybe_unused notrace
-#else
-#define inline inline                                    __gnu_inline \
-	__maybe_unused notrace
-#endif
-
-#define __inline__ inline
-#define __inline   inline
-
-/*
- * Rather then using noinline to prevent stack consumption, use
- * noinline_for_stack instead.  For documentation reasons.
- */
-#define noinline_for_stack noinline
-
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.11.0

