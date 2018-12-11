Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815CCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF5A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF5A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLKMTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:19:15 -0500
Received: from 8bytes.org ([81.169.241.247]:53122 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeLKMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:19:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 84D6451B; Tue, 11 Dec 2018 13:19:12 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/9] iommu/arm-smmu: Use helper functions to access dev->iommu_fwspec
Date:   Tue, 11 Dec 2018 13:19:04 +0100
Message-Id: <20181211121910.5604-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211121910.5604-1-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu-v3.c | 16 +++++++++-------
 drivers/iommu/arm-smmu.c    | 12 ++++++------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6947ccf26512..8f2d3a30d090 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1691,24 +1691,26 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 
 static void arm_smmu_detach_dev(struct device *dev)
 {
-	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_master_data *master = fwspec->iommu_priv;
 
 	master->ste.assigned = false;
-	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
+	arm_smmu_install_ste_for_dev(fwspec);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master_data *master;
 	struct arm_smmu_strtab_ent *ste;
 
-	if (!dev->iommu_fwspec)
+	if (!fwspec)
 		return -ENOENT;
 
-	master = dev->iommu_fwspec->iommu_priv;
+	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 	ste = &master->ste;
 
@@ -1748,7 +1750,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ste->s2_cfg = &smmu_domain->s2_cfg;
 	}
 
-	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
+	arm_smmu_install_ste_for_dev(fwspec);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
@@ -1839,7 +1841,7 @@ static int arm_smmu_add_device(struct device *dev)
 	int i, ret;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_data *master;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct iommu_group *group;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
@@ -1890,7 +1892,7 @@ static int arm_smmu_add_device(struct device *dev)
 
 static void arm_smmu_remove_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_data *master;
 	struct arm_smmu_device *smmu;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5a28ae892504..988d0362cd03 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1103,7 +1103,7 @@ static bool arm_smmu_free_sme(struct arm_smmu_device *smmu, int idx)
 
 static int arm_smmu_master_alloc_smes(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = cfg->smmu;
 	struct arm_smmu_smr *smrs = smmu->smrs;
@@ -1206,7 +1206,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
@@ -1380,7 +1380,7 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, ret;
 
 	if (using_legacy_binding) {
@@ -1391,7 +1391,7 @@ static int arm_smmu_add_device(struct device *dev)
 		 * will allocate/initialise a new one. Thus we need to update fwspec for
 		 * later use.
 		 */
-		fwspec = dev->iommu_fwspec;
+		fwspec = dev_iommu_fwspec_get(dev);
 		if (ret)
 			goto out_free;
 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
@@ -1445,7 +1445,7 @@ static int arm_smmu_add_device(struct device *dev)
 
 static void arm_smmu_remove_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
 
@@ -1465,7 +1465,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
 	struct iommu_group *group = NULL;
 	int i, idx;
-- 
2.17.1

