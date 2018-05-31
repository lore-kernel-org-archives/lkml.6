Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeEaHoA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:44:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754076AbeEaHn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:57 -0400
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
Subject: [PATCH 7/7] iommu/arm-smmu-v3: add support for non-strict mode
Date: Thu, 31 May 2018 15:42:49 +0800
Message-ID: <1527752569-18020-8-git-send-email-thunder.leizhen@huawei.com>
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

1. Add IOMMU_CAP_NON_STRICT capability.
2. Dynamic choose strict or non-strict mode base on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 59b3387..25bccbd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1440,6 +1440,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_NOEXEC:
 		return true;
+	case IOMMU_CAP_NON_STRICT:
+		return true;
 	default:
 		return false;
 	}
@@ -1767,7 +1769,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size, IOMMU_STRICT);
+	return ops->unmap(ops, iova, size, IOMMU_DOMAIN_IS_STRICT(domain));
 }
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1782,7 +1784,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
 
-	if (smmu)
+	if (smmu && IOMMU_DOMAIN_IS_STRICT(domain))
 		__arm_smmu_tlb_sync(smmu);
 }
 
-- 
1.8.3
