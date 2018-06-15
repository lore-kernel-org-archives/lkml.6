Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DEA2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B7820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DnYqmkjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B7820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeFOM63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:58:29 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:55080 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936192AbeFOM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:58:27 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9FBF51E04A8;
        Fri, 15 Jun 2018 14:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529067505; bh=wr8dqsHixcmjiVVfYDGVjQ+tgHMIsloj4hRBtBfwBc8=;
        h=From:To:Cc:Subject:Date:From;
        b=DnYqmkjGAkhvlK5203Lu7TcAmbES9v9CJgsSk5LUSLGsfoZidHlT6LoPZVF3nLMp7
         CaTJY2mnvU8tHep9cDns816oqEqYqAZZu16D8VGhNYnLshCC1jcxSbQDwPdm06Qhlw
         v6jyazkhXHBJWO6wnUSbMtqND8S69bc+9dHZlBxio2vHKoD1zFTO7JS3zrpmWvOfd6
         DgBYr49QYuA+kFpegFE8PMaEhzgrySVE87uUprpWVLxi5EcGlsQYYt7U+QPrQUpemb
         C7PwzagIQmADqPkgn2GJJnBzQ2jClHyrf5dsUXCL7hq9CFzzHFmp8QDDdukXX+v/wP
         V6LeRVIRIq0JA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20A965894;
        Fri, 15 Jun 2018 05:58:22 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date:   Fri, 15 Jun 2018 15:58:19 +0300
Message-Id: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
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

For example we can connect USB and SDIO controllers through IOC port
(so we don't need to need to maintain cache coherency for these
devices manualy. All cache sync ops will be nop)
And we can connect Ethernet directly to RAM port (so we had to
maintain cache coherency manualy. Cache sync ops will be real
flush/invalidate operations)

Cache ops are set per-device and depends on "dma-coherent" device
tree property:
"dma_noncoherent_ops" are used if no "dma-coherent" property is
present (or IOC is disabled)
"dma_direct_ops" are used if "dma-coherent" property is present.


NOTE 1:
It works perfectly fine only if we don't have ZONE_HIGHMEM used
as IOC doesn't cover all physical memory. As for today It configured
to cover 1GiB starting from 0x8z (which is ZONE_NORMAL memory for
us). Transactions outside this region are sent on the non-coherent
I/O bus interface.
We can't configure IOC to cover all physical memory as it has several
limitations relating to aperture size and start address.

And if we get DMA buffer from ZONE_HIGHMEM memory we need to
do real flush/invalidate operations on that buffer, which is obviously
not done by "dma_direct_ops".

So I am not sure about "dma_direct_ops" using - probably we need to
create our special cache ops like "arc_ioc_ops" which will handle
ZONE_HIGHMEM case.

(BTW: current ARC dma_noncoherent_ops implementation also has same
problem if IOC and HIGHMEM are enabled.)


NOTE 2:
In this RFC only hsdk.dts changes are shown to reduce patch size.
AXS103 device tree changes are not shown.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                   |  1 +
 arch/arc/boot/dts/hsdk.dts         |  4 ++++
 arch/arc/include/asm/dma-mapping.h | 14 ++++++++++++++
 arch/arc/mm/Makefile               |  2 +-
 arch/arc/mm/cache.c                | 15 +--------------
 arch/arc/mm/dma-mapping.c          | 20 ++++++++++++++++++++
 arch/arc/mm/dma.c                  | 14 +-------------
 7 files changed, 42 insertions(+), 28 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h
 create mode 100644 arch/arc/mm/dma-mapping.c

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
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 006aa3de5348..ebb686c21393 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -176,6 +176,7 @@
 			phy-handle = <&phy0>;
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
+			dma-coherent;
 
 			mdio {
 				#address-cells = <1>;
@@ -194,12 +195,14 @@
 			compatible = "snps,hsdk-v1.0-ohci", "generic-ohci";
 			reg = <0x60000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		ehci@40000 {
 			compatible = "snps,hsdk-v1.0-ehci", "generic-ehci";
 			reg = <0x40000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		mmc@a000 {
@@ -212,6 +215,7 @@
 			clock-names = "biu", "ciu";
 			interrupts = <12>;
 			bus-width = <4>;
+			dma-coherent;
 		};
 	};
 
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..640a851bd331
--- /dev/null
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#ifndef ASM_ARC_DMA_MAPPING_H
+#define ASM_ARC_DMA_MAPPING_H
+
+#define arch_setup_dma_ops arch_setup_dma_ops
+
+#include <asm-generic/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent);
+
+#endif
diff --git a/arch/arc/mm/Makefile b/arch/arc/mm/Makefile
index 3703a4969349..45683897c27b 100644
--- a/arch/arc/mm/Makefile
+++ b/arch/arc/mm/Makefile
@@ -7,5 +7,5 @@
 #
 
 obj-y	:= extable.o ioremap.o dma.o fault.o init.o
-obj-y	+= tlb.o tlbex.o cache.o mmap.o
+obj-y	+= tlb.o tlbex.o cache.o mmap.o dma-mapping.o
 obj-$(CONFIG_HIGHMEM)	+= highmem.o
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 9dbe645ee127..c5d1f2a2c4da 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
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
diff --git a/arch/arc/mm/dma-mapping.c b/arch/arc/mm/dma-mapping.c
new file mode 100644
index 000000000000..9d0d310bbf5a
--- /dev/null
+++ b/arch/arc/mm/dma-mapping.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#include <linux/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	const struct dma_map_ops *dma_ops = &dma_noncoherent_ops;
+
+	/*
+	 * IOC hardware snoops all DMA traffic keeping the caches consistent
+	 * with memory - eliding need for any explicit cache maintenance of
+	 * DMA buffers - so we can use dma_direct cache ops.
+	 */
+	if (is_isa_arcv2() && ioc_enable && coherent)
+		dma_ops = &dma_direct_ops;
+
+	set_dma_ops(dev, dma_ops);
+}
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 8c1071840979..4fd130e786c7 100644
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
-- 
2.14.4

