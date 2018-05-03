Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeECMV7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeECMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23D2A60588
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
Subject: [PATCH v2 13/14] mtd: rawnand: qcom: helper function for raw read
Date: Thu,  3 May 2018 17:50:40 +0530
Message-Id: <1525350041-22995-14-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does minor code reorganization for raw reads.
Currently the raw read is required for complete page but for
subsequent patches related with erased codeword bit flips
detection, only few CW should be read. So, this patch adds
helper function and introduces the read CW bitmask which
specifies which CW reads are required in complete page.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

 1. Included more detail in function comment

 drivers/mtd/nand/raw/qcom_nandc.c | 197 ++++++++++++++++++++++++--------------
 1 file changed, 123 insertions(+), 74 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index d828115..5148b49 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1590,6 +1590,127 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 }
 
 /*
+ * Helper to perform the page raw read operation. The read_cw_mask will be
+ * used to specify the codewords (CW) for which the data should be read. The
+ * single page contains multiple CW.
+ *
+ * Normally other NAND controllers store the data in main area and
+ * ecc bytes in oob area. So, if page size is 2048+64 then 2048
+ * data bytes will go in main area followed by ECC bytes. The QCOM NAND
+ * controller follows different layout in which the data+oob is internally
+ * divided in 528/532 bytes CW and each CW contains 516 bytes followed by
+ * ECC parity bytes for that CW. By this, 4 available oob bytes per CW
+ * will also be protected with ECC.
+ *
+ * For each CW read, following are the 2 steps
+ * 1. Read the codeword bytes from NAND chip to NAND controller internal HW
+ *    buffer.
+ * 2. Copy all these bytes from this HW buffer to driver RAM buffer.
+ *
+ * Sometime, only few CW data is required in complete page. The read_cw_mask
+ * specifies which CW in a page needs to be read. Start address will be
+ * determined with this CW mask to skip unnecessary data copy from NAND
+ * flash device. Then, actual data copy from NAND controller HW internal buffer
+ * to data buffer will be done only for the CWs, which have the mask set.
+ */
+static int
+nandc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
+		    u8 *data_buf, u8 *oob_buf,
+		    int page, unsigned long read_cw_mask)
+{
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int i, ret;
+	int read_loc, start_step, last_step;
+
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
+	host->use_ecc = false;
+	start_step = ffs(read_cw_mask) - 1;
+	last_step = fls(read_cw_mask);
+
+	clear_bam_transaction(nandc);
+	set_address(host, host->cw_size * start_step, page);
+	update_rw_regs(host, last_step - start_step, true);
+	config_nand_page_read(nandc);
+
+	for (i = start_step; i < last_step; i++) {
+		int data_size1, data_size2, oob_size1, oob_size2;
+		int reg_off = FLASH_BUF_ACC;
+
+		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
+		oob_size1 = host->bbm_size;
+
+		if (i == (ecc->steps - 1)) {
+			data_size2 = ecc->size - data_size1 -
+				     ((ecc->steps - 1) << 2);
+			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
+				    host->spare_bytes;
+		} else {
+			data_size2 = host->cw_data - data_size1;
+			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
+		}
+
+		/*
+		 * Don't perform actual data copy from NAND controller internal
+		 * HW buffer to data buffer through DMA for this codeword.
+		 */
+		if (!(read_cw_mask & BIT(i))) {
+			if (nandc->props->is_bam)
+				nandc_set_read_loc(nandc, 0, 0, 0, 1);
+
+			config_nand_cw_read(nandc, false);
+
+			data_buf += data_size1 + data_size2;
+			oob_buf += oob_size1 + oob_size2;
+
+			continue;
+		}
+
+		if (nandc->props->is_bam) {
+			read_loc = 0;
+			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+			read_loc += data_size1;
+
+			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+			read_loc += oob_size1;
+
+			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+			read_loc += data_size2;
+
+			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+		}
+
+		config_nand_cw_read(nandc, false);
+
+		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
+		reg_off += data_size1;
+		data_buf += data_size1;
+
+		read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
+		reg_off += oob_size1;
+		oob_buf += oob_size1;
+
+		read_data_dma(nandc, reg_off, data_buf, data_size2, 0);
+		reg_off += data_size2;
+		data_buf += data_size2;
+
+		read_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
+		oob_buf += oob_size2;
+	}
+
+	ret = submit_descs(nandc);
+	free_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failure to read raw page\n");
+		return ret;
+	}
+
+	return check_flash_errors(host, ecc->steps);
+}
+
+/*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
  */
@@ -1817,80 +1938,8 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 				    struct nand_chip *chip, uint8_t *buf,
 				    int oob_required, int page)
 {
-	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	u8 *data_buf, *oob_buf;
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int i, ret;
-	int read_loc;
-
-	nand_read_page_op(chip, page, 0, NULL, 0);
-	data_buf = buf;
-	oob_buf = chip->oob_poi;
-
-	host->use_ecc = false;
-
-	clear_bam_transaction(nandc);
-	update_rw_regs(host, ecc->steps, true);
-	config_nand_page_read(nandc);
-
-	for (i = 0; i < ecc->steps; i++) {
-		int data_size1, data_size2, oob_size1, oob_size2;
-		int reg_off = FLASH_BUF_ACC;
-
-		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
-		oob_size1 = host->bbm_size;
-
-		if (i == (ecc->steps - 1)) {
-			data_size2 = ecc->size - data_size1 -
-				     ((ecc->steps - 1) << 2);
-			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
-				    host->spare_bytes;
-		} else {
-			data_size2 = host->cw_data - data_size1;
-			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
-		}
-
-		if (nandc->props->is_bam) {
-			read_loc = 0;
-			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
-			read_loc += data_size1;
-
-			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
-			read_loc += oob_size1;
-
-			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
-			read_loc += data_size2;
-
-			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
-		}
-
-		config_nand_cw_read(nandc, false);
-
-		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
-		reg_off += data_size1;
-		data_buf += data_size1;
-
-		read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
-		reg_off += oob_size1;
-		oob_buf += oob_size1;
-
-		read_data_dma(nandc, reg_off, data_buf, data_size2, 0);
-		reg_off += data_size2;
-		data_buf += data_size2;
-
-		read_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
-		oob_buf += oob_size2;
-	}
-
-	ret = submit_descs(nandc);
-	free_descs(nandc);
-	if (ret) {
-		dev_err(nandc->dev, "failure to read raw page\n");
-		return ret;
-	}
-
-	return check_flash_errors(host, ecc->steps);
+	return nandc_read_page_raw(mtd, chip, buf, chip->oob_poi, page,
+				   BIT(chip->ecc.steps) - 1);
 }
 
 /* implements ecc->read_oob() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
