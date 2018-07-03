Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017C4223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017C4223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeGCWBT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:01:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53186 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933034AbeGCWBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F9B2208C5; Wed,  4 Jul 2018 00:01:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id DEE0A20933;
        Wed,  4 Jul 2018 00:01:10 +0200 (CEST)
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
Subject: [PATCH v2 21/32] mtd: rawnand: sh_flctl: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:18 +0200
Message-Id: <20180703220029.19565-22-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/sh_flctl.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index d37d1d3ccbf9..959eb6f5f269 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1002,10 +1002,10 @@ static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	flctl->index += len;
 }
 
-static int flctl_chip_init_tail(struct mtd_info *mtd)
+static int flctl_chip_attach_chip(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	struct nand_chip *chip = &flctl->chip;
 
 	if (chip->options & NAND_BUSWIDTH_16) {
 		/*
@@ -1200,15 +1200,8 @@ static int flctl_probe(struct platform_device *pdev)
 
 	flctl_setup_dma(flctl);
 
-	ret = nand_scan_ident(flctl_mtd, 1, NULL);
-	if (ret)
-		goto err_chip;
-
-	ret = flctl_chip_init_tail(flctl_mtd);
-	if (ret)
-		goto err_chip;
-
-	ret = nand_scan_tail(flctl_mtd);
+	nand->hwcontrol.attach_chip = flctl_chip_attach_chip;
+	ret = nand_scan(flctl_mtd, 1);
 	if (ret)
 		goto err_chip;
 
-- 
2.14.1

