Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeFEGRG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:17:06 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:42693 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFEGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:17:02 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 6/8] mailbox: ti-msgmgr: Add support for Secure Proxy
Date: Tue, 5 Jun 2018 01:16:27 -0500
Message-ID: <20180605061629.4759-7-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure Proxy is another communication scheme in Texas Instrument's
devices intended to provide an unique communication path from various
processors in the System on Chip(SoC) to a central System Controller.

Secure proxy is, in effect, an evolution of current generation Message
Manager hardware block found in K2G devices. However the following
changes have taken place:

Secure Proxy instance exposes "threads" or "proxies" which is
primary representation of "a" communication channel. Each thread is
preconfigured by System controller configuration based on SoC usage
requirements. Secure proxy by itself represents a single "queue" of
communication but allows the proxies to be independently operated.

Each Secure proxy thread can uniquely have their own error and threshold
interrupts allowing for more fine control of IRQ handling.

Provide the driver support for Secure Proxy and thread instances.

NOTE: Secure proxy configuration is only done by System Controller,
hence these are assumed to be pre-configured instances.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 233 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 205 insertions(+), 28 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index a37d6a4b392f..3e30b80c6401 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -25,6 +25,17 @@
 #define Q_STATE_OFFSET(queue)			((queue) * 0x4)
 #define Q_STATE_ENTRY_COUNT_MASK		(0xFFF000)
 
+#define SPROXY_THREAD_OFFSET(tid) (0x1000 * (tid))
+#define SPROXY_THREAD_DATA_OFFSET(tid, reg) \
+	(SPROXY_THREAD_OFFSET(tid) + ((reg) * 0x4) + 0x4)
+
+#define SPROXY_THREAD_STATUS_OFFSET(tid) (SPROXY_THREAD_OFFSET(tid))
+
+#define SPROXY_THREAD_STATUS_COUNT_MASK (0xFF)
+
+#define SPROXY_THREAD_CTRL_OFFSET(tid) (0x1000 + SPROXY_THREAD_OFFSET(tid))
+#define SPROXY_THREAD_CTRL_DIR_MASK (0x1 << 31)
+
 /**
  * struct ti_msgmgr_valid_queue_desc - SoC valid queues meant for this processor
  * @queue_id:	Queue Number for this path
@@ -45,12 +56,15 @@ struct ti_msgmgr_valid_queue_desc {
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
  * @status_cnt_mask:	Mask for getting the status value
+ * @status_err_mask:	Mask for getting the error value, if applicable
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
  * @data_region_name:	Name of the proxy data region
  * @status_region_name:	Name of the proxy status region
+ * @ctrl_region_name:	Name of the proxy control region
  * @num_valid_queues:	Number of valid queues
+ * @is_sproxy:		Is this an Secure Proxy instance?
  *
  * This structure is used in of match data to describe how integration
  * for a specific compatible SoC is done.
@@ -62,12 +76,15 @@ struct ti_msgmgr_desc {
 	u8 data_first_reg;
 	u8 data_last_reg;
 	u32 status_cnt_mask;
+	u32 status_err_mask;
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
 	const char *data_region_name;
 	const char *status_region_name;
+	const char *ctrl_region_name;
 	int num_valid_queues;
+	bool is_sproxy;
 };
 
 /**
@@ -80,6 +97,7 @@ struct ti_msgmgr_desc {
  * @queue_buff_start: First register of Data Buffer
  * @queue_buff_end: Last (or confirmation) register of Data buffer
  * @queue_state: Queue status register
+ * @queue_ctrl: Queue Control register
  * @chan:	Mailbox channel
  * @rx_buff:	Receive buffer pointer allocated at probe, max_message_size
  */
@@ -92,6 +110,7 @@ struct ti_queue_inst {
 	void __iomem *queue_buff_start;
 	void __iomem *queue_buff_end;
 	void __iomem *queue_state;
+	void __iomem *queue_ctrl;
 	struct mbox_chan *chan;
 	u32 *rx_buff;
 };
