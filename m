Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967116AbeEYMXF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:23:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967001AbeEYMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:23:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C375860C54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v3 14/16] mtd: rawnand: qcom: check for operation errors in case of raw read
Date: Fri, 25 May 2018 17:51:42 +0530
Message-Id: <1527250904-21988-15-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no error checking for raw read. For raw
reads, there won’t be any ECC failure but the operational
failures are possible, so schedule the NAND_FLASH_STATUS read
after each codeword.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v2:
  NONE

* Changes from v1:
 1. Removed the code for copy_last_cw.

 drivers/mtd/nand/raw/qcom_nandc.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index f72bc8a..87f900e 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1096,7 +1096,8 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
  * Helper to prepare DMA descriptors for configuring registers
  * before reading each codeword in NAND page.
  */
-static void config_nand_cw_read(struct qcom_nand_controller *nandc)
+static void
+config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
 {
 	if (nandc->props->is_bam)
 		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
@@ -1105,19 +1106,25 @@ static void config_nand_cw_read(struct qcom_nand_controller *nandc)
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
-	read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-		     NAND_BAM_NEXT_SGL);
+	if (use_ecc) {
+		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
+		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+			     NAND_BAM_NEXT_SGL);
+	} else {
+		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	}
 }
 
 /*
  * Helper to prepare dma descriptors to configure registers needed for reading a
  * single codeword in page
  */
-static void config_nand_single_cw_page_read(struct qcom_nand_controller *nandc)
+static void
+config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
+				bool use_ecc)
 {
 	config_nand_page_read(nandc);
-	config_nand_cw_read(nandc);
+	config_nand_cw_read(nandc, use_ecc);
 }
 
 /*
@@ -1198,7 +1205,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
-	config_nand_single_cw_page_read(nandc);
+	config_nand_single_cw_page_read(nandc, false);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
 		      nandc->buf_count, 0);
@@ -1563,6 +1570,23 @@ struct read_stats {
 	__le32 erased_cw;
 };
 
+/* reads back FLASH_STATUS register set by the controller */
+static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
+{
+	struct nand_chip *chip = &host->chip;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	int i;
+
+	for (i = 0; i < cw_cnt; i++) {
+		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
+
+		if (flash & (FS_OP_ERR | FS_MPU_ERR))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
@@ -1729,7 +1753,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			}
 		}
 
-		config_nand_cw_read(nandc);
+		config_nand_cw_read(nandc, true);
 
 		if (data_buf)
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
@@ -1839,7 +1863,7 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
 		}
 
-		config_nand_cw_read(nandc);
+		config_nand_cw_read(nandc, false);
 
 		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 		reg_off += data_size1;
@@ -1858,12 +1882,13 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 	}
 
 	ret = submit_descs(nandc);
-	if (ret)
+	free_descs(nandc);
+	if (ret) {
 		dev_err(nandc->dev, "failure to read raw page\n");
+		return ret;
+	}
 
-	free_descs(nandc);
-
-	return ret;
+	return check_flash_errors(host, ecc->steps);
 }
 
 /* implements ecc->read_oob() */
@@ -2082,7 +2107,6 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret, bbpos, bad = 0;
-	u32 flash_status;
 	u8 *bbm_bytes_buf = chip->data_buf;
 
 	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
@@ -2109,7 +2133,7 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	 * bbpos offset.
 	 */
 	nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
-	config_nand_single_cw_page_read(nandc);
+	config_nand_single_cw_page_read(nandc, host->use_ecc);
 	read_data_dma(nandc, FLASH_BUF_ACC + bbpos, bbm_bytes_buf,
 		      host->bbm_size, 0);
 
@@ -2120,9 +2144,7 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 		goto err;
 	}
 
-	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
-
-	if (flash_status & (FS_OP_ERR | FS_MPU_ERR)) {
+	if (check_flash_errors(host, 1)) {
 		dev_warn(nandc->dev, "error when trying to read BBM\n");
 		goto err;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
