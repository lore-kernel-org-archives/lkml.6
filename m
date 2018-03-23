Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeCWWXu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:23:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeCWWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:23:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5426B60F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Michael Chan <michael.chan@broadcom.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] bnxt_en: Eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 23 Mar 2018 18:23:11 -0400
Message-Id: <1521843791-21201-7-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
References: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
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

Also add mmiowb() so that write code doesn't move outside of scope.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1500243..fc8ea0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1922,7 +1922,8 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		/* Sync BD data before updating doorbell */
 		wmb();
 
-		bnxt_db_write(bp, db, DB_KEY_TX | prod);
+		bnxt_db_write_relaxed(bp, db, DB_KEY_TX | prod);
+		mmiowb();
 	}
 
 	cpr->cp_raw_cons = raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1989c47..5e453b9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1401,6 +1401,15 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 		((txr->tx_prod - txr->tx_cons) & bp->tx_ring_mask);
 }
 
+/* For TX and RX ring doorbells with no ordering guarantee*/
+static inline void bnxt_db_write_relaxed(struct bnxt *bp, void __iomem *db,
+					 u32 val)
+{
+	writel_relaxed(val, db);
+	if (bp->flags & BNXT_FLAG_DOUBLE_DB)
+		writel_relaxed(val, db);
+}
+
 /* For TX and RX ring doorbells */
 static inline void bnxt_db_write(struct bnxt *bp, void __iomem *db, u32 val)
 {
-- 
2.7.4
