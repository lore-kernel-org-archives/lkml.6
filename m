Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ABC20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ABC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbeGTN1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeGTN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3938ED29;
        Fri, 20 Jul 2018 12:36:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 014/101] ixgbe: split XDP_TX tail and XDP_REDIRECT map flushing
Date:   Fri, 20 Jul 2018 14:13:20 +0200
Message-Id: <20180720121423.545934539@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit ad088ec480768850db019a5cc543685e868a513d ]

The driver was combining the XDP_TX tail flush and XDP_REDIRECT
map flushing (xdp_do_flush_map).  This is suboptimal, these two
flush operations should be kept separate.

Fixes: 11393cc9b9be ("xdp: Add batching support to redirect map")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2257,9 +2257,10 @@ static struct sk_buff *ixgbe_build_skb(s
 	return skb;
 }
 
-#define IXGBE_XDP_PASS 0
-#define IXGBE_XDP_CONSUMED 1
-#define IXGBE_XDP_TX 2
+#define IXGBE_XDP_PASS		0
+#define IXGBE_XDP_CONSUMED	BIT(0)
+#define IXGBE_XDP_TX		BIT(1)
+#define IXGBE_XDP_REDIR		BIT(2)
 
 static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
 			       struct xdp_buff *xdp);
@@ -2288,7 +2289,7 @@ static struct sk_buff *ixgbe_run_xdp(str
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
 		if (!err)
-			result = IXGBE_XDP_TX;
+			result = IXGBE_XDP_REDIR;
 		else
 			result = IXGBE_XDP_CONSUMED;
 		break;
@@ -2348,7 +2349,7 @@ static int ixgbe_clean_rx_irq(struct ixg
 	unsigned int mss = 0;
 #endif /* IXGBE_FCOE */
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
-	bool xdp_xmit = false;
+	unsigned int xdp_xmit = 0;
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
@@ -2391,8 +2392,10 @@ static int ixgbe_clean_rx_irq(struct ixg
 		}
 
 		if (IS_ERR(skb)) {
-			if (PTR_ERR(skb) == -IXGBE_XDP_TX) {
-				xdp_xmit = true;
+			unsigned int xdp_res = -PTR_ERR(skb);
+
+			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
+				xdp_xmit |= xdp_res;
 				ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
 			} else {
 				rx_buffer->pagecnt_bias++;
@@ -2464,7 +2467,10 @@ static int ixgbe_clean_rx_irq(struct ixg
 		total_rx_packets++;
 	}
 
-	if (xdp_xmit) {
+	if (xdp_xmit & IXGBE_XDP_REDIR)
+		xdp_do_flush_map();
+
+	if (xdp_xmit & IXGBE_XDP_TX) {
 		struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
 
 		/* Force memory writes to complete before letting h/w
@@ -2472,8 +2478,6 @@ static int ixgbe_clean_rx_irq(struct ixg
 		 */
 		wmb();
 		writel(ring->next_to_use, ring->tail);
-
-		xdp_do_flush_map();
 	}
 
 	u64_stats_update_begin(&rx_ring->syncp);


