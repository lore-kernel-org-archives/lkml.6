Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE452084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE452084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeGTNPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:15:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbeGTNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D436BB6;
        Fri, 20 Jul 2018 12:27:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Meelis Roos <mroos@linux.ee>,
        Mathieu Malaterre <malat@debian.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 16/31] net: sungem: fix rx checksum support
Date:   Fri, 20 Jul 2018 14:13:46 +0200
Message-Id: <20180720121340.740217924@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 12b03558cef6d655d0d394f5e98a6fd07c1f6c0f ]

After commit 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE
are friends"), sungem owners reported the infamous "eth0: hw csum failure"
message.

CHECKSUM_COMPLETE has in fact never worked for this driver, but this
was masked by the fact that upper stacks had to strip the FCS, and
therefore skb->ip_summed was set back to CHECKSUM_NONE before
my recent change.

Driver configures a number of bytes to skip when the chip computes
the checksum, and for some reason only half of the Ethernet header
was skipped.

Then a second problem is that we should strip the FCS by default,
unless the driver is updated to eventually support NETIF_F_RXFCS in
the future.

Finally, a driver should check if NETIF_F_RXCSUM feature is enabled
or not, so that the admin can turn off rx checksum if wanted.

Many thanks to Andreas Schwab and Mathieu Malaterre for their
help in debugging this issue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Mathieu Malaterre <malat@debian.org>
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Tested-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/sungem.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -60,8 +60,7 @@
 #include <linux/sungem_phy.h>
 #include "sungem.h"
 
-/* Stripping FCS is causing problems, disabled for now */
-#undef STRIP_FCS
+#define STRIP_FCS
 
 #define DEFAULT_MSG	(NETIF_MSG_DRV		| \
 			 NETIF_MSG_PROBE	| \
@@ -435,7 +434,7 @@ static int gem_rxmac_reset(struct gem *g
 	writel(desc_dma & 0xffffffff, gp->regs + RXDMA_DBLOW);
 	writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
 	val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
-	       ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
+	       (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
 	writel(val, gp->regs + RXDMA_CFG);
 	if (readl(gp->regs + GREG_BIFCFG) & GREG_BIFCFG_M66EN)
 		writel(((5 & RXDMA_BLANK_IPKTS) |
@@ -760,7 +759,6 @@ static int gem_rx(struct gem *gp, int wo
 	struct net_device *dev = gp->dev;
 	int entry, drops, work_done = 0;
 	u32 done;
-	__sum16 csum;
 
 	if (netif_msg_rx_status(gp))
 		printk(KERN_DEBUG "%s: rx interrupt, done: %d, rx_new: %d\n",
@@ -855,9 +853,13 @@ static int gem_rx(struct gem *gp, int wo
 			skb = copy_skb;
 		}
 
-		csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
-		skb->csum = csum_unfold(csum);
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (likely(dev->features & NETIF_F_RXCSUM)) {
+			__sum16 csum;
+
+			csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
+			skb->csum = csum_unfold(csum);
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 		skb->protocol = eth_type_trans(skb, gp->dev);
 
 		napi_gro_receive(&gp->napi, skb);
@@ -1755,7 +1757,7 @@ static void gem_init_dma(struct gem *gp)
 	writel(0, gp->regs + TXDMA_KICK);
 
 	val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
-	       ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
+	       (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
 	writel(val, gp->regs + RXDMA_CFG);
 
 	writel(desc_dma >> 32, gp->regs + RXDMA_DBHI);
@@ -2973,8 +2975,8 @@ static int gem_init_one(struct pci_dev *
 	pci_set_drvdata(pdev, dev);
 
 	/* We can do scatter/gather and HW checksum */
-	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM;
-	dev->features |= dev->hw_features | NETIF_F_RXCSUM;
+	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+	dev->features = dev->hw_features;
 	if (pci_using_dac)
 		dev->features |= NETIF_F_HIGHDMA;
 


