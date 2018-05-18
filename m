Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeERGly (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:41:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48591 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeERGlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:41:18 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next 1/2] net: mscc: ocelot: add bonding support
Date: Fri, 18 May 2018 08:41:05 +0200
Message-Id: <20180518064106.10122-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518064106.10122-1-alexandre.belloni@bootlin.com>
References: <20180518064106.10122-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add link aggregation hardware offload support for Ocelot.

ocelot_get_link_ksettings() is not great but it does work until the driver
is reworked to switch to phylink.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 177 +++++++++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h |   2 +-
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c8c74aa548d9..f22f5467001e 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -775,10 +775,43 @@ static int ocelot_get_sset_count(struct net_device *dev, int sset)
 	return ocelot->num_stats;
 }
 
+static int ocelot_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *ks)
+{
+	ethtool_link_ksettings_zero_link_mode(ks, supported);
+	ethtool_link_ksettings_zero_link_mode(ks, advertising);
+
+	ethtool_link_ksettings_add_link_mode(ks, supported, 10baseT_Half);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 10baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 100baseT_Half);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 100baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 1000baseT_Half);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 1000baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, supported, 2500baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
+
+	if (!dev->phydev)
+		return 0;
+
+	ethtool_link_ksettings_add_link_mode(ks, advertising, 10baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, advertising, 100baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, advertising, 1000baseT_Full);
+	ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
+
+	if (!dev->phydev->link)
+		return 0;
+
+	ks->base.speed = dev->phydev->speed;
+	ks->base.duplex = DUPLEX_FULL;
+
+	return 0;
+}
+
 static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_strings		= ocelot_get_strings,
 	.get_ethtool_stats	= ocelot_get_ethtool_stats,
 	.get_sset_count		= ocelot_get_sset_count,
+	.get_link_ksettings	= ocelot_get_link_ksettings,
 };
 
 static int ocelot_port_attr_get(struct net_device *dev,
@@ -1087,6 +1120,137 @@ static void ocelot_port_bridge_leave(struct ocelot_port *ocelot_port,
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
@@ -1113,6 +1277,14 @@ static int ocelot_netdevice_port_event(struct net_device *dev,
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
@@ -1200,6 +1372,11 @@ int ocelot_init(struct ocelot *ocelot)
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
2.17.0
