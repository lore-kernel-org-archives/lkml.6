Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3778620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1srvT4mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeGTIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:34:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28450 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeGTIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:34:58 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdix008048;
        Fri, 20 Jul 2018 16:46:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdix008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072804;
        bh=96arycp4z8LOgD9Xj6LUTt+Z6oY7DhyU5UyNBMuQ0w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1srvT4mZkHbAn2ue+MaX0Ocz4P4BnmHNtrG8Y8UkCWfQCdbLPP/j0JiA+wENfnsON
         BzVhGAJY98pcw2l9RBVpvNJD2lgQBSaBqsGC3OdlCtpjq0X+J/CeLvLrjV2+6HvhSa
         C38N9YBRD+cbKmFKtJsTh6ZuPbmx6Z7LLT4xo58717WOMf1PtZdB/vxTlehqe0Upya
         3r42jGvgUONf3AayBLT8uBlrxRpxmLIj1Qh0X4qEja7AP3kcgSCzNeEyMHEyQ2icKw
         zHrNXuvscVwbNmv5Cy4XPkSZ37/jwbfrUKL5hZhfnqdkFxOJiZgXJv7NpY4MgtbCDI
         2CvhGlQAlQrGQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] kbuild: use 'include' directive to load auto.conf from top Makefile
Date:   Fri, 20 Jul 2018 16:46:32 +0900
Message-Id: <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you build targets that require the kernel configuration, dot-config
is set to 1, then the top-level Makefile includes auto.conf.  However,
Make considers its inclusion is optional because the '-include' directive
is used here.

If a necessary configuration file is missing for the external module
building, the following error message is displayed:

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

However, Make still continues building; /bin/false let the creation of
'include/config/auto.config' fail, but Make can ignore the error since
it is included by the '-include' directive.

I guess the reason of using '-include' directive was to suppress
the warning when you build the kernel from a pristine source tree:

  Makefile:605: include/config/auto.conf: No such file or directory

The previous commit made sure include/config/auto.conf exists after
the 'make *config' stage.  Now, we can use the 'include' directive
without showing the warning.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5c8e9a3..2fa9830 100644
--- a/Makefile
+++ b/Makefile
@@ -585,7 +585,7 @@ virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
--include include/config/auto.conf
+include include/config/auto.conf
 endif
 
 # The all: target is the default when no target is given on the
-- 
2.7.4

