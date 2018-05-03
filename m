Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeECMVu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeECMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3C3A60AD4
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
Subject: [PATCH v2 11/14] mtd: rawnand: qcom: minor code reorganization for bad block check
Date: Thu,  3 May 2018 17:50:38 +0530
Message-Id: <1525350041-22995-12-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCOM NAND layout is such that, the bad block byte offset for
last codeword will come to first byte in spare area. Currently,
the raw read for last codeword is being done with copy_last_cw
function. It does following 2 things

1. Read the last codeword bytes from NAND chip to NAND
   controller internal HW buffer.
2. Copy all these bytes from this HW buffer to driver RAM
   buffer.

For bad block check, maximum two bytes are required so instead of
copying the complete bytes in step 2, only those bbm_size bytes
can be copied.

This patch does minor code reorganization for the same. After
this, copy_last_cw function won’t be required.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

 NEW CHANGE

 drivers/mtd/nand/raw/qcom_nandc.c | 66 +++++++++++++++------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 17b7f3af..10bdc6c 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1771,41 +1771,6 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	return parse_read_errors(host, data_buf_start, oob_buf_start);
 }
 
-/*
- * a helper that copies the last step/codeword of a page (containing free oob)
- * into our local buffer
- */
-static int copy_last_cw(struct qcom_nand_host *host, int page)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int size;
-	int ret;
-
-	clear_read_regs(nandc);
-
-	size = host->use_ecc ? host->cw_data : host->cw_size;
-
-	/* prepare a clean read buffer */
-	memset(nandc->data_buffer, 0xff, size);
-
-	set_address(host, host->cw_size * (ecc->steps - 1), page);
-	update_rw_regs(host, 1, true);
-
-	config_nand_single_cw_page_read(nandc);
-
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
-
-	ret = submit_descs(nandc);
-	if (ret)
-		dev_err(nandc->dev, "failed to copy last codeword\n");
-
-	free_descs(nandc);
-
-	return ret;
-}
-
 /* implements ecc->read_page() */
 static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
@@ -2121,6 +2086,7 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret, bbpos, bad = 0;
 	u32 flash_status;
+	u8 *bbm_bytes_buf = chip->data_buf;
 
 	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
 
@@ -2131,11 +2097,31 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	 * that contains the BBM
 	 */
 	host->use_ecc = false;
+	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);
 
 	clear_bam_transaction(nandc);
-	ret = copy_last_cw(host, page);
-	if (ret)
+	clear_read_regs(nandc);
+
+	set_address(host, host->cw_size * (ecc->steps - 1), page);
+	update_rw_regs(host, 1, true);
+
+	/*
+	 * The last codeword data will be copied from NAND device to NAND
+	 * controller internal HW buffer. Copy only required BBM size bytes
+	 * from this HW buffer to bbm_bytes_buf which is present at
+	 * bbpos offset.
+	 */
+	nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
+	config_nand_single_cw_page_read(nandc);
+	read_data_dma(nandc, FLASH_BUF_ACC + bbpos, bbm_bytes_buf,
+		      host->bbm_size, 0);
+
+	ret = submit_descs(nandc);
+	free_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failed to copy bad block bytes\n");
 		goto err;
+	}
 
 	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
 
@@ -2144,12 +2130,10 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 		goto err;
 	}
 
-	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);
-
-	bad = nandc->data_buffer[bbpos] != 0xff;
+	bad = bbm_bytes_buf[0] != 0xff;
 
 	if (chip->options & NAND_BUSWIDTH_16)
-		bad = bad || (nandc->data_buffer[bbpos + 1] != 0xff);
+		bad = bad || (bbm_bytes_buf[1] != 0xff);
 err:
 	return bad;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
