Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeECMWF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:22:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeECMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B38B760591
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
Subject: [PATCH v2 14/14] mtd: rawnand: qcom: erased page bitflips detection
Date: Thu,  3 May 2018 17:50:41 +0530
Message-Id: <1525350041-22995-15-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAND parts can have bitflips in an erased page due to the
process technology used. In this case, qpic nand controller
is not able to identify that page as an erased page.
Currently the driver calls nand_check_erased_ecc_chunk for
identifying the erased pages but this won’t work always since the
checking is being with ECC engine returned data. In case of
bitflips, the ECC engine tries to correct the data and then it
generates the uncorrectable error. Now, this data is not equal to
original raw data. For erased CW identification, the raw data
should be read again from NAND device and this
nand_check_erased_ecc_chunk function should be called for raw
data only.

Now following logic is being added to identify the erased
codeword bitflips.

1. In most of the case, not all the codewords will have bitflips
   and only single CW will have bitflips. So, there is no need to
   read the complete raw page data. The NAND raw read can be
   scheduled for any CW in page. The NAND controller works on CW
   basis and it will update the status register after each CW read.
   Maintain the bitmask for the CW which generated the uncorrectable
   error.
2. Schedule the raw flash read from NAND flash device to
   NAND controller buffer for all these CWs between first and last
   uncorrectable errors CWs. Copy the content from NAND controller
   internal HW buffer to actual data buffer only for the uncorrectable
   errors CWs so that other CW data content won’t be affected, and
   unnecessary data copy can be avoided.
3. Both DATA and OOB need to be checked for number of 0. The
   top-level API can be called with only data buf or oob buf so use
   chip->databuf if data buf is null and chip->oob_poi if
   oob buf is null for copying the raw bytes temporarily.
4. For each CW, check the number of 0 in cw_data and usable
   oob bytes, The bbm and spare (unused) bytes bit flip won’t
   affect the ECC so don’t check the number of bitflips in this area.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

 1. Minor change in commit message
 2. invalidate pagebuf if databuf or oob_poi is used

 drivers/mtd/nand/raw/qcom_nandc.c | 135 +++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5148b49..d63ea92 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1711,20 +1711,103 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 }
 
 /*
+ * Bitflips can happen in erased codewords also so this function counts the
+ * number of 0 in each CW for which ECC engine returns the uncorrectable
+ * error. The page will be assumed as erased if this count is less than or
+ * equal to the ecc->strength for each CW.
+ *
+ * 1. Both DATA and OOB need to be checked for number of 0. The
+ *    top-level API can be called with only data buf or oob buf so use
+ *    chip->data_buf if data buf is null and chip->oob_poi if oob buf
+ *    is null for copying the raw bytes.
+ * 2. Perform raw read for all the CW which has uncorrectable errors.
+ * 3. For each CW, check the number of 0 in cw_data and usable oob bytes.
+ *    The bbm and spare bytes bit flip won’t affect the ECC so don’t check
+ *    the number of bitflips in this area.
+ */
+static int
+check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
+		      u8 *oob_buf, unsigned long uncorrectable_err_cws,
+		      int page, unsigned int max_bitflips)
+{
+	struct nand_chip *chip = &host->chip;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int i, start_step, last_step, ret = 0;
+
+	start_step = ffs(uncorrectable_err_cws) - 1;
+	last_step = fls(uncorrectable_err_cws);
+
+	if (!data_buf) {
+		data_buf = chip->data_buf;
+		chip->pagebuf = -1;
+	}
+
+	if (!oob_buf) {
+		oob_buf = chip->oob_poi;
+		chip->pagebuf = -1;
+	}
+
+	data_buf += start_step * host->cw_data;
+	oob_buf += start_step * ecc->bytes;
+
+	clear_read_regs(nandc);
+	nandc_read_page_raw(mtd, chip, data_buf, oob_buf, page,
+			    uncorrectable_err_cws);
+
+	for (i = start_step; i < last_step; i++) {
+		int data_size, oob_size;
+
+		if (i == (ecc->steps - 1)) {
+			data_size = ecc->size - ((ecc->steps - 1) << 2);
+			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw;
+		} else {
+			data_size = host->cw_data;
+			oob_size = host->ecc_bytes_hw;
+		}
+
+		if (uncorrectable_err_cws & BIT(i)) {
+			/*
+			 * make sure it isn't an erased page reported
+			 * as not-erased by HW because of a few bitflips
+			 */
+			ret = nand_check_erased_ecc_chunk(data_buf,
+				data_size, oob_buf + host->bbm_size,
+				oob_size, NULL,
+				0, ecc->strength);
+			if (ret < 0) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += ret;
+				max_bitflips =
+					max_t(unsigned int, max_bitflips, ret);
+			}
+		}
+
+		data_buf += data_size;
+		oob_buf += ecc->bytes;
+	}
+
+	return max_bitflips;
+}
+
+/*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
  */
 static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
