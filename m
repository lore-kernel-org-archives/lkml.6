Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933449AbeCGOTA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:19:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37540 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933407AbeCGOSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:18:53 -0500
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>, ymarkman@marvell.com,
        nadavh@marvell.com, stefanc@marvell.com
Subject: [PATCH net-next 1/2] net: mvpp2: Simplify MAC filtering function parameters
Date: Wed,  7 Mar 2018 15:18:03 +0100
Message-Id: <20180307141804.348-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180307141804.348-1-maxime.chevallier@bootlin.com>
References: <20180307141804.348-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvpp2_prs_mac_da_accept function takes into parameter both the
struct representing the controller and the port id. This is meaningful
when we want to create TCAM entries for non-initialized ports, but in
this case we expect the port to be initialized before starting adding or
removing MAC addresses to the per-port filter.

This commit changes the function so that it takes struct mvpp2_port as
a parameter instead.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index ac0a0dc8f157..7820906eca8a 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -3817,16 +3817,17 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 }
 
 /* Update parser's mac da entry */
-static int mvpp2_prs_mac_da_accept(struct mvpp2 *priv, int port,
-				   const u8 *da, bool add)
+static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,
+				   bool add)
 {
-	struct mvpp2_prs_entry *pe;
-	unsigned int pmap, len, ri;
 	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	struct mvpp2 *priv = port->priv;
+	unsigned int pmap, len, ri;
+	struct mvpp2_prs_entry *pe;
 	int tid;
 
 	/* Scan TCAM and see if entry with this <MAC DA, port> already exist */
-	pe = mvpp2_prs_mac_da_range_find(priv, (1 << port), da, mask,
+	pe = mvpp2_prs_mac_da_range_find(priv, BIT(port->id), da, mask,
 					 MVPP2_PRS_UDF_MAC_DEF);
 
 	/* No such entry */
@@ -3861,7 +3862,7 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2 *priv, int port,
 	}
 
 	/* Update port mask */
-	mvpp2_prs_tcam_port_set(pe, port, add);
+	mvpp2_prs_tcam_port_set(pe, port->id, add);
 
 	/* Invalidate the entry if no ports are left enabled */
 	pmap = mvpp2_prs_tcam_port_map_get(pe);
@@ -3917,13 +3918,12 @@ static int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 	int err;
 
 	/* Remove old parser entry */
-	err = mvpp2_prs_mac_da_accept(port->priv, port->id, dev->dev_addr,
-				      false);
+	err = mvpp2_prs_mac_da_accept(port, dev->dev_addr, false);
 	if (err)
 		return err;
 
 	/* Add new parser entry */
-	err = mvpp2_prs_mac_da_accept(port->priv, port->id, da, true);
+	err = mvpp2_prs_mac_da_accept(port, da, true);
 	if (err)
 		return err;
 
@@ -3959,7 +3959,8 @@ static void mvpp2_prs_mcast_del_all(struct mvpp2 *priv, int port)
 
 		if (is_multicast_ether_addr(da) && !is_broadcast_ether_addr(da))
 			/* Delete this entry */
-			mvpp2_prs_mac_da_accept(priv, port, da, false);
+			mvpp2_prs_mac_da_accept(priv->port_list[port], da,
+						false);
 	}
 }
 
@@ -7380,15 +7381,14 @@ static int mvpp2_open(struct net_device *dev)
 			0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int err;
 
-	err = mvpp2_prs_mac_da_accept(port->priv, port->id, mac_bcast, true);
+	err = mvpp2_prs_mac_da_accept(port, mac_bcast, true);
 	if (err) {
 		netdev_err(dev, "mvpp2_prs_mac_da_accept BC failed\n");
 		return err;
 	}
-	err = mvpp2_prs_mac_da_accept(port->priv, port->id,
-				      dev->dev_addr, true);
+	err = mvpp2_prs_mac_da_accept(port, dev->dev_addr, true);
 	if (err) {
-		netdev_err(dev, "mvpp2_prs_mac_da_accept MC failed\n");
+		netdev_err(dev, "mvpp2_prs_mac_da_accept own addr failed\n");
 		return err;
 	}
 	err = mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH);
@@ -7520,7 +7520,7 @@ static void mvpp2_set_rx_mode(struct net_device *dev)
 
 	if (!allmulti) {
 		netdev_for_each_mc_addr(ha, dev) {
-			if (mvpp2_prs_mac_da_accept(priv, id, ha->addr, true)) {
+			if (mvpp2_prs_mac_da_accept(port, ha->addr, true)) {
 				allmulti = true;
 				goto retry;
 			}
-- 
2.11.0
