Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeFEGSV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:18:21 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37249 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeFEGQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:47 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 2/8] mailbox: ti-msgmgr: Allocate Rx channel resources only on request
Date: Tue, 5 Jun 2018 01:16:23 -0500
Message-ID: <20180605061629.4759-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a much bigger system SoCs, the number of Rx channels can be
many and mostly unused based on the system of choice, and not all
Rx channels need IRQs and allocating all memory at probe will be
inefficient. Some SoCs could have total threads in the 100s and usage
would be just 1 Rx thread.

Thus, request and map the IRQs and allocate memory only when needed.

Since these channels are requested by client drivers on need, our
utilization will be optimal.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 91 ++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 7cd5f9c9c97f..7221590c409c 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -310,6 +310,51 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
+/**
+ *  ti_msgmgr_queue_rx_irq_req() - RX IRQ request
+ *  @dev:	device pointer
+ *  @qinst:	Queue instance
+ *  @chan:	Channel pointer
+ */
+static int ti_msgmgr_queue_rx_irq_req(struct device *dev,
+				      struct ti_queue_inst *qinst,
+				      struct mbox_chan *chan)
+{
+	int ret = 0;
+	char of_rx_irq_name[7];
+	struct device_node *np;
+
+	snprintf(of_rx_irq_name, sizeof(of_rx_irq_name),
+		 "rx_%03d", qinst->queue_id);
+
+	/* Get the IRQ if not found */
+	if (qinst->irq < 0) {
+		np = of_node_get(dev->of_node);
+		if (!np)
+			return -ENODATA;
+		qinst->irq = of_irq_get_byname(np, of_rx_irq_name);
+		of_node_put(np);
+
+		if (qinst->irq < 0) {
+			dev_err(dev,
+				"QID %d PID %d:No IRQ[%s]: %d\n",
+				qinst->queue_id, qinst->proxy_id,
+				of_rx_irq_name, qinst->irq);
+			return qinst->irq;
+		}
+	}
+
+	/* With the expectation that the IRQ might be shared in SoC */
+	ret = request_irq(qinst->irq, ti_msgmgr_queue_rx_interrupt,
+			  IRQF_SHARED, qinst->name, chan);
+	if (ret) {
+		dev_err(dev, "Unable to get IRQ %d on %s(res=%d)\n",
+			qinst->irq, qinst->name, ret);
+	}
+
+	return ret;
+}
+
 /**
  * ti_msgmgr_queue_startup() - Startup queue
  * @chan:	Channel pointer
@@ -318,19 +363,21 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
  */
 static int ti_msgmgr_queue_startup(struct mbox_chan *chan)
 {
-	struct ti_queue_inst *qinst = chan->con_priv;
 	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	struct ti_queue_inst *qinst = chan->con_priv;
+	const struct ti_msgmgr_desc *d = inst->desc;
 	int ret;
 
 	if (!qinst->is_tx) {
-		/*
-		 * With the expectation that the IRQ might be shared in SoC
-		 */
-		ret = request_irq(qinst->irq, ti_msgmgr_queue_rx_interrupt,
-				  IRQF_SHARED, qinst->name, chan);
+		/* Allocate usage buffer for rx */
+		qinst->rx_buff = kzalloc(d->max_message_size, GFP_KERNEL);
+		if (!qinst->rx_buff)
+			return -ENOMEM;
+		/* Request IRQ */
+		ret = ti_msgmgr_queue_rx_irq_req(dev, qinst, chan);
 		if (ret) {
-			dev_err(dev, "Unable to get IRQ %d on %s(res=%d)\n",
-				qinst->irq, qinst->name, ret);
+			kfree(qinst->rx_buff);
 			return ret;
 		}
 	}
@@ -346,8 +393,10 @@ static void ti_msgmgr_queue_shutdown(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
 
-	if (!qinst->is_tx)
+	if (!qinst->is_tx) {
 		free_irq(qinst->irq, chan);
+		kfree(qinst->rx_buff);
+	}
 }
 
 /**
@@ -425,27 +474,6 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 		 dev_name(dev), qinst->is_tx ? "tx" : "rx", qinst->queue_id,
 		 qinst->proxy_id);
 
-	if (!qinst->is_tx) {
-		char of_rx_irq_name[7];
-
-		snprintf(of_rx_irq_name, sizeof(of_rx_irq_name),
-			 "rx_%03d", qinst->queue_id);
-
-		qinst->irq = of_irq_get_byname(np, of_rx_irq_name);
-		if (qinst->irq < 0) {
-			dev_crit(dev,
-				 "[%d]QID %d PID %d:No IRQ[%s]: %d\n",
-				 idx, qinst->queue_id, qinst->proxy_id,
-				 of_rx_irq_name, qinst->irq);
-			return qinst->irq;
-		}
-		/* Allocate usage buffer for rx */
-		qinst->rx_buff = devm_kzalloc(dev,
-					      d->max_message_size, GFP_KERNEL);
-		if (!qinst->rx_buff)
-			return -ENOMEM;
-	}
-
 	qinst->queue_buff_start = inst->queue_proxy_region +
 	    Q_DATA_OFFSET(qinst->proxy_id, qinst->queue_id, d->data_first_reg);
 	qinst->queue_buff_end = inst->queue_proxy_region +
@@ -454,6 +482,9 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 	    Q_STATE_OFFSET(qinst->queue_id);
 	qinst->chan = chan;
 
+	/* Setup an error value for IRQ - Lazy allocation */
+	qinst->irq = -EINVAL;
+
 	chan->con_priv = qinst;
 
 	dev_dbg(dev, "[%d] qidx=%d pidx=%d irq=%d q_s=%p q_e = %p\n",
-- 
2.15.1
