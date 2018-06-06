Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2B2E601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeFFCUs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 22:20:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43754 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752424AbeFFCUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 22:20:47 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/1] iommu/amd: make sure TLB to be flushed before IOVA freed
Date: Wed, 6 Jun 2018 10:18:46 +0800
Message-ID: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the mapping has already been removed in the page table, it maybe
still exist in TLB. Suppose the freed IOVAs is reused by others before the
flush operation completed, the new user can not correctly access to its
meomory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c73..93aa389 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2402,9 +2402,9 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 	}

 	if (amd_iommu_unmap_flush) {
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
+		dma_ops_free_iova(dma_dom, dma_addr, pages);
 	} else {
 		pages = __roundup_pow_of_two(pages);
 		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
--
1.8.3
