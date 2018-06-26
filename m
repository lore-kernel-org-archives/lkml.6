Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243426A8A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8243426A8A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935394AbeFZMbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:31:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33945 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935171AbeFZMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:30:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E63A1206ED; Tue, 26 Jun 2018 14:30:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAA4A203B0;
        Tue, 26 Jun 2018 14:30:55 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v2 1/2] net: mscc: ocelot: add bonding support
Date:   Tue, 26 Jun 2018 14:28:48 +0200
Message-Id: <20180626122849.13174-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
References: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add link aggregation hardware offload support for Ocelot.

ocelot_get_link_ksettings() is not great but it does work until the driver
is reworked to switch to phylink.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 160 +++++++++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h |   2 +-
 2 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index fb2c8f8071e6..e154bdd1d12d 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -779,6 +779,8 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_strings		= ocelot_get_strings,
 	.get_ethtool_stats	= ocelot_get_ethtool_stats,
 	.get_sset_count		= ocelot_get_sset_count,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
 static int ocelot_port_attr_get(struct net_device *dev,
@@ -1087,6 +1089,137 @@ static void ocelot_port_bridge_leave(struct ocelot_port *ocelot_port,
 		ocelot->hw_bridge_dev = NULL;
 }
 
+static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
+{
+	int i, port, lag;
+
+	/* Reset destination and aggregation PGIDS */
+	for (port = 0; port < ocelot->num_phys_ports; port++)
+		ocelot_write_rix(ocelot, BIT(port), ANA_PGID_PGID, port);
+
+	for (i = PGID_AGGR; i < PGID_SRC; i++)
+		ocelot_write_rix(ocelot, GENMASK(ocelot->num_phys_ports - 1, 0),
+				 ANA_PGID_PGID, i);
+
+	/* Now, set PGIDs for each LAG */
+	for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
+		unsigned long bond_mask;
+		int aggr_count = 0;
+		u8 aggr_idx[16];
+
+		bond_mask = ocelot->lags[lag];
+		if (!bond_mask)
+			continue;
+
+		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
+			// Destination mask
+			ocelot_write_rix(ocelot, bond_mask,
+					 ANA_PGID_PGID, port);
+			aggr_idx[aggr_count] = port;
+			aggr_count++;
+		}
+
+		for (i = PGID_AGGR; i < PGID_SRC; i++) {
+			u32 ac;
+
+			ac = ocelot_read_rix(ocelot, ANA_PGID_PGID, i);
+			ac &= ~bond_mask;
+			ac |= BIT(aggr_idx[i % aggr_count]);
+			ocelot_write_rix(ocelot, ac, ANA_PGID_PGID, i);
+		}
+	}
+}
+
+static void ocelot_setup_lag(struct ocelot *ocelot, int lag)
+{
+	unsigned long bond_mask = ocelot->lags[lag];
+	unsigned int p;
+
+	for_each_set_bit(p, &bond_mask, ocelot->num_phys_ports) {
+		u32 port_cfg = ocelot_read_gix(ocelot, ANA_PORT_PORT_CFG, p);
+
+		port_cfg &= ~ANA_PORT_PORT_CFG_PORTID_VAL_M;
+
+		/* Use lag port as logical port for port i */
+		ocelot_write_gix(ocelot, port_cfg |
+				 ANA_PORT_PORT_CFG_PORTID_VAL(lag),
+				 ANA_PORT_PORT_CFG, p);
+	}
+}
+
+static int ocelot_port_lag_join(struct ocelot_port *ocelot_port,
+				struct net_device *bond)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int p = ocelot_port->chip_port;
+	int lag, lp;
+	struct net_device *ndev;
+	u32 bond_mask = 0;
+
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(bond, ndev) {
+		struct ocelot_port *port = netdev_priv(ndev);
+
+		bond_mask |= BIT(port->chip_port);
+	}
+	rcu_read_unlock();
+
+	lp = __ffs(bond_mask);
+
+	/* If the new port is the lowest one, use it as the logical port from
+	 * now on
+	 */
+	if (p == lp) {
+		lag = p;
+		ocelot->lags[p] = bond_mask;
+		bond_mask &= ~BIT(p);
+		if (bond_mask) {
+			lp = __ffs(bond_mask);
+			ocelot->lags[lp] = 0;
+		}
+	} else {
+		lag = lp;
+		ocelot->lags[lp] |= BIT(p);
+	}
+
+	ocelot_setup_lag(ocelot, lag);
+	ocelot_set_aggr_pgids(ocelot);
+
+	return 0;
+}
+
+static void ocelot_port_lag_leave(struct ocelot_port *ocelot_port,
+				  struct net_device *bond)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int p = ocelot_port->chip_port;
+	u32 port_cfg;
+	int i;
+
+	/* Remove port from any lag */
+	for (i = 0; i < ocelot->num_phys_ports; i++)
+		ocelot->lags[i] &= ~BIT(ocelot_port->chip_port);
+
+	/* if it was the logical port of the lag, move the lag config to the
+	 * next port
+	 */
+	if (ocelot->lags[p]) {
+		int n = __ffs(ocelot->lags[p]);
+
+		ocelot->lags[n] = ocelot->lags[p];
+		ocelot->lags[p] = 0;
+
+		ocelot_setup_lag(ocelot, n);
+	}
+
+	port_cfg = ocelot_read_gix(ocelot, ANA_PORT_PORT_CFG, p);
+	port_cfg &= ~ANA_PORT_PORT_CFG_PORTID_VAL_M;
+	ocelot_write_gix(ocelot, port_cfg | ANA_PORT_PORT_CFG_PORTID_VAL(p),
+			 ANA_PORT_PORT_CFG, p);
+
+	ocelot_set_aggr_pgids(ocelot);
+}
+
 /* Checks if the net_device instance given to us originate from our driver. */
 static bool ocelot_netdevice_dev_check(const struct net_device *dev)
 {
@@ -1113,6 +1246,14 @@ static int ocelot_netdevice_port_event(struct net_device *dev,
 				ocelot_port_bridge_leave(ocelot_port,
 							 info->upper_dev);
 		}
+		if (netif_is_lag_master(info->upper_dev)) {
+			if (info->linking)
+				err = ocelot_port_lag_join(ocelot_port,
+							   info->upper_dev);
+			else
+				ocelot_port_lag_leave(ocelot_port,
+						      info->upper_dev);
+		}
 		break;
 	default:
 		break;
@@ -1128,6 +1269,20 @@ static int ocelot_netdevice_event(struct notifier_block *unused,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
+	if (event == NETDEV_PRECHANGEUPPER &&
+	    netif_is_lag_master(info->upper_dev)) {
+		struct netdev_lag_upper_info *lag_upper_info = info->upper_info;
+		struct netlink_ext_ack *extack;
+
+		if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+			extack = netdev_notifier_info_to_extack(&info->info);
+			NL_SET_ERR_MSG_MOD(extack, "LAG device using unsupported Tx type");
+
+			ret = -EINVAL;
+			goto notify;
+		}
+	}
+
 	if (netif_is_lag_master(dev)) {
 		struct net_device *slave;
 		struct list_head *iter;
@@ -1200,6 +1355,11 @@ int ocelot_init(struct ocelot *ocelot)
 	int i, cpu = ocelot->num_phys_ports;
 	char queue_name[32];
 
+	ocelot->lags = devm_kcalloc(ocelot->dev, ocelot->num_phys_ports,
+				    sizeof(u32), GFP_KERNEL);
+	if (!ocelot->lags)
+		return -ENOMEM;
+
 	ocelot->stats = devm_kcalloc(ocelot->dev,
 				     ocelot->num_phys_ports * ocelot->num_stats,
 				     sizeof(u64), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 097bd12a10d4..616bec30dfa3 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -493,7 +493,7 @@ struct ocelot {
 	u8 num_cpu_ports;
 	struct ocelot_port **ports;
 
-	u16 lags[16];
+	u32 *lags;
 
 	/* Keep track of the vlan port masks */
 	u32 vlan_mask[VLAN_N_VID];
-- 
2.18.0

