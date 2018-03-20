Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeCTCnb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:43:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCTCnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:43:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4194960F94
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/17] qed/qede: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:42:31 -0400
Message-Id: <1521513753-7325-17-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/qlogic/qed/qed.h           |  5 ++++-
 drivers/net/ethernet/qlogic/qed/qed_hw.c        | 12 ++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_hw.h        | 14 ++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_int.c       |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c        |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c       |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c        |  7 ++++---
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c      |  4 ++--
 drivers/net/ethernet/qlogic/qlge/qlge.h         |  1 -
 include/linux/qed/qed_if.h                      | 17 +++++++++++++----
 11 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 6948855..241077f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -818,12 +818,15 @@ u16 qed_get_cm_pq_idx_vf(struct qed_hwfn *p_hwfn, u16 vf);
 						(cdev->regview) + \
 							 (offset))
 
+#define REG_WR_RELAXED(cdev, offset, val)		\
+	writel_relaxed((u32)val, REG_ADDR(cdev, offset))
+
 #define REG_RD(cdev, offset)            readl(REG_ADDR(cdev, offset))
 #define REG_WR(cdev, offset, val)       writel((u32)val, REG_ADDR(cdev, offset))
 #define REG_WR16(cdev, offset, val)     writew((u16)val, REG_ADDR(cdev, offset))
 
 #define DOORBELL(cdev, db_addr, val)			 \
