Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A9720869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A9720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeKLFsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49290 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729554AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000lF-SA; Sun, 11 Nov 2018 19:58:32 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001Mt-Md; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.66576390@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 011/366] Revert "mtd: nand: omap2: Fix subpage write"
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

This reverts commit e7e13fa736726e9860a86e5e1ae19ce162e11b71, which
was commit 739c64414f01748a36e7d82c8e0611dea94412bd upstream.  It
doesn't appear to fix a real bug in 3.16, and it results in build
breakage and/or compiler warnings depending on the kernel
configuration.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/nand/omap2.c | 340 +++++++++++++--------------------------
 1 file changed, 115 insertions(+), 225 deletions(-)

--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1163,174 +1163,130 @@ static u8  bch8_polynomial[] = {0xef, 0x
 				0x97, 0x79, 0xe5, 0x24, 0xb5};
 
 /**
- * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
+ * omap_calculate_ecc_bch - Generate bytes of ECC bytes
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
  * @ecc_code:	The ecc_code buffer
- * @i:		The sector number (for a multi sector page)
  *
- * Support calculating of BCH4/8/16 ECC vectors for one sector
- * within a page. Sector number is in @i.
+ * Support calculating of BCH4/8 ecc vectors for the page
  */
-static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
-				   const u_char *dat, u_char *ecc_calc, int i)
+static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
+					const u_char *dat, u_char *ecc_calc)
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
 	int eccbytes	= info->nand.ecc.bytes;
 	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
 	u8 *ecc_code;
-	unsigned long bch_val1, bch_val2, bch_val3, bch_val4;
+	unsigned long nsectors, bch_val1, bch_val2, bch_val3, bch_val4;
 	u32 val;
