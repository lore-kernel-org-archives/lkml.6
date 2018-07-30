Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A287320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A287320893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbeG3O25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:28:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732219AbeG3O24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:28:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 171E7AE83;
        Mon, 30 Jul 2018 12:54:03 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id BCDB8A0BE8; Mon, 30 Jul 2018 14:54:02 +0200 (CEST)
Message-Id: <f8c663c19963187a814bc49548c4b5d24cfdaa8b.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 16/17] ethtool: implement SET_PARAMS
 notification
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:54:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_PARAMS notification message has the same format as response to
GET_PARAMS request and is broadcasted on change of relevant fields. Info
mask can be used to limit the information passed to userspace.

Also trigger the notification on analogous changes performed via the legacy
ioctl interface.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ethtool/ioctl.c   | 42 ++++++++++++++++++++++++++++++++++++------
 net/ethtool/netlink.c |  3 +++
 net/ethtool/params.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 2754d3f6fd75..1dc1459dff6e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1337,6 +1337,7 @@ static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_eee edata;
+	int ret;
 
 	if (!dev->ethtool_ops->set_eee)
 		return -EOPNOTSUPP;
@@ -1344,7 +1345,11 @@ static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 	if (copy_from_user(&edata, useraddr, sizeof(edata)))
 		return -EFAULT;
 
-	return dev->ethtool_ops->set_eee(dev, &edata);
+	ret = dev->ethtool_ops->set_eee(dev, &edata);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_EEE);
+	return ret;
 }
 
 static int ethtool_nway_reset(struct net_device *dev)
@@ -1499,6 +1504,7 @@ static noinline_for_stack int ethtool_set_coalesce(struct net_device *dev,
 						   void __user *useraddr)
 {
 	struct ethtool_coalesce coalesce;
+	int ret;
 
 	if (!dev->ethtool_ops->set_coalesce)
 		return -EOPNOTSUPP;
@@ -1506,7 +1512,11 @@ static noinline_for_stack int ethtool_set_coalesce(struct net_device *dev,
 	if (copy_from_user(&coalesce, useraddr, sizeof(coalesce)))
 		return -EFAULT;
 
-	return dev->ethtool_ops->set_coalesce(dev, &coalesce);
+	ret = dev->ethtool_ops->set_coalesce(dev, &coalesce);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_COALESCE);
+	return ret;
 }
 
 static int ethtool_get_ringparam(struct net_device *dev, void __user *useraddr)
@@ -1526,6 +1536,7 @@ static int ethtool_get_ringparam(struct net_device *dev, void __user *useraddr)
 static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_ringparam ringparam, max = { .cmd = ETHTOOL_GRINGPARAM };
+	int ret;
 
 	if (!dev->ethtool_ops->set_ringparam || !dev->ethtool_ops->get_ringparam)
 		return -EOPNOTSUPP;
@@ -1542,7 +1553,11 @@ static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 	    ringparam.tx_pending > max.tx_max_pending)
 		return -EINVAL;
 
-	return dev->ethtool_ops->set_ringparam(dev, &ringparam);
+	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_RING);
+	return ret;
 }
 
 static noinline_for_stack int ethtool_get_channels(struct net_device *dev,
@@ -1565,6 +1580,7 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 {
 	struct ethtool_channels channels, max = { .cmd = ETHTOOL_GCHANNELS };
 	u32 max_rx_in_use = 0;
+	int ret;
 
 	if (!dev->ethtool_ops->set_channels || !dev->ethtool_ops->get_channels)
 		return -EOPNOTSUPP;
@@ -1588,7 +1604,11 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	    (channels.combined_count + channels.rx_count) <= max_rx_in_use)
 	    return -EINVAL;
 
-	return dev->ethtool_ops->set_channels(dev, &channels);
+	ret = dev->ethtool_ops->set_channels(dev, &channels);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_CHANNELS);
+	return ret;
 }
 
 static int ethtool_get_pauseparam(struct net_device *dev, void __user *useraddr)
