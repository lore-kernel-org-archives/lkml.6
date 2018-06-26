Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75F526A8F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75F526A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbeFZMbc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:31:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935173AbeFZMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:30:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4A952207D4; Tue, 26 Jun 2018 14:30:56 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 145B1203B0;
        Tue, 26 Jun 2018 14:30:56 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v2 2/2] net: mscc: ocelot: add VLAN filtering
Date:   Tue, 26 Jun 2018 14:28:49 +0200
Message-Id: <20180626122849.13174-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
References: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

Add hardware VLAN filtering offloading on ocelot.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 285 ++++++++++++++++++++++++++++-
 1 file changed, 283 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index e154bdd1d12d..88d6c6396489 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -148,12 +148,191 @@ static inline int ocelot_vlant_wait_for_completion(struct ocelot *ocelot)
 	return 0;
 }
 
+static int ocelot_vlant_set_mask(struct ocelot *ocelot, u16 vid, u32 mask)
+{
+	/* Select the VID to configure */
+	ocelot_write(ocelot, ANA_TABLES_VLANTIDX_V_INDEX(vid),
+		     ANA_TABLES_VLANTIDX);
+	/* Set the vlan port members mask and issue a write command */
+	ocelot_write(ocelot, ANA_TABLES_VLANACCESS_VLAN_PORT_MASK(mask) |
+			     ANA_TABLES_VLANACCESS_CMD_WRITE,
+		     ANA_TABLES_VLANACCESS);
+
+	return ocelot_vlant_wait_for_completion(ocelot);
+}
+
+static void ocelot_vlan_mode(struct ocelot_port *port,
+			     netdev_features_t features)
+{
+	struct ocelot *ocelot = port->ocelot;
+	u8 p = port->chip_port;
+	u32 val;
+
+	/* Filtering */
+	val = ocelot_read(ocelot, ANA_VLANMASK);
+	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		val |= BIT(p);
+	else
+		val &= ~BIT(p);
+	ocelot_write(ocelot, val, ANA_VLANMASK);
+}
+
+static void ocelot_vlan_port_apply(struct ocelot *ocelot,
+				   struct ocelot_port *port)
+{
+	u32 val;
+
+	/* Ingress clasification (ANA_PORT_VLAN_CFG) */
+	/* Default vlan to clasify for untagged frames (may be zero) */
+	val = ANA_PORT_VLAN_CFG_VLAN_VID(port->pvid);
+	if (port->vlan_aware)
+		val |= ANA_PORT_VLAN_CFG_VLAN_AWARE_ENA |
+		       ANA_PORT_VLAN_CFG_VLAN_POP_CNT(1);
+
+	ocelot_rmw_gix(ocelot, val,
+		       ANA_PORT_VLAN_CFG_VLAN_VID_M |
+		       ANA_PORT_VLAN_CFG_VLAN_AWARE_ENA |
+		       ANA_PORT_VLAN_CFG_VLAN_POP_CNT_M,
+		       ANA_PORT_VLAN_CFG, port->chip_port);
+
+	/* Drop frames with multicast source address */
+	val = ANA_PORT_DROP_CFG_DROP_MC_SMAC_ENA;
+	if (port->vlan_aware && !port->vid)
+		/* If port is vlan-aware and tagged, drop untagged and priority
+		 * tagged frames.
+		 */
+		val |= ANA_PORT_DROP_CFG_DROP_UNTAGGED_ENA |
+		       ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
+		       ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA;
+	ocelot_write_gix(ocelot, val, ANA_PORT_DROP_CFG, port->chip_port);
+
+	/* Egress configuration (REW_TAG_CFG): VLAN tag type to 8021Q. */
+	val = REW_TAG_CFG_TAG_TPID_CFG(0);
+
+	if (port->vlan_aware) {
+		if (port->vid)
+			/* Tag all frames except when VID == DEFAULT_VLAN */
+			val |= REW_TAG_CFG_TAG_CFG(1);
+		else
+			/* Tag all frames */
+			val |= REW_TAG_CFG_TAG_CFG(3);
+	}
+	ocelot_rmw_gix(ocelot, val,
+		       REW_TAG_CFG_TAG_TPID_CFG_M |
+		       REW_TAG_CFG_TAG_CFG_M,
+		       REW_TAG_CFG, port->chip_port);
+
+	/* Set default VLAN and tag type to 8021Q. */
+	val = REW_PORT_VLAN_CFG_PORT_TPID(ETH_P_8021Q) |
+	      REW_PORT_VLAN_CFG_PORT_VID(port->vid);
+	ocelot_rmw_gix(ocelot, val,
+		       REW_PORT_VLAN_CFG_PORT_TPID_M |
+		       REW_PORT_VLAN_CFG_PORT_VID_M,
+		       REW_PORT_VLAN_CFG, port->chip_port);
+}
+
+static int ocelot_vlan_vid_add(struct net_device *dev, u16 vid, bool pvid,
+			       bool untagged)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	int ret;
+
+	/* Add the port MAC address to with the right VLAN information */
+	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr, vid,
+			  ENTRYTYPE_LOCKED);
+
+	/* Make the port a member of the VLAN */
+	ocelot->vlan_mask[vid] |= BIT(port->chip_port);
+	ret = ocelot_vlant_set_mask(ocelot, vid, ocelot->vlan_mask[vid]);
+	if (ret)
+		return ret;
+
+	/* Default ingress vlan classification */
+	if (pvid)
+		port->pvid = vid;
+
+	/* Untagged egress vlan clasification */
+	if (untagged)
+		port->vid = vid;
+
+	ocelot_vlan_port_apply(ocelot, port);
+
+	return 0;
+}
+
+static int ocelot_vlan_vid_del(struct net_device *dev, u16 vid)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	int ret;
+
+	/* 8021q removes VID 0 on module unload for all interfaces
+	 * with VLAN filtering feature. We need to keep it to receive
+	 * untagged traffic.
+	 */
+	if (vid == 0)
+		return 0;
+
+	/* Del the port MAC address to with the right VLAN information */
+	ocelot_mact_forget(ocelot, dev->dev_addr, vid);
+
+	/* Stop the port from being a member of the vlan */
+	ocelot->vlan_mask[vid] &= ~BIT(port->chip_port);
+	ret = ocelot_vlant_set_mask(ocelot, vid, ocelot->vlan_mask[vid]);
+	if (ret)
+		return ret;
+
+	/* Ingress */
+	if (port->pvid == vid)
+		port->pvid = 0;
+
+	/* Egress */
+	if (port->vid == vid)
+		port->vid = 0;
+
+	ocelot_vlan_port_apply(ocelot, port);
+
+	return 0;
+}
+
 static void ocelot_vlan_init(struct ocelot *ocelot)
 {
+	u16 port, vid;
+
 	/* Clear VLAN table, by default all ports are members of all VLANs */
 	ocelot_write(ocelot, ANA_TABLES_VLANACCESS_CMD_INIT,
 		     ANA_TABLES_VLANACCESS);
 	ocelot_vlant_wait_for_completion(ocelot);
+
+	/* Configure the port VLAN memberships */
+	for (vid = 1; vid < VLAN_N_VID; vid++) {
+		ocelot->vlan_mask[vid] = 0;
+		ocelot_vlant_set_mask(ocelot, vid, ocelot->vlan_mask[vid]);
+	}
+
+	/* Because VLAN filtering is enabled, we need VID 0 to get untagged
+	 * traffic.  It is added automatically if 8021q module is loaded, but
+	 * we can't rely on it since module may be not loaded.
+	 */
+	ocelot->vlan_mask[0] = GENMASK(ocelot->num_phys_ports - 1, 0);
+	ocelot_vlant_set_mask(ocelot, 0, ocelot->vlan_mask[0]);
+
+	/* Configure the CPU port to be VLAN aware */
+	ocelot_write_gix(ocelot, ANA_PORT_VLAN_CFG_VLAN_VID(0) |
+				 ANA_PORT_VLAN_CFG_VLAN_AWARE_ENA |
+				 ANA_PORT_VLAN_CFG_VLAN_POP_CNT(1),
+			 ANA_PORT_VLAN_CFG, ocelot->num_phys_ports);
+
+	/* Set vlan ingress filter mask to all ports but the CPU port by
+	 * default.
+	 */
+	ocelot_write(ocelot, GENMASK(9, 0), ANA_VLANMASK);
+
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		ocelot_write_gix(ocelot, 0, REW_PORT_VLAN_CFG, port);
+		ocelot_write_gix(ocelot, 0, REW_TAG_CFG, port);
+	}
 }
 
 /* Watermark encode
@@ -538,6 +717,20 @@ static int ocelot_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
 
+	if (!vid) {
+		if (!port->vlan_aware)
+			/* If the bridge is not VLAN aware and no VID was
+			 * provided, set it to pvid to ensure the MAC entry
+			 * matches incoming untagged packets
+			 */
+			vid = port->pvid;
+		else
+			/* If the bridge is VLAN aware a VID must be provided as
+			 * otherwise the learnt entry wouldn't match any frame.
+			 */
+			return -EINVAL;
+	}
+
 	return ocelot_mact_learn(ocelot, port->chip_port, addr, vid,
 				 ENTRYTYPE_NORMAL);
 }
