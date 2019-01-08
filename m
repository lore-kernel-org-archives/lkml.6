Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77499C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE320827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfAHK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfAHK1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D632D89AE8;
        Tue,  8 Jan 2019 10:27:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E918A601A4;
        Tue,  8 Jan 2019 10:27:50 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v3 10/21] iommu/smmuv3: Implement set_pasid_table
Date:   Tue,  8 Jan 2019 11:26:22 +0100
Message-Id: <20190108102633.17482-11-eric.auger@redhat.com>
In-Reply-To: <20190108102633.17482-1-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 08 Jan 2019 10:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On set_pasid_table() we program STE S1 related info set
by the guest into the actual physical STEs. At minimum
we need to program the context descriptor GPA and compute
whether the guest wanted to bypass the stage 1 or induce
aborts for this STE.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- callback now is named set_pasid_table and struct fields
  are laid out differently.

v1 -> v2:
- invalidate the STE before changing them
- hold init_mutex
- handle new fields
---
 drivers/iommu/arm-smmu-v3.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9716a301d9ae..0e006babc8a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2226,6 +2226,73 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
+static int arm_smmu_set_pasid_table(struct iommu_domain *domain,
+				     struct iommu_pasid_table_config *cfg)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_data *entry;
+	struct arm_smmu_s1_cfg *s1_cfg;
+	struct arm_smmu_device *smmu;
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (cfg->format != IOMMU_PASID_FORMAT_SMMUV3)
+		return -EINVAL;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		goto out;
+
+	if (!((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	      (smmu->features & ARM_SMMU_FEAT_TRANS_S2))) {
+		dev_info(smmu_domain->smmu->dev,
+			 "does not implement two stages\n");
+		goto out;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		goto out;
+
+	if (cfg->bypass) {
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_for_each_entry(entry, &smmu_domain->devices, list) {
+			entry->ste.s1_cfg = NULL;
+			entry->ste.nested = false;
+			arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+		}
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		s1_cfg->nested_abort = false;
+		s1_cfg->nested_bypass = false;
+		ret = 0;
+		goto out;
+	}
+
+	/* we currently support a single CD. S1DSS and S1FMT are ignored */
+	if (cfg->pasid_bits)
+		goto out;
+
+	s1_cfg = &smmu_domain->s1_cfg;
+	s1_cfg->nested_bypass = cfg->bypass;
+	s1_cfg->nested_abort = cfg->smmuv3.abort;
+	s1_cfg->cdptr_dma = cfg->base_ptr;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(entry, &smmu_domain->devices, list) {
+		entry->ste.s1_cfg = &smmu_domain->s1_cfg;
+		entry->ste.nested = true;
+		arm_smmu_install_ste_for_dev(entry->dev->iommu_fwspec);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	ret = 0;
+out:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2244,6 +2311,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.set_pasid_table	= arm_smmu_set_pasid_table,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.17.2

