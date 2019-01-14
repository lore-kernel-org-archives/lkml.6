Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4215C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3DF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KK4P8+F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfANJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfANJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gX1qc5MYXYmZZDQTpvapAXAEjXt6MguH0uOaPofciGU=; b=KK4P8+F/ADkSLk0B5FrwxiutL7
        Nz8hArjhM+csOAULHKJAe9Y2QXJ2vmPlWK5QxRC08k2WlJV3fXmg6Q8Z0G6N9ATguFWSsMs8JgSMG
        VSavP2mWSZJs4296ig6A4A1X6xKRaY/5Iq/sZYLfJaLJKCk5eoKiC7FmTVgAGmRhvVakp9nTnlGvM
        lie9fN29SIt4F3r6QbKhUr7OxeBMOo/PETGAsE0r+OSnbbo93DfKrSVmb829Y1nU42+33QmfjMjvf
        0mdPv95Qt3GH48xM42XLnZgdFUTpXfTe2ey/6Q8HfD7WGhFm/MOya6TYdCCdhHF6HHOX+MQ1iHA+p
        oyWbGpLA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylW-0006e2-0U; Mon, 14 Jan 2019 09:42:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] dma-iommu: refactor iommu_dma_free
Date:   Mon, 14 Jan 2019 10:41:52 +0100
Message-Id: <20190114094159.27326-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the checks a bit so that a non-remapped allocation is the
fallthrough case, as this will ease making remapping conditional.
Also get rid of the confusing game with the size and iosize variables
and rename the handle argument to the more standard dma_handle.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 73f76226ff5e..c9788e0c1d5d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1061,34 +1061,36 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
-	size_t iosize = size;
+	struct page *page;
 
-	size = PAGE_ALIGN(size);
 	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
+	 * cpu_addr can be one of 4 things depending on how it was allocated:
+	 *
+	 *  (1) A non-cacheable alias from the atomic pool.
+	 *  (2) A remapped array of pages from iommu_dma_alloc_remap().
+	 *  (3) A remapped contiguous lowmem allocation.
+	 *  (4) A normal lowmem address.
+	 *
 	 * Hence how dodgy the below logic looks...
 	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_free_pool(dev, size, cpu_addr, handle);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		iommu_dma_free_contiguous(dev, iosize,
-				vmalloc_to_page(cpu_addr), handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
-	} else {
-		iommu_dma_free_contiguous(dev, iosize, virt_to_page(cpu_addr),
-				handle);
+	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
+		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
+		return;
 	}
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+			iommu_dma_free_remap(dev, size, cpu_addr, dma_handle);
+			return;
+		}
+		page = vmalloc_to_page(cpu_addr);
+		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
+	} else
+		page = virt_to_page(cpu_addr);
+
+	iommu_dma_free_contiguous(dev, size, page, dma_handle);
 }
 
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-- 
2.20.1

