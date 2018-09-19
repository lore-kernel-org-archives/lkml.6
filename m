Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93679C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349E2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349E2214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbeISPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeISPHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5F681208EB; Wed, 19 Sep 2018 11:30:14 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 25653208F3;
        Wed, 19 Sep 2018 11:30:04 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 12/12] net: mvpp2: rename mvpp2_percpu function to mvpp2_thread
Date:   Wed, 19 Sep 2018 11:27:11 +0200
Message-Id: <20180919092711.22296-13-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the mvpp2_percpu_read/write/... functions aren't really per-cpu but
per s/w thread, rename them to include 'thread' instead of 'percpu'.
This is a cosmetic patch.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 94 +++++++++----------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f34b958997dc..af6e62c6579b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -129,25 +129,25 @@ static inline u32 mvpp2_cpu_to_thread(struct mvpp2 *priv, int cpu)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  */
-static void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int thread,
+static void mvpp2_thread_write(struct mvpp2 *priv, unsigned int thread,
 			       u32 offset, u32 data)
 {
 	writel(data, priv->swth_base[thread] + offset);
 }
 
-static u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int thread,
+static u32 mvpp2_thread_read(struct mvpp2 *priv, unsigned int thread,
 			     u32 offset)
 {
 	return readl(priv->swth_base[thread] + offset);
 }
 
-static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int thread,
+static void mvpp2_thread_write_relaxed(struct mvpp2 *priv, unsigned int thread,
 				       u32 offset, u32 data)
 {
 	writel_relaxed(data, priv->swth_base[thread] + offset);
 }
 
