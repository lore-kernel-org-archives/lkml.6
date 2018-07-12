Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C94C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A2E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A2E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeGLMEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58016 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeGLMEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE7BF20731; Thu, 12 Jul 2018 13:54:57 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 67801206A6;
        Thu, 12 Jul 2018 13:54:57 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 15/18] net: mvpp2: use classifier to assign default rx queue
Date:   Thu, 12 Jul 2018 13:54:24 +0200
Message-Id: <20180712115427.27375-16-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPv2 Controller has a classifier, that can perform multiple lookup
operations for each packet, using different engines.

One of these engines is the C2 engine, which performs TCAM based lookups
on data extracted from the packet header. When a packet matches an
entry, the engine sets various attributes, used to perform
classification operations.

One of these attributes is the rx queue in which the packet should be sent.
The current code uses the lookup_id table (also called decoding table)
to assign the rx queue. However, this only works if we use one entry per
port in the decoding table, which won't be the case once we add RSS
lookups.

This patch uses the C2 engine to assign the rx queue to each packet.

The C2 engine is used through the flow table, which dictates what
classification operations are done for a given flow.

Right now, we have one flow per port, which contains every ingress
packet for this port.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h     |  40 +++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 150 +++++++++++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h |  56 +++++++++
 3 files changed, 246 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 2afbbf5e71e2..749d9720bf5e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -87,11 +87,28 @@
 #define     MVPP2_CLS_LKP_INDEX_WAY_OFFS	6
 #define MVPP2_CLS_LKP_TBL_REG			0x1818
 #define     MVPP2_CLS_LKP_TBL_RXQ_MASK		0xff
+#define     MVPP2_CLS_LKP_FLOW_PTR(flow)	((flow) << 16)
 #define     MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK	BIT(25)
 #define MVPP2_CLS_FLOW_INDEX_REG		0x1820
 #define MVPP2_CLS_FLOW_TBL0_REG			0x1824
+#define     MVPP2_CLS_FLOW_TBL0_LAST		BIT(0)
+#define     MVPP2_CLS_FLOW_TBL0_ENG_MASK	0x7
+#define     MVPP2_CLS_FLOW_TBL0_OFFS		1
+#define     MVPP2_CLS_FLOW_TBL0_ENG(x)		((x) << 1)
+#define     MVPP2_CLS_FLOW_TBL0_PORT_ID_MASK	0xff
+#define     MVPP2_CLS_FLOW_TBL0_PORT_ID(port)	((port) << 4)
+#define     MVPP2_CLS_FLOW_TBL0_PORT_ID_SEL	BIT(23)
 #define MVPP2_CLS_FLOW_TBL1_REG			0x1828
+#define     MVPP2_CLS_FLOW_TBL1_N_FIELDS_MASK	0x7
+#define     MVPP2_CLS_FLOW_TBL1_N_FIELDS(x)	(x)
+#define     MVPP2_CLS_FLOW_TBL1_PRIO_MASK	0x3f
+#define     MVPP2_CLS_FLOW_TBL1_PRIO(x)		((x) << 9)
+#define     MVPP2_CLS_FLOW_TBL1_SEQ_MASK	0x7
+#define     MVPP2_CLS_FLOW_TBL1_SEQ(x)		((x) << 15)
 #define MVPP2_CLS_FLOW_TBL2_REG			0x182c
+#define     MVPP2_CLS_FLOW_TBL2_FLD_MASK	0x3f
+#define     MVPP2_CLS_FLOW_TBL2_FLD_OFFS(n)	((n) * 6)
+#define     MVPP2_CLS_FLOW_TBL2_FLD(n, x)	((x) << ((n) * 6))
 #define MVPP2_CLS_OVERSIZE_RXQ_LOW_REG(port)	(0x1980 + ((port) * 4))
 #define     MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS	3
 #define     MVPP2_CLS_OVERSIZE_RXQ_LOW_MASK	0x7
@@ -99,6 +116,29 @@
 #define MVPP2_CLS_SWFWD_PCTRL_REG		0x19d0
 #define     MVPP2_CLS_SWFWD_PCTRL_MASK(port)	(1 << (port))
 
