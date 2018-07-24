Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47840C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E636A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7A0APkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E636A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeGXNIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:08:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbeGXNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GLMhO7THQNYQMGNR69BhDpHrUeAsFM6JGv9ROEpAST4=; b=N7A0APkITThTCD5T+K1EnSPdU
        X81Kh2ovusDeViuh3LCZE85IOTZaPlC+DHNZSJXiGbDYwoSekv+PcuCTkCFiWcAmOwcxqk4JeyQKF
        AkC/jBgnU6rxCBs6482oh15Q3NCS798XPIQu7ty9Y2FaHEvkLXDHX3rdFiO5ThF6ndGU0YkjWd1Dl
        5iIFome2CUc31vTEiTStCMtH/diILeEbW7iDbgtNPcdgJasKupnGW3fh3Sp8zXodWnqPfEEGoOOc+
        LgHWLO7+X3O+LYoqfR7WFiV9QeJCBWv7EnkQKG1sbKx8K5K6DoTMLprUn+RhZnOI08p/l3EA/lHGT
        9TwiKm2QA==;
Received: from 089144194224.atnat0003.highway.a1.net ([89.144.194.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhw0w-0001bi-K5; Tue, 24 Jul 2018 12:02:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Date:   Tue, 24 Jul 2018 14:01:46 +0200
Message-Id: <20180724120147.15096-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724120147.15096-1-hch@lst.de>
References: <20180724120147.15096-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of the file just contains platform device memory setup code which
is required for all builds, and half contains helpers for dma coherent
allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/Makefile       |  2 +-
 arch/sh/kernel/dma-coherent.c | 85 +++++++++++++++++++++++++++++++++++
 arch/sh/mm/consistent.c       | 80 ---------------------------------
 3 files changed, 86 insertions(+), 81 deletions(-)
 create mode 100644 arch/sh/kernel/dma-coherent.c

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index cb5f1bfb52de..d5ddb64bfffe 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
new file mode 100644
index 000000000000..763ba10fbd3e
--- /dev/null
+++ b/arch/sh/kernel/dma-coherent.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2004 - 2007  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/addrspace.h>
+
+void *dma_generic_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 unsigned long attrs)
+{
+	void *ret, *ret_nocache;
+	int order = get_order(size);
+
+	gfp |= __GFP_ZERO;
+
+	ret = (void *)__get_free_pages(gfp, order);
+	if (!ret)
+		return NULL;
+
+	/*
+	 * Pages from the page allocator may have data present in
+	 * cache. So flush the cache before using uncached memory.
+	 */
+	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
+
+	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
+	if (!ret_nocache) {
+		free_pages((unsigned long)ret, order);
+		return NULL;
+	}
+
+	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
+
+	*dma_handle = virt_to_phys(ret);
+	if (!WARN_ON(!dev))
+		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
+
+	return ret_nocache;
+}
+
+void dma_generic_free_coherent(struct device *dev, size_t size,
+			       void *vaddr, dma_addr_t dma_handle,
+			       unsigned long attrs)
+{
+	int order = get_order(size);
+	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
+	int k;
+
+	if (!WARN_ON(!dev))
+		pfn += dev->dma_pfn_offset;
+
+	for (k = 0; k < (1 << order); k++)
+		__free_pages(pfn_to_page(pfn + k), 0);
+
+	iounmap(vaddr);
+}
+
+void sh_sync_dma_for_device(void *vaddr, size_t size,
+		    enum dma_data_direction direction)
+{
+	void *addr = sh_cacheop_vaddr(vaddr);
+
+	switch (direction) {
+	case DMA_FROM_DEVICE:		/* invalidate only */
+		__flush_invalidate_region(addr, size);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		__flush_wback_region(addr, size);
+		break;
+	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
+		__flush_purge_region(addr, size);
+		break;
+	default:
+		BUG();
+	}
+}
+EXPORT_SYMBOL(sh_sync_dma_for_device);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 1622ae6b9dbd..792f36129062 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -1,10 +1,6 @@
 /*
- * arch/sh/mm/consistent.c
- *
  * Copyright (C) 2004 - 2007  Paul Mundt
  *
- * Declared coherent memory functions based on arch/x86/kernel/pci-dma_32.c
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -13,83 +9,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/gfp.h>
-#include <asm/cacheflush.h>
-#include <asm/addrspace.h>
-
-void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
-{
-	void *ret, *ret_nocache;
-	int order = get_order(size);
-
-	gfp |= __GFP_ZERO;
-
-	ret = (void *)__get_free_pages(gfp, order);
-	if (!ret)
-		return NULL;
-
-	/*
-	 * Pages from the page allocator may have data present in
-	 * cache. So flush the cache before using uncached memory.
-	 */
-	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
-
-	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
-	if (!ret_nocache) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
-	}
-
-	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
-
-	*dma_handle = virt_to_phys(ret);
-	if (!WARN_ON(!dev))
-		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
-
-	return ret_nocache;
-}
-
-void dma_generic_free_coherent(struct device *dev, size_t size,
-			       void *vaddr, dma_addr_t dma_handle,
-			       unsigned long attrs)
-{
-	int order = get_order(size);
-	unsigned long pfn = dma_handle >> PAGE_SHIFT;
-	int k;
-
-	if (!WARN_ON(!dev))
-		pfn += dev->dma_pfn_offset;
-
-	for (k = 0; k < (1 << order); k++)
-		__free_pages(pfn_to_page(pfn + k), 0);
-
-	iounmap(vaddr);
-}
-
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
-{
-	void *addr = sh_cacheop_vaddr(vaddr);
-
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		__flush_invalidate_region(addr, size);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__flush_wback_region(addr, size);
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		__flush_purge_region(addr, size);
-		break;
-	default:
-		BUG();
-	}
-}
 
 static int __init memchunk_setup(char *str)
 {
-- 
2.18.0