-	int j;
-
-	ecc_code = ecc_calc;
-	switch (info->ecc_opt) {
-	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-	case OMAP_ECC_BCH8_CODE_HW:
-		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
-		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
-		bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
-		bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
-		*ecc_code++ = (bch_val4 & 0xFF);
-		*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
-		*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
-		*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
-		*ecc_code++ = (bch_val3 & 0xFF);
-		*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
-		*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
-		*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
-		*ecc_code++ = (bch_val2 & 0xFF);
-		*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
-		*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
-		*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
-		*ecc_code++ = (bch_val1 & 0xFF);
-		break;
-	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-	case OMAP_ECC_BCH4_CODE_HW:
-		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
-		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
-		*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
-		*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
-		*ecc_code++ = ((bch_val2 & 0xF) << 4) |
-			((bch_val1 >> 28) & 0xF);
-		*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
-		*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
-		*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
-		*ecc_code++ = ((bch_val1 & 0xF) << 4);
-		break;
-	case OMAP_ECC_BCH16_CODE_HW:
-		val = readl(gpmc_regs->gpmc_bch_result6[i]);
-		ecc_code[0]  = ((val >>  8) & 0xFF);
-		ecc_code[1]  = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result5[i]);
-		ecc_code[2]  = ((val >> 24) & 0xFF);
-		ecc_code[3]  = ((val >> 16) & 0xFF);
-		ecc_code[4]  = ((val >>  8) & 0xFF);
-		ecc_code[5]  = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result4[i]);
-		ecc_code[6]  = ((val >> 24) & 0xFF);
-		ecc_code[7]  = ((val >> 16) & 0xFF);
-		ecc_code[8]  = ((val >>  8) & 0xFF);
-		ecc_code[9]  = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result3[i]);
-		ecc_code[10] = ((val >> 24) & 0xFF);
-		ecc_code[11] = ((val >> 16) & 0xFF);
-		ecc_code[12] = ((val >>  8) & 0xFF);
-		ecc_code[13] = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result2[i]);
-		ecc_code[14] = ((val >> 24) & 0xFF);
-		ecc_code[15] = ((val >> 16) & 0xFF);
-		ecc_code[16] = ((val >>  8) & 0xFF);
-		ecc_code[17] = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result1[i]);
-		ecc_code[18] = ((val >> 24) & 0xFF);
-		ecc_code[19] = ((val >> 16) & 0xFF);
-		ecc_code[20] = ((val >>  8) & 0xFF);
-		ecc_code[21] = ((val >>  0) & 0xFF);
-		val = readl(gpmc_regs->gpmc_bch_result0[i]);
-		ecc_code[22] = ((val >> 24) & 0xFF);
-		ecc_code[23] = ((val >> 16) & 0xFF);
-		ecc_code[24] = ((val >>  8) & 0xFF);
-		ecc_code[25] = ((val >>  0) & 0xFF);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* ECC scheme specific syndrome customizations */
-	switch (info->ecc_opt) {
-	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-		/* Add constant polynomial to remainder, so that
-		 * ECC of blank pages results in 0x0 on reading back
-		 */
-		for (j = 0; j < eccbytes; j++)
-			ecc_calc[j] ^= bch4_polynomial[j];
-		break;
-	case OMAP_ECC_BCH4_CODE_HW:
-		/* Set  8th ECC byte as 0x0 for ROM compatibility */
-		ecc_calc[eccbytes - 1] = 0x0;
-		break;
-	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-		/* Add constant polynomial to remainder, so that
-		 * ECC of blank pages results in 0x0 on reading back
-		 */
-		for (j = 0; j < eccbytes; j++)
-			ecc_calc[j] ^= bch8_polynomial[j];
-		break;
-	case OMAP_ECC_BCH8_CODE_HW:
-		/* Set 14th ECC byte as 0x0 for ROM compatibility */
-		ecc_calc[eccbytes - 1] = 0x0;
-		break;
-	case OMAP_ECC_BCH16_CODE_HW:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
- * @mtd:	MTD device structure
- * @dat:	The pointer to data on which ecc is computed
- * @ecc_code:	The ecc_code buffer
- *
- * Support calculating of BCH4/8/16 ECC vectors for one sector. This is used
- * when SW based correction is required as ECC is required for one sector
- * at a time.
- */
-static int omap_calculate_ecc_bch_sw(struct mtd_info *mtd,
-				     const u_char *dat, u_char *ecc_calc)
-{
-	return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
-}
-
-/**
- * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
- * @mtd:	MTD device structure
- * @dat:	The pointer to data on which ecc is computed
- * @ecc_code:	The ecc_code buffer
- *
- * Support calculating of BCH4/8/16 ecc vectors for the entire page in one go.
- */
-static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
-					const u_char *dat, u_char *ecc_calc)
-{
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-	int eccbytes = info->nand.ecc.bytes;
-	unsigned long nsectors;
-	int i, ret;
+	int i, j;
 
 	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
 	for (i = 0; i < nsectors; i++) {
-		ret = _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
-		if (ret)
-			return ret;
+		ecc_code = ecc_calc;
+		switch (info->ecc_opt) {
+		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		case OMAP_ECC_BCH8_CODE_HW:
+			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
+			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
+			bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
+			bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
+			*ecc_code++ = (bch_val4 & 0xFF);
+			*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
+			*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
+			*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
+			*ecc_code++ = (bch_val3 & 0xFF);
+			*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
+			*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
+			*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
+			*ecc_code++ = (bch_val2 & 0xFF);
+			*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
+			*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
+			*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
+			*ecc_code++ = (bch_val1 & 0xFF);
+			break;
+		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		case OMAP_ECC_BCH4_CODE_HW:
+			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
+			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
+			*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
+			*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
+			*ecc_code++ = ((bch_val2 & 0xF) << 4) |
+				((bch_val1 >> 28) & 0xF);
+			*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
+			*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
+			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
+			*ecc_code++ = ((bch_val1 & 0xF) << 4);
+			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			val = readl(gpmc_regs->gpmc_bch_result6[i]);
+			ecc_code[0]  = ((val >>  8) & 0xFF);
+			ecc_code[1]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result5[i]);
+			ecc_code[2]  = ((val >> 24) & 0xFF);
+			ecc_code[3]  = ((val >> 16) & 0xFF);
+			ecc_code[4]  = ((val >>  8) & 0xFF);
+			ecc_code[5]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result4[i]);
+			ecc_code[6]  = ((val >> 24) & 0xFF);
+			ecc_code[7]  = ((val >> 16) & 0xFF);
+			ecc_code[8]  = ((val >>  8) & 0xFF);
+			ecc_code[9]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result3[i]);
+			ecc_code[10] = ((val >> 24) & 0xFF);
+			ecc_code[11] = ((val >> 16) & 0xFF);
+			ecc_code[12] = ((val >>  8) & 0xFF);
+			ecc_code[13] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result2[i]);
+			ecc_code[14] = ((val >> 24) & 0xFF);
+			ecc_code[15] = ((val >> 16) & 0xFF);
+			ecc_code[16] = ((val >>  8) & 0xFF);
+			ecc_code[17] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result1[i]);
+			ecc_code[18] = ((val >> 24) & 0xFF);
+			ecc_code[19] = ((val >> 16) & 0xFF);
+			ecc_code[20] = ((val >>  8) & 0xFF);
+			ecc_code[21] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result0[i]);
+			ecc_code[22] = ((val >> 24) & 0xFF);
+			ecc_code[23] = ((val >> 16) & 0xFF);
+			ecc_code[24] = ((val >>  8) & 0xFF);
+			ecc_code[25] = ((val >>  0) & 0xFF);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* ECC scheme specific syndrome customizations */
+		switch (info->ecc_opt) {
+		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+			/* Add constant polynomial to remainder, so that
+			 * ECC of blank pages results in 0x0 on reading back */
+			for (j = 0; j < eccbytes; j++)
+				ecc_calc[j] ^= bch4_polynomial[j];
+			break;
+		case OMAP_ECC_BCH4_CODE_HW:
+			/* Set  8th ECC byte as 0x0 for ROM compatibility */
+			ecc_calc[eccbytes - 1] = 0x0;
+			break;
+		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+			/* Add constant polynomial to remainder, so that
+			 * ECC of blank pages results in 0x0 on reading back */
+			for (j = 0; j < eccbytes; j++)
+				ecc_calc[j] ^= bch8_polynomial[j];
+			break;
+		case OMAP_ECC_BCH8_CODE_HW:
+			/* Set 14th ECC byte as 0x0 for ROM compatibility */
+			ecc_calc[eccbytes - 1] = 0x0;
+			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			break;
+		default:
+			return -EINVAL;
+		}
 
