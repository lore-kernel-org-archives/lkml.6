Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16670ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hn4g/CnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC2D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGXLQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:16:24 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40130 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:16:23 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E9EFE10C0B30;
        Tue, 24 Jul 2018 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532427039; bh=jyT3ex7FyLJrxtqCR19UYjZ6/4R2QkIq0UtgAgSQEB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hn4g/CnVPR3gDFx6t4mZy/h1/L5y6BtQy0sBvcddxUv9IPGGeLQHUo0pDVnL9/R6d
         wzjd2Uo1vxYsggH/8qpNZky1C7/PSAnIQk6HITKhcWNs9aIEu7KRqj+ecGl2fWiWDN
         QqEAgwOZNrLyg3cTb4W5tomZjoUlPPpPW75ENkEhiqheoKLDUgGB1oWOKZ5DzNDajI
         0VYB8ICHayN9tpsZ9+bcRWOZEg8b/8CUUTWIvMPGBlzx4Rc5CXLfcRVnFzj9QPBdff
         6NbxHK3r/J2zkbdxmKBtygaAm88dhTLlGeiU1dfXNVd47BSezdaB7ewoH6PwrWpYkQ
         zpC4bbBGgatog==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3908B3333;
        Tue, 24 Jul 2018 03:10:38 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/4] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date:   Tue, 24 Jul 2018 13:09:59 +0300
Message-Id: <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARC HS processor provides an IOC port (I/O coherency bus
interface) that allows external devices such as DMA devices
to access memory through the cache hierarchy, providing
coherency between I/O transactions and the complete memory
hierarchy.

Some recent SoC with ARC HS (like HSDK) allow to select bus
port (IOC or non-IOC port) for connecting DMA devices in runtime.

With this patch we can use both HW-coherent and regular DMA
peripherals simultaneously.

For example we can connect Ethernet and SDIO controllers through
IOC port (so we don't need to need to maintain cache coherency
for these devices manualy. All cache sync ops will be nop)
And we can connect USB directly to RAM port (so we had to
maintain cache coherency manualy. Cache sync ops will be real
flush/invalidate operations)

Cache ops are set per-device and depends on "dma-coherent" device
tree property:
"dma_noncoherent_ops" are used if no "dma-coherent" property is
present (or IOC is disabled)
"dma_direct_ops" are used if "dma-coherent" property is present.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---

Changes RFC v2 -> PATCH v1:
 * Move device tree changes to separate patch. Add AXS103 device tree
   changes.
 * Don't check IOC status in arch_dma_free function (Thanks to Christoph)
 * Add panic for IOC + HIGHMEM in separate patch.

Changes RFC v1 -> RFC v2 (Thanks to Vineet and Christoph):
 * Panic if both IOC and HIGHMEM_ZONE are enabled.
 * Move arch_setup_dma_ops to arch/arc/mm/dma.c
 * Tweak the boot printing about IOC
 * Print info about cache ops used for each device.
 * Refactor arch_setup_dma_ops

 arch/arc/Kconfig                   |  1 +
 arch/arc/include/asm/dma-mapping.h | 13 +++++++++++++
 arch/arc/mm/cache.c                | 17 ++---------------
 arch/arc/mm/dma.c                  | 34 +++++++++++++++++++---------------
 4 files changed, 35 insertions(+), 30 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e81bcd271be7..0a2fcd2a8c32 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,6 +17,7 @@ config ARC
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..c946c0a83e76
--- /dev/null
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier:  GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#ifndef ASM_ARC_DMA_MAPPING_H
+#define ASM_ARC_DMA_MAPPING_H
+
+#include <asm-generic/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent);
+#define arch_setup_dma_ops arch_setup_dma_ops
+
+#endif
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 9dbe645ee127..34935ce38631 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -65,7 +65,7 @@ char *arc_cache_mumbojumbo(int c, char *buf, int len)
 
 	n += scnprintf(buf + n, len - n, "Peripherals\t: %#lx%s%s\n",
 		       perip_base,
-		       IS_AVAIL3(ioc_exists, ioc_enable, ", IO-Coherency "));
+		       IS_AVAIL3(ioc_exists, ioc_enable, ", per device IO-Coherency "));
 
 	return buf;
 }
@@ -896,15 +896,6 @@ static void __dma_cache_wback_slc(phys_addr_t start, unsigned long sz)
 	slc_op(start, sz, OP_FLUSH);
 }
 
-/*
- * DMA ops for systems with IOC
- * IOC hardware snoops all DMA traffic keeping the caches consistent with
- * memory - eliding need for any explicit cache maintenance of DMA buffers
- */
-static void __dma_cache_wback_inv_ioc(phys_addr_t start, unsigned long sz) {}
-static void __dma_cache_inv_ioc(phys_addr_t start, unsigned long sz) {}
-static void __dma_cache_wback_ioc(phys_addr_t start, unsigned long sz) {}
-
 /*
  * Exported DMA API
  */
@@ -1253,11 +1244,7 @@ void __init arc_cache_init_master(void)
 	if (is_isa_arcv2() && ioc_enable)
 		arc_ioc_setup();
 
-	if (is_isa_arcv2() && ioc_enable) {
-		__dma_cache_wback_inv = __dma_cache_wback_inv_ioc;
-		__dma_cache_inv = __dma_cache_inv_ioc;
-		__dma_cache_wback = __dma_cache_wback_ioc;
-	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {
+	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
 		__dma_cache_wback_inv = __dma_cache_wback_inv_slc;
 		__dma_cache_inv = __dma_cache_inv_slc;
 		__dma_cache_wback = __dma_cache_wback_slc;
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 8c1071840979..b693818cd8e5 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (!page)
 		return NULL;
 
-	/*
-	 * IOC relies on all data (even coherent DMA data) being in cache
-	 * Thus allocate normal cached memory
-	 *
-	 * The gains with IOC are two pronged:
-	 *   -For streaming data, elides need for cache maintenance, saving
-	 *    cycles in flush code, and bus bandwidth as all the lines of a
-	 *    buffer need to be flushed out to memory
-	 *   -For coherent data, Read/Write to buffers terminate early in cache
-	 *   (vs. always going to memory - thus are faster)
-	 */
-	if ((is_isa_arcv2() && ioc_enable) ||
-	    (attrs & DMA_ATTR_NON_CONSISTENT))
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
 		need_coh = 0;
 
 	/*
@@ -95,8 +83,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	struct page *page = virt_to_page(paddr);
 	int is_non_coh = 1;
 
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT) ||
-			(is_isa_arcv2() && ioc_enable);
+	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
 
 	if (PageHighMem(page) || !is_non_coh)
 		iounmap((void __force __iomem *)vaddr);
@@ -140,3 +127,20 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 {
 	dma_cache_inv(paddr, size);
 }
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	/*
+	 * IOC hardware snoops all DMA traffic keeping the caches consistent
+	 * with memory - eliding need for any explicit cache maintenance of
+	 * DMA buffers - so we can use dma_direct cache ops.
+	 */
+	if (is_isa_arcv2() && ioc_enable && coherent) {
+		set_dma_ops(dev, &dma_direct_ops);
+		dev_info(dev, "use dma_direct_ops cache ops\n");
+	} else {
+		set_dma_ops(dev, &dma_noncoherent_ops);
+		dev_info(dev, "use dma_noncoherent_ops cache ops\n");
+	}
+}
-- 
2.14.4

