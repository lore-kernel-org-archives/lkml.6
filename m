Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCEOVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:21:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58661 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932304AbeCEOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:20:05 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Stefan Chulski <stefanc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next v2 5/5] net: mvpp2: jumbo frames support
Date: Mon,  5 Mar 2018 15:16:54 +0100
Message-Id: <20180305141654.7789-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305141654.7789-1-antoine.tenart@bootlin.com>
References: <20180305141654.7789-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

This patch adds the support for jumbo frames in the Marvell PPv2 driver.
A third buffer pool is added with 10KB buffers, which is used if the MTU
is higher than 1518B for packets larger than 1518B. Please note only the
port 0 supports hardware checksum offload due to the Tx FIFO size
limitation.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
[Antoine: cosmetic cleanup, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 98 +++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 78dc07c826c5..10b722197aed 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -815,6 +815,7 @@ enum mvpp2_prs_l3_cast {
 #define MVPP22_RSS_TABLE_ENTRIES	32
 
 /* BM constants */
+#define MVPP2_BM_JUMBO_BUF_NUM		512
 #define MVPP2_BM_LONG_BUF_NUM		1024
 #define MVPP2_BM_SHORT_BUF_NUM		2048
 #define MVPP2_BM_POOL_SIZE_MAX		(16*1024 - MVPP2_BM_POOL_PTR_ALIGN/4)
@@ -826,12 +827,14 @@ enum mvpp2_prs_l3_cast {
 
 #define MVPP2_BM_SHORT_FRAME_SIZE		512
 #define MVPP2_BM_LONG_FRAME_SIZE		2048
+#define MVPP2_BM_JUMBO_FRAME_SIZE		10240
 /* BM short pool packet size
  * These value assure that for SWF the total number
  * of bytes allocated for each buffer will be 512
  */
 #define MVPP2_BM_SHORT_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_SHORT_FRAME_SIZE)
 #define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
+#define MVPP2_BM_JUMBO_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_JUMBO_FRAME_SIZE)
 
 #define MVPP21_ADDR_SPACE_SZ		0
 #define MVPP22_ADDR_SPACE_SZ		SZ_64K
@@ -842,6 +845,7 @@ enum mvpp2_prs_l3_cast {
 enum mvpp2_bm_pool_log_num {
 	MVPP2_BM_SHORT,
 	MVPP2_BM_LONG,
+	MVPP2_BM_JUMBO,
 	MVPP2_BM_POOLS_NUM
 };
 
@@ -4393,6 +4397,10 @@ static void mvpp2_setup_bm_pool(void)
 	/* Long pool */
 	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
 	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
+
+	/* Jumbo pool */
+	mvpp2_pools[MVPP2_BM_JUMBO].buf_num  = MVPP2_BM_JUMBO_BUF_NUM;
+	mvpp2_pools[MVPP2_BM_JUMBO].pkt_size = MVPP2_BM_JUMBO_PKT_SIZE;
 }
 
 /* Attach long pool to rxq */
@@ -4596,15 +4604,28 @@ mvpp2_bm_pool_use(struct mvpp2_port *port, unsigned pool, int pkt_size)
 static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 {
 	int rxq;
+	enum mvpp2_bm_pool_log_num long_log_pool, short_log_pool;
+
+	/* If port pkt_size is higher than 1518B:
+	 * HW Long pool - SW Jumbo pool, HW Short pool - SW Long pool
+	 * else: HW Long pool - SW Long pool, HW Short pool - SW Short pool
+	 */
+	if (port->pkt_size > MVPP2_BM_LONG_PKT_SIZE) {
+		long_log_pool = MVPP2_BM_JUMBO;
+		short_log_pool = MVPP2_BM_LONG;
+	} else {
+		long_log_pool = MVPP2_BM_LONG;
+		short_log_pool = MVPP2_BM_SHORT;
+	}
 
 	if (!port->pool_long) {
 		port->pool_long =
-			mvpp2_bm_pool_use(port, MVPP2_BM_LONG,
-					  mvpp2_pools[MVPP2_BM_LONG].pkt_size);
+			mvpp2_bm_pool_use(port, long_log_pool,
+					  mvpp2_pools[long_log_pool].pkt_size);
 		if (!port->pool_long)
 			return -ENOMEM;
 
-		port->pool_long->port_map |= (1 << port->id);
+		port->pool_long->port_map |= BIT(port->id);
 
 		for (rxq = 0; rxq < port->nrxqs; rxq++)
 			mvpp2_rxq_long_pool_set(port, rxq, port->pool_long->id);
@@ -4612,12 +4633,12 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 
 	if (!port->pool_short) {
 		port->pool_short =
-			mvpp2_bm_pool_use(port, MVPP2_BM_SHORT,
-					  mvpp2_pools[MVPP2_BM_SHORT].pkt_size);
+			mvpp2_bm_pool_use(port, short_log_pool,
+					  mvpp2_pools[long_log_pool].pkt_size);
 		if (!port->pool_short)
 			return -ENOMEM;
 
-		port->pool_short->port_map |= (1 << port->id);
+		port->pool_short->port_map |= BIT(port->id);
 
 		for (rxq = 0; rxq < port->nrxqs; rxq++)
 			mvpp2_rxq_short_pool_set(port, rxq,
@@ -4630,24 +4651,49 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
-	struct mvpp2_bm_pool *port_pool = port->pool_long;
-	int num, pkts_num = port_pool->buf_num;
+	enum mvpp2_bm_pool_log_num new_long_pool;
+	int pkt_size = MVPP2_RX_PKT_SIZE(mtu);
 
-	/* Update BM pool with new buffer size */
-	mvpp2_bm_bufs_free(dev->dev.parent, port->priv, port_pool,
-			   port_pool->buf_num);
-	if (port_pool->buf_num) {
-		WARN(1, "cannot free all buffers in pool %d\n", port_pool->id);
-		return -EIO;
+	/* If port MTU is higher than 1518B:
+	 * HW Long pool - SW Jumbo pool, HW Short pool - SW Long pool
+	 * else: HW Long pool - SW Long pool, HW Short pool - SW Short pool
+	 */
+	if (pkt_size > MVPP2_BM_LONG_PKT_SIZE)
+		new_long_pool = MVPP2_BM_JUMBO;
+	else
+		new_long_pool = MVPP2_BM_LONG;
+
+	if (new_long_pool != port->pool_long->id) {
+		/* Remove port from old short & long pool */
+		port->pool_long = mvpp2_bm_pool_use(port, port->pool_long->id,
+						    port->pool_long->pkt_size);
+		port->pool_long->port_map &= ~BIT(port->id);
+		port->pool_long = NULL;
+
+		port->pool_short = mvpp2_bm_pool_use(port, port->pool_short->id,
+						     port->pool_short->pkt_size);
+		port->pool_short->port_map &= ~BIT(port->id);
+		port->pool_short = NULL;
+
+		port->pkt_size =  pkt_size;
+
+		/* Add port to new short & long pool */
+		mvpp2_swf_bm_pool_init(port);
+
+		/* Update L4 checksum when jumbo enable/disable on port */
+		if (new_long_pool == MVPP2_BM_JUMBO && port->id != 0) {
+			dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
+			dev->hw_features &= ~(NETIF_F_IP_CSUM |
+					      NETIF_F_IPV6_CSUM);
+		} else {
+			dev->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+			dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+		}
 	}
 
-	num = mvpp2_bm_bufs_add(port, port_pool, pkts_num);
-	if (num != pkts_num) {
-		WARN(1, "pool %d: %d of %d allocated\n",
-		     port_pool->id, num, pkts_num);
-		return -EIO;
-	}
 	dev->mtu = mtu;
+	dev->wanted_features = dev->features;
+
 	netdev_update_features(dev);
 	return 0;
 }
@@ -8326,13 +8372,19 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->features = features | NETIF_F_RXCSUM;
 	dev->hw_features |= features | NETIF_F_RXCSUM | NETIF_F_GRO |
 			    NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
+		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
+		dev->hw_features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
+	}
+
 	dev->vlan_features |= features;
 	dev->gso_max_segs = MVPP2_MAX_TSO_SEGS;
 
-	/* MTU range: 68 - 9676 */
+	/* MTU range: 68 - 9704 */
 	dev->min_mtu = ETH_MIN_MTU;
-	/* 9676 == 9700 - 20 and rounding to 8 */
-	dev->max_mtu = 9676;
+	/* 9704 == 9728 - 20 and rounding to 8 */
+	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
 
 	err = register_netdev(dev);
 	if (err < 0) {
-- 
2.14.3
