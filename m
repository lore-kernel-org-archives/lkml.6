Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AD20645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeISPIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:08:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43213 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeISPHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 15CAA208F5; Wed, 19 Sep 2018 11:30:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id D45B420795;
        Wed, 19 Sep 2018 11:30:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 02/12] net: mvpp2: rename the IRQs to match the hardware
Date:   Wed, 19 Sep 2018 11:27:01 +0200
Message-Id: <20180919092711.22296-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the IRQs in the Marvell PPv2 driver as their current
names match the way they are used in software. But this will change in
the future, and those IRQs have nothing to do with Rx/Tx interrupts
(this can be configured). The new binding also describe more interrupts
as some where left out.

The old binding support is kept for backward compatibility.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 60 ++++++++++++++-----
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 2f8d8202d1d2..43f9d8372b28 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -613,6 +613,7 @@
 
 /* Port flags */
 #define MVPP2_F_LOOPBACK		BIT(0)
+#define MVPP2_F_DT_COMPAT		BIT(1)
 
 /* Marvell tag types */
 enum mvpp2_tag_type {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8bf81d11ff98..69ab80911756 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4001,7 +4001,10 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 		v->sw_thread_id = i;
 		v->sw_thread_mask = BIT(i);
 
-		snprintf(irqname, sizeof(irqname), "tx-cpu%d", i);
+		if (port->flags & MVPP2_F_DT_COMPAT)
+			snprintf(irqname, sizeof(irqname), "tx-cpu%d", i);
+		else
+			snprintf(irqname, sizeof(irqname), "hif%d", i);
 
 		if (queue_mode == MVPP2_QDIST_MULTI_MODE) {
 			v->first_rxq = i * MVPP2_DEFAULT_RXQ;
@@ -4011,7 +4014,9 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 			v->first_rxq = 0;
 			v->nrxqs = port->nrxqs;
 			v->type = MVPP2_QUEUE_VECTOR_SHARED;
-			strncpy(irqname, "rx-shared", sizeof(irqname));
+
+			if (port->flags & MVPP2_F_DT_COMPAT)
+				strncpy(irqname, "rx-shared", sizeof(irqname));
 		}
 
 		if (port_node)
@@ -4207,24 +4212,47 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	return err;
 }
 
-/* Checks if the port DT description has the TX interrupts
- * described. On PPv2.1, there are no such interrupts. On PPv2.2,
- * there are available, but we need to keep support for old DTs.
+static bool mvpp22_port_has_legacy_tx_irqs(struct device_node *port_node,
+					   unsigned long *flags)
+{
+	char *irqs[5] = { "rx-shared", "tx-cpu0", "tx-cpu1", "tx-cpu2",
+			  "tx-cpu3" };
+	int i;
+
+	for (i = 0; i < 5; i++)
+		if (of_property_match_string(port_node, "interrupt-names",
+					     irqs[i]) < 0)
+			return false;
+
+	*flags |= MVPP2_F_DT_COMPAT;
+	return true;
+}
+
+/* Checks if the port dt description has the required Tx interrupts:
+ * - PPv2.1: there are no such interrupts.
+ * - PPv2.2:
+ *   - The old DTs have: "rx-shared", "tx-cpuX" with X in [0...3]
+ *   - The new ones have: "hifX" with X in [0..8]
+ *
+ * All those variants are supported to keep the backward compatibility.
  */
-static bool mvpp2_port_has_tx_irqs(struct mvpp2 *priv,
-				   struct device_node *port_node)
+static bool mvpp2_port_has_irqs(struct mvpp2 *priv,
+				struct device_node *port_node,
+				unsigned long *flags)
 {
-	char *irqs[5] = { "rx-shared", "tx-cpu0", "tx-cpu1",
-			  "tx-cpu2", "tx-cpu3" };
-	int ret, i;
+	char name[5];
+	int i;
 
 	if (priv->hw_version == MVPP21)
 		return false;
 
-	for (i = 0; i < 5; i++) {
-		ret = of_property_match_string(port_node, "interrupt-names",
-					       irqs[i]);
-		if (ret < 0)
+	if (mvpp22_port_has_legacy_tx_irqs(port_node, flags))
+		return true;
+
+	for (i = 0; i < MVPP2_MAX_THREADS; i++) {
+		snprintf(name, 5, "hif%d", i);
+		if (of_property_match_string(port_node, "interrupt-names",
+					     name) < 0)
 			return false;
 	}
 
@@ -4602,6 +4630,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	struct phylink *phylink;
 	char *mac_from = "";
 	unsigned int ntxqs, nrxqs;
+	unsigned long flags = 0;
 	bool has_tx_irqs;
 	u32 id;
 	int features;
@@ -4609,7 +4638,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	int err, i, cpu;
 
 	if (port_node) {
-		has_tx_irqs = mvpp2_port_has_tx_irqs(priv, port_node);
+		has_tx_irqs = mvpp2_port_has_irqs(priv, port_node, &flags);
 	} else {
 		has_tx_irqs = true;
 		queue_mode = MVPP2_QDIST_MULTI_MODE;
@@ -4665,6 +4694,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	port->nrxqs = nrxqs;
 	port->priv = priv;
 	port->has_tx_irqs = has_tx_irqs;
+	port->flags = flags;
 
 	err = mvpp2_queue_vectors_init(port, port_node);
 	if (err)
-- 
2.17.1

