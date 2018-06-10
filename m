Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jK4IFXAGHVsiNwAAmS7hNA
	; Sun, 10 Jun 2018 11:08:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 258B1608B8; Sun, 10 Jun 2018 11:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9E4A9600D0;
	Sun, 10 Jun 2018 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E4A9600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbeFJLIh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:08:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35206 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753869AbeFJLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:08:36 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72320B2132917;
        Sun, 10 Jun 2018 19:08:32 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Sun, 10 Jun 2018
 19:08:26 +0800
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
Subject: [PATCH v2 5/5] iommu/arm-smmu-v3: add support for non-strict mode
Date: Sun, 10 Jun 2018 19:07:23 +0800
Message-ID: <1528628843-10280-6-git-send-email-thunder.leizhen@huawei.com>
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

1. Add IOMMU_CAP_NON_STRICT capability.
2. Dynamic choose strict or non-strict mode base on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4402187..4a198a0 100644
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

-	return ops->unmap(ops, iova, size);
+	return ops->unmap(ops, iova | IOMMU_DOMAIN_STRICT_MODE(domain), size);
 }

 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1782,7 +1784,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;

-	if (smmu)
+	if (smmu && (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_STRICT))
 		__arm_smmu_tlb_sync(smmu);
 }

--
1.8.3
