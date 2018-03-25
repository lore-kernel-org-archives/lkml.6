Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeCYOld (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:41:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeCYOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:39:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD32C60F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/7] net: qlge: Eliminate duplicate barriers on weakly-ordered archs
Date: Sun, 25 Mar 2018 10:39:19 -0400
Message-Id: <1521988761-30344-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a wmb().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/qlogic/qlge/qlge.h      | 16 ++++++++++++++++
 drivers/net/ethernet/qlogic/qlge/qlge_main.c |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge.h b/drivers/net/ethernet/qlogic/qlge/qlge.h
index 84ac50f..3e71b65 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge.h
+++ b/drivers/net/ethernet/qlogic/qlge/qlge.h
@@ -2185,6 +2185,22 @@ static inline void ql_write_db_reg(u32 val, void __iomem *addr)
 }
 
 /*
+ * Doorbell Registers:
+ * Doorbell registers are virtual registers in the PCI memory space.
+ * The space is allocated by the chip during PCI initialization.  The
+ * device driver finds the doorbell address in BAR 3 in PCI config space.
+ * The registers are used to control outbound and inbound queues. For
+ * example, the producer index for an outbound queue.  Each queue uses
+ * 1 4k chunk of memory.  The lower half of the space is for outbound
+ * queues. The upper half is for inbound queues.
+ * Caller has to guarantee ordering.
+ */
+static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
+{
+	writel_relaxed(val, addr);
+}
+
+/*
  * Shadow Registers:
  * Outbound queues have a consumer index that is maintained by the chip.
  * Inbound queues have a producer index that is maintained by the chip.
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 50038d9..8293c202 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -2700,7 +2700,8 @@ static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 		tx_ring->prod_idx = 0;
 	wmb();
 
-	ql_write_db_reg(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
+	ql_write_db_reg_relaxed(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
+	mmiowb();
 	netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
 		     "tx queued, slot %d, len %d\n",
 		     tx_ring->prod_idx, skb->len);
-- 
2.7.4
