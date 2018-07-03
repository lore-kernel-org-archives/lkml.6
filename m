Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D095C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D089A23F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D089A23F0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGCWBN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:01:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53109 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932895AbeGCWBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 894A52091A; Wed,  4 Jul 2018 00:01:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1F1A620914;
        Wed,  4 Jul 2018 00:01:05 +0200 (CEST)
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
Subject: [PATCH v2 17/32] mtd: rawnand: nandsim: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:14 +0200
Message-Id: <20180703220029.19565-18-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/nandsim.c | 78 ++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index f8edacde49ab..fa9d1c05fc45 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2192,6 +2192,44 @@ static void ns_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 	return;
 }
 
+static int ns_attach_chip(struct nand_chip *chip)
+{
+	unsigned int eccsteps, eccbytes;
+
+	if (!bch)
+		return 0;
+
+	if (!mtd_nand_has_bch()) {
+		NS_ERR("BCH ECC support is disabled\n");
+		return -EINVAL;
+	}
+
+	/* Use 512-byte ecc blocks */
+	eccsteps = nsmtd->writesize / 512;
+	eccbytes = ((bch * 13) + 7) / 8;
+
+	/* Do not bother supporting small page devices */
+	if (nsmtd->oobsize < 64 || !eccsteps) {
+		NS_ERR("BCH not available on small page devices\n");
+		return -EINVAL;
+	}
+
+	if (((eccbytes * eccsteps) + 2) > nsmtd->oobsize) {
+		NS_ERR("Invalid BCH value %u\n", bch);
+		return -EINVAL;
+	}
+
+	chip->ecc.mode = NAND_ECC_SOFT;
+	chip->ecc.algo = NAND_ECC_BCH;
+	chip->ecc.size = 512;
+	chip->ecc.strength = bch;
+	chip->ecc.bytes = eccbytes;
+
+	NS_INFO("Using %u-bit/%u bytes BCH ECC\n", bch, chip->ecc.size);
+
+	return 0;
+}
+
 /*
  * Module initialization function
  */
@@ -2276,44 +2314,10 @@ static int __init ns_init_module(void)
 	if ((retval = parse_gravepages()) != 0)
 		goto error;
 
-	retval = nand_scan_ident(nsmtd, 1, NULL);
+	chip->hwcontrol.attach_chip = ns_attach_chip;
+	retval = nand_scan(nsmtd, 1);
 	if (retval) {
-		NS_ERR("cannot scan NAND Simulator device\n");
-		goto error;
-	}
-
-	if (bch) {
-		unsigned int eccsteps, eccbytes;
-		if (!mtd_nand_has_bch()) {
-			NS_ERR("BCH ECC support is disabled\n");
-			retval = -EINVAL;
-			goto error;
-		}
-		/* use 512-byte ecc blocks */
-		eccsteps = nsmtd->writesize/512;
-		eccbytes = (bch*13+7)/8;
-		/* do not bother supporting small page devices */
-		if ((nsmtd->oobsize < 64) || !eccsteps) {
-			NS_ERR("bch not available on small page devices\n");
-			retval = -EINVAL;
-			goto error;
-		}
-		if ((eccbytes*eccsteps+2) > nsmtd->oobsize) {
-			NS_ERR("invalid bch value %u\n", bch);
-			retval = -EINVAL;
-			goto error;
-		}
-		chip->ecc.mode = NAND_ECC_SOFT;
-		chip->ecc.algo = NAND_ECC_BCH;
-		chip->ecc.size = 512;
-		chip->ecc.strength = bch;
-		chip->ecc.bytes = eccbytes;
-		NS_INFO("using %u-bit/%u bytes BCH ECC\n", bch, chip->ecc.size);
-	}
-
-	retval = nand_scan_tail(nsmtd);
-	if (retval) {
-		NS_ERR("can't register NAND Simulator\n");
+		NS_ERR("Could not scan NAND Simulator device\n");
 		goto error;
 	}
 
-- 
2.14.1

