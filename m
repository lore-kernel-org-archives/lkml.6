Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B84C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D12073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8JycExy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfBFRqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfBFRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so3410755pls.8;
        Wed, 06 Feb 2019 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTQuMDXybzEy13PR44sPjWjmSHRmeRN98zHu2/LCGyc=;
        b=b8JycExyqGZt/va0hrd1T/MSedN53Z+egyFTXz7gzweWuHQGSsMJ58K62Nj3QzqsR3
         keezTNF7QpPlDbSOVAMDP0oqgZLf42ILsBG3NZp95Vr8dHfSghgHKI9A77KvBVOvMgxz
         ZigWmH5+IDWajjoliT0GkKs/6q7qw/3Gsl5fQcYOCOucK52oLNq1ZycOvLPGqo3wJ9Nd
         RFzctS+2DSfuMy6BQXZ7Ea2ouXhefzLBY47mxItop37m6vLsYhDDfT0UiybapkdR5A0A
         NVnItY2IcNP9R17WCyC/flDKgej1TZyNto06J4xtiV+m4oVStlhPss8rjFxqU7Rghs4i
         6lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qTQuMDXybzEy13PR44sPjWjmSHRmeRN98zHu2/LCGyc=;
        b=DA940xki8fRSbTMv986Klo4H7v+DniN2i5bvfmb3/brMIx2zb+2Qdn6LM7mDeoGbVD
         aNXq+hHUi/pvJ1ENRj2/VGAg+OY+6AqvlIhfTzJHoitsrBiRabTMODrpDo4M91D6YdDW
         zp6OLUOXq709kxUi3hFxZpuhAWXiAq0WW9e0JgA00fMyL3R1bdFU95nEl2cQsChaWIwc
         JvThJBRiZOG/SgFndEMUFpaHFZeaBHhqhbaZDY62J+MaR7MOVGH2d+osdFFB9rm++o6i
         3N3B1MxOiSKfVeOvCAbTEvr6z6XLuMmHUPNTv1ea0aWLLTbCEts5+nh0PpD54pPnsqCU
         kdfg==
X-Gm-Message-State: AHQUAuaiK0R5Z3wYo8mU+1be2DuxCFl6dlFGimh7492SiU+ewHaClaEX
        mzsayzTuTvlJEM/VShr7yfDq9bD4
X-Google-Smtp-Source: AHgI3IaBy6B2j+R5n3Lq7gGaSIt3iINTyxPtxiVRvYqhaJo7sP5QWSBClI9Zm8iZ1JYsgMzbFLWjRA==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr11403863plu.122.1549475184694;
        Wed, 06 Feb 2019 09:46:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:23 -0800 (PST)
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
Subject: [PATCH net-next v4 12/12] net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID
Date:   Wed,  6 Feb 2019 09:45:46 -0800
Message-Id: <20190206174546.23597-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a dedicated NDO for getting a port's parent ID, get rid
of SWITCHDEV_ATTR_ID_PORT_PARENT_ID and convert all callers to use the
NDO exclusively. This is a preliminary change to getting rid of
switchdev_ops eventually.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 11 -----------
 net/bridge/br_switchdev.c | 14 +++-----------
 net/core/net-sysfs.c      | 19 ++++---------------
 net/core/rtnetlink.c      | 16 +++-------------
 net/ipv4/ipmr.c           | 19 +++++--------------
 net/switchdev/switchdev.c | 20 --------------------
 6 files changed, 15 insertions(+), 84 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 63843ae5dc81..5e87b54c5dc5 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -43,7 +43,6 @@ static inline bool switchdev_trans_ph_commit(struct switchdev_trans *trans)
 
 enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
