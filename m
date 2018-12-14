Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D88C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0C20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I3041r5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A0C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeLNIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:06:17 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:28078 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLNIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:06:13 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBE85gQT007194;
        Fri, 14 Dec 2018 17:05:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBE85gQT007194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544774743;
        bh=vr8fjlTWSuQGReVOV6A95VVc8nQk5JFmiCc4p1232Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3041r5Knm6b+kaLVYalZJWugpGR5GLXvq1xmQwrVq83RYvZBKHQvvuitiOMqSy9O
         /OwHZlr91OLniJrkopfK8duDBMmi4UbfItTPaP4nl/EE71rMrUbZEhAKKm4sANgzTH
         OAPY2VAtYXa5q53dD6A6kVBtutfOvLMo7Mu45IZXNEzO2euxRz1Nsk3TaELHfngbPT
         omCNq8jJWnH8C/OUyv+E/jesd2hU7oENStt6H54OwOdvPccPOQJzs/Sc5wecTRH+fR
         NmKxcA+U2SQ0F0buUyqq5+7bkwC/Yr4H9MAEK71Eif4otxgrWfLHzEWfABtKdfz1hJ
         tnH7vTngRUxCA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: add -Werror=strict-prototype flag unconditionally
Date:   Fri, 14 Dec 2018 17:05:38 +0900
Message-Id: <1544774739-13471-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Wstrict-prototype is added to KBUILD_CFLAGS first, then overridden
by -Werror=strict-prototype later.

Let's add -Werror=strict-prototypes unconditionally because it is
supported by GCC 4.6, and also by Clang.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3bbc16a..bcb943e 100644
--- a/Makefile
+++ b/Makefile
@@ -423,7 +423,7 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
@@ -828,9 +828,6 @@ KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 # disallow errors like 'EXPORT_GPL(foo);' with missing header
 KBUILD_CFLAGS   += $(call cc-option,-Werror=implicit-int)
 
-# require functions to have arguments in prototypes, not empty 'int foo()'
-KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)
-
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
-- 
2.7.4

