Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B75C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5D20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GB6nkJcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB5D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLGLev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:51 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45837 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLGLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6rf020070;
        Fri, 7 Dec 2018 20:34:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6rf020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182449;
        bh=Szx3G+D9Ykc5wPocxiIgpOefJMSBr6XaryNtZw8+QQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GB6nkJcx+bKVbVtbEiXhg7Q1FTdzhiVCCRyVG9ph8DQTwA30gQ1vMKu5WKLl9kw4r
         qiXDSsKa8mSRwVyZZsSe5nzct++yyKU81jvS4EzMB2HqkBRS49pOhFd+fx6/pD3CPg
         5CW2AMOgQB7cwlrJjtQzna5tgjF3uI7H2foAPtYqtE5R4HXV3tQgrrgNII+7jXQkAe
         /ZsuaRJc1mXAPO+aShCCGUIfi1SF0PowH8IFGnrssa8sUpVzt0SJ8SiP4+rLz5hvnH
         nJOZbNRtYlJCzo+jClDg3HGHA9QDzJzWXiJeQjaF3NX1EpBnKb6GZn4wxOKC710YBS
         4J+PqW3A8jTpg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] microblaze: add linux.bin* and simpleImage.* to PHONY
Date:   Fri,  7 Dec 2018 20:33:55 +0900
Message-Id: <1544182437-26660-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux.bin, linux.bin.gz, and linux.bin.ub are phony targets to
generate a corresponding image under arch/microblaze/boot/.

simpleImage.% also works like a phony target, but a pattern that
contains '%' cannot be a phony target. I replaced it with equivalent
simpleImage.$(DTB).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/microblaze/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index ff5abbd..180dffa 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -82,11 +82,13 @@ archclean:
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
 
+PHONY += linux.bin linux.bin.gz linux.bin.ub
 linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-simpleImage.%: vmlinux
+PHONY += simpleImage.$(DTB)
+simpleImage.$(DTB): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(addprefix $(boot)/$@., ub unstrip strip)
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-- 
2.7.4

