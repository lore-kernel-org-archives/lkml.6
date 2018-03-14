Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeCNDVQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:21:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43588 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933429AbeCNDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:20:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4514460867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered archs
Date: Tue, 13 Mar 2018 23:20:27 -0400
Message-Id: <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3dd4aeb..e0e583a 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4573,7 +4573,7 @@ e1000_alloc_jumbo_rx_buffers(struct e1000_adapter *adapter,
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, adapter->hw.hw_addr + rx_ring->rdt);
+		writel_relaxed(i, adapter->hw.hw_addr + rx_ring->rdt);
 	}
 }
 
@@ -4688,7 +4688,7 @@ static void e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, hw->hw_addr + rx_ring->rdt);
+		writel_relaxed(i, hw->hw_addr + rx_ring->rdt);
 	}
 }
 
-- 
2.7.4
