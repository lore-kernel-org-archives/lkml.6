Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EAA204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EAA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbeGTQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:06:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbeGTQEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EFF7C2097A; Fri, 20 Jul 2018 17:15:59 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31A51207B4;
        Fri, 20 Jul 2018 17:15:41 +0200 (CEST)
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
Subject: [PATCH v4 22/35] mtd: rawnand: tango: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 17:15:14 +0200
Message-Id: <20180720151527.16038-23-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/tango_nand.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index dd7a26efdf4f..a448d0797cd5 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -517,6 +517,28 @@ static int tango_set_timings(struct mtd_info *mtd, int csline,
 	return 0;
 }
 
+static int tango_attach_chip(struct nand_chip *chip)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	ecc->mode = NAND_ECC_HW;
+	ecc->algo = NAND_ECC_BCH;
+	ecc->bytes = DIV_ROUND_UP(ecc->strength * FIELD_ORDER, BITS_PER_BYTE);
+
+	ecc->read_page_raw = tango_read_page_raw;
+	ecc->write_page_raw = tango_write_page_raw;
+	ecc->read_page = tango_read_page;
+	ecc->write_page = tango_write_page;
+	ecc->read_oob = tango_read_oob;
+	ecc->write_oob = tango_write_oob;
+
+	return 0;
+}
+
+static const struct nand_controller_ops tango_controller_ops = {
+	.attach_chip = tango_attach_chip,
+};
+
 static int chip_init(struct device *dev, struct device_node *np)
 {
 	u32 cs;
@@ -560,28 +582,14 @@ static int chip_init(struct device *dev, struct device_node *np)
 			NAND_NO_SUBPAGE_WRITE |
 			NAND_WAIT_TCCS;
 	chip->controller = &nfc->hw;
+	chip->controller->ops = &tango_controller_ops;
 	tchip->base = nfc->pbus_base + (cs * 256);
 
 	nand_set_flash_node(chip, np);
 	mtd_set_ooblayout(mtd, &tango_nand_ooblayout_ops);
 	mtd->dev.parent = dev;
 
-	err = nand_scan_ident(mtd, 1, NULL);
-	if (err)
-		return err;
-
-	ecc->mode = NAND_ECC_HW;
-	ecc->algo = NAND_ECC_BCH;
-	ecc->bytes = DIV_ROUND_UP(ecc->strength * FIELD_ORDER, BITS_PER_BYTE);
-
-	ecc->read_page_raw = tango_read_page_raw;
-	ecc->write_page_raw = tango_write_page_raw;
-	ecc->read_page = tango_read_page;
-	ecc->write_page = tango_write_page;
-	ecc->read_oob = tango_read_oob;
-	ecc->write_oob = tango_write_oob;
-
-	err = nand_scan_tail(mtd);
+	err = nand_scan(mtd, 1);
 	if (err)
 		return err;
 
-- 
2.14.1

