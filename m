Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC28C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597C0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597C0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeGLMEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbeGLMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CA84820731; Thu, 12 Jul 2018 13:54:53 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78DAD206A6;
        Thu, 12 Jul 2018 13:54:53 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 11/18] net: mvpp2: RSS indirection table support
Date:   Thu, 12 Jul 2018 13:54:20 +0200
Message-Id: <20180712115427.27375-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

This patch adds the RSS indirection table support, allowing to use the
ethtool -x and -X options to dump and set this table.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
[Maxime: Small warning fixes, use one table per port]
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  3 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 24 ++++++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  |  2 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 70 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index e6b182d8be5b..2afbbf5e71e2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -801,6 +801,9 @@ struct mvpp2_port {
 	bool has_tx_irqs;
 
 	u32 tx_time_coal;
+
+	/* RSS indirection table */
+	u32 indir[MVPP22_RSS_TABLE_ENTRIES];
 };
 
 /* The mvpp2_tx_desc and mvpp2_rx_desc structures describe the
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index c8cf3db85ffe..c80a1a549224 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -107,6 +107,20 @@ void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
 	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
 }
 
+void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table)
+{
+	struct mvpp2 *priv = port->priv;
+	int i;
+
+	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++) {
+		u32 sel = MVPP22_RSS_INDEX_TABLE(table) |
+			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
+		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
+
+		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY, port->indir[i]);
+	}
+}
+
 void mvpp22_init_rss(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
@@ -129,12 +143,8 @@ void mvpp22_init_rss(struct mvpp2_port *port)
 	/* Configure the first table to evenly distribute the packets across
 	 * real Rx Queues. The table entries map a hash to a port Rx Queue.
 	 */
-	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++) {
-		u32 sel = MVPP22_RSS_INDEX_TABLE(port->id) |
-			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
-		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
-
-		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY, i % port->nrxqs);
-	}
+	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++)
+		port->indir[i] = ethtool_rxfh_indir_default(i, port->nrxqs);
 
+	mvpp22_rss_fill_table(port, port->id);
 }
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index e571238a83cc..4c7be7469a92 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -32,6 +32,8 @@ struct mvpp2_cls_lookup_entry {
 	u32 data;
 };
 
+void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table);
+
 void mvpp22_init_rss(struct mvpp2_port *port);
 
 void mvpp2_cls_init(struct mvpp2 *priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 4bc0b893b026..f0b5fb78cd67 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3821,6 +3821,71 @@ static int mvpp2_ethtool_set_link_ksettings(struct net_device *dev,
 	return phylink_ethtool_ksettings_set(port->phylink, cmd);
 }
 
+static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
+				   struct ethtool_rxnfc *info, u32 *rules)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!mvpp22_rss_is_supported())
+		return -EOPNOTSUPP;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXRINGS:
+		info->data = port->nrxqs;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static u32 mvpp2_ethtool_get_rxfh_indir_size(struct net_device *dev)
+{
+	return mvpp22_rss_is_supported() ? MVPP22_RSS_TABLE_ENTRIES : 0;
+}
+
+static int mvpp2_ethtool_get_rxfh(struct net_device *dev, u32 *indir, u8 *key,
+				  u8 *hfunc)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!mvpp22_rss_is_supported())
+		return -EOPNOTSUPP;
+
+	if (indir)
+		memcpy(indir, port->indir,
+		       ARRAY_SIZE(port->indir) * sizeof(port->indir[0]));
+
+	if (hfunc)
+		*hfunc = ETH_RSS_HASH_CRC32;
+
+	return 0;
+}
+
+static int mvpp2_ethtool_set_rxfh(struct net_device *dev, const u32 *indir,
+				  const u8 *key, const u8 hfunc)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!mvpp22_rss_is_supported())
+		return -EOPNOTSUPP;
+
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_CRC32)
+		return -EOPNOTSUPP;
+
+	if (key)
+		return -EOPNOTSUPP;
+
+	if (indir) {
+		memcpy(port->indir, indir,
+		       ARRAY_SIZE(port->indir) * sizeof(port->indir[0]));
+		mvpp22_rss_fill_table(port, port->id);
+	}
+
+	return 0;
+}
+
 /* Device ops */
 
 static const struct net_device_ops mvpp2_netdev_ops = {
@@ -3852,6 +3917,11 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.set_pauseparam		= mvpp2_ethtool_set_pause_param,
 	.get_link_ksettings	= mvpp2_ethtool_get_link_ksettings,
 	.set_link_ksettings	= mvpp2_ethtool_set_link_ksettings,
+	.get_rxnfc		= mvpp2_ethtool_get_rxnfc,
+	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
+	.get_rxfh		= mvpp2_ethtool_get_rxfh,
+	.set_rxfh		= mvpp2_ethtool_set_rxfh,
+
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
-- 
2.11.0

