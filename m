Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3319C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A98B206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4F81PEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfBWABJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:01:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40812 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWABF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:01:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so1775093plb.7;
        Fri, 22 Feb 2019 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWkqsX7ExmIOXwBAx7TK2UJRBLvw/0J7RTNj9ngytR0=;
        b=n4F81PEPRZD8QvgEYWbr0uM8MQHPT3RN8xnlKaML7KayfpceS6YpoIzolOjjWUXBNv
         HACsLGvc65BPG+ngGB2HObdQLJxzkn7+GRQXHGd3iyPfqqREjbh1EcUCwo8yDEobad5A
         yngy4nvUp42aXjJ5R4/Ed0jtnnRixXdVuj6fpaq2RY1a2F2oXOPgD0b9vl+sL+WI5au0
         kiHczUaHYikLPMxt1Zjsvh5c2Y/IcNU62QYp4YvS1N7WBlYhmLdwXroJeLXyXFzGhGsm
         hpqrmEAxH4rOBhgGB98q2en+Vf6RQ5luoRim/FgQeGSiMxk1X/JrmW1vfTdUXah/9q5U
         Hbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWkqsX7ExmIOXwBAx7TK2UJRBLvw/0J7RTNj9ngytR0=;
        b=t9B3jH6z64aDfwViJ57wG1YUQmtUCTLsA6Ipb8a+8Xf7JnJ0Jfxsr42zYSuY8bKhFg
         S4qWJxnvvZno1dtBNK3InWqJ+waH48FymAJuXaX5FMIJiITaMttzh4whqms737XdUrbb
         HPyJDikuFTUNsyA3mjODT5uvYkJQ2z3EAoVq1AA0br1Ts/Mqj4KGivn7EeOlfj803CW1
         B8QsOiaLprMqOL5tuHY9m+l7voc6mzKYpDeHHlcphz/IKYmy/6B/HOf6kf/BjlIr9jvK
         ciWcjWW5H2NR3pus60B3nxoH/fy+t1/boAlY0X1sd/RSm6pCUlahEljlFGn2gxokZ21J
         2DWg==
X-Gm-Message-State: AHQUAub5thYo3GAscXqz18HxYnRAv9uWOggpd0Ku71pFffrQILHwWpRm
        ZLjO671uwv/OF+P8lbQw7iB3QjAt
X-Google-Smtp-Source: AHgI3Iai75V/4A41q0mtVVeQCrOn6yU4yoqgZ2ch8v3+1y2MzZRMb0qMIB+wd38T2JmJoaHG44gKYA==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr6758601plb.256.1550880063583;
        Fri, 22 Feb 2019 16:01:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:01:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:27 -0800
Message-Id: <20190222235927.10295-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 27 +++++++++++++++++++++
 net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 45310ddf2d7e..ca56b7487540 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -136,6 +136,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -164,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
@@ -216,7 +224,15 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans));
+
 #define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
+
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -303,6 +319,17 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
+static inline int
+switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	return 0;
+}
+
 #define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
 
 #endif
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..94400f5b8e07 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -697,3 +697,54 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(switchdev_handle_port_obj_del);
+
+static int __switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (check_cb(dev)) {
+		port_attr_info->handled = true;
+		return set_cb(dev, port_attr_info->attr,
+			      port_attr_info->trans);
+	}
+
+	/* Switch ports might be stacked under e.g. a LAG. Ignore the
+	 * unsupported devices, another driver might be able to handle them. But
+	 * propagate to the callers any hard errors.
+	 *
+	 * If the driver does its own bookkeeping of stacked ports, it's not
+	 * necessary to go through this helper.
+	 */
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		err = __switchdev_handle_port_attr_set(lower_dev, port_attr_info,
+						       check_cb, set_cb);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return err;
+}
+
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	int err;
+
+	err = __switchdev_handle_port_attr_set(dev, port_attr_info, check_cb,
+					       set_cb);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+	return err;
+}
+EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
-- 
2.17.1


From ba4f6d2c1528229131147b177722c1714df8231e Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 31 Jan 2019 11:10:34 -0800
Subject: [PATCH 2/8] rocker: Handle SWITCHDEV_PORT_ATTR_SET

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
rocker_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 309a6bf9130c..fc772cf079cc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2710,6 +2710,19 @@ static bool rocker_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &rocker_port_netdev_ops;
 }
 
