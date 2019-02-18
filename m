Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E95B2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfBRKm7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:42:59 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:50304 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbfBRKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:42:56 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7A922603741;
        Mon, 18 Feb 2019 11:42:40 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Feb
 2019 11:42:40 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 18 Feb 2019 11:42:40 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] mtd: rawnand: Always store info about bad block
 markers in chip struct
Thread-Topic: [PATCH v4 1/7] mtd: rawnand: Always store info about bad block
 markers in chip struct
Thread-Index: AQHUx3ar9APJBNHcCE2d9JE/ieXSGg==
Date:   Mon, 18 Feb 2019 10:42:39 +0000
Message-ID: <20190218104122.18788-2-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190218104122.18788-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7A922603741.AE86C
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The information about where the manufacturer puts the bad block
markers inside the bad block and in the OOB data is stored in
different places. Let's move this information to nand_chip.options
and nand_chip.badblockpos.

As this chip-specific information is not directly related to the
bad block table (BBT), we also rename the flags to NAND_BBM_*.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/raw/nand_amd.c      |  2 +-
 drivers/mtd/nand/raw/nand_base.c     | 12 ++++++------
 drivers/mtd/nand/raw/nand_bbt.c      |  4 ++--
 drivers/mtd/nand/raw/nand_esmt.c     |  2 +-
 drivers/mtd/nand/raw/nand_hynix.c    |  4 ++--
 drivers/mtd/nand/raw/nand_macronix.c |  2 +-
 drivers/mtd/nand/raw/nand_micron.c   |  2 +-
 drivers/mtd/nand/raw/nand_samsung.c  |  4 ++--
 drivers/mtd/nand/raw/nand_toshiba.c  |  2 +-
 drivers/mtd/nand/raw/sh_flctl.c      |  4 ++--
 include/linux/mtd/rawnand.h          | 14 ++++++++++++++
 11 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_amd.c b/drivers/mtd/nand/raw/nand_amd.c
index 890c5b43e03c..6e248bdcc797 100644
--- a/drivers/mtd/nand/raw/nand_amd.c
+++ b/drivers/mtd/nand/raw/nand_amd.c
@@ -40,7 +40,7 @@ static void amd_nand_decode_id(struct nand_chip *chip)
 static int amd_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cca4b24d2ffa..c6199cc68d2f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -298,11 +298,11 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 	int page, page_end, res;
 	u8 bad;
 
-	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
+	if (chip->options & NAND_BBM_LASTPAGE)
 		ofs += mtd->erasesize - mtd->writesize;
 
 	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
-	page_end = page + (chip->bbt_options & NAND_BBT_SCAN2NDPAGE ? 2 : 1);
+	page_end = page + ((chip->options & NAND_BBM_SECONDPAGE) ? 2 : 1);
 
 	for (; page < page_end; page++) {
 		res = chip->ecc.read_oob(chip, page);
@@ -541,7 +541,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 	ops.mode = MTD_OPS_PLACE_OOB;
 
 	/* Write to first/last page(s) if necessary */
-	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
+	if (chip->options & NAND_BBM_LASTPAGE)
 		ofs += mtd->erasesize - mtd->writesize;
 	do {
 		res = nand_do_write_oob(chip, ofs, &ops);
@@ -550,7 +550,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 
 		i++;
 		ofs += mtd->writesize;
-	} while ((chip->bbt_options & NAND_BBT_SCAN2NDPAGE) && i < 2);
+	} while ((chip->options & NAND_BBM_SECONDPAGE) && i < 2);
 
 	return ret;
 }
@@ -4576,9 +4576,9 @@ static void nand_decode_bbm_options(struct nand_chip *chip)
 
 	/* Set the bad block position */
 	if (mtd->writesize > 512 || (chip->options & NAND_BUSWIDTH_16))
-		chip->badblockpos = NAND_LARGE_BADBLOCK_POS;
+		chip->badblockpos = NAND_BBM_POS_LARGE;
 	else
-		chip->badblockpos = NAND_SMALL_BADBLOCK_POS;
+		chip->badblockpos = NAND_BBM_POS_SMALL;
 }
 
 static inline bool is_full_id_nand(struct nand_flash_dev *type)
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 1b722fe9213c..12e92e307346 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -466,7 +466,7 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
 
 	pr_info("Scanning device for bad blocks\n");
 
-	if (bd->options & NAND_BBT_SCAN2NDPAGE)
+	if (this->options & NAND_BBM_SECONDPAGE)
 		numpages = 2;
 	else
 		numpages = 1;
