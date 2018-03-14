Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933553AbeCNDW2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:22:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933316AbeCNDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:20:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27EE0607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ixgbe: eliminate duplicate barriers on weakly-ordered archs
Date: Tue, 13 Mar 2018 23:20:23 -0400
Message-Id: <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0da5aa2..35ca1d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1692,7 +1692,7 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
@@ -2453,7 +2453,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		 * know there are new descriptors to fetch.
 		 */
 		wmb();
-		writel(ring->next_to_use, ring->tail);
+		writel_relaxed(ring->next_to_use, ring->tail);
 
 		xdp_do_flush_map();
 	}
@@ -10014,7 +10014,7 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	 * are new descriptors to fetch.
 	 */
 	wmb();
-	writel(ring->next_to_use, ring->tail);
+	writel_relaxed(ring->next_to_use, ring->tail);
 
 	return;
 }
-- 
2.7.4
