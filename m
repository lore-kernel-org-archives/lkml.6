Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeEaHnn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:43:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50135 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753934AbeEaHnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:40 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH 2/7] iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
Date: Thu, 31 May 2018 15:42:44 +0800
Message-ID: <1527752569-18020-3-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.flush_iotlb_all can not just wait for previous tlbi operations to be
completed, but should also invalid all TLBs of the related domain.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d64710..4402187 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1770,6 +1770,14 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->smmu)
+		arm_smmu_tlb_inv_context(smmu_domain);
+}
+
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -1998,7 +2006,7 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
-	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
-- 
1.8.3
