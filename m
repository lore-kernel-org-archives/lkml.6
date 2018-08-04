Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A3DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D9217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978D9217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHDH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:29:40 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:41226 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:29:40 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id w745TWLR000773; Sat, 4 Aug 2018 14:29:32 +0900
X-Iguazu-Qid: 2wGrT2hbsoZemxf7rc
X-Iguazu-QSIG: v=1; s=0; t=1533360572; q=2wGrT2hbsoZemxf7rc; m=fWLoZMBK0fYugtY533PjSu4xCFSoTTJpttmiC/x+MmE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id w745TUHB032990;
        Sat, 4 Aug 2018 14:29:31 +0900
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by imx12.toshiba.co.jp  with ESMTP id w745TUhE007278;
        Sat, 4 Aug 2018 14:29:30 +0900 (JST)
From:   KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: [RFC PATCH v2] mtd: nand: toshiba: Add support for ->exec_op()
Date:   Sat,  4 Aug 2018 14:26:18 +0900
X-TSB-HOP: ON
Message-Id: <1533360378-2925-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
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
 drivers/mtd/nand/raw/nand_toshiba.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index 8aec3fa..3f4683b 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -23,14 +23,65 @@
 /* Recommended to rewrite for BENAND */
 #define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
 
+/* ECC Status Read Command for BENAND */
+#define TOSHIBA_NAND_CMD_ECC_STATUS_READ	0x7A
+
+/* ECC Status Mask for BENAND */
+#define TOSHIBA_NAND_ECC_STATUS_MASK		0x0F
+
+/* Uncorrectable Error for BENAND */
+#define TOSHIBA_NAND_ECC_STATUS_UNCORR		0x0F
+
+static int toshiba_nand_benand_read_eccstatus_op(struct nand_chip *chip,
+						 u8 *buf)
+{
+	u8 *ecc_status = buf;
+
+	if (chip->exec_op) {
+		const struct nand_sdr_timings *sdr =
+			nand_get_sdr_timings(&chip->data_interface);
+		struct nand_op_instr instrs[] = {
+			NAND_OP_CMD(TOSHIBA_NAND_CMD_ECC_STATUS_READ,
+				    PSEC_TO_NSEC(sdr->tADL_min)),
+			NAND_OP_8BIT_DATA_IN(chip->ecc.steps, ecc_status, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
+	return -ENOTSUPP;
+}
+
 static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
 					 struct nand_chip *chip)
 {
 	int ret;
 	unsigned int max_bitflips = 0;
-	u8 status;
+	u8 status, ecc_status[8];
 
 	/* Check Status */
+	ret = toshiba_nand_benand_read_eccstatus_op(chip, ecc_status);
+	if (!ret) {
+		unsigned int i, bitflips = 0;
+
+		for (i = 0; i < chip->ecc.steps; i++) {
+			bitflips = ecc_status[i] & TOSHIBA_NAND_ECC_STATUS_MASK;
+			if (bitflips == TOSHIBA_NAND_ECC_STATUS_UNCORR) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += bitflips;
+				max_bitflips = max(max_bitflips, bitflips);
+			}
+		}
+
+		return max_bitflips;
+	}
+
+	/*
+	 * Fallback to regular status check if
+	 * toshiba_nand_benand_read_eccstatus_op() failed.
+	 */
 	ret = nand_status_op(chip, &status);
 	if (ret)
 		return ret;
-- 
2.7.4