@@ -102,6 +121,7 @@ struct ti_queue_inst {
  * @desc:	Description of the SoC integration
  * @queue_proxy_region:	Queue proxy region where queue buffers are located
  * @queue_state_debug_region:	Queue status register regions
+ * @queue_ctrl_region:	Queue Control register regions
  * @num_valid_queues:	Number of valid queues defined for the processor
  *		Note: other queues are probably reserved for other processors
  *		in the SoC.
@@ -114,6 +134,7 @@ struct ti_msgmgr_inst {
 	const struct ti_msgmgr_desc *desc;
 	void __iomem *queue_proxy_region;
 	void __iomem *queue_state_debug_region;
+	void __iomem *queue_ctrl_region;
 	u8 num_valid_queues;
 	struct ti_queue_inst *qinsts;
 	struct mbox_controller mbox;
@@ -144,6 +165,31 @@ ti_msgmgr_queue_get_num_messages(const struct ti_msgmgr_desc *d,
 	return val;
 }
 
+/**
+ * ti_msgmgr_queue_is_error() - Check to see if there is queue error
+ * @d:		Description of message manager
+ * @qinst:	Queue instance for which we check the number of pending messages
+ *
+ * Return: true if error, else false
+ */
+static inline bool ti_msgmgr_queue_is_error(const struct ti_msgmgr_desc *d,
+					    struct ti_queue_inst *qinst)
+{
+	u32 val;
+
+	/* Msgmgr has no error detection */
+	if (!d->is_sproxy)
+		return false;
+
+	/*
+	 * We cannot use relaxed operation here - update may happen
+	 * real-time.
+	 */
+	val = readl(qinst->queue_state) & d->status_err_mask;
+
+	return val ? true : false;
+}
+
 /**
  * ti_msgmgr_queue_rx_interrupt() - Interrupt handler for receive Queue
  * @irq:	Interrupt number
@@ -178,6 +224,11 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 	}
 
 	desc = inst->desc;
+	if (ti_msgmgr_queue_is_error(desc, qinst)) {
+		dev_err(dev, "Error on Rx channel %s\n", qinst->name);
+		return IRQ_NONE;
+	}
+
 	/* Do I actually have messages to read? */
 	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
 	if (!msg_count) {
@@ -236,12 +287,18 @@ static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 	struct ti_queue_inst *qinst = chan->con_priv;
 	struct device *dev = chan->mbox->dev;
 	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	const struct ti_msgmgr_desc *desc = inst->desc;
 	int msg_count;
 
 	if (qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
+	if (ti_msgmgr_queue_is_error(desc, qinst)) {
+		dev_err(dev, "Error on channel %s\n", qinst->name);
+		return false;
+	}
+
+	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
 
 	return msg_count ? true : false;
 }
@@ -257,12 +314,23 @@ static bool ti_msgmgr_last_tx_done(struct mbox_chan *chan)
 	struct ti_queue_inst *qinst = chan->con_priv;
 	struct device *dev = chan->mbox->dev;
 	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	const struct ti_msgmgr_desc *desc = inst->desc;
 	int msg_count;
 
 	if (!qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
+	if (ti_msgmgr_queue_is_error(desc, qinst)) {
+		dev_err(dev, "Error on channel %s\n", qinst->name);
+		return false;
+	}
+
+	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
+
+	if (desc->is_sproxy) {
+		/* In secure proxy, msg_count indicates how many we can send */
+		return msg_count ? true : false;
+	}
 
 	/* if we have any messages pending.. */
 	return msg_count ? false : true;
@@ -292,6 +360,11 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 	}
 	desc = inst->desc;
 
+	if (ti_msgmgr_queue_is_error(desc, qinst)) {
+		dev_err(dev, "Error on channel %s\n", qinst->name);
+		return false;
+	}
+
 	if (desc->max_message_size < message->len) {
 		dev_err(dev, "Queue %s message length %zu > max %d\n",
 			qinst->name, message->len, desc->max_message_size);
@@ -327,10 +400,12 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 /**
  *  ti_msgmgr_queue_rx_irq_req() - RX IRQ request
  *  @dev:	device pointer
+ *  @d:		descriptor for ti_msgmgr
  *  @qinst:	Queue instance
  *  @chan:	Channel pointer
  */
 static int ti_msgmgr_queue_rx_irq_req(struct device *dev,
+				      const struct ti_msgmgr_desc *d,
 				      struct ti_queue_inst *qinst,
 				      struct mbox_chan *chan)
 {
@@ -339,7 +414,7 @@ static int ti_msgmgr_queue_rx_irq_req(struct device *dev,
 	struct device_node *np;
 
 	snprintf(of_rx_irq_name, sizeof(of_rx_irq_name),
-		 "rx_%03d", qinst->queue_id);
+		 "rx_%03d", d->is_sproxy ? qinst->proxy_id : qinst->queue_id);
 
 	/* Get the IRQ if not found */
 	if (qinst->irq < 0) {
@@ -382,6 +457,24 @@ static int ti_msgmgr_queue_startup(struct mbox_chan *chan)
 	struct ti_queue_inst *qinst = chan->con_priv;
 	const struct ti_msgmgr_desc *d = inst->desc;
 	int ret;
+	int msg_count;
+
+	/*
+	 * If sproxy is starting and can send messages, we are a Tx thread,
+	 * else Rx
+	 */
+	if (d->is_sproxy) {
+		qinst->is_tx = (readl(qinst->queue_ctrl) &
+				SPROXY_THREAD_CTRL_DIR_MASK) ? false : true;
+
+		msg_count = ti_msgmgr_queue_get_num_messages(d, qinst);
+
+		if (!msg_count && qinst->is_tx) {
+			dev_err(dev, "%s: Cannot transmit with 0 credits!\n",
+				qinst->name);
+			return -EINVAL;
+		}
+	}
 
 	if (!qinst->is_tx) {
 		/* Allocate usage buffer for rx */
@@ -389,7 +482,7 @@ static int ti_msgmgr_queue_startup(struct mbox_chan *chan)
 		if (!qinst->rx_buff)
 			return -ENOMEM;
 		/* Request IRQ */
-		ret = ti_msgmgr_queue_rx_irq_req(dev, qinst, chan);
+		ret = ti_msgmgr_queue_rx_irq_req(dev, d, qinst, chan);
 		if (ret) {
 			kfree(qinst->rx_buff);
 			return ret;
@@ -427,20 +520,38 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
 	struct ti_msgmgr_inst *inst;
 	int req_qid, req_pid;
 	struct ti_queue_inst *qinst;
-	int i;
+	const struct ti_msgmgr_desc *d;
+	int i, ncells;
 
 	inst = container_of(mbox, struct ti_msgmgr_inst, mbox);
 	if (WARN_ON(!inst))
 		return ERR_PTR(-EINVAL);
 
-	/* #mbox-cells is 2 */
-	if (p->args_count != 2) {
-		dev_err(inst->dev, "Invalid arguments in dt[%d] instead of 2\n",
-			p->args_count);
+	d = inst->desc;
+
+	if (d->is_sproxy)
+		ncells = 1;
+	else
+		ncells = 2;
+	if (p->args_count != ncells) {
+		dev_err(inst->dev, "Invalid arguments in dt[%d]. Must be %d\n",
+			p->args_count, ncells);
 		return ERR_PTR(-EINVAL);
 	}
-	req_qid = p->args[0];
-	req_pid = p->args[1];
+	if (ncells == 1) {
+		req_qid = 0;
+		req_pid = p->args[0];
+	} else {
+		req_qid = p->args[0];
+		req_pid = p->args[1];
+	}
+
+	if (d->is_sproxy) {
+		if (req_pid > d->num_valid_queues)
+			goto err;
+		qinst = &inst->qinsts[req_pid];
+		return qinst->chan;
+	}
 
 	for (qinst = inst->qinsts, i = 0; i < inst->num_valid_queues;
 	     i++, qinst++) {
@@ -448,6 +559,7 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
 			return qinst->chan;
 	}
 
+err:
 	dev_err(inst->dev, "Queue ID %d, Proxy ID %d is wrong on %s\n",
 		req_qid, req_pid, p->np->name);
 	return ERR_PTR(-ENOENT);
@@ -474,6 +586,8 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 				 struct ti_queue_inst *qinst,
 				 struct mbox_chan *chan)
 {
+	char *dir;
+
 	qinst->proxy_id = qd->proxy_id;
 	qinst->queue_id = qd->queue_id;
 
@@ -483,17 +597,38 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 		return -ERANGE;
 	}
 
-	qinst->is_tx = qd->is_tx;
-	snprintf(qinst->name, sizeof(qinst->name), "%s %s_%03d_%03d",
-		 dev_name(dev), qinst->is_tx ? "tx" : "rx", qinst->queue_id,
-		 qinst->proxy_id);
-
-	qinst->queue_buff_start = inst->queue_proxy_region +
-	    Q_DATA_OFFSET(qinst->proxy_id, qinst->queue_id, d->data_first_reg);
-	qinst->queue_buff_end = inst->queue_proxy_region +
-	    Q_DATA_OFFSET(qinst->proxy_id, qinst->queue_id, d->data_last_reg);
-	qinst->queue_state = inst->queue_state_debug_region +
-	    Q_STATE_OFFSET(qinst->queue_id);
+	if (d->is_sproxy) {
+		qinst->queue_buff_start = inst->queue_proxy_region +
+		    SPROXY_THREAD_DATA_OFFSET(qinst->proxy_id,
+					      d->data_first_reg);
+		qinst->queue_buff_end = inst->queue_proxy_region +
+		    SPROXY_THREAD_DATA_OFFSET(qinst->proxy_id,
+					      d->data_last_reg);
+		qinst->queue_state = inst->queue_state_debug_region +
+		    SPROXY_THREAD_STATUS_OFFSET(qinst->proxy_id);
+		qinst->queue_ctrl = inst->queue_ctrl_region +
+		    SPROXY_THREAD_CTRL_OFFSET(qinst->proxy_id);
+
+		/* XXX: DONOT read registers here!.. Some may be unusable */
+		dir = "thr";
+		snprintf(qinst->name, sizeof(qinst->name), "%s %s_%03d",
+			 dev_name(dev), dir, qinst->proxy_id);
+	} else {
+		qinst->queue_buff_start = inst->queue_proxy_region +
+		    Q_DATA_OFFSET(qinst->proxy_id, qinst->queue_id,
+				  d->data_first_reg);
+		qinst->queue_buff_end = inst->queue_proxy_region +
+		    Q_DATA_OFFSET(qinst->proxy_id, qinst->queue_id,
+				  d->data_last_reg);
+		qinst->queue_state =
+		    inst->queue_state_debug_region +
+		    Q_STATE_OFFSET(qinst->queue_id);
+		qinst->is_tx = qd->is_tx;
+		dir = qinst->is_tx ? "tx" : "rx";
+		snprintf(qinst->name, sizeof(qinst->name), "%s %s_%03d_%03d",
+			 dev_name(dev), dir, qinst->queue_id, qinst->proxy_id);
+	}
+
 	qinst->chan = chan;
 
 	/* Setup an error value for IRQ - Lazy allocation */
@@ -543,12 +678,29 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.tx_polled = false,
 	.valid_queues = k2g_valid_queues,
 	.num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
+	.is_sproxy = false,
+};
+
+static const struct ti_msgmgr_desc am654_desc = {
+	.queue_count = 190,
+	.num_valid_queues = 190,
+	.max_message_size = 60,
+	.data_region_name = "target_data",
+	.status_region_name = "rt",
+	.ctrl_region_name = "scfg",
+	.data_first_reg = 0,
+	.data_last_reg = 14,
+	.status_cnt_mask = SPROXY_THREAD_STATUS_COUNT_MASK,
+	.tx_polled = false,
+	.is_sproxy = true,
 };
 
 static const struct of_device_id ti_msgmgr_of_match[] = {
 	{.compatible = "ti,k2g-message-manager", .data = &k2g_desc},
+	{.compatible = "ti,am654-secure-proxy", .data = &am654_desc},
 	{ /* Sentinel */ }
 };
+
 MODULE_DEVICE_TABLE(of, ti_msgmgr_of_match);
 
 static int ti_msgmgr_probe(struct platform_device *pdev)
@@ -599,6 +751,14 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	if (IS_ERR(inst->queue_state_debug_region))
 		return PTR_ERR(inst->queue_state_debug_region);
 
+	if (desc->is_sproxy) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   desc->ctrl_region_name);
+		inst->queue_ctrl_region = devm_ioremap_resource(dev, res);
+		if (IS_ERR(inst->queue_ctrl_region))
+			return PTR_ERR(inst->queue_ctrl_region);
+	}
+
 	dev_dbg(dev, "proxy region=%p, queue_state=%p\n",
 		inst->queue_proxy_region, inst->queue_state_debug_region);
 
@@ -620,12 +780,29 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	inst->chans = chans;
 
-	for (i = 0, queue_desc = desc->valid_queues;
-	     i < queue_count; i++, qinst++, chans++, queue_desc++) {
-		ret = ti_msgmgr_queue_setup(i, dev, np, inst,
-					    desc, queue_desc, qinst, chans);
-		if (ret)
-			return ret;
+	if (desc->is_sproxy) {
+		struct ti_msgmgr_valid_queue_desc sproxy_desc;
+
+		/* All proxies may be valid in Secure Proxy instance */
+		for (i = 0; i < queue_count; i++, qinst++, chans++) {
+			sproxy_desc.queue_id = 0;
+			sproxy_desc.proxy_id = i;
+			ret = ti_msgmgr_queue_setup(i, dev, np, inst,
+						    desc, &sproxy_desc, qinst,
+						    chans);
+			if (ret)
+				return ret;
+		}
+	} else {
+		/* Only Some proxies are valid in Message Manager */
+		for (i = 0, queue_desc = desc->valid_queues;
+		     i < queue_count; i++, qinst++, chans++, queue_desc++) {
+			ret = ti_msgmgr_queue_setup(i, dev, np, inst,
+						    desc, queue_desc, qinst,
+						    chans);
+			if (ret)
+				return ret;
+		}
 	}
 
 	mbox = &inst->mbox;
-- 
2.15.1
