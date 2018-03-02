Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424633AbeCBPpR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:45:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36258 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033793AbeCBPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:45:09 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Stefan Chulski <stefanc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 2/5] net: mvpp2: update the BM buffer free/destroy logic
Date: Fri,  2 Mar 2018 16:40:41 +0100
Message-Id: <20180302154044.25204-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180302154044.25204-1-antoine.tenart@bootlin.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

The buffer free routine is updated to release only given a number of
buffers, and the destroy routine now checks the actual number of buffers
in the (BPPI and BPPE) HW counters before draining the pools. This
change helps getting jumbo frames support.

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
[Antoine: cosmetic cleanup, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 45 ++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index ca349d520d22..db511dd4249d 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -258,6 +258,7 @@
 #define MVPP2_BM_BPPI_READ_PTR_REG(pool)	(0x6100 + ((pool) * 4))
 #define MVPP2_BM_BPPI_PTRS_NUM_REG(pool)	(0x6140 + ((pool) * 4))
 #define     MVPP2_BM_BPPI_PTR_NUM_MASK		0x7ff
+#define MVPP22_BM_POOL_PTRS_NUM_MASK		0xfff8
 #define     MVPP2_BM_BPPI_PREFETCH_FULL_MASK	BIT(16)
 #define MVPP2_BM_POOL_CTRL_REG(pool)		(0x6200 + ((pool) * 4))
 #define     MVPP2_BM_START_MASK			BIT(0)
@@ -4251,11 +4252,17 @@ static void mvpp2_bm_bufs_get_addrs(struct device *dev, struct mvpp2 *priv,
 
 /* Free all buffers from the pool */
 static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
-			       struct mvpp2_bm_pool *bm_pool)
+			       struct mvpp2_bm_pool *bm_pool, int buf_num)
 {
 	int i;
 
-	for (i = 0; i < bm_pool->buf_num; i++) {
+	if (buf_num > bm_pool->buf_num) {
+		WARN(1, "Pool does not have so many bufs pool(%d) bufs(%d)\n",
+		     bm_pool->id, buf_num);
+		buf_num = bm_pool->buf_num;
+	}
+
+	for (i = 0; i < buf_num; i++) {
 		dma_addr_t buf_dma_addr;
 		phys_addr_t buf_phys_addr;
 		void *data;
@@ -4277,16 +4284,39 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
 	bm_pool->buf_num -= i;
 }
 
+/* Check number of buffers in BM pool */
+int mvpp2_check_hw_buf_num(struct mvpp2 *priv, struct mvpp2_bm_pool *bm_pool)
+{
+	int buf_num = 0;
+
+	buf_num += mvpp2_read(priv, MVPP2_BM_POOL_PTRS_NUM_REG(bm_pool->id)) &
+				    MVPP22_BM_POOL_PTRS_NUM_MASK;
+	buf_num += mvpp2_read(priv, MVPP2_BM_BPPI_PTRS_NUM_REG(bm_pool->id)) &
+				    MVPP2_BM_BPPI_PTR_NUM_MASK;
+
+	/* HW has one buffer ready which is not reflected in the counters */
+	if (buf_num)
+		buf_num += 1;
+
+	return buf_num;
+}
+
 /* Cleanup pool */
 static int mvpp2_bm_pool_destroy(struct platform_device *pdev,
 				 struct mvpp2 *priv,
 				 struct mvpp2_bm_pool *bm_pool)
 {
+	int buf_num;
 	u32 val;
 
-	mvpp2_bm_bufs_free(&pdev->dev, priv, bm_pool);
-	if (bm_pool->buf_num) {
-		WARN(1, "cannot free all buffers in pool %d\n", bm_pool->id);
+	buf_num = mvpp2_check_hw_buf_num(priv, bm_pool);
+	mvpp2_bm_bufs_free(&pdev->dev, priv, bm_pool, buf_num);
+
+	/* Check buffer counters after free */
+	buf_num = mvpp2_check_hw_buf_num(priv, bm_pool);
+	if (buf_num) {
+		WARN(1, "cannot free all buffers in pool %d, buf_num left %d\n",
+		     bm_pool->id, bm_pool->buf_num);
 		return 0;
 	}
 
@@ -4534,7 +4564,7 @@ mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, int pkt_size)
 			pkts_num = mvpp2_pools[pool].buf_num;
 		else
 			mvpp2_bm_bufs_free(port->dev->dev.parent,
-					   port->priv, new_pool);
+					   port->priv, new_pool, pkts_num);
 
 		new_pool->pkt_size = pkt_size;
 		new_pool->frag_size =
@@ -4598,7 +4628,8 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 	int num, pkts_num = port_pool->buf_num;
 
 	/* Update BM pool with new buffer size */
-	mvpp2_bm_bufs_free(dev->dev.parent, port->priv, port_pool);
+	mvpp2_bm_bufs_free(dev->dev.parent, port->priv, port_pool,
+			   port_pool->buf_num);
 	if (port_pool->buf_num) {
 		WARN(1, "cannot free all buffers in pool %d\n", port_pool->id);
 		return -EIO;
-- 
2.14.3
