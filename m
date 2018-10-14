Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B52C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B30A2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggz7NMd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B30A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJOB6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:58:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeJOB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qNa0DlUMZNio10PGjUwal7BTZqrTFZQbO5lv5O3KY0M=; b=ggz7NMd8wIObwWbqmjm0NNCV3
        tYCi1h2CqgWzcJYRWCyPFEnY6QruvP8wp8xMqTvxIc0Eh+w18W5ElP+EYEZ/mer664AXY69KuZ1AZ
        VBvoSyzQViIJT7GKcc+EJRXFeqLYsmq5EV3sWkZNUldpLNHHUN4VzROq0c4Pg0xYf+m8UPeIOYYEL
        N/Axk9N+7yzX3vL5PuOyzOMteAN3wsXFwq7aRmPCwG4cozjAUd2SCz27b4HRahY2dn4H5LGlHEltA
        nmHTvMcNKjhHNhjJRoo2sbxuFwXxMoCYtab/8FylYlmbGzwu5+dvzO+OnuehYWIA2Fwk90KhO7Bj7
        FDJLlvQRg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBkwf-0007xE-Rk; Sun, 14 Oct 2018 18:16:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     labbott@redhat.com, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: move the remap helpers to a separate file
Date:   Sun, 14 Oct 2018 20:16:51 +0200
Message-Id: <20181014181651.22971-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma remap code only really makes sense for not cache coherent
architectures, and currently is only used by arm, arm64 and xtensa.
Split it out into a separate file with a separate Kconfig symbol.

[Laura: you wrote this code back then, do you have a sensible
 copyright statement to add, given that the mapping.c statement
 obviously does not match your code that was written much later]

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig     |  1 +
 arch/arm64/Kconfig   |  1 +
 arch/xtensa/Kconfig  |  1 +
 kernel/dma/Kconfig   |  4 +++
 kernel/dma/Makefile  |  2 +-
 kernel/dma/mapping.c | 84 -------------------------------------------
 kernel/dma/remap.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 93 insertions(+), 85 deletions(-)
 create mode 100644 kernel/dma/remap.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..cf54e572dafd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,7 @@ config ARM
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_DIRECT_OPS if !MMU
+	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..179994b67d11 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -77,6 +77,7 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_OPS
+	select DMA_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9a7c654a7654..d57abe4cad0f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -10,6 +10,7 @@ config XTENSA
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_DIRECT_OPS
+	select DMA_REMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_SHOW
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 645c7a2ecde8..c92e08173ed8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -51,3 +51,7 @@ config SWIOTLB
 	bool
 	select DMA_DIRECT_OPS
 	select NEED_DMA_MAP_STATE
+
+config DMA_REMAP
+	depends on MMU
+	bool
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 7d581e4eea4a..f4feeceb8020 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
-
+obj-$(CONFIG_DMA_REMAP)			+= remap.o
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a92b7b..dfbc3deb95cd 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -262,87 +262,3 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 EXPORT_SYMBOL(dma_common_mmap);
-
-#ifdef CONFIG_MMU
-static struct vm_struct *__dma_common_pages_remap(struct page **pages,
-			size_t size, unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
-{
-	struct vm_struct *area;
-
-	area = get_vm_area_caller(size, vm_flags, caller);
-	if (!area)
-		return NULL;
-
-	if (map_vm_area(area, prot, pages)) {
-		vunmap(area->addr);
-		return NULL;
-	}
-
-	return area;
-}
-
-/*
- * remaps an array of PAGE_SIZE pages into another vm_area
- * Cannot be used in non-sleeping contexts
- */
-void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
-{
-	struct vm_struct *area;
-
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
-	if (!area)
-		return NULL;
-
-	area->pages = pages;
-
-	return area->addr;
-}
-
-/*
- * remaps an allocated contiguous region into another vm_area.
- * Cannot be used in non-sleeping contexts
- */
-
-void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
-			pgprot_t prot, const void *caller)
-{
-	int i;
-	struct page **pages;
-	struct vm_struct *area;
-
-	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
-	if (!pages)
-		return NULL;
-
-	for (i = 0; i < (size >> PAGE_SHIFT); i++)
-		pages[i] = nth_page(page, i);
-
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
-
-	kfree(pages);
-
-	if (!area)
-		return NULL;
-	return area->addr;
-}
-
-/*
- * unmaps a range previously mapped by dma_common_*_remap
- */
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
-{
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (!area || (area->flags & vm_flags) != vm_flags) {
-		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
-		return;
-	}
-
-	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
-	vunmap(cpu_addr);
-}
-#endif
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
new file mode 100644
index 000000000000..33dff4096d46
--- /dev/null
+++ b/kernel/dma/remap.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+static struct vm_struct *__dma_common_pages_remap(struct page **pages,
+			size_t size, unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area_caller(size, vm_flags, caller);
+	if (!area)
+		return NULL;
+
+	if (map_vm_area(area, prot, pages)) {
+		vunmap(area->addr);
+		return NULL;
+	}
+
+	return area;
+}
+
+/*
+ * remaps an array of PAGE_SIZE pages into another vm_area
+ * Cannot be used in non-sleeping contexts
+ */
+void *dma_common_pages_remap(struct page **pages, size_t size,
+			unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	if (!area)
+		return NULL;
+
+	area->pages = pages;
+
+	return area->addr;
+}
+
+/*
+ * Remaps an allocated contiguous region into another vm_area.
+ * Cannot be used in non-sleeping contexts
+ */
+void *dma_common_contiguous_remap(struct page *page, size_t size,
+			unsigned long vm_flags,
+			pgprot_t prot, const void *caller)
+{
+	int i;
+	struct page **pages;
+	struct vm_struct *area;
+
+	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	for (i = 0; i < (size >> PAGE_SHIFT); i++)
+		pages[i] = nth_page(page, i);
+
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+
+	kfree(pages);
+
+	if (!area)
+		return NULL;
+	return area->addr;
+}
+
+/*
+ * Unmaps a range previously mapped by dma_common_*_remap
+ */
+void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || (area->flags & vm_flags) != vm_flags) {
+		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
+		return;
+	}
+
+	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
+	vunmap(cpu_addr);
+}
-- 
2.19.1

