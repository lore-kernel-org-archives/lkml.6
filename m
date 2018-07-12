Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BEBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C54213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C54213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbeGLMES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58043 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeGLMER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4326120731; Thu, 12 Jul 2018 13:55:03 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id EC4F9206A6;
        Thu, 12 Jul 2018 13:55:02 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 18/18] net: mvpp2: allow setting RSS flow hash parameters with ethtool
Date:   Thu, 12 Jul 2018 13:54:27 +0200
Message-Id: <20180712115427.27375-19-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows setting the RSS hash generation parameters from
ethtool. When setting parameters for a given flow type from ethtool
(e.g. tcp4), all the corresponding flows in the flow table are updated,
according to the supported hash parameters.

For example, when configuring TCP over IPv4 hash parameters to be
src/dst IP  + src/dst port ("ethtool -N eth0 rx-flow-hash tcp4 sdfn"),
we only set the "src/dst port" hash parameters on the non-fragmented TCP
over IPv4 flows.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 104 ++++++++++++++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  |   3 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  26 +++++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 98e0e25f7dca..dc7dfa9a6606 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -663,6 +663,35 @@ u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
 	return hash_opts;
 }
 
+/* Returns the hash opts for this flow. There are several classifier flows
+ * for one traffic flow, this returns an aggregation of all configurations.
+ */
+static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
+{
+	struct mvpp2_cls_flow_entry fe;
+	struct mvpp2_cls_flow *flow;
+	int i, flow_index;
+	u16 hash_opts = 0;
+
+	for (i = 0; i < MVPP2_N_FLOWS; i++) {
+		flow = mvpp2_cls_flow_get(i);
+		if (!flow)
+			return 0;
+
+		if (flow->flow_type != flow_type)
+			continue;
+
+		flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(port->id,
+							flow->flow_id);
+
+		mvpp2_cls_flow_read(port->priv, flow_index, &fe);
+
+		hash_opts |= mvpp2_flow_get_hek_fields(&fe);
+	}
+
+	return hash_opts;
+}
+
 static void mvpp2_cls_port_init_flows(struct mvpp2 *priv)
 {
 	struct mvpp2_cls_flow *flow;
@@ -897,6 +926,81 @@ void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table)
 	}
 }
 
+int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info)
+{
+	u16 hash_opts = 0;
+
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+		if (info->data & RXH_L4_B_0_1)
+			hash_opts |= MVPP22_CLS_HEK_OPT_L4SIP;
+		if (info->data & RXH_L4_B_2_3)
+			hash_opts |= MVPP22_CLS_HEK_OPT_L4DIP;
+		/* Fallthrough */
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		if (info->data & RXH_L2DA)
+			hash_opts |= MVPP22_CLS_HEK_OPT_MAC_DA;
+		if (info->data & RXH_VLAN)
+			hash_opts |= MVPP22_CLS_HEK_OPT_VLAN;
+		if (info->data & RXH_L3_PROTO)
+			hash_opts |= MVPP22_CLS_HEK_OPT_L3_PROTO;
+		if (info->data & RXH_IP_SRC)
+			hash_opts |= (MVPP22_CLS_HEK_OPT_IP4SA |
+				     MVPP22_CLS_HEK_OPT_IP6SA);
+		if (info->data & RXH_IP_DST)
+			hash_opts |= (MVPP22_CLS_HEK_OPT_IP4DA |
+				     MVPP22_CLS_HEK_OPT_IP6DA);
+		break;
+	default: return -EOPNOTSUPP;
+	}
+
+	return mvpp2_port_rss_hash_opts_set(port, info->flow_type, hash_opts);
+}
+
+int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info)
+{
+	unsigned long hash_opts;
+	int i;
+
+	hash_opts = mvpp2_port_rss_hash_opts_get(port, info->flow_type);
+	info->data = 0;
+
+	for_each_set_bit(i, &hash_opts, MVPP22_CLS_HEK_N_FIELDS) {
+		switch (BIT(i)) {
+		case MVPP22_CLS_HEK_OPT_MAC_DA:
+			info->data |= RXH_L2DA;
+			break;
+		case MVPP22_CLS_HEK_OPT_VLAN:
+			info->data |= RXH_VLAN;
+			break;
+		case MVPP22_CLS_HEK_OPT_L3_PROTO:
+			info->data |= RXH_L3_PROTO;
+			break;
+		case MVPP22_CLS_HEK_OPT_IP4SA:
+		case MVPP22_CLS_HEK_OPT_IP6SA:
+			info->data |= RXH_IP_SRC;
+			break;
+		case MVPP22_CLS_HEK_OPT_IP4DA:
+		case MVPP22_CLS_HEK_OPT_IP6DA:
+			info->data |= RXH_IP_DST;
+			break;
+		case MVPP22_CLS_HEK_OPT_L4SIP:
+			info->data |= RXH_L4_B_0_1;
+			break;
+		case MVPP22_CLS_HEK_OPT_L4DIP:
+			info->data |= RXH_L4_B_2_3;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 void mvpp22_rss_port_init(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 21bd0249be0d..151d791a91b6 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -203,6 +203,9 @@ void mvpp22_rss_port_init(struct mvpp2_port *port);
 void mvpp22_rss_enable(struct mvpp2_port *port);
 void mvpp22_rss_disable(struct mvpp2_port *port);
 
+int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info);
+int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info);
+
 void mvpp2_cls_init(struct mvpp2 *priv);
 
 void mvpp2_cls_port_config(struct mvpp2_port *port);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 61e2d6886a4b..2283be12d700 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3829,11 +3829,15 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 				   struct ethtool_rxnfc *info, u32 *rules)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
+	int ret = 0;
 
 	if (!mvpp22_rss_is_supported())
 		return -EOPNOTSUPP;
 
 	switch (info->cmd) {
+	case ETHTOOL_GRXFH:
+		ret = mvpp2_ethtool_rxfh_get(port, info);
+		break;
 	case ETHTOOL_GRXRINGS:
 		info->data = port->nrxqs;
 		break;
@@ -3841,7 +3845,26 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		return -ENOTSUPP;
 	}
 
-	return 0;
+	return ret;
+}
+
+static int mvpp2_ethtool_set_rxnfc(struct net_device *dev,
+				   struct ethtool_rxnfc *info)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+	int ret = 0;
+
+	if (!mvpp22_rss_is_supported())
+		return -EOPNOTSUPP;
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXFH:
+		ret = mvpp2_ethtool_rxfh_set(port, info);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return ret;
 }
 
 static u32 mvpp2_ethtool_get_rxfh_indir_size(struct net_device *dev)
@@ -3922,6 +3945,7 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.get_link_ksettings	= mvpp2_ethtool_get_link_ksettings,
 	.set_link_ksettings	= mvpp2_ethtool_set_link_ksettings,
 	.get_rxnfc		= mvpp2_ethtool_get_rxnfc,
+	.set_rxnfc		= mvpp2_ethtool_set_rxnfc,
 	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= mvpp2_ethtool_get_rxfh,
 	.set_rxfh		= mvpp2_ethtool_set_rxfh,
-- 
2.11.0

