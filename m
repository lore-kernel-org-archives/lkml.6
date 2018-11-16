Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8479C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E2F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KTje1eHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E2F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbeKPQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:39:46 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37123 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKPQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:39:46 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAG6RdQS027653;
        Fri, 16 Nov 2018 15:27:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAG6RdQS027653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542349661;
        bh=FiMb9cm5cfC+tJ2DzG8B1uvbIVBWDvJqcdJNHmLq8dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTje1eHJ34nH0lQ8mleBtj+7Jr/c+y3AIs9EhiKH3tMvMIETEPRxGzrHleaR9FU8J
         k1ZX8ij6A+xTf7QqkpBsgaVYEc5ylOimFYr4pba4V/GxDVDOV0UA43E/ccIKmxdPOt
         ushtFWGMnbYMeDwndSxvhr+w64vTl6U/7U0AcWJY/Y5b678Re55r8DGvmTPR+hQJQs
         PHGqi4LfNRoqdhhATzaV1gOc8mqNzOi6Us0lu0URNpmP7qR2LEek8rtd0MgLamXET4
         RyvQzBvPmuDgvkx1/j+AZkgiBQET65WZkE6jE3vpBJiwN+TjjHANxqSPSaHnYklULd
         XcnmncRyW4tNQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] build_bug.h: remove all dummy BUILD_BUG_ON stubs for sparse
Date:   Fri, 16 Nov 2018 15:27:25 +0900
Message-Id: <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of these dummy BUILD_BUG_ON stubs dates back to
commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
for sparse"). At that time, BUILD_BUG_ON() was implemented with the
negative array trick, which Sparse complains about even if the
condition can be optimized and evaluated to 0 at compile-time.

With the previous commit, the leftover negative array trick is gone.
Sparse is happy with the current BUILD_BUG_ON(), which is implemented
by using the 'error' attribute.

There might be a little room for argument about BUILD_BUG_ON_ZERO().
Sparse reports 'invalid bitfield width, -1' for non-zero value,
and 'bad integer constant expression' for non-constant value.
This is the same criteria as GCC uses. So, if those Sparse errors
occurred, they would cause errors for GCC as well. (Hence, such
errors would have been detected by the normal compile test process.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Fix a coding style error (two consecutive blank lines)

 include/linux/build_bug.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index d415c64..6625c88 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -4,16 +4,6 @@
 
 #include <linux/compiler.h>
 
-#ifdef __CHECKER__
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_ZERO(e) (0)
-#define BUILD_BUG_ON_INVALID(e) (0)
-#define BUILD_BUG_ON_MSG(cond, msg) (0)
-#define BUILD_BUG_ON(condition) (0)
-#define BUILD_BUG() (0)
-#else /* __CHECKER__ */
-
 /* Force a compilation error if a constant expression is not a power of 2 */
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
 	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
@@ -64,6 +54,4 @@
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
-#endif	/* __CHECKER__ */
-
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.7.4

