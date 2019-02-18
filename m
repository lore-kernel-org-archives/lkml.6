Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C53DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B9217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbfBRSWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:22:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390596AbfBRSWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:22:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E11DAEBB;
        Mon, 18 Feb 2019 18:22:00 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id B0DACE0122; Mon, 18 Feb 2019 19:21:59 +0100 (CET)
Message-Id: <c75c70d7b8f5e1b9a3ef6b83c2adaac2b113db31.1550513384.git.mkubecek@suse.cz>
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 07/21] ethtool: implement EVENT notifications
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:21:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three types of netlink notifications are introduced:

  - ETHA_EVENT_NEWDEV to notify about newly registered network devices
  - ETHA_EVENT_DELDEV to notify about unregistered network devices
  - ETHA_EVENT_RENAMEDEV to notify about renamed network device

The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
NETDEV_CHANGENAME notifiers.

These notifications are intended for applications and daemons monitoring
ethtool events to allow updating the list of existing devices without
having to open another socket for rtnetlink.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt | 27 ++++++++
 include/uapi/linux/ethtool_netlink.h         | 37 +++++++++++
 net/ethtool/netlink.c                        | 65 ++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index 205ae4462e9e..b79c26b5e92b 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -125,6 +125,8 @@ which the request applies.
 List of message types
 ---------------------
 
+    ETHNL_CMD_EVENT			notification only
+
 All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
 to indicate the type.
 
@@ -136,9 +138,34 @@ messages marked as "response only" in the table above. "Get" messages with
 NLM_F_DUMP flags and no device identification dump the information for all
 devices supporting the request.
 
+Type ETHNL_CMD_EVENT is special, these messages are never used in userspace
+requests or kernel replies. They are only sent by kernel to sockets listening
+to "monitor" multicast group to inform userspace about certain events.
+
 Later sections describe the format and semantics of these request messages.
 
 
+EVENT
+-----
+
+EVENT messages are only used in kernel multicast notifications. Atributes
+correspond to specific event types, the same type can appear multiple times.
+
+    ETHA_EVENT_NEWDEV		(nested)	new device was registered
+       ETHA_NEWDEV_DEV			(nested)	new device
+    ETHA_EVENT_DELDEV		(nested)	device was unregistered
+       ETHA_DELDEV_DEV			(nested)	removed device
+    ETHA_EVENT_RENAMEDEV	(nested)	device was renamed
+       ETHA_RENAMEDEV_DEV		(nested)	renamed device
+
+For ETHA_EVENT_RENAMEDEV, the name ETHA_RENAME_DEV/ETHA_DEV_NAME is the new
+name after the rename.
+
+Userspace application must expect multiple events to be present in one message
+and also multiple events of the same type (e.g. two or more newly registered
+devices).
+
+
 Request translation
 -------------------
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b662d75a0636..7e192ad8ce3a 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -7,6 +7,7 @@
 
 enum {
 	ETHNL_CMD_NOOP,
+	ETHNL_CMD_EVENT,		/* only for notifications */
 
 	__ETHNL_CMD_CNT,
 	ETHNL_CMD_MAX = (__ETHNL_CMD_CNT - 1)
@@ -55,6 +56,42 @@ enum {
 	ETHA_BITSET_MAX = (__ETHA_BITSET_CNT - 1)
 };
 
+/* events */
+
+enum {
+	ETHA_NEWDEV_UNSPEC,
+	ETHA_NEWDEV_DEV,			/* nest - ETHA_DEV_* */
+
+	__ETHA_NEWDEV_CNT,
+	ETHA_NEWDEV_MAX = (__ETHA_NEWDEV_CNT - 1)
+};
+
+enum {
+	ETHA_DELDEV_UNSPEC,
+	ETHA_DELDEV_DEV,			/* nest - ETHA_DEV_* */
+
+	__ETHA_DELDEV_CNT,
+	ETHA_DELDEV_MAX = (__ETHA_DELDEV_CNT - 1)
+};
+
+enum {
+	ETHA_RENAMEDEV_UNSPEC,
+	ETHA_RENAMEDEV_DEV,			/* nest - ETHA_DEV_* */
+
+	__ETHA_RENAMEDEV_CNT,
+	ETHA_RENAMEDEV_MAX = (__ETHA_RENAMEDEV_CNT - 1)
+};
+
+enum {
+	ETHA_EVENT_UNSPEC,
+	ETHA_EVENT_NEWDEV,			/* nest - ETHA_NEWDEV_* */
+	ETHA_EVENT_DELDEV,			/* nest - ETHA_DELDEV_* */
+	ETHA_EVENT_RENAMEDEV,			/* nest - ETHA_RENAMEDEV_* */
+
+	__ETHA_EVENT_CNT,
+	ETHA_EVENT_MAX = (__ETHA_EVENT_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a5fa54c2b743..ee3424cd1f90 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -148,6 +148,67 @@ void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
 }
 EXPORT_SYMBOL(ethtool_notify);
 
+/* size of NEWDEV/DELDEV notification */
+static inline unsigned int dev_notify_size(void)
+{
+	return nla_total_size(dev_ident_size());
+}
+
+static void ethnl_notify_devlist(struct netdev_notifier_info *info,
+				 u16 ev_type, u16 dev_attr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(info);
+	struct sk_buff *skb;
+	struct nlattr *nest;
+	void *ehdr;
+	int ret;
+
+	skb = genlmsg_new(dev_notify_size(), GFP_KERNEL);
+	if (!skb)
+		return;
+	ehdr = genlmsg_put(skb, 0, ++ethnl_bcast_seq, &ethtool_genl_family, 0,
+			   ETHNL_CMD_EVENT);
+	if (!ehdr)
+		goto out_skb;
+	nest = ethnl_nest_start(skb, ev_type);
+	if (!nest)
+		goto out_skb;
+	ret = ethnl_fill_dev(skb, dev, dev_attr);
+	if (ret < 0)
+		goto out_skb;
+	nla_nest_end(skb, nest);
+	genlmsg_end(skb, ehdr);
+
+	genlmsg_multicast(&ethtool_genl_family, skb, 0, ETHNL_MCGRP_MONITOR,
+			  GFP_KERNEL);
+	return;
+out_skb:
+	nlmsg_free(skb);
+}
+
+static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
+			      void *ptr)
+{
+	switch (event) {
+	case NETDEV_REGISTER:
+		ethnl_notify_devlist(ptr, ETHA_EVENT_NEWDEV, ETHA_NEWDEV_DEV);
+		break;
+	case NETDEV_UNREGISTER:
+		ethnl_notify_devlist(ptr, ETHA_EVENT_DELDEV, ETHA_DELDEV_DEV);
+		break;
+	case NETDEV_CHANGENAME:
+		ethnl_notify_devlist(ptr, ETHA_EVENT_RENAMEDEV,
+				     ETHA_RENAMEDEV_DEV);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ethnl_netdev_notifier = {
+	.notifier_call = ethnl_netdev_event,
+};
+
 /* genetlink setup */
 
 static const struct genl_ops ethtool_genl_ops[] = {
@@ -179,6 +240,10 @@ static int __init ethnl_init(void)
 	if (ret < 0)
 		panic("ethtool: could not register genetlink family\n");
 
+	ret = register_netdevice_notifier(&ethnl_netdev_notifier);
+	if (ret < 0)
+		panic("ethtool: could not register netdev notifier\n");
+
 	return 0;
 }
 
-- 
2.20.1

