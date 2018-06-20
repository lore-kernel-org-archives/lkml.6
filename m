Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46413C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="HxjChBsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F156C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFTFG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:06:26 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48858 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:05:50 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 914968448A;
        Wed, 20 Jun 2018 17:05:48 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529471148;
        bh=mqn1iJWIBzr392oIEsjmWpoUgCZQelD3iayWhCQ/IDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HxjChBsgwPBSWVnU5RLgqOrVnNazi2vYln0WIWy23yslpiRbycd9sDCgo4rpN4uGz
         8C0tGtQwdzfp1tS/3wsB+o+z65h71EaE9/75qoQxfcgUjUb7aASClxMTziOCyIiAXv
         LLt7um/pWmQw8FsgRUMyeZixSN9rda8TfB9lmCVA=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b29e0ac0003>; Wed, 20 Jun 2018 17:05:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 2744113ED58;
        Wed, 20 Jun 2018 17:05:51 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 039051E2626; Wed, 20 Jun 2018 17:05:48 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v3 4/4] mtd: rawnand: micron: support 8/512 on-die ECC
Date:   Wed, 20 Jun 2018 17:05:44 +1200
Message-Id: <20180620050544.31549-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron MT29F1G08ABAFAWP-ITE:F supports an on-die ECC with 8 bits
per 512 bytes. Add support for this combination.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- New
Changes in v3:
- Handle reporting of corrected errors that don't require a rewrite, expand
  comment for the ECC status bits.

 drivers/mtd/nand/raw/nand_micron.c | 34 ++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 5cec79372181..0c2bde4411d7 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -18,10 +18,24 @@
 #include <linux/mtd/rawnand.h>
 
 /*
- * Special Micron status bit that indicates when the block has been
- * corrected by on-die ECC and should be rewritten
+ * Special Micron status bit 3 indicates that the block has been
+ * corrected by on-die ECC and should be rewritten.
+ *
+ * On chips with 8-bit ECC and additional bit can be used to distinguish
+ * cases where a errors were corrected without needing a rewrite
+ *
+ * Bit 4 Bit 3 Bit 0 Description
+ * ----- ----- ----- -----------
+ * 0     0     0     No Errors
+ * 0     0     1     Multiple uncorrected errors
+ * 0     1     0     4 - 6 errors corrected, recommend rewrite
+ * 0     0     1     Reserved
+ * 1     0     0     1 - 3 errors corrected
+ * 1     0     1     Reserved
+ * 1     1     0     7 - 8 errors corrected, recommend rewrite
  */
 #define NAND_STATUS_WRITE_RECOMMENDED	BIT(3)
+#define NAND_STATUS_ERRORS_CORRECTED	BIT(4)
 
 struct nand_onfi_vendor_micron {
 	u8 two_plane_read;
@@ -141,7 +155,7 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 		mtd->ecc_stats.failed++;
 
 	/*
-	 * The internal ECC doesn't tell us the number of bitflips
+	 * The internal 4-bit ECC doesn't tell us the number of bitflips
 	 * that have been corrected, but tells us if it recommends to
 	 * rewrite the block. If it's the case, then we pretend we had
 	 * a number of bitflips equal to the ECC strength, which will
@@ -149,6 +163,12 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 	 */
 	else if (status & NAND_STATUS_WRITE_RECOMMENDED)
 		max_bitflips = chip->ecc.strength;
+	/*
+	 * Chips with 8-bit internal ECC do tell us if errors 1 to 3 bit
+	 * errors have been corrected without recommending a rewrite.
+	 */
+	else if (status & NAND_STATUS_ERRORS_CORRECTED)
+		max_bitflips = 3;
 
 	ret = nand_read_data_op(chip, buf, mtd->writesize, false);
 	if (!ret && oob_required)
@@ -240,9 +260,9 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 
 	/*
 	 * Some Micron NANDs have an on-die ECC of 4/512, some other
-	 * 8/512. We only support the former.
+	 * 8/512.
 	 */
-	if (chip->ecc_strength_ds != 4)
+	if (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	return MICRON_ON_DIE_SUPPORTED;
@@ -274,9 +294,9 @@ static int micron_nand_init(struct nand_chip *chip)
 			return -EINVAL;
 		}
 
-		chip->ecc.bytes = 8;
+		chip->ecc.bytes = chip->ecc_strength_ds * 2;
 		chip->ecc.size = 512;
-		chip->ecc.strength = 4;
+		chip->ecc.strength = chip->ecc_strength_ds;
 		chip->ecc.algo = NAND_ECC_BCH;
 		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
 		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
-- 
2.17.1

