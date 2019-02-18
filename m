Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D472146E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbfBRSXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:23:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:47106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404019AbfBRSXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:23:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68BA5AEBB;
        Mon, 18 Feb 2019 18:23:10 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1BCF6E0122; Mon, 18 Feb 2019 19:23:10 +0100 (CET)
Message-Id: <73fef81aa207a254ff6a24a60a1910b3c0682af3.1550513384.git.mkubecek@suse.cz>
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 21/21] ethtool: send netlink notifications
 about setting changes
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:23:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SETTINGS notification message has the same format as response to
GET_SETTINGS request and is broadcasted on change of relevant fields. Info
mask can be used to limit the information passed to userspace.

Send the notification on changes performed via the legacy ioctl interface;
feature notifications are also sent whenever netdev_update_features() or
netdev_change_features() is called, even if the change was not performed
using the ethtool interface.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ethtool/ioctl.c   | 24 ++++++++++++++++++++++--
 net/ethtool/netlink.c | 12 ++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 6c3b492a88fe..17ccca14f5c3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -30,6 +30,7 @@
 #include <net/devlink.h>
 #include <net/xdp_sock.h>
 #include <net/flow_offload.h>
+#include <linux/ethtool_netlink.h>
 
 #include "common.h"
 
@@ -567,7 +568,12 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 	    != link_ksettings.base.link_mode_masks_nwords)
 		return -EINVAL;
 
-	return dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
+	err = dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
+	if (err >= 0)
+		ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+			       ETH_SETTINGS_IM_LINKINFO |
+			       ETH_SETTINGS_IM_LINKMODES, NULL);
+	return err;
 }
 
 /* Query device for its ethtool_cmd settings.
@@ -616,6 +622,7 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_link_ksettings link_ksettings;
 	struct ethtool_cmd cmd;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -628,7 +635,12 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 		return -EINVAL;
 	link_ksettings.base.link_mode_masks_nwords =
 		__ETHTOOL_LINK_MODE_MASK_NU32;
-	return dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
+	ret = dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
+	if (ret >= 0)
+		ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+			       ETH_SETTINGS_IM_LINKINFO |
+			       ETH_SETTINGS_IM_LINKMODES, NULL);
+	return ret;
 }
 
 static noinline_for_stack int ethtool_get_drvinfo(struct net_device *dev,
@@ -1255,6 +1267,8 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 		return ret;
 
 	dev->wol_enabled = !!wol.wolopts;
+	ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+		       ETH_SETTINGS_IM_WOLINFO, NULL);
 
 	return 0;
 }
@@ -2453,6 +2467,9 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SMSGLVL:
 		rc = ethtool_set_value_void(dev, useraddr,
 				       dev->ethtool_ops->set_msglevel);
+		if (rc >= 0)
+			ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				       ETH_SETTINGS_IM_MSGLEVEL, NULL);
 		break;
 	case ETHTOOL_GEEE:
 		rc = ethtool_get_eee(dev, useraddr);
@@ -2519,6 +2536,9 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SPFLAGS:
 		rc = ethtool_set_value(dev, useraddr,
 				       dev->ethtool_ops->set_priv_flags);
+		if (rc == 0)
+			ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				       ETH_SETTINGS_IM_PRIVFLAGS, NULL);
 		break;
 	case ETHTOOL_GRXFH:
 	case ETHTOOL_GRXRINGS:
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 5166b0c28288..6f94aec6fa69 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -480,6 +480,7 @@ typedef void (*ethnl_notify_handler_t)(struct net_device *dev,
 				       const void *data);
 
 ethnl_notify_handler_t ethnl_notify_handlers[] = {
+	[ETHNL_CMD_SET_SETTINGS]	= ethnl_std_notify,
 };
 
 void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
@@ -534,6 +535,14 @@ static void ethnl_notify_devlist(struct netdev_notifier_info *info,
 	nlmsg_free(skb);
 }
 
+static void ethnl_notify_features(struct netdev_notifier_info *info)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(info);
+
+	ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+		       ETH_SETTINGS_IM_FEATURES, NULL);
+}
+
 static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 			      void *ptr)
 {
@@ -548,6 +557,9 @@ static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 		ethnl_notify_devlist(ptr, ETHA_EVENT_RENAMEDEV,
 				     ETHA_RENAMEDEV_DEV);
 		break;
+	case NETDEV_FEAT_CHANGE:
+		ethnl_notify_features(ptr);
+		break;
 	}
 
 	return NOTIFY_DONE;
-- 
2.20.1

