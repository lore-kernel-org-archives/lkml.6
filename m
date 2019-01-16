Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5EBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbfAPGOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:14:36 -0500
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:43348 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfAPGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:14:35 -0500
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 01:14:34 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id x0G5qUpe014388; Wed, 16 Jan 2019 14:52:30 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id x0G5pTvj011528; Wed, 16 Jan 2019 14:51:30 +0900
X-Iguazu-Qid: 34tKHS48TsYsTHngOX
X-Iguazu-QSIG: v=2; s=0; t=1547617889; q=34tKHS48TsYsTHngOX; m=J6YwhIuYWFJ/V/M/bgmPeDrialCVb3bpbgqylT4MdVw=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id x0G5pMX3003462;
        Wed, 16 Jan 2019 14:51:22 +0900
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by imx12.toshiba.co.jp  with ESMTP id x0G5pLfY014709;
        Wed, 16 Jan 2019 14:51:21 +0900 (JST)
From:   Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
To:     bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, frieder.schrempf@kontron.De,
        peron.clem@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, tmcmc-mb-yfuruyama7@ml.toshiba.co.jp
Subject: [PATCH] mtd: spinand: Add support for all Toshiba Memory products
Date:   Wed, 16 Jan 2019 14:53:19 +0900
X-TSB-HOP: ON
Message-Id: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device table for Toshiba Memory products.
Also, generalize OOB layout structure and function names.

Signed-off-by: Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>

---
 drivers/mtd/nand/spi/toshiba.c |   79 +++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 0812655..0916962 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -25,19 +25,19 @@ static SPINAND_OP_VARIANTS(write_cache_variants,
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
+static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
 				     struct mtd_oob_region *region)
 {
-	if (section > 7)
+	if (section > 0)
 		return -ERANGE;
 
-	region->offset = 128 + 16 * section;
-	region->length = 16;
+	region->offset = mtd->oobsize / 2;
+	region->length = mtd->oobsize / 2;
 
 	return 0;
 }
 
-static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
+static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
 				      struct mtd_oob_region *region)
 {
 	if (section > 0)
@@ -45,17 +45,17 @@ static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
 
 	/* 2 bytes reserved for BBM */
 	region->offset = 2;
-	region->length = 126;
+	region->length = mtd->oobsize / 2 - 2;
 
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops tc58cvg2s0h_ooblayout = {
-	.ecc = tc58cvg2s0h_ooblayout_ecc,
-	.free = tc58cvg2s0h_ooblayout_free,
+static const struct mtd_ooblayout_ops tc58cxgxsx_ooblayout = {
+	.ecc = tc58cxgxsx_ooblayout_ecc,
+	.free = tc58cxgxsx_ooblayout_free,
 };
 
-static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
+static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
 				      u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -94,15 +94,66 @@ static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info toshiba_spinand_table[] = {
-	SPINAND_INFO("TC58CVG2S0H", 0xCD,
+	/* 3.3V 1Gb */
+	SPINAND_INFO("TC58CVG0S3", 0xC2,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
+	/* 3.3V 2Gb */
+	SPINAND_INFO("TC58CVG1S3", 0xCB,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
+	/* 3.3V 4Gb */
+	SPINAND_INFO("TC58CVG2S0", 0xCD,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
+	/* 1.8V 1Gb */
+	SPINAND_INFO("TC58CYG0S3", 0xB2,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
+	/* 1.8V 2Gb */
+	SPINAND_INFO("TC58CYG1S3", 0xBB,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
+	/* 1.8V 4Gb */
+	SPINAND_INFO("TC58CYG2S0", 0xBD,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&tc58cvg2s0h_ooblayout,
-				     tc58cvg2s0h_ecc_get_status)),
+		     0,
+		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
+				     tc58cxgxsx_ecc_get_status)),
 };
 
 static int toshiba_spinand_detect(struct spinand_device *spinand)
-- 
1.7.9.5

