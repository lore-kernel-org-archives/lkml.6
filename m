Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB420855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFB420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeGCWEy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:04:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53093 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932355AbeGCWBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1FF3120922; Wed,  4 Jul 2018 00:01:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id A7C0A208FF;
        Wed,  4 Jul 2018 00:01:03 +0200 (CEST)
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
Subject: [PATCH v2 16/32] mtd: rawnand: mxc: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:13 +0200
Message-Id: <20180703220029.19565-17-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/mxc_nand.c | 132 ++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 90cfb5e730aa..3c0451433247 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1706,6 +1706,70 @@ static int mxcnd_probe_dt(struct mxc_nand_host *host)
 }
 #endif
 
+static int mxcnd_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	struct device *dev = mtd->dev.parent;
+
+	switch (chip->ecc.mode) {
+	case NAND_ECC_HW:
+		chip->ecc.read_page = mxc_nand_read_page;
+		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
+		chip->ecc.read_oob = mxc_nand_read_oob;
+		chip->ecc.write_page = mxc_nand_write_page_ecc;
+		chip->ecc.write_page_raw = mxc_nand_write_page_raw;
+		chip->ecc.write_oob = mxc_nand_write_oob;
+		break;
+
+	case NAND_ECC_SOFT:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	}
+
+	/* Allocate the right size buffer now */
+	devm_kfree(dev, (void *)host->data_buf);
+	host->data_buf = devm_kzalloc(dev, mtd->writesize + mtd->oobsize,
+				      GFP_KERNEL);
+	if (!host->data_buf)
+		return -ENOMEM;
+
+	/* Call preset again, with correct writesize chip time */
+	host->devtype_data->preset(mtd);
+
+	if (!chip->ecc.bytes) {
+		if (host->eccsize == 8)
+			chip->ecc.bytes = 18;
+		else if (host->eccsize == 4)
+			chip->ecc.bytes = 9;
+	}
+
+	/*
+	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
+	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
+	 * into copying invalid data to/from the spare IO buffer, as this
+	 * might cause ECC data corruption when doing sub-page write to a
+	 * partially written page.
+	 */
+	host->used_oobsize = min(mtd->oobsize, 218U);
+
+	if (chip->ecc.mode == NAND_ECC_HW) {
+		if (is_imx21_nfc(host) || is_imx27_nfc(host))
+			chip->ecc.strength = 1;
+		else
+			chip->ecc.strength = (host->eccsize == 4) ? 4 : 8;
+	}
+
+	return 0;
+}
+
 static int mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
@@ -1845,71 +1909,9 @@ static int mxcnd_probe(struct platform_device *pdev)
 		host->devtype_data->irq_control(host, 1);
 	}
 
-	/* first scan to find the device and get the page size */
-	err = nand_scan_ident(mtd, is_imx25_nfc(host) ? 4 : 1, NULL);
-	if (err)
-		goto escan;
-
-	switch (this->ecc.mode) {
-	case NAND_ECC_HW:
-		this->ecc.read_page = mxc_nand_read_page;
-		this->ecc.read_page_raw = mxc_nand_read_page_raw;
-		this->ecc.read_oob = mxc_nand_read_oob;
-		this->ecc.write_page = mxc_nand_write_page_ecc;
-		this->ecc.write_page_raw = mxc_nand_write_page_raw;
-		this->ecc.write_oob = mxc_nand_write_oob;
-		break;
-
-	case NAND_ECC_SOFT:
-		break;
-
-	default:
-		err = -EINVAL;
-		goto escan;
-	}
-
-	if (this->bbt_options & NAND_BBT_USE_FLASH) {
-		this->bbt_td = &bbt_main_descr;
-		this->bbt_md = &bbt_mirror_descr;
-	}
-
-	/* allocate the right size buffer now */
-	devm_kfree(&pdev->dev, (void *)host->data_buf);
-	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
-					GFP_KERNEL);
-	if (!host->data_buf) {
-		err = -ENOMEM;
-		goto escan;
-	}
-
-	/* Call preset again, with correct writesize this time */
-	host->devtype_data->preset(mtd);
-
-	if (!this->ecc.bytes) {
-		if (host->eccsize == 8)
-			this->ecc.bytes = 18;
-		else if (host->eccsize == 4)
-			this->ecc.bytes = 9;
-	}
-
-	/*
-	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
-	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
-	 * into copying invalid data to/from the spare IO buffer, as this
-	 * might cause ECC data corruption when doing sub-page write to a
-	 * partially written page.
-	 */
-	host->used_oobsize = min(mtd->oobsize, 218U);
-
-	if (this->ecc.mode == NAND_ECC_HW) {
-		if (is_imx21_nfc(host) || is_imx27_nfc(host))
-			this->ecc.strength = 1;
-		else
-			this->ecc.strength = (host->eccsize == 4) ? 4 : 8;
-	}
-
-	/* second phase scan */
-	err = nand_scan_tail(mtd);
+	/* Scan the NAND device */
+	this->hwcontrol.attach_chip = mxcnd_attach_chip;
+	err = nand_scan(mtd, is_imx25_nfc(host) ? 4 : 1);
 	if (err)
 		goto escan;
 
-- 
2.14.1

