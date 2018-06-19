Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A04C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D75205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GombzLiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D75205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030554AbeFSTnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:43:46 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:39333 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030374AbeFSTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:42 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJhbqi013455;
        Tue, 19 Jun 2018 14:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437417;
        bh=JaojuIEE3X5kvJBZyUWRzgfYPZdvaCHIVA3zLg9T8Fs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GombzLiNyP6vD0V2/UI1ZPeZGqxzV1+H1l2VrJlt+3EloNff65FGD0j2igtVqOyZj
         4k+7TqyRVGmvYFKe9E9vnHRUtFycWsrWSYDiOGzaFffBIzh1pyyb2dBrJx0ZSFWIiO
         bZ4mxC7Xqwofyhrsb7baWFayqTu2JLIIn2peo4KI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbKB009151;
        Tue, 19 Jun 2018 14:43:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:43:37 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:43:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbhN026532;
        Tue, 19 Jun 2018 14:43:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/6] mailbox: ti-msgmgr: Allocate Rx channel resources only on request
Date:   Tue, 19 Jun 2018 14:43:33 -0500
Message-ID: <20180619194337.31522-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194337.31522-1-nm@ti.com>
References: <20180619194337.31522-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Changes since RFC: None
RFC: https://patchwork.kernel.org/patch/10447701/

 drivers/mailbox/ti-msgmgr.c | 91 ++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 5fe6ce200264..91c955979008 100644
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