-static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, unsigned int thread,
+static u32 mvpp2_thread_read_relaxed(struct mvpp2 *priv, unsigned int thread,
 				     u32 offset)
 {
 	return readl_relaxed(priv->swth_base[thread] + offset);
@@ -394,15 +394,15 @@ static void mvpp2_bm_bufs_get_addrs(struct device *dev, struct mvpp2 *priv,
 {
 	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
 
-	*dma_addr = mvpp2_percpu_read(priv, thread,
+	*dma_addr = mvpp2_thread_read(priv, thread,
 				      MVPP2_BM_PHY_ALLOC_REG(bm_pool->id));
-	*phys_addr = mvpp2_percpu_read(priv, thread, MVPP2_BM_VIRT_ALLOC_REG);
+	*phys_addr = mvpp2_thread_read(priv, thread, MVPP2_BM_VIRT_ALLOC_REG);
 
 	if (priv->hw_version == MVPP22) {
 		u32 val;
 		u32 dma_addr_highbits, phys_addr_highbits;
 
-		val = mvpp2_percpu_read(priv, thread, MVPP22_BM_ADDR_HIGH_ALLOC);
+		val = mvpp2_thread_read(priv, thread, MVPP22_BM_ADDR_HIGH_ALLOC);
 		dma_addr_highbits = (val & MVPP22_BM_ADDR_HIGH_PHYS_MASK);
 		phys_addr_highbits = (val & MVPP22_BM_ADDR_HIGH_VIRT_MASK) >>
 			MVPP22_BM_ADDR_HIGH_VIRT_SHIFT;
@@ -651,7 +651,7 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 				<< MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT) &
 				MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK;
 
-		mvpp2_percpu_write_relaxed(port->priv, thread,
+		mvpp2_thread_write_relaxed(port->priv, thread,
 					   MVPP22_BM_ADDR_HIGH_RLS_REG, val);
 	}
 
@@ -660,9 +660,9 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 	 * descriptor. Instead of storing the virtual address, we
 	 * store the physical address
 	 */
-	mvpp2_percpu_write_relaxed(port->priv, thread,
+	mvpp2_thread_write_relaxed(port->priv, thread,
 				   MVPP2_BM_VIRT_RLS_REG, buf_phys_addr);
-	mvpp2_percpu_write_relaxed(port->priv, thread,
+	mvpp2_thread_write_relaxed(port->priv, thread,
 				   MVPP2_BM_PHY_RLS_REG(pool), buf_dma_addr);
 
 	if (test_bit(thread, &port->priv->lock_map))
@@ -912,7 +912,7 @@ static void mvpp2_interrupts_mask(void *arg)
 	if (smp_processor_id() > port->priv->nthreads)
 		return;
 
-	mvpp2_percpu_write(port->priv,
+	mvpp2_thread_write(port->priv,
 			   mvpp2_cpu_to_thread(port->priv, smp_processor_id()),
 			   MVPP2_ISR_RX_TX_MASK_REG(port->id), 0);
 }
@@ -935,7 +935,7 @@ static void mvpp2_interrupts_unmask(void *arg)
 	if (port->has_tx_irqs)
 		val |= MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK;
 
-	mvpp2_percpu_write(port->priv,
+	mvpp2_thread_write(port->priv,
 			   mvpp2_cpu_to_thread(port->priv, smp_processor_id()),
 			   MVPP2_ISR_RX_TX_MASK_REG(port->id), val);
 }
@@ -960,7 +960,7 @@ mvpp2_shared_interrupt_mask_unmask(struct mvpp2_port *port, bool mask)
 		if (v->type != MVPP2_QUEUE_VECTOR_SHARED)
 			continue;
 
-		mvpp2_percpu_write(port->priv, v->sw_thread_id,
+		mvpp2_thread_write(port->priv, v->sw_thread_id,
 				   MVPP2_ISR_RX_TX_MASK_REG(port->id), val);
 	}
 }
@@ -1648,7 +1648,7 @@ mvpp2_txq_next_desc_get(struct mvpp2_tx_queue *txq)
 static void mvpp2_aggr_txq_pend_desc_add(struct mvpp2_port *port, int pending)
 {
 	/* aggregated access - relevant TXQ number is written in TX desc */
-	mvpp2_percpu_write(port->priv,
+	mvpp2_thread_write(port->priv,
 			   mvpp2_cpu_to_thread(port->priv, smp_processor_id()),
 			   MVPP2_AGGR_TXQ_UPDATE_REG, pending);
 }
@@ -1691,9 +1691,9 @@ static int mvpp2_txq_alloc_reserved_desc(struct mvpp2_port *port,
 	u32 val;
 
 	val = (txq->id << MVPP2_TXQ_RSVD_REQ_Q_OFFSET) | num;
-	mvpp2_percpu_write_relaxed(priv, thread, MVPP2_TXQ_RSVD_REQ_REG, val);
+	mvpp2_thread_write_relaxed(priv, thread, MVPP2_TXQ_RSVD_REQ_REG, val);
 
-	val = mvpp2_percpu_read_relaxed(priv, thread, MVPP2_TXQ_RSVD_RSLT_REG);
+	val = mvpp2_thread_read_relaxed(priv, thread, MVPP2_TXQ_RSVD_RSLT_REG);
 
 	return val & MVPP2_TXQ_RSVD_RSLT_MASK;
 }
@@ -1799,7 +1799,7 @@ static inline int mvpp2_txq_sent_desc_proc(struct mvpp2_port *port,
 	u32 val;
 
 	/* Reading status reg resets transmitted descriptor counter */
-	val = mvpp2_percpu_read_relaxed(port->priv,
+	val = mvpp2_thread_read_relaxed(port->priv,
 					mvpp2_cpu_to_thread(port->priv, smp_processor_id()),
 					MVPP2_TXQ_SENT_REG(txq->id));
 
@@ -1822,7 +1822,7 @@ static void mvpp2_txq_sent_counter_clear(void *arg)
 	for (queue = 0; queue < port->ntxqs; queue++) {
 		int id = port->txqs[queue]->id;
 
-		mvpp2_percpu_read(port->priv,
+		mvpp2_thread_read(port->priv,
 				  mvpp2_cpu_to_thread(port->priv, smp_processor_id()),
 				  MVPP2_TXQ_SENT_REG(id));
 	}
@@ -1888,8 +1888,8 @@ static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 	if (rxq->pkts_coal > MVPP2_OCCUPIED_THRESH_MASK)
 		rxq->pkts_coal = MVPP2_OCCUPIED_THRESH_MASK;
 
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_THRESH_REG,
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_THRESH_REG,
 			   rxq->pkts_coal);
 
 	put_cpu();
@@ -1906,8 +1906,8 @@ static void mvpp2_tx_pkts_coal_set(struct mvpp2_port *port,
 		txq->done_pkts_coal = MVPP2_TXQ_THRESH_MASK;
 
 	val = (txq->done_pkts_coal << MVPP2_TXQ_THRESH_OFFSET);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_THRESH_REG, val);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_THRESH_REG, val);
 
 	put_cpu();
 }
@@ -2109,14 +2109,14 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
 
 	/* Set Rx descriptors queue starting address - indirect access */
 	thread = mvpp2_cpu_to_thread(port->priv, get_cpu());
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
 	if (port->priv->hw_version == MVPP21)
 		rxq_dma = rxq->descs_dma;
 	else
 		rxq_dma = rxq->descs_dma >> MVPP22_DESC_ADDR_OFFS;
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, rxq_dma);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, rxq->size);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_INDEX_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, rxq_dma);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, rxq->size);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_INDEX_REG, 0);
 	put_cpu();
 
 	/* Set Offset */
@@ -2181,9 +2181,9 @@ static void mvpp2_rxq_deinit(struct mvpp2_port *port,
 	 */
 	mvpp2_write(port->priv, MVPP2_RXQ_STATUS_REG(rxq->id), 0);
 	thread = mvpp2_cpu_to_thread(port->priv, get_cpu());
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, 0);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, 0);
 	put_cpu();
 }
 
