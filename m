Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FL6wL38BHVtPGQAAmS7hNA
	; Sun, 10 Jun 2018 11:09:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9ABC60850; Sun, 10 Jun 2018 11:09:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5CDFE606FA;
	Sun, 10 Jun 2018 11:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CDFE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeFJLI6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:08:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753944AbeFJLI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:08:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98F985C7C3BC4;
        Sun, 10 Jun 2018 19:08:31 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Sun, 10 Jun 2018
 19:08:23 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>,
        "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH v2 1/5] iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
Date: Sun, 10 Jun 2018 19:07:19 +0800
Message-ID: <1528628843-10280-2-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
