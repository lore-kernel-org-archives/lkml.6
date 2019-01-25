Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4875F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfAYJzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:55:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42763 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfAYJzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:55:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A4207209B6; Fri, 25 Jan 2019 10:55:09 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 459BE20746;
        Fri, 25 Jan 2019 10:55:09 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Date:   Fri, 25 Jan 2019 10:55:06 +0100
Message-Id: <20190125095507.29334-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125095507.29334-1-miquel.raynal@bootlin.com>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user might apply a specific switch configuration, with specific
forwarding rules, VLAN, bridges, etc.

During suspend to RAM the switch power will be turned off and the
switch will lost its configuration. In an attempt to bring S2RAM
support to the mv88e6xxx DSA, let's first save these rules in a
per-chip list thanks to the mv88e6xxx_add/del_xxx_rule()
helpers. These helpers are then called from various callbacks:
* mv88e6xxx_port_fdb_add/del()
* mv88e6xxx_port_mdb_add/del()
* mv88e6xxx_port_vlan_add/del()
* mv88e6xxx_port_bridge_join/leave()
* mv88e6xxx_crosschip_bridge_join/leave()

To avoid recursion problems when replaying the rules, the content of
the above *_add()/*_join() callbacks has been moved in separate
helpers with a '_' prefix. Hence, each callback just calls the
corresponding helper and the corresponding *_add_xxx_rule().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
=================
* New patch: saves the forwarding/vlan/bridge rules when they are
  applied in a list. This way in the second patch when adding S2RAM
  support, we just need to replay these rules.

 drivers/net/dsa/mv88e6xxx/chip.c | 270 +++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/chip.h |  33 ++++
 2 files changed, 271 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8a517d8fb9d1..428177f80abd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -52,6 +52,111 @@ static void assert_reg_lock(struct mv88e6xxx_chip *chip)
 	}
 }
 
+static void mv88e6xxx_add_rule(struct mv88e6xxx_chip *chip, int port,
+			       enum mv88e6xxx_rule_type type,
+			       const unsigned char *addr, u16 vid,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       int dev, struct net_device *br)
+{
+	struct mv88e6xxx_rule *rule;
+
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule)
+		return;
+
+	rule->port = port;
+	rule->type = type;
+	switch (type) {
+	case FDB_RULE:
+	case MDB_RULE:
+		ether_addr_copy(rule->params.db.addr, addr);
+		rule->params.db.vid = vid;
+		break;
+	case VLAN_RULE:
+		rule->params.vlan = *vlan;
+		break;
+	case BRIDGE_RULE:
+		rule->params.br = br;
+		break;
+	case CC_BRIDGE_RULE:
+		rule->params.crosschip.dev = dev;
+		rule->params.crosschip.br = br;
+		break;
+	}
+
+	list_add_tail(&rule->node, &chip->rules);
+}
+
+static void mv88e6xxx_del_rule(struct mv88e6xxx_chip *chip, int port,
+			       enum mv88e6xxx_rule_type type,
+			       const unsigned char *addr, u16 vid,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       int dev, struct net_device *br)
+{
+	struct mv88e6xxx_rule *rule, *next;
+
+	list_for_each_entry_safe(rule, next, &chip->rules, node) {
+		if (rule->port != port || rule->type != type)
+			continue;
+
+		switch (type) {
+		case FDB_RULE:
+		case MDB_RULE:
+			if (!memcmp(rule->params.db.addr, addr, ETH_ALEN) &&
+			    rule->params.db.vid == vid)
+				goto found;
+			break;
+		case VLAN_RULE:
+			if (rule->params.vlan.flags == vlan->flags &&
+			    rule->params.vlan.vid_begin == vlan->vid_begin &&
+			    rule->params.vlan.vid_end == vlan->vid_end)
+				goto found;
+			break;
+		case BRIDGE_RULE:
+			if (rule->params.br == br)
+				goto found;
+			break;
+		case CC_BRIDGE_RULE:
+			if (rule->params.crosschip.br == br &&
+			    rule->params.crosschip.dev == dev)
+				goto found;
+			break;
+		default:
+			dev_warn(chip->dev, "Unknown rule type\n");
+			break;
+		}
+	}
+
+	dev_info(chip->dev, "Cannot delete rule: not found\n");
+
+	return;
+
+found:
+	list_del(&rule->node);
+	kfree(rule);
+}
+
+#define mv88e6xxx_add_fdb_rule(chip, port, addr, vid) \
+	mv88e6xxx_add_rule(chip, port, FDB_RULE, addr, vid, NULL, 0, NULL)
+#define mv88e6xxx_del_fdb_rule(chip, port, addr, vid) \
+	mv88e6xxx_del_rule(chip, port, FDB_RULE, addr, vid, NULL, 0, NULL)
+#define mv88e6xxx_add_mdb_rule(chip, port, addr, vid) \
+	mv88e6xxx_add_rule(chip, port, MDB_RULE, addr, vid, NULL, 0, NULL)
+#define mv88e6xxx_del_mdb_rule(chip, port, addr, vid) \
+	mv88e6xxx_del_rule(chip, port, MDB_RULE, addr, vid, NULL, 0, NULL)
+#define mv88e6xxx_add_vlan_rule(chip, port, vlan) \
+	mv88e6xxx_add_rule(chip, port, VLAN_RULE, NULL, 0, vlan, 0, NULL)
+#define mv88e6xxx_del_vlan_rule(chip, port, vlan) \
+	mv88e6xxx_del_rule(chip, port, VLAN_RULE, NULL, 0, vlan, 0, NULL)
+#define mv88e6xxx_add_bridge_rule(chip, port, br) \
+	mv88e6xxx_add_rule(chip, port, BRIDGE_RULE, NULL, 0, NULL, 0, br)
+#define mv88e6xxx_del_bridge_rule(chip, port, br) \
+	mv88e6xxx_del_rule(chip, port, BRIDGE_RULE, NULL, 0, NULL, 0, br)
+#define mv88e6xxx_add_cc_bridge_rule(chip, port, dev, br) \
+	mv88e6xxx_add_rule(chip, port, CC_BRIDGE_RULE, NULL, 0, NULL, dev, br)
+#define mv88e6xxx_del_cc_bridge_rule(chip, port, dev, br) \
+	mv88e6xxx_del_rule(chip, port, CC_BRIDGE_RULE, NULL, 0, NULL, dev, br)
+
 /* The switch ADDR[4:1] configuration pins define the chip SMI device address
  * (ADDR[0] is always zero, thus only even SMI addresses can be strapped).
  *
@@ -1674,8 +1779,8 @@ static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
 	return 0;
 }
 
-static int _mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
-				    u16 vid, u8 member)
+static int __mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
+				     u16 vid, u8 member)
 {
 	struct mv88e6xxx_vtu_entry vlan;
 	int err;
@@ -1693,19 +1798,19 @@ static int _mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_broadcast_setup(chip, vid);
 }
 
-static void mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
+static int _mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
 				    const struct switchdev_obj_port_vlan *vlan)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	u8 member;
 	u16 vid;
+	int err;
 
 	if (!chip->info->max_vid)
-		return;
+		return -EINVAL;
 
-	if (dsa_is_dsa_port(ds, port) || dsa_is_cpu_port(ds, port))
+	if (dsa_is_dsa_port(chip->ds, port) || dsa_is_cpu_port(chip->ds, port))
 		member = MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED;
 	else if (untagged)
 		member = MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNTAGGED;
@@ -1714,16 +1819,37 @@ static void mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
 
 	mutex_lock(&chip->reg_lock);
 
-	for (vid = vlan->vid_begin; vid <= vlan->vid_end; ++vid)
-		if (_mv88e6xxx_port_vlan_add(chip, port, vid, member))
-			dev_err(ds->dev, "p%d: failed to add VLAN %d%c\n", port,
-				vid, untagged ? 'u' : 't');
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; ++vid) {
+		err = __mv88e6xxx_port_vlan_add(chip, port, vid, member);
+		if (err) {
+			dev_err(chip->dev, "p%d: failed to add VLAN %d%c\n",
+				port, vid, untagged ? 'u' : 't');
+			goto out;
+		}
+	}
 
-	if (pvid && mv88e6xxx_port_set_pvid(chip, port, vlan->vid_end))
-		dev_err(ds->dev, "p%d: failed to set PVID %d\n", port,
-			vlan->vid_end);
+	if (pvid) {
+		err = mv88e6xxx_port_set_pvid(chip, port, vlan->vid_end);
+		if (err)
+			dev_err(chip->dev, "p%d: failed to set PVID %d\n",
+				port, vlan->vid_end);
+	}
 
+out:
 	mutex_unlock(&chip->reg_lock);
+
+	return err;
+}
+
+static void mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
+				    const struct switchdev_obj_port_vlan *vlan)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+
+	if (_mv88e6xxx_port_vlan_add(chip, port, vlan))
+		return;
+
+	mv88e6xxx_add_vlan_rule(chip, port, vlan);
 }
 
 static int _mv88e6xxx_port_vlan_del(struct mv88e6xxx_chip *chip,
@@ -1769,6 +1895,8 @@ static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
 	if (!chip->info->max_vid)
 		return -EOPNOTSUPP;
 
+	mv88e6xxx_del_vlan_rule(chip, port, vlan);
+
 	mutex_lock(&chip->reg_lock);
 
 	err = mv88e6xxx_port_get_pvid(chip, port, &pvid);
@@ -1793,10 +1921,9 @@ static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
-				  const unsigned char *addr, u16 vid)
+static int _mv88e6xxx_port_fdb_add(struct mv88e6xxx_chip *chip, int port,
+				   const unsigned char *addr, u16 vid)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
 	mutex_lock(&chip->reg_lock);
@@ -1807,12 +1934,29 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
+				  const unsigned char *addr, u16 vid)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	err = _mv88e6xxx_port_fdb_add(chip, port, addr, vid);
+	if (err)
+		return err;
+
+	mv88e6xxx_add_fdb_rule(chip, port, addr, vid);
+
+	return 0;
+}
+
 static int mv88e6xxx_port_fdb_del(struct dsa_switch *ds, int port,
 				  const unsigned char *addr, u16 vid)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
+	mv88e6xxx_del_fdb_rule(chip, port, addr, vid);
+
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_UNUSED);
@@ -1945,31 +2089,68 @@ static int mv88e6xxx_bridge_map(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
+static int _mv88e6xxx_port_bridge_join(struct mv88e6xxx_chip *chip, int port,
+				       struct net_device *br)
+{
+	int err;
+
+	mutex_lock(&chip->reg_lock);
+	err = mv88e6xxx_bridge_map(chip, br);
+	mutex_unlock(&chip->reg_lock);
+
+	return err;
+}
+
 static int mv88e6xxx_port_bridge_join(struct dsa_switch *ds, int port,
 				      struct net_device *br)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
-	mutex_lock(&chip->reg_lock);
-	err = mv88e6xxx_bridge_map(chip, br);
-	mutex_unlock(&chip->reg_lock);
+	err = _mv88e6xxx_port_bridge_join(chip, port, br);
+	if (err)
+		return err;
 
-	return err;
+	mv88e6xxx_add_bridge_rule(chip, port, br);
+
+	return 0;
 }
 
 static void mv88e6xxx_port_bridge_leave(struct dsa_switch *ds, int port,
 					struct net_device *br)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	mv88e6xxx_del_bridge_rule(chip, port, br);
 
 	mutex_lock(&chip->reg_lock);
-	if (mv88e6xxx_bridge_map(chip, br) ||
-	    mv88e6xxx_port_vlan_map(chip, port))
+	err = mv88e6xxx_bridge_map(chip, br);
+	if (!err)
+		err = mv88e6xxx_port_vlan_map(chip, port);
+
+	if (err)
 		dev_err(ds->dev, "failed to remap in-chip Port VLAN\n");
+
 	mutex_unlock(&chip->reg_lock);
 }
 
+static int _mv88e6xxx_crosschip_bridge_join(struct mv88e6xxx_chip *chip,
+					    int dev, int port,
+					    struct net_device *br)
+{
+	int err;
+
+	if (!mv88e6xxx_has_pvt(chip))
+		return 0;
+
+	mutex_lock(&chip->reg_lock);
+	err = mv88e6xxx_pvt_map(chip, dev, port);
+	mutex_unlock(&chip->reg_lock);
+
+	return err;
+}
+
 static int mv88e6xxx_crosschip_bridge_join(struct dsa_switch *ds, int dev,
 					   int port, struct net_device *br)
 {
@@ -1979,11 +2160,13 @@ static int mv88e6xxx_crosschip_bridge_join(struct dsa_switch *ds, int dev,
 	if (!mv88e6xxx_has_pvt(chip))
 		return 0;
 
-	mutex_lock(&chip->reg_lock);
-	err = mv88e6xxx_pvt_map(chip, dev, port);
-	mutex_unlock(&chip->reg_lock);
+	err = _mv88e6xxx_crosschip_bridge_join(chip, dev, port, br);
+	if (err)
+		return err;
 
-	return err;
+	mv88e6xxx_add_cc_bridge_rule(chip, port, dev, br);
+
+	return 0;
 }
 
 static void mv88e6xxx_crosschip_bridge_leave(struct dsa_switch *ds, int dev,
@@ -1994,6 +2177,8 @@ static void mv88e6xxx_crosschip_bridge_leave(struct dsa_switch *ds, int dev,
 	if (!mv88e6xxx_has_pvt(chip))
 		return;
 
+	mv88e6xxx_del_cc_bridge_rule(chip, port, dev, br);
+
 	mutex_lock(&chip->reg_lock);
 	if (mv88e6xxx_pvt_map(chip, dev, port))
 		dev_err(ds->dev, "failed to remap cross-chip Port VLAN\n");
@@ -4534,17 +4719,34 @@ static int mv88e6xxx_port_mdb_prepare(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int _mv88e6xxx_port_mdb_add(struct mv88e6xxx_chip *chip, int port,
+				   const unsigned char *addr, u16 vid)
+{
+	int err;
+
+	mutex_lock(&chip->reg_lock);
+	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
+					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+	mutex_unlock(&chip->reg_lock);
+
+	if (err)
+		dev_err(chip->dev,
+			"p%d: failed to load multicast MAC address\n", port);
+
+	return err;
+}
+
 static void mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				   const struct switchdev_obj_port_mdb *mdb)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
 
-	mutex_lock(&chip->reg_lock);
-	if (mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					 MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC))
-		dev_err(ds->dev, "p%d: failed to load multicast MAC address\n",
-			port);
-	mutex_unlock(&chip->reg_lock);
+	err = _mv88e6xxx_port_mdb_add(chip, port, mdb->addr, mdb->vid);
+	if (err)
+		return;
+
+	mv88e6xxx_add_mdb_rule(chip, port, mdb->addr, mdb->vid);
 }
 
 static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
@@ -4553,6 +4755,8 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
+	mv88e6xxx_del_mdb_rule(chip, port, mdb->addr, mdb->vid);
+
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_UNUSED);
@@ -4766,6 +4970,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out_mdio;
 
+	INIT_LIST_HEAD(&chip->rules);
+
 	return 0;
 
 out_mdio:
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index f9ecb7872d32..b5c8d6a8d9e7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -203,6 +203,36 @@ struct mv88e6xxx_port {
 	int serdes_irq;
 };
 
+enum mv88e6xxx_rule_type {
+	FDB_RULE,
+	MDB_RULE,
+	VLAN_RULE,
+	BRIDGE_RULE,
+	CC_BRIDGE_RULE,
+};
+
+struct mv88e6xxx_db_rule {
+	u8 addr[ETH_ALEN];
+	u16 vid;
+};
+
+struct mv88e6xxx_br_rule {
+	int dev;
+	struct net_device *br;
+};
+
+struct mv88e6xxx_rule {
+	int port;
+	enum mv88e6xxx_rule_type type;
+	union {
+		struct mv88e6xxx_db_rule db;
+		struct switchdev_obj_port_vlan vlan;
+		struct net_device *br;
+		struct mv88e6xxx_br_rule crosschip;
+	} params;
+	struct list_head node;
+};
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -285,6 +315,9 @@ struct mv88e6xxx_chip {
 
 	/* Array of port structures. */
 	struct mv88e6xxx_port ports[DSA_MAX_PORTS];
+
+	/* List of bridging rules to recover at resume */
+	struct list_head rules;
 };
 
 struct mv88e6xxx_bus_ops {
-- 
2.19.1

