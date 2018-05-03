Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeECMYy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:24:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeECMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E32D60807
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
Subject: [PATCH v2 05/14] mtd: rawnand: qcom: wait for desc completion in all BAM channels
Date: Thu,  3 May 2018 17:50:32 +0530
Message-Id: <1525350041-22995-6-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BAM has 3 channels - tx, rx and command. command channel
is used for register read/writes, tx channel for data writes
and rx channel for data reads. Currently, the driver assumes the
transfer completion once it gets all the command descriptor
completed. Sometimes, there is race condition in data channel
(tx/rx) and command channel completion and in these cases,
the data in buffer is not valid during the small window between
command descriptor completion and data descriptor completion.

Now, the changes have been made to assign the callback for
channel's final descriptor. The DMA will generate the callback
when all the descriptors have completed in that channel.
The NAND transfer will be completed only when all required
DMA channels have generated the completion callback.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

  NONE

  1. Removed the custom logic and used the helper fuction.
 drivers/mtd/nand/raw/qcom_nandc.c | 55 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a8d71ce..3d1ff54 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -213,6 +213,8 @@
 #define QPIC_PER_CW_CMD_SGL		32
 #define QPIC_PER_CW_DATA_SGL		8
 
+#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
+
 /*
  * Flags used in DMA descriptor preparation helper functions
  * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
@@ -245,6 +247,11 @@
  * @tx_sgl_start - start index in data sgl for tx.
  * @rx_sgl_pos - current index in data sgl for rx.
  * @rx_sgl_start - start index in data sgl for rx.
+ * @first_chan_done - if current transfer already has got first channel
+ *		      DMA desc completion.
+ * @txn_done - completion for nand transfer.
+ * @last_data_desc - last DMA desc in data channel (tx/rx).
+ * @last_cmd_desc - last DMA desc in command channel.
  */
 struct bam_transaction {
 	struct bam_cmd_element *bam_ce;
@@ -258,6 +265,10 @@ struct bam_transaction {
 	u32 tx_sgl_start;
 	u32 rx_sgl_pos;
 	u32 rx_sgl_start;
+	bool first_chan_done;
+	struct completion txn_done;
+	struct dma_async_tx_descriptor *last_data_desc;
+	struct dma_async_tx_descriptor *last_cmd_desc;
 };
 
 /*
@@ -504,6 +515,8 @@ static void free_bam_transaction(struct qcom_nand_controller *nandc)
 
 	bam_txn->data_sgl = bam_txn_buf;
 
+	init_completion(&bam_txn->txn_done);
+
 	return bam_txn;
 }
 
@@ -523,11 +536,36 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
 	bam_txn->tx_sgl_start = 0;
 	bam_txn->rx_sgl_pos = 0;
 	bam_txn->rx_sgl_start = 0;
+	bam_txn->last_data_desc = NULL;
+	bam_txn->first_chan_done = false;
 
 	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
 		      QPIC_PER_CW_CMD_SGL);
 	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
 		      QPIC_PER_CW_DATA_SGL);
+
+	reinit_completion(&bam_txn->txn_done);
+}
+
+/* Callback for DMA descriptor completion */
+static void qpic_bam_dma_done(void *data)
+{
+	struct bam_transaction *bam_txn = data;
+
+	/*
+	 * In case of data transfer with NAND, 2 callbacks will be generated.
+	 * One for command channel and another one for data channel.
+	 * If current transaction has data descriptors then check if its
+	 * already got one DMA channel completion callback. In this case
+	 * make the NAND transfer complete otherwise mark first_chan_done true
+	 * and wait for next channel DMA completion callback.
+	 */
+	if (bam_txn->last_data_desc && !bam_txn->first_chan_done) {
+		bam_txn->first_chan_done = true;
+		return;
+	}
+
+	complete(&bam_txn->txn_done);
 }
 
 static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
@@ -756,6 +794,12 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
 
 	desc->dma_desc = dma_desc;
 
+	/* update last data/command descriptor */
+	if (chan == nandc->cmd_chan)
+		bam_txn->last_cmd_desc = dma_desc;
+	else
+		bam_txn->last_data_desc = dma_desc;
+
 	list_add_tail(&desc->node, &nandc->desc_list);
 
 	return 0;
@@ -1273,10 +1317,19 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		cookie = dmaengine_submit(desc->dma_desc);
 
 	if (nandc->props->is_bam) {
+		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback_param = bam_txn;
+		if (bam_txn->last_data_desc) {
+			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
+			bam_txn->last_data_desc->callback_param = bam_txn;
+		}
+
 		dma_async_issue_pending(nandc->tx_chan);
 		dma_async_issue_pending(nandc->rx_chan);
+		dma_async_issue_pending(nandc->cmd_chan);
 
-		if (dma_sync_wait(nandc->cmd_chan, cookie) != DMA_COMPLETE)
+		if (!wait_for_completion_timeout(&bam_txn->txn_done,
+						 QPIC_NAND_COMPLETION_TIMEOUT))
 			return -ETIMEDOUT;
 	} else {
 		if (dma_sync_wait(nandc->chan, cookie) != DMA_COMPLETE)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
