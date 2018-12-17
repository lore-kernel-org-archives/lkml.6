Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D442145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbeLQPtP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:49:15 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:43334 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387748AbeLQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:49:11 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id D344467A7C6;
        Mon, 17 Dec 2018 16:49:07 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 17 Dec
 2018 16:49:07 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 17 Dec 2018 16:49:07 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 1/3] mtd: rawnand: Support bad block markers in first, second
 or last page
Thread-Topic: [PATCH 1/3] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Index: AQHUliALbj7sZ4eBT0aRyPBxGaehfw==
Date:   Mon, 17 Dec 2018 15:49:07 +0000
Message-ID: <1545061693-29216-2-git-send-email-frieder.schrempf@kontron.de>
References: <1545061693-29216-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1545061693-29216-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D344467A7C6.AE6CF
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Currently supported bad block marker positions within the block are:
* in first page only
* in last page only
* in first or second page

Some ESMT NANDs are known to have been shipped by the manufacturer
with bad block markers in the first or last page, instead of the
first or second page.

Also the datasheets for Cypress/Spansion/AMD NANDs claim that the
first, second *and* last page needs to be checked.

Therefore we make it possible to set NAND_BBT_SCAN2NDPAGE and
NAND_BBT_SCANLASTPAGE at the same time to scan/set all three pages.

To simplify the code, the logic to evaluate the flags is moved to a
a new function nand_bbm_page_offset().

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/raw/internals.h |  1 +
 drivers/mtd/nand/raw/nand_base.c | 72 ++++++++++++++++++++++++++---------
 drivers/mtd/nand/raw/nand_bbt.c  | 30 +++++++--------
 3 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index 04c2cf7..8e4b168 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -76,6 +76,7 @@ extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 
 /* Core functions */
 const struct nand_manufacturer *nand_get_manufacturer(u8 id);
+int nand_bbm_page_offset(struct nand_chip *chip, int index);
 int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 71050a0..388d9ed 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -253,6 +253,45 @@ static void nand_release_device(struct mtd_info *mtd)
 }
 
 /**
+ * nand_bbm_page_offset - Get the page offsets for bad block markers
+ * @chip: NAND chip object
+ * @index: Index for the page offset
+ *
+ * Returns an integer that corresponds to the page offset within a block, for
+ * a page that is used to store bad block markers. If no more page offsets are
+ * available, -1 is returned.
+ */
+int nand_bbm_page_offset(struct nand_chip *chip, int index)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int last_page = ((mtd->erasesize - mtd->writesize) >>
+			 chip->page_shift) & chip->pagemask;
+
+	switch (index) {
+	case 0:
+		if ((chip->bbt_options & NAND_BBT_SCANLASTPAGE) &&
+		    !(chip->bbt_options & NAND_BBT_SCAN2NDPAGE))
+			return last_page;
+		else
+			return 0;
+		break;
+	case 1:
+		if (chip->bbt_options & NAND_BBT_SCAN2NDPAGE)
+			return 1;
+		break;
+	case 2:
+		if ((chip->bbt_options & NAND_BBT_SCANLASTPAGE) &&
+		    (chip->bbt_options & NAND_BBT_SCAN2NDPAGE))
+			return last_page;
+		break;
+	default:
+		break;
+	}
+
+	return -1;
+}
+
+/**
  * nand_block_bad - [DEFAULT] Read bad block marker from the chip
  * @chip: NAND chip object
  * @ofs: offset from device start
@@ -261,18 +300,14 @@ static void nand_release_device(struct mtd_info *mtd)
  */
 static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	int page, page_end, res;
+	int page_offset, i = 0;
+	int res, first_page = (int)(ofs >> chip->page_shift) & chip->pagemask;
 	u8 bad;
 
-	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
-		ofs += mtd->erasesize - mtd->writesize;
+	page_offset = nand_bbm_page_offset(chip, 0);
 
-	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
-	page_end = page + (chip->bbt_options & NAND_BBT_SCAN2NDPAGE ? 2 : 1);
-
-	for (; page < page_end; page++) {
-		res = chip->ecc.read_oob(chip, page);
+	do {
+		res = chip->ecc.read_oob(chip, first_page + page_offset);
 		if (res < 0)
 			return res;
 
@@ -284,7 +319,9 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 			res = hweight8(bad) < chip->badblockbits;
 		if (res)
 			return res;
-	}
+
+		page_offset = nand_bbm_page_offset(chip, ++i);
+	} while (page_offset != -1);
 
 	return 0;
 }