+/* Classifier C2 engine Registers */
+#define MVPP22_CLS_C2_TCAM_IDX			0x1b00
+#define MVPP22_CLS_C2_TCAM_DATA0		0x1b10
+#define MVPP22_CLS_C2_TCAM_DATA1		0x1b14
+#define MVPP22_CLS_C2_TCAM_DATA2		0x1b18
+#define MVPP22_CLS_C2_TCAM_DATA3		0x1b1c
+#define MVPP22_CLS_C2_TCAM_DATA4		0x1b20
+#define     MVPP22_CLS_C2_PORT_ID(port)		((port) << 8)
+#define MVPP22_CLS_C2_ACT			0x1b60
+#define     MVPP22_CLS_C2_ACT_RSS_EN(act)	(((act) & 0x3) << 19)
+#define     MVPP22_CLS_C2_ACT_FWD(act)		(((act) & 0x7) << 13)
+#define     MVPP22_CLS_C2_ACT_QHIGH(act)	(((act) & 0x3) << 11)
+#define     MVPP22_CLS_C2_ACT_QLOW(act)		(((act) & 0x3) << 9)
+#define MVPP22_CLS_C2_ATTR0			0x1b64
+#define     MVPP22_CLS_C2_ATTR0_QHIGH(qh)	(((qh) & 0x1f) << 24)
+#define     MVPP22_CLS_C2_ATTR0_QHIGH_MASK	0x1f
+#define     MVPP22_CLS_C2_ATTR0_QLOW(ql)	(((ql) & 0x7) << 21)
+#define     MVPP22_CLS_C2_ATTR0_QLOW_MASK	0x7
+#define MVPP22_CLS_C2_ATTR1			0x1b68
+#define MVPP22_CLS_C2_ATTR2			0x1b6c
+#define     MVPP22_CLS_C2_ATTR2_RSS_EN		BIT(30)
+#define MVPP22_CLS_C2_ATTR3			0x1b70
+
 /* Descriptor Manager Top Registers */
 #define MVPP2_RXQ_NUM_REG			0x2040
 #define MVPP2_RXQ_DESC_ADDR_REG			0x2044
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 66160b9b8a9a..7cee117efb4f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -12,6 +12,7 @@
 
 #include "mvpp2.h"
 #include "mvpp2_cls.h"
