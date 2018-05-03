Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeECMVc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeECMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7C1B60807
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
Subject: [PATCH v2 07/14] mtd: rawnand: qcom: fix null pointer access for erased page detection
Date: Thu,  3 May 2018 17:50:34 +0530
Message-Id: <1525350041-22995-8-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_read_errors can be called with only oob_buf in which case
data_buf will be NULL.  If data_buf is NULL, then don’t
treat this page as completely erased in case of ECC uncorrectable
error for RS ECC. For BCH ECC, the controller itself tells
regarding erased page in status register.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

  1. Added more detail in commit message
  2. Added comment before each if/else

 drivers/mtd/nand/raw/qcom_nandc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index e6a21598..fa38142 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1613,13 +1613,24 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			int ret, ecclen, extraooblen;
 			void *eccbuf;
 
-			/* ignore erased codeword errors */
+			/*
+			 * For BCH ECC, ignore erased codeword errors, if
+			 * ERASED_CW bits are set.
+			 */
 			if (host->bch_enabled) {
 				erased = (erased_cw & ERASED_CW) == ERASED_CW ?
 					 true : false;
-			} else {
+			/*
+			 * For RS ECC, HW reports the erased CW by placing
+			 * special characters at certain offsets in the buffer.
+			 * These special characters will be valid only if
+			 * complete page is read i.e. data_buf is not NULL.
+			 */
+			} else if (data_buf) {
 				erased = erased_chunk_check_and_fixup(data_buf,
 								      data_len);
+			} else {
+				erased = false;
 			}
 
 			if (erased) {
@@ -1667,7 +1678,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			max_bitflips = max(max_bitflips, stat);
 		}
 
-		data_buf += data_len;
+		if (data_buf)
+			data_buf += data_len;
 		if (oob_buf)
 			oob_buf += oob_len + ecc->bytes;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
