Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeECMVk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeECMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F377160591
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
Subject: [PATCH v2 09/14] mtd: rawnand: qcom: modify write_oob to remove read codeword part
Date: Thu,  3 May 2018 17:50:36 +0530
Message-Id: <1525350041-22995-10-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND layout protect available OOB data bytes with ECC also so
when ecc->write_oob (qcom_nandc_write_oob) is being called then it
can't update just OOB bytes. Currently, it first reads the last
codeword which includes old OOB bytes. Then it updates the old OOB
bytes with new one and then again writes the codeword back.
The reading codeword is unnecessary since all the other bytes
should be 0xff only.

This patch removes the read part and updates the oob bytes with
all other data bytes as 0xff.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

 NEW CHANGE

 drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 61d0e7d..f85d8ab 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2067,10 +2067,9 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
  * implements ecc->write_oob()
  *
  * the NAND controller cannot write only data or only oob within a codeword,
- * since ecc is calculated for the combined codeword. we first copy the
- * entire contents for the last codeword(data + oob), replace the old oob
- * with the new one in chip->oob_poi, and then write the entire codeword.
- * this read-copy-write operation results in a slight performance loss.
+ * since ecc is calculated for the combined codeword. So make all the data
+ * bytes as 0xff and update the oob from chip->oob_poi, and then write
+ * the entire codeword again.
  */
 static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
@@ -2082,20 +2081,14 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	int data_size, oob_size;
 	int ret;
 
-	host->use_ecc = true;
-
-	clear_bam_transaction(nandc);
-	ret = copy_last_cw(host, page);
-	if (ret)
-		return ret;
-
-	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
 	oob_size = mtd->oobavail;
+	host->use_ecc = true;
 
+	memset(nandc->data_buffer, 0xff, host->cw_data);
 	/* override new oob content to last codeword */
 	mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size, oob,
 				    0, mtd->oobavail);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