+#include "mvpp2_prs.h"
 
 /* Update classification flow table registers */
 static void mvpp2_cls_flow_write(struct mvpp2 *priv,
@@ -34,6 +35,151 @@ static void mvpp2_cls_lookup_write(struct mvpp2 *priv,
 	mvpp2_write(priv, MVPP2_CLS_LKP_TBL_REG, le->data);
 }
 
+static void mvpp2_cls_flow_eng_set(struct mvpp2_cls_flow_entry *fe,
+				   int engine)
+{
+	fe->data[0] &= ~MVPP2_CLS_FLOW_TBL0_ENG(MVPP2_CLS_FLOW_TBL0_ENG_MASK);
+	fe->data[0] |= MVPP2_CLS_FLOW_TBL0_ENG(engine);
+}
+
+static void mvpp2_cls_flow_port_id_sel(struct mvpp2_cls_flow_entry *fe,
+				       bool from_packet)
+{
+	if (from_packet)
+		fe->data[0] |= MVPP2_CLS_FLOW_TBL0_PORT_ID_SEL;
+	else
+		fe->data[0] &= ~MVPP2_CLS_FLOW_TBL0_PORT_ID_SEL;
+}
+
+static void mvpp2_cls_flow_seq_set(struct mvpp2_cls_flow_entry *fe, u32 seq)
+{
+	fe->data[1] &= ~MVPP2_CLS_FLOW_TBL1_SEQ(MVPP2_CLS_FLOW_TBL1_SEQ_MASK);
+	fe->data[1] |= MVPP2_CLS_FLOW_TBL1_SEQ(seq);
+}
+
+static void mvpp2_cls_flow_last_set(struct mvpp2_cls_flow_entry *fe,
+				    bool is_last)
+{
+	fe->data[0] &= ~MVPP2_CLS_FLOW_TBL0_LAST;
+	fe->data[0] |= !!is_last;
+}
+
+static void mvpp2_cls_flow_pri_set(struct mvpp2_cls_flow_entry *fe, int prio)
+{
+	fe->data[1] &= ~MVPP2_CLS_FLOW_TBL1_PRIO(MVPP2_CLS_FLOW_TBL1_PRIO_MASK);
+	fe->data[1] |= MVPP2_CLS_FLOW_TBL1_PRIO(prio);
+}
+
+static void mvpp2_cls_flow_port_add(struct mvpp2_cls_flow_entry *fe,
+				    u32 port)
+{
+	fe->data[0] |= MVPP2_CLS_FLOW_TBL0_PORT_ID(port);
+}
+
+/* Initialize the Lookup Id table entry for the given flow */
+static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv, int port_id)
+{
+	struct mvpp2_cls_lookup_entry le;
+
+	le.way = 0;
+	le.lkpid = port_id;
+
+	/* The default RxQ for this port is set in the C2 lookup */
+	le.data = 0;
+
+	le.data |= MVPP2_CLS_LKP_FLOW_PTR(port_id);
+	le.data |= MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK;
+
+	mvpp2_cls_lookup_write(priv, &le);
+}
+
+/* Initialize the flow table entries for the given flow */
+static void mvpp2_cls_flow_init(struct mvpp2 *priv, int port_id)
+{
+	struct mvpp2_cls_flow_entry fe;
+	int i;
+
+	/* C2 lookup */
+	memset(&fe, 0, sizeof(fe));
+	fe.index = port_id;
+
+	mvpp2_cls_flow_eng_set(&fe, MVPP22_CLS_ENGINE_C2);
+	mvpp2_cls_flow_port_id_sel(&fe, true);
+	mvpp2_cls_flow_last_set(&fe, 1);
+	mvpp2_cls_flow_pri_set(&fe, 0);
+	mvpp2_cls_flow_seq_set(&fe, MVPP2_CLS_FLOW_SEQ_LAST);
+
+	/* Add all ports */
+	for (i = 0; i < MVPP2_MAX_PORTS; i++)
+		mvpp2_cls_flow_port_add(&fe, BIT(i));
+
+	mvpp2_cls_flow_write(priv, &fe);
+}
+
+static void mvpp2_cls_port_init_flows(struct mvpp2 *priv)
+{
+	int i;
+
+	for (i = 0; i < MVPP2_MAX_PORTS; i++) {
+		mvpp2_cls_flow_lkp_init(priv, i);
+		mvpp2_cls_flow_init(priv, i);
+	}
+}
+
+static void mvpp2_cls_c2_write(struct mvpp2 *priv,
+			       struct mvpp2_cls_c2_entry *c2)
+{
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, c2->index);
+
+	/* Write TCAM */
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA0, c2->tcam[0]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA1, c2->tcam[1]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA2, c2->tcam[2]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA3, c2->tcam[3]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA4, c2->tcam[4]);
+
+	mvpp2_write(priv, MVPP22_CLS_C2_ACT, c2->act);
+
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR0, c2->attr[0]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR1, c2->attr[1]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR2, c2->attr[2]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR3, c2->attr[3]);
+}
+
+static void mvpp2_port_c2_cls_init(struct mvpp2_port *port)
+{
+	struct mvpp2_cls_c2_entry c2;
+	u8 qh, ql, pmap;
+
+	memset(&c2, 0, sizeof(c2));
+
+	c2.index = MVPP22_CLS_C2_RSS_ENTRY(port->id);
+
+	pmap = BIT(port->id);
+	c2.tcam[4] = MVPP22_CLS_C2_PORT_ID(pmap);
+	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_PORT_ID(pmap));
+
+	/* Update RSS status after matching this entry */
+	c2.act = MVPP22_CLS_C2_ACT_RSS_EN(MVPP22_C2_UPD_LOCK);
+
+	/* Mark packet as "forwarded to software", needed for RSS */
+	c2.act |= MVPP22_CLS_C2_ACT_FWD(MVPP22_C2_FWD_SW_LOCK);
+
+	/* Configure the default rx queue : Update Queue Low and Queue High, but
+	 * don't lock, since the rx queue selection might be overridden by RSS
+	 */
+	c2.act |= MVPP22_CLS_C2_ACT_QHIGH(MVPP22_C2_UPD) |
+		   MVPP22_CLS_C2_ACT_QLOW(MVPP22_C2_UPD);
+
+	qh = (port->first_rxq >> 3) & MVPP22_CLS_C2_ATTR0_QHIGH_MASK;
+	ql = port->first_rxq & MVPP22_CLS_C2_ATTR0_QLOW_MASK;
+
+	c2.attr[0] = MVPP22_CLS_C2_ATTR0_QHIGH(qh) |
+		      MVPP22_CLS_C2_ATTR0_QLOW(ql);
+
+	mvpp2_cls_c2_write(port->priv, &c2);
+}
+
 /* Classifier default initialization */
 void mvpp2_cls_init(struct mvpp2 *priv)
 {
@@ -61,6 +207,8 @@ void mvpp2_cls_init(struct mvpp2 *priv)
 		le.way = 1;
 		mvpp2_cls_lookup_write(priv, &le);
 	}
