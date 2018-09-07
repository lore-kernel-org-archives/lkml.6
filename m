Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A81206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A81206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeIHCgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:36:04 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54471 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeIHCgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:36:03 -0400
Received: from sed.home (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 276922003C6;
        Fri,  7 Sep 2018 23:52:50 +0200 (CEST)
From:   Cedric Roux <sed@free.fr>
To:     kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cedric Roux <sed@free.fr>
Subject: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect detection on Mini2440
Date:   Fri,  7 Sep 2018 23:54:46 +0200
Message-Id: <20180907215446.15160-2-sed@free.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907215446.15160-1-sed@free.fr>
References: <20180907215446.15160-1-sed@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mini2440 computer uses "active high" to signal that the "write protect"
of the inserted MMC is set. The current code uses the opposite, leading to
a wrong detection of write protection. The solution is simply to use
".wprotect_invert = 1" in the description of the MMC.

Signed-off-by: Cedric Roux <sed@free.fr>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 4a0bf6abba8c..bfce7971d741 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -234,10 +234,11 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 /* MMC/SD  */
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
-	.gpio_detect   = S3C2410_GPG(8),
-	.gpio_wprotect = S3C2410_GPH(8),
-	.set_power     = NULL,
-	.ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_detect     = S3C2410_GPG(8),
+	.gpio_wprotect   = S3C2410_GPH(8),
+	.wprotect_invert = 1,
+	.set_power       = NULL,
+	.ocr_avail       = MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
 /* NAND Flash on MINI2440 board */
-- 
2.18.0

