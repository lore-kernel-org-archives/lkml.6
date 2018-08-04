Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD812C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661272177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661272177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeHDH0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:26:44 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:55764 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDH0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:26:43 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id w745QN67007035; Sat, 4 Aug 2018 14:26:23 +0900
X-Iguazu-Qid: 2wGqjZUhdEFGnqXwtk
X-Iguazu-QSIG: v=1; s=0; t=1533360382; q=2wGqjZUhdEFGnqXwtk; m=efBU3koXaYlJ2dy8mid6XF+0OEJ8Iq4Kbvu3IMFJTfs=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id w745QJ5g037574;
        Sat, 4 Aug 2018 14:26:19 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w745QJ1Z010620;
        Sat, 4 Aug 2018 14:26:19 +0900 (JST)
From:   KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: [PATCH v6] mtd: nand: toshiba: Add support for Toshiba Memory BENAND (Built-in ECC NAND)
Date:   Sat,  4 Aug 2018 14:25:52 +0900
X-TSB-HOP: ON
Message-Id: <1533360352-2882-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a patch to support TOSHIBA MEMORY CORPORATION BENAND
memory devices.  Check the status of the built-in ECC with the Read
Status command without using the vendor specific command.  The Read
Status command only knows whether there was bitflips above the
threshold and can not get accurate bitflips.  For now, I set
max_bitflips mtd->bitflip_threshold.

Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
---
 drivers/mtd/nand/raw/nand_toshiba.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index ab43f02..8aec3fa 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -17,6 +17,89 @@
 
 #include <linux/mtd/rawnand.h>
 
+/* Bit for detecting BENAND */
+#define TOSHIBA_NAND_ID4_IS_BENAND		BIT(7)
+
+/* Recommended to rewrite for BENAND */
+#define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
+
+static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
+					 struct nand_chip *chip)
+{
+	int ret;
+	unsigned int max_bitflips = 0;
+	u8 status;
+
+	/* Check Status */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL) {
+		/* uncorrected */
+		mtd->ecc_stats.failed++;
+	} else if (status & TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED) {
+		/* corrected */
+		max_bitflips = mtd->bitflip_threshold;
+		mtd->ecc_stats.corrected += max_bitflips;
+	}
+
+	return max_bitflips;
+}
+
+static int
+toshiba_nand_read_page_benand(struct mtd_info *mtd,
+			      struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
+{
+	int ret;
+
+	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
+	if (ret)
+		return ret;
+
+	return toshiba_nand_benand_eccstatus(mtd, chip);
+}
+
+static int
+toshiba_nand_read_subpage_benand(struct mtd_info *mtd,
+				 struct nand_chip *chip, uint32_t data_offs,
+				 uint32_t readlen, uint8_t *bufpoi, int page)
+{
+	int ret;
+
+	ret = nand_read_page_op(chip, page, data_offs,
+				bufpoi + data_offs, readlen);
+	if (ret)
+		return ret;
+
+	return toshiba_nand_benand_eccstatus(mtd, chip);
+}
+
+static void toshiba_nand_benand_init(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	/*
+	 * On BENAND, the entire OOB region can be used by the MTD user.
+	 * The calculated ECC bytes are stored into other isolated
+	 * area which is not accessible to users.
+	 * This is why chip->ecc.bytes = 0.
+	 */
+	chip->ecc.bytes = 0;
+	chip->ecc.size = 512;
+	chip->ecc.strength = 8;
+	chip->ecc.read_page = toshiba_nand_read_page_benand;
+	chip->ecc.read_subpage = toshiba_nand_read_subpage_benand;
+	chip->ecc.write_page = nand_write_page_raw;
+	chip->ecc.read_page_raw = nand_read_page_raw_notsupp;
+	chip->ecc.write_page_raw = nand_write_page_raw_notsupp;
+
+	chip->options |= NAND_SUBPAGE_READ;
+
+	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+}
+
 static void toshiba_nand_decode_id(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -68,6 +151,11 @@ static int toshiba_nand_init(struct nand_chip *chip)
 	if (nand_is_slc(chip))
 		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
 
+	/* Check that chip is BENAND and ECC mode is on-die */
+	if (nand_is_slc(chip) && chip->ecc.mode == NAND_ECC_ON_DIE &&
+	    chip->id.data[4] & TOSHIBA_NAND_ID4_IS_BENAND)
+		toshiba_nand_benand_init(chip);
+
 	return 0;
 }
 
-- 
2.7.4