+static int
+rocker_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = rocker_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct rocker_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -2779,6 +2792,9 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 	if (!rocker_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
+
 	rocker_port = netdev_priv(dev);
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (WARN_ON(!switchdev_work))
@@ -2841,6 +2857,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1


From f80f3e7ac04da99d9cf3e3b8d12eccb1b49e6480 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 31 Jan 2019 13:26:26 -0800
Subject: [PATCH 3/8] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
dsa_slave_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index a78b2bba0332..49a5b29fe884 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1422,6 +1422,19 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+				      port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct dsa_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -1500,6 +1513,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1562,6 +1578,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1


From 001e6b9b955cb5035c79c223d07a1e47febac0af Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 31 Jan 2019 13:30:31 -0800
Subject: [PATCH 4/8] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET

Following patches will change the way we communicate setting a port's
attribute and use a notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
to handle stacking of devices.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 766f5b5f1cf5..c1aedfea3a31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *br_dev;
 	int err;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
 	/* Tunnel devices are not our uppers, so check their master instead */
 	br_dev = netdev_master_upper_dev_get_rcu(dev);
 	if (!br_dev)
@@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     mlxsw_sp_port_dev_check,
+						     mlxsw_sp_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1


From e3776307a8ec8ce8726cbbb338cf1988afd90310 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 31 Jan 2019 13:31:58 -0800
Subject: [PATCH 5/8] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET

Following patches will change the way we communicate setting a port's
attribute and use notifiers to perform those tasks.

Ocelot does not currently have an atomic notifier registered for
switchdev events, so we need to register one in order to deal with
atomic context SWITCHDEV_PORT_ATTR_SET events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c       | 27 ++++++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h       |  1 +
 drivers/net/ethernet/mscc/ocelot_board.c |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..83a678b11757 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,28 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int ocelot_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	return NOTIFY_DONE;
+}
+
+struct notifier_block ocelot_switchdev_nb __read_mostly = {
+	.notifier_call = ocelot_switchdev_event,
+};
+EXPORT_SYMBOL(ocelot_switchdev_nb);
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1622,11 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ocelot_netdevice_dev_check,
+						     ocelot_port_attr_set);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 086775f7b52f..ba3b3380b4d0 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -499,6 +499,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 		      struct phy_device *phy);
 
 extern struct notifier_block ocelot_netdevice_nb;
+extern struct notifier_block ocelot_switchdev_nb;
 extern struct notifier_block ocelot_switchdev_blocking_nb;
 
 #endif
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index ca3ea2fbfcd0..2c1121d86edf 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -329,6 +329,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	}
 
 	register_netdevice_notifier(&ocelot_netdevice_nb);
+	register_switchdev_notifier(&ocelot_switchdev_nb);
 	register_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 
 	dev_info(&pdev->dev, "Ocelot switch probed\n");
@@ -345,6 +346,7 @@ static int mscc_ocelot_remove(struct platform_device *pdev)
 
 	ocelot_deinit(ocelot);
 	unregister_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
+	unregister_switchdev_notifier(&ocelot_switchdev_nb);
 	unregister_netdevice_notifier(&ocelot_netdevice_nb);
 
 	return 0;
-- 
2.17.1


From 3a90b167eddfaafb2d31dbcf139bfcca67fe6299 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 31 Jan 2019 13:33:31 -0800
Subject: [PATCH 6/8] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET

Following patches will change the way we communicate setting a port's
attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 018399ee8731..73efc2a5fd91 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1047,6 +1047,12 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1103,6 +1109,19 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1115,6 +1134,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1


From dbad862260ca273ef066ebb5ad42d007205d86ff Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 8 Feb 2019 16:21:26 -0800
Subject: [PATCH 7/8] net: switchdev: Replace port attr set SDO with a
 notification

Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
from all clients, which were migrated to use switchdev notification in
the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
(atomic) notifier chain accordingly.

Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/switchdev/switchdev.c | 96 +++++++++++----------------------------
 1 file changed, 26 insertions(+), 70 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 94400f5b8e07..a1f16836ef89 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-/**
- *	switchdev_port_attr_get - Get port attribute
- *
- *	@dev: port device
- *	@attr: attribute to get
- */
-int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	struct switchdev_attr first = {
-		.id = SWITCHDEV_ATTR_ID_UNDEFINED
-	};
-	int err = -EOPNOTSUPP;
+	int err;
+	int rc;
 
-	if (ops && ops->switchdev_port_attr_get)
-		return ops->switchdev_port_attr_get(dev, attr);
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
+	if (attr & SWITCHDEV_F_DEFER)
+		rc = call_switchdev_blocking_notifiers(nt, dev,
+						       &attr_info.info, NULL);
+	else
+		rc = call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
 		return err;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to get attr on
-	 * each port.  Return -ENODATA if attr values don't
-	 * compare across ports.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = switchdev_port_attr_get(lower_dev, attr);
-		if (err)
-			break;
-		if (first.id == SWITCHDEV_ATTR_ID_UNDEFINED)
-			first = *attr;
-		else if (memcmp(&first, attr, sizeof(*attr)))
-			return -ENODATA;
 	}
 