+
+	mvpp2_cls_port_init_flows(priv);
 }
 
 void mvpp2_cls_port_config(struct mvpp2_port *port)
@@ -89,6 +237,8 @@ void mvpp2_cls_port_config(struct mvpp2_port *port)
 
 	/* Update lookup ID table entry */
 	mvpp2_cls_lookup_write(port->priv, &le);
+
+	mvpp2_port_c2_cls_init(port);
 }
 
 /* Set CPU queue number for oversize packets */
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 38a8cf1172df..ee4933ca7ed8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -14,6 +14,7 @@
 #define _MVPP2_CLS_H_
 
 #include "mvpp2.h"
+#include "mvpp2_prs.h"
 
 /* Classifier constants */
 #define MVPP2_CLS_FLOWS_TBL_SIZE	512
@@ -21,6 +22,61 @@
 #define MVPP2_CLS_LKP_TBL_SIZE		64
 #define MVPP2_CLS_RX_QUEUES		256
 
+/* Classifier flow constants */
+enum mvpp2_cls_engine {
+	MVPP22_CLS_ENGINE_C2 = 1,
+	MVPP22_CLS_ENGINE_C3A,
+	MVPP22_CLS_ENGINE_C3B,
+	MVPP22_CLS_ENGINE_C4,
+	MVPP22_CLS_ENGINE_C3HA = 6,
+	MVPP22_CLS_ENGINE_C3HB = 7,
+};
+
+enum mvpp2_cls_flow_seq {
+	MVPP2_CLS_FLOW_SEQ_NORMAL = 0,
+	MVPP2_CLS_FLOW_SEQ_FIRST1,
+	MVPP2_CLS_FLOW_SEQ_FIRST2,
+	MVPP2_CLS_FLOW_SEQ_LAST,
+	MVPP2_CLS_FLOW_SEQ_MIDDLE
+};
+
+/* Classifier C2 engine constants */
+#define MVPP22_CLS_C2_TCAM_EN(data)		((data) << 16)
+
+enum mvpp22_cls_c2_action {
+	MVPP22_C2_NO_UPD = 0,
+	MVPP22_C2_NO_UPD_LOCK,
+	MVPP22_C2_UPD,
+	MVPP22_C2_UPD_LOCK,
+};
+
+enum mvpp22_cls_c2_fwd_action {
+	MVPP22_C2_FWD_NO_UPD = 0,
+	MVPP22_C2_FWD_NO_UPD_LOCK,
+	MVPP22_C2_FWD_SW,
+	MVPP22_C2_FWD_SW_LOCK,
+	MVPP22_C2_FWD_HW,
+	MVPP22_C2_FWD_HW_LOCK,
+	MVPP22_C2_FWD_HW_LOW_LAT,
+	MVPP22_C2_FWD_HW_LOW_LAT_LOCK,
+};
+
+#define MVPP2_CLS_C2_TCAM_WORDS			5
+#define MVPP2_CLS_C2_ATTR_WORDS			5
+
+struct mvpp2_cls_c2_entry {
+	u32 index;
+	u32 tcam[MVPP2_CLS_C2_TCAM_WORDS];
+	u32 act;
+	u32 attr[MVPP2_CLS_C2_ATTR_WORDS];
+};
+
+/* Classifier C2 engine entries */
+#define MVPP22_CLS_C2_RSS_ENTRY(port)	(port)
+#define MVPP22_CLS_C2_N_ENTRIES		MVPP2_MAX_PORTS
+
+#define MVPP22_RSS_FLOW_C2_OFFS		0
+
 struct mvpp2_cls_flow_entry {
 	u32 index;
 	u32 data[MVPP2_CLS_FLOWS_TBL_DATA_WORDS];
-- 
2.11.0

