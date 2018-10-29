Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB532084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x/16oJ45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB532084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJ3Aax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:30:53 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25348 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeJ3Aax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:30:53 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w9TFfWK2013655;
        Tue, 30 Oct 2018 00:41:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w9TFfWK2013655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540827692;
        bh=HMAzEtLUBQ8jV61vaUgZPyx7GDQriWLLUT3ZTQfut0g=;
        h=From:To:Cc:Subject:Date:From;
        b=x/16oJ45sYdXqK1urzvNx62AfT54nJeWSvGIXDxeuBU0EelgcjsPSwq9816mm4Nr7
         Bj2bbnVsYuk2bMXExQfvvpWUbPSJ3S+TTQQ197VpXh26/XZmP6qnn0Jt7YmlSDFjqe
         WyDS0up9Cq2vW+3EjFuPyMYQqPWQ+zayVJ47n+38JiKDH1OlMU+Xab5XrBzADmXoy4
         ILOaGzGwHxer3JV8U9WquBUOHM6WJt/U2LzuD9LqsNGGzg6I1OdOKdzHT8dGmO+8Bp
         yAAnt2/W2YzbFM8zb1ILYyX5BWWN01Hl1bVKadr/2i1QcHo4nfFI3NlRRe2xVhMVOp
         iq3G6xvmlF2zw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: remove oldnoconfig target
Date:   Tue, 30 Oct 2018 00:41:27 +0900
Message-Id: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 312ee68752fa ("kconfig: announce removal of oldnoconfig if
used") announced, it is time for the removal.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile | 9 +--------
 scripts/kconfig/conf.c   | 7 -------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 67ed9f6..5d37a60 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -68,14 +68,7 @@ PHONY += $(simple-targets)
 $(simple-targets): $(obj)/conf
 	$< $(silent) --$@ $(Kconfig)
 
-PHONY += oldnoconfig silentoldconfig savedefconfig defconfig
-
-# oldnoconfig is an alias of olddefconfig, because people already are dependent
-# on its behavior (sets new symbols to their default value but not 'n') with the
-# counter-intuitive name.
-oldnoconfig: olddefconfig
-	@echo "  WARNING: \"oldnoconfig\" target will be removed after Linux 4.19"
-	@echo "            Please use \"olddefconfig\" instead, which is an alias."
+PHONY += silentoldconfig savedefconfig defconfig
 
 # We do not expect manual invokcation of "silentoldcofig" (or "syncconfig").
 silentoldconfig: syncconfig
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 7b2b372..98e0c7a 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -460,12 +460,6 @@ static struct option long_opts[] = {
 	{"randconfig",      no_argument,       NULL, randconfig},
 	{"listnewconfig",   no_argument,       NULL, listnewconfig},
 	{"olddefconfig",    no_argument,       NULL, olddefconfig},
-	/*
-	 * oldnoconfig is an alias of olddefconfig, because people already
-	 * are dependent on its behavior(sets new symbols to their default
-	 * value but not 'n') with the counter-intuitive name.
-	 */
-	{"oldnoconfig",     no_argument,       NULL, olddefconfig},
 	{NULL, 0, NULL, 0}
 };
 
@@ -480,7 +474,6 @@ static void conf_usage(const char *progname)
 	printf("  --syncconfig            Similar to oldconfig but generates configuration in\n"
 	       "                          include/{generated/,config/}\n");
 	printf("  --olddefconfig          Same as oldconfig but sets new symbols to their default value\n");
-	printf("  --oldnoconfig           An alias of olddefconfig\n");
 	printf("  --defconfig <file>      New config with default defined in <file>\n");
 	printf("  --savedefconfig <file>  Save the minimal current configuration to <file>\n");
 	printf("  --allnoconfig           New config where all options are answered with no\n");
-- 
2.7.4

