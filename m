Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165174AbeE1NIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163879AbeE1Kvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 236/496] hv_netvsc: fix locking during VF setup
Date: Mon, 28 May 2018 12:00:21 +0200
Message-Id: <20180528100329.847535404@linuxfoundation.org>
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

[ Upstream commit b0dee7910317f41f398838992516af6a3b981d86 ]

The dev_uc/mc_sync calls need to have the device address list
locked. This was spotted by running with lockdep enabled.

Fixes: bee9d41b37ea ("hv_netvsc: propagate rx filters to VF")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1848,8 +1848,12 @@ static void __netvsc_vf_setup(struct net
 
 	/* set multicast etc flags on VF */
 	dev_change_flags(vf_netdev, ndev->flags | IFF_SLAVE);
+
+	/* sync address list from ndev to VF */
+	netif_addr_lock_bh(ndev);
 	dev_uc_sync(vf_netdev, ndev);
 	dev_mc_sync(vf_netdev, ndev);
+	netif_addr_unlock_bh(ndev);
 
 	if (netif_running(ndev)) {
 		ret = dev_open(vf_netdev);
