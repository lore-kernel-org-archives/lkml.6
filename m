Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeECMV1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeECMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27AAF607CF
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
Subject: [PATCH v2 06/14] mtd: rawnand: qcom: erased page detection for uncorrectable errors only
Date: Thu,  3 May 2018 17:50:33 +0530
Message-Id: <1525350041-22995-7-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following is the flow in the HW if controller tries to read erased
page

1. First ECC uncorrectable error will be generated from ECC engine
   since ECC engine first calculates the ECC with all 0xff and match
   the calculated ECC with ECC code in OOB (which is again all 0xff).
2. After getting ECC error, erased CW detection logic will be
   applied which is different for BCH and RS ECC
    a. For BCH, HW checks if all the bytes in page are 0xff and then
       it updates the status in separate register
       NAND_ERASED_CW_DETECT_STATUS.
    b. For RS ECC, the HW reports the same error when reading an
       erased CW, but it notifies that it is an erased CW by
       placing special characters at certain offsets in the
       buffer.

So the erased CW detect status should be checked only if ECC engine
generated the uncorrectable error.

Currently for all other operational errors also (like TIMEOUT, MPU
errors, etc.), the erased CW detect logic is being applied so fix this
and return EIO for other operational errors.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

  1. Added more detail in commit message
  2. Added comment before each if/else
  3. Removed redundant check for BS_UNCORRECTABLE_BIT

 drivers/mtd/nand/raw/qcom_nandc.c | 65 ++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 3d1ff54..e6a21598 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1578,6 +1578,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	struct read_stats *buf;
+	bool flash_op_err = false;
 	int i;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
@@ -1599,8 +1600,18 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 		buffer = le32_to_cpu(buf->buffer);
 		erased_cw = le32_to_cpu(buf->erased_cw);
 
-		if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
+		/*
+		 * Check ECC failure for each codeword. ECC failure can
+		 * happen in either of the following conditions
+		 * 1. If number of bitflips are greater than ECC engine
+		 *    capability.
+		 * 2. If this codeword contains all 0xff for which erased
+		 *    codeword detection check will be done.
+		 */
+		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
 			bool erased;
+			int ret, ecclen, extraooblen;
+			void *eccbuf;
 
 			/* ignore erased codeword errors */
 			if (host->bch_enabled) {
@@ -1618,29 +1629,36 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 				continue;
 			}
 
-			if (buffer & BS_UNCORRECTABLE_BIT) {
-				int ret, ecclen, extraooblen;
-				void *eccbuf;
+			eccbuf = oob_buf ? oob_buf + oob_len : NULL;
+			ecclen = oob_buf ? host->ecc_bytes_hw : 0;
+			extraooblen = oob_buf ? oob_len : 0;
 
-				eccbuf = oob_buf ? oob_buf + oob_len : NULL;
-				ecclen = oob_buf ? host->ecc_bytes_hw : 0;
-				extraooblen = oob_buf ? oob_len : 0;
-
-				/*
-				 * make sure it isn't an erased page reported
-				 * as not-erased by HW because of a few bitflips
-				 */
-				ret = nand_check_erased_ecc_chunk(data_buf,
-					data_len, eccbuf, ecclen, oob_buf,
-					extraooblen, ecc->strength);
-				if (ret < 0) {
-					mtd->ecc_stats.failed++;
-				} else {
-					mtd->ecc_stats.corrected += ret;
-					max_bitflips =
-						max_t(unsigned int, max_bitflips, ret);
-				}
+			/*
+			 * make sure it isn't an erased page reported
+			 * as not-erased by HW because of a few bitflips
+			 */
+			ret = nand_check_erased_ecc_chunk(data_buf,
+				data_len, eccbuf, ecclen, oob_buf,
+				extraooblen, ecc->strength);
+			if (ret < 0) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += ret;
+				max_bitflips =
+					max_t(unsigned int, max_bitflips, ret);
 			}
+		/*
+		 * Check if MPU or any other operational error (timeout,
+		 * device failure, etc.) happened for this codeword and
+		 * make flash_op_err true. If flash_op_err is set, then
+		 * EIO will be returned for page read.
+		 */
+		} else if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
+			flash_op_err = true;
+		/*
+		 * No ECC or operational errors happened. Check the number of
+		 * bits corrected and update the ecc_stats.corrected.
+		 */
 		} else {
 			unsigned int stat;
 
@@ -1654,6 +1672,9 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_len + ecc->bytes;
 	}
 
+	if (flash_op_err)
+		return -EIO;
+
 	return max_bitflips;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
