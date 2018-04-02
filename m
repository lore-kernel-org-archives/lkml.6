Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756848AbeDBTHT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:07:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756804AbeDBTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:06:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B61160F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/7] ixgbevf: eliminate duplicate barriers on weakly-ordered archs
Date: Mon,  2 Apr 2018 15:06:30 -0400
Message-Id: <1522695990-31082-8-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 757dac6..29b71a7 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -719,12 +719,6 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
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
@@ -1228,10 +1222,6 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		struct ixgbevf_ring *xdp_ring =
 			adapter->xdp_ring[rx_ring->queue_index];
 
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.
-		 */
-		wmb();
 		writel(xdp_ring->next_to_use, xdp_ring->tail);
 	}
 
@@ -3985,11 +3975,7 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
-	/* Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.  (Only applicable for weak-ordered
-	 * memory model archs, such as IA-64).
-	 *
-	 * We also need this memory barrier (wmb) to make certain all of the
+	/* We also need this memory barrier (wmb) to make certain all of the
 	 * status bits have been updated before next_to_watch is written.
 	 */
 	wmb();
@@ -4004,7 +3990,12 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	tx_ring->next_to_use = i;
 
 	/* notify HW of packet */
-	writel(i, tx_ring->tail);
+	writel_relaxed(i, tx_ring->tail);
+
+	/* We need this if more than one processor can write to our tail
+	 * at a time, it synchronizes IO on IA64/Altix systems
+	 */
+	mmiowb();
 
 	return;
 dma_error:
-- 
2.7.4
