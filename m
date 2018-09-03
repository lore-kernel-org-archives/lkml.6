Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A5F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeICWB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:01:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeICWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:01:55 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82B1FBAE;
        Mon,  3 Sep 2018 17:40:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.18 114/123] mtd: rawnand: qcom: wait for desc completion in all BAM channels
Date:   Mon,  3 Sep 2018 18:57:38 +0200
Message-Id: <20180903165724.327444397@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Sahu <absahu@codeaurora.org>

commit 6f20070d51a20e489ef117603210264c6bcde8a5 upstream.

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
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/qcom_nandc.c |   53 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -213,6 +213,8 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_
 #define QPIC_PER_CW_CMD_SGL		32
 #define QPIC_PER_CW_DATA_SGL		8
 
+#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
+
 /*
  * Flags used in DMA descriptor preparation helper functions
  * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
@@ -245,6 +247,11 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_
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
@@ -504,6 +515,8 @@ alloc_bam_transaction(struct qcom_nand_c
 
 	bam_txn->data_sgl = bam_txn_buf;
 
+	init_completion(&bam_txn->txn_done);
+
 	return bam_txn;
 }
 
@@ -523,11 +536,33 @@ static void clear_bam_transaction(struct
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
@@ -756,6 +791,12 @@ static int prepare_bam_async_desc(struct
 
 	desc->dma_desc = dma_desc;
 
+	/* update last data/command descriptor */
+	if (chan == nandc->cmd_chan)
+		bam_txn->last_cmd_desc = dma_desc;
+	else
+		bam_txn->last_data_desc = dma_desc;
+
 	list_add_tail(&desc->node, &nandc->desc_list);
 
 	return 0;
@@ -1273,10 +1314,20 @@ static int submit_descs(struct qcom_nand
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


