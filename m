Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeCWSzF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:55:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:53:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11FD960F61
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/7] igbvf: eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 23 Mar 2018 14:52:56 -0400
Message-Id: <1521831180-25014-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index fa07876..df2283b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -252,7 +252,7 @@ static void igbvf_alloc_rx_buffers(struct igbvf_ring *rx_ring,
 		 * such as IA-64).
 		*/
 		wmb();
-		writel(i, adapter->hw.hw_addr + rx_ring->tail);
+		writel_relaxed(i, adapter->hw.hw_addr + rx_ring->tail);
 	}
 }
 
@@ -2298,7 +2298,7 @@ static inline void igbvf_tx_queue_adv(struct igbvf_adapter *adapter,
 
 	tx_ring->buffer_info[first].next_to_watch = tx_desc;
 	tx_ring->next_to_use = i;
-	writel(i, adapter->hw.hw_addr + tx_ring->tail);
+	writel_relaxed(i, adapter->hw.hw_addr + tx_ring->tail);
 	/* we need this if more than one processor can write to our tail
 	 * at a time, it synchronizes IO on IA64/Altix systems
 	 */
-- 
2.7.4
