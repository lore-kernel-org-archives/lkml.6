Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426250AbeCBKMf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:12:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426176AbeCBKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:11:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F20F602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, robin.murphy@arm.com, will.deacon@arm.com,
        robdclark@gmail.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, jcrouse@codeaurora.org, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org
Subject: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Fri,  2 Mar 2018 15:40:49 +0530
Message-Id: <20180302101050.6191-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3d6a1875431f..bb1ea82c1003 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -217,6 +217,9 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	/* runtime PM link to master */
+	struct device_link *link;
 };
 
 enum arm_smmu_context_fmt {
@@ -1470,10 +1473,26 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!smmu->link) {
+		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+		ret = -ENODEV;
+		goto out_unlink;
+	}
+
 	arm_smmu_rpm_put(smmu);
 
 	return 0;
 
+out_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_master_free_smes(fwspec);
 out_rpm_put:
 	arm_smmu_rpm_put(smmu);
 out_cfg_free:
@@ -1496,6 +1515,8 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	device_link_del(smmu->link);
+
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
