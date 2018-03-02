Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034354AbeCBPpN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:45:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033791AbeCBPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:45:09 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Stefan Chulski <stefanc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for all ports
Date: Fri,  2 Mar 2018 16:40:40 +0100
Message-Id: <20180302154044.25204-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180302154044.25204-1-antoine.tenart@bootlin.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

This patch configures the buffer manager long pool for all ports part of
the same CP. Long pool separation between ports is redundant since there
are no performance improvement when different pools are used.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
[Antoine: cosmetic cleanup, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 76 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 2acf499fc317..ca349d520d22 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -808,23 +808,23 @@ enum mvpp2_prs_l3_cast {
 #define MVPP22_RSS_TABLE_ENTRIES	32
 
 /* BM constants */
-#define MVPP2_BM_POOLS_NUM		8
 #define MVPP2_BM_LONG_BUF_NUM		1024
 #define MVPP2_BM_SHORT_BUF_NUM		2048
 #define MVPP2_BM_POOL_SIZE_MAX		(16*1024 - MVPP2_BM_POOL_PTR_ALIGN/4)
 #define MVPP2_BM_POOL_PTR_ALIGN		128
-#define MVPP2_BM_SWF_LONG_POOL(port)	((port > 2) ? 2 : port)
-#define MVPP2_BM_SWF_SHORT_POOL		3
 
 /* BM cookie (32 bits) definition */
 #define MVPP2_BM_COOKIE_POOL_OFFS	8
 #define MVPP2_BM_COOKIE_CPU_OFFS	24
 
+#define MVPP2_BM_SHORT_FRAME_SIZE		512
+#define MVPP2_BM_LONG_FRAME_SIZE		2048
 /* BM short pool packet size
  * These value assure that for SWF the total number
  * of bytes allocated for each buffer will be 512
  */
-#define MVPP2_BM_SHORT_PKT_SIZE		MVPP2_RX_MAX_PKT_SIZE(512)
+#define MVPP2_BM_SHORT_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_SHORT_FRAME_SIZE)
+#define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
 
 #define MVPP21_ADDR_SPACE_SZ		0
 #define MVPP22_ADDR_SPACE_SZ		SZ_64K
@@ -832,12 +832,17 @@ enum mvpp2_prs_l3_cast {
 #define MVPP2_MAX_THREADS		8
 #define MVPP2_MAX_QVECS			MVPP2_MAX_THREADS
 
-enum mvpp2_bm_type {
-	MVPP2_BM_FREE,
-	MVPP2_BM_SWF_LONG,
-	MVPP2_BM_SWF_SHORT
+enum mvpp2_bm_pool_log_num {
+	MVPP2_BM_SHORT,
+	MVPP2_BM_LONG,
+	MVPP2_BM_POOLS_NUM
 };
 
+static struct {
+	int pkt_size;
+	int buf_num;
+} mvpp2_pools[MVPP2_BM_POOLS_NUM];
+
 /* GMAC MIB Counters register definitions */
 #define MVPP21_MIB_COUNTERS_OFFSET		0x1000
 #define MVPP21_MIB_COUNTERS_PORT_SZ		0x400
@@ -1266,7 +1271,6 @@ struct mvpp2_cls_lookup_entry {
 struct mvpp2_bm_pool {
 	/* Pool number in the range 0-7 */
 	int id;
-	enum mvpp2_bm_type type;
 
 	/* Buffer Pointers Pool External (BPPE) size */
 	int size;
@@ -4195,7 +4199,6 @@ static int mvpp2_bm_pool_create(struct platform_device *pdev,
 	val |= MVPP2_BM_START_MASK;
 	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(bm_pool->id), val);
 
-	bm_pool->type = MVPP2_BM_FREE;
 	bm_pool->size = size;
 	bm_pool->pkt_size = 0;
 	bm_pool->buf_num = 0;
@@ -4345,6 +4348,17 @@ static int mvpp2_bm_init(struct platform_device *pdev, struct mvpp2 *priv)
 	return 0;
 }
 
+static void mvpp2_setup_bm_pool(void)
+{
+	/* Short pool */
+	mvpp2_pools[MVPP2_BM_SHORT].buf_num  = MVPP2_BM_SHORT_BUF_NUM;
+	mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
+
+	/* Long pool */
+	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
+	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
+}
+
 /* Attach long pool to rxq */
 static void mvpp2_rxq_long_pool_set(struct mvpp2_port *port,
 				    int lrxq, int long_pool)
@@ -4483,13 +4497,11 @@ static int mvpp2_bm_bufs_add(struct mvpp2_port *port,
 	bm_pool->buf_num += i;
 
 	netdev_dbg(port->dev,
-		   "%s pool %d: pkt_size=%4d, buf_size=%4d, total_size=%4d\n",
-		   bm_pool->type == MVPP2_BM_SWF_SHORT ? "short" : " long",
+		   "pool %d: pkt_size=%4d, buf_size=%4d, total_size=%4d\n",
 		   bm_pool->id, bm_pool->pkt_size, buf_size, total_size);
 
 	netdev_dbg(port->dev,
-		   "%s pool %d: %d of %d buffers added\n",
-		   bm_pool->type == MVPP2_BM_SWF_SHORT ? "short" : " long",
+		   "pool %d: %d of %d buffers added\n",
 		   bm_pool->id, i, buf_num);
 	return i;
 }
@@ -4498,25 +4510,20 @@ static int mvpp2_bm_bufs_add(struct mvpp2_port *port,
  * pool pointer on success
  */
 static struct mvpp2_bm_pool *
-mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, enum mvpp2_bm_type type,
-		  int pkt_size)
+mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, int pkt_size)
 {
 	struct mvpp2_bm_pool *new_pool = &port->priv->bm_pools[pool];
 	int num;
 
-	if (new_pool->type != MVPP2_BM_FREE && new_pool->type != type) {
-		netdev_err(port->dev, "mixing pool types is forbidden\n");
+	if (pool < MVPP2_BM_SHORT || pool > MVPP2_BM_LONG) {
+		netdev_err(port->dev, "Invalid pool %d\n", pool);
 		return NULL;
 	}
 
-	if (new_pool->type == MVPP2_BM_FREE)
-		new_pool->type = type;
-
 	/* Allocate buffers in case BM pool is used as long pool, but packet
 	 * size doesn't match MTU or BM pool hasn't being used yet
 	 */
-	if (((type == MVPP2_BM_SWF_LONG) && (pkt_size > new_pool->pkt_size)) ||
-	    (new_pool->pkt_size == 0)) {
+	if (new_pool->pkt_size == 0) {
 		int pkts_num;
 
 		/* Set default buffer number or free all the buffers in case
@@ -4524,9 +4531,7 @@ mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, enum mvpp2_bm_type type,
 		 */
 		pkts_num = new_pool->buf_num;
 		if (pkts_num == 0)
-			pkts_num = type == MVPP2_BM_SWF_LONG ?
-				   MVPP2_BM_LONG_BUF_NUM :
-				   MVPP2_BM_SHORT_BUF_NUM;
+			pkts_num = mvpp2_pools[pool].buf_num;
 		else
 			mvpp2_bm_bufs_free(port->dev->dev.parent,
 					   port->priv, new_pool);
@@ -4558,9 +4563,8 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 
 	if (!port->pool_long) {
 		port->pool_long =
-		       mvpp2_bm_pool_use(port, MVPP2_BM_SWF_LONG_POOL(port->id),
-					 MVPP2_BM_SWF_LONG,
-					 port->pkt_size);
+			mvpp2_bm_pool_use(port, MVPP2_BM_LONG,
+					  mvpp2_pools[MVPP2_BM_LONG].pkt_size);
 		if (!port->pool_long)
 			return -ENOMEM;
 
@@ -4572,9 +4576,8 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 
 	if (!port->pool_short) {
 		port->pool_short =
-			mvpp2_bm_pool_use(port, MVPP2_BM_SWF_SHORT_POOL,
-					  MVPP2_BM_SWF_SHORT,
-					  MVPP2_BM_SHORT_PKT_SIZE);
+			mvpp2_bm_pool_use(port, MVPP2_BM_SHORT,
+					  mvpp2_pools[MVPP2_BM_SHORT].pkt_size);
 		if (!port->pool_short)
 			return -ENOMEM;
 
@@ -4593,7 +4596,6 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_bm_pool *port_pool = port->pool_long;
 	int num, pkts_num = port_pool->buf_num;
-	int pkt_size = MVPP2_RX_PKT_SIZE(mtu);
 
 	/* Update BM pool with new buffer size */
 	mvpp2_bm_bufs_free(dev->dev.parent, port->priv, port_pool);
@@ -4602,18 +4604,12 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 		return -EIO;
 	}
 
-	port_pool->pkt_size = pkt_size;
-	port_pool->frag_size = SKB_DATA_ALIGN(MVPP2_RX_BUF_SIZE(pkt_size)) +
-		MVPP2_SKB_SHINFO_SIZE;
 	num = mvpp2_bm_bufs_add(port, port_pool, pkts_num);
 	if (num != pkts_num) {
 		WARN(1, "pool %d: %d of %d allocated\n",
 		     port_pool->id, num, pkts_num);
 		return -EIO;
 	}
-
-	mvpp2_bm_pool_bufsize_set(port->priv, port_pool,
-				  MVPP2_RX_BUF_SIZE(port_pool->pkt_size));
 	dev->mtu = mtu;
 	netdev_update_features(dev);
 	return 0;
@@ -8630,6 +8626,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 			priv->sysctrl_base = NULL;
 	}
 
+	mvpp2_setup_bm_pool();
+
 	for (i = 0; i < MVPP2_MAX_THREADS; i++) {
 		u32 addr_space_sz;
 
-- 
2.14.3
