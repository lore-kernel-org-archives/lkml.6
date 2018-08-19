Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25782C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AE2215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cRXrtkty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AE2215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeHSJDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 05:03:39 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:49329 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeHSJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 05:03:39 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7J5q2sB006201;
        Sun, 19 Aug 2018 14:52:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7J5q2sB006201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534657923;
        bh=AJ5o3WeTaVzWN4TQSQZ+BAvlJAeuRtOAc3TzW++J5QQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cRXrtkty1TuaFQvg/sQGTBjxYaz+nW5j4dOXUy6tRe1hUQ4F4/U+RaHJ33tSRjsAW
         9+eD9Oj/RW2W1yGcJvTERrJ1KfiQDjz36LRlEZBj5zRaXrhB4DkWASnfuUM2gzqCbf
         NhKzXAmYAhM9eHepPLb5R5YCmNZEfSlN+y1s2yX1So06PTzM+c1wgQRY2nzWal5Hmx
         DESNQoXT0CkhYb4FL7xRLdXPxchrOknvY3XrMirT6SGe8APJElJYHhMSrHuVx2Djtu
         Mx6+EZeYpwgCgPndrWr6kHiE3zscWU7p30tKiVynTNUSW8kqhzeR764tl7BY32fqeC
         /plbn6pSMwalA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Hogan <james.hogan@imgtec.com>, Joe Stringer <joe@ovn.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date:   Sun, 19 Aug 2018 14:51:20 +0900
Message-Id: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__compiletime_assert_fallback() is supposed to stop building earlier
by using the negative-array-size method in case the compiler does not
support "error" attribute, but has never worked like that.

You can try this simple code:

    #include <linux/build_bug.h>
    void foo(void)
    {
            BUILD_BUG_ON(1);
    }

GCC (precisely, GCC 4.3 or later) immediately terminates the build,
but Clang does not report anything because Clang does not support the
"error" attribute now.  It will eventually fail in the link stage,
but at least __compiletime_assert_fallback() is not working.

The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
was checked by the negative-array-size method *and* the link-time trick.
Since that commit, the negative-array-size is not effective because
'__cond' is no longer constant.  As the comment in <linux/build_bug.h>
says, GCC (and Clang as well) only emits the error for obvious cases.

When '__cond' is a variable,

    ((void)sizeof(char[1 - 2 * __cond]))

... is not obvious for the compiler to know the array size is negative.

One way to fix this is to stop the variable assignment, i.e. to pass
'!(condition)' directly to __compiletime_error_fallback() at the cost
of the double evaluation of 'condition'.  However, all calls of
BUILD_BUG() would be turned into errors even if they are called from
dead-code.

This commit does not change the current behavior since it just rips
off the code that has not been effective for some years.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/compiler.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 42506e4..c062238f4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -295,29 +295,14 @@ unsigned long read_word_at_a_time(const void *addr)
 #endif
 #ifndef __compiletime_error
 # define __compiletime_error(message)
-/*
- * Sparse complains of variable sized arrays due to the temporary variable in
- * __compiletime_assert. Unfortunately we can't just expand it out to make
- * sparse see a constant array size without breaking compiletime_assert on old
- * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
- */
-# ifndef __CHECKER__
-#  define __compiletime_error_fallback(condition) \
-	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
-# endif
-#endif
-#ifndef __compiletime_error_fallback
-# define __compiletime_error_fallback(condition) do { } while (0)
 #endif
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
 	do {								\
-		bool __cond = !(condition);				\
 		extern void prefix ## suffix(void) __compiletime_error(msg); \
-		if (__cond)						\
+		if (!(condition))					\
 			prefix ## suffix();				\
-		__compiletime_error_fallback(__cond);			\
 	} while (0)
 #else
 # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
-- 
2.7.4