-	return err;
-}
-EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
-
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
-{
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	int err = -EOPNOTSUPP;
-
-	if (ops && ops->switchdev_port_attr_set) {
-		err = ops->switchdev_port_attr_set(dev, attr, trans);
-		goto done;
-	}
-
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
-		goto done;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
-	}
-
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -267,7 +221,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -286,7 +241,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
-- 
2.17.1


From 84dade3ae80b842ba1692618fba235f43a25c1ae Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 8 Feb 2019 16:22:06 -0800
Subject: [PATCH 8/8] net: Remove switchdev_ops

Now that we have converted all possible callers to using a switchdev
notifier for attributes we do not have a need for implementing
switchdev_ops anymore, and this can be removed from all drivers the
net_device structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 -----------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 --
 .../mellanox/mlxsw/spectrum_switchdev.c       | 12 -----------
 drivers/net/ethernet/mscc/ocelot.c            |  5 -----
 drivers/net/ethernet/rocker/rocker_main.c     |  5 -----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  5 -----
 include/linux/netdevice.h                     |  3 ---
 include/net/switchdev.h                       | 21 -------------------
 net/dsa/slave.c                               |  5 -----
 9 files changed, 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f018b0607dac..5d998517653a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3215,7 +3215,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
-	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
 	mlxsw_sp->ports[local_port] = mlxsw_sp_port;
 	err = register_netdev(dev);
 	if (err) {
@@ -3232,7 +3231,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
 err_port_pvid_set:
@@ -3275,7 +3273,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
@@ -3996,12 +3993,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_span_init;
 	}
 
-	err = mlxsw_sp_switchdev_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
-		goto err_switchdev_init;
-	}
-
 	err = mlxsw_sp_counter_pool_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
@@ -4072,8 +4063,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
-err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
@@ -4138,7 +4127,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8bb83d0facc2..b1342fe9ca48 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -381,8 +381,6 @@ extern const struct mlxsw_sp_sb_vals mlxsw_sp2_sb_vals;
 /* spectrum_switchdev.c */
 int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 			bool adding);
 void
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c1aedfea3a31..f6ce386c3036 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1938,10 +1938,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
-};
-
 static int
 mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 				struct mlxsw_sp_bridge_port *bridge_port,
@@ -3545,11 +3541,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp)
 	kfree(mlxsw_sp->bridge);
 }
 
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-	mlxsw_sp_port->dev->switchdev_ops = &mlxsw_sp_port_switchdev_ops;
-}
-
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-}
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 83a678b11757..a1d0d6e42533 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1660,7 +1656,6 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 
 	dev->netdev_ops = &ocelot_port_netdev_ops;
 	dev->ethtool_ops = &ocelot_ethtool_ops;
-	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index fc772cf079cc..c883aa89b7ca 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2142,10 +2142,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_set	= rocker_port_attr_set,
-};
-
 struct rocker_fib_event_work {
 	struct work_struct work;
 	union {
@@ -2599,7 +2595,6 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_port_dev_addr_init(rocker_port);
 	dev->netdev_ops = &rocker_port_netdev_ops;
 	dev->ethtool_ops = &rocker_port_ethtool_ops;
-	dev->switchdev_ops = &rocker_port_switchdev_ops;
 	netif_tx_napi_add(dev, &rocker_port->napi_tx, rocker_port_poll_tx,
 			  NAPI_POLL_WEIGHT);
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 73efc2a5fd91..ef7ec02da2fa 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -925,10 +925,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_set	= swdev_port_attr_set,
-};
-
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1455,7 +1451,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index aab4d9f6613d..a3c60ba35046 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1835,9 +1835,6 @@ struct net_device {
 #endif
 	const struct net_device_ops *netdev_ops;
 	const struct ethtool_ops *ethtool_ops;
-#ifdef CONFIG_NET_SWITCHDEV
-	const struct switchdev_ops *switchdev_ops;
-#endif
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	const struct l3mdev_ops	*l3mdev_ops;
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ca56b7487540..e4f751e19ecf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -112,21 +112,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -230,9 +215,6 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 			int (*set_cb)(struct net_device *dev,
 				      const struct switchdev_attr *attr,
 				      struct switchdev_trans *trans));
-
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
-
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -329,9 +311,6 @@ switchdev_handle_port_attr_set(struct net_device *dev,
 {
 	return 0;
 }
-
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 49a5b29fe884..49dc87309bd6 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1050,10 +1050,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
-static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
-};
-
 static struct device_type dsa_type = {
 	.name	= "dsa",
 };
@@ -1313,7 +1309,6 @@ int dsa_slave_create(struct dsa_port *port)
 	eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
-	slave_dev->switchdev_ops = &dsa_slave_switchdev_ops;
 	slave_dev->min_mtu = 0;
 	slave_dev->max_mtu = ETH_MAX_MTU;
 	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-- 
2.17.1

