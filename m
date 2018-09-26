Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA480214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA480214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeIZTf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:35:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59572 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbeIZTf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CB031A025F;
        Wed, 26 Sep 2018 15:22:58 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 801A21A004C;
        Wed, 26 Sep 2018 15:22:58 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DA739203C2;
        Wed, 26 Sep 2018 15:22:57 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 13/22] dpaa_eth: fix iova handling for contiguous frames
Date:   Wed, 26 Sep 2018 16:22:38 +0300
Message-Id: <20180926132247.10971-14-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The driver relies on the no longer valid assumption that dma addresses
(iovas) are identical to physical addressees and uses phys_to_virt() to
make iova -> vaddr conversions. Fix this by adding a function that does
proper iova -> phys conversions using the iommu api and update the code
to use it.
Also, a dma_unmap_single() call had to be moved further down the code
because iova -> vaddr conversions were required before the unmap.
For now only the contiguous frame case is handled and the SG case is
split in a following patch.
While at it, clean-up a redundant dpaa_bpid2pool() and pass the bp
as parameter.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ac9e50c8a556..e9e081c3f8cc 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -50,6 +50,7 @@
 #include <linux/highmem.h>
 #include <linux/percpu.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 #include <linux/sort.h>
 #include <soc/fsl/bman.h>
 #include <soc/fsl/qman.h>
@@ -1595,6 +1596,17 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
 	return 0;
 }
 
+static phys_addr_t dpaa_iova_to_phys(struct device *dev, dma_addr_t addr)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		return iommu_iova_to_phys(domain, addr);
+	else
+		return addr;
+}
+
 /* Cleanup function for outgoing frame descriptors that were built on Tx path,
  * either contiguous frames or scatter/gather ones.
  * Skb freeing is not handled here.
@@ -1617,7 +1629,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 	int nr_frags, i;
 	u64 ns;
 
-	skbh = (struct sk_buff **)phys_to_virt(addr);
+	skbh = (struct sk_buff **)phys_to_virt(dpaa_iova_to_phys(dev, addr));
 	skb = *skbh;
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
@@ -1687,25 +1699,21 @@ static u8 rx_csum_offload(const struct dpaa_priv *priv, const struct qm_fd *fd)
  * accommodate the shared info area of the skb.
  */
 static struct sk_buff *contig_fd_to_skb(const struct dpaa_priv *priv,
-					const struct qm_fd *fd)
+					const struct qm_fd *fd,
+					struct dpaa_bp *dpaa_bp,
+					void *vaddr)
 {
 	ssize_t fd_off = qm_fd_get_offset(fd);
-	dma_addr_t addr = qm_fd_addr(fd);
-	struct dpaa_bp *dpaa_bp;
 	struct sk_buff *skb;
-	void *vaddr;
 
-	vaddr = phys_to_virt(addr);
 	WARN_ON(!IS_ALIGNED((unsigned long)vaddr, SMP_CACHE_BYTES));
 
-	dpaa_bp = dpaa_bpid2pool(fd->bpid);
-	if (!dpaa_bp)
-		goto free_buffer;
-
 	skb = build_skb(vaddr, dpaa_bp->size +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (WARN_ONCE(!skb, "Build skb failure on Rx\n"))
-		goto free_buffer;
+	if (WARN_ONCE(!skb, "Build skb failure on Rx\n")) {
+		skb_free_frag(vaddr);
+		return NULL;
+	}
 	WARN_ON(fd_off != priv->rx_headroom);
 	skb_reserve(skb, fd_off);
 	skb_put(skb, qm_fd_get_length(fd));
@@ -1713,10 +1721,6 @@ static struct sk_buff *contig_fd_to_skb(const struct dpaa_priv *priv,
 	skb->ip_summed = rx_csum_offload(priv, fd);
 
 	return skb;
-
-free_buffer:
-	skb_free_frag(vaddr);
-	return NULL;
 }
 
 /* Build an skb with the data of the first S/G entry in the linear portion and
@@ -2302,12 +2306,12 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	if (!dpaa_bp)
 		return qman_cb_dqrr_consume;
 
-	dma_unmap_single(dpaa_bp->dev, addr, dpaa_bp->size, DMA_FROM_DEVICE);
-
 	/* prefetch the first 64 bytes of the frame or the SGT start */
-	vaddr = phys_to_virt(addr);
+	vaddr = phys_to_virt(dpaa_iova_to_phys(dpaa_bp->dev, addr));
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
+	dma_unmap_single(dpaa_bp->dev, addr, dpaa_bp->size, DMA_FROM_DEVICE);
+
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
@@ -2318,7 +2322,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	(*count_ptr)--;
 
 	if (likely(fd_format == qm_fd_contig))
-		skb = contig_fd_to_skb(priv, fd);
+		skb = contig_fd_to_skb(priv, fd, dpaa_bp, vaddr);
 	else
 		skb = sg_fd_to_skb(priv, fd);
 	if (!skb)
-- 
2.17.1

