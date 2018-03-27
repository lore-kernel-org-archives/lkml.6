Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC0OuL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:50:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54991 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeC0OuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:50:10 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next] net: mvpp2: Use relaxed I/O in data path
Date: Tue, 27 Mar 2018 16:49:05 +0200
Message-Id: <20180327144905.23499-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Use relaxed I/O on the hot path. This achieves significant performance
improvements. On a 10G link, this makes a basic iperf TCP test go from
an average of 4.5 Gbits/sec to about 9.40 Gbits/sec.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Maxime: Commit message, cosmetic changes]
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
David, this patch should not conflict with other the pending PPv2 series I sent
earlier ("[PATCH net-next 0/2] net: mvpp2: Remove unnecessary dynamic allocs")

 drivers/net/ethernet/marvell/mvpp2.c | 43 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index f8bc3d4a39ff..5a68e00e9c5b 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -1359,6 +1359,10 @@ static u32 mvpp2_read(struct mvpp2 *priv, u32 offset)
 	return readl(priv->swth_base[0] + offset);
 }
 
+static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
+{
+	return readl_relaxed(priv->swth_base[0] + offset);
+}
 /* These accessors should be used to access:
  *
  * - per-CPU registers, where each CPU has its own copy of the
@@ -1407,6 +1411,18 @@ static u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu,
 	return readl(priv->swth_base[cpu] + offset);
 }
 
+static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu,
+				       u32 offset, u32 data)
+{
+	writel_relaxed(data, priv->swth_base[cpu] + offset);
+}
+
+static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
+				     u32 offset)
+{
+	return readl_relaxed(priv->swth_base[cpu] + offset);
+}
+
 static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
 					    struct mvpp2_tx_desc *tx_desc)
 {
@@ -4488,8 +4504,8 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 				<< MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT) &
 				MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK;
 
-		mvpp2_percpu_write(port->priv, cpu,
-				   MVPP22_BM_ADDR_HIGH_RLS_REG, val);
+		mvpp2_percpu_write_relaxed(port->priv, cpu,
+					   MVPP22_BM_ADDR_HIGH_RLS_REG, val);
 	}
 
 	/* MVPP2_BM_VIRT_RLS_REG is not interpreted by HW, and simply
@@ -4497,10 +4513,10 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 	 * descriptor. Instead of storing the virtual address, we
 	 * store the physical address
 	 */
-	mvpp2_percpu_write(port->priv, cpu,
-			   MVPP2_BM_VIRT_RLS_REG, buf_phys_addr);
-	mvpp2_percpu_write(port->priv, cpu,
-			   MVPP2_BM_PHY_RLS_REG(pool), buf_dma_addr);
+	mvpp2_percpu_write_relaxed(port->priv, cpu,
+				   MVPP2_BM_VIRT_RLS_REG, buf_phys_addr);
+	mvpp2_percpu_write_relaxed(port->priv, cpu,
+				   MVPP2_BM_PHY_RLS_REG(pool), buf_dma_addr);
 
 	put_cpu();
 }
@@ -5592,7 +5608,8 @@ static int mvpp2_aggr_desc_num_check(struct mvpp2 *priv,
 	if ((aggr_txq->count + num) > MVPP2_AGGR_TXQ_SIZE) {
 		/* Update number of occupied aggregated Tx descriptors */
 		int cpu = smp_processor_id();
-		u32 val = mvpp2_read(priv, MVPP2_AGGR_TXQ_STATUS_REG(cpu));
+		u32 val = mvpp2_read_relaxed(priv,
+					     MVPP2_AGGR_TXQ_STATUS_REG(cpu));
 
 		aggr_txq->count = val & MVPP2_AGGR_TXQ_PENDING_MASK;
 	}
@@ -5616,9 +5633,9 @@ static int mvpp2_txq_alloc_reserved_desc(struct mvpp2 *priv,
 	int cpu = smp_processor_id();
 
 	val = (txq->id << MVPP2_TXQ_RSVD_REQ_Q_OFFSET) | num;
-	mvpp2_percpu_write(priv, cpu, MVPP2_TXQ_RSVD_REQ_REG, val);
+	mvpp2_percpu_write_relaxed(priv, cpu, MVPP2_TXQ_RSVD_REQ_REG, val);
 
-	val = mvpp2_percpu_read(priv, cpu, MVPP2_TXQ_RSVD_RSLT_REG);
+	val = mvpp2_percpu_read_relaxed(priv, cpu, MVPP2_TXQ_RSVD_RSLT_REG);
 
 	return val & MVPP2_TXQ_RSVD_RSLT_MASK;
 }
@@ -5723,8 +5740,8 @@ static inline int mvpp2_txq_sent_desc_proc(struct mvpp2_port *port,
 	u32 val;
 
 	/* Reading status reg resets transmitted descriptor counter */
-	val = mvpp2_percpu_read(port->priv, smp_processor_id(),
-				MVPP2_TXQ_SENT_REG(txq->id));
+	val = mvpp2_percpu_read_relaxed(port->priv, smp_processor_id(),
+					MVPP2_TXQ_SENT_REG(txq->id));
 
 	return (val & MVPP2_TRANSMITTED_COUNT_MASK) >>
 		MVPP2_TRANSMITTED_COUNT_OFFSET;
@@ -7090,8 +7107,8 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 	 *
 	 * Each CPU has its own Rx/Tx cause register
 	 */
-	cause_rx_tx = mvpp2_percpu_read(port->priv, qv->sw_thread_id,
-					MVPP2_ISR_RX_TX_CAUSE_REG(port->id));
+	cause_rx_tx = mvpp2_percpu_read_relaxed(port->priv, qv->sw_thread_id,
+						MVPP2_ISR_RX_TX_CAUSE_REG(port->id));
 
 	cause_misc = cause_rx_tx & MVPP2_CAUSE_MISC_SUM_MASK;
 	if (cause_misc) {
-- 
2.11.0
