Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD242083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD242083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeHATzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:55:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405749AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66C68137B;
        Wed,  1 Aug 2018 17:14:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 022/246] hv_netvsc: fix network namespace issues with VF support
Date:   Wed,  1 Aug 2018 18:48:52 +0200
Message-Id: <20180801165012.756257714@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 7bf7bb37f16a80465ee3bd7c6c966f96f5a075a6 ]

When finding the parent netvsc device, the search needs to be across
all netvsc device instances (independent of network namespace).

Find parent device of VF using upper_dev_get routine which
searches only adjacent list.

Fixes: e8ff40d4bff1 ("hv_netvsc: improve VF device matching")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>

netns aware byref
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |    2 +
 drivers/net/hyperv/netvsc_drv.c |   45 ++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -724,6 +724,8 @@ struct net_device_context {
 	struct hv_device *device_ctx;
 	/* netvsc_device */
 	struct netvsc_device __rcu *nvdev;
+	/* list of netvsc net_devices */
+	struct list_head list;
 	/* reconfigure work */
 	struct delayed_work dwork;
 	/* last reconfig time */
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -66,6 +66,8 @@ static int debug = -1;
 module_param(debug, int, S_IRUGO);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static LIST_HEAD(netvsc_dev_list);
+
 static void netvsc_change_rx_flags(struct net_device *net, int change)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(net);
@@ -1749,13 +1751,10 @@ out_unlock:
 
 static struct net_device *get_netvsc_bymac(const u8 *mac)
 {
-	struct net_device *dev;
-
-	ASSERT_RTNL();
+	struct net_device_context *ndev_ctx;
 
-	for_each_netdev(&init_net, dev) {
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
+	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
+		struct net_device *dev = hv_get_drvdata(ndev_ctx->device_ctx);
 
 		if (ether_addr_equal(mac, dev->perm_addr))
 			return dev;
@@ -1766,25 +1765,18 @@ static struct net_device *get_netvsc_bym
 
 static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)
 {
+	struct net_device_context *net_device_ctx;
 	struct net_device *dev;
 
-	ASSERT_RTNL();
-
-	for_each_netdev(&init_net, dev) {
-		struct net_device_context *net_device_ctx;
-
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
-
-		net_device_ctx = netdev_priv(dev);
-		if (!rtnl_dereference(net_device_ctx->nvdev))
-			continue;	/* device is removed */
+	dev = netdev_master_upper_dev_get(vf_netdev);
+	if (!dev || dev->netdev_ops != &device_ops)
+		return NULL;	/* not a netvsc device */
+
+	net_device_ctx = netdev_priv(dev);
+	if (!rtnl_dereference(net_device_ctx->nvdev))
+		return NULL;	/* device is removed */
 
-		if (rtnl_dereference(net_device_ctx->vf_netdev) == vf_netdev)
-			return dev;	/* a match */
-	}
-
-	return NULL;
+	return dev;
 }
 
 /* Called when VF is injecting data into network stack.
@@ -2065,15 +2057,19 @@ static int netvsc_probe(struct hv_device
 	else
 		net->max_mtu = ETH_DATA_LEN;
 
-	ret = register_netdev(net);
+	rtnl_lock();
+	ret = register_netdevice(net);
 	if (ret != 0) {
 		pr_err("Unable to register netdev.\n");
 		goto register_failed;
 	}
 
-	return ret;
+	list_add(&net_device_ctx->list, &netvsc_dev_list);
+	rtnl_unlock();
+	return 0;
 
 register_failed:
+	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
 	free_percpu(net_device_ctx->vf_stats);
@@ -2119,6 +2115,7 @@ static int netvsc_remove(struct hv_devic
 		rndis_filter_device_remove(dev, nvdev);
 
 	unregister_netdevice(net);
+	list_del(&ndev_ctx->list);
 
 	rtnl_unlock();
 	rcu_read_unlock();


