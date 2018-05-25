Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbeEYDwX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:52:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45699 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbeEYDwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:52:20 -0400
X-Google-Smtp-Source: ADUXVKLiTUdVDjfCAVQeS/jORsqA7Em66vupICOggxNB4uig6uHuB83/oQB+kOz/pwyOyfCEZdsJdQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: dsa_loop: Make dynamic debugging helpful
Date: Thu, 24 May 2018 20:52:14 -0700
Message-Id: <20180525035215.19341-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant debug prints from phy_read/write since we can trace those
calls through trace events. Enhance dynamic debug prints to print arguments
which helps figuring how what is going on at the driver level with higher level
configuration interfaces.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 58f14af04639..816f34d64736 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -67,7 +67,7 @@ static struct phy_device *phydevs[PHY_MAX_ADDR];
 static enum dsa_tag_protocol dsa_loop_get_protocol(struct dsa_switch *ds,
 						   int port)
 {
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d\n", __func__, port);
 
 	return DSA_TAG_PROTO_NONE;
 }
@@ -124,8 +124,6 @@ static int dsa_loop_phy_read(struct dsa_switch *ds, int port, int regnum)
 	struct mii_bus *bus = ps->bus;
 	int ret;
 
-	dev_dbg(ds->dev, "%s\n", __func__);
-
 	ret = mdiobus_read_nested(bus, ps->port_base + port, regnum);
 	if (ret < 0)
 		ps->ports[port].mib[DSA_LOOP_PHY_READ_ERR].val++;
@@ -142,8 +140,6 @@ static int dsa_loop_phy_write(struct dsa_switch *ds, int port,
 	struct mii_bus *bus = ps->bus;
 	int ret;
 
-	dev_dbg(ds->dev, "%s\n", __func__);
-
 	ret = mdiobus_write_nested(bus, ps->port_base + port, regnum, value);
 	if (ret < 0)
 		ps->ports[port].mib[DSA_LOOP_PHY_WRITE_ERR].val++;
@@ -156,7 +152,8 @@ static int dsa_loop_phy_write(struct dsa_switch *ds, int port,
 static int dsa_loop_port_bridge_join(struct dsa_switch *ds, int port,
 				     struct net_device *bridge)
 {
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d, bridge: %s\n",
+		__func__, port, bridge->name);
 
 	return 0;
 }
@@ -164,19 +161,22 @@ static int dsa_loop_port_bridge_join(struct dsa_switch *ds, int port,
 static void dsa_loop_port_bridge_leave(struct dsa_switch *ds, int port,
 				       struct net_device *bridge)
 {
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d, bridge: %s\n",
+		__func__, port, bridge->name);
 }
 
 static void dsa_loop_port_stp_state_set(struct dsa_switch *ds, int port,
 					u8 state)
 {
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d, state: %d\n",
+		__func__, port, state);
 }
 
 static int dsa_loop_port_vlan_filtering(struct dsa_switch *ds, int port,
 					bool vlan_filtering)
 {
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d, vlan_filtering: %d\n",
+		__func__, port, vlan_filtering);
 
 	return 0;
 }
@@ -188,7 +188,8 @@ dsa_loop_port_vlan_prepare(struct dsa_switch *ds, int port,
 	struct dsa_loop_priv *ps = ds->priv;
 	struct mii_bus *bus = ps->bus;
 
-	dev_dbg(ds->dev, "%s\n", __func__);
+	dev_dbg(ds->dev, "%s: port: %d, vlan: %d-%d",
+		__func__, port, vlan->vid_begin, vlan->vid_end);
 
 	/* Just do a sleeping operation to make lockdep checks effective */
 	mdiobus_read(bus, ps->port_base + port, MII_BMSR);
@@ -209,8 +210,6 @@ static void dsa_loop_port_vlan_add(struct dsa_switch *ds, int port,
 	struct dsa_loop_vlan *vl;
 	u16 vid;
 
-	dev_dbg(ds->dev, "%s\n", __func__);
-
 	/* Just do a sleeping operation to make lockdep checks effective */
 	mdiobus_read(bus, ps->port_base + port, MII_BMSR);
 
@@ -222,6 +221,9 @@ static void dsa_loop_port_vlan_add(struct dsa_switch *ds, int port,
 			vl->untagged |= BIT(port);
 		else
 			vl->untagged &= ~BIT(port);
+
+		dev_dbg(ds->dev, "%s: port: %d vlan: %d, %stagged, pvid: %d\n",
+			__func__, port, vid, untagged ? "un" : "", pvid);
 	}
 
 	if (pvid)
@@ -237,8 +239,6 @@ static int dsa_loop_port_vlan_del(struct dsa_switch *ds, int port,
 	struct dsa_loop_vlan *vl;
 	u16 vid, pvid = ps->pvid;
 
-	dev_dbg(ds->dev, "%s\n", __func__);
-
 	/* Just do a sleeping operation to make lockdep checks effective */
 	mdiobus_read(bus, ps->port_base + port, MII_BMSR);
 
@@ -251,6 +251,9 @@ static int dsa_loop_port_vlan_del(struct dsa_switch *ds, int port,
 
 		if (pvid == vid)
 			pvid = 1;
+
+		dev_dbg(ds->dev, "%s: port: %d vlan: %d, %stagged, pvid: %d\n",
+			__func__, port, vid, untagged ? "un" : "", pvid);
 	}
 	ps->pvid = pvid;
 
-- 
2.14.1