@@ -303,7 +340,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtd_oob_ops ops;
 	uint8_t buf[2] = { 0, 0 };
-	int ret = 0, res, i = 0;
+	int ret = 0, res, i = 0, page_offset;
 
 	memset(&ops, 0, sizeof(ops));
 	ops.oobbuf = buf;
@@ -316,17 +353,16 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 	}
 	ops.mode = MTD_OPS_PLACE_OOB;
 
-	/* Write to first/last page(s) if necessary */
-	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
-		ofs += mtd->erasesize - mtd->writesize;
+	page_offset = nand_bbm_page_offset(chip, 0);
+
 	do {
-		res = nand_do_write_oob(mtd, ofs, &ops);
+		res = nand_do_write_oob(mtd, ofs + page_offset * mtd->writesize,
+					&ops);
 		if (!ret)
 			ret = res;
 
-		i++;
-		ofs += mtd->writesize;
-	} while ((chip->bbt_options & NAND_BBT_SCAN2NDPAGE) && i < 2);
+		page_offset = nand_bbm_page_offset(chip, ++i);
+	} while (page_offset != -1);
 
 	return ret;
 }
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 98a8268..b1424b3 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -412,10 +412,11 @@ static void read_abs_bbts(struct mtd_info *mtd, uint8_t *buf,
 
 /* Scan a given block partially */
 static int scan_block_fast(struct mtd_info *mtd, struct nand_bbt_descr *bd,
-			   loff_t offs, uint8_t *buf, int numpages)
+			   loff_t offs, uint8_t *buf)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct mtd_oob_ops ops;
-	int j, ret;
+	int i = 0, ret, page_offset;
 
 	ops.ooblen = mtd->oobsize;
 	ops.oobbuf = buf;
@@ -423,12 +424,15 @@ static int scan_block_fast(struct mtd_info *mtd, struct nand_bbt_descr *bd,
 	ops.datbuf = NULL;
 	ops.mode = MTD_OPS_PLACE_OOB;
 
-	for (j = 0; j < numpages; j++) {
+	page_offset = nand_bbm_page_offset(chip, 0);
+
+	do {
 		/*
 		 * Read the full oob until read_oob is fixed to handle single
 		 * byte reads for 16 bit buswidth.
 		 */
-		ret = mtd_read_oob(mtd, offs, &ops);
+		ret = mtd_read_oob(mtd, offs + page_offset * mtd->writesize,
+				   &ops);
 		/* Ignore ECC errors when checking for BBM */
 		if (ret && !mtd_is_bitflip_or_eccerr(ret))
 			return ret;
@@ -436,8 +440,9 @@ static int scan_block_fast(struct mtd_info *mtd, struct nand_bbt_descr *bd,
 		if (check_short_pattern(buf, bd))
 			return 1;
 
-		offs += mtd->writesize;
-	}
+		page_offset = nand_bbm_page_offset(chip, ++i);
+	} while (page_offset != -1);
+
 	return 0;
 }
 
@@ -456,17 +461,11 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf,
 	struct nand_bbt_descr *bd, int chip)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int i, numblocks, numpages;
-	int startblock;
+	int i, numblocks, startblock;
 	loff_t from;
 
 	pr_info("Scanning device for bad blocks\n");
 
-	if (bd->options & NAND_BBT_SCAN2NDPAGE)
-		numpages = 2;
-	else
-		numpages = 1;
-
 	if (chip == -1) {
 		numblocks = mtd->size >> this->bbt_erase_shift;
 		startblock = 0;
@@ -483,15 +482,12 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf,
 		from = (loff_t)startblock << this->bbt_erase_shift;
 	}
 
-	if (this->bbt_options & NAND_BBT_SCANLASTPAGE)
-		from += mtd->erasesize - (mtd->writesize * numpages);
-
 	for (i = startblock; i < numblocks; i++) {
 		int ret;
 
 		BUG_ON(bd->options & NAND_BBT_NO_OOB);
 
-		ret = scan_block_fast(mtd, bd, from, buf, numpages);
+		ret = scan_block_fast(mtd, bd, from, buf);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4
