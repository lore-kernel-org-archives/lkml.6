Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB8DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D1214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3D1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeIRCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:10:51 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:3695 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeIRCKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:10:50 -0400
Received: from sed.home (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id EAF7E2003E3;
        Mon, 17 Sep 2018 22:41:30 +0200 (CEST)
From:   Cedric Roux <sed@free.fr>
To:     kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cedric Roux <sed@free.fr>
Subject: [PATCH] ARM: s3c24xx: fix usage of pr_info/pr_cont
Date:   Mon, 17 Sep 2018 22:43:50 +0200
Message-Id: <20180917204350.15192-1-sed@free.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the wrong usage of pr_info introduced by the
commit e728e4f20100 ("ARM: s3c24xx: formatting cleanup in
mach-mini2440.c").

Since the idea is to print on a single line, pr_cont has to be used.

Signed-off-by: Cedric Roux <sed@free.fr>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 9f830abe701c..50d67d760efd 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -684,14 +684,14 @@ static void __init mini2440_init(void)
 		pr_info("MINI2440: LCD");
 		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
 			if (li == features.lcd_index)
-				pr_info(" [%d:%dx%d]", li,
+				pr_cont(" [%d:%dx%d]", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
 			else
-				pr_info(" %d:%dx%d", li,
+				pr_cont(" %d:%dx%d", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
-		pr_info("\n");
+		pr_cont("\n");
 		s3c24xx_fb_set_platdata(&mini2440_fb_info);
 	}
 
-- 
2.18.0

Note: running: scripts/checkpatch.pl 000*
reports 3 warnings about the use of pr_cont.
Since this modification was required by Joe Perches, I think this patch
doest the correct thing.
