Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ED020850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAHK2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbfAHK2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76FBA3E2CC;
        Tue,  8 Jan 2019 10:28:16 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C490601A3;
        Tue,  8 Jan 2019 10:28:12 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v3 13/21] iommu/smmuv3: Implement bind_guest_msi
Date:   Tue,  8 Jan 2019 11:26:25 +0100
Message-Id: <20190108102633.17482-14-eric.auger@redhat.com>
In-Reply-To: <20190108102633.17482-1-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 10:28:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bind_guest_msi() callback checks the domain
is NESTED and redirect to the dma-iommu implementation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ca72e0ce92f6..999ee470a2ae 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2226,6 +2226,28 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
+static int arm_smmu_bind_guest_msi(struct iommu_domain *domain,
+				   struct device *dev,
+				   struct iommu_guest_msi_binding *binding)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu;
+	int ret = -EINVAL;
+
+	mutex_lock(&smmu_domain->init_mutex);
+	smmu = smmu_domain->smmu;
+	if (!smmu)
+		goto out;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		goto out;
+
+	ret = iommu_dma_bind_doorbell(domain, dev, binding);
+out:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
 static int arm_smmu_set_pasid_table(struct iommu_domain *domain,
 				     struct iommu_pasid_table_config *cfg)
 {
@@ -2352,6 +2374,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.set_pasid_table	= arm_smmu_set_pasid_table,
 	.cache_invalidate	= arm_smmu_cache_invalidate,
+	.bind_guest_msi		= arm_smmu_bind_guest_msi,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.17.2

