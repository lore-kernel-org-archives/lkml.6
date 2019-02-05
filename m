Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485A32054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INtoh7+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfBEWNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:13:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42360 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbfBEWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id r15so2823134eds.9;
        Tue, 05 Feb 2019 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nTKEvjtWBy73hDRofBxiPlgKnlhsT5wlAGkCuq/lF+w=;
        b=INtoh7+1ZB7xss1HSJDuECHnOcvkVl0PT9AkHIfoxdAtMpZefQqrehir0kQH+mt5LS
         ecSWzOx8S0b3S6OpVhg/8b19aZw5Ie9sUrxoA2xhBY/V0m87hyPVmZfpwgs41FNI6mgY
         MfQpaoiZo54au3jRYX2nJLi9fJGDCaudeE2Fcb/KlX52pd3HF01iv7EosjaSzIUH8bwU
         PXD4i8D3t/7T/F6epY9YkXF/aUnZupyk2YE06FN2kqggxTgzTKhoid4GqDt5Ke6QGDQd
         Xu3kHolDoBmny6/hojO1G6foTm41pIf5Dha18yClAgF78lQ9QTSc08CbDItO6/snwlTb
         o6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nTKEvjtWBy73hDRofBxiPlgKnlhsT5wlAGkCuq/lF+w=;
        b=EJ96tw5NvmKNkwY3ZBlxDEOIHM4Qfc76PtuR5e77kI4IvhfMSn4sETSGfaB2yuRNar
         aB3X5DmYiWPjM4duTBcjTES5ndhHVAXLGtISUghWmQ54uT7Jggu7uEKSUQjXgIEXpsmr
         qm1fOysNRvWWik9wHtclhXDQVQIlsahw/Z8dDVQtLOru+DSZiQCJYTldQm5y2KGzPvUe
         w2q5NnS7+MkNbjzmatnpSun8ypT3YGp3o/SAcuRRb7Ht8S+8xe2fQczeyGI3+Bqp6FXO
         bm9m6lkJkN1A/LsOJk1b3TF7SMhiucV0pRfZY6mK9NJ6nV5bodiGcY49cB+vH6REMFlJ
         z7Zw==
X-Gm-Message-State: AHQUAuYHODVGnCktJFTvmv4Nr+su51jXeCe0kquiUa9wGaFCnxzDCPYC
        uxKVKaG8RVQkobZOOK5Ryf6J/RN7
X-Google-Smtp-Source: AHgI3IYpiUMbyRDxcyIbI1c2afURUbOAIlX0upFkPrCd9x9jDmoFtDzRy1OXBioWyUss169p2npm1A==
X-Received: by 2002:a17:906:4058:: with SMTP id y24mr5085850ejj.230.1549404809111;
        Tue, 05 Feb 2019 14:13:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v2 01/12] net: Introduce ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:00 -0800
Message-Id: <20190205221311.18476-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_ops, create a dedicated NDO
operation for getting the port's parent identifier. There are
essentially two classes of drivers that need to implement getting the
port's parent ID which are VF/PF drivers with a built-in switch, and
pure switchdev drivers such as mlxsw, ocelot, dsa etc.

We introduce a helper function: dev_get_port_parent_id() which supports
recursing into the lower devices to obtain the first port's parent ID.

