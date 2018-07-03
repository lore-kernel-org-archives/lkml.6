Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D479B20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D479B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGCWEf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:04:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53146 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932960AbeGCWBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 75FD720935; Wed,  4 Jul 2018 00:01:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0532220930;
        Wed,  4 Jul 2018 00:01:07 +0200 (CEST)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 19/32] mtd: rawnand: s3c2410: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:16 +0200
Message-Id: <20180703220029.19565-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/s3c2410.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 19661c5d3220..d656ea3a9ffe 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -915,20 +915,19 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 }
 
 /**
- * s3c2410_nand_update_chip - post probe update
- * @info: The controller instance.
- * @nmtd: The driver version of the MTD instance.
+ * s3c2410_nand_attach_chip - Init the ECC engine after NAND scan
+ * @chip: The NAND chip
  *
- * This routine is called after the chip probe has successfully completed
- * and the relevant per-chip information updated. This call ensure that
+ * This hook is called by the core after the identification of the NAND chip,
+ * once the relevant per-chip information is up to date.. This call ensure that
  * we update the internal state accordingly.
  *
  * The internal state is currently limited to the ECC state information.
 */
-static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
-				    struct s3c2410_nand_mtd *nmtd)
+static int s3c2410_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nmtd->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	switch (chip->ecc.mode) {
 
@@ -1161,15 +1160,8 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		err = nand_scan_ident(mtd, (sets) ? sets->nr_chips : 1, NULL);
-		if (err)
-			goto exit_error;
-
-		err = s3c2410_nand_update_chip(info, nmtd);
-		if (err < 0)
-			goto exit_error;
-
-		err = nand_scan_tail(mtd);
+		nmtd->chip.controller->attach_chip = s3c2410_nand_attach_chip;
+		err = nand_scan(mtd, sets ? sets->nr_chips : 1);
 		if (err)
 			goto exit_error;
 
-- 
2.14.1