-		ecc_calc += eccbytes;
+	ecc_calc += eccbytes;
 	}
 
 	return 0;
@@ -1571,7 +1527,7 @@ static int omap_write_page_bch(struct mt
 	chip->write_buf(mtd, buf, mtd->writesize);
 
 	/* Update ecc vector from GPMC result registers */
-	omap_calculate_ecc_bch_multi(mtd, buf, &ecc_calc[0]);
+	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
 
 	for (i = 0; i < chip->ecc.total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
@@ -1582,72 +1538,6 @@ static int omap_write_page_bch(struct mt
 }
 
 /**
- * omap_write_subpage_bch - BCH hardware ECC based subpage write
- * @mtd:	mtd info structure
- * @chip:	nand chip info structure
- * @offset:	column address of subpage within the page
- * @data_len:	data length
- * @buf:	data buffer
- * @oob_required: must write chip->oob_poi to OOB
- * @page: page number to write
- *
- * OMAP optimized subpage write method.
- */
-static int omap_write_subpage_bch(struct mtd_info *mtd,
-				  struct nand_chip *chip, u32 offset,
-				  u32 data_len, const u8 *buf,
-				  int oob_required, int page)
-{
-	u8 *ecc_calc = chip->buffers->ecccalc;
-	int ecc_size      = chip->ecc.size;
-	int ecc_bytes     = chip->ecc.bytes;
-	int ecc_steps     = chip->ecc.steps;
-	u32 start_step = offset / ecc_size;
-	u32 end_step   = (offset + data_len - 1) / ecc_size;
-	int step, ret = 0;
-
-	/*
-	 * Write entire page at one go as it would be optimal
-	 * as ECC is calculated by hardware.
-	 * ECC is calculated for all subpages but we choose
-	 * only what we want.
-	 */
-
-	/* Enable GPMC ECC engine */
-	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
-
-	/* Write data */
-	chip->write_buf(mtd, buf, mtd->writesize);
-
-	for (step = 0; step < ecc_steps; step++) {
-		/* mask ECC of un-touched subpages by padding 0xFF */
-		if (step < start_step || step > end_step)
-			memset(ecc_calc, 0xff, ecc_bytes);
-		else
-			ret = _omap_calculate_ecc_bch(mtd, buf, ecc_calc, step);
-
-		if (ret)
-			return ret;
-
-		buf += ecc_size;
-		ecc_calc += ecc_bytes;
-	}
-
-	/* copy calculated ECC for whole page to chip->buffer->oob */
-	/* this include masked-value(0xFF) for unwritten subpages */
-	ecc_calc = chip->buffers->ecccalc;
-	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
-					 chip->ecc.total);
-	if (ret)
-		return ret;
-
-	/* write OOB buffer to NAND device */
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	return 0;
-}
-
-/**
  * omap_read_page_bch - BCH ecc based page read function for entire page
  * @mtd:		mtd info structure
  * @chip:		nand chip info structure
@@ -1684,7 +1574,7 @@ static int omap_read_page_bch(struct mtd
 	chip->read_buf(mtd, oob, chip->ecc.total);
 
 	/* Calculate ecc bytes */
-	omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
+	chip->ecc.calculate(mtd, buf, ecc_calc);
 
 	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
 
@@ -1933,7 +1823,7 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1973,9 +1863,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -2008,7 +1898,7 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -2049,9 +1939,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err = is_elm_present(info, pdata->elm_of_node, BCH8_ECC);
 		if (err < 0) {
@@ -2084,9 +1974,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 16;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err = is_elm_present(info, pdata->elm_of_node, BCH16_ECC);
 		if (err < 0) {

