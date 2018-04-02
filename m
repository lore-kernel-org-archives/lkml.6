Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756779AbeDBTGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:06:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756760AbeDBTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:06:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 224C1602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/7] i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon,  2 Apr 2018 15:06:24 -0400
Message-Id: <1522695990-31082-2-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 +++++++++-------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  8 +-------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f174c72..1b9fa7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -186,7 +186,13 @@ static int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data,
 	/* Mark the data descriptor to be watched */
 	first->next_to_watch = tx_desc;
 
-	writel(tx_ring->next_to_use, tx_ring->tail);
+	writel_relaxed(tx_ring->next_to_use, tx_ring->tail);
+
+	/* We need this if more than one processor can write to our tail
+	 * at a time, it synchronizes IO on IA64/Altix systems
+	 */
+	mmiowb();
+
 	return 0;
 
 dma_fail:
@@ -1523,12 +1529,6 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	/* update next to alloc since we have filled the ring */
 	rx_ring->next_to_alloc = val;
 
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.  (Only
-	 * applicable for weak-ordered memory model archs,
-	 * such as IA-64).
-	 */
-	wmb();
 	writel(val, rx_ring->tail);
 }
 
@@ -2274,11 +2274,7 @@ static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
 
 static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
 {
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.
-	 */
-	wmb();
-	writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
+	writel(xdp_ring->next_to_use, xdp_ring->tail);
 }
 
 /**
@@ -3444,7 +3440,7 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* notify HW of packet */
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 12bd937..eb5556e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -804,12 +804,6 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	/* update next to alloc since we have filled the ring */
 	rx_ring->next_to_alloc = val;
 
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.  (Only
-	 * applicable for weak-ordered memory model archs,
-	 * such as IA-64).
-	 */
-	wmb();
 	writel(val, rx_ring->tail);
 }
 
@@ -2379,7 +2373,7 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* notify HW of packet */
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
-- 
2.7.4
