Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeCNDUj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:20:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeCNDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:20:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8142F607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
Date: Tue, 13 Mar 2018 23:20:22 -0400
Message-Id: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e554aa6cf..7028516 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1375,7 +1375,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	 * such as IA-64).
 	 */
 	wmb();
-	writel(val, rx_ring->tail);
+	writel_relaxed(val, rx_ring->tail);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 357d605..2d323fc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -667,7 +667,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	 * such as IA-64).
 	 */
 	wmb();
-	writel(val, rx_ring->tail);
+	writel_relaxed(val, rx_ring->tail);
 }
 
 /**
-- 
2.7.4