@@ -689,6 +882,30 @@ static int ocelot_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	return ret;
 }
 
+static int ocelot_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
+				  u16 vid)
+{
+	return ocelot_vlan_vid_add(dev, vid, false, true);
+}
+
+static int ocelot_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
+				   u16 vid)
+{
+	return ocelot_vlan_vid_del(dev, vid);
+}
+
+static int ocelot_set_features(struct net_device *dev,
+			       netdev_features_t features)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	netdev_features_t changed = dev->features ^ features;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER)
+		ocelot_vlan_mode(port, features);
+
+	return 0;
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -700,6 +917,9 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_fdb_add			= ocelot_fdb_add,
 	.ndo_fdb_del			= ocelot_fdb_del,
 	.ndo_fdb_dump			= ocelot_fdb_dump,
+	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
+	.ndo_set_features		= ocelot_set_features,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -915,6 +1135,10 @@ static int ocelot_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ocelot_port_attr_ageing_set(ocelot_port, attr->u.ageing_time);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		ocelot_port->vlan_aware = attr->u.vlan_filtering;
+		ocelot_vlan_port_apply(ocelot_port->ocelot, ocelot_port);
+		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
 		ocelot_port_attr_mc_set(ocelot_port, !attr->u.mc_disabled);
 		break;
