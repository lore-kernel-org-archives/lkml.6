Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967095AbeEYMW7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:22:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967001AbeEYMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:22:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F85560117
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
Subject: [PATCH v3 11/16] mtd: rawnand: qcom: modify write_oob to remove read codeword part
Date: Fri, 25 May 2018 17:51:39 +0530
Message-Id: <1527250904-21988-12-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND controller layout protects available OOB data bytes with
ECC also so when ecc->write_oob() is being called then it
can't update just OOB bytes. Currently, it first reads the last
codeword which includes old OOB bytes. Then it updates the old OOB
bytes with new ones and then again writes the codeword back.
The reading codeword is unnecessary since user is responsible to
have these bytes cleared to 0xFF.

This patch removes the read part and updates the OOB bytes with
data area padded with OxFF.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v2:

  1. Changed commit message and comments slightly
  2. Changed host->use_ecc assignment place

* Changes from v1:
  NEW CHANGE

 drivers/mtd/nand/raw/qcom_nandc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index e4b87b7..e02d752 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2064,11 +2064,9 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
 /*
  * implements ecc->write_oob()
  *
- * the NAND controller cannot write only data or only oob within a codeword,
- * since ecc is calculated for the combined codeword. we first copy the
- * entire contents for the last codeword(data + oob), replace the old oob
- * with the new one in chip->oob_poi, and then write the entire codeword.
- * this read-copy-write operation results in a slight performance loss.
+ * the NAND controller cannot write only data or only OOB within a codeword
+ * since ECC is calculated for the combined codeword. So update the OOB from
+ * chip->oob_poi, and pad the data area with OxFF before writing.
  */
 static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
@@ -2081,19 +2079,13 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	int ret;
 
 	host->use_ecc = true;
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
 
+	memset(nandc->data_buffer, 0xff, host->cw_data);
 	/* override new oob content to last codeword */
 	mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size, oob,
 				    0, mtd->oobavail);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
