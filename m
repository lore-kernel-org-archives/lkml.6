Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E432ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98D4214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98D4214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbeISPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43254 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbeISPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B168E208B0; Wed, 19 Sep 2018 11:30:14 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 754C2208F4;
        Wed, 19 Sep 2018 11:30:04 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 09/12] net: mvpp2: do not use the CPU number to access the per-thread registers
Date:   Wed, 19 Sep 2018 11:27:08 +0200
Message-Id: <20180919092711.22296-10-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the Marvell PPv2 driver to stop using directly the
CPU number to access per-thread registers.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 169 +++++++++---------
 1 file changed, 88 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 011bf9c5d105..0c51bd4f9354 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -87,9 +87,15 @@ static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
 {
 	return readl_relaxed(priv->swth_base[0] + offset);
 }
+
+static inline u32 mvpp2_cpu_to_thread(int cpu)
+{
+	return cpu;
+}
+
 /* These accessors should be used to access:
  *
- * - per-CPU registers, where each CPU has its own copy of the
+ * - per-thread registers, where each thread has its own copy of the
  *   register.
  *
  *   MVPP2_BM_VIRT_ALLOC_REG
@@ -105,8 +111,8 @@ static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
  *   MVPP2_TXQ_SENT_REG
  *   MVPP2_RXQ_NUM_REG
  *
- * - global registers that must be accessed through a specific CPU
- *   window, because they are related to an access to a per-CPU
+ * - global registers that must be accessed through a specific thread
+ *   window, because they are related to an access to a per-thread
  *   register
  *
  *   MVPP2_BM_PHY_ALLOC_REG    (related to MVPP2_BM_VIRT_ALLOC_REG)
@@ -123,28 +129,28 @@ static u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  */
-static void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu,
+static void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int thread,
 			       u32 offset, u32 data)
 {
-	writel(data, priv->swth_base[cpu] + offset);
+	writel(data, priv->swth_base[thread] + offset);
 }
 
-static u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu,
+static u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int thread,
 			     u32 offset)
 {
-	return readl(priv->swth_base[cpu] + offset);
+	return readl(priv->swth_base[thread] + offset);
 }
 
-static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
+static void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int thread,
 				       u32 offset, u32 data)
 {
-	writel_relaxed(data, priv->swth_base[cpu] + offset);
+	writel_relaxed(data, priv->swth_base[thread] + offset);
 }
 
-static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, unsigned int cpu,
+static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, unsigned int thread,
 				     u32 offset)
 {
-	return readl_relaxed(priv->swth_base[cpu] + offset);
+	return readl_relaxed(priv->swth_base[thread] + offset);
 }
 
 static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