-			     u8 *oob_buf)
+			     u8 *oob_buf, int page)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	unsigned int max_bitflips = 0;
+	unsigned int max_bitflips = 0, uncorrectable_err_cws = 0;
 	struct read_stats *buf;
-	bool flash_op_err = false;
+	bool flash_op_err = false, erased;
 	int i;
+	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
 	nandc_read_buffer_sync(nandc, true);
@@ -1754,10 +1837,6 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 		 *    codeword detection check will be done.
 		 */
 		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
-			bool erased;
-			int ret, ecclen, extraooblen;
-			void *eccbuf;
-
 			/*
 			 * For BCH ECC, ignore erased codeword errors, if
 			 * ERASED_CW bits are set.
@@ -1778,31 +1857,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 				erased = false;
 			}
 
-			if (erased) {
-				data_buf += data_len;
-				if (oob_buf)
-					oob_buf += oob_len + ecc->bytes;
-				continue;
-			}
-
-			eccbuf = oob_buf ? oob_buf + oob_len : NULL;
-			ecclen = oob_buf ? host->ecc_bytes_hw : 0;
-			extraooblen = oob_buf ? oob_len : 0;
-
-			/*
-			 * make sure it isn't an erased page reported
-			 * as not-erased by HW because of a few bitflips
-			 */
-			ret = nand_check_erased_ecc_chunk(data_buf,
-				data_len, eccbuf, ecclen, oob_buf,
-				extraooblen, ecc->strength);
-			if (ret < 0) {
-				mtd->ecc_stats.failed++;
-			} else {
-				mtd->ecc_stats.corrected += ret;
-				max_bitflips =
-					max_t(unsigned int, max_bitflips, ret);
-			}
+			if (!erased)
+				uncorrectable_err_cws |= BIT(i);
 		/*
 		 * Check if MPU or any other operational error (timeout,
 		 * device failure, etc.) happened for this codeword and
@@ -1832,7 +1888,12 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	if (flash_op_err)
 		return -EIO;
 
-	return max_bitflips;
+	if (!uncorrectable_err_cws)
+		return max_bitflips;
+
+	return check_for_erased_page(host, data_buf_start, oob_buf_start,
+				     uncorrectable_err_cws, page,
+				     max_bitflips);
 }
 
 /*
@@ -1840,7 +1901,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
  * ecc->read_oob()
  */
 static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
-			 u8 *oob_buf)
+			 u8 *oob_buf, int page)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
@@ -1913,7 +1974,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		return ret;
 	}
 
-	return parse_read_errors(host, data_buf_start, oob_buf_start);
+	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
 }
 
 /* implements ecc->read_page() */
@@ -1930,7 +1991,7 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	clear_bam_transaction(nandc);
 
-	return read_page_ecc(host, data_buf, oob_buf);
+	return read_page_ecc(host, data_buf, oob_buf, page);
 }
 
 /* implements ecc->read_page_raw() */
@@ -1957,7 +2018,7 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true);
 
-	return read_page_ecc(host, NULL, chip->oob_poi);
+	return read_page_ecc(host, NULL, chip->oob_poi, page);
 }
 
 /* implements ecc->write_page() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
