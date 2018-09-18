Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96418ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F4320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t387fXDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F4320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeIRJaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:30:17 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:39411 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeIRJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:30:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8I3wa79011632;
        Tue, 18 Sep 2018 12:58:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8I3wa79011632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537243117;
        bh=0GikBV1boSu4LBO9XSS9Q0Txn8pjxfM2Z9dgnIB1h6o=;
        h=From:To:Cc:Subject:Date:From;
        b=t387fXDmKNcY0mnPMgorqrrUlvqP8UTplmVvf1y5oEAT1p49UAPTuiJWNcJfDMlPa
         5WBXcEGSgkuS+zLPDQugioZbxnbvit9AgpQh/FVKKW94mLtRab+lHloIvwgHg1Ii83
         CKc0Pf60QETfSWmrQ5OJBjL6h+yGScon/XgNk5PGsjQ4OteW4ha5llnvPT4vYCROze
         jFRnbMceFR2hiCUklmdNXlr2y+RJR3J8bFSvzGijims5MoFQyLynVidI+GTvqLeeLt
         cER+MXVGxD7JZw3Qio4VYvtIzYftDY+EcjSI92qqy9YhMBvvs7HRWCMWChY145GDyU
         k0/NDYyCi6T2A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Howells <dhowells@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] samples: disable CONFIG_SAMPLES for UML
Date:   Tue, 18 Sep 2018 12:58:33 +0900
Message-Id: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some samples require headers installation, so commit 3fca1700c4c3
("kbuild: make samples really depend on headers_install") added
such dependency in the top Makefile.  However, UML fails to build
with CONFIG_SAMPLES=y because UML does not support headers_install.

Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
Reported-by: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index bd133ef..ad1ec701 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -1,5 +1,6 @@
 menuconfig SAMPLES
 	bool "Sample kernel code"
+	depends on !UML
 	help
 	  You can build and test sample kernel code here.
 
-- 
2.7.4

