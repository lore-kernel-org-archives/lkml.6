Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04AAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FD2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FD2214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeISPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43248 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731144AbeISPHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ADD2F208E7; Wed, 19 Sep 2018 11:30:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 72E59208F0;
        Wed, 19 Sep 2018 11:30:03 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 10/12] net: mvpp2: map the CPUs to threads
Date:   Wed, 19 Sep 2018 11:27:09 +0200
Message-Id: <20180919092711.22296-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch maps all uses of the CPU to threads. All this_cpu calls are
replaced, and all smp_processor_id() calls are wrapped into the
indirection.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  5 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 90 +++++++++++--------
 2 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 87ac86a87bd5..0280856ff6ec 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -814,6 +814,9 @@ struct mvpp2_port {
 	void __iomem *base;
 	void __iomem *stats_base;
 
+	/* Number of threads used on the port */
+	unsigned int nthreads;
+
 	struct mvpp2_rx_queue **rxqs;
 	unsigned int nrxqs;
 	struct mvpp2_tx_queue **txqs;
@@ -971,7 +974,7 @@ struct mvpp2_txq_pcpu_buf {
 
 /* Per-CPU Tx queue control */
 struct mvpp2_txq_pcpu {
-	unsigned int cpu;
+	unsigned int thread;
 
 	/* Number of Tx DMA descriptors in the descriptor ring */
 	int size;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0c51bd4f9354..b46ffbca35af 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1681,13 +1681,14 @@ static int mvpp2_txq_alloc_reserved_desc(struct mvpp2 *priv,
 /* Check if there are enough reserved descriptors for transmission.
  * If not, request chunk of reserved descriptors and check again.
  */
-static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2 *priv,
+static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2_port *port,
 					    struct mvpp2_tx_queue *txq,
 					    struct mvpp2_txq_pcpu *txq_pcpu,
 					    int num)
 {
+	struct mvpp2 *priv = port->priv;
 	int req, desc_count;
-	unsigned int cpu;
+	unsigned int thread;
 
 	if (txq_pcpu->reserved_num >= num)
 		return 0;
@@ -1698,10 +1699,10 @@ static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2 *priv,
 
 	desc_count = 0;
 	/* Compute total of used descriptors */
-	for_each_present_cpu(cpu) {
+	for (thread = 0; thread < port->nthreads; thread++) {
 		struct mvpp2_txq_pcpu *txq_pcpu_aux;
 
-		txq_pcpu_aux = per_cpu_ptr(txq->pcpu, cpu);
+		txq_pcpu_aux = per_cpu_ptr(txq->pcpu, thread);
 		desc_count += txq_pcpu_aux->count;
 		desc_count += txq_pcpu_aux->reserved_num;
 	}
@@ -1710,7 +1711,7 @@ static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2 *priv,
 	desc_count += req;
 
 	if (desc_count >
-	   (txq->size - (num_present_cpus() * MVPP2_CPU_DESC_CHUNK)))
+	   (txq->size - (MVPP2_MAX_THREADS * MVPP2_CPU_DESC_CHUNK)))
 		return -ENOMEM;
 
 	txq_pcpu->reserved_num += mvpp2_txq_alloc_reserved_desc(priv, txq, req);
@@ -1984,7 +1985,7 @@ static void mvpp2_txq_done(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
 	struct netdev_queue *nq = netdev_get_tx_queue(port->dev, txq->log_id);
 	int tx_done;
 
-	if (txq_pcpu->cpu != smp_processor_id())
+	if (txq_pcpu->thread != mvpp2_cpu_to_thread(smp_processor_id()))
 		netdev_err(port->dev, "wrong cpu on the end of Tx processing\n");
 
 	tx_done = mvpp2_txq_sent_desc_proc(port, txq);
@@ -2168,7 +2169,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 			  struct mvpp2_tx_queue *txq)
 {
 	u32 val;
-	unsigned int cpu, thread;
+	unsigned int thread;
 	int desc, desc_per_txq, tx_port_num;
 	struct mvpp2_txq_pcpu *txq_pcpu;
 
@@ -2225,8 +2226,8 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_SIZE_REG(txq->log_id),
 		    val);
 
-	for_each_present_cpu(cpu) {
-		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
+	for (thread = 0; thread < port->nthreads; thread++) {
+		txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 		txq_pcpu->size = txq->size;
 		txq_pcpu->buffs = kmalloc_array(txq_pcpu->size,
 						sizeof(*txq_pcpu->buffs),
@@ -2260,10 +2261,10 @@ static void mvpp2_txq_deinit(struct mvpp2_port *port,
 			     struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	unsigned int cpu, thread;
+	unsigned int thread;
 
-	for_each_present_cpu(cpu) {
-		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
+	for (thread = 0; thread < port->nthreads; thread++) {
+		txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 		kfree(txq_pcpu->buffs);
 
 		if (txq_pcpu->tso_headers)
@@ -2301,7 +2302,7 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 {
 	struct mvpp2_txq_pcpu *txq_pcpu;
 	int delay, pending;
-	unsigned int cpu, thread = mvpp2_cpu_to_thread(get_cpu());
+	unsigned int thread = mvpp2_cpu_to_thread(get_cpu());
 	u32 val;
 
 	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_NUM_REG, txq->id);
@@ -2332,8 +2333,8 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 	mvpp2_percpu_write(port->priv, thread, MVPP2_TXQ_PREF_BUF_REG, val);
 	put_cpu();
 
-	for_each_present_cpu(cpu) {
-		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
+	for (thread = 0; thread < port->nthreads; thread++) {
+		txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 
 		/* Release all packets */
 		mvpp2_txq_bufs_free(port, txq, txq_pcpu, txq_pcpu->count);
@@ -2514,16 +2515,20 @@ static void mvpp2_tx_proc_cb(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct mvpp2_port *port = netdev_priv(dev);
-	struct mvpp2_port_pcpu *port_pcpu = this_cpu_ptr(port->pcpu);
+	struct mvpp2_port_pcpu *port_pcpu;
 	unsigned int tx_todo, cause;
 
+	port_pcpu = per_cpu_ptr(port->pcpu,
+				mvpp2_cpu_to_thread(smp_processor_id()));
+
 	if (!netif_running(dev))
 		return;
 	port_pcpu->timer_scheduled = false;
 
 	/* Process all the Tx queues */
 	cause = (1 << port->ntxqs) - 1;
-	tx_todo = mvpp2_tx_done(port, cause, smp_processor_id());
+	tx_todo = mvpp2_tx_done(port, cause,
+				mvpp2_cpu_to_thread(smp_processor_id()));
 
 	/* Set the timer in case not all the packets were processed */
 	if (tx_todo)
@@ -2739,7 +2744,8 @@ static inline void
 tx_desc_unmap_put(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
 		  struct mvpp2_tx_desc *desc)
 {
-	struct mvpp2_txq_pcpu *txq_pcpu = this_cpu_ptr(txq->pcpu);
+	unsigned int thread = mvpp2_cpu_to_thread(smp_processor_id());
+	struct mvpp2_txq_pcpu *txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 
 	dma_addr_t buf_dma_addr =
 		mvpp2_txdesc_dma_addr_get(port, desc);
@@ -2756,7 +2762,8 @@ static int mvpp2_tx_frag_process(struct mvpp2_port *port, struct sk_buff *skb,
 				 struct mvpp2_tx_queue *aggr_txq,
 				 struct mvpp2_tx_queue *txq)
 {
-	struct mvpp2_txq_pcpu *txq_pcpu = this_cpu_ptr(txq->pcpu);
+	unsigned int thread = mvpp2_cpu_to_thread(smp_processor_id());
+	struct mvpp2_txq_pcpu *txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
 	struct mvpp2_tx_desc *tx_desc;
 	int i;
 	dma_addr_t buf_dma_addr;
@@ -2877,7 +2884,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
 	/* Check number of available descriptors */
 	if (mvpp2_aggr_desc_num_check(port->priv, aggr_txq,
 				      tso_count_descs(skb)) ||
-	    mvpp2_txq_reserved_desc_num_proc(port->priv, txq, txq_pcpu,
+	    mvpp2_txq_reserved_desc_num_proc(port, txq, txq_pcpu,
 					     tso_count_descs(skb)))
 		return 0;
 
@@ -2924,14 +2931,17 @@ static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 	struct mvpp2_txq_pcpu *txq_pcpu;
 	struct mvpp2_tx_desc *tx_desc;
 	dma_addr_t buf_dma_addr;
+	unsigned int thread;
 	int frags = 0;
 	u16 txq_id;
 	u32 tx_cmd;
 
+	thread = mvpp2_cpu_to_thread(smp_processor_id());
+
 	txq_id = skb_get_queue_mapping(skb);
 	txq = port->txqs[txq_id];
-	txq_pcpu = this_cpu_ptr(txq->pcpu);
-	aggr_txq = &port->priv->aggr_txqs[smp_processor_id()];
+	txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
+	aggr_txq = &port->priv->aggr_txqs[thread];
 
 	if (skb_is_gso(skb)) {
 		frags = mvpp2_tx_tso(skb, dev, txq, aggr_txq, txq_pcpu);
@@ -2941,8 +2951,7 @@ static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 
 	/* Check number of available descriptors */
 	if (mvpp2_aggr_desc_num_check(port->priv, aggr_txq, frags) ||
-	    mvpp2_txq_reserved_desc_num_proc(port->priv, txq,
-					     txq_pcpu, frags)) {
+	    mvpp2_txq_reserved_desc_num_proc(port, txq, txq_pcpu, frags)) {
 		frags = 0;
 		goto out;
 	}
@@ -2984,7 +2993,7 @@ static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 
 out:
 	if (frags > 0) {
-		struct mvpp2_pcpu_stats *stats = this_cpu_ptr(port->stats);
+		struct mvpp2_pcpu_stats *stats = per_cpu_ptr(port->stats, thread);
 		struct netdev_queue *nq = netdev_get_tx_queue(dev, txq_id);
 
 		txq_pcpu->reserved_num -= frags;
@@ -3014,7 +3023,7 @@ static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 	/* Set the timer in case not all frags were processed */
 	if (!port->has_tx_irqs && txq_pcpu->count <= frags &&
 	    txq_pcpu->count > 0) {
-		struct mvpp2_port_pcpu *port_pcpu = this_cpu_ptr(port->pcpu);
+		struct mvpp2_port_pcpu *port_pcpu = per_cpu_ptr(port->pcpu, thread);
 
 		mvpp2_timer_set(port_pcpu);
 	}
@@ -3407,7 +3416,7 @@ static int mvpp2_stop(struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_port_pcpu *port_pcpu;
-	unsigned int cpu;
+	unsigned int thread;
 
 	mvpp2_stop_dev(port);
 
@@ -3422,8 +3431,8 @@ static int mvpp2_stop(struct net_device *dev)
 
 	mvpp2_irqs_deinit(port);
 	if (!port->has_tx_irqs) {
-		for_each_present_cpu(cpu) {
-			port_pcpu = per_cpu_ptr(port->pcpu, cpu);
+		for (thread = 0; thread < port->nthreads; thread++) {
+			port_pcpu = per_cpu_ptr(port->pcpu, thread);
 
 			hrtimer_cancel(&port_pcpu->tx_done_timer);
 			port_pcpu->timer_scheduled = false;
@@ -4104,7 +4113,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	struct device *dev = port->dev->dev.parent;
 	struct mvpp2 *priv = port->priv;
 	struct mvpp2_txq_pcpu *txq_pcpu;
-	unsigned int cpu;
+	unsigned int thread;
 	int queue, err;
 
 	/* Checks for hardware constraints */
@@ -4149,9 +4158,9 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 		txq->id = queue_phy_id;
 		txq->log_id = queue;
 		txq->done_pkts_coal = MVPP2_TXDONE_COAL_PKTS_THRESH;
-		for_each_present_cpu(cpu) {
-			txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
-			txq_pcpu->cpu = cpu;
+		for (thread = 0; thread < port->nthreads; thread++) {
+			txq_pcpu = per_cpu_ptr(txq->pcpu, thread);
+			txq_pcpu->thread = thread;
 		}
 
 		port->txqs[queue] = txq;
@@ -4645,7 +4654,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	struct resource *res;
 	struct phylink *phylink;
 	char *mac_from = "";
-	unsigned int ntxqs, nrxqs, cpu;
+	unsigned int ntxqs, nrxqs, thread;
 	unsigned long flags = 0;
 	bool has_tx_irqs;
 	u32 id;
@@ -4709,6 +4718,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	port->has_tx_irqs = has_tx_irqs;
 	port->flags = flags;
 
+	port->nthreads = min_t(unsigned int, num_present_cpus(),
+			       MVPP2_MAX_THREADS);
+
 	err = mvpp2_queue_vectors_init(port, port_node);
 	if (err)
 		goto err_free_netdev;
@@ -4804,8 +4816,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	}
 
 	if (!port->has_tx_irqs) {
-		for_each_present_cpu(cpu) {
-			port_pcpu = per_cpu_ptr(port->pcpu, cpu);
+		for (thread = 0; thread < port->nthreads; thread++) {
+			port_pcpu = per_cpu_ptr(port->pcpu, thread);
 
 			hrtimer_init(&port_pcpu->tx_done_timer, CLOCK_MONOTONIC,
 				     HRTIMER_MODE_REL_PINNED);
@@ -5089,13 +5101,13 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
 	}
 
 	/* Allocate and initialize aggregated TXQs */
-	priv->aggr_txqs = devm_kcalloc(&pdev->dev, num_present_cpus(),
+	priv->aggr_txqs = devm_kcalloc(&pdev->dev, MVPP2_MAX_THREADS,
 				       sizeof(*priv->aggr_txqs),
 				       GFP_KERNEL);
 	if (!priv->aggr_txqs)
 		return -ENOMEM;
 
-	for_each_present_cpu(i) {
+	for (i = 0; i < MVPP2_MAX_THREADS; i++) {
 		priv->aggr_txqs[i].id = i;
 		priv->aggr_txqs[i].size = MVPP2_AGGR_TXQ_SIZE;
 		err = mvpp2_aggr_txq_init(pdev, &priv->aggr_txqs[i], i, priv);
@@ -5390,7 +5402,7 @@ static int mvpp2_remove(struct platform_device *pdev)
 		mvpp2_bm_pool_destroy(pdev, priv, bm_pool);
 	}
 
-	for_each_present_cpu(i) {
+	for (i = 0; i < MVPP2_MAX_THREADS; i++) {
 		struct mvpp2_tx_queue *aggr_txq = &priv->aggr_txqs[i];
 
 		dma_free_coherent(&pdev->dev,
-- 
2.17.1

