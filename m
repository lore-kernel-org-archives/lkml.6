Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD42073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="Pnkv4/Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfACI3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:29:52 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25462 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbfACI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:29:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546504178; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ClQSrW8KJDY89PhJhQ/AYD8XONVvWY/88WRkqylbr9jSpiPY5vvJJEb3xvF4C+MKuBigIidMZ0cQUy/ceX7ERJbUuvC2hgDZjlRqTStm3guzBIyVeFuEnKCrGmrGY8dsHVM1hWRDxhYgSOvG7h10/6DS3lkJBtoCc/RssuJKgv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546504178; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=GLMplAc/1wyRSa54blzN1TjGuBt+nMTrWiVLprHbzdQ=; 
        b=bzdLU5vUkPSI6mcpUrvjyMbjJGzlkLC/bv/aKQ/sBa+aYFVhvve/P4qBTeuCf7bnPZ2fTtU3W/+nUsmd2k7xgPccTPd/n/u+hl+F1Ty+s4a1STFumK0hvg8yOVfFC9KR3sll8eYlW4b5SNO7dtI8bviAmRLaYSOhihqwMuoxoiA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=pr6xA8zCoY6gLhtkivV8lXSzO1FYiDAd9DzUJFg/YnH9QzDG72PmDix+KoYQq2A64cqkLwUFOVmJ
    UyMXI/OLReF/9fjntNS9LcoU5pqrkUZeYYaMGHtG0Pp8YbHQOtD/  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546504178;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=2370;
        bh=GLMplAc/1wyRSa54blzN1TjGuBt+nMTrWiVLprHbzdQ=;
        b=Pnkv4/Cf2YAzoL+HEcKlCJDuNI49IkxDX1PTf/blczzGCMxQkU4HNUM7PlgktWF+
        An0RUXSkHJFYizI5osUEwBoB8JjAAd4wjtJti9ggudL/YZp633LCl58WozmIqjQGKXT
        Ly9plaP0aCc3iLryx+Ri853Y/5qaElNhf0AydOKs=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1546504176699644.4196842856686; Thu, 3 Jan 2019 00:29:36 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     hch@lst.de
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dma-mapping: remove unused attrs parameter to dma_common_get_sgtable
Date:   Thu,  3 Jan 2019 16:29:08 +0800
Message-Id: <20190103082908.9988-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

dma_common_get_sgtable has parameter attrs which is not used at all.
Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/xen/swiotlb-xen.c   | 2 +-
 include/linux/dma-mapping.h | 5 ++---
 kernel/dma/mapping.c        | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2a7f545..2dc17a5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -697,7 +697,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 							   handle, size, attrs);
 	}
 #endif
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
 }
 
 static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d327bdd..bbfad44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -483,7 +483,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs);
+		dma_addr_t dma_addr, size_t size);
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
@@ -495,8 +495,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 	if (ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
-			attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
 }
 
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a..6b33f10 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -202,8 +202,7 @@ void dmam_release_declared_memory(struct device *dev)
  * Create scatter-list for the already allocated DMA buffer.
  */
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	struct page *page;
 	int ret;
-- 
1.8.3.1


