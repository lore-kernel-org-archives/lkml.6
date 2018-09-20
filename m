Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9E321524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j18bvSbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9E321524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbeITNJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeITNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3WC6aLG7tShGJ7jiDjJnLHGZno8YyfuffVVLse3DJag=; b=j18bvSbhkX6+fGgJ7+oAbhu4a
        pNiynp2pzWxwwVLp2MBw3L1gO+MSbdBUfY0n5sI/jFAS7waT/GYkAAvHtD1ZQGdJ0rXat27BJyNWd
        fcuQETH0SP0fCOIuCP8tKHlzWfQRAtP2KumTWillbiZZucwTQdVpzH5Pr4N76fdMLZz0I7ESwpAqI
        IscjYdGE2gvXfyXORYOg4Yd/zzRwR0G0wLXpc34J8fl575Go6Wo4RIdsOCMw1KTH3+pUCF8mnanfi
        rOBgPB7prvQ5cu6XmHKMjr6FN+yr8oYRg2mAwPnKO9C/myhSHtMxPn9pwes85AcXjd4N1q9C1iSVZ
        tFAy7eqlA==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMo-0002eS-Ea; Thu, 20 Sep 2018 07:27:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] ia64: remove iommu_dma_supported
Date:   Thu, 20 Sep 2018 09:26:54 +0200
Message-Id: <20180920072700.22396-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic dma_direct_supported helper already used by intel-iommu on
x86 does a better job than the ia64 reimplementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c  | 13 -------------
 drivers/iommu/intel-iommu.c |  2 --
 2 files changed, 15 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 50b6ad282a90..3c2884bef3d4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -51,18 +51,6 @@ iommu_dma_init(void)
 	return;
 }
 
-int iommu_dma_supported(struct device *dev, u64 mask)
-{
-	/* Copied from i386. Doesn't make much sense, because it will
-	   only work for pci_alloc_coherent.
-	   The caller just has to use GFP_DMA in this case. */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-EXPORT_SYMBOL(iommu_dma_supported);
-
 void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
@@ -71,7 +59,6 @@ void __init pci_iommu_alloc(void)
 	intel_dma_ops.sync_sg_for_cpu = machvec_dma_sync_sg;
 	intel_dma_ops.sync_single_for_device = machvec_dma_sync_single;
 	intel_dma_ops.sync_sg_for_device = machvec_dma_sync_sg;
-	intel_dma_ops.dma_supported = iommu_dma_supported;
 
 	/*
 	 * The order of these functions is important for
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..e72efef97924 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3903,9 +3903,7 @@ const struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.mapping_error = intel_mapping_error,
-#ifdef CONFIG_X86
 	.dma_supported = dma_direct_supported,
-#endif
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.18.0

