Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeCLNPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:15:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeCLNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:15:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 191E060807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 04/13] i2c: qup: remove redundant variables for BAM SG count
Date: Mon, 12 Mar 2018 18:44:53 +0530
Message-Id: <1520860502-14886-5-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
be used for total number of SG entries. Since rx_buf and tx_buf
give the impression that it is buffer instead of count so rename
it to tx_cnt and rx_cnt for giving it more meaningful variable
name.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Austin Christ <austinwc@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---

* Changes from v1:

1. Changed rx_buf/tx_buf to tx_cnt/rx_cnt
2. Modified commit message for the same

 drivers/i2c/busses/i2c-qup.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index f6ea074..d970458 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -683,8 +683,8 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 	struct dma_async_tx_descriptor *txd, *rxd = NULL;
 	int ret = 0, idx = 0, limit = QUP_READ_LIMIT;
 	dma_cookie_t cookie_rx, cookie_tx;
-	u32 rx_nents = 0, tx_nents = 0, len, blocks, rem;
-	u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
+	u32 len, blocks, rem;
+	u32 i, tlen, tx_len, tx_cnt = 0, rx_cnt = 0, off = 0;
 	u8 *tags;
 
 	while (idx < num) {
@@ -698,9 +698,6 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 		rem = msg->len - (blocks - 1) * limit;
 
 		if (msg->flags & I2C_M_RD) {
-			rx_nents += (blocks * 2) + 1;
-			tx_nents += 1;
-
 			while (qup->blk.pos < blocks) {
 				tlen = (i == (blocks - 1)) ? rem : limit;
 				tags = &qup->start_tag.start[off + len];
@@ -708,14 +705,14 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 				qup->blk.data_len -= tlen;
 
 				/* scratch buf to read the start and len tags */
-				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
+				ret = qup_sg_set_buf(&qup->brx.sg[rx_cnt++],
 						     &qup->brx.tag.start[0],
 						     2, qup, DMA_FROM_DEVICE);
 
 				if (ret)
 					return ret;
 
-				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
+				ret = qup_sg_set_buf(&qup->brx.sg[rx_cnt++],
 						     &msg->buf[limit * i],
 						     tlen, qup,
 						     DMA_FROM_DEVICE);
@@ -725,7 +722,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 				i++;
 				qup->blk.pos = i;
 			}
-			ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
+			ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++],
 					     &qup->start_tag.start[off],
 					     len, qup, DMA_TO_DEVICE);
 			if (ret)
@@ -733,28 +730,26 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 
 			off += len;
 			/* scratch buf to read the BAM EOT and FLUSH tags */
-			ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
+			ret = qup_sg_set_buf(&qup->brx.sg[rx_cnt++],
 					     &qup->brx.tag.start[0],
 					     2, qup, DMA_FROM_DEVICE);
 			if (ret)
 				return ret;
 		} else {
-			tx_nents += (blocks * 2);
-
 			while (qup->blk.pos < blocks) {
 				tlen = (i == (blocks - 1)) ? rem : limit;
 				tags = &qup->start_tag.start[off + tx_len];
 				len = qup_i2c_set_tags(tags, qup, msg, 1);
 				qup->blk.data_len -= tlen;
 
-				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
+				ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++],
 						     tags, len,
 						     qup, DMA_TO_DEVICE);
 				if (ret)
 					return ret;
 
 				tx_len += len;
-				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
+				ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++],
 						     &msg->buf[limit * i],
 						     tlen, qup, DMA_TO_DEVICE);
 				if (ret)
@@ -766,26 +761,25 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 
 			if (idx == (num - 1)) {
 				len = 1;
-				if (rx_nents) {
+				if (rx_cnt) {
 					qup->btx.tag.start[0] =
 							QUP_BAM_INPUT_EOT;
 					len++;
 				}
 				qup->btx.tag.start[len - 1] =
 							QUP_BAM_FLUSH_STOP;
-				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
+				ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++],
 						     &qup->btx.tag.start[0],
 						     len, qup, DMA_TO_DEVICE);
 				if (ret)
 					return ret;
-				tx_nents += 1;
 			}
 		}
 		idx++;
 		msg++;
 	}
 
-	txd = dmaengine_prep_slave_sg(qup->btx.dma, qup->btx.sg, tx_nents,
+	txd = dmaengine_prep_slave_sg(qup->btx.dma, qup->btx.sg, tx_cnt,
 				      DMA_MEM_TO_DEV,
 				      DMA_PREP_INTERRUPT | DMA_PREP_FENCE);
 	if (!txd) {
@@ -794,7 +788,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 		goto desc_err;
 	}
 
-	if (!rx_nents) {
+	if (!rx_cnt) {
 		txd->callback = qup_i2c_bam_cb;
 		txd->callback_param = qup;
 	}
@@ -807,9 +801,9 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 
 	dma_async_issue_pending(qup->btx.dma);
 
-	if (rx_nents) {
+	if (rx_cnt) {
 		rxd = dmaengine_prep_slave_sg(qup->brx.dma, qup->brx.sg,
-					      rx_nents, DMA_DEV_TO_MEM,
+					      rx_cnt, DMA_DEV_TO_MEM,
 					      DMA_PREP_INTERRUPT);
 		if (!rxd) {
 			dev_err(qup->dev, "failed to get rx desc\n");
@@ -844,7 +838,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 			goto desc_err;
 		}
 
-		if (rx_nents)
+		if (rx_cnt)
 			writel(QUP_BAM_INPUT_EOT,
 			       qup->base + QUP_OUT_FIFO_BASE);
 
@@ -862,10 +856,10 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 	}
 
 desc_err:
-	dma_unmap_sg(qup->dev, qup->btx.sg, tx_nents, DMA_TO_DEVICE);
+	dma_unmap_sg(qup->dev, qup->btx.sg, tx_cnt, DMA_TO_DEVICE);
 
-	if (rx_nents)
-		dma_unmap_sg(qup->dev, qup->brx.sg, rx_nents,
+	if (rx_cnt)
+		dma_unmap_sg(qup->dev, qup->brx.sg, rx_cnt,
 			     DMA_FROM_DEVICE);
 
 	return ret;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