@@ -386,17 +392,17 @@ static void mvpp2_bm_bufs_get_addrs(struct device *dev, struct mvpp2 *priv,
 				    dma_addr_t *dma_addr,
 				    phys_addr_t *phys_addr)
 {
-	unsigned int cpu = get_cpu();
+	unsigned int thread = mvpp2_cpu_to_thread(get_cpu());
 
-	*dma_addr = mvpp2_percpu_read(priv, cpu,
+	*dma_addr = mvpp2_percpu_read(priv, thread,
 				      MVPP2_BM_PHY_ALLOC_REG(bm_pool->id));
-	*phys_addr = mvpp2_percpu_read(priv, cpu, MVPP2_BM_VIRT_ALLOC_REG);
+	*phys_addr = mvpp2_percpu_read(priv, thread, MVPP2_BM_VIRT_ALLOC_REG);
 
 	if (priv->hw_version == MVPP22) {
 		u32 val;
 		u32 dma_addr_highbits, phys_addr_highbits;
 
-		val = mvpp2_percpu_read(priv, cpu, MVPP22_BM_ADDR_HIGH_ALLOC);
+		val = mvpp2_percpu_read(priv, thread, MVPP22_BM_ADDR_HIGH_ALLOC);
 		dma_addr_highbits = (val & MVPP22_BM_ADDR_HIGH_PHYS_MASK);
 		phys_addr_highbits = (val & MVPP22_BM_ADDR_HIGH_VIRT_MASK) >>
 			MVPP22_BM_ADDR_HIGH_VIRT_SHIFT;
@@ -627,7 +633,7 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 				     dma_addr_t buf_dma_addr,
 				     phys_addr_t buf_phys_addr)
 {
-	unsigned int cpu = get_cpu();
+	unsigned int thread = mvpp2_cpu_to_thread(get_cpu());
 
 	if (port->priv->hw_version == MVPP22) {
 		u32 val = 0;
@@ -641,7 +647,7 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 				<< MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT) &
 				MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK;
 
-		mvpp2_percpu_write_relaxed(port->priv, cpu,
+		mvpp2_percpu_write_relaxed(port->priv, thread,
 					   MVPP22_BM_ADDR_HIGH_RLS_REG, val);
 	}
 
@@ -650,9 +656,9 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 	 * descriptor. Instead of storing the virtual address, we
 	 * store the physical address
 	 */
-	mvpp2_percpu_write_relaxed(port->priv, cpu,
+	mvpp2_percpu_write_relaxed(port->priv, thread,
 				   MVPP2_BM_VIRT_RLS_REG, buf_phys_addr);
-	mvpp2_percpu_write_relaxed(port->priv, cpu,
+	mvpp2_percpu_write_relaxed(port->priv, thread,
 				   MVPP2_BM_PHY_RLS_REG(pool), buf_dma_addr);
 
 	put_cpu();
@@ -887,7 +893,7 @@ static inline void mvpp2_qvec_interrupt_disable(struct mvpp2_queue_vector *qvec)
 		    MVPP2_ISR_DISABLE_INTERRUPT(qvec->sw_thread_mask));
 }
 
-/* Mask the current CPU's Rx/Tx interrupts
+/* Mask the current thread's Rx/Tx interrupts
  * Called by on_each_cpu(), guaranteed to run with migration disabled,
  * using smp_processor_id() is OK.
  */
@@ -895,11 +901,11 @@ static void mvpp2_interrupts_mask(void *arg)
 {
 	struct mvpp2_port *port = arg;
 
-	mvpp2_percpu_write(port->priv, smp_processor_id(),
+	mvpp2_percpu_write(port->priv, mvpp2_cpu_to_thread(smp_processor_id()),
 			   MVPP2_ISR_RX_TX_MASK_REG(port->id), 0);
 }
 
-/* Unmask the current CPU's Rx/Tx interrupts.
+/* Unmask the current thread's Rx/Tx interrupts.
  * Called by on_each_cpu(), guaranteed to run with migration disabled,
  * using smp_processor_id() is OK.
  */
@@ -913,7 +919,7 @@ static void mvpp2_interrupts_unmask(void *arg)
 	if (port->has_tx_irqs)
 		val |= MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK;
 
-	mvpp2_percpu_write(port->priv, smp_processor_id(),
+	mvpp2_percpu_write(port->priv, mvpp2_cpu_to_thread(smp_processor_id()),
 			   MVPP2_ISR_RX_TX_MASK_REG(port->id), val);
 }
 
@@ -1625,7 +1631,7 @@ mvpp2_txq_next_desc_get(struct mvpp2_tx_queue *txq)
 static void mvpp2_aggr_txq_pend_desc_add(struct mvpp2_port *port, int pending)
 {
 	/* aggregated access - relevant TXQ number is written in TX desc */
-	mvpp2_percpu_write(port->priv, smp_processor_id(),
+	mvpp2_percpu_write(port->priv, mvpp2_cpu_to_thread(smp_processor_id()),
 			   MVPP2_AGGR_TXQ_UPDATE_REG, pending);
 }
 
@@ -1640,9 +1646,9 @@ static int mvpp2_aggr_desc_num_check(struct mvpp2 *priv,
 {
 	if ((aggr_txq->count + num) > MVPP2_AGGR_TXQ_SIZE) {
 		/* Update number of occupied aggregated Tx descriptors */
-		unsigned int cpu = smp_processor_id();
+		unsigned int thread = mvpp2_cpu_to_thread(smp_processor_id());
 		u32 val = mvpp2_read_relaxed(priv,
-					     MVPP2_AGGR_TXQ_STATUS_REG(cpu));
+					     MVPP2_AGGR_TXQ_STATUS_REG(thread));
 
 		aggr_txq->count = val & MVPP2_AGGR_TXQ_PENDING_MASK;
 
@@ -1662,12 +1668,12 @@ static int mvpp2_txq_alloc_reserved_desc(struct mvpp2 *priv,
 					 struct mvpp2_tx_queue *txq, int num)
 {
 	u32 val;
-	unsigned int cpu = smp_processor_id();
+	unsigned int thread = mvpp2_cpu_to_thread(smp_processor_id());
 
 	val = (txq->id << MVPP2_TXQ_RSVD_REQ_Q_OFFSET) | num;
-	mvpp2_percpu_write_relaxed(priv, cpu, MVPP2_TXQ_RSVD_REQ_REG, val);
+	mvpp2_percpu_write_relaxed(priv, thread, MVPP2_TXQ_RSVD_REQ_REG, val);
 
-	val = mvpp2_percpu_read_relaxed(priv, cpu, MVPP2_TXQ_RSVD_RSLT_REG);
+	val = mvpp2_percpu_read_relaxed(priv, thread, MVPP2_TXQ_RSVD_RSLT_REG);
 
 	return val & MVPP2_TXQ_RSVD_RSLT_MASK;
 }
@@ -1761,7 +1767,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_proto,
 
 /* Get number of sent descriptors and decrement counter.
  * The number of sent descriptors is returned.
- * Per-CPU access
+ * Per-thread access
  *
  * Called only from mvpp2_txq_done(), called from mvpp2_tx()
  * (migration disabled) and from the TX completion tasklet (migration
@@ -1773,7 +1779,8 @@ static inline int mvpp2_txq_sent_desc_proc(struct mvpp2_port *port,
 	u32 val;
 
 	/* Reading status reg resets transmitted descriptor counter */
-	val = mvpp2_percpu_read_relaxed(port->priv, smp_processor_id(),
+	val = mvpp2_percpu_read_relaxed(port->priv,
+					mvpp2_cpu_to_thread(smp_processor_id()),
 					MVPP2_TXQ_SENT_REG(txq->id));
 
 	return (val & MVPP2_TRANSMITTED_COUNT_MASK) >>
@@ -1791,7 +1798,8 @@ static void mvpp2_txq_sent_counter_clear(void *arg)
 	for (queue = 0; queue < port->ntxqs; queue++) {
 		int id = port->txqs[queue]->id;
 
-		mvpp2_percpu_read(port->priv, smp_processor_id(),
+		mvpp2_percpu_read(port->priv,
+				  mvpp2_cpu_to_thread(smp_processor_id()),
 				  MVPP2_TXQ_SENT_REG(id));
 	}
 }
@@ -1851,13 +1859,13 @@ static void mvpp2_txp_max_tx_size_set(struct mvpp2_port *port)
 static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_rx_queue *rxq)
 {
-	unsigned int cpu = get_cpu();
+	unsigned int thread = mvpp2_cpu_to_thread(get_cpu());
 
 	if (rxq->pkts_coal > MVPP2_OCCUPIED_THRESH_MASK)
 		rxq->pkts_coal = MVPP2_OCCUPIED_THRESH_MASK;
 
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_NUM_REG, rxq->id);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_THRESH_REG,
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_THRESH_REG,
 			   rxq->pkts_coal);
 
 	put_cpu();
@@ -1867,15 +1875,15 @@ static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 static void mvpp2_tx_pkts_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_tx_queue *txq)
 {
-	unsigned int cpu = get_cpu();
+	unsigned int thread = mvpp2_cpu_to_thread(get_cpu());
 	u32 val;
 
 	if (txq->done_pkts_coal > MVPP2_TXQ_THRESH_MASK)
 		txq->done_pkts_coal = MVPP2_TXQ_THRESH_MASK;
 
 	val = (txq->done_pkts_coal << MVPP2_TXQ_THRESH_OFFSET);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_THRESH_REG, val);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_THRESH_REG, val);
 
 	put_cpu();
 }
@@ -1992,7 +2000,7 @@ static void mvpp2_txq_done(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
 }
 
 static unsigned int mvpp2_tx_done(struct mvpp2_port *port, u32 cause,
-				  unsigned int cpu)
+				  unsigned int thread)
 {
 	struct mvpp2_tx_queue *txq;
 	struct mvpp2_txq_pcpu *txq_pcpu;
@@ -2003,7 +2011,7 @@ static unsigned int mvpp2_tx_done(struct mvpp2_port *port, u32 cause,
 		if (!txq)
 			break;
 
-		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
+		txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 
 		if (txq_pcpu->count) {
 			mvpp2_txq_done(port, txq, txq_pcpu);
@@ -2020,7 +2028,7 @@ static unsigned int mvpp2_tx_done(struct mvpp2_port *port, u32 cause,
 /* Allocate and initialize descriptors for aggr TXQ */
 static int mvpp2_aggr_txq_init(struct platform_device *pdev,
 			       struct mvpp2_tx_queue *aggr_txq,
-			       unsigned int cpu, struct mvpp2 *priv)
+			       unsigned int thread, struct mvpp2 *priv)
 {
 	u32 txq_dma;
 
@@ -2035,7 +2043,7 @@ static int mvpp2_aggr_txq_init(struct platform_device *pdev,
 
 	/* Aggr TXQ no reset WA */
 	aggr_txq->next_desc_to_proc = mvpp2_read(priv,
-						 MVPP2_AGGR_TXQ_INDEX_REG(cpu));
+						 MVPP2_AGGR_TXQ_INDEX_REG(thread));
 
 	/* Set Tx descriptors queue starting address indirect
 	 * access
@@ -2046,8 +2054,8 @@ static int mvpp2_aggr_txq_init(struct platform_device *pdev,
 		txq_dma = aggr_txq->descs_dma >>
 			MVPP22_AGGR_TXQ_DESC_ADDR_OFFS;
 
-	mvpp2_write(priv, MVPP2_AGGR_TXQ_DESC_ADDR_REG(cpu), txq_dma);
-	mvpp2_write(priv, MVPP2_AGGR_TXQ_DESC_SIZE_REG(cpu),
+	mvpp2_write(priv, MVPP2_AGGR_TXQ_DESC_ADDR_REG(thread), txq_dma);
+	mvpp2_write(priv, MVPP2_AGGR_TXQ_DESC_SIZE_REG(thread),
 		    MVPP2_AGGR_TXQ_SIZE);
 
 	return 0;
@@ -2058,7 +2066,7 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
 			  struct mvpp2_rx_queue *rxq)
 
 {
-	unsigned int cpu;
+	unsigned int thread;
 	u32 rxq_dma;
 
 	rxq->size = port->rx_ring_size;
@@ -2076,15 +2084,15 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
 	mvpp2_write(port->priv, MVPP2_RXQ_STATUS_REG(rxq->id), 0);
 
 	/* Set Rx descriptors queue starting address - indirect access */
-	cpu = get_cpu();
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_NUM_REG, rxq->id);
+	thread = mvpp2_cpu_to_thread(get_cpu());
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
 	if (port->priv->hw_version == MVPP21)
 		rxq_dma = rxq->descs_dma;
 	else
 		rxq_dma = rxq->descs_dma >> MVPP22_DESC_ADDR_OFFS;
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_DESC_ADDR_REG, rxq_dma);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_DESC_SIZE_REG, rxq->size);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_INDEX_REG, 0);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, rxq_dma);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, rxq->size);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_INDEX_REG, 0);
 	put_cpu();
 
 	/* Set Offset */
