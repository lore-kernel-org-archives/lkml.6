Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA573C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5A123C07
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="besfmkdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A123C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeFVB25 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:28:57 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53686 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934235AbeFVB2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:28:51 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A304C8448A;
        Fri, 22 Jun 2018 13:28:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529630930;
        bh=KcLCX7zzbyJ6z9uIORmX3b0B5jwZKlaUBrwTo8BTxj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=besfmkdVSevQsrYw0XXFo7JjHVhgyvmp6lZAdpl56LFY+AaT36JZ4KjjZg5PUTKfe
         PkSsb9D3IaqfGQN6/HPMCeYwzguZqhoS1ZsvtljQyV5D6bjuph+x5LNqJUh6Q291FB
         +eVtUB8ChGLbeO8dBXrJ5/2u7JuzQ0Yg6+aT2fqU=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2c50d20000>; Fri, 22 Jun 2018 13:28:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A442B13EE1C;
        Fri, 22 Jun 2018 13:28:53 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 694821E2626; Fri, 22 Jun 2018 13:28:50 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v5 5/6] mtd: rawnand: micron: support 8/512 on-die ECC
Date:   Fri, 22 Jun 2018 13:28:34 +1200
Message-Id: <20180622012835.17874-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622012835.17874-1-chris.packham@alliedtelesis.co.nz>
References: <20180622012835.17874-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron MT29F1G08ABAFAWP-ITE:F supports an on-die ECC with 8 bits
per 512 bytes. Add support for this combination.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New
    Changes in v3:
    - Handle reporting of corrected errors that don't require a rewrite, expand
      comment for the ECC status bits.
    Changes in v4:
    - Use a switch statement for handling ECC status
    - Update ecc_stats.corrected
    Changes in v5:
    - Move status checking to different routines for 4/512 and 8/512 assume
      the highest number of bit flips for a given status value.

 drivers/mtd/nand/raw/nand_micron.c | 100 +++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index d30bd4df9b12..f83053562925 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -18,10 +18,30 @@
 #include <linux/mtd/rawnand.h>
 
 /*
- * Special Micron status bit that indicates when the block has been
- * corrected by on-die ECC and should be rewritten
+ * Special Micron status bit 3 indicates that the block has been
+ * corrected by on-die ECC and should be rewritten.
  */
-#define NAND_STATUS_WRITE_RECOMMENDED	BIT(3)
+#define NAND_ECC_STATUS_WRITE_RECOMMENDED	BIT(3)
+
+/*
+ * On chips with 8-bit ECC and additional bit can be used to distinguish
+ * cases where a errors were corrected without needing a rewrite
+ *
+ * Bit 4 Bit 3 Bit 0 Description
+ * ----- ----- ----- -----------
+ * 0     0     0     No Errors
+ * 0     0     1     Multiple uncorrected errors
+ * 0     1     0     4 - 6 errors corrected, recommend rewrite
+ * 0     1     1     Reserved
+ * 1     0     0     1 - 3 errors corrected
+ * 1     0     1     Reserved
+ * 1     1     0     7 - 8 errors corrected, recommend rewrite
+ */
+#define NAND_ECC_STATUS_MASK		(BIT(4) | BIT(3) | BIT(0))
+#define NAND_ECC_STATUS_UNCORRECTABLE	BIT(0)
+#define NAND_ECC_STATUS_4_6_CORRECTED	BIT(3)
+#define NAND_ECC_STATUS_1_3_CORRECTED	BIT(4)
+#define NAND_ECC_STATUS_7_8_CORRECTED	(BIT(4) | BIT(3))
 
 struct nand_onfi_vendor_micron {
 	u8 two_plane_read;
@@ -113,6 +133,54 @@ static int micron_nand_on_die_ecc_setup(struct nand_chip *chip, bool enable)
 	return nand_set_features(chip, ONFI_FEATURE_ON_DIE_ECC, feature);
 }
 
+
+static int micron_nand_on_die_ecc_status_4(struct mtd_info *mtd,
+					   struct nand_chip *chip, u8 status)
+{
+	/*
+	 * The internal ECC doesn't tell us the number of bitflips
+	 * that have been corrected, but tells us if it recommends to
+	 * rewrite the block. If it's the case, then we pretend we had
+	 * a number of bitflips equal to the ECC strength, which will
+	 * hint the NAND core to rewrite the block.
+	 */
+	if (status & NAND_STATUS_FAIL) {
+		mtd->ecc_stats.failed++;
+	} else if (status & NAND_ECC_STATUS_WRITE_RECOMMENDED) {
+		mtd->ecc_stats.corrected += chip->ecc.strength;
+		return chip->ecc.strength;
+	}
+
+	return 0;
+}
+
+static int micron_nand_on_die_ecc_status_8(struct mtd_info *mtd,
+					   struct nand_chip *chip, u8 status)
+{
+	/*
+	 * With 8/512 we have more information but still don't know precisely
+	 * how many bit-flips were seen.
+	 */
+	switch (status & NAND_ECC_STATUS_MASK) {
+	case NAND_ECC_STATUS_UNCORRECTABLE:
+		mtd->ecc_stats.failed++;
+		return 0;
+	case NAND_ECC_STATUS_1_3_CORRECTED:
+		mtd->ecc_stats.corrected += 3;
+		return 3;
+	case NAND_ECC_STATUS_4_6_CORRECTED:
+		mtd->ecc_stats.corrected += 6;
+		/* rewrite recommended */
+		return 6;
+	case NAND_ECC_STATUS_7_8_CORRECTED:
+		mtd->ecc_stats.corrected += 8;
+		/* rewrite recommended */
+		return 8;
+	default:
+		return 0;
+	}
+}
+
 static int
 micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 				 uint8_t *buf, int oob_required,
@@ -137,19 +205,10 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 	if (ret)
 		goto out;
 
-	if (status & NAND_STATUS_FAIL) {
-		mtd->ecc_stats.failed++;
-	} else if (status & NAND_STATUS_WRITE_RECOMMENDED) {
-		/*
-		 * The internal ECC doesn't tell us the number of bitflips
-		 * that have been corrected, but tells us if it recommends to
-		 * rewrite the block. If it's the case, then we pretend we had
-		 * a number of bitflips equal to the ECC strength, which will
-		 * hint the NAND core to rewrite the block.
-		 */
-		mtd->ecc_stats.corrected += chip->ecc.strength;
-		max_bitflips = chip->ecc.strength;
-	}
+	if (chip->ecc.strength == 4)
+		max_bitflips = micron_nand_on_die_ecc_status_4(mtd, chip, status);
+	else
+		max_bitflips = micron_nand_on_die_ecc_status_8(mtd, chip, status);
 
 	ret = nand_read_data_op(chip, buf, mtd->writesize, false);
 	if (!ret && oob_required)
@@ -240,10 +299,9 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 		return MICRON_ON_DIE_MANDATORY;
 
 	/*
-	 * Some Micron NANDs have an on-die ECC of 4/512, some other
-	 * 8/512. We only support the former.
+	 * We only support on-die ECC of 4/512 or 8/512
 	 */
-	if (chip->ecc_strength_ds != 4)
+	if  (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	return MICRON_ON_DIE_SUPPORTED;
@@ -275,9 +333,9 @@ static int micron_nand_init(struct nand_chip *chip)
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

