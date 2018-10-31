Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC1ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF72420838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF72420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeJaTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:33:59 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:49407 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728102AbeJaTd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:33:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9VAaf6l095853;
        Wed, 31 Oct 2018 18:36:41 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 31 Oct 2018
 18:35:44 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>
CC:     <arnd@arndb.de>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <greentime@andestech.com>,
        <alankao@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <deanbo422@gmail.com>
Subject: [RFC 2/2] RISC-V: make dma_map_ops work without cache coherent agent
Date:   Wed, 31 Oct 2018 18:35:30 +0800
Message-ID: <1540982130-28248-3-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9VAaf6l095853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Currently, DMA operations in RISC-V ports assume the cache coherent
agent is supported. In other words, the functions in struct dma_map_ops
cannot work if the cache coherent agent is unsupported. In RISCV-NDS
extension ISA, the AndeStart RISC-V CPU provides a solution to overcome
this limitation.

  The AndeStart RISC-V CPU provides following two features so that the
functions of struct dma_map_ops can work without cache coherent agent.

  1. Non-cacheable memory
     In standard RISC-V, the memory cacheability is usually
  determined by the platform and there is no a particular scheme to
  adjust it by software at runtime. Hence, platform needs to allocate a
  fixed non-cacheable memory region for OS. This may cause some
  inconvenience and waste to the user. The feature provided by the
  AndeStar RISC-V CPU is that when the cache coherent agent is not
  supported, the user can arbitrarily disable the cacheability of a
  particular memory region at runtime. This feature separates the whole
  PA region is into 2 parts. The PA in higher part is the non-cacheable
  alias to the lower part. Hence, we can think the cacheability of
  targeted PA can be disabled by setting the MSB of physical address to 1.
  Based on this feature, user just requires a general memory and then
  binds the aliasing of the deriving PA in higher part to a new VA by
  io_reamp.

  2. Synchronize specific content between memory and cache
     The RISC-V generic ISA has instructions that allow the user to
  synchronize between cache and memory. However, the synchronized region
  can only be the entire cache. Therefore, the RISC-V generic ISA cannot
  handle the page synchronization required by the struct dma_map_ops.
  The extension ISA provided by the AndeStar RISC-V CPU has the ability
  to synchronize the contents of specific region between memory and
  cache.

  Due to feature requirements, we need to use custom SBI call to
derive the MSB of physical address from bbl. However, there is no
reserved SBI call for vendor in the current specification. Hence we use
a temporary method to send the vendor-defined SBI call in this commit.
We glad to change the implementation when determining the SBI usage for
vendor.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/include/asm/sbi.h                    |    1 +
 arch/riscv/vendor-nds/cache.c                   |   83 ++++++++
 arch/riscv/vendor-nds/include/asm/csr.h         |   32 +++
 arch/riscv/vendor-nds/include/asm/dma-mapping.h |   24 +++
 arch/riscv/vendor-nds/include/asm/proc.h        |   17 ++
 arch/riscv/vendor-nds/include/asm/sbi.h         |   17 ++
 arch/riscv/vendor-nds/noncoherent_dma.c         |  254 +++++++++++++++++++++++
 arch/riscv/vendor-nds/setup.c                   |    7 +
 8 files changed, 435 insertions(+), 0 deletions(-)
 create mode 100644 arch/riscv/vendor-nds/cache.c
 create mode 100644 arch/riscv/vendor-nds/include/asm/csr.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/dma-mapping.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/proc.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/sbi.h
 create mode 100644 arch/riscv/vendor-nds/noncoherent_dma.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5e1abf6..731fc38 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -26,6 +26,7 @@
 #define SBI_REMOTE_SFENCE_VMA_ASID 7
 #define SBI_SHUTDOWN 8
 #define SBI_GET_MVENDOR_ID 10