@@ -2209,17 +2209,17 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 
 	/* Set Tx descriptors queue starting address - indirect access */
 	thread = mvpp2_cpu_to_thread(port->priv, get_cpu());
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG,
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG,
 			   txq->descs_dma);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG,
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG,
 			   txq->size & MVPP2_TXQ_DESC_SIZE_MASK);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_INDEX_REG, 0);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_RSVD_CLR_REG,
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_INDEX_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_RSVD_CLR_REG,
 			   txq->id << MVPP2_TXQ_RSVD_CLR_OFFSET);
-	val = mvpp2_percpu_read(port->priv, thread, MVPP2_TXQ_PENDING_REG);
+	val = mvpp2_thread_read(port->priv, thread, MVPP2_TXQ_PENDING_REG);
 	val &= ~MVPP2_TXQ_PENDING_MASK;
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PENDING_REG, val);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_PENDING_REG, val);
 
 	/* Calculate base address in prefetch buffer. We reserve 16 descriptors
 	 * for each existing TXQ.
@@ -2230,7 +2230,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 	desc = (port->id * MVPP2_MAX_TXQ * desc_per_txq) +
 	       (txq->log_id * desc_per_txq);
 
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG,
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG,
 			   MVPP2_PREF_BUF_PTR(desc) | MVPP2_PREF_BUF_SIZE_16 |
 			   MVPP2_PREF_BUF_THRESH(desc_per_txq / 2));
 	put_cpu();
@@ -2314,9 +2314,9 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 
 	/* Set Tx descriptors queue starting address and size */
 	thread = mvpp2_cpu_to_thread(port->priv, get_cpu());
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG, 0);
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG, 0);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG, 0);
 	put_cpu();
 }
 
@@ -2328,10 +2328,10 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 	unsigned int thread = mvpp2_cpu_to_thread(port->priv, get_cpu());
 	u32 val;
 
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
-	val = mvpp2_percpu_read(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	val = mvpp2_thread_read(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG);
 	val |= MVPP2_TXQ_DRAIN_EN_MASK;
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
 
 	/* The napi queue has been stopped so wait for all packets
 	 * to be transmitted.
@@ -2347,13 +2347,13 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 		mdelay(1);
 		delay++;
 
-		pending = mvpp2_percpu_read(port->priv, thread,
+		pending = mvpp2_thread_read(port->priv, thread,
 					    MVPP2_TXQ_PENDING_REG);
 		pending &= MVPP2_TXQ_PENDING_MASK;
 	} while (pending);
 
 	val &= ~MVPP2_TXQ_DRAIN_EN_MASK;
-	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
+	mvpp2_thread_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
 	put_cpu();
 
 	for (thread = 0; thread < port->priv->nthreads; thread++) {
@@ -3090,7 +3090,7 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 	 *
 	 * Each CPU has its own Rx/Tx cause register
 	 */
-	cause_rx_tx = mvpp2_percpu_read_relaxed(port->priv, qv->sw_thread_id,
+	cause_rx_tx = mvpp2_thread_read_relaxed(port->priv, qv->sw_thread_id,
 						MVPP2_ISR_RX_TX_CAUSE_REG(port->id));
 
 	cause_misc = cause_rx_tx & MVPP2_CAUSE_MISC_SUM_MASK;
@@ -3099,7 +3099,7 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 
 		/* Clear the cause register */
 		mvpp2_write(port->priv, MVPP2_ISR_MISC_CAUSE_REG, 0);
-		mvpp2_percpu_write(port->priv, thread,
+		mvpp2_thread_write(port->priv, thread,
 				   MVPP2_ISR_RX_TX_CAUSE_REG(port->id),
 				   cause_rx_tx & ~MVPP2_CAUSE_MISC_SUM_MASK);
 	}
-- 
2.17.1

