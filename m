Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05510C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2952086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tv1HCMgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2952086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeIJK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:58:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZRV///W/g0ll9ZGvdUDkLdphVAe6+VSHbWQZ8byZatw=; b=tv1HCMgZPqS5zH5KjtAtT+I9/
        z6ELvMMvPgvzhNnz7LAasa5jH9hRPeyMQa5LZG3tq7JAy7vmcUNjIM1EOf+aoTqTMyNNvaDux0aFJ
        Th6rnJPwusjOaK10PIwRp7TrdY69q7AgQIWB/PawhZ2yiSG5yDsolK51VUwt6olzdi/Wy3umYzS6L
        9qzEzPhEVwXo2z77da9ur5zB6VXYMzRR1UTHwifkPohgAnO1zLvVyEn5ln7Zd2PoKLJJ5F0Fp7DWM
        6y2YnEsDxa5tSCsDerfaHjGZRkEn9pkNaH4bGdIPA6jEoNarRsHfGfASeqvNcjc/gFZRR292LwgaW
        G57eZ0ZTA==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFKQ-00080f-AA; Mon, 10 Sep 2018 06:05:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct device
Date:   Mon, 10 Sep 2018 08:05:30 +0200
Message-Id: <20180910060533.27172-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910060533.27172-1-hch@lst.de>
References: <20180910060533.27172-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various architectures support both coherent and non-coherent dma on a
per-device basis.  Move the dma_noncoherent flag from the mips archdata
field to struct device proper to prepare the infrastructure for reuse on
other architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/Kconfig                     |  1 +
 arch/mips/include/asm/Kbuild          |  1 +
 arch/mips/include/asm/device.h        | 19 ----------------
 arch/mips/include/asm/dma-coherence.h |  6 +++++
 arch/mips/include/asm/dma-mapping.h   |  2 +-
 arch/mips/mm/dma-noncoherent.c        | 32 +++++----------------------
 include/linux/device.h                |  7 ++++++
 include/linux/dma-noncoherent.h       | 16 ++++++++++++++
 kernel/dma/Kconfig                    |  3 +++
 9 files changed, 41 insertions(+), 46 deletions(-)
 delete mode 100644 arch/mips/include/asm/device.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0b25180028b8..54c52bd0d9d3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1106,6 +1106,7 @@ config ARCH_SUPPORTS_UPROBES
 	bool
 
 config DMA_MAYBE_COHERENT
+	select ARCH_HAS_DMA_COHERENCE_H
 	select DMA_NONCOHERENT
 	bool
 
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 58351e48421e..9a81e72119da 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
 generic-y += current.h
+generic-y += device.h
 generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
 generic-y += export.h
diff --git a/arch/mips/include/asm/device.h b/arch/mips/include/asm/device.h
deleted file mode 100644
index 6aa796f1081a..000000000000
--- a/arch/mips/include/asm/device.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Arch specific extensions to struct device
- *
- * This file is released under the GPLv2
- */
-#ifndef _ASM_MIPS_DEVICE_H
-#define _ASM_MIPS_DEVICE_H
-
-struct dev_archdata {
-#ifdef CONFIG_DMA_PERDEV_COHERENT
-	/* Non-zero if DMA is coherent with CPU caches */
-	bool dma_coherent;
-#endif
-};
-
-struct pdev_archdata {
-};
-
-#endif /* _ASM_MIPS_DEVICE_H*/
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 8eda48748ed5..876ba0d14cde 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -20,6 +20,12 @@ enum coherent_io_user_state {
 #elif defined(CONFIG_DMA_MAYBE_COHERENT)
 extern enum coherent_io_user_state coherentio;
 extern int hw_coherentio;
+
+static inline int dev_is_dma_coherent(struct device *dev)
+{
+	return coherentio == IO_COHERENCE_ENABLED ||
+		(coherentio == IO_COHERENCE_DEFAULT && hw_coherentio);
+}
 #else
 #ifdef CONFIG_DMA_NONCOHERENT
 #define coherentio	IO_COHERENCE_DISABLED
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index e81c4e97ff1a..40d825c779de 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -25,7 +25,7 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      bool coherent)
 {
 #ifdef CONFIG_DMA_PERDEV_COHERENT
-	dev->archdata.dma_coherent = coherent;
+	dev->dma_coherent = coherent;
 #endif
 }
 
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 2aca1236af36..d408ac51f56c 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -14,26 +14,6 @@
 #include <asm/dma-coherence.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_DMA_PERDEV_COHERENT
