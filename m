Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F6F214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F6F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbeITWxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:53:06 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:52416
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733169AbeITWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:53:05 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 32QTgzTQdsezk32QTg6ORy; Thu, 20 Sep 2018 10:07:37 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g32QT-0002WH-Nk; Thu, 20 Sep 2018 10:07:37 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,2/3] hv_netvsc: Add handler for LRO setting change
Date:   Thu, 20 Sep 2018 17:07:00 +0000
Message-Id: <20180920170701.9574-3-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
References: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfCn7UPeBGmbopDGUvdUwNXrcmI3Q3bwqqMbR4Q5YjLYNYMiabKt7TymYE5Sy4V+NTsFu67Nux6zgR51i6H+KAZ9TxkMOUwvhNohe6ldXj3ZtQXcCDaxi
 PhMOWB6a3OJF0lQsRcFBH3D6V1YuOHYGnNUT3+0kVyeWJ8gubmBKBBnT1yLqIylzYeGD3P7CfK8jl7nUOeyT7NStKRq3s/weBRA0z7BMwx35sPvN7pXA6n+n
 aY/42j9y/5Vx8mvG2oDKmPiEWt01yfNF0Jm8i9a1ZxqRA75p3xJpMASUliogAHAkezZAwIPwQElKyCgjZLjpOw3DsnCtD15Bu88bgIcB/xMMb8agRlDwue5o
 yW4bPq1bAvit1og84F+Hs9wSYZWVbPXg/TcVd8gebp7AJXkRL46m3yXiYI5XiWshEQrDXhKnVwoISpnNcY6z0UY9varoaoyzKRxLaCb/3OfVPCGaUOaaFG54
 73FplHsBPgZfXwf80BViJXv7HG/lPAJQ8q9fPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

This patch adds the handler for LRO setting change, so that a user
can use ethtool command to enable / disable LRO feature.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   |  4 ++++
 drivers/net/hyperv/netvsc_drv.c   | 30 ++++++++++++++++++++++++++++++
 drivers/net/hyperv/rndis_filter.c | 11 ++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 7f1603dc8128..ef6f766f6389 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -185,6 +185,7 @@ struct rndis_device {
 
 /* Interface */
 struct rndis_message;
+struct ndis_offload_params;
 struct netvsc_device;
 struct netvsc_channel;
 struct net_device_context;
@@ -218,6 +219,9 @@ void rndis_filter_device_remove(struct hv_device *dev,
 				struct netvsc_device *nvdev);
 int rndis_filter_set_rss_param(struct rndis_device *rdev,
 			       const u8 *key);
+int rndis_filter_set_offload_params(struct net_device *ndev,
+				    struct netvsc_device *nvdev,
+				    struct ndis_offload_params *req_offloads);
 int rndis_filter_receive(struct net_device *ndev,
 			 struct netvsc_device *net_dev,
 			 struct netvsc_channel *nvchan,
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index f8c18370d9d1..ec699741170b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1006,6 +1006,8 @@ static void netvsc_init_settings(struct net_device *dev)
 
 	ndc->speed = SPEED_UNKNOWN;
 	ndc->duplex = DUPLEX_FULL;
+
+	dev->features = NETIF_F_LRO;
 }
 
 static int netvsc_get_link_ksettings(struct net_device *dev,
@@ -1733,6 +1735,33 @@ static int netvsc_set_ringparam(struct net_device *ndev,
 	return ret;
 }
 
+static int netvsc_set_features(struct net_device *ndev,
+			       netdev_features_t features)
+{
+	netdev_features_t change = features ^ ndev->features;
+	struct net_device_context *ndevctx = netdev_priv(ndev);
+	struct netvsc_device *nvdev = rtnl_dereference(ndevctx->nvdev);
+	struct ndis_offload_params offloads;
+
+	if (!nvdev || nvdev->destroy)
+		return -ENODEV;
+
+	if (!(change & NETIF_F_LRO))
+		return 0;
+
+	memset(&offloads, 0, sizeof(struct ndis_offload_params));
+
+	if (features & NETIF_F_LRO) {
+		offloads.rsc_ip_v4 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
+		offloads.rsc_ip_v6 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
+	} else {
+		offloads.rsc_ip_v4 = NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED;
+		offloads.rsc_ip_v6 = NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED;
+	}
+
+	return rndis_filter_set_offload_params(ndev, nvdev, &offloads);
+}
+
 static u32 netvsc_get_msglevel(struct net_device *ndev)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
@@ -1776,6 +1805,7 @@ static const struct net_device_ops device_ops = {
 	.ndo_start_xmit =		netvsc_start_xmit,
 	.ndo_change_rx_flags =		netvsc_change_rx_flags,
 	.ndo_set_rx_mode =		netvsc_set_rx_mode,
+	.ndo_set_features =		netvsc_set_features,
 	.ndo_change_mtu =		netvsc_change_mtu,
 	.ndo_validate_addr =		eth_validate_addr,
 	.ndo_set_mac_address =		netvsc_set_mac_addr,
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 7bc8ade5c2bd..f94892edaa21 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -716,7 +716,7 @@ int rndis_filter_set_device_mac(struct netvsc_device *nvdev,
 	return ret;
 }
 
-static int
+int
 rndis_filter_set_offload_params(struct net_device *ndev,
 				struct netvsc_device *nvdev,
 				struct ndis_offload_params *req_offloads)
@@ -1246,8 +1246,13 @@ static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
 	if (hwcaps.rsc.ip4 && hwcaps.rsc.ip6) {
 		net->hw_features |= NETIF_F_LRO;
 
-		offloads.rsc_ip_v4 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
-		offloads.rsc_ip_v6 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
+		if (net->features & NETIF_F_LRO) {
+			offloads.rsc_ip_v4 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
+			offloads.rsc_ip_v6 = NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED;
+		} else {
+			offloads.rsc_ip_v4 = NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED;
+			offloads.rsc_ip_v6 = NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED;
+		}
 	}
 
 	/* In case some hw_features disappeared we need to remove them from
-- 
2.18.0

