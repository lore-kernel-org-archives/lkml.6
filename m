Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B7C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02E2178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="V9FF756B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F02E2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHDGsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:48:21 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64016 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDGsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:48:21 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w744lBUf027764;
        Sat, 4 Aug 2018 13:47:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w744lBUf027764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533358034;
        bh=EOr7rpI7mBIILrjEfuomV4TnJoO7PrJzo1tHh6RbeO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9FF756BymP/4UZTTOm9fdpPDY+4lOe0SWfWl1jxVSmQ7VywhxZQfYKuw2/Z5pn17
         8R2SFpZYKByKncf5jKHOHipRsKqAXKL8Qp1dJljJi5FIkGomLURWyPrnoq8vwlw0b6
         xwFdcqLtpnc2ISsHxIZcuAL2IwkPstjUwvOEdLYt4JE8+k3rYXhgcSBHeAyXAUDqRd
         lZaTD/dvUuXbSczm8i4XbKUCsoR6SOD4hCVei0/Nrg0BgBmU7A/D5F4gfNOH1mWXEo
         4g8uyJEeFWByCWd2hZuUmNYimnWqjFKDm1Er0iTn8QRksuBnBSbAXGmL1Bi+UkEwsj
         yUGYl0RR9+NRw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: add %asm-generic to no-dot-config-targets
Date:   Sat,  4 Aug 2018 13:47:02 +0900
Message-Id: <1533358023-5801-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic and uapi-asm-generic do not depend on the kernel
configuration.  In fact, uapi-asm-generic is the prerequisite of
headers_{install,check}, hence it should not require the .config file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 85f3481..5cf87a18 100644
--- a/Makefile
+++ b/Makefile
@@ -224,7 +224,7 @@ clean-targets := %clean mrproper cleandocs
 no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
-			 kernelversion %src-pkg
+			 %asm-generic kernelversion %src-pkg
 
 config-targets := 0
 mixed-targets  := 0
-- 
2.7.4

