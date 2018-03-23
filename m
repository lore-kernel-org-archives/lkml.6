Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeCWSVp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:21:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbeCWSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:21:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DC7D607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] ixgbevf: keep writel() closer to wmb()
Date: Fri, 23 Mar 2018 14:21:16 -0400
Message-Id: <1521829277-9398-7-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ixgbevf_write_tail() in favor of moving writel() close to
wmb().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index f712646..f97091d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -312,11 +312,6 @@ static inline u16 ixgbevf_desc_unused(struct ixgbevf_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
-static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 value)
-{
-	writel(value, ring->tail);
-}
-
 #define IXGBEVF_RX_DESC(R, i)	\
 	(&(((union ixgbe_adv_rx_desc *)((R)->desc))[i]))
 #define IXGBEVF_TX_DESC(R, i)	\
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d9033f..815cb1a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -725,7 +725,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		 * such as IA-64).
 		 */
 		wmb();
-		ixgbevf_write_tail(rx_ring, i);
+		writel(i, rx_ring->tail);
 	}
 }
 
@@ -1232,7 +1232,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		 * know there are new descriptors to fetch.
 		 */
 		wmb();
-		ixgbevf_write_tail(xdp_ring, xdp_ring->next_to_use);
+		writel(xdp_ring->next_to_use, xdp_ring->tail);
 	}
 
 	u64_stats_update_begin(&rx_ring->syncp);
@@ -4004,7 +4004,7 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	tx_ring->next_to_use = i;
 
 	/* notify HW of packet */
-	ixgbevf_write_tail(tx_ring, i);
+	writel(i, tx_ring->tail);
 
 	return;
 dma_error:
-- 
2.7.4
