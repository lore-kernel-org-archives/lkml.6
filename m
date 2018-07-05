Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA768C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ABE241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eIQFIIzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ABE241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeGEClt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:49 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:44108 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeGECln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZZ028145;
        Thu, 5 Jul 2018 11:39:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZZ028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758399;
        bh=qnJerOZw7y4UM2FcEumXP19Vq4DDaKyhKEblMJs0Uc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIQFIIzub8sBVxl97eY3wE3j8nXFDpgJc+FcjSb2AGm+QrJmA66kxeG/00MPUKx0W
         G/7i6veCp/4ZpT0GzicTlfhAoN36RSR4kbtWq3WZv7xGTMtUb6jR/PNVg45x9mXOYM
         MJ2T/2W5ifHukZsTCKx7M9Mf78s1PPKlcnHN2Mx5KaxOYWwJWKyEBPZe1bncWyiq7o
         tPIpOFGlt5WiLMSGfrxwJkqqLg5Yj54fmZhORTTB+HRFlOQI09KLl89FRT1WJDL13Q
         R/kR17sa4zv7eQCBX7kKXAX457ds6dkXAntzsV2PCzaMjHEA1YAx8z0ZsQJaIrlAHH
         6MVITETrCNcfw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] kconfig: remove unneeded directory generation from local*config
Date:   Thu,  5 Jul 2018 11:39:40 +0900
Message-Id: <1530758389-30862-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 17263baf958b ("kconfig: Create include/generated for
localmodconfig") added the 'mkdir' line because local{yes,mod}config
ran streamline_config.pl followed by silentoldconfig at that time.

Since commit 81d2bc227305 ("kconfig: invoke oldconfig instead of
silentoldconfig from local*config"), no sub-directory is required.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index a3ac2c9..c9e8cf5 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -41,7 +41,6 @@ syncconfig: $(obj)/conf
 	$< $(silent) --$@ $(Kconfig)
 
 localyesconfig localmodconfig: $(obj)/conf
-	$(Q)mkdir -p include/config include/generated
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 					\
 			cmp -s .tmp.config .config ||			\
-- 
2.7.4

