Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F016920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F016920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeG3O2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:28:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730125AbeG3O2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:28:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 069A9AD6A;
        Mon, 30 Jul 2018 12:53:43 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id A4A96A0BE8; Mon, 30 Jul 2018 14:53:42 +0200 (CEST)
Message-Id: <0f59c43203698da554069328f1a96026bf9bf037.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 12/17] ethtool: implement SET_SETTINGS
 notification
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:53:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SETTINGS notification message has the same format as response to
GET_SETTINGS request and is broadcasted on change of relevant fields. Info
mask can be used to limit the information passed to userspace.

Also trigger the notification on analogous changes performed via the legacy
ioctl interface.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt |  3 +-
 net/core/dev.c                               |  3 ++
 net/ethtool/ioctl.c                          | 36 +++++++++++++++--
 net/ethtool/netlink.c                        |  2 +
 net/ethtool/settings.c                       | 41 ++++++++++++++++++++
 5 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index 82b839c03707..3993652f81a9 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -263,7 +263,8 @@ requests.
 
 GET_SETTINGS requests allow dumps and messages in the same format as response
 to them are broadcasted as notifications on change of these settings using
-netlink or ioctl ethtool interface.
+netlink or ioctl ethtool interface; feature notifications are also sent
+whenever netdev_update_features() or netdev_change_features() is called.
 
 
 Request translation
diff --git a/net/core/dev.c b/net/core/dev.c
index 8a0773a52dd7..66932a9f133e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -93,6 +93,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/notifier.h>
 #include <linux/skbuff.h>
 #include <linux/bpf.h>
@@ -1318,6 +1319,8 @@ int dev_get_alias(const struct net_device *dev, char *name, size_t len)
 void netdev_features_change(struct net_device *dev)
 {
 	call_netdevice_notifiers(NETDEV_FEAT_CHANGE, dev);
+	netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				   ETH_SETTINGS_IM_FEATURES);
 }
 EXPORT_SYMBOL(netdev_features_change);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 39e9aea60516..2754d3f6fd75 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -27,6 +27,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/sched/signal.h>
 #include <linux/net.h>
+#include <linux/ethtool_netlink.h>
 #include "common.h"
 
 /*
@@ -125,6 +126,8 @@ static int ethtool_set_features(struct net_device *dev, void __user *useraddr)
 	dev->wanted_features &= ~valid;
 	dev->wanted_features |= wanted & valid;
 	__netdev_update_features(dev);
+	netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				   ETH_SETTINGS_IM_FEATURES);
 
 	if ((dev->wanted_features ^ dev->features) & valid)
 		ret |= ETHTOOL_F_WISH;
@@ -243,6 +246,8 @@ static int ethtool_set_one_feature(struct net_device *dev,
 		dev->wanted_features &= ~mask;
 
 	__netdev_update_features(dev);
+	netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				   ETH_SETTINGS_IM_FEATURES);
 
 	return 0;
 }
@@ -298,6 +303,8 @@ static int __ethtool_set_flags(struct net_device *dev, u32 data)
 		(dev->wanted_features & ~changed) | (features & changed);
 
 	__netdev_update_features(dev);
+	netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				   ETH_SETTINGS_IM_FEATURES);
 
 	return 0;
 }
@@ -638,6 +645,7 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_cmd cmd;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -655,8 +663,14 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 		link_ksettings.base.cmd = ETHTOOL_SLINKSETTINGS;
 		link_ksettings.base.link_mode_masks_nwords
 			= __ETHTOOL_LINK_MODE_MASK_NU32;
-		return dev->ethtool_ops->set_link_ksettings(dev,
-							    &link_ksettings);
+		ret = dev->ethtool_ops->set_link_ksettings(dev,
+							   &link_ksettings);
+		if (ret >= 0)
+			netdev_ethtool_info_change(dev, NULL,
+						   ETHNL_CMD_SET_SETTINGS,
+						   ETH_SETTINGS_IM_LINKINFO |
+						   ETH_SETTINGS_IM_LINKMODES);
+		return ret;
 	}
 
 	/* legacy %ethtool_cmd API */