@@ -487,7 +487,7 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
 		from = (loff_t)startblock << this->bbt_erase_shift;
 	}
 
-	if (this->bbt_options & NAND_BBT_SCANLASTPAGE)
+	if (this->options & NAND_BBM_LASTPAGE)
 		from += mtd->erasesize - (mtd->writesize * numpages);
 
 	for (i = startblock; i < numblocks; i++) {
diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
index 96f039a83bc8..80d2d3a1b5f2 100644
--- a/drivers/mtd/nand/raw/nand_esmt.c
+++ b/drivers/mtd/nand/raw/nand_esmt.c
@@ -36,7 +36,7 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
 static int esmt_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 343f477362d1..2789bf3857c9 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -672,9 +672,9 @@ static int hynix_nand_init(struct nand_chip *chip)
 	int ret;
 
 	if (!nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCANLASTPAGE;
+		chip->options |= NAND_BBM_LASTPAGE;
 	else
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	hynix = kzalloc(sizeof(*hynix), GFP_KERNEL);
 	if (!hynix)
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 47d8cda547cf..6db7ced4b96b 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -62,7 +62,7 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	macronix_nand_fix_broken_get_timings(chip);
 
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index b85e1c13b79e..ea6b6e80d6f8 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -448,7 +448,7 @@ static int micron_nand_init(struct nand_chip *chip)
 		goto err_free_manuf_data;
 
 	if (mtd->writesize == 2048)
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	ondie = micron_supports_on_die_ecc(chip);
 
diff --git a/drivers/mtd/nand/raw/nand_samsung.c b/drivers/mtd/nand/raw/nand_samsung.c
index e46d4c492ad8..3be737139210 100644
--- a/drivers/mtd/nand/raw/nand_samsung.c
+++ b/drivers/mtd/nand/raw/nand_samsung.c
@@ -121,9 +121,9 @@ static int samsung_nand_init(struct nand_chip *chip)
 		chip->options |= NAND_SAMSUNG_LP_OPTIONS;
 
 	if (!nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCANLASTPAGE;
+		chip->options |= NAND_BBM_LASTPAGE;
 	else
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |= NAND_BBM_SECONDPAGE;
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index d068163b64b3..222a66bf0aa6 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -147,7 +147,7 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
 static int toshiba_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
-		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+		chip->options |=  NAND_BBM_SECONDPAGE;
 
 	/* Check that chip is BENAND and ECC mode is on-die */
 	if (nand_is_slc(chip) && chip->ecc.mode == NAND_ECC_ON_DIE &&
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index cf6b1be1cf9c..2017b00fadd8 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -101,14 +101,12 @@ static const struct mtd_ooblayout_ops flctl_4secc_oob_largepage_ops = {
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
 static struct nand_bbt_descr flctl_4secc_smallpage = {
-	.options = NAND_BBT_SCAN2NDPAGE,
 	.offs = 11,
 	.len = 1,
 	.pattern = scan_ff_pattern,
 };
 
 static struct nand_bbt_descr flctl_4secc_largepage = {
-	.options = NAND_BBT_SCAN2NDPAGE,
 	.offs = 0,
 	.len = 2,
 	.pattern = scan_ff_pattern,
@@ -1178,6 +1176,8 @@ static int flctl_probe(struct platform_device *pdev)
 	if (pdata->flcmncr_val & SEL_16BIT)
 		nand->options |= NAND_BUSWIDTH_16;
 
+	nand->options |= NAND_BBM_SECONDPAGE;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 33e240acdc6d..b31f023f8887 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -169,6 +169,20 @@ enum nand_ecc_algo {
 /* Macros to identify the above */
 #define NAND_HAS_SUBPAGE_READ(chip) ((chip->options & NAND_SUBPAGE_READ))
 
+/*
+ * There are different places where the manufacturer stores the factory bad
+ * block markers.
+ *
+ * Position within the block: Each of these pages needs to be checked for a
+ * bad block marking pattern.
+ */
+#define NAND_BBM_SECONDPAGE		0x02000000
+#define NAND_BBM_LASTPAGE		0x04000000
+
+/* Position within the OOB data of the page */
+#define NAND_BBM_POS_SMALL		5
+#define NAND_BBM_POS_LARGE		0
+
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
 #define NAND_SKIP_BBTSCAN	0x00010000
-- 
2.17.1
