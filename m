Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCPQVQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:21:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbeCPQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:17:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3E3260F5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/18] net: cxgb4/cxgb4vf: Eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 16 Mar 2018 12:16:26 -0400
Message-Id: <1521216991-28706-14-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |  6 ++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 13 +++++++------
 drivers/net/ethernet/chelsio/cxgb4/sge.c        |  8 ++++----
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h  | 14 ++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c      | 16 +++++++++-------
 6 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 9040e13..6bde0b9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1202,6 +1202,12 @@ static inline void t4_write_reg(struct adapter *adap, u32 reg_addr, u32 val)
 	writel(val, adap->regs + reg_addr);
 }
 
+static inline void t4_write_reg_relaxed(struct adapter *adap, u32 reg_addr,
+					u32 val)
+{
+	writel_relaxed(val, adap->regs + reg_addr);
+}
+
 #ifndef readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 7b452e8..276472d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1723,8 +1723,8 @@ int cxgb4_sync_txq_pidx(struct net_device *dev, u16 qid, u16 pidx,
 		else
 			val = PIDX_T5_V(delta);
 		wmb();
-		t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-			     QID_V(qid) | val);
+		t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+				     QID_V(qid) | val);
 	}
 out:
 	return ret;
@@ -1902,8 +1902,9 @@ static void enable_txq_db(struct adapter *adap, struct sge_txq *q)
 		 * are committed before we tell HW about them.
 		 */
 		wmb();
-		t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-			     QID_V(q->cntxt_id) | PIDX_V(q->db_pidx_inc));
+		t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+				     QID_V(q->cntxt_id) |
+						PIDX_V(q->db_pidx_inc));
 		q->db_pidx_inc = 0;
 	}
 	q->db_disabled = 0;
@@ -2003,8 +2004,8 @@ static void sync_txq_pidx(struct adapter *adap, struct sge_txq *q)
 		else
 			val = PIDX_T5_V(delta);
 		wmb();
-		t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-			     QID_V(q->cntxt_id) | val);
+		t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+				     QID_V(q->cntxt_id) | val);
 	}
 out:
 	q->db_disabled = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 6e310a0..1a1738a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -530,11 +530,11 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
 		 * mechanism.
 		 */
 		if (unlikely(q->bar2_addr == NULL)) {
-			t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-				     val | QID_V(q->cntxt_id));
+			t4_write_reg_relaxed(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
+					     val | QID_V(q->cntxt_id));
 		} else {
-			writel(val | QID_V(q->bar2_qid),
-			       q->bar2_addr + SGE_UDB_KDOORBELL);
+			writel_relaxed(val | QID_V(q->bar2_qid),
+				       q->bar2_addr + SGE_UDB_KDOORBELL);
 
 			/* This Write memory Barrier will force the write to
 			 * the User Doorbell area to be flushed.
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 920bccd..8b723a0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -139,7 +139,7 @@ void t4_write_indirect(struct adapter *adap, unsigned int addr_reg,
 {
 	while (nregs--) {
 		t4_write_reg(adap, addr_reg, start_idx++);
-		t4_write_reg(adap, data_reg, *vals++);
+		t4_write_reg_relaxed(adap, data_reg, *vals++);
 	}
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
index 5883f09..00247be4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -442,6 +442,20 @@ static inline void t4_write_reg(struct adapter *adapter, u32 reg_addr, u32 val)
 	writel(val, adapter->regs + reg_addr);
 }
 
+/**
+ * t4_write_reg_relaxed - write a HW register without ordering guarantees
+ * @adapter: the adapter
+ * @reg_addr: the register address
+ * @val: the value to write
+ *
+ * Write a 32-bit value into the given HW register.
+ */
+static inline void t4_write_reg_relaxed(struct adapter *adapter, u32 reg_addr,
+					u32 val)
+{
+	writel_relaxed(val, adapter->regs + reg_addr);
+}
+
 #ifndef readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index dfce5df..1d98387 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -546,12 +546,13 @@ static inline void ring_fl_db(struct adapter *adapter, struct sge_fl *fl)
 		 * mechanism.
 		 */
 		if (unlikely(fl->bar2_addr == NULL)) {
-			t4_write_reg(adapter,
-				     T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
-				     QID_V(fl->cntxt_id) | val);
+			t4_write_reg_relaxed(adapter,
+					     T4VF_SGE_BASE_ADDR +
+							SGE_VF_KDOORBELL,
+					     QID_V(fl->cntxt_id) | val);
 		} else {
-			writel(val | QID_V(fl->bar2_qid),
-			       fl->bar2_addr + SGE_UDB_KDOORBELL);
+			writel_relaxed(val | QID_V(fl->bar2_qid),
+				       fl->bar2_addr + SGE_UDB_KDOORBELL);
 
 			/* This Write memory Barrier will force the write to
 			 * the User Doorbell area to be flushed.
@@ -980,8 +981,9 @@ static inline void ring_tx_db(struct adapter *adapter, struct sge_txq *tq,
 	if (unlikely(tq->bar2_addr == NULL)) {
 		u32 val = PIDX_V(n);
 
-		t4_write_reg(adapter, T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
-			     QID_V(tq->cntxt_id) | val);
+		t4_write_reg_relaxed(adapter,
+				     T4VF_SGE_BASE_ADDR + SGE_VF_KDOORBELL,
+				     QID_V(tq->cntxt_id) | val);
 	} else {
 		u32 val = PIDX_T5_V(n);
 
-- 
2.7.4
