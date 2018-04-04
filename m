Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeDDMnY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:43:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDDMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:43:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2294D6055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 6/9] mtd: nand: qcom: support for checking read errors for last codeword
Date: Wed,  4 Apr 2018 18:12:22 +0530
Message-Id: <1522845745-6624-7-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add boolean function argument in parse_read_errors to identify
whether the read error has been called for complete page read or
only last codeword read. This will help in subsequent patches to
detect ECC errors in case of last codeword read.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/qcom_nandc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index ba43752..dce97e8 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -1570,7 +1570,7 @@ struct read_stats {
  * errors. this is equivalent to what 'ecc->correct()' would do.
  */
 static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
-			     u8 *oob_buf)
+			     u8 *oob_buf, bool last_cw)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
@@ -1579,12 +1579,12 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	unsigned int max_bitflips = 0;
 	struct read_stats *buf;
 	bool flash_op_err = false;
-	int i;
+	int i, cw_cnt = last_cw ? 1 : ecc->steps;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
 	nandc_read_buffer_sync(nandc, true);
 
-	for (i = 0; i < ecc->steps; i++, buf++) {
+	for (i = 0; i < cw_cnt; i++, buf++) {
 		u32 flash, buffer, erased_cw;
 		int data_len, oob_len;
 
@@ -1743,7 +1743,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	free_descs(nandc);
 
 	if (!ret)
-		ret = parse_read_errors(host, data_buf_start, oob_buf_start);
+		ret = parse_read_errors(host, data_buf_start, oob_buf_start,
+					false);
 
 	return ret;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
