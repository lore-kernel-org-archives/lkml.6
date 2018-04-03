Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeDCV32 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:29:28 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.109]:49914 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752788AbeDCV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:29:27 -0400
Date: Tue, 3 Apr 2018 16:29:25 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereference
Message-ID: <20180403212925.GA31093@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3TUc-000j1Q-Db
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:53894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add null check on kmalloc() return value in order to prevent
a null pointer dereference.

Addresses-Coverity-ID: 1467429 ("Dereference null return value")
Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1e9a31f..468321a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1999,6 +1999,8 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 				struct xcast_addr *xaddr;
 
 				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
+				if (unlikely(!mc_list))
+					return;
 				INIT_LIST_HEAD(&mc_list->list);
 				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
 					xaddr = kmalloc(sizeof(*xaddr),
-- 
2.7.4