-	writel((u32)val, (void __iomem *)((u8 __iomem *)\
+	writel_relaxed((u32)val, (void __iomem *)((u8 __iomem *)\
 					  (cdev->doorbells) + (db_addr)))
 
 /* Prototypes */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.c b/drivers/net/ethernet/qlogic/qed/qed_hw.c
index fca2dbd..1d76121 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.c
@@ -222,6 +222,18 @@ struct qed_ptt *qed_get_reserved_ptt(struct qed_hwfn *p_hwfn,
 	return &p_hwfn->p_ptt_pool->ptts[ptt_idx];
 }
 
+void qed_wr_relaxed(struct qed_hwfn *p_hwfn,
+		    struct qed_ptt *p_ptt,
+		    u32 hw_addr, u32 val)
+{
+	u32 bar_addr = qed_set_ptt(p_hwfn, p_ptt, hw_addr);
+
+	REG_WR_RELAXED(p_hwfn, bar_addr, val);
+	DP_VERBOSE(p_hwfn, NETIF_MSG_HW,
+		   "bar_addr 0x%x, hw_addr 0x%x, val 0x%x\n",
+		   bar_addr, hw_addr, val);
+}
+
 void qed_wr(struct qed_hwfn *p_hwfn,
 	    struct qed_ptt *p_ptt,
 	    u32 hw_addr, u32 val)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.h b/drivers/net/ethernet/qlogic/qed/qed_hw.h
index 8db2839..bb4f5ff 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.h
@@ -152,6 +152,20 @@ struct qed_ptt *qed_get_reserved_ptt(struct qed_hwfn *p_hwfn,
 				     enum reserved_ptts ptt_idx);
 
 /**
+ * @brief qed_wr_relaxed - Write value to BAR using the given ptt
+ *			   No ordering guarantee.
+ *
+ * @param p_hwfn
+ * @param p_ptt
+ * @param val
+ * @param hw_addr
+ */
+void qed_wr_relaxed(struct qed_hwfn *p_hwfn,
+		    struct qed_ptt *p_ptt,
+		    u32 hw_addr,
+		    u32 val);
+
+/**
  * @brief qed_wr - Write value to BAR using the given ptt
  *
  * @param p_hwfn
diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index d3eabcf..5f09253 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -1747,7 +1747,7 @@ static void qed_int_igu_cleanup_sb(struct qed_hwfn *p_hwfn,
 
 	barrier();
 
-	qed_wr(p_hwfn, p_ptt, IGU_REG_COMMAND_REG_CTRL, cmd_ctrl);
+	qed_wr_relaxed(p_hwfn, p_ptt, IGU_REG_COMMAND_REG_CTRL, cmd_ctrl);
 
 	/* Flush the write to IGU */
 	mmiowb();
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 893ef08..7f3f923b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -921,7 +921,7 @@ qed_eth_pf_rx_queue_start(struct qed_hwfn *p_hwfn,
 
 	/* Init the rcq, rx bd and rx sge (if valid) producers to 0 */
 	__internal_ram_wr(p_hwfn, *pp_prod, sizeof(u32),
-			  (u32 *)(&init_prod_val));
+			  (u32 *)(&init_prod_val), false);
 
 	return qed_eth_rxq_start_ramrod(p_hwfn, p_cid,
 					bd_max_bytes,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index c4f14fd..211f325 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -1759,7 +1759,7 @@ static void qed_ll2_tx_packet_notify(struct qed_hwfn *p_hwfn,
 	/* Make sure the BDs data is updated before ringing the doorbell */
 	wmb();
 
-	DIRECT_REG_WR(p_tx->doorbell_addr, *((u32 *)&db_msg));
+	DIRECT_REG_WR_RELAXED(p_tx->doorbell_addr, *((u32 *)&db_msg));
 
 	DP_VERBOSE(p_hwfn,
 		   (NETIF_MSG_TX_QUEUED | QED_MSG_LL2),
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 91b5e9f..6fa5ccb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -123,7 +123,8 @@ static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done, u32 resp_size)
 	 */
 	wmb();
 
-	REG_WR(p_hwfn, (uintptr_t)&zone_data->trigger, *((u32 *)&trigger));
+	REG_WR_RELAXED(p_hwfn, (uintptr_t)&zone_data->trigger,
+		       *((u32 *)&trigger));
 
 	/* When PF would be done with the response, it would write back to the
 	 * `done' address. Poll until then.
@@ -758,7 +759,7 @@ qed_vf_pf_rxq_start(struct qed_hwfn *p_hwfn,
 
 		/* Init the rcq, rx bd and rx sge (if valid) producers to 0 */
 		__internal_ram_wr(p_hwfn, *pp_prod, sizeof(u32),
-				  (u32 *)(&init_prod_val));
+				  (u32 *)(&init_prod_val), false);
 	}
 
 	qed_vf_pf_add_qid(p_hwfn, p_cid);
@@ -788,7 +789,7 @@ qed_vf_pf_rxq_start(struct qed_hwfn *p_hwfn,
 
 		/* Init the rcq, rx bd and rx sge (if valid) producers to 0 */
 		__internal_ram_wr(p_hwfn, *pp_prod, sizeof(u32),
-				  (u32 *)&init_prod_val);
+				  (u32 *)&init_prod_val, false);
 	}
 exit:
 	qed_vf_pf_req_end(p_hwfn, rc);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 4ca3847..0d9f63a 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1417,7 +1417,7 @@ static int qede_selftest_transmit_traffic(struct qede_dev *edev,
 	 */
 	wmb();
 	barrier();
-	writel(txq->tx_db.raw, txq->doorbell_addr);
+	writel_relaxed(txq->tx_db.raw, txq->doorbell_addr);
 
 	/* mmiowb is needed to synchronize doorbell writes from more than one
 	 * processor. It guarantees that the write arrives to the device before
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index dafc079..9dd2124 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -318,7 +318,7 @@ static inline void qede_update_tx_producer(struct qede_tx_queue *txq)
 	 */
 	wmb();
 	barrier();
-	writel(txq->tx_db.raw, txq->doorbell_addr);
+	writel_relaxed(txq->tx_db.raw, txq->doorbell_addr);
 
 	/* mmiowb is needed to synchronize doorbell writes from more than one
 	 * processor. It guarantees that the write arrives to the device before
@@ -581,7 +581,7 @@ void qede_update_rx_prod(struct qede_dev *edev, struct qede_rx_queue *rxq)
 	wmb();
 
 	internal_ram_wr(rxq->hw_rxq_prod_addr, sizeof(rx_prods),
-			(u32 *)&rx_prods);
+			(u32 *)&rx_prods, true);
 
 	/* mmiowb is needed to synchronize doorbell writes from more than one
 	 * processor. It guarantees that the write arrives to the device before
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge.h b/drivers/net/ethernet/qlogic/qlge/qlge.h
index 1465986..01dfdb5 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge.h
+++ b/drivers/net/ethernet/qlogic/qlge/qlge.h
@@ -2201,7 +2201,6 @@ static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
 	mmiowb();
 }
 
-
 /*
  * Shadow Registers:
  * Outbound queues have a consumer index that is maintained by the chip.
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 15e398c..70f67ad 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -179,6 +179,9 @@ enum qed_led_mode {
 	QED_LED_MODE_RESTORE
 };
 
+#define DIRECT_REG_WR_RELAXED(reg_addr, val) \
+	writel_relaxed((u32)val, (void __iomem *)(reg_addr))
+
 #define DIRECT_REG_WR(reg_addr, val) writel((u32)val, \
 					    (void __iomem *)(reg_addr))
 
@@ -985,20 +988,26 @@ static inline void qed_sb_ack(struct qed_sb_info *sb_info,
 static inline void __internal_ram_wr(void *p_hwfn,
 				     void __iomem *addr,
 				     int size,
-				     u32 *data)
+				     u32 *data,
+				     bool relaxed)
 
 {
 	unsigned int i;
 
 	for (i = 0; i < size / sizeof(*data); i++)
-		DIRECT_REG_WR(&((u32 __iomem *)addr)[i], data[i]);
+		if (relaxed)
+			DIRECT_REG_WR_RELAXED(&((u32 __iomem *)addr)[i],
+					      data[i]);
+		else
+			DIRECT_REG_WR(&((u32 __iomem *)addr)[i], data[i]);
 }
 
 static inline void internal_ram_wr(void __iomem *addr,
 				   int size,
-				   u32 *data)
+				   u32 *data,
+				   bool relaxed)
 {
-	__internal_ram_wr(NULL, addr, size, data);
+	__internal_ram_wr(NULL, addr, size, data, relaxed);
 }
 
 enum qed_rss_caps {
-- 
2.7.4