+#define SBI_XEXT_ARCH_RESERVED 0x80000000
 
 #define SBI_CALL(which, arg0, arg1, arg2) ({			\
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
diff --git a/arch/riscv/vendor-nds/cache.c b/arch/riscv/vendor-nds/cache.c
new file mode 100644
index 0000000..d9754ac
--- /dev/null
+++ b/arch/riscv/vendor-nds/cache.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Andes Technology Corporation
+#include <linux/irqflags.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/cacheinfo.h>
+#include <linux/sizes.h>
+#include <asm/csr.h>
+#include <asm/proc.h>
+
+
+DEFINE_PER_CPU(struct riscv_nds_cache_info, cpu_cache_info) = {
+	.init_done = 0,
+	.dcache_line_size = SZ_32
+};
+static void fill_cpu_cache_info(struct riscv_nds_cache_info *cpu_ci)
+{
+	struct cpu_cacheinfo *this_cpu_ci =
+			get_cpu_cacheinfo(smp_processor_id());
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	unsigned int i = 0;
+
+	for (; i < this_cpu_ci->num_leaves ; i++, this_leaf++) {
+		if (this_leaf->type == CACHE_TYPE_DATA)
+			cpu_ci->dcache_line_size = this_leaf->coherency_line_size;
+	}
+	cpu_ci->init_done = true;
+}
+
+
+inline int get_cache_line_size(void)
+{
+	struct riscv_nds_cache_info *cpu_ci =
+		&per_cpu(cpu_cache_info, smp_processor_id());
+
+	if (unlikely(cpu_ci->init_done == false))
+		fill_cpu_cache_info(cpu_ci);
+	return cpu_ci->dcache_line_size;
+}
+void cpu_dcache_wb_range(unsigned long start, unsigned long end)
+{
+	int line_size = get_cache_line_size();
+
+	while (end > start) {
+		csr_write(ucctlbeginaddr, start);
+		csr_write(ucctlcommand, CCTL_L1D_VA_WB);
+		start += line_size;
+	}
+}
+
+void cpu_dcache_inval_range(unsigned long start, unsigned long end)
+{
+	int line_size = get_cache_line_size();
+
+	while (end > start) {
+		csr_write(ucctlbeginaddr, start);
+		csr_write(ucctlcommand, CCTL_L1D_VA_INVAL);
+		start += line_size;
+	}
+}
+void cpu_dma_inval_range(unsigned long start, unsigned long end)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpu_dcache_inval_range(start, end);
+	local_irq_restore(flags);
+
+}
+EXPORT_SYMBOL(cpu_dma_inval_range);
+
+void cpu_dma_wb_range(unsigned long start, unsigned long end)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpu_dcache_wb_range(start, end);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(cpu_dma_wb_range);
+
diff --git a/arch/riscv/vendor-nds/include/asm/csr.h b/arch/riscv/vendor-nds/include/asm/csr.h
new file mode 100644
index 0000000..6027e6d
--- /dev/null
+++ b/arch/riscv/vendor-nds/include/asm/csr.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#include_next <asm/csr.h>
+
+/* mdcm_cfg: Data Cache/Memory Configuration Register */
+#define MDCM_CFG_DEST_OFFSET		0
+#define MDCM_CFG_DWAY_OFFSET		3
+#define MDCM_CFG_DSZ_OFFSET		6
+#define MDCM_CFG_DLCK_OFFSET		9
+#define MDCM_CFG_DC_ECC_OFFSET		10
+#define MDCM_CFG_DLMB_OFFSET		12
+#define MDCM_CFG_DLMSZ_OFFSET		15
+#define MDCM_CFG_ULM_2BANK_OFFSET	20
+#define MDCM_CFG_DLM_ECC_OFFSET		21
+
+
+#define MDCM_CFG_DEST_MASK	(0x7  << MDCM_CFG_DEST_OFFSET)
+#define MDCM_CFG_DWAY_MASK	(0x7  << MDCM_CFG_DWAY_OFFSET)
+#define MDCM_CFG_DSZ_MASK	(0x7  << MDCM_CFG_DSZ_OFFSET)
+#define MDCM_CFG_DLCK_MASK	(0x1  << MDCM_CFG_DLCK_OFFSET)
+#define MDCM_CFG_DC_ECC_MASK	(0x3  << MDCM_CFG_DC_ECC_OFFSET)
+#define MDCM_CFG_DLMB_MASK	(0x7  << MDCM_CFG_DLMB_OFFSET)
+#define MDCM_CFG_DLMSZ_MASK	(0x1f << MDCM_CFG_DLMSZ_OFFSET)
+#define MDCM_CFG_ULM_2BANK_MASK	(0x1  << MDCM_CFG_ULM_2BANK_OFFSET)
+#define MDCM_CFG_DLM_ECC_MASK	(0x3  << MDCM_CFG_DLM_ECC_OFFSET)
+
+
+/* ucctlcommand */
+/* D-cache operation */
+#define CCTL_L1D_VA_INVAL	0
+#define CCTL_L1D_VA_WB		1
+#define CCTL_L1D_VA_WBINVAL	2
diff --git a/arch/riscv/vendor-nds/include/asm/dma-mapping.h b/arch/riscv/vendor-nds/include/asm/dma-mapping.h
new file mode 100644
index 0000000..30b4183
--- /dev/null
+++ b/arch/riscv/vendor-nds/include/asm/dma-mapping.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#ifndef _RISCV_ASM_DMA_MAPPING_H
+#define _RISCV_ASM_DMA_MAPPING_H 1
+
+
+#ifdef CONFIG_SWIOTLB
+#include <linux/swiotlb.h>
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+{
+#ifdef CONFIG_DMA_NONCOHERENT_OPS
+	extern const struct dma_map_ops swiotlb_noncoh_dma_ops;
+	extern bool riscv_nds_compat_platform;
+
+	if (riscv_nds_compat_platform)
+		return &swiotlb_noncoh_dma_ops;
+#endif
+	return &swiotlb_dma_ops;
+}
+#else
+#include <asm-generic/dma-mapping.h>
+#endif /* CONFIG_SWIOTLB */
+
+#endif /* _RISCV_ASM_DMA_MAPPING_H */
diff --git a/arch/riscv/vendor-nds/include/asm/proc.h b/arch/riscv/vendor-nds/include/asm/proc.h
new file mode 100644
index 0000000..a2684f4
--- /dev/null
+++ b/arch/riscv/vendor-nds/include/asm/proc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#include <asm/io.h>
+#include <asm/page.h>
+
+void cpu_dma_inval_range(unsigned long start, unsigned long end);
+
+void cpu_dma_wb_range(unsigned long start, unsigned long end);
+
+/*
+ * When the content of riscv_nds_cache_info has been initilized by function
+ * fill_cpu_cache_info(), member init_done is set to true
+ */
+struct riscv_nds_cache_info {
+	bool init_done;
+	int dcache_line_size;
+};
diff --git a/arch/riscv/vendor-nds/include/asm/sbi.h b/arch/riscv/vendor-nds/include/asm/sbi.h
new file mode 100644
index 0000000..7a002a4
--- /dev/null
+++ b/arch/riscv/vendor-nds/include/asm/sbi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#ifndef _AMS_RISCV_NDS_SBI_H
+#define _AMS_RISCV_NDS_SBI_H
+
+#include_next <asm/sbi.h>
+#define SBI_RISCV_NDS_GET_MAX_PA (0x0)
+
+#define SBI_RISCV_NDS_CALL_0(which) \
+	SBI_CALL(SBI_XEXT_ARCH_RESERVED|which, 0, 0, 0)
+
+
+static inline phys_addr_t sbi_call_riscv_nds_get_maxpa(void)
+{
+	return SBI_RISCV_NDS_CALL_0(SBI_RISCV_NDS_GET_MAX_PA);
+}
+#endif
diff --git a/arch/riscv/vendor-nds/noncoherent_dma.c b/arch/riscv/vendor-nds/noncoherent_dma.c
new file mode 100644
index 0000000..470dc90
--- /dev/null
+++ b/arch/riscv/vendor-nds/noncoherent_dma.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Andes Technology Corporation
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
+#include <linux/scatterlist.h>
+#include <asm/proc.h>
+
+phys_addr_t pa_msb;
+#define dma_remap(pa, size) ioremap((pa|(pa_msb << PAGE_SHIFT)), size)
+#define dma_unmap(vaddr) iounmap((void __force __iomem *)vaddr)
+
+static void dma_flush_page(struct page *page, size_t size)
+{
+	unsigned long k_d_vaddr;
+	/*
+	 * Invalidate any data that might be lurking in the
+	 * kernel direct-mapped region for device DMA.
+	 */
+	k_d_vaddr = (unsigned long)page_address(page);
+	memset((void *)k_d_vaddr, 0, size);
+	cpu_dma_wb_range(k_d_vaddr, k_d_vaddr + size);
+	cpu_dma_inval_range(k_d_vaddr, k_d_vaddr + size);
+
+}
+
+static inline void cache_op(phys_addr_t paddr, size_t size,
+			    void (*fn)(unsigned long start, unsigned long end))
+{
+	unsigned long start;
+
+	start = (unsigned long)phys_to_virt(paddr);
+	fn(start, start + size);
+}
+
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+			      size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(paddr, size, cpu_dma_wb_range);
+		break;
+	default:
+		BUG();
+	}
+}
+
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+			   size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(paddr, size, cpu_dma_inval_range);
+		break;
+	default:
+		BUG();
+	}
+}
+
+#ifdef CONFIG_32BIT
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		     gfp_t gfp, unsigned long attrs)
+{
+	void *kvaddr, *coherent_kvaddr;
+
+	size = PAGE_ALIGN(size);
+	kvaddr = dma_direct_alloc(dev, size, handle, gfp, attrs);
+	if (!kvaddr)
+		goto no_mem;
+	coherent_kvaddr = dma_remap(dma_to_phys(dev, *handle), size);
+	if (!coherent_kvaddr)
+		goto no_map;
+
+	dma_flush_page(virt_to_page(kvaddr), size);
+	return coherent_kvaddr;
+no_map:
+	dma_direct_free(dev, size, kvaddr, *handle, attrs);
+no_mem:
+	return NULL;
+}
+
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t handle, unsigned long attrs)
+{
+	void *kvaddr = phys_to_virt(dma_to_phys(dev, handle));
+
+	size = PAGE_ALIGN(size);
+	dma_unmap(vaddr);
+	dma_direct_free(dev, size, kvaddr, handle, attrs);
+}
+#else
+void *arch_dma_alloc(struct device *dev, size_t size,
+		     dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+{
+	void *kvaddr, *coherent_kvaddr;
+
+	size = PAGE_ALIGN(size);
+	kvaddr = swiotlb_alloc(dev, size, handle, gfp, attrs);
+	if (!kvaddr)
+		goto no_mem;
+	coherent_kvaddr = dma_remap(dma_to_phys(dev, *handle), size);
+	if (!coherent_kvaddr)
+		goto no_map;
+
+	dma_flush_page(virt_to_page(kvaddr), size);
+	return coherent_kvaddr;
+no_map:
+	swiotlb_free(dev, size, kvaddr, *handle, attrs);
+no_mem:
+	return NULL;
+}
+
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t handle, unsigned long attrs)
+{
+	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, handle));
+
+	size = PAGE_ALIGN(size);
+	dma_unmap(vaddr);
+	swiotlb_free(dev, size, swiotlb_addr, handle, attrs);
+}
+
+static dma_addr_t dma_riscv_swiotlb_map_page(struct device *dev,
+					     struct page *page,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir,
+					     unsigned long attrs)
+{
+	dma_addr_t dev_addr;
+
+	dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(dev, dma_to_phys(dev, dev_addr),
+					 size, dir);
+
+	return dev_addr;
+}
+
+static int dma_riscv_swiotlb_map_sg(struct device *dev,
+				    struct scatterlist *sgl,
+				    int nelems, enum dma_data_direction dir,
+				    unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i, ret;
+
+	ret = swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		for_each_sg(sgl, sg, ret, i)
+			arch_sync_dma_for_device(dev,
+					     dma_to_phys(dev, sg->dma_address),
+					     sg->length, dir);
+
+	return ret;
+}
+
+static void dma_riscv_swiotlb_unmap_page(struct device *dev,
+					 dma_addr_t dev_addr, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_cpu(dev, dma_to_phys(dev, dev_addr),
+				      size, dir);
+	swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static void dma_riscv_swiotlb_unmap_sg(struct device *dev,
+				       struct scatterlist *sgl, int nelems,
+				       enum dma_data_direction dir,
+				       unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		for_each_sg(sgl, sg, nelems, i)
+			arch_sync_dma_for_cpu(dev,
+					  dma_to_phys(dev, sg->dma_address),
+					  sg->length, dir);
+	swiotlb_unmap_sg_attrs(dev, sgl, nelems, dir, attrs);
+}
+
+static void dma_riscv_swiotlb_sync_single_for_cpu(struct device *dev,
+						  dma_addr_t dev_addr,
+						  size_t size,
+						  enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, dev_addr), size, dir);
+	swiotlb_sync_single_for_cpu(dev, dev_addr, size, dir);
+}
+
+static void dma_riscv_swiotlb_sync_single_for_device(struct device *dev,
+						     dma_addr_t dev_addr,
+						     size_t size,
+						     enum dma_data_direction
+						     dir)
+{
+	swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
+	arch_sync_dma_for_device(dev, dma_to_phys(dev, dev_addr), size, dir);
+}
+
+static void dma_riscv_swiotlb_sync_sg_for_cpu(struct device *dev,
+					      struct scatterlist *sgl,
+					      int nelems,
+					      enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_cpu(dev, dma_to_phys(dev, sg->dma_address),
+				  sg->length, dir);
+	swiotlb_sync_sg_for_cpu(dev, sgl, nelems, dir);
+}
+
+static void dma_riscv_swiotlb_sync_sg_for_device(struct device *dev,
+						 struct scatterlist *sgl,
+						 int nelems,
+						 enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	swiotlb_sync_sg_for_device(dev, sgl, nelems, dir);
+	for_each_sg(sgl, sg, nelems, i)
+		arch_sync_dma_for_device(dev,
+				     dma_to_phys(dev, sg->dma_address),
+				     sg->length, dir);
+}
+
+const struct dma_map_ops swiotlb_noncoh_dma_ops = {
+	.alloc			= arch_dma_alloc,
+	.free			= arch_dma_free,
+	.dma_supported		= swiotlb_dma_supported,
+	.map_page		= dma_riscv_swiotlb_map_page,
+	.map_sg			= dma_riscv_swiotlb_map_sg,
+	.unmap_page		= dma_riscv_swiotlb_unmap_page,
+	.unmap_sg		= dma_riscv_swiotlb_unmap_sg,
+	.sync_single_for_cpu	= dma_riscv_swiotlb_sync_single_for_cpu,
+	.sync_single_for_device	= dma_riscv_swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu	= dma_riscv_swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device	= dma_riscv_swiotlb_sync_sg_for_device,
+};
+EXPORT_SYMBOL(swiotlb_noncoh_dma_ops);
+#endif
diff --git a/arch/riscv/vendor-nds/setup.c b/arch/riscv/vendor-nds/setup.c
index 5ceed1b..4b494eb 100644
--- a/arch/riscv/vendor-nds/setup.c
+++ b/arch/riscv/vendor-nds/setup.c
@@ -1,9 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Andes Technology Corporation
 #include <linux/init.h>
+#include <asm/sbi.h>
 #include <asm/vendor-hook.h>
+extern phys_addr_t pa_msb;
 bool riscv_nds_compat_platform;
+static void __init setup_maxpa(void)
+{
+	pa_msb = sbi_call_riscv_nds_get_maxpa();
+}
 void __init setup_vendor_extension(void)
 {
 	riscv_nds_compat_platform = true;
+	setup_maxpa();
 }
-- 
1.7.1

