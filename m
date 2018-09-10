Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/VedcAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDC92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeIJLGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:06:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gd+verPlV6yo+9vk4NAP7mzpmX8+Jpz+v1SQKDDpUJY=; b=M/VedcAJJuoiiPa1kunjQRAIH
        O24aqy082FPzysNuavL8aZ67MyDXWgTgL+dAwH3LEQ+nH2/NQiFMasx4L8RAv9y6A5smGQcIlCazs
        TQERiPTJMPR+2MGqB7DgSksMvuDRT6YuahX6oLqtu5imIm4IarsvGWSHnWrTosNNypPitwgH0ytyS
        xDN5eZSK3TFGbww9WDGAT6j8ewijBios6hoIeHXINL7VS+alU206YoPayR9AppGY8KJPqW+2WJ58H
        pwnrvpSPGNxmZNJ7fse9zcTcKX/agsiALhYa+A66OyZFOIbMmTlpMPksPp2LOdRQGal+sFeDr/qSX
        ilvuEVskA==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFS5-00021w-Se; Mon, 10 Sep 2018 06:13:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-mapping: make the get_required_mask method available unconditionally
Date:   Mon, 10 Sep 2018 08:13:30 +0200
Message-Id: <20180910061332.28187-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This save some duplication for ia64.  In the long run this method will
need some additional work including moving over to kernel/dma, but that
will require some additional prep work, so let's do this minimal change
for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/dma-mapping.h  |  2 --
 arch/ia64/include/asm/machvec.h      |  7 -------
 arch/ia64/include/asm/machvec_init.h |  1 -
 arch/ia64/include/asm/machvec_sn2.h  |  2 --
 arch/ia64/pci/pci.c                  | 26 --------------------------
 arch/ia64/sn/pci/pci_dma.c           |  4 ++--
 drivers/base/platform.c              | 17 +++++++++++++++--
 drivers/pci/controller/vmd.c         |  4 ----
 include/linux/dma-direct.h           |  1 +
 include/linux/dma-mapping.h          |  2 --
 10 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 76e4d6632d68..522745ae67bb 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -10,8 +10,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
-#define ARCH_HAS_DMA_GET_REQUIRED_MASK
-
 extern const struct dma_map_ops *dma_ops;
 extern struct ia64_machine_vector ia64_mv;
 extern void set_iommu_machvec(void);
diff --git a/arch/ia64/include/asm/machvec.h b/arch/ia64/include/asm/machvec.h
index 267f4f170191..5133739966bc 100644
--- a/arch/ia64/include/asm/machvec.h
+++ b/arch/ia64/include/asm/machvec.h
@@ -44,7 +44,6 @@ typedef void ia64_mv_kernel_launch_event_t(void);
 
 /* DMA-mapping interface: */
 typedef void ia64_mv_dma_init (void);