@@ -926,6 +1150,40 @@ static int ocelot_port_attr_set(struct net_device *dev,
 	return err;
 }
 
+static int ocelot_port_obj_add_vlan(struct net_device *dev,
+				    const struct switchdev_obj_port_vlan *vlan,
+				    struct switchdev_trans *trans)
+{
+	int ret;
+	u16 vid;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		ret = ocelot_vlan_vid_add(dev, vid,
+					  vlan->flags & BRIDGE_VLAN_INFO_PVID,
+					  vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ocelot_port_vlan_del_vlan(struct net_device *dev,
+				     const struct switchdev_obj_port_vlan *vlan)
+{
+	int ret;
+	u16 vid;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		ret = ocelot_vlan_vid_del(dev, vid);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct ocelot_multicast *ocelot_multicast_get(struct ocelot *ocelot,
 						     const unsigned char *addr,
 						     u16 vid)
@@ -952,7 +1210,7 @@ static int ocelot_port_obj_add_mdb(struct net_device *dev,
 	bool new = false;
 
 	if (!vid)
-		vid = 1;
+		vid = port->pvid;
 
 	mc = ocelot_multicast_get(ocelot, mdb->addr, vid);
 	if (!mc) {
@@ -993,7 +1251,7 @@ static int ocelot_port_obj_del_mdb(struct net_device *dev,
 	u16 vid = mdb->vid;
 
 	if (!vid)
-		vid = 1;
+		vid = port->pvid;
 
 	mc = ocelot_multicast_get(ocelot, mdb->addr, vid);
 	if (!mc)
@@ -1025,6 +1283,11 @@ static int ocelot_port_obj_add(struct net_device *dev,
 	int ret = 0;
 
 	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		ret = ocelot_port_obj_add_vlan(dev,
+					       SWITCHDEV_OBJ_PORT_VLAN(obj),
+					       trans);
+		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		ret = ocelot_port_obj_add_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj),
 					      trans);
@@ -1042,6 +1305,10 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	int ret = 0;
 
 	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		ret = ocelot_port_vlan_del_vlan(dev,
+						SWITCHDEV_OBJ_PORT_VLAN(obj));
+		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		ret = ocelot_port_obj_del_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
 		break;
@@ -1087,6 +1354,11 @@ static void ocelot_port_bridge_leave(struct ocelot_port *ocelot_port,
 
 	if (!ocelot->bridge_mask)
 		ocelot->hw_bridge_dev = NULL;
+
+	/* Clear bridge vlan settings before calling ocelot_vlan_port_apply */
+	ocelot_port->vlan_aware = 0;
+	ocelot_port->pvid = 0;
+	ocelot_port->vid = 0;
 }
 
 static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
@@ -1245,6 +1517,9 @@ static int ocelot_netdevice_port_event(struct net_device *dev,
 			else
 				ocelot_port_bridge_leave(ocelot_port,
 							 info->upper_dev);
+
+			ocelot_vlan_port_apply(ocelot_port->ocelot,
+					       ocelot_port);
 		}
 		if (netif_is_lag_master(info->upper_dev)) {
 			if (info->linking)
@@ -1330,6 +1605,9 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 	dev->ethtool_ops = &ocelot_ethtool_ops;
 	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
+	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
 	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
 	dev->dev_addr[ETH_ALEN - 1] += port;
 	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr, ocelot_port->pvid,
@@ -1341,6 +1619,9 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 		goto err_register_netdev;
 	}
 
+	/* Basic L2 initialization */
+	ocelot_vlan_port_apply(ocelot, ocelot_port);
+
 	return 0;
 
 err_register_netdev:
-- 
2.18.0

