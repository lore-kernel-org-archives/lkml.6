Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCWSzI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:55:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:53:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5A5760C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/7] ixgbe: eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 23 Mar 2018 14:52:55 -0400
Message-Id: <1521831180-25014-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e3b32ea..fb80edb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1701,7 +1701,7 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
@@ -2470,7 +2470,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		 * know there are new descriptors to fetch.
 		 */
 		wmb();
-		writel(ring->next_to_use, ring->tail);
+		writel_relaxed(ring->next_to_use, ring->tail);
 
 		xdp_do_flush_map();
 	}
@@ -8101,7 +8101,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	ixgbe_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
@@ -10038,7 +10038,7 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	 * are new descriptors to fetch.
 	 */
 	wmb();
-	writel(ring->next_to_use, ring->tail);
+	writel_relaxed(ring->next_to_use, ring->tail);
 
 	return;
 }
-- 
2.7.4