-	SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
@@ -61,7 +60,6 @@ struct switchdev_attr {
 	void *complete_priv;
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
-		struct netdev_phys_item_id ppid;	/* PORT_PARENT_ID */
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
 		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
@@ -208,9 +206,6 @@ void switchdev_port_fwd_mark_set(struct net_device *dev,
 				 struct net_device *group_dev,
 				 bool joining);
 
-bool switchdev_port_same_parent_id(struct net_device *a,
-				   struct net_device *b);
-
 int switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
@@ -295,12 +290,6 @@ call_switchdev_blocking_notifiers(unsigned long val,
 	return NOTIFY_DONE;
 }
 
-static inline bool switchdev_port_same_parent_id(struct net_device *a,
-						 struct net_device *b)
-{
-	return false;
-}
-
 static inline int
 switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 06b0ae44585f..db9e8ab96d48 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -14,8 +14,7 @@ static int br_switchdev_mark_get(struct net_bridge *br, struct net_device *dev)
 
 	/* dev is yet to be added to the port list. */
 	list_for_each_entry(p, &br->port_list, list) {
-		if (netdev_port_same_parent_id(dev, p->dev) ||
-		    switchdev_port_same_parent_id(dev, p->dev))
+		if (netdev_port_same_parent_id(dev, p->dev))
 			return p->offload_fwd_mark;
 	}
 
@@ -24,19 +23,12 @@ static int br_switchdev_mark_get(struct net_bridge *br, struct net_device *dev)
 
 int nbp_switchdev_mark_set(struct net_bridge_port *p)
 {
-	const struct net_device_ops *ops = p->dev->netdev_ops;
-	struct switchdev_attr attr = {
-		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-	};
+	struct netdev_phys_item_id ppid = { };
 	int err;
 
 	ASSERT_RTNL();
 
-	if (ops->ndo_get_port_parent_id)
-		err = dev_get_port_parent_id(p->dev, &attr.u.ppid, true);
-	else
-		err = switchdev_port_attr_get(p->dev, &attr);
+	err = dev_get_port_parent_id(p->dev, &ppid, true);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4eace9f1dcf9..7c5061123ead 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -12,7 +12,6 @@
 #include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <net/switchdev.h>
 #include <linux/if_arp.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
@@ -495,27 +494,17 @@ static ssize_t phys_switch_id_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
-	const struct net_device_ops *ops = netdev->netdev_ops;
 	ssize_t ret = -EINVAL;
 
 	if (!rtnl_trylock())
 		return restart_syscall();
 
 	if (dev_isalive(netdev)) {
-		struct switchdev_attr attr = {
-			.orig_dev = netdev,
-			.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-			.flags = SWITCHDEV_F_NO_RECURSE,
-		};
-
-		if (ops->ndo_get_port_parent_id)
-			ret = dev_get_port_parent_id(netdev, &attr.u.ppid,
-						     false);
-		else
-			ret = switchdev_port_attr_get(netdev, &attr);
+		struct netdev_phys_item_id ppid = { };
+
+		ret = dev_get_port_parent_id(netdev, &ppid, false);
 		if (!ret)
-			ret = sprintf(buf, "%*phN\n", attr.u.ppid.id_len,
-				      attr.u.ppid.id);
+			ret = sprintf(buf, "%*phN\n", ppid.id_len, ppid.id);
 	}
 	rtnl_unlock();
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 90dd02c1f561..a51cab95ba64 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -46,7 +46,6 @@
 
 #include <linux/inet.h>
 #include <linux/netdevice.h>
-#include <net/switchdev.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/arp.h>
@@ -1146,26 +1145,17 @@ static int rtnl_phys_port_name_fill(struct sk_buff *skb, struct net_device *dev)
 
 static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
+	struct netdev_phys_item_id ppid = { };
 	int err;
-	struct switchdev_attr attr = {
-		.orig_dev = dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-		.flags = SWITCHDEV_F_NO_RECURSE,
-	};
 
-	if (ops->ndo_get_port_parent_id)
-		err = dev_get_port_parent_id(dev, &attr.u.ppid, false);
-	else
-		err = switchdev_port_attr_get(dev, &attr);
+	err = dev_get_port_parent_id(dev, &ppid, false);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
 		return err;
 	}
 
-	if (nla_put(skb, IFLA_PHYS_SWITCH_ID, attr.u.ppid.id_len,
-		    attr.u.ppid.id))
+	if (nla_put(skb, IFLA_PHYS_SWITCH_ID, ppid.id_len, ppid.id))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c71bcc42d66d..e536970557dd 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -67,7 +67,6 @@
 #include <net/fib_rules.h>
 #include <linux/netconf.h>
 #include <net/nexthop.h>
-#include <net/switchdev.h>
 
 #include <linux/nospec.h>
 
@@ -837,11 +836,8 @@ static void ipmr_update_thresholds(struct mr_table *mrt, struct mr_mfc *cache,
 static int vif_add(struct net *net, struct mr_table *mrt,
 		   struct vifctl *vifc, int mrtsock)
 {
-	const struct net_device_ops *ops;
+	struct netdev_phys_item_id ppid = { };
 	int vifi = vifc->vifc_vifi;
-	struct switchdev_attr attr = {
-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-	};
 	struct vif_device *v = &mrt->vif_table[vifi];
 	struct net_device *dev;
 	struct in_device *in_dev;
@@ -920,15 +916,10 @@ static int vif_add(struct net *net, struct mr_table *mrt,
 			vifc->vifc_flags | (!mrtsock ? VIFF_STATIC : 0),
 			(VIFF_TUNNEL | VIFF_REGISTER));
 
-	attr.orig_dev = dev;
-	ops = dev->netdev_ops;
-	if (ops->ndo_get_port_parent_id &&
-	    !dev_get_port_parent_id(dev, &attr.u.ppid, true)) {
-		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
-		v->dev_parent_id.id_len = attr.u.ppid.id_len;
-	} else if (!switchdev_port_attr_get(dev, &attr)) {
-		memcpy(v->dev_parent_id.id, attr.u.ppid.id, attr.u.ppid.id_len);
-		v->dev_parent_id.id_len = attr.u.ppid.id_len;
+	err = dev_get_port_parent_id(dev, &ppid, true);
+	if (err == 0) {
+		memcpy(v->dev_parent_id.id, ppid.id, ppid.id_len);
+		v->dev_parent_id.id_len = ppid.id_len;
 	} else {
 		v->dev_parent_id.id_len = 0;
 	}
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index cd78253de31d..7e1357db33d7 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -592,26 +592,6 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-bool switchdev_port_same_parent_id(struct net_device *a,
-				   struct net_device *b)
-{
-	struct switchdev_attr a_attr = {
-		.orig_dev = a,
-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-	};
-	struct switchdev_attr b_attr = {
-		.orig_dev = b,
-		.id = SWITCHDEV_ATTR_ID_PORT_PARENT_ID,
-	};
-
-	if (switchdev_port_attr_get(a, &a_attr) ||
-	    switchdev_port_attr_get(b, &b_attr))
-		return false;
-
-	return netdev_phys_item_id_same(&a_attr.u.ppid, &b_attr.u.ppid);
-}
-EXPORT_SYMBOL_GPL(switchdev_port_same_parent_id);
-
 static int __switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
-- 
2.17.1

