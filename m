Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E37ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975F206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1975F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeITVyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITVyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C6E1596;
        Thu, 20 Sep 2018 09:10:36 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A03533F557;
        Thu, 20 Sep 2018 09:10:34 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 1/7] iommu/arm-smmu-v3: Implement flush_iotlb_all hook
Date:   Thu, 20 Sep 2018 17:10:21 +0100
Message-Id: <396dac165e343dec0cbe0a1f4d311839ff768f95.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

.flush_iotlb_all is currently stubbed to arm_smmu_iotlb_sync() since the
only time it would ever need to actually do anything is for callers
doing their own explicit batching, e.g.:

	iommu_unmap_fast(domain, ...);
	iommu_unmap_fast(domain, ...);
	iommu_iotlb_flush_all(domain, ...);

where since io-pgtable still issues the TLBI commands implicitly in the
unmap instead of implementing .iotlb_range_add, the "flush" only needs
to ensure completion of those already-in-flight invalidations.

However, we're about to start using it in anger with flush queues, so
let's get a proper implementation wired up.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
[rm: document why it wasn't a bug]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e395f1ff3f81..f10c852479fc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1781,6 +1781,14 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
@@ -2008,7 +2016,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
-- 
2.19.0.dirty

