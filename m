Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940E21581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yN/JvsaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B940E21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHYV4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:56:51 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:60229 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHYV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:56:51 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7PIGZeW027987;
        Sun, 26 Aug 2018 03:16:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7PIGZeW027987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535220995;
        bh=j+K7PHGyJBhSYAiDGKYPS2wMpUuPPd1zgTSqpkO6vBE=;
        h=From:To:Cc:Subject:Date:From;
        b=yN/JvsaWv7RTaBYJjmESTHH49Pvpr4dMIbUJqvz7UCf4GDE6UMkvEy0dmd44ulrkt
         7WO7dXbkcb7OrsXHyoypVy7gB+71cd3GzPI023QNPkabwhfNq9yJYsJE9XYHkQJHLs
         NiKODu+THPqLlUaL9FnaaYMZJ03Ml5JgD/0Sbi9A5lqFzGTzpokO7HhFJ7q5G2VgOT
         SkM21vUACqMNLZThjy+3ufH/3sUO3lf2mHytCODeqQCFdMbDhDeeaksVzlDF4PCnix
         kGnKxkYRt1U8mC9lUMQVL6KqzJG1CP/1V1GB0IE1mx/5Go73EMdsnJdUsnCoLwBBmx
         ENOZTUGHbyrKQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date:   Sun, 26 Aug 2018 03:16:29 +0900
Message-Id: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__compiletime_assert_fallback() is supposed to stop building earlier
by using the negative-array-size method in case the compiler does not
support "error" attribute, but has never worked like that.

You can simply try:

    BUILD_BUG_ON(1);

GCC immediately terminates the build, but Clang does not report
anything because Clang does not support the "error" attribute now.
It will later fail at link time, but __compiletime_assert_fallback()
is not working at least.

The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
was checked by the negative-array-size method *and* the link-time trick.
Since that commit, the negative-array-size is not effective because
'__cond' is no longer constant.  As the comment in <linux/build_bug.h>
says, GCC (and Clang as well) only emits the error for obvious cases.

When '__cond' is a variable,

    ((void)sizeof(char[1 - 2 * __cond]))

... is not obvious for the compiler to know the array size is negative.

Reverting that commit would break BUILD_BUG() because negative-size-array
is evaluated before the code is optimized out.

Let's give up __compiletime_assert_fallback().  This commit does not
change the current behavior since it just rips off the useless code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Rebase

 include/linux/compiler.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866..87c776c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *off)
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
-		int __cond = !(condition);				\
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