@@ -2129,7 +2137,7 @@ static void mvpp2_rxq_drop_pkts(struct mvpp2_port *port,
 static void mvpp2_rxq_deinit(struct mvpp2_port *port,
 			     struct mvpp2_rx_queue *rxq)
 {
-	unsigned int cpu;
+	unsigned int thread;
 
 	mvpp2_rxq_drop_pkts(port, rxq);
 
@@ -2148,10 +2156,10 @@ static void mvpp2_rxq_deinit(struct mvpp2_port *port,
 	 * free descriptor number
 	 */
 	mvpp2_write(port->priv, MVPP2_RXQ_STATUS_REG(rxq->id), 0);
-	cpu = get_cpu();
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_NUM_REG, rxq->id);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_DESC_ADDR_REG, 0);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_RXQ_DESC_SIZE_REG, 0);
+	thread = mvpp2_cpu_to_thread(get_cpu());
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_NUM_REG, rxq->id);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_ADDR_REG, 0);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_RXQ_DESC_SIZE_REG, 0);
 	put_cpu();
 }
 
@@ -2160,7 +2168,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 			  struct mvpp2_tx_queue *txq)
 {
 	u32 val;
-	unsigned int cpu;
+	unsigned int cpu, thread;
 	int desc, desc_per_txq, tx_port_num;
 	struct mvpp2_txq_pcpu *txq_pcpu;
 
@@ -2176,18 +2184,18 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 	txq->last_desc = txq->size - 1;
 
 	/* Set Tx descriptors queue starting address - indirect access */
-	cpu = get_cpu();
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_DESC_ADDR_REG,
+	thread = mvpp2_cpu_to_thread(get_cpu());
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG,
 			   txq->descs_dma);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_DESC_SIZE_REG,
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG,
 			   txq->size & MVPP2_TXQ_DESC_SIZE_MASK);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_INDEX_REG, 0);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_RSVD_CLR_REG,
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_INDEX_REG, 0);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_RSVD_CLR_REG,
 			   txq->id << MVPP2_TXQ_RSVD_CLR_OFFSET);