-static inline int dev_is_coherent(struct device *dev)
-{
-	return dev->archdata.dma_coherent;
-}
-#else
-static inline int dev_is_coherent(struct device *dev)
-{
-	switch (coherentio) {
-	default:
-	case IO_COHERENCE_DEFAULT:
-		return hw_coherentio;
-	case IO_COHERENCE_ENABLED:
-		return 1;
-	case IO_COHERENCE_DISABLED:
-		return 0;
-	}
-}
-#endif /* CONFIG_DMA_PERDEV_COHERENT */
-
 /*
  * The affected CPUs below in 'cpu_needs_post_dma_flush()' can speculatively
  * fill random cachelines with stale data at any time, requiring an extra
@@ -49,7 +29,7 @@ static inline int dev_is_coherent(struct device *dev)
  */
 static inline bool cpu_needs_post_dma_flush(struct device *dev)
 {
-	if (dev_is_coherent(dev))
+	if (dev_is_dma_coherent(dev))
 		return false;
 
 	switch (boot_cpu_type()) {
@@ -76,7 +56,7 @@ void *arch_dma_alloc(struct device *dev, size_t size,
 	if (!ret)
 		return NULL;
 
-	if (!dev_is_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = (void *)UNCAC_ADDR(ret);
 	}
@@ -87,7 +67,7 @@ void *arch_dma_alloc(struct device *dev, size_t size,
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !dev_is_coherent(dev))
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !dev_is_dma_coherent(dev))
 		cpu_addr = (void *)CAC_ADDR((unsigned long)cpu_addr);
 	dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
 }
@@ -103,7 +83,7 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn;
 	int ret = -ENXIO;
 
-	if (!dev_is_coherent(dev))
+	if (!dev_is_dma_coherent(dev))
 		addr = CAC_ADDR(addr);
 
 	pfn = page_to_pfn(virt_to_page((void *)addr));
@@ -187,7 +167,7 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	if (!dev_is_coherent(dev))
+	if (!dev_is_dma_coherent(dev))
 		dma_sync_phys(paddr, size, dir);
 }
 
@@ -203,6 +183,6 @@ void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 {
 	BUG_ON(direction == DMA_NONE);
 
-	if (!dev_is_coherent(dev))
+	if (!dev_is_dma_coherent(dev))
 		dma_sync_virt(vaddr, size, direction);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..983506789402 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -927,6 +927,8 @@ struct dev_links_info {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
+ * @dma_coherent: this particular device is dma coherent, even if the
+ *		architecture supports non-coherent devices.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -1016,6 +1018,11 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	bool			dma_coherent:1;
+#endif
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index a0aa00cc909d..69630ec320be 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -4,6 +4,22 @@
 
 #include <linux/dma-mapping.h>
 
+#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
+#include <asm/dma-coherence.h>
+#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+static inline int dev_is_dma_coherent(struct device *dev)
+{
+	return dev->dma_coherent;
+}
+#else
+static inline int dev_is_dma_coherent(struct device *dev)
+{
+	return true;
+}
+#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..040859ac2a56 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool 64BIT || PHYS_ADDR_T_64BIT
 
+config ARCH_HAS_DMA_COHERENCE_H
+	bool
+
 config HAVE_GENERIC_DMA_COHERENT
 	bool
 
-- 
2.18.0

