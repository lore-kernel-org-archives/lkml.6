Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937066AbeE3DDs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:03:48 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56402 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935948AbeE3DDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:03:44 -0400
Date: Wed, 30 May 2018 13:03:51 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cba8175deaf9d631ae000088aea1ccf1c444909b.1527649393.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net] net/sonic: Use dma_mapping_error()
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DMA_API_DEBUG=y, calling sonic_open() produces the
message, "DMA-API: device driver failed to check map error".
Add the missing dma_mapping_error() call.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 7ed08486ae23..c805dcbebd02 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -84,7 +84,7 @@ static int sonic_open(struct net_device *dev)
 	for (i = 0; i < SONIC_NUM_RRS; i++) {
 		dma_addr_t laddr = dma_map_single(lp->device, skb_put(lp->rx_skb[i], SONIC_RBSIZE),
 		                                  SONIC_RBSIZE, DMA_FROM_DEVICE);
-		if (!laddr) {
+		if (dma_mapping_error(lp->device, laddr)) {
 			while(i > 0) { /* free any that were mapped successfully */
 				i--;
 				dma_unmap_single(lp->device, lp->rx_laddr[i], SONIC_RBSIZE, DMA_FROM_DEVICE);
-- 
2.16.1
