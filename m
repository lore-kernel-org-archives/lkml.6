Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDA921523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gltf/4w1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDA921523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbeITNJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeITNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=urOa7+lWwo519+3QAN7mUc19CiVinIYrutfB3h0jYZk=; b=Gltf/4w1fTxSz+8A0K5SxfI2o
        dqp68efS/GEI90upcliYlvqbmC7M7CP62hjCOq5/Uh2CgLOrkkyGoJ550fsQy57ZZRgBafK+Mb6Co
        CD7kZ7f/eqNWkXji6rAg6Jic9tH7k2SuLdliTrY8vUSGnC/eznvLwjzYNp/ICtlJADo2KRp1T1mtV
        KkOUseNtC0dv/xGWG/XNGxbPKh7ajHjltYuI+gNl/cECN/+EpXhBKWrTmMkEbXfHcjo3+vcgPJcPh
        4NSR3NdwjxEzsLI+ci+TQQDPyrZt+T+6ZP6TUgvKG+hBNX5jlBK2xQrrTksmVlP88HlK+SwW+YDxP
        Y2rtORPVQ==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tN5-0002lR-Eb; Thu, 20 Sep 2018 07:27:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ia64: remove machvec_dma_sync_{single,sg}
Date:   Thu, 20 Sep 2018 09:26:59 +0200
Message-Id: <20180920072700.22396-9-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original form of these was added (to the HP zx1 platform only) by
the following bitkeeper commit (by the way of the historic.git tree):

commit 66b99421d118a5ddd98a72913670b0fcf0a38d45
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat Mar 13 17:05:37 2004 -0800

    [PATCH] DMA: Fill gaping hole in DMA API interfaces.

    From: "David S. Miller" <davem@redhat.com>

The commit does not explain why we'd need the memory barrier on ia64,
it never included the swiotlb or SGI IOMMU based platforms, and also
failed to address the map/unmap parts of the dma mapping interface,
which should provide the same ordering semantics and actually are
commonly used.  The conclusion of this is that they were added in
error and should be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c     |  4 ----
 arch/ia64/include/asm/dma-mapping.h |  5 -----
 arch/ia64/kernel/machvec.c          | 16 ----------------
 arch/ia64/kernel/pci-dma.c          |  5 -----
 4 files changed, 30 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 671ce1e3f6f2..e8a93b07283e 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2207,10 +2207,6 @@ const struct dma_map_ops sba_dma_ops = {
 	.unmap_page		= sba_unmap_page,
 	.map_sg			= sba_map_sg_attrs,
 	.unmap_sg		= sba_unmap_sg_attrs,
-	.sync_single_for_cpu	= machvec_dma_sync_single,
-	.sync_sg_for_cpu	= machvec_dma_sync_sg,
-	.sync_single_for_device	= machvec_dma_sync_single,
-	.sync_sg_for_device	= machvec_dma_sync_sg,
 	.dma_supported		= sba_dma_supported,
 	.mapping_error		= sba_dma_mapping_error,
 };
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 76e4d6632d68..2b8cd4a6d958 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -16,11 +16,6 @@ extern const struct dma_map_ops *dma_ops;
 extern struct ia64_machine_vector ia64_mv;
 extern void set_iommu_machvec(void);
 
-extern void machvec_dma_sync_single(struct device *, dma_addr_t, size_t,
-				    enum dma_data_direction);
-extern void machvec_dma_sync_sg(struct device *, struct scatterlist *, int,
-				enum dma_data_direction);
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return platform_dma_get_ops(NULL);
diff --git a/arch/ia64/kernel/machvec.c b/arch/ia64/kernel/machvec.c
index 7bfe98859911..1b604d02250b 100644
--- a/arch/ia64/kernel/machvec.c
+++ b/arch/ia64/kernel/machvec.c
@@ -73,19 +73,3 @@ machvec_timer_interrupt (int irq, void *dev_id)
 {
 }
 EXPORT_SYMBOL(machvec_timer_interrupt);
-
-void
-machvec_dma_sync_single(struct device *hwdev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction dir)
-{
-	mb();
-}
-EXPORT_SYMBOL(machvec_dma_sync_single);
-
-void
-machvec_dma_sync_sg(struct device *hwdev, struct scatterlist *sg, int n,
-		    enum dma_data_direction dir)
-{
-	mb();
-}
-EXPORT_SYMBOL(machvec_dma_sync_sg);
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index afb43677f9ca..5a5bf5a82ac2 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -41,11 +41,6 @@ void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
 
-	intel_dma_ops.sync_single_for_cpu = machvec_dma_sync_single;
-	intel_dma_ops.sync_sg_for_cpu = machvec_dma_sync_sg;
-	intel_dma_ops.sync_single_for_device = machvec_dma_sync_single;
-	intel_dma_ops.sync_sg_for_device = machvec_dma_sync_sg;
-
 	/*
 	 * The order of these functions is important for
 	 * fall-back/fail-over reasons
-- 
2.18.0

