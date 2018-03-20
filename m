Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeCTCo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:44:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeCTCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:43:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3262761155
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Michael Chan <michael.chan@broadcom.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/17] bnxt_en: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:42:30 -0400
Message-Id: <1521513753-7325-16-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
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

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 11 ++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1500243..befb538 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1922,7 +1922,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		/* Sync BD data before updating doorbell */
 		wmb();
 
-		bnxt_db_write(bp, db, DB_KEY_TX | prod);
+		bnxt_db_write_relaxed(bp, db, DB_KEY_TX | prod);
 	}
 
 	cpr->cp_raw_cons = raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1989c47..4c0d048 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1402,11 +1402,20 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 }
 
 /* For TX and RX ring doorbells */
+static inline void bnxt_db_write_relaxed(struct bnxt *bp, void __iomem *db,
+					 u32 val)
+{
+	writel_relaxed(val, db);
+	if (bp->flags & BNXT_FLAG_DOUBLE_DB)
+		writel_relaxed(val, db);
+}
+
+/* For TX and RX ring doorbells */
 static inline void bnxt_db_write(struct bnxt *bp, void __iomem *db, u32 val)
 {
 	writel(val, db);
 	if (bp->flags & BNXT_FLAG_DOUBLE_DB)
-		writel(val, db);
+		writel_relaxed(val, db);
 }
 
 extern const u16 bnxt_lhint_arr[];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1801582..a1b1060 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2403,7 +2403,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	/* Sync BD data before updating doorbell */
 	wmb();
 
-	bnxt_db_write(bp, txr->tx_doorbell, DB_KEY_TX | txr->tx_prod);
+	bnxt_db_write_relaxed(bp, txr->tx_doorbell, DB_KEY_TX | txr->tx_prod);
 	rc = bnxt_poll_loopback(bp, pkt_size);
 
 	dma_unmap_single(&bp->pdev->dev, map, pkt_size, PCI_DMA_TODEVICE);
-- 
2.7.4
