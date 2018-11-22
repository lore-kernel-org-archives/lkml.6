Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ADC04EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DBE20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNwPGNUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DBE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437251AbeKWAno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeKWAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iD/dRc9UIv9SfqvzdC8Dc4U8+KY0iTA1zzLpZCyDmfU=; b=fNwPGNUALylryXuMR7mrWot3JL
        EzsQChgXsw0SPQkNVpF+eVJtXImr47FWb05HWImcohAewvuG9XDjOWpsgcg8PNTGazy79u8qnqKJm
        uVWLwtkizZpljbE+BkWLaFo2kdQ6/rsFRU5Q0y4goRQ5YHl3WfRcOxPceGyFRzTJ/sDCKjgI7k3yO
        tBJ/haN6nPoZG+r630fU/m5l8VZJp/06aJqC/5yh8J9qydk+xZ/Hv8eZEN7cFR79UrYKb/CbotEZ2
        zvfMMi1CaN+hZSt92Rgiv7/auyh2Sc+okOOpzWHIH8w93BT1JijI8prdIbASAOxfPBhA3Htv1UAGq
        aUWLveMg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaN-0008Pb-Qy; Thu, 22 Nov 2018 14:04:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/24] alpha: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:09 +0100
Message-Id: <20181122140320.24080-14-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/pci_iommu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 46e08e0d9181..e1716e0d92fd 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -291,7 +291,7 @@ pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	   use direct_map above, it now must be considered an error. */
 	if (! alpha_mv.mv_pci_tbi) {
 		printk_once(KERN_WARNING "pci_map_single: no HW sg\n");
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 
 	arena = hose->sg_pci;
@@ -307,7 +307,7 @@ pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	if (dma_ofs < 0) {
 		printk(KERN_WARNING "pci_map_single failed: "
 		       "could not allocate dma page tables\n");
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 
 	paddr &= PAGE_MASK;
@@ -455,7 +455,7 @@ static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
 	memset(cpu_addr, 0, size);
 
 	*dma_addrp = pci_map_single_1(pdev, cpu_addr, size, 0);
-	if (*dma_addrp == 0) {
+	if (*dma_addrp == DMA_MAPPING_ERROR) {
 		free_pages((unsigned long)cpu_addr, order);
 		if (alpha_mv.mv_pci_tbi || (gfp & GFP_DMA))
 			return NULL;
@@ -671,7 +671,7 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 		sg->dma_address
 		  = pci_map_single_1(pdev, SG_ENT_VIRT_ADDRESS(sg),
 				     sg->length, dac_allowed);
-		return sg->dma_address != 0;
+		return sg->dma_address != DMA_MAPPING_ERROR;
 	}
 
 	start = sg;
@@ -935,11 +935,6 @@ iommu_unbind(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 	return 0;
 }
 
-static int alpha_pci_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == 0;
-}
-
 const struct dma_map_ops alpha_pci_ops = {
 	.alloc			= alpha_pci_alloc_coherent,
 	.free			= alpha_pci_free_coherent,
@@ -947,7 +942,6 @@ const struct dma_map_ops alpha_pci_ops = {
 	.unmap_page		= alpha_pci_unmap_page,
 	.map_sg			= alpha_pci_map_sg,
 	.unmap_sg		= alpha_pci_unmap_sg,
-	.mapping_error		= alpha_pci_mapping_error,
 	.dma_supported		= alpha_pci_supported,
 };
 EXPORT_SYMBOL(alpha_pci_ops);
-- 
2.19.1

