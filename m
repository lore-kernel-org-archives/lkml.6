Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFDFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8627444
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QW5WVTRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC8627444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966501AbeF1OPN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:15:13 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:44960 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965985AbeF1OO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:14:59 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E062F10C0854;
        Thu, 28 Jun 2018 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530195299; bh=h6SB+9OzP1hNw++djUZMOmq2HZgdNVToZznDHbksHoo=;
        h=From:To:Cc:Subject:Date:From;
        b=QW5WVTRDzHrbGfp7/3kf6H2GRRZO/gPgkSQLJH8QjV57yMmOHBNBTyYbS+sQ/cWZO
         KUQZgITiHdIDCMU66TfPH1WaAQUJzsTScSRY0q78k5nVSZitxIB2OMZEdcjNOMgMO0
         GkzHUbfK2vj50nm4YYjqGy+opG/1Mu+xOBAO+ir41s/OOIOXl6zj3BD9KQu1ZmAZin
         yIewxrmA7LrNepeLiLLCtKIy2RnN9jMvBkcwFkPpuINywdNyxXw0gPdawTlh8xCTd0
         suUJS5oWrYYngp5gfYtj7XocB69ZEMUfUO3xz9vtEA7dK8DUefW9c7l921HTObpJro
         Cm1znXQXxw90w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.53])
        by mailhost.synopsys.com (Postfix) with ESMTP id 29BF95BF3;
        Thu, 28 Jun 2018 07:14:54 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC v2] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date:   Thu, 28 Jun 2018 17:14:52 +0300
Message-Id: <20180628141452.3585-1-Eugeniy.Paltsev@synopsys.com>
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


Changes v1->v2 (Thanks to Vineet and Christoph):
 * Panic if both IOC and HIGHMEM_ZONE are enabled.
 * Move arch_setup_dma_ops to arch/arc/mm/dma.c
 * Tweak the boot printing about IOC
 * Print info about cache ops used for each device.
 * Refactor arch_setup_dma_ops

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                   |  1 +
 arch/arc/boot/dts/hsdk.dts         |  4 ++++
 arch/arc/include/asm/dma-mapping.h | 13 +++++++++++++
 arch/arc/mm/cache.c                | 20 +++++---------------
 arch/arc/mm/dma.c                  | 32 +++++++++++++++++++-------------
 5 files changed, 42 insertions(+), 28 deletions(-)
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
index 9dbe645ee127..6d3234854461 100644
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
@@ -1152,6 +1143,9 @@ noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		panic("IOC and HIGHMEM can't be used simultaneously");
+
 	/* Flush + invalidate + disable L1 dcache */
 	__dc_disable();
 
@@ -1253,11 +1247,7 @@ void __init arc_cache_init_master(void)
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
index 8c1071840979..fbcb3428a7ab 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -19,6 +19,7 @@
 #include <linux/dma-noncoherent.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
+#include <linux/dma-mapping.h>
 
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
@@ -33,19 +34,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
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
@@ -140,3 +129,20 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
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

