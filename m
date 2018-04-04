Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeDDMnJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:43:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDDMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:43:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BED1260C65
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
Subject: [PATCH 4/9] mtd: nand: qcom: fix null pointer access for erased buffer detection
Date: Wed,  4 Apr 2018 18:12:20 +0530
Message-Id: <1522845745-6624-5-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_read_errors can be called with only oob buf also in which
case data_buf will be NULL.  If data_buf is NULL, then don’t
treat this page as completely erased in case of ECC uncorrectable
error.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/qcom_nandc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index 57c16a6..0ebcc55 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -1607,9 +1607,11 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			if (host->bch_enabled) {
 				erased = (erased_cw & ERASED_CW) == ERASED_CW ?
 					 true : false;
-			} else {
+			} else if (data_buf) {
 				erased = erased_chunk_check_and_fixup(data_buf,
 								      data_len);
+			} else {
+				erased = false;
 			}
 
 			if (erased) {
@@ -1652,7 +1654,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			max_bitflips = max(max_bitflips, stat);
 		}
 
-		data_buf += data_len;
+		if (data_buf)
+			data_buf += data_len;
 		if (oob_buf)
 			oob_buf += oob_len + ecc->bytes;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
