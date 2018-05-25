Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967192AbeEYMYr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:24:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966967AbeEYMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:22:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90D0160AFB
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
        Abhishek Sahu <absahu@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH v3 07/16] mtd: rawnand: qcom: wait for desc completion in all BAM channels
Date: Fri, 25 May 2018 17:51:35 +0530
Message-Id: <1527250904-21988-8-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BAM has 3 channels - tx, rx and command. command channel
is used for register read/writes, tx channel for data writes
and rx channel for data reads. Currently, the driver assumes the
transfer completion once it gets all the command descriptors
completed. Sometimes, there is race condition between data channel
(tx/rx) and command channel completion. In these cases,
the data present in buffer is not valid during small window
between command descriptor completion and data descriptor
completion.

This patch generates NAND transfer completion when both
(Data and Command) DMA channels have completed all its DMA
descriptors. It assigns completion callback in last
DMA descriptors of that channel and wait for completion.

Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v2:
  1. Changed commit message and comments slightly
  2. Renamed wait_second_completion from first_chan_done and set
     it before submit desc
  3. Mark for stable tree

* Changes from v1:
  NONE

 drivers/mtd/nand/raw/qcom_nandc.c | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 7377923..7f85ef8 100644
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
+ * @wait_second_completion - wait for second DMA desc completion before making
+ *			     the NAND transfer completion.
+ * @txn_done - completion for NAND transfer.
+ * @last_data_desc - last DMA desc in data channel (tx/rx).
+ * @last_cmd_desc - last DMA desc in command channel.
  */
 struct bam_transaction {
 	struct bam_cmd_element *bam_ce;
@@ -258,6 +265,10 @@ struct bam_transaction {
 	u32 tx_sgl_start;
 	u32 rx_sgl_pos;
 	u32 rx_sgl_start;
+	bool wait_second_completion;
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
 
@@ -523,11 +536,33 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
 	bam_txn->tx_sgl_start = 0;
 	bam_txn->rx_sgl_pos = 0;
 	bam_txn->rx_sgl_start = 0;
+	bam_txn->last_data_desc = NULL;
+	bam_txn->wait_second_completion = false;
 
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
+	 * If current transaction has data descriptors
+	 * (i.e. wait_second_completion is true), then set this to false
+	 * and wait for second DMA descriptor completion.
+	 */
+	if (bam_txn->wait_second_completion)
+		bam_txn->wait_second_completion = false;
+	else
+		complete(&bam_txn->txn_done);
 }
 
 static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
@@ -756,6 +791,12 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
 
 	desc->dma_desc = dma_desc;
 
+	/* update last data/command descriptor */
+	if (chan == nandc->cmd_chan)
+		bam_txn->last_cmd_desc = dma_desc;
+	else
+		bam_txn->last_data_desc = dma_desc;
+
 	list_add_tail(&desc->node, &nandc->desc_list);
 
 	return 0;
@@ -1273,10 +1314,20 @@ static int submit_descs(struct qcom_nand_controller *nandc)
 		cookie = dmaengine_submit(desc->dma_desc);
 
 	if (nandc->props->is_bam) {
+		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback_param = bam_txn;
+		if (bam_txn->last_data_desc) {
+			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
+			bam_txn->last_data_desc->callback_param = bam_txn;
+			bam_txn->wait_second_completion = true;
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