@@ -1608,6 +1628,7 @@ static int ethtool_get_pauseparam(struct net_device *dev, void __user *useraddr)
 static int ethtool_set_pauseparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_pauseparam pauseparam;
+	int ret;
 
 	if (!dev->ethtool_ops->set_pauseparam)
 		return -EOPNOTSUPP;
@@ -1615,7 +1636,11 @@ static int ethtool_set_pauseparam(struct net_device *dev, void __user *useraddr)
 	if (copy_from_user(&pauseparam, useraddr, sizeof(pauseparam)))
 		return -EFAULT;
 
-	return dev->ethtool_ops->set_pauseparam(dev, &pauseparam);
+	ret = dev->ethtool_ops->set_pauseparam(dev, &pauseparam);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_PAUSE);
+	return ret;
 }
 
 static int ethtool_self_test(struct net_device *dev, char __user *useraddr)
@@ -2394,6 +2419,7 @@ static int ethtool_get_fecparam(struct net_device *dev, void __user *useraddr)
 static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_fecparam fecparam;
+	int ret;
 
 	if (!dev->ethtool_ops->set_fecparam)
 		return -EOPNOTSUPP;
@@ -2401,7 +2427,11 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 	if (copy_from_user(&fecparam, useraddr, sizeof(fecparam)))
 		return -EFAULT;
 
-	return dev->ethtool_ops->set_fecparam(dev, &fecparam);
+	ret = dev->ethtool_ops->set_fecparam(dev, &fecparam);
+	if (ret >= 0)
+		netdev_ethtool_info_change(dev, NULL, ETHNL_CMD_SET_PARAMS,
+					   ETH_PARAMS_IM_FEC);
+	return ret;
 }
 
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 721101ed2ab6..b24a0e045ec0 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -630,8 +630,11 @@ int ethnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 typedef void (*ethnl_notify_handler_t)(struct netdev_notifier_ethtool_info *);
 
 void ethnl_settings_notify(struct netdev_notifier_ethtool_info *);
+void ethnl_params_notify(struct netdev_notifier_ethtool_info *);
+
 ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHNL_CMD_SET_SETTINGS]	= ethnl_settings_notify,
+	[ETHNL_CMD_SET_PARAMS]		= ethnl_params_notify,
 };
 
 static void __ethnl_notify(struct netdev_notifier_ethtool_info *info)
diff --git a/net/ethtool/params.c b/net/ethtool/params.c
index 07d4c527abf2..773e13fc1ae6 100644
--- a/net/ethtool/params.c
+++ b/net/ethtool/params.c
@@ -537,3 +537,43 @@ int ethnl_params_done(struct netlink_callback *cb)
 
 	return 0;
 }
+
+void ethnl_params_notify(struct netdev_notifier_ethtool_info *info)
+{
+	struct params_reqinfo req_info = {
+		.dev		= info->info.dev,
+		.req_mask	= info->ethtool_info.req_mask,
+		.compact	= true,
+		.have_rtnl	= true,
+	};
+	struct params_data data;
+	struct sk_buff *skb;
+	int reply_len;
+	void *ehdr;
+	int ret;
+
+	ret = prepare_params(&data, &req_info, NULL, req_info.dev);
+	if (ret < 0)
+		return;
+	reply_len = params_size(&data, &req_info);
+	if (ret < 0)
+		return;
+	skb = genlmsg_new(reply_len, GFP_KERNEL);
+	if (!skb)
+		return;
+	ehdr = genlmsg_put(skb, 0, ++ethnl_bcast_seq, &ethtool_genl_family, 0,
+			   ETHNL_CMD_SET_PARAMS);
+	ret = ethnl_fill_dev(skb, req_info.dev, ETHA_PARAMS_DEV);
+	if (ret < 0)
+		goto err_skb;
+	ret = fill_params(skb, &data, &req_info);
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

