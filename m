Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCWSVb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:21:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWSV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:21:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 357E76030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 23 Mar 2018 14:21:11 -0400
Message-Id: <1521829277-9398-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a barrier
on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 24 ++++++++++++++++++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  9 +++++++--
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c6972bd..fc10cc0 100644
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
@@ -1529,7 +1535,12 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	 * such as IA-64).
 	 */
 	wmb();
-	writel(val, rx_ring->tail);
+	writel_relaxed(val, rx_ring->tail);
+
+	/* We need this if more than one processor can write to our tail
+	 * at a time, it synchronizes IO on IA64/Altix systems
+	 */
+	mmiowb();
 }
 
 /**
@@ -2412,7 +2423,12 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		wmb();
 
-		writel(xdp_ring->next_to_use, xdp_ring->tail);
+		writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
+
+		/* We need this if more than one processor can write to our tail
+		 * at a time, it synchronizes IO on IA64/Altix systems
+		 */
+		mmiowb();
 	}
 
 	rx_ring->skb = skb;
@@ -3437,7 +3453,7 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* notify HW of packet */
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 1ae112f..ca02762 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -810,7 +810,12 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	 * such as IA-64).
 	 */
 	wmb();
-	writel(val, rx_ring->tail);
+	writel_relaxed(val, rx_ring->tail);
+
+	/* We need this if more than one processor can write to our tail
+	 * at a time, it synchronizes IO on IA64/Altix systems
+	 */
+	mmiowb();
 }
 
 /**
@@ -2379,7 +2384,7 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* notify HW of packet */
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
-- 
2.7.4
