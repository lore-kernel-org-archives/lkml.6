Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756942AbeDBTJi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:09:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754430AbeDBTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:06:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83BAA60817
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] ixgbe: eliminate duplicate barriers on weakly-ordered archs
Date: Mon,  2 Apr 2018 15:06:25 -0400
Message-Id: <1522695990-31082-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory-barriers.txt has been updated as follows:

"When using writel(), a prior wmb() is not needed to guarantee that the
cache coherent memory writes have completed before writing to the MMIO
region."

Remove old IA-64 comments in the code along with unneeded wmb() in front
of writel().

There are places in the code where wmb() has been used as a double barrier
for CPU and IO in place of smp_wmb() and wmb() as an optimization. For
such places, keep the wmb() but replace the following writel() with
writel_relaxed() to have a sequence as

wmb()
writel_relaxed()
mmio_wb()

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba9..c17924b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1696,12 +1696,6 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		/* update next to alloc since we have filled the ring */
 		rx_ring->next_to_alloc = i;
 
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.  (Only
-		 * applicable for weak-ordered memory model archs,
-		 * such as IA-64).
-		 */
-		wmb();
 		writel(i, rx_ring->tail);
 	}
 }
@@ -2467,10 +2461,6 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	if (xdp_xmit) {
 		struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
 
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.
-		 */
-		wmb();
 		writel(ring->next_to_use, ring->tail);
 
 		xdp_do_flush_map();
@@ -8080,12 +8070,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
-	/*
-	 * Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.  (Only applicable for weak-ordered
-	 * memory model archs, such as IA-64).
-	 *
-	 * We also need this memory barrier to make certain all of the
+	/* We need this memory barrier to make certain all of the
 	 * status bits have been updated before next_to_watch is written.
 	 */
 	wmb();
@@ -8102,7 +8087,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	ixgbe_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
@@ -10034,10 +10019,6 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	if (unlikely(!ring))
 		return;
 
-	/* Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.
-	 */
-	wmb();
 	writel(ring->next_to_use, ring->tail);
 
 	return;
-- 
2.7.4
