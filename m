Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeECMY2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:24:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeECMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85AFE60AF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 08/14] mtd: rawnand: qcom: parse read errors for read oob also
Date: Thu,  3 May 2018 17:50:35 +0530
Message-Id: <1525350041-22995-9-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_page and read_oob both calls the read_page_ecc function.
The QCOM NAND controller protect the OOB available bytes with
ECC so read errors should be checked for read_oob also. Now
this patch moves the error checking code inside read_page_ecc
so caller does not have to check explicitly for read errors.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
* Changes from v1:

  1. Minor code change for return early in case of error

 drivers/mtd/nand/raw/qcom_nandc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index fa38142..61d0e7d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1700,6 +1700,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 	int i, ret;
 
 	config_nand_page_read(nandc);
@@ -1760,12 +1761,14 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	}
 
 	ret = submit_descs(nandc);
-	if (ret)
+	free_descs(nandc);
+
+	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
+		return ret;
+	}
 
-	free_descs(nandc);
-
-	return ret;
+	return parse_read_errors(host, data_buf_start, oob_buf_start);
 }
 
 /*
@@ -1810,20 +1813,14 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u8 *data_buf, *oob_buf = NULL;
-	int ret;
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
 	clear_bam_transaction(nandc);
-	ret = read_page_ecc(host, data_buf, oob_buf);
-	if (ret) {
-		dev_err(nandc->dev, "failure to read page\n");
-		return ret;
-	}
 
-	return parse_read_errors(host, data_buf, oob_buf);
+	return read_page_ecc(host, data_buf, oob_buf);
 }
 
 /* implements ecc->read_page_raw() */
@@ -1913,7 +1910,6 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int ret;
 
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
@@ -1922,11 +1918,7 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true);
 
-	ret = read_page_ecc(host, NULL, chip->oob_poi);
-	if (ret)
-		dev_err(nandc->dev, "failure to read oob\n");
-
-	return ret;
+	return read_page_ecc(host, NULL, chip->oob_poi);
 }
 
 /* implements ecc->write_page() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
