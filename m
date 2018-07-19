Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC3E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC3E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeGSJSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:18:52 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:49514 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeGSJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:18:51 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id w6J7ssqT030202; Thu, 19 Jul 2018 16:54:54 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id w6J7s1dh008596; Thu, 19 Jul 2018 16:54:01 +0900
X-Iguazu-Qid: 2wGr4XsOpocR8ov1OL
X-Iguazu-QSIG: v=1; s=0; t=1531986841; q=2wGr4XsOpocR8ov1OL; m=/g3rU7TXdO+dfxS7wdS8GI7jugW0ermTbPf+dQMKbZw=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id w6J7rx5X001124;
        Thu, 19 Jul 2018 16:53:59 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w6J7rx9v020903;
        Thu, 19 Jul 2018 16:53:59 +0900 (JST)
Content-Transfer-Encoding: 7bit
From:   KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: [RFC PATCH] mtd: nand: toshiba: Add support for ->exec_op()
Date:   Thu, 19 Jul 2018 16:53:47 +0900
X-TSB-HOP: ON
Message-Id: <1531986827-18743-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a patch to support TOSHIBA MEMORY CORPORATION BENAND
memory devices.  This use vendor specific command
(TOSHIBA_NAND_CMD_ECC_STATUS) to know the exact bitflips.  However, I
could not test this patch because I do not have a platform that
supports chip-> exec_op.  Therefore, I post this patch as RFC.

As soon as I get a platform that supports chip-> exec_op, I would like
to test and re-post.

Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
---
 drivers/mtd/nand/raw/nand_toshiba.c | 76 +++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index 6cec923..12218cd 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -17,28 +17,74 @@
 
 #include <linux/mtd/rawnand.h>
 
+/* ECC Status Read Command for BENAND */
+#define TOSHIBA_NAND_CMD_ECC_STATUS_READ	0x7A
+
+/* ECC Status Mask for BENAND */
+#define TOSHIBA_NAND_ECC_STATUS_MASK	0x0F
+
 /* Recommended to rewrite for BENAND */
 #define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
 
+static int toshiba_nand_benand_read_eccstatus_op(struct nand_chip *chip,
+						 u8 *buf)
+{
+	u8 *ecc_status = buf;
+
+	const struct nand_sdr_timings *sdr =
+		nand_get_sdr_timings(&chip->data_interface);
+	struct nand_op_instr instrs[] = {
+		NAND_OP_CMD(TOSHIBA_NAND_CMD_ECC_STATUS_READ,
+			    PSEC_TO_NSEC(sdr->tADL_min)),
+		NAND_OP_8BIT_DATA_IN(chip->ecc.steps, ecc_status, 0),
+	};
+	struct nand_operation op = NAND_OPERATION(instrs);
+
+	/* Drop the DATA_IN instruction if chip->ecc.steps is set to 0. */
+	if (!chip->ecc.steps)
+		op.ninstrs--;
+
+	return nand_exec_op(chip, &op);
+}
+
 static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
 					 struct nand_chip *chip)
 {
-	int ret;
+	int ret, i;
 	unsigned int max_bitflips = 0;
-	u8 status;
-
-	/* Check Status */
-	ret = nand_status_op(chip, &status);
-	if (ret)
-		return ret;
-
-	if (status & NAND_STATUS_FAIL) {
-		/* uncorrected */
-		mtd->ecc_stats.failed++;
-	} else if (status & TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED) {
-		/* corrected */
-		max_bitflips = mtd->bitflip_threshold;
-		mtd->ecc_stats.corrected += max_bitflips;
+	u8 status, bitflips, ecc_status[8];
+
+	if (chip->exec_op) {
+		/* Check ECC Status */
+		ret = toshiba_nand_benand_read_eccstatus_op(chip, ecc_status);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < chip->ecc.steps; i++) {
+			bitflips = (ecc_status[i] &
+				    TOSHIBA_NAND_ECC_STATUS_MASK);
+			if (bitflips == 0x0F) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += bitflips;
+				max_bitflips = max_t(unsigned int,
+						     max_bitflips, bitflips);
+			}
+		}
+	} else {
+		/* Check Status */
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			return ret;
+
+		if (status & NAND_STATUS_FAIL) {
+			/* uncorrected */
+			mtd->ecc_stats.failed++;
+		} else if (status & TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED) {
+			/* corrected */
+			max_bitflips = mtd->bitflip_threshold;
+			mtd->ecc_stats.corrected += max_bitflips;
+		}
 	}
 
 	return max_bitflips;
-- 
2.7.4