-	val = mvpp2_percpu_read(port->priv, cpu, MVPP2_TXQ_PENDING_REG);
+	val = mvpp2_percpu_read(port->priv, thread, MVPP2_TXQ_PENDING_REG);
 	val &= ~MVPP2_TXQ_PENDING_MASK;
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_PENDING_REG, val);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PENDING_REG, val);
 
 	/* Calculate base address in prefetch buffer. We reserve 16 descriptors
 	 * for each existing TXQ.
@@ -2198,7 +2206,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 	desc = (port->id * MVPP2_MAX_TXQ * desc_per_txq) +
 	       (txq->log_id * desc_per_txq);
 
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_PREF_BUF_REG,
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG,
 			   MVPP2_PREF_BUF_PTR(desc) | MVPP2_PREF_BUF_SIZE_16 |
 			   MVPP2_PREF_BUF_THRESH(desc_per_txq / 2));
 	put_cpu();
@@ -2252,7 +2260,7 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 			     struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	unsigned int cpu;
+	unsigned int cpu, thread;
 
 	for_each_present_cpu(cpu) {
 		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
@@ -2281,10 +2289,10 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(txq->id), 0);
 
 	/* Set Tx descriptors queue starting address and size */
-	cpu = get_cpu();
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_NUM_REG, txq->id);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_DESC_ADDR_REG, 0);
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_DESC_SIZE_REG, 0);
+	thread = mvpp2_cpu_to_thread(get_cpu());
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_ADDR_REG, 0);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_DESC_SIZE_REG, 0);
 	put_cpu();
 }
 
