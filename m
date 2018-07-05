Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BCC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1647E241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hd7P61ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1647E241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeGECly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:54 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:44279 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeGEClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:49 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZg028145;
        Thu, 5 Jul 2018 11:40:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZg028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758405;
        bh=u6aifoU1n3Vl9zZKiS9dT41GFAXNW8O//Adc4m1xEjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd7P61kobhNx3enoEetYVWe1VR8R/gofF1UMBHjniW0rKUhG6eNf1194GlU9gqC1u
         NjcwQbiDomrOJeWbYg08aX3wxHEb8hHaiub//p7e6+OypYrQcV0FjUDhd1wdXj7QCd
         IUL0wl557nmM1mD38wVjhz37SYvXKjORJPVXHYdQ2kkYEnue1hb9rJ7tazxBVJ3Bna
         W7RnROCKqb6iGMAX9fQSU1tYWXx7k4KoQrI8lh3wNSv3U4GYBorKq+EVCol0Am6QA/
         DBqgFKgiDow61XbjlWlkpEd9GSaohAo07Re47nXbFGOQeOzWTeKUpEM63nkVFYrjxY
         ovxPyEUycbFUA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] kbuild: do not update config for 'make kernelrelease'
Date:   Thu,  5 Jul 2018 11:39:47 +0900
Message-Id: <1530758389-30862-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kernelrelease' depends on CONFIG_LOCALVERSION(_AUTO), but
for the same reason as install targets, we do not want to update
the configuration just for printing the kernelrelease string.

This is likely to happen when you compiled the kernel with
CROSS_COMPILE, but forget to pass it to 'make kernelrelease'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f0663c8..c258937 100644
--- a/Makefile
+++ b/Makefile
@@ -225,7 +225,8 @@ no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
-no-sync-config-targets := $(no-dot-config-targets) install %install
+no-sync-config-targets := $(no-dot-config-targets) install %install \
+			   kernelrelease
 
 config-targets  := 0
 mixed-targets   := 0
-- 
2.7.4

