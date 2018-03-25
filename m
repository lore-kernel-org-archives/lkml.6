Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeCYOju (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:39:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeCYOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:39:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B5C860C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/7] bnx2x: Eliminate duplicate barriers on weakly-ordered archs
Date: Sun, 25 Mar 2018 10:39:18 -0400
Message-Id: <1521988761-30344-5-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h         | 12 ++++++++----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c     |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h     |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c    |  4 +++-
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 352beff..d847e1b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -166,6 +166,12 @@ do {						\
 #define REG_RD8(bp, offset)		readb(REG_ADDR(bp, offset))
 #define REG_RD16(bp, offset)		readw(REG_ADDR(bp, offset))
 
+#define REG_WR_RELAXED(bp, offset, val)	\
+	writel_relaxed((u32)val, REG_ADDR(bp, offset))
+
+#define REG_WR16_RELAXED(bp, offset, val) \
+	writew_relaxed((u16)val, REG_ADDR(bp, offset))
+
 #define REG_WR(bp, offset, val)		writel((u32)val, REG_ADDR(bp, offset))
 #define REG_WR8(bp, offset, val)	writeb((u8)val, REG_ADDR(bp, offset))
 #define REG_WR16(bp, offset, val)	writew((u16)val, REG_ADDR(bp, offset))
@@ -758,10 +764,8 @@ struct bnx2x_fastpath {
 #if (BNX2X_DB_SHIFT < BNX2X_DB_MIN_SHIFT)
 #error "Min DB doorbell stride is 8"
 #endif
-#define DOORBELL(bp, cid, val) \
-	do { \
-		writel((u32)(val), bp->doorbells + (bp->db_size * (cid))); \
-	} while (0)
+#define DOORBELL_RELAXED(bp, cid, val) \
+	writel_relaxed((u32)(val), (bp)->doorbells + ((bp)->db_size * (cid)))
 
 /* TX CSUM helpers */
 #define SKB_CS_OFF(skb)		(offsetof(struct tcphdr, check) - \
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 0f86f18..95871576 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4156,7 +4156,7 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* make sure descriptor update is observed by HW */
 	wmb();
 
-	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
+	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
 
 	mmiowb();
 
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
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 39af4f8..da18aa2 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2593,7 +2593,7 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
 	txdata->tx_db.data.prod += 2;
 	/* make sure descriptor update is observed by the HW */
 	wmb();
-	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
+	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
 
 	mmiowb();
 	barrier();
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af..146c40d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -3817,8 +3817,8 @@ static void bnx2x_sp_prod_update(struct bnx2x *bp)
 	 */
 	mb();
 
-	REG_WR16(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
-		 bp->spq_prod_idx);
+	REG_WR16_RELAXED(bp, BAR_XSTRORM_INTMEM + XSTORM_SPQ_PROD_OFFSET(func),
+			 bp->spq_prod_idx);
 	mmiowb();
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 76a4668..8e0a317 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -170,7 +170,9 @@ static int bnx2x_send_msg2pf(struct bnx2x *bp, u8 *done, dma_addr_t msg_mapping)
 	wmb();
 
 	/* Trigger the PF FW */
-	writeb(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+
+	mmiowb();
 
 	/* Wait for PF to complete */
 	while ((tout >= 0) && (!*done)) {
-- 
2.7.4
