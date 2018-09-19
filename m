Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F677ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DBE20645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DBE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeISPIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:08:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbeISPHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6896D208B0; Wed, 19 Sep 2018 11:30:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2B120208C7;
        Wed, 19 Sep 2018 11:30:02 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 06/12] net: mvpp2: cpu should always be unsigned
Date:   Wed, 19 Sep 2018 11:27:05 +0200
Message-Id: <20180919092711.22296-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the PPv2 driver so that all CPU variables are unsigned, as it
makes no sense to have a negative CPU number. This patch is cosmetic.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    | 11 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 54 ++++++++++---------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 014e3343b660..57fea9193a49 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -971,7 +971,7 @@ struct mvpp2_txq_pcpu_buf {
 
 /* Per-CPU Tx queue control */
 struct mvpp2_txq_pcpu {
-	int cpu;
+	unsigned int cpu;
 
 	/* Number of Tx DMA descriptors in the descriptor ring */
 	int size;
@@ -1099,11 +1099,12 @@ u32 mvpp2_read(struct mvpp2 *priv, u32 offset);
 
 u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset);
 
-void mvpp2_percpu_write(struct mvpp2 *priv, int cpu, u32 offset, u32 data);
-u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu, u32 offset);
+void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu, u32 offset,
+			u32 data);
+u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu, u32 offset);
 
-void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu, u32 offset,
-				u32 data);
+void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
+				u32 offset, u32 data);
 
 void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 86f4b1323077..8d4e5d0c0ad8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -123,25 +123,25 @@ u32 mvpp2_read_relaxed(struct mvpp2 *priv, u32 offset)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  *   MVPP2_TXQ_PREF_BUF_REG    (related to MVPP2_TXQ_NUM_REG)
  */
