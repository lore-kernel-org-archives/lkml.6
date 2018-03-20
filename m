Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeCTCpa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:45:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeCTCnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:43:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AA3360FAA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] bnx2x: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:42:26 -0400
Message-Id: <1521513753-7325-12-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h       |  9 ++++++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 21 +++++++++++----------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  |  2 +-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 352beff..ac38db9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -166,6 +166,12 @@ do {						\
 #define REG_RD8(bp, offset)		readb(REG_ADDR(bp, offset))
 #define REG_RD16(bp, offset)		readw(REG_ADDR(bp, offset))
 
+#define REG_WR_RELAXED(bp, offset, val)	writel_relaxed((u32)val,\
+						       REG_ADDR(bp, offset))
+
+#define REG_WR16_RELAXED(bp, offset, val) \
+	writew_relaxed((u16)val, REG_ADDR(bp, offset))
+
 #define REG_WR(bp, offset, val)		writel((u32)val, REG_ADDR(bp, offset))
 #define REG_WR8(bp, offset, val)	writeb((u8)val, REG_ADDR(bp, offset))
 #define REG_WR16(bp, offset, val)	writew((u16)val, REG_ADDR(bp, offset))
@@ -760,7 +766,8 @@ struct bnx2x_fastpath {
 #endif
 #define DOORBELL(bp, cid, val) \
 	do { \
-		writel((u32)(val), bp->doorbells + (bp->db_size * (cid))); \
+		writel_relaxed((u32)(val),\
+				bp->doorbells + (bp->db_size * (cid))); \
 	} while (0)
 
 /* TX CSUM helpers */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index a5265e1..a8ce5c5 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -522,8 +522,8 @@ static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 	wmb();
 
 	for (i = 0; i < sizeof(rx_prods)/4; i++)
-		REG_WR(bp, fp->ustorm_rx_prods_offset + i*4,
-		       ((u32 *)&rx_prods)[i]);
+		REG_WR_RELAXED(bp, fp->ustorm_rx_prods_offset + i * 4,
+			       ((u32 *)&rx_prods)[i]);
 
 	mmiowb(); /* keep prod updates ordered */
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af..2dea1b6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1608,8 +1608,8 @@ static void bnx2x_hc_int_enable(struct bnx2x *bp)
 		} else
 			val = 0xffff;
 
-		REG_WR(bp, HC_REG_TRAILING_EDGE_0 + port*8, val);
-		REG_WR(bp, HC_REG_LEADING_EDGE_0 + port*8, val);
+		REG_WR_RELAXED(bp, HC_REG_TRAILING_EDGE_0 + port * 8, val);
+		REG_WR_RELAXED(bp, HC_REG_LEADING_EDGE_0 + port * 8, val);
 	}
 
 	/* Make sure that interrupts are indeed enabled from here on */
@@ -1672,8 +1672,8 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	} else
 		val = 0xffff;
 
-	REG_WR(bp, IGU_REG_TRAILING_EDGE_LATCH, val);
-	REG_WR(bp, IGU_REG_LEADING_EDGE_LATCH, val);
+	REG_WR_RELAXED(bp, IGU_REG_TRAILING_EDGE_LATCH, val);
+	REG_WR_RELAXED(bp, IGU_REG_LEADING_EDGE_LATCH, val);
 
 	/* Make sure that interrupts are indeed enabled from here on */
 	mmiowb();
@@ -3817,8 +3817,8 @@ static void bnx2x_sp_prod_update(struct bnx2x *bp)
 	 */
 	mb();
 
-	REG_WR16(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
-		 bp->spq_prod_idx);
+	REG_WR16_RELAXED(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
+			 bp->spq_prod_idx);
 	mmiowb();
 }
 
@@ -7761,7 +7761,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id, bool is_pf)
 	barrier();
 	DP(NETIF_MSG_HW, "write 0x%08x to IGU(via GRC) addr 0x%x\n",
 			  ctl, igu_addr_ctl);
-	REG_WR(bp, igu_addr_ctl, ctl);
+	REG_WR_RELAXED(bp, igu_addr_ctl, ctl);
 	mmiowb();
 	barrier();
 
@@ -9720,13 +9720,14 @@ static void bnx2x_process_kill_chip_reset(struct bnx2x *bp, bool global)
 	barrier();
 	mmiowb();
 
-	REG_WR(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_2_SET,
-	       reset_mask2 & (~stay_reset2));
+	REG_WR_RELAXED(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_2_SET,
+		       reset_mask2 & (~stay_reset2));
 
 	barrier();
 	mmiowb();
 
-	REG_WR(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_1_SET, reset_mask1);
+	REG_WR_RELAXED(bp, GRCBASE_MISC + MISC_REGISTERS_RESET_REG_1_SET,
+		       reset_mask1);
 	mmiowb();
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index ffa7959..40e55d8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -105,7 +105,7 @@ static void bnx2x_vf_igu_ack_sb(struct bnx2x *bp, struct bnx2x_virtf *vf,
 
 	DP(NETIF_MSG_HW, "write 0x%08x to IGU(via GRC) addr 0x%x\n",
 	   ctl, igu_addr_ctl);
-	REG_WR(bp, igu_addr_ctl, ctl);
+	REG_WR_RELAXED(bp, igu_addr_ctl, ctl);
 	mmiowb();
 	barrier();
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 76a4668..3b2f1bd 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -170,7 +170,7 @@ static int bnx2x_send_msg2pf(struct bnx2x *bp, u8 *done, dma_addr_t msg_mapping)
 	wmb();
 
 	/* Trigger the PF FW */
-	writeb(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
 
 	/* Wait for PF to complete */
 	while ((tout >= 0) && (!*done)) {
-- 
2.7.4
