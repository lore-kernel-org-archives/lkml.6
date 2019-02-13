Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16DEC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52BC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8Lr8jai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfBMHDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:03:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbfBMHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lxv0WcQW84mmLJvEFcH/Tsr23MhYXWXlkbgBkcV0LpM=; b=E8Lr8jaijQUN2C3NgfIfAJIuo9
        LAzv2YVf76nZMAgyJGRdRpFEImBROI1eb7btsbLDmnna+1b1StOzo/0VKxm1XUpKPHPDlm2Vq0Egb
        WxzoKay2Gk4ZgagQL1ZZRFJAHWjU0fcLuafR458mPyFOZSsOYcsdKDoc+Z8sGMLnSvJDxbKggLBGu
        h6qzGNesOruL6wMvqsrarqrMTr6bAmdJT4GL5f8EtxlwBGLfg5PXafankBA+P4pEwDo9AqK5nrf2r
        nPcqwhuYvI8O4EAyzuFyLIifRS1fPuS7Mks8A1AVvfd2SORKhr6ZQv5wNLazi9JugYBQPDSQCs63R
        xXeGadyg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoZF-0000mL-1m; Wed, 13 Feb 2019 07:02:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 31/32] powerpc/dma: remove set_dma_offset
Date:   Wed, 13 Feb 2019 08:01:32 +0100
Message-Id: <20190213070133.11259-32-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason for this helper, just opencode it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h    | 6 ------
 arch/powerpc/kernel/pci-common.c          | 2 +-
 arch/powerpc/platforms/cell/iommu.c       | 4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 arch/powerpc/platforms/pseries/iommu.c    | 7 ++-----
 arch/powerpc/sysdev/dart_iommu.c          | 2 +-
 arch/powerpc/sysdev/fsl_pci.c             | 2 +-
 drivers/misc/cxl/vphb.c                   | 2 +-
 8 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c70f55d2f5e0..a59c42879194 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -43,11 +43,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-static inline void set_dma_offset(struct device *dev, dma_addr_t off)
-{
-	if (dev)
-		dev->archdata.dma_offset = off;
-}
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 23989175349c..cbdf13d86227 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -966,7 +966,7 @@ static void pcibios_setup_device(struct pci_dev *dev)
 
 	/* Hook up default DMA ops */
 	set_dma_ops(&dev->dev, pci_dma_ops);
-	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+	dev->dev.archdata.dma_offset = PCI_DRAM_OFFSET;
 
 	/* Additional platform DMA/iommu setup */
 	phb = pci_bus_to_host(dev->bus);
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 06abd432b830..54e012e1f720 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -577,10 +577,10 @@ static void cell_dma_dev_setup(struct device *dev)
 		u64 addr = cell_iommu_get_fixed_address(dev);
 
 		if (addr != OF_BAD_ADDR)
-			set_dma_offset(dev, addr + dma_iommu_fixed_base);
+			dev->archdata.dma_offset = addr + dma_iommu_fixed_base;
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
 	} else {
-		set_dma_offset(dev, cell_dma_nommu_offset);
+		dev->archdata.dma_offset = cell_dma_nommu_offset;
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9a1db2de9605..b56bf65e1bb6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1746,7 +1746,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
+	pdev->dev.archdata.dma_offset = pe->tce_bypass_base;
 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	/*
 	 * Note: iommu_add_device() will fail here as
@@ -1859,7 +1859,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 		if (rc)
 			return rc;
 		/* 4GB offset bypasses 32-bit space */
-		set_dma_offset(&pdev->dev, (1ULL << 32));
+		pdev->dev.archdata.dma_offset = (1ULL << 32);
 		return true;
 	}
 
@@ -1872,7 +1872,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
-		set_dma_offset(&dev->dev, pe->tce_bypass_base);
+		dev->dev.archdata.dma_offset = pe->tce_bypass_base;
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 37d2ce3f55a3..36eb1ddbac69 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1202,7 +1202,6 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct device_node *dn = pci_device_to_OF_node(pdev), *pdn;
 	const __be32 *dma_window = NULL;
-	u64 dma_offset;
 
 	/* only attempt to use a new window if 64-bit DMA is requested */
 	if (dma_mask < DMA_BIT_MASK(64))
@@ -1224,11 +1223,9 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 	}
 
 	if (pdn && PCI_DN(pdn)) {
-		dma_offset = enable_ddw(pdev, pdn);
-		if (dma_offset != 0) {
-			set_dma_offset(&pdev->dev, dma_offset);
+		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
+		if (pdev->dev.archdata.dma_offset)
 			return true;
-		}
 	}
 
 	return false;
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index d42ba645d51d..809797dbe169 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -386,7 +386,7 @@ static bool dart_device_on_pcie(struct device *dev)
 static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
 	if (dart_is_u4 && dart_device_on_pcie(&dev->dev))
-		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
+		dev->dev.archdata.dma_offset = DART_U4_BYPASS_BASE;
 	set_iommu_table_base(&dev->dev, &iommu_table_dart);
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 23000ca7f688..a04c6dde6ed0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -139,7 +139,7 @@ static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
 		dev->bus_dma_mask = 0;
-		set_dma_offset(dev, pci64_dma_offset);
+		dev->archdata.dma_offset = pci64_dma_offset;
 	}
 }
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index b64adc0f0865..631c5df246d4 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -43,7 +43,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 		return false;
 	}
 
-	set_dma_offset(&dev->dev, PAGE_OFFSET);
+	dev->dev.archdata.dma_offset = PAGE_OFFSET;
 
 	/*
 	 * Allocate a context to do cxl things too.  If we eventually do real
-- 
2.20.1

