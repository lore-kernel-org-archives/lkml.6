Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EAE20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZxeBAq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EAE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeGaTB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:01:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbeGaTB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/J/HGUgyOH5vfRsukQGVXjDLuxynaYtDJFq081fABsQ=; b=pZxeBAq199lcK2J9QmFHBlklv
        LUmSOWLDGCAbUMsvxHNZytNfMLcIDxeZGzC+0k7Nk4Tmqm2xpAKTnE5o6I5p+xjZoXV9HjqV0pSxG
        OrtVH5nRjEv1jB+tOKE/vaWBtAkaU8gESPqQMgbAorjKzyy0KlW6dgeQsAccriWt5RDsByR1cdiYm
        8xiDjReUyLbWlVxEsrjJTkpJFVzEDkQUP9KsjG/4Wcu/qIaXb0HQb0Wq3Dp2InlKtqzBwjNMnwDyL
        XYqhZaTaze91GkP+M9f39Or0bJP7cLVpK5aXfR7715qtjwaXNSZxuqfnPf/Kjpd9vmDFtN2ORaoyk
        IQ1ELFdnw==;
Received: from 089144203113.atnat0012.highway.a1.net ([89.144.203.113] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkYK6-0002IF-7g; Tue, 31 Jul 2018 17:20:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH] ia64: fix barrier placement for write* / dma mapping
Date:   Tue, 31 Jul 2018 19:20:31 +0200
Message-Id: <20180731172031.4447-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731172031.4447-1-hch@lst.de>
References: <20180731172031.4447-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory-barriers.txt has been updated with the following requirement.

"When using writel(), a prior wmb() is not needed to guarantee that the
cache coherent memory writes have completed before writing to the MMIO
region."

The current writeX() and iowriteX() implementations on ia64 are not
satisfying this requirement as the barrier is after the register write.

This adds the missing memory barriers, and instead drops them from the
dma sync routine where they are misplaced (and were missing in the
more important map/unmap cases anyway).

All this doesn't affect the SN2 platform, which already has barrier
in the I/O accessors, and none in dma mapping (but then again
swiotlb doesn't have any either).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c     |  4 ----
 arch/ia64/include/asm/dma-mapping.h |  5 -----
 arch/ia64/include/asm/io.h          |  5 +++++
 arch/ia64/kernel/machvec.c          | 16 ----------------
 arch/ia64/kernel/pci-dma.c          |  5 -----
 5 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index ee5b652d320a..e8da6503ed2f 100644
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
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index fb0651961e2c..ba5523b67eaf 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -22,6 +22,7 @@
 
 #include <asm/unaligned.h>
 #include <asm/early_ioremap.h>
+#include <asm/barrier.h>
 
 /* We don't use IO slowdowns on the ia64, but.. */
 #define __SLOW_DOWN_IO	do { } while (0)
@@ -345,24 +346,28 @@ ___ia64_readq (const volatile void __iomem *addr)
 static inline void
 __writeb (unsigned char val, volatile void __iomem *addr)
 {
+	mb();
 	*(volatile unsigned char __force *) addr = val;
 }
 
 static inline void
 __writew (unsigned short val, volatile void __iomem *addr)
 {
+	mb();
 	*(volatile unsigned short __force *) addr = val;
 }
 
 static inline void
 __writel (unsigned int val, volatile void __iomem *addr)
 {
+	mb();
 	*(volatile unsigned int __force *) addr = val;
 }
 
 static inline void
 __writeq (unsigned long val, volatile void __iomem *addr)
 {
+	mb();
 	*(volatile unsigned long __force *) addr = val;
 }
 
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
index 3c2884bef3d4..2512aa3029f5 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -55,11 +55,6 @@ void __init pci_iommu_alloc(void)
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

