Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DEB2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DEB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbeGMQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:29:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38801 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731446AbeGMQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:29:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 819F9207B4; Fri, 13 Jul 2018 18:14:07 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 305D4207C8;
        Fri, 13 Jul 2018 18:13:57 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 5/5] net: mvpp2: debugfs: add classifier hit counters
Date:   Fri, 13 Jul 2018 18:13:44 +0200
Message-Id: <20180713161344.19872-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
References: <20180713161344.19872-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The classification operations that are used for RSS make use of several
lookup tables. Having hit counters for these tables is really helpful
to determine what flows were matched by ingress traffic, and see the
path of packets among all the classifier tables.

This commit adds hit counters for the 3 tables used at the moment :

 - The decoding table (also called lookup_id table), that links flows
   identified by the Header Parser to the flow table.

   There's one entry per flow, located at :
   .../mvpp2/<controller>/flows/XX/dec_hits

   Note that there are 21 flows in the decoding table, whereas there are
   52 flows in the Header Parser. That's because there are several kind
   of traffic that will match a given flow. Reading the hit counter from
   one sub-flow will clear all hit counter that have the same flow_id.

   This also applies to the flow_hits.

 - The flow table, that contains all the different lookups to be
   performed by the classifier for each packet of a given flow. The match
   is done on the first entry of the flow sequence.

 - The C2 engine entries, that are used to assign the default rx queue,
   and enable or disable RSS for a given port.

   There's one entry per flow, located at:
   .../mvpp2/<controller>/flows/XX/flow_hits

   There is one C2 entry per port, so the c2 hit counter is located at :
   .../mvpp2/<controller>/ethX/c2_hits

All hit counter values are 16-bits clear-on-read values.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |  6 +++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     | 21 +++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |  6 +++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 51 ++++++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index af4968d7c007..67b9e81b7c02 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -124,6 +124,7 @@
 #define MVPP22_CLS_C2_TCAM_DATA3		0x1b1c
 #define MVPP22_CLS_C2_TCAM_DATA4		0x1b20
 #define     MVPP22_CLS_C2_PORT_ID(port)		((port) << 8)
+#define MVPP22_CLS_C2_HIT_CTR			0x1b50
 #define MVPP22_CLS_C2_ACT			0x1b60
 #define     MVPP22_CLS_C2_ACT_RSS_EN(act)	(((act) & 0x3) << 19)
 #define     MVPP22_CLS_C2_ACT_FWD(act)		(((act) & 0x7) << 13)
@@ -318,6 +319,11 @@
 #define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK	0xff00
 #define     MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT	8
 
+/* Hit counters registers */
+#define MVPP2_CTRS_IDX				0x7040
+#define MVPP2_CLS_DEC_TBL_HIT_CTR		0x7700
+#define MVPP2_CLS_FLOW_TBL_HIT_CTR		0x7704
+
 /* TX Scheduler registers */
 #define MVPP2_TXP_SCHED_PORT_INDEX_REG		0x8000
 #define MVPP2_TXP_SCHED_Q_CMD_REG		0x8004
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index c5012fa390c8..efdb7a656835 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -322,6 +322,13 @@ static struct mvpp2_cls_flow cls_flows[MVPP2_N_FLOWS] = {
 		       0, 0),
 };
 
+u32 mvpp2_cls_flow_hits(struct mvpp2 *priv, int index)
+{
+	mvpp2_write(priv, MVPP2_CTRS_IDX, index);
+
+	return mvpp2_read(priv, MVPP2_CLS_FLOW_TBL_HIT_CTR);
+}
+
 void mvpp2_cls_flow_read(struct mvpp2 *priv, int index,
 			 struct mvpp2_cls_flow_entry *fe)
 {
@@ -342,6 +349,13 @@ static void mvpp2_cls_flow_write(struct mvpp2 *priv,
 	mvpp2_write(priv, MVPP2_CLS_FLOW_TBL2_REG,  fe->data[2]);
 }
 
+u32 mvpp2_cls_lookup_hits(struct mvpp2 *priv, int index)
+{
+	mvpp2_write(priv, MVPP2_CTRS_IDX, index);
+
+	return mvpp2_read(priv, MVPP2_CLS_DEC_TBL_HIT_CTR);
+}
+
 void mvpp2_cls_lookup_read(struct mvpp2 *priv, int lkpid, int way,
 			   struct mvpp2_cls_lookup_entry *le)
 {
@@ -859,6 +873,13 @@ void mvpp2_cls_port_config(struct mvpp2_port *port)
 	mvpp2_port_c2_cls_init(port);
 }
 
+u32 mvpp2_cls_c2_hit_count(struct mvpp2 *priv, int c2_index)
+{
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, c2_index);
+
+	return mvpp2_read(priv, MVPP22_CLS_C2_HIT_CTR);
+}
+
 static void mvpp2_rss_port_c2_enable(struct mvpp2_port *port)
 {
 	struct mvpp2_cls_c2_entry c2;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 13eae2d1b4bf..089f05f29891 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -215,12 +215,18 @@ u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe);
 
 struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow);
 
