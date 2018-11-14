Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1427C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC021780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9p5CATE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAC021780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeKNS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732891AbeKNS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DX9cMG1u8d0vd6WPvXO0Apsoz04fpG8sch9Xg4PpRUk=; b=a9p5CATEfjbNCYg4gN/oz1Innm
        0JbOLjPOGZIswPlPuiM/WeHKbo/5QBzli76XFZB0AT8oSU7ouFdEF9uc9+FZwdxXdvonAfgP2iUZ5
        3zYSHUf8+0z5m/CYd1CyhRinhJvoFiw4XAL6ixTHCAJNqo9axNSHFc9dQ7rBNLzNvGdhvsXkBPyFD
        azhTB/Qz8Z88trurty002NXRZr/oqdjIfvlZKVg9/KudfQHT7UCpmgOIsg5difJ7n5OUc7i4/ohiZ
        peH30Zu6Uvsb0Pj2OYMNDsxJ7o0M7JnwL3gviIdDAKuWoCuAwGcH5icGuaqVc0MS6DoqdxnwWFC05
        tOywm6UA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqTJ-000533-10; Wed, 14 Nov 2018 08:24:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/34] powerpc/dma: remove max_direct_dma_addr
Date:   Wed, 14 Nov 2018 09:23:05 +0100
Message-Id: <20181114082314.8965-26-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_direct_dma_addr duplicates the bus_dma_mask field in struct
device.  Use the generic field instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/device.h     |  3 ---
 arch/powerpc/include/asm/dma-direct.h |  4 +---
 arch/powerpc/kernel/dma-swiotlb.c     | 20 --------------------
 arch/powerpc/kernel/dma.c             |  5 ++---
 arch/powerpc/sysdev/fsl_pci.c         |  3 +--
 5 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 3814e1c2d4bc..a130be13ee83 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -38,9 +38,6 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void			*iommu_domain;
 #endif
-#ifdef CONFIG_SWIOTLB
-	dma_addr_t		max_direct_dma_addr;
-#endif
 #ifdef CONFIG_PPC64
 	struct pci_dn		*pci_data;
 #endif
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index 7702875aabb7..e00ab5d0612d 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -5,9 +5,7 @@
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 #ifdef CONFIG_SWIOTLB
-	struct dev_archdata *sd = &dev->archdata;
-
-	if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
+	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
 		return false;
 #endif
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 38a2c9f5ab54..62caa16b91a9 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -24,21 +24,6 @@
 
 unsigned int ppc_swiotlb_enable;
 
-static u64 swiotlb_powerpc_get_required(struct device *dev)
-{
-	u64 end, mask, max_direct_dma_addr = dev->archdata.max_direct_dma_addr;
-
-	end = memblock_end_of_DRAM();
-	if (max_direct_dma_addr && end > max_direct_dma_addr)
-		end = max_direct_dma_addr;
-	end += get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 /*
  * At the moment, all platforms that use this code only require
  * swiotlb to be used if we're operating on HIGHMEM.  Since
@@ -60,22 +45,17 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = dma_direct_mapping_error,
-	.get_required_mask = swiotlb_powerpc_get_required,
 };
 
 static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 				  unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct dev_archdata *sd;
 
 	/* We are only intereted in device addition */
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	sd = &dev->archdata;
-	sd->max_direct_dma_addr = 0;
-
 	/* May need to bounce if the device can't address all of DRAM */
 	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
 		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index f9f51fc505a1..59f38ca3975c 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -30,11 +30,10 @@
 static u64 __maybe_unused get_pfn_limit(struct device *dev)
 {
 	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
-	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
-		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
+	if (dev->bus_dma_mask && dev->dma_ops == &powerpc_swiotlb_dma_ops)
+		pfn = min_t(u64, pfn, dev->bus_dma_mask >> PAGE_SHIFT);
 #endif
 
 	return pfn;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 561f97d698cc..f136567a5ed5 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -117,9 +117,8 @@ static u64 pci64_dma_offset;
 static void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct dev_archdata *sd = &pdev->dev.archdata;
 
-	sd->max_direct_dma_addr =
+	pdev->dev.bus_dma_mask =
 		hose->dma_window_base_cur + hose->dma_window_size;
 }
 
-- 
2.19.1

