Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeCTCnu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:43:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeCTCn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:43:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E76E60F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Netanel Belgazal <netanel@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>, Zorik Machulsky <zorik@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tobias Klauser <tklauser@distanz.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/17] net: ena: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:42:32 -0400
Message-Id: <1521513753-7325-18-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes barrier() followed by writel(). writel() already has a
barrier
on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a barrier().

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c     |  6 ++++--
 drivers/net/ethernet/amazon/ena/ena_eth_com.h | 22 ++++++++++++++++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  4 ++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index bf2de52..b6e628f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -631,7 +631,8 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *ena_dev, u16 offset)
 	 */
 	wmb();
 
-	writel(mmio_read_reg, ena_dev->reg_bar + ENA_REGS_MMIO_REG_READ_OFF);
+	writel_relaxed(mmio_read_reg,
+		       ena_dev->reg_bar + ENA_REGS_MMIO_REG_READ_OFF);
 
 	for (i = 0; i < timeout; i++) {
 		if (read_resp->req_id == mmio_read->seq_num)
@@ -1826,7 +1827,8 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *dev, void *data)
 
 	/* write the aenq doorbell after all AENQ descriptors were read */
 	mb();
-	writel((u32)aenq->head, dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
+	writel_relaxed((u32)aenq->head,
+		       dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
 }
 
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.h b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
index 2f76572..09ef7cd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
@@ -107,7 +107,8 @@ static inline int ena_com_sq_empty_space(struct ena_com_io_sq *io_sq)
 	return io_sq->q_depth - 1 - cnt;
 }
 
-static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
+static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq,
+					    bool relaxed)
 {
 	u16 tail;
 
@@ -116,7 +117,24 @@ static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
 	pr_debug("write submission queue doorbell for queue: %d tail: %d\n",
 		 io_sq->qid, tail);
 
-	writel(tail, io_sq->db_addr);
+	if (relaxed)
+		writel_relaxed(tail, io_sq->db_addr);
+	else
+		writel(tail, io_sq->db_addr);
+
+	return 0;
+}
+
+static inline int ena_com_write_sq_doorbell_rel(struct ena_com_io_sq *io_sq)
+{
+	u16 tail;
+
+	tail = io_sq->tail;
+
+	pr_debug("write submission queue doorbell for queue: %d tail: %d\n",
+		 io_sq->qid, tail);
+
+	writel_relaxed(tail, io_sq->db_addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6975150..0530201 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -556,7 +556,7 @@ static int ena_refill_rx_bufs(struct ena_ring *rx_ring, u32 num)
 		 * issue a doorbell
 		 */
 		wmb();
-		ena_com_write_sq_doorbell(rx_ring->ena_com_io_sq);
+		ena_com_write_sq_doorbell(rx_ring->ena_com_io_sq, true);
 	}
 
 	rx_ring->next_to_use = next_to_use;
@@ -2151,7 +2151,7 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (netif_xmit_stopped(txq) || !skb->xmit_more) {
 		/* trigger the dma engine */
-		ena_com_write_sq_doorbell(tx_ring->ena_com_io_sq);
+		ena_com_write_sq_doorbell(tx_ring->ena_com_io_sq, false);
 		u64_stats_update_begin(&tx_ring->syncp);
 		tx_ring->tx_stats.doorbells++;
 		u64_stats_update_end(&tx_ring->syncp);
-- 
2.7.4