@@ -2293,14 +2301,13 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
 	int delay, pending;
-	unsigned int cpu;
+	unsigned int cpu, thread = mvpp2_cpu_to_thread(get_cpu());
 	u32 val;
 
-	cpu = get_cpu();
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_NUM_REG, txq->id);
-	val = mvpp2_percpu_read(port->priv, cpu, MVPP2_TXQ_PREF_BUF_REG);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
+	val = mvpp2_percpu_read(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG);
 	val |= MVPP2_TXQ_DRAIN_EN_MASK;
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_PREF_BUF_REG, val);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
 
 	/* The napi queue has been stopped so wait for all packets
 	 * to be transmitted.
@@ -2316,13 +2323,13 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 		mdelay(1);
 		delay++;
 
-		pending = mvpp2_percpu_read(port->priv, cpu,
+		pending = mvpp2_percpu_read(port->priv, thread,
 					    MVPP2_TXQ_PENDING_REG);
 		pending &= MVPP2_TXQ_PENDING_MASK;
 	} while (pending);
 
 	val &= ~MVPP2_TXQ_DRAIN_EN_MASK;
-	mvpp2_percpu_write(port->priv, cpu, MVPP2_TXQ_PREF_BUF_REG, val);
+	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
 	put_cpu();
 
 	for_each_present_cpu(cpu) {
@@ -3031,7 +3038,7 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 	int rx_done = 0;
 	struct mvpp2_port *port = netdev_priv(napi->dev);
 	struct mvpp2_queue_vector *qv;
-	unsigned int cpu = smp_processor_id();
+	unsigned int thread = mvpp2_cpu_to_thread(smp_processor_id());
 
 	qv = container_of(napi, struct mvpp2_queue_vector, napi);
 
@@ -3054,7 +3061,7 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 
 		/* Clear the cause register */
 		mvpp2_write(port->priv, MVPP2_ISR_MISC_CAUSE_REG, 0);
-		mvpp2_percpu_write(port->priv, cpu,
+		mvpp2_percpu_write(port->priv, thread,
 				   MVPP2_ISR_RX_TX_CAUSE_REG(port->id),
 				   cause_rx_tx & ~MVPP2_CAUSE_MISC_SUM_MASK);
 	}
@@ -3144,7 +3151,7 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
 	for (i = 0; i < port->nqvecs; i++)
 		napi_enable(&port->qvecs[i].napi);
 
-	/* Enable interrupts on all CPUs */
+	/* Enable interrupts on all threads */
 	mvpp2_interrupts_enable(port);
 
 	if (port->priv->hw_version == MVPP22)
@@ -3174,7 +3181,7 @@ static void mvpp2_stop_dev(struct mvpp2_port *port)
 {
 	int i;
 
-	/* Disable interrupts on all CPUs */
+	/* Disable interrupts on all threads */
 	mvpp2_interrupts_disable(port);
 
 	for (i = 0; i < port->nqvecs; i++)
-- 
2.17.1