-typedef u64 ia64_mv_dma_get_required_mask (struct device *);
 typedef const struct dma_map_ops *ia64_mv_dma_get_ops(struct device *);
 
 /*
@@ -127,7 +126,6 @@ extern void machvec_tlb_migrate_finish (struct mm_struct *);
 #  define platform_global_tlb_purge	ia64_mv.global_tlb_purge
 #  define platform_tlb_migrate_finish	ia64_mv.tlb_migrate_finish
 #  define platform_dma_init		ia64_mv.dma_init
-#  define platform_dma_get_required_mask ia64_mv.dma_get_required_mask
 #  define platform_dma_get_ops		ia64_mv.dma_get_ops
 #  define platform_irq_to_vector	ia64_mv.irq_to_vector
 #  define platform_local_vector_to_irq	ia64_mv.local_vector_to_irq
@@ -171,7 +169,6 @@ struct ia64_machine_vector {
 	ia64_mv_global_tlb_purge_t *global_tlb_purge;
 	ia64_mv_tlb_migrate_finish_t *tlb_migrate_finish;
 	ia64_mv_dma_init *dma_init;
-	ia64_mv_dma_get_required_mask *dma_get_required_mask;
 	ia64_mv_dma_get_ops *dma_get_ops;
 	ia64_mv_irq_to_vector *irq_to_vector;
 	ia64_mv_local_vector_to_irq *local_vector_to_irq;
@@ -211,7 +208,6 @@ struct ia64_machine_vector {
 	platform_global_tlb_purge,		\
 	platform_tlb_migrate_finish,		\
 	platform_dma_init,			\
-	platform_dma_get_required_mask,		\
 	platform_dma_get_ops,			\
 	platform_irq_to_vector,			\
 	platform_local_vector_to_irq,		\
@@ -286,9 +282,6 @@ extern const struct dma_map_ops *dma_get_ops(struct device *);
 #ifndef platform_dma_get_ops
 # define platform_dma_get_ops		dma_get_ops
 #endif
-#ifndef platform_dma_get_required_mask
-# define  platform_dma_get_required_mask	ia64_dma_get_required_mask
-#endif
 #ifndef platform_irq_to_vector
 # define platform_irq_to_vector		__ia64_irq_to_vector
 #endif
diff --git a/arch/ia64/include/asm/machvec_init.h b/arch/ia64/include/asm/machvec_init.h
index 2b32fd06b7c6..2aafb69a3787 100644
--- a/arch/ia64/include/asm/machvec_init.h
+++ b/arch/ia64/include/asm/machvec_init.h
@@ -4,7 +4,6 @@
 
 extern ia64_mv_send_ipi_t ia64_send_ipi;
 extern ia64_mv_global_tlb_purge_t ia64_global_tlb_purge;
-extern ia64_mv_dma_get_required_mask ia64_dma_get_required_mask;
 extern ia64_mv_irq_to_vector __ia64_irq_to_vector;
 extern ia64_mv_local_vector_to_irq __ia64_local_vector_to_irq;
 extern ia64_mv_pci_get_legacy_mem_t ia64_pci_get_legacy_mem;
diff --git a/arch/ia64/include/asm/machvec_sn2.h b/arch/ia64/include/asm/machvec_sn2.h
index ece9fa85be88..b5153d300289 100644
--- a/arch/ia64/include/asm/machvec_sn2.h
+++ b/arch/ia64/include/asm/machvec_sn2.h
@@ -55,7 +55,6 @@ extern ia64_mv_readb_t __sn_readb_relaxed;
 extern ia64_mv_readw_t __sn_readw_relaxed;
 extern ia64_mv_readl_t __sn_readl_relaxed;
 extern ia64_mv_readq_t __sn_readq_relaxed;
-extern ia64_mv_dma_get_required_mask	sn_dma_get_required_mask;
 extern ia64_mv_dma_init			sn_dma_init;
 extern ia64_mv_migrate_t		sn_migrate;
 extern ia64_mv_kernel_launch_event_t	sn_kernel_launch_event;
@@ -100,7 +99,6 @@ extern ia64_mv_pci_fixup_bus_t		sn_pci_fixup_bus;
 #define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
 #define platform_pci_legacy_read	sn_pci_legacy_read
 #define platform_pci_legacy_write	sn_pci_legacy_write
-#define platform_dma_get_required_mask	sn_dma_get_required_mask
 #define platform_dma_init		sn_dma_init
 #define platform_migrate		sn_migrate
 #define platform_kernel_launch_event    sn_kernel_launch_event
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7ccc64d5fe3e..5d71800df431 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -568,32 +568,6 @@ static void __init set_pci_dfl_cacheline_size(void)
 	pci_dfl_cache_line_size = (1 << cci.pcci_line_size) / 4;
 }
 
-u64 ia64_dma_get_required_mask(struct device *dev)
-{
-	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
-	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
-	u64 mask;
-
-	if (!high_totalram) {
-		/* convert to mask just covering totalram */
-		low_totalram = (1 << (fls(low_totalram) - 1));
-		low_totalram += low_totalram - 1;
-		mask = low_totalram;
-	} else {
-		high_totalram = (1 << (fls(high_totalram) - 1));
-		high_totalram += high_totalram - 1;
-		mask = (((u64)high_totalram) << 32) + 0xffffffff;
-	}
-	return mask;
-}
-EXPORT_SYMBOL_GPL(ia64_dma_get_required_mask);
-
-u64 dma_get_required_mask(struct device *dev)
-{
-	return platform_dma_get_required_mask(dev);
-}
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
-
 static int __init pcibios_init(void)
 {
 	set_pci_dfl_cacheline_size();
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 74c934a997bb..96eb2567718a 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -344,11 +344,10 @@ static int sn_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
-u64 sn_dma_get_required_mask(struct device *dev)
+static u64 sn_dma_get_required_mask(struct device *dev)
 {
 	return DMA_BIT_MASK(64);
 }
-EXPORT_SYMBOL_GPL(sn_dma_get_required_mask);
 
 char *sn_pci_get_legacy_mem(struct pci_bus *bus)
 {
@@ -473,6 +472,7 @@ static struct dma_map_ops sn_dma_ops = {
 	.sync_sg_for_device	= sn_dma_sync_sg_for_device,
 	.mapping_error		= sn_dma_mapping_error,
 	.dma_supported		= sn_dma_supported,
+	.get_required_mask	= sn_dma_get_required_mask,
 };
 
 void sn_dma_init(void)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..a255fc8aa483 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1179,8 +1179,11 @@ int __init platform_bus_init(void)
 	return error;
 }
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
-u64 dma_get_required_mask(struct device *dev)
+/*
+ * TODO: should eventually move to dma-direct.c and be wired up explicitly,
+ * but that will require a little more work.
+ */
+u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
 	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
@@ -1198,6 +1201,16 @@ u64 dma_get_required_mask(struct device *dev)
 	}
 	return mask;
 }
+
+#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
+u64 dma_get_required_mask(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->get_required_mask)
+		return ops->get_required_mask(dev);
+	return dma_direct_get_required_mask(dev);
+}
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fd2dbd7eed7b..f31ed62d518c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -404,12 +404,10 @@ static int vmd_dma_supported(struct device *dev, u64 mask)
 	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
 }
 
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 static u64 vmd_get_required_mask(struct device *dev)
 {
 	return vmd_dma_ops(dev)->get_required_mask(to_vmd_dev(dev));
 }
-#endif
 
 static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
 {
@@ -450,9 +448,7 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
 	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
 	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
-#endif
 	add_dma_domain(domain);
 }
 #undef ASSIGN_VMD_DMA_OPS
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 8d9f33febde5..7c9c412923d9 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -64,6 +64,7 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long attrs);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+u64 dma_direct_get_required_mask(struct device *dev);
 int dma_direct_supported(struct device *dev, u64 mask);
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1db6a6b46d0d..546fa9d944ff 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,9 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
-#endif
 };
 
 extern const struct dma_map_ops dma_direct_ops;
-- 
2.18.0