Convert the bridge, core and ipv4 multicast routing code to check for
such ndo_get_port_parent_id() and call the helper functino when valid
before falling back to switchdev_port_attr_get(). This will allow us to
convert all relevant drivers in one go instead of having to implement
both switchdev_port_attr_get() and ndo_get_port_parent_id() operations,
then get rid of switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/netdevice.h |  9 +++++++
 net/bridge/br_switchdev.c |  9 +++++--
 net/core/dev.c            | 57 +++++++++++++++++++++++++++++++++++++++
 net/core/net-sysfs.c      |  7 ++++-
 net/core/rtnetlink.c      |  6 ++++-
 net/ipv4/ipmr.c           |  8 +++++-
 6 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ba57d0ba425e..1d95e634f3fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1188,6 +1188,10 @@ struct dev_ifalias {
  *	not implement this, it is assumed that the hw is not able to have
  *	multiple net devices on single physical port.
  *
+ * int (*ndo_get_port_parent_id)(struct net_device *dev,
+ *				 struct netdev_phys_item_id *ppid)
+ *	Called to get the parent ID of the physical port of this device.
+ *
  * void (*ndo_udp_tunnel_add)(struct net_device *dev,
  *			      struct udp_tunnel_info *ti);
  *	Called by UDP tunnel to notify a driver about the UDP port and socket
@@ -1412,6 +1416,8 @@ struct net_device_ops {
 						      bool new_carrier);
 	int			(*ndo_get_phys_port_id)(struct net_device *dev,
 							struct netdev_phys_item_id *ppid);
+	int			(*ndo_get_port_parent_id)(struct net_device *dev,
+							  struct netdev_phys_item_id *ppid);
 	int			(*ndo_get_phys_port_name)(struct net_device *dev,
 							  char *name, size_t len);
 	void			(*ndo_udp_tunnel_add)(struct net_device *dev,
@@ -3651,6 +3657,9 @@ int dev_get_phys_port_id(struct net_device *dev,
 			 struct netdev_phys_item_id *ppid);
 int dev_get_phys_port_name(struct net_device *dev,
 			   char *name, size_t len);
+int dev_get_port_parent_id(struct net_device *dev,
+			   struct netdev_phys_item_id *ppid, bool recurse);
+bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
 int dev_change_proto_down(struct net_device *dev, bool proto_down);
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 4d2b9eb7604a..06b0ae44585f 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -14,7 +14,8 @@ static int br_switchdev_mark_get(struct net_bridge *br, struct net_device *dev)
 
 	/* dev is yet to be added to the port list. */
 	list_for_each_entry(p, &br->port_list, list) {
-		if (switchdev_port_same_parent_id(dev, p->dev))
+		if (netdev_port_same_parent_id(dev, p->dev) ||
+		    switchdev_port_same_parent_id(dev, p->dev))
 			return p->offload_fwd_mark;
 	}
 
@@ -23,6 +24,7 @@ static int br_switchdev_mark_get(struct net_bridge *br, struct net_device *dev)
 
 int nbp_switchdev_mark_set(struct net_bridge_port *p)
 {
+	const struct net_device_ops *ops = p->dev->netdev_ops;
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
 		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
@@ -31,7 +33,10 @@ int nbp_switchdev_mark_set(struct net_bridge_port *p)
 
 	ASSERT_RTNL();
 
-	err = switchdev_port_attr_get(p->dev, &attr);
+	if (ops->ndo_get_port_parent_id)
+		err = dev_get_port_parent_id(p->dev, &attr.u.ppid, true);
+	else
+		err = switchdev_port_attr_get(p->dev, &attr);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
diff --git a/net/core/dev.c b/net/core/dev.c
index bfa4be42afff..8c6d5cf8a308 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7877,6 +7877,63 @@ int dev_get_phys_port_name(struct net_device *dev,
 }
 EXPORT_SYMBOL(dev_get_phys_port_name);
 
+/**
+ *	dev_get_port_parent_id - Get the device's port parent identifier
+ *	@dev: network device
+ *	@ppid: pointer to a storage for the port's parent identifier
+ *	@recurse: allow/disallow recursion to lower devices
+ *
+ *	Get the devices's port parent identifier
+ */
+int dev_get_port_parent_id(struct net_device *dev,
+			   struct netdev_phys_item_id *ppid,
+			   bool recurse)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	struct netdev_phys_item_id first = { };
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (ops->ndo_get_port_parent_id)
+		return ops->ndo_get_port_parent_id(dev, ppid);
+
+	if (!recurse)
+		return err;
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		err = dev_get_port_parent_id(lower_dev, ppid, recurse);
+		if (err)
+			break;
+		if (!first.id_len)
+			first = *ppid;
+		else if (memcmp(&first, ppid, sizeof(*ppid)))
+			return -ENODATA;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(dev_get_port_parent_id);
+
+/**
+ *	netdev_port_same_parent_id - Indicate if two network devices have
+ *	the same port parent identifier
+ *	@a: first network device
+ *	@b: second network device
+ */
+bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
+{
+	struct netdev_phys_item_id a_id = { };
+	struct netdev_phys_item_id b_id = { };
+
+	if (dev_get_port_parent_id(a, &a_id, true) ||
+	    dev_get_port_parent_id(b, &b_id, true))
+		return false;
+
+	return netdev_phys_item_id_same(&a_id, &b_id);
+}
+EXPORT_SYMBOL(netdev_port_same_parent_id);
+
 /**
  *	dev_change_proto_down - update protocol port state information
  *	@dev: device
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ff9fd2bb4ce4..4eace9f1dcf9 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -495,6 +495,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
 	ssize_t ret = -EINVAL;
 
 	if (!rtnl_trylock())
@@ -507,7 +508,11 @@ static ssize_t phys_switch_id_show(struct device *dev,
 			.flags = SWITCHDEV_F_NO_RECURSE,
 		};
 
-		ret = switchdev_port_attr_get(netdev, &attr);
+		if (ops->ndo_get_port_parent_id)
+			ret = dev_get_port_parent_id(netdev, &attr.u.ppid,
+						     false);
+		else
+			ret = switchdev_port_attr_get(netdev, &attr);
 		if (!ret)
 			ret = sprintf(buf, "%*phN\n", attr.u.ppid.id_len,
 				      attr.u.ppid.id);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f5a98082ac7a..90dd02c1f561 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1146,6 +1146,7 @@ static int rtnl_phys_port_name_fill(struct sk_buff *skb, struct net_device *dev)
 
 static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
 {
+	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
 	struct switchdev_attr attr = {
 		.orig_dev = dev,
@@ -1153,7 +1154,10 @@ static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
 		.flags = SWITCHDEV_F_NO_RECURSE,
 	};
 
-	err = switchdev_port_attr_get(dev, &attr);
+	if (ops->ndo_get_port_parent_id)
+		err = dev_get_port_parent_id(dev, &attr.u.ppid, false);
+	else
+		err = switchdev_port_attr_get(dev, &attr);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index fb99002c3d4e..c71bcc42d66d 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -837,6 +837,7 @@ static void ipmr_update_thresholds(struct mr_table *mrt, struct mr_mfc *cache,
 static int vif_add(struct net *net, struct mr_table *mrt,
 		   struct vifctl *vifc, int mrtsock)
 {
+	const struct net_device_ops *ops;
 	int vifi = vifc->vifc_vifi;
 	struct switchdev_attr attr = {
 		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
@@ -920,7 +921,12 @@ static int vif_add(struct net *net, struct mr_table *mrt,
 			(VIFF_TUNNEL | VIFF_REGISTER));
 
 	attr.orig_dev = dev;
-	if (!switchdev_port_attr_get(dev, &attr)) {
+	ops = dev->netdev_ops;
+	if (ops->ndo_get_port_parent_id &&
+	    !dev_get_port_parent_id(dev, &attr.u.ppid, true)) {
+		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
+		v->dev_parent_id.id_len = attr.u.ppid.id_len;
+	} else if (!switchdev_port_attr_get(dev, &attr)) {
 		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
 		v->dev_parent_id.id_len = attr.u.ppid.id_len;
 	} else {
-- 
2.17.1

