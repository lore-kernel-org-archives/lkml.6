Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4720823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1oefpl2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB4720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeKSUzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:55:52 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:59353 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeKSUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:55:51 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAJAVrOC009918;
        Mon, 19 Nov 2018 19:31:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAJAVrOC009918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542623515;
        bh=UxpwZPndNpZuNEqiuBMWdLIBfZYlxrIZKZ+04Pdc4gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oefpl2QWCyEz5uu0/A6mfOYMdJ0IDson0waVI4TK4a7e5WXqkCak10TdFlluYITQ
         O0gPBU8v77j6f0k9eJ5i7rfwx6Qsw96qh7of+O+6u8B9gtYbMLAzSUJLXpBWb9pUK7
         YvmE8CD/uOf8h9r4JC5SAGmozsxqRu8Ywje2IAJe3Wc3Sn5YlsvFW+J3nnG6nc3HMw
         ZFNqGZfOYgblDQhwEABM6Oy2Poq/H4PK3j7jYcMSYJIy7BUQSLw0YI7n0HpybyRODc
         4XjO/i9G1es3BrA4tBD3bs0dblcZQOMXogogxzbuvctDj3/mOaKw5q3d/E+7xUMSIn
         hGLlP5VwfDzTQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] build_bug.h: remove most of dummy BUILD_BUG_ON stubs for sparse
Date:   Mon, 19 Nov 2018 19:31:43 +0900
Message-Id: <1542623503-3755-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of these dummy BUILD_BUG_ON stubs dates back to
commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
for sparse").

At that time, BUILD_BUG_ON() was implemented with the negative array
trick *and* the link-time trick, like this:

  extern int __build_bug_on_failed;
  #define BUILD_BUG_ON(condition)                                \
          do {                                                   \
                  ((void)sizeof(char[1 - 2*!!(condition)]));     \
                  if (condition) __build_bug_on_failed = 1;      \
          } while(0)

Sparse is more strict about the negative array trick than GCC because
Sparse requires the array length to be really constant.

Here is the simple test code for the macro above:

  static const int x = 0;
  BUILD_BUG_ON(x);

GCC is absolutely fine with it (-Wvla was not enabled at that time),
but Sparse warns like this:

  error: bad constant expression
  error: cannot size expression

(If you are using a newer version of Sparse, you will see a different
warning message, "warning: Variable length array is used".)

Anyway, Sparse was producing many false positive warnings, hence
silenced.

With the previous commit, the leftover negative array trick is gone.
Sparse is fine with the current BUILD_BUG_ON(), which is implemented
by using the 'error' attribute. (assuming your Sparse version supports
-Wno-unknown-attribute option)

I am keeping the stub for BUILD_BUG_ON_ZERO(). Otherwise, Sparse
would complain about the following code, which GCC is fine with:

  static const int x = 0;
  int y = BUILD_BUG_ON_ZERO(x);

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v3:
 - Add Kees' Acked-by
 - Clarify log that BUILD_BUG_ON() *was* producing false positives
 - Keep the stub for BUILD_BUG_ON_ZERO()

Changes in v2:
 - Fix a coding style error (two consecutive blank lines)

 include/linux/build_bug.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index d415c64..faeec74 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -5,21 +5,8 @@
 #include <linux/compiler.h>
 
 #ifdef __CHECKER__
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
 #define BUILD_BUG_ON_ZERO(e) (0)
-#define BUILD_BUG_ON_INVALID(e) (0)
-#define BUILD_BUG_ON_MSG(cond, msg) (0)
-#define BUILD_BUG_ON(condition) (0)
-#define BUILD_BUG() (0)
 #else /* __CHECKER__ */
-
-/* Force a compilation error if a constant expression is not a power of 2 */
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
-
 /*
  * Force a compilation error if condition is true, but also produce a
  * result (of value 0 and type size_t), so the expression can be used
@@ -27,6 +14,13 @@
  * aren't permitted).
  */
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#endif /* __CHECKER__ */
+
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
 
 /*
  * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
@@ -64,6 +58,4 @@
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
-#endif	/* __CHECKER__ */
-
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.7.4