@@ -668,7 +682,12 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 	if (!dev->ethtool_ops->set_settings)
 		return -EOPNOTSUPP;
 
-	return dev->ethtool_ops->set_settings(dev, &cmd);
+	ret = dev->ethtool_ops->set_settings(dev, &cmd);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+					   ETH_SETTINGS_IM_LINKINFO |
+					   ETH_SETTINGS_IM_LINKMODES);
+	return ret;
 }
 
 static noinline_for_stack int ethtool_get_drvinfo(struct net_device *dev,
@@ -1279,6 +1298,7 @@ static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
 static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_wolinfo wol;
+	int ret;
 
 	if (!dev->ethtool_ops->set_wol)
 		return -EOPNOTSUPP;
@@ -1286,7 +1306,11 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	if (copy_from_user(&wol, useraddr, sizeof(wol)))
 		return -EFAULT;
 
-	return dev->ethtool_ops->set_wol(dev, &wol);
+	ret = dev->ethtool_ops->set_wol(dev, &wol);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+					   ETH_SETTINGS_IM_WOLINFO);
+	return ret;
 }
 
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
@@ -2478,6 +2502,10 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SMSGLVL:
 		rc = ethtool_set_value_void(dev, useraddr,
 				       dev->ethtool_ops->set_msglevel);
+		if (rc >= 0)
+			netdev_ethtool_info_change(dev, NULL,
+						   ETHNL_CMD_SET_SETTINGS,
+						   ETH_SETTINGS_IM_MSGLEVEL);
 		break;
 	case ETHTOOL_GEEE:
 		rc = ethtool_get_eee(dev, useraddr);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6c14185a6466..0e2158092a44 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -629,7 +629,9 @@ int ethnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 typedef void (*ethnl_notify_handler_t)(struct netdev_notifier_ethtool_info *);
 
+void ethnl_settings_notify(struct netdev_notifier_ethtool_info *);
 ethnl_notify_handler_t ethnl_notify_handlers[] = {
+	[ETHNL_CMD_SET_SETTINGS]	= ethnl_settings_notify,
 };
 
 static void __ethnl_notify(struct netdev_notifier_ethtool_info *info)
diff --git a/net/ethtool/settings.c b/net/ethtool/settings.c
index fdca418a6d8e..739bd006c924 100644
--- a/net/ethtool/settings.c
+++ b/net/ethtool/settings.c
@@ -565,3 +565,44 @@ int ethnl_settings_done(struct netlink_callback *cb)
 
 	return 0;
 }
+
+void ethnl_settings_notify(struct netdev_notifier_ethtool_info *info)
+{
+	struct settings_reqinfo req_info = {
+		.dev		= info->info.dev,
+		.req_mask	= info->ethtool_info.req_mask,
+		.compact	= true,
+		.is_privileged	= false,
+		.have_rtnl	= true,
+	};
+	struct settings_data data;
+	struct sk_buff *skb;
+	int reply_len;
+	void *ehdr;
+	int ret;
+
+	ret = prepare_settings(&data, &req_info, NULL, req_info.dev);
+	if (ret < 0)
+		return;
+	reply_len = settings_size(&data, &req_info);
+	if (ret < 0)
+		return;
+	skb = genlmsg_new(reply_len, GFP_KERNEL);
+	if (!skb)
+		return;
+	ehdr = genlmsg_put(skb, 0, ++ethnl_bcast_seq, &ethtool_genl_family, 0,
+			   ETHNL_CMD_SET_SETTINGS);
+	ret = ethnl_fill_dev(skb, req_info.dev, ETHA_SETTINGS_DEV);
+	if (ret < 0)
+		goto err_skb;
+	ret = fill_settings(skb, &data, &req_info);
+	if (ret < 0)
+		goto err_skb;
+	genlmsg_end(skb, ehdr);
+
+	genlmsg_multicast(&ethtool_genl_family, skb, 0, ETHNL_MCGRP_MONITOR,
+			  GFP_KERNEL);
+	return;
+err_skb:
+	nlmsg_free(skb);
+}
-- 
2.18.0

