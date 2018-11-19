Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE1020823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="es473xh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE1020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeKSUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:55:51 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:59354 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeKSUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:55:51 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAJAVrOB009918;
        Mon, 19 Nov 2018 19:31:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAJAVrOB009918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542623514;
        bh=8Od9yITiN3CpQ9ID8oxmfcb1MGMov3ZoJ+/Zebs+qw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es473xh3BXGrESilENTJ82S6FUNHsottnp1X6xGXkAXtiFTf537ER62oQzK6A14UU
         K964ZaGfZhg1NiylVuxj9rzo8dwG1ULrBwTPRQN03iDH+GDytfoVtZGnpxzAMx5TP/
         DjEH9b3s7YZP4M7SwxrkY0gk8TB+19Fae4tg52EyrKZvw6xSTG9C+tUcCHe4KMuHMU
         n7qPbT5pzvCIDSWfhbjvj6YYzof43pnhyffPA7EPxwB3sEvTThg21gGtNJGcaADaI6
         xYKsRzPuMihOygCymhCceaf66UA/Ozx6BnkvLf/uDhdM/Lwk16Iv+gelvkJ6G7MNdW
         phzVg16pCvM7w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
Date:   Mon, 19 Nov 2018 19:31:42 +0900
Message-Id: <1542623503-3755-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can only be compiled with an optimization option (-O2, -Os,
or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
in the kernel source.

The fallback for the -O0 case is just hypothetical and pointless.
Moreover, commit 0bb95f80a38f ("Makefile: Globally enable VLA warning")
enabled -Wvla warning. The use of variable length arrays is banned.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v3: None
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

