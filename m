Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeBCH7D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:59:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeBCH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:58:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A3B66079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 02/12] i2c: qup: minor code reorganization for use_dma
Date: Sat,  3 Feb 2018 13:28:07 +0530
Message-Id: <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Assigns use_dma in qup_dev structure itself which will
   help in subsequent patches to determine the mode in IRQ handler.
2. Does minor code reorganization for loops to reduce the
   unnecessary comparison and assignment.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 9faa26c41a..c68f433 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -190,6 +190,8 @@ struct qup_i2c_dev {
 
 	/* dma parameters */
 	bool			is_dma;
+	/* To check if the current transfer is using DMA */
+	bool			use_dma;
 	struct			dma_pool *dpool;
 	struct			qup_i2c_tag start_tag;
 	struct			qup_i2c_bam brx;
@@ -1297,7 +1299,7 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			   int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, len, idx = 0, use_dma = 0;
+	int ret, len, idx = 0;
 
 	qup->bus_err = 0;
 	qup->qup_err = 0;
@@ -1326,13 +1328,12 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			len = (msgs[idx].len > qup->out_fifo_sz) ||
 			      (msgs[idx].len > qup->in_fifo_sz);
 
-			if ((!is_vmalloc_addr(msgs[idx].buf)) && len) {
-				use_dma = 1;
-			 } else {
-				use_dma = 0;
+			if (is_vmalloc_addr(msgs[idx].buf) || !len)
 				break;
-			}
 		}
+
+		if (idx == num)
+			qup->use_dma = true;
 	}
 
 	idx = 0;
@@ -1356,15 +1357,17 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 
 		reinit_completion(&qup->xfer);
 
-		if (use_dma) {
+		if (qup->use_dma) {
 			ret = qup_i2c_bam_xfer(adap, &msgs[idx], num);
+			qup->use_dma = false;
+			break;
 		} else {
 			if (msgs[idx].flags & I2C_M_RD)
 				ret = qup_i2c_read_one_v2(qup, &msgs[idx]);
 			else
 				ret = qup_i2c_write_one_v2(qup, &msgs[idx]);
 		}
-	} while ((idx++ < (num - 1)) && !use_dma && !ret);
+	} while ((idx++ < (num - 1)) && !ret);
 
 	if (!ret)
 		ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