-void mvpp2_percpu_write(struct mvpp2 *priv, int cpu,
+void mvpp2_percpu_write(struct mvpp2 *priv, unsigned int cpu,
 			       u32 offset, u32 data)
 {
 	writel(data, priv->swth_base[cpu] + offset);
 }
 
-u32 mvpp2_percpu_read(struct mvpp2 *priv, int cpu,
+u32 mvpp2_percpu_read(struct mvpp2 *priv, unsigned int cpu,
 			     u32 offset)
 {
 	return readl(priv->swth_base[cpu] + offset);
 }
 
-void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu,
+void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, unsigned int cpu,
 				       u32 offset, u32 data)
 {
 	writel_relaxed(data, priv->swth_base[cpu] + offset);
 }
 
-static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
+static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, unsigned int cpu,
 				     u32 offset)
 {
 	return readl_relaxed(priv->swth_base[cpu] + offset);
@@ -386,7 +386,7 @@ static void mvpp2_bm_bufs_get_addrs(struct device *dev, struct mvpp2 *priv,
 				    dma_addr_t *dma_addr,
 				    phys_addr_t *phys_addr)
 {
-	int cpu = get_cpu();
+	unsigned int cpu = get_cpu();
 
 	*dma_addr = mvpp2_percpu_read(priv, cpu,
 				      MVPP2_BM_PHY_ALLOC_REG(bm_pool->id));
@@ -627,7 +627,7 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
 				     dma_addr_t buf_dma_addr,
 				     phys_addr_t buf_phys_addr)
 {
-	int cpu = get_cpu();
+	unsigned int cpu = get_cpu();
 
 	if (port->priv->hw_version == MVPP22) {
 		u32 val = 0;
@@ -1640,7 +1640,7 @@ static int mvpp2_aggr_desc_num_check(struct mvpp2 *priv,
 {
 	if ((aggr_txq->count + num) > MVPP2_AGGR_TXQ_SIZE) {
 		/* Update number of occupied aggregated Tx descriptors */
-		int cpu = smp_processor_id();
+		unsigned int cpu = smp_processor_id();
 		u32 val = mvpp2_read_relaxed(priv,
 					     MVPP2_AGGR_TXQ_STATUS_REG(cpu));
 
@@ -1662,7 +1662,7 @@ static int mvpp2_txq_alloc_reserved_desc(struct mvpp2 *priv,
 					 struct mvpp2_tx_queue *txq, int num)
 {
 	u32 val;
-	int cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
 
 	val = (txq->id << MVPP2_TXQ_RSVD_REQ_Q_OFFSET) | num;
 	mvpp2_percpu_write_relaxed(priv, cpu, MVPP2_TXQ_RSVD_REQ_REG, val);
@@ -1680,7 +1680,8 @@ static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2 *priv,
 					    struct mvpp2_txq_pcpu *txq_pcpu,
 					    int num)
 {
-	int req, cpu, desc_count;
+	int req, desc_count;
+	unsigned int cpu;
 
 	if (txq_pcpu->reserved_num >= num)
 		return 0;
@@ -1850,7 +1851,7 @@ static void mvpp2_txp_max_tx_size_set(struct mvpp2_port *port)
 static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_rx_queue *rxq)
 {
-	int cpu = get_cpu();
+	unsigned int cpu = get_cpu();
 
 	if (rxq->pkts_coal > MVPP2_OCCUPIED_THRESH_MASK)
 		rxq->pkts_coal = MVPP2_OCCUPIED_THRESH_MASK;
@@ -1866,7 +1867,7 @@ static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 static void mvpp2_tx_pkts_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_tx_queue *txq)
 {
-	int cpu = get_cpu();
+	unsigned int cpu = get_cpu();
 	u32 val;
 
 	if (txq->done_pkts_coal > MVPP2_TXQ_THRESH_MASK)
@@ -1991,7 +1992,7 @@ static void mvpp2_txq_done(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
 }
 
 static unsigned int mvpp2_tx_done(struct mvpp2_port *port, u32 cause,
-				  int cpu)
+				  unsigned int cpu)
 {
 	struct mvpp2_tx_queue *txq;
 	struct mvpp2_txq_pcpu *txq_pcpu;
@@ -2018,8 +2019,8 @@ static unsigned int mvpp2_tx_done(struct mvpp2_port *port, u32 cause,
 
 /* Allocate and initialize descriptors for aggr TXQ */
 static int mvpp2_aggr_txq_init(struct platform_device *pdev,
-			       struct mvpp2_tx_queue *aggr_txq, int cpu,
-			       struct mvpp2 *priv)
+			       struct mvpp2_tx_queue *aggr_txq,
+			       unsigned int cpu, struct mvpp2 *priv)
 {
 	u32 txq_dma;
 
@@ -2057,8 +2058,8 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
 			  struct mvpp2_rx_queue *rxq)
 
 {
+	unsigned int cpu;
 	u32 rxq_dma;
-	int cpu;
 
 	rxq->size = port->rx_ring_size;
 
@@ -2128,7 +2129,7 @@ static void mvpp2_rxq_drop_pkts(struct mvpp2_port *port,
 static void mvpp2_rxq_deinit(struct mvpp2_port *port,
 			     struct mvpp2_rx_queue *rxq)
 {
-	int cpu;
+	unsigned int cpu;
 
 	mvpp2_rxq_drop_pkts(port, rxq);
 
@@ -2159,7 +2160,8 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 			  struct mvpp2_tx_queue *txq)
 {
 	u32 val;
-	int cpu, desc, desc_per_txq, tx_port_num;
+	unsigned int cpu;
+	int desc, desc_per_txq, tx_port_num;
 	struct mvpp2_txq_pcpu *txq_pcpu;
 
 	txq->size = port->tx_ring_size;
@@ -2250,7 +2252,7 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 			     struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	int cpu;
+	unsigned int cpu;
 
 	for_each_present_cpu(cpu) {
 		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
@@ -2290,7 +2292,8 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	int delay, pending, cpu;
+	int delay, pending;
+	unsigned int cpu;
 	u32 val;
 
 	cpu = get_cpu();
@@ -3028,7 +3031,7 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 	int rx_done = 0;
 	struct mvpp2_port *port = netdev_priv(napi->dev);
 	struct mvpp2_queue_vector *qv;
-	int cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
 
 	qv = container_of(napi, struct mvpp2_queue_vector, napi);
 
@@ -3397,7 +3400,7 @@ static int mvpp2_stop(struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_port_pcpu *port_pcpu;
-	int cpu;
+	unsigned int cpu;
 
 	mvpp2_stop_dev(port);
 
@@ -3558,7 +3561,7 @@ mvpp2_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	unsigned int start;
-	int cpu;
+	unsigned int cpu;
 
 	for_each_possible_cpu(cpu) {
 		struct mvpp2_pcpu_stats *cpu_stats;
@@ -4094,7 +4097,8 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	struct device *dev = port->dev->dev.parent;
 	struct mvpp2 *priv = port->priv;
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	int queue, cpu, err;
+	unsigned int cpu;
+	int queue, err;
 
 	/* Checks for hardware constraints */
 	if (port->first_rxq + port->nrxqs >
@@ -4634,13 +4638,13 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	struct resource *res;
 	struct phylink *phylink;
 	char *mac_from = "";
-	unsigned int ntxqs, nrxqs;
+	unsigned int ntxqs, nrxqs, cpu;
 	unsigned long flags = 0;
 	bool has_tx_irqs;
 	u32 id;
 	int features;
 	int phy_mode;
-	int err, i, cpu;
+	int err, i;
 
 	has_tx_irqs = mvpp2_port_has_irqs(priv, port_node, &flags);
 	if (!has_tx_irqs && queue_mode == MVPP2_QDIST_MULTI_MODE) {
-- 
2.17.1

