Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887D2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/IJqG46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1887D2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeLAAdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:33:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeLAAde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hpjYjKudVjLUb7UHyn9+K/DV+bP8hobeo20A2psp+Ho=; b=A/IJqG46IKFXCPj+Hv2JWLMhPh
        ZNu+UTcRYFnoSQwF9eSi35ACP0gTFqAH3ufN046HtohgLycaRQ7h8ogZProQExZ8qOSbQbcDdESw2
        W4p5vy11TFmwkHS0D6LFaaCATCitTjBQFiiXKjsDKHu+SMWmJdgppi11UBY63Bz1th3mWpKhsAKxk
        sumIQFXC5H1ILCOVnUMvLCCQBQt82nn+3fFYGTNN+e9nS29ElzUrkCDSnmYWN2G7BS27fMv5Myeyi
        9SuienavBWI+YdxJGB+ufMWKkqJoY8Kg3VZ+xbw7hpYHPgL/dgFqME1VfSwEKrfQYL1d2cWXkK0ZH
        pShpuhRg==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSim5-00058s-DF; Fri, 30 Nov 2018 13:24:05 +0000
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
Subject: [PATCH 22/23] dma-mapping: remove the mapping_error dma_map_ops method
Date:   Fri, 30 Nov 2018 14:22:30 +0100
Message-Id: <20181130132231.16512-23-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left except for vmd which just forwards it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/vmd.c | 6 ------
 include/linux/dma-mapping.h  | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e50b0b5815ff..98ce79eac128 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -394,11 +394,6 @@ static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	vmd_dma_ops(dev)->sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
 }
 
-static int vmd_mapping_error(struct device *dev, dma_addr_t addr)
-{
-	return vmd_dma_ops(dev)->mapping_error(to_vmd_dev(dev), addr);
-}
-
 static int vmd_dma_supported(struct device *dev, u64 mask)
 {
 	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
@@ -446,7 +441,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
 	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
 	add_dma_domain(domain);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 46bd612d929e..2adef56c6069 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -128,7 +128,6 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
 			enum dma_data_direction direction);
-	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 };
@@ -575,15 +574,9 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 	debug_dma_mapping_error(dev, dma_addr);
-
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return 1;
-
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
 	return 0;
 }
 
-- 
2.19.1

