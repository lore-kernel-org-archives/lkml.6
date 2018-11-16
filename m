Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D22208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="axIo3gH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D22208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbeKPQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:39:46 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37122 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:39:46 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAG6RdQR027653;
        Fri, 16 Nov 2018 15:27:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAG6RdQR027653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542349660;
        bh=AE9HOGag1iWONloFmWzxxe9Ll1Q5kgvlETsrHKesQQI=;
        h=From:To:Cc:Subject:Date:From;
        b=axIo3gH550BuYi8ju/zKpAPo4jB7f8KwnMfWuFjs05q0QLVBAlwjADUfypkd4eUiQ
         TrjazYvtYtLe1RcW32UTiu902FVodQzx2+vBu45JC893f4z8IXhGDupn5KvvQ3TGU5
         0XuBeWctGjqYoboM5soYsA/C5AOiR/Axu35otKPa8nwvbV8I/+5IsgdiDa0DnxnrMp
         iDo2ytrEFRSBqC8P55m3jTlQC00wBW5cDhxULlMyzY6CdxFLsz4APwKgX7CS1fQHiy
         CThKwQYlakP/JbtAqEm/pXS8HA5rYCj/KxtjgO31vfq8tm2Qo3t7RRE35XXN76zdFO
         1xIPfAyUhYz3g==
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
Subject: [PATCH v2 1/2] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
Date:   Fri, 16 Nov 2018 15:27:24 +0900
Message-Id: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can only be compiled with an optimization option (-O2, -Os,
or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
in the kernel source.

The fallback for -O0 case is just hypothetical and pointless. Moreover,
commit 0bb95f80a38f ("Makefile: Globally enable VLA warning") enabled
-Wvla warning. The use of variable length arrays is banned.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 include/linux/build_bug.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 43d1fd5..d415c64 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -51,23 +51,9 @@
  * If you have some code which relies on certain constants being equal, or
  * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
  * detect if someone changes it.
- *
- * The implementation uses gcc's reluctance to create a negative array, but gcc
- * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
- * inline functions).  Luckily, in 4.3 they added the "error" function
- * attribute just for this type of case.  Thus, we use a negative sized array
- * (should always create an error on gcc versions older than 4.4) and then call
- * an undefined function with the error attribute (should always create an
- * error on gcc 4.3 and later).  If for some reason, neither creates a
- * compile-time error, we'll still have a link-time error, which is harder to
- * track down.
  */
-#ifndef __OPTIMIZE__
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#else
 #define BUILD_BUG_ON(condition) \
 	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
-#endif
 
 /**
  * BUILD_BUG - break compile if used.
-- 
2.7.4

