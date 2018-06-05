Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeFEGRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:17:43 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37248 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeFEGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:48 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 3/8] mailbox: ti-msgmgr: Change message count mask to be descriptor based
Date: Tue, 5 Jun 2018 01:16:24 -0500
Message-ID: <20180605061629.4759-4-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mask used to extract the message count to be descriptor based.

This is to support changes for count location for various SoC
solutions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 7221590c409c..2952339a8446 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -44,6 +44,7 @@ struct ti_msgmgr_valid_queue_desc {
  * @max_messages:	Number of messages
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
+ * @status_cnt_mask:	Mask for getting the status value
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
@@ -58,6 +59,7 @@ struct ti_msgmgr_desc {
 	u8 max_messages;
 	u8 data_first_reg;
 	u8 data_last_reg;
+	u32 status_cnt_mask;
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
@@ -116,20 +118,24 @@ struct ti_msgmgr_inst {
 
 /**
  * ti_msgmgr_queue_get_num_messages() - Get the number of pending messages
+ * @d:		Description of message manager
  * @qinst:	Queue instance for which we check the number of pending messages
  *
  * Return: number of messages pending in the queue (0 == no pending messages)
  */
-static inline int ti_msgmgr_queue_get_num_messages(struct ti_queue_inst *qinst)
+static inline int
+ti_msgmgr_queue_get_num_messages(const struct ti_msgmgr_desc *d,
+				 struct ti_queue_inst *qinst)
 {
 	u32 val;
+	u32 status_cnt_mask = d->status_cnt_mask;
 
 	/*
 	 * We cannot use relaxed operation here - update may happen
 	 * real-time.
 	 */
-	val = readl(qinst->queue_state) & Q_STATE_ENTRY_COUNT_MASK;
-	val >>= __ffs(Q_STATE_ENTRY_COUNT_MASK);
+	val = readl(qinst->queue_state) & status_cnt_mask;
+	val >>= __ffs(status_cnt_mask);
 
 	return val;
 }
@@ -167,8 +173,9 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 		return IRQ_NONE;
 	}
 
+	desc = inst->desc;
 	/* Do I actually have messages to read? */
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
 	if (!msg_count) {
 		/* Shared IRQ? */
 		dev_dbg(dev, "Spurious event - 0 pending data!\n");
@@ -181,7 +188,6 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 	 * of how many bytes I should be reading. Let the client figure this
 	 * out.. I just read the full message and pass it on..
 	 */
-	desc = inst->desc;
 	message.len = desc->max_message_size;
 	message.buf = (u8 *)qinst->rx_buff;
 
@@ -224,12 +230,14 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	return msg_count ? true : false;
 }
@@ -243,12 +251,14 @@ static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 static bool ti_msgmgr_last_tx_done(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (!qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	/* if we have any messages pending.. */
 	return msg_count ? false : true;
@@ -523,6 +533,7 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.max_messages = 128,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
+	.status_cnt_mask = Q_STATE_ENTRY_COUNT_MASK,
 	.tx_polled = false,
 	.valid_queues = k2g_valid_queues,
 	.num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
-- 
2.15.1
