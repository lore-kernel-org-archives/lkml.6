Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164680AbeE1LC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164592AbeE1LCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 461/496] dpaa_eth: fix SG mapping
Date: Mon, 28 May 2018 12:04:06 +0200
Message-Id: <20180528100339.343435258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 120d75ecf043044554abbba8507f6d22e4715beb ]

An issue in the code mapping the skb fragments into
scatter-gather frames was evidentiated by netperf
TCP_SENDFILE tests. The size was set wrong for all
fragments but the first, affecting the transmission
of any skb with more than one fragment.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1930,8 +1930,10 @@ static int skb_to_sg_fd(struct dpaa_priv
 		goto csum_failed;
 	}
 
+	/* SGT[0] is used by the linear part */
 	sgt = (struct qm_sg_entry *)(sgt_buf + priv->tx_headroom);
-	qm_sg_entry_set_len(&sgt[0], skb_headlen(skb));
+	frag_len = skb_headlen(skb);
+	qm_sg_entry_set_len(&sgt[0], frag_len);
 	sgt[0].bpid = FSL_DPAA_BPID_INV;
 	sgt[0].offset = 0;
 	addr = dma_map_single(dev, skb->data,
@@ -1944,9 +1946,9 @@ static int skb_to_sg_fd(struct dpaa_priv
 	qm_sg_entry_set64(&sgt[0], addr);
 
 	/* populate the rest of SGT entries */
-	frag = &skb_shinfo(skb)->frags[0];
-	frag_len = frag->size;
-	for (i = 1; i <= nr_frags; i++, frag++) {
+	for (i = 0; i < nr_frags; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+		frag_len = frag->size;
 		WARN_ON(!skb_frag_page(frag));
 		addr = skb_frag_dma_map(dev, frag, 0,
 					frag_len, dma_dir);
@@ -1956,15 +1958,16 @@ static int skb_to_sg_fd(struct dpaa_priv
 			goto sg_map_failed;
 		}
 
-		qm_sg_entry_set_len(&sgt[i], frag_len);
-		sgt[i].bpid = FSL_DPAA_BPID_INV;
-		sgt[i].offset = 0;
+		qm_sg_entry_set_len(&sgt[i + 1], frag_len);
+		sgt[i + 1].bpid = FSL_DPAA_BPID_INV;
+		sgt[i + 1].offset = 0;
 
 		/* keep the offset in the address */
-		qm_sg_entry_set64(&sgt[i], addr);
-		frag_len = frag->size;
+		qm_sg_entry_set64(&sgt[i + 1], addr);
 	}
-	qm_sg_entry_set_f(&sgt[i - 1], frag_len);
+
+	/* Set the final bit in the last used entry of the SGT */
+	qm_sg_entry_set_f(&sgt[nr_frags], frag_len);
 
 	qm_fd_set_sg(fd, priv->tx_headroom, skb->len);
 
