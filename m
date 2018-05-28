Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164492AbeE1NGg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163974AbeE1KwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 214/496] hv_netvsc: propagate rx filters to VF
Date: Mon, 28 May 2018 11:59:59 +0200
Message-Id: <20180528100328.938061334@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit bee9d41b37ea6b1f860e5bc0989cf1cf1d7e6ab3 ]

The netvsc device should propagate filters to the SR-IOV VF
device (if present). The flags also need to be propagated to the
VF device as well. This only really matters on local Hyper-V
since Azure does not support multiple addresses.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -66,10 +66,36 @@ static int debug = -1;
 module_param(debug, int, S_IRUGO);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
-static void netvsc_set_multicast_list(struct net_device *net)
+static void netvsc_change_rx_flags(struct net_device *net, int change)
 {
-	struct net_device_context *net_device_ctx = netdev_priv(net);
-	struct netvsc_device *nvdev = rtnl_dereference(net_device_ctx->nvdev);
+	struct net_device_context *ndev_ctx = netdev_priv(net);
+	struct net_device *vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	int inc;
+
+	if (!vf_netdev)
+		return;
+
+	if (change & IFF_PROMISC) {
+		inc = (net->flags & IFF_PROMISC) ? 1 : -1;
+		dev_set_promiscuity(vf_netdev, inc);
+	}
+
+	if (change & IFF_ALLMULTI) {
+		inc = (net->flags & IFF_ALLMULTI) ? 1 : -1;
+		dev_set_allmulti(vf_netdev, inc);
+	}
+}
+
+static void netvsc_set_rx_mode(struct net_device *net)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(net);
+	struct net_device *vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	struct netvsc_device *nvdev = rtnl_dereference(ndev_ctx->nvdev);
+
+	if (vf_netdev) {
+		dev_uc_sync(vf_netdev, net);
+		dev_mc_sync(vf_netdev, net);
+	}
 
 	rndis_filter_update(nvdev);
 }
@@ -1582,7 +1608,8 @@ static const struct net_device_ops devic
 	.ndo_open =			netvsc_open,
 	.ndo_stop =			netvsc_close,
 	.ndo_start_xmit =		netvsc_start_xmit,
-	.ndo_set_rx_mode =		netvsc_set_multicast_list,
+	.ndo_change_rx_flags =		netvsc_change_rx_flags,
+	.ndo_set_rx_mode =		netvsc_set_rx_mode,
 	.ndo_change_mtu =		netvsc_change_mtu,
 	.ndo_validate_addr =		eth_validate_addr,
 	.ndo_set_mac_address =		netvsc_set_mac_addr,
@@ -1814,6 +1841,11 @@ static void __netvsc_vf_setup(struct net
 		netdev_warn(vf_netdev,
 			    "unable to change mtu to %u\n", ndev->mtu);
 
+	/* set multicast etc flags on VF */
+	dev_change_flags(vf_netdev, ndev->flags | IFF_SLAVE);
+	dev_uc_sync(vf_netdev, ndev);
+	dev_mc_sync(vf_netdev, ndev);
+
 	if (netif_running(ndev)) {
 		ret = dev_open(vf_netdev);
 		if (ret)
