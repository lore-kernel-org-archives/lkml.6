Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3225FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673BB20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673BB20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbeG3O2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:49154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730125AbeG3O2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:28:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBB45AF59;
        Mon, 30 Jul 2018 12:53:17 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 85027A0BE8; Mon, 30 Jul 2018 14:53:17 +0200 (CEST)
Message-Id: <11dcbb7c1219e95dc21d1e3ecb096214f67e44f0.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 07/17] ethtool: implement EVENT notifications
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:53:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two types of netlink notifications are introduced: ETHA_EVENT_NEWDEV to
notify about newly registered network devices and ETHA_EVENT_DELDEV to
notify about unregistered network devices. These are triggered by
NETDEV_REGISTER and NETDEV_UNREGISTER notifiers.

These are intended for applications and daemons monitoring ethtool events
to allow updating the list of existing devices without having to open
another socket for rtnetlink.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt | 22 ++++++++++
 include/uapi/linux/ethtool_netlink.h         | 28 +++++++++++++
 net/ethtool/netlink.c                        | 44 ++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index a49dfe3ef4bb..0e83397f2975 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -118,6 +118,8 @@ which the request applies.
 List of message types
 ---------------------
 
+    ETHNL_CMD_EVENT			notification only
+
 All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
 to indicate the type.
 
@@ -129,9 +131,29 @@ messages marked as "response only" in the table above. "Get" messages with
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
+
+Userspace application must expect multiple events to be present in one message
+and also multiple events of the same type (e.g. two or more newly registered
+devices).
+
+
 Request translation
 -------------------
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 444a668e4a08..f162cd6f80d4 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -7,6 +7,7 @@
 
 enum {
 	ETHNL_CMD_NOOP,
+	ETHNL_CMD_EVENT,		/* only for notifications */
 
 	__ETHNL_CMD_MAX,
 	ETHNL_CMD_MAX = (__ETHNL_CMD_MAX - 1)
@@ -54,6 +55,33 @@ enum {
 	ETHA_BITSET_MAX = (__ETHA_BITSET_MAX - 1)
 };
 
+/* events */
+
+enum {
+	ETHA_NEWDEV_UNSPEC,
+	ETHA_NEWDEV_DEV,			/* nest - ETHA_DEV_* */
+
+	__ETHA_NEWDEV_MAX,
+	ETHA_NEWDEV_MAX = (__ETHA_NEWDEV_MAX - 1)
+};
+
+enum {
+	ETHA_DELDEV_UNSPEC,
+	ETHA_DELDEV_DEV,			/* nest - ETHA_DEV_* */
+
+	__ETHA_DELDEV_MAX,
+	ETHA_DELDEV_MAX = (__ETHA_DELDEV_MAX - 1)
+};
+
+enum {
+	ETHA_EVENT_UNSPEC,
+	ETHA_EVENT_NEWDEV,			/* nest - ETHA_NEWDEV_* */
+	ETHA_EVENT_DELDEV,			/* nest - ETHA_DELDEV_* */
+
+	__ETHA_EVENT_MAX,
+	ETHA_EVENT_MAX = (__ETHA_EVENT_MAX - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e4a20bb6c1d4..543560778c80 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -607,6 +607,44 @@ void ethnl_notify(struct net_device *dev, struct netlink_ext_ack *extack,
 	return __ethnl_notify(&ethtool_info);
 }
 
+static unsigned int dev_notify_size(void)
+{
+	return nla_total_size(nla_total_size(nla_total_size(sizeof(u32)) +
+					     nla_total_size(IFNAMSIZ)));
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
 static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 			      void *ptr)
 {
@@ -614,6 +652,12 @@ static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 	case NETDEV_ETHTOOL:
 		__ethnl_notify(ptr);
 		break;
+	case NETDEV_REGISTER:
+		ethnl_notify_devlist(ptr, ETHA_EVENT_NEWDEV, ETHA_NEWDEV_DEV);
+		break;
+	case NETDEV_UNREGISTER:
+		ethnl_notify_devlist(ptr, ETHA_EVENT_DELDEV, ETHA_DELDEV_DEV);
+		break;
 	}
 
 	return NOTIFY_DONE;
-- 
2.18.0