+u32 mvpp2_cls_flow_hits(struct mvpp2 *priv, int index);
+
 void mvpp2_cls_flow_read(struct mvpp2 *priv, int index,
 			 struct mvpp2_cls_flow_entry *fe);
 
+u32 mvpp2_cls_lookup_hits(struct mvpp2 *priv, int index);
+
 void mvpp2_cls_lookup_read(struct mvpp2 *priv, int lkpid, int way,
 			   struct mvpp2_cls_lookup_entry *le);
 
+u32 mvpp2_cls_c2_hit_count(struct mvpp2 *priv, int c2_index);
+
 void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
 		       struct mvpp2_cls_c2_entry *c2);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index fc46ec81249b..02dfef13cccd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -28,6 +28,33 @@ struct mvpp2_dbgfs_port_flow_entry {
 	struct mvpp2_dbgfs_flow_entry *dbg_fe;
 };
 
+static int mvpp2_dbgfs_flow_flt_hits_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_flow_entry *entry = s->private;
+	int id = MVPP2_FLOW_C2_ENTRY(entry->flow);
+
+	u32 hits = mvpp2_cls_flow_hits(entry->priv, id);
+
+	seq_printf(s, "%u\n", hits);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_flt_hits);
+
+static int mvpp2_dbgfs_flow_dec_hits_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_dbgfs_flow_entry *entry = s->private;
+
+	u32 hits = mvpp2_cls_lookup_hits(entry->priv, entry->flow);
+
+	seq_printf(s, "%u\n", hits);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_dec_hits);
+
 static int mvpp2_dbgfs_flow_type_show(struct seq_file *s, void *unused)
 {
 	struct mvpp2_dbgfs_flow_entry *entry = s->private;
@@ -174,6 +201,21 @@ static int mvpp2_dbgfs_port_flow_engine_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_port_flow_engine);
 
+static int mvpp2_dbgfs_flow_c2_hits_show(struct seq_file *s, void *unused)
+{
+	struct mvpp2_port *port = s->private;
+	u32 hits;
+
+	hits = mvpp2_cls_c2_hit_count(port->priv,
+				      MVPP22_CLS_C2_RSS_ENTRY(port->id));
+
+	seq_printf(s, "%u\n", hits);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_c2_hits);
+
 static int mvpp2_dbgfs_flow_c2_rxq_show(struct seq_file *s, void *unused)
 {
 	struct mvpp2_port *port = s->private;
@@ -484,6 +526,12 @@ static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
 	entry->flow = flow;
 	entry->priv = priv;
 
+	debugfs_create_file("flow_hits", 0444, flow_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_flt_hits_fops);
+
+	debugfs_create_file("dec_hits", 0444, flow_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_dec_hits_fops);
+
 	debugfs_create_file("type", 0444, flow_entry_dir, entry,
 			    &mvpp2_dbgfs_flow_type_fops);
 
@@ -600,6 +648,9 @@ static int mvpp2_dbgfs_port_init(struct dentry *parent,
 	debugfs_create_file("vid_filter", 0444, port_dir, port,
 			    &mvpp2_dbgfs_port_vid_fops);
 
+	debugfs_create_file("c2_hits", 0444, port_dir, port,
+			    &mvpp2_dbgfs_flow_c2_hits_fops);
+
 	debugfs_create_file("default_rxq", 0444, port_dir, port,
 			    &mvpp2_dbgfs_flow_c2_rxq_fops);
 
-- 
2.11.0

