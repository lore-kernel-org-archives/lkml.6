Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCTCn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:43:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeCTCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:43:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 916B561111
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Santosh Raspatur <santosh@chelsio.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] net: cxgb3: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:42:28 -0400
Message-Id: <1521513753-7325-14-git-send-email-okaya@codeaurora.org>
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

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/chelsio/cxgb3/adapter.h |  7 +++++++
 drivers/net/ethernet/chelsio/cxgb3/sge.c     | 19 ++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/adapter.h b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
index 087ff0f..0e21e66 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -281,6 +281,13 @@ static inline void t3_write_reg(struct adapter *adapter, u32 reg_addr, u32 val)
 	writel(val, adapter->regs + reg_addr);
 }
 
+static inline void t3_write_reg_relaxed(struct adapter *adapter, u32 reg_addr,
+					u32 val)
+{
+	CH_DBG(adapter, MMIO, "setting register 0x%x to 0x%x\n", reg_addr, val);
+	writel_relaxed(val, adapter->regs + reg_addr);
+}
+
 static inline struct port_info *adap2pinfo(struct adapter *adap, int idx)
 {
 	return netdev_priv(adap->port[idx]);
diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index e988caa..0baab06 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -487,7 +487,8 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
 	if (q->pend_cred >= q->credits / 4) {
 		q->pend_cred = 0;
 		wmb();
-		t3_write_reg(adap, A_SG_KDOORBELL, V_EGRCNTX(q->cntxt_id));
+		t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+				     V_EGRCNTX(q->cntxt_id));
 	}
 }
 
@@ -1058,8 +1059,8 @@ static inline void check_ring_tx_db(struct adapter *adap, struct sge_txq *q)
 	}
 #else
 	wmb();			/* write descriptors before telling HW */
-	t3_write_reg(adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 #endif
 }
 
@@ -1510,8 +1511,8 @@ static int ctrl_xmit(struct adapter *adap, struct sge_txq *q,
 	}
 	spin_unlock(&q->lock);
 	wmb();
-	t3_write_reg(adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 	return NET_XMIT_SUCCESS;
 }
 
@@ -1554,8 +1555,8 @@ static void restart_ctrlq(unsigned long data)
 
 	spin_unlock(&q->lock);
 	wmb();
-	t3_write_reg(qs->adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(qs->adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 }
 
 /*
@@ -1793,8 +1794,8 @@ again:	reclaim_completed_tx(adap, q, TX_RECLAIM_CHUNK);
 #endif
 	wmb();
 	if (likely(written))
-		t3_write_reg(adap, A_SG_KDOORBELL,
-			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+		t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+				     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 }
 
 /**
-- 
2.7.4
