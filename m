Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbeCPBFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:05:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932956AbeCPBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:05:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BC2160FA9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@ocdeaurora.org, sulrich@ocdeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ixgbevf: keep writel() closer to wmb()
Date: Thu, 15 Mar 2018 21:04:55 -0400
Message-Id: <1521162296-19729-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
References: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index f695242..11e893e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -244,11 +244,6 @@ static inline u16 ixgbevf_desc_unused(struct ixgbevf_ring *ring)
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
index 9b3d43d..b65f691 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -659,7 +659,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		 * such as IA-64).
 		 */
 		wmb();
-		ixgbevf_write_tail(rx_ring, i);
+		writel(i, rx_ring->tail);
 	}
 }
 
@@ -3644,7 +3644,7 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	tx_ring->next_to_use = i;
 
 	/* notify HW of packet */
-	ixgbevf_write_tail(tx_ring, i);
+	writel(value, tx_ring->tail);
 
 	return;
 dma_error:
-- 
2.7.4
