Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id W/GdBItGGVtTOAAAmS7hNA
	; Thu, 07 Jun 2018 14:52:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3CFD608B8; Thu,  7 Jun 2018 14:52:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC970601C3;
	Thu,  7 Jun 2018 14:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC970601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935154AbeFGOwO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40902 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeFGOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:11 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbP-0005Zm-Es; Thu, 07 Jun 2018 15:09:23 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003GJ-89; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.870449909@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 367/410] net: systemport: Rewrite __bcm_sysport_tx_reclaim()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 484d802d0f2f29c335563fcac2a8facf174a1bbc upstream.

There is no need for complex checking between the last consumed index
and current consumed index, a simple subtraction will do.

This also eliminates the possibility of a permanent transmit queue stall
under the following conditions:

- one CPU bursts ring->size worth of traffic (up to 256 buffers), to the
  point where we run out of free descriptors, so we stop the transmit
  queue at the end of bcm_sysport_xmit()

- because of our locking, we have the transmit process disable
  interrupts which means we can be blocking the TX reclamation process

- when TX reclamation finally runs, we will be computing the difference
  between ring->c_index (last consumed index by SW) and what the HW
  reports through its register

- this register is masked with (ring->size - 1) = 0xff, which will lead
  to stripping the upper bits of the index (register is 16-bits wide)

- we will be computing last_tx_cn as 0, which means there is no work to
  be done, and we never wake-up the transmit queue, leaving it
  permanently disabled

A practical example is e.g: ring->c_index aka last_c_index = 12, we
pushed 256 entries, HW consumer index = 268, we mask it with 0xff = 12,
so last_tx_cn == 0, nothing happens.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 33 ++++++++++------------
 drivers/net/ethernet/broadcom/bcmsysport.h |  2 +-
 2 files changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -584,37 +584,33 @@ static unsigned int __bcm_sysport_tx_rec
 					     struct bcm_sysport_tx_ring *ring)
 {
 	struct net_device *ndev = priv->netdev;
-	unsigned int c_index, last_c_index, last_tx_cn, num_tx_cbs;
 	unsigned int pkts_compl = 0, bytes_compl = 0;
+	unsigned int txbds_processed = 0;
 	struct bcm_sysport_cb *cb;
+	unsigned int txbds_ready;
+	unsigned int c_index;
 	u32 hw_ind;
 
 	/* Compute how many descriptors have been processed since last call */
 	hw_ind = tdma_readl(priv, TDMA_DESC_RING_PROD_CONS_INDEX(ring->index));
 	c_index = (hw_ind >> RING_CONS_INDEX_SHIFT) & RING_CONS_INDEX_MASK;
-	ring->p_index = (hw_ind & RING_PROD_INDEX_MASK);
-
-	last_c_index = ring->c_index;
-	num_tx_cbs = ring->size;
-
-	c_index &= (num_tx_cbs - 1);
-
-	if (c_index >= last_c_index)
-		last_tx_cn = c_index - last_c_index;
-	else
-		last_tx_cn = num_tx_cbs - last_c_index + c_index;
+	txbds_ready = (c_index - ring->c_index) & RING_CONS_INDEX_MASK;
 
 	netif_dbg(priv, tx_done, ndev,
-			"ring=%d c_index=%d last_tx_cn=%d last_c_index=%d\n",
-			ring->index, c_index, last_tx_cn, last_c_index);
+		  "ring=%d old_c_index=%u c_index=%u txbds_ready=%u\n",
+		  ring->index, ring->c_index, c_index, txbds_ready);
 
-	while (last_tx_cn-- > 0) {
-		cb = ring->cbs + last_c_index;
+	while (txbds_processed < txbds_ready) {
+		cb = &ring->cbs[ring->clean_index];
 		bcm_sysport_tx_reclaim_one(priv, cb, &bytes_compl, &pkts_compl);
 
 		ring->desc_count++;
-		last_c_index++;
-		last_c_index &= (num_tx_cbs - 1);
+		txbds_processed++;
+
+		if (likely(ring->clean_index < ring->size - 1))
+			ring->clean_index++;
+		else
+			ring->clean_index = 0;
 	}
 
 	ring->c_index = c_index;
@@ -1036,6 +1032,7 @@ static int bcm_sysport_init_tx_ring(stru
 	netif_napi_add(priv->netdev, &ring->napi, bcm_sysport_tx_poll, 64);
 	ring->index = index;
 	ring->size = size;
+	ring->clean_index = 0;
 	ring->alloc_size = ring->size;
 	ring->desc_cpu = p;
 	ring->desc_count = ring->size;
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -624,7 +624,7 @@ struct bcm_sysport_tx_ring {
 	unsigned int	desc_count;	/* Number of descriptors */
 	unsigned int	curr_desc;	/* Current descriptor */
 	unsigned int	c_index;	/* Last consumer index */
-	unsigned int	p_index;	/* Current producer index */
+	unsigned int	clean_index;	/* Current clean index */
 	struct bcm_sysport_cb *cbs;	/* Transmit control blocks */
 	struct dma_desc	*desc_cpu;	/* CPU view of the descriptor */
 	struct bcm_sysport_priv *priv;	/* private context backpointer */
