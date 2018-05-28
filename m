Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163890AbeE1Kvw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163652AbeE1Kvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 235/496] hv_netvsc: fix locking for rx_mode
Date: Mon, 28 May 2018 12:00:20 +0200
Message-Id: <20180528100329.810379683@linuxfoundation.org>
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

[ Upstream commit 35a57b7fef136fa3d5b735ba773f191b95110fa0 ]

The rx_mode operation handler is different than other callbacks
in that is not always called with rtnl held. Therefore use
RCU to ensure that references are valid.

Fixes: bee9d41b37ea ("hv_netvsc: propagate rx filters to VF")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -89,15 +89,20 @@ static void netvsc_change_rx_flags(struc
 static void netvsc_set_rx_mode(struct net_device *net)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(net);
-	struct net_device *vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
-	struct netvsc_device *nvdev = rtnl_dereference(ndev_ctx->nvdev);
+	struct net_device *vf_netdev;
+	struct netvsc_device *nvdev;
 
+	rcu_read_lock();
+	vf_netdev = rcu_dereference(ndev_ctx->vf_netdev);
 	if (vf_netdev) {
 		dev_uc_sync(vf_netdev, net);
 		dev_mc_sync(vf_netdev, net);
 	}
 
-	rndis_filter_update(nvdev);
+	nvdev = rcu_dereference(ndev_ctx->nvdev);
+	if (nvdev)
+		rndis_filter_update(nvdev);
+	rcu_read_unlock();
 }
 
 static int netvsc_open(struct net_device *net)
