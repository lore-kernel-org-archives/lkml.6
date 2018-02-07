Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeBGBRT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:17:19 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:32307 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeBGBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:17:17 -0500
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Tue, 6 Feb 2018 19:17:06 -0600
Message-ID: <20180207011706.13393-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that simple program which indefinitely sends 200b UDP
packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
timeout is triggered due to race between cpsw_ndo_start_xmit() and
cpsw_tx_handler() [NAPI]

cpsw_ndo_start_xmit()
	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
		txq = netdev_get_tx_queue(ndev, q_idx);
		netif_tx_stop_queue(txq);

^^ as per [1] barier has to be used after set_bit() otherwise new value
might not be visible to other cpus
	}

cpsw_tx_handler()
	if (unlikely(netif_tx_queue_stopped(txq)))
		netif_tx_wake_queue(txq);

and when it happens ndev TX queue became disabled forever while driver's HW
TX queue is empty.

Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
calls and double check for free TX descriptors after stopping ndev TX queue
- if there are free TX descriptors wake up ndev TX queue.

[1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 10d7cbe..3805b13 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1638,6 +1638,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 		q_idx = q_idx % cpsw->tx_ch_num;
 
 	txch = cpsw->txv[q_idx].ch;
+	txq = netdev_get_tx_queue(ndev, q_idx);
 	ret = cpsw_tx_packet_submit(priv, skb, txch);
 	if (unlikely(ret != 0)) {
 		cpsw_err(priv, tx_err, "desc submit failed\n");
@@ -1648,15 +1649,26 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	 * tell the kernel to stop sending us tx frames.
 	 */
 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
-		txq = netdev_get_tx_queue(ndev, q_idx);
 		netif_tx_stop_queue(txq);
+
+		/* Barrier, so that stop_queue visible to other cpus */
+		smp_mb__after_atomic();
+
+		if (cpdma_check_free_tx_desc(txch))
+			netif_tx_wake_queue(txq);
 	}
 
 	return NETDEV_TX_OK;
 fail:
 	ndev->stats.tx_dropped++;
-	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
 	netif_tx_stop_queue(txq);
+
+	/* Barrier, so that stop_queue visible to other cpus */
+	smp_mb__after_atomic();
+
+	if (cpdma_check_free_tx_desc(txch))
+		netif_tx_wake_queue(txq);
+
 	return NETDEV_TX_BUSY;
 }
 
-- 
2.10.5
