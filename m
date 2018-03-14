Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeCNIPX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:15:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeCNIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:15:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 845226081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, robh+dt@kernel.org, rafael.j.wysocki@intel.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, robdclark@gmail.com,
        tfiga@chromium.org, sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, vivek.gautam@codeaurora.org
Subject: [PATCH v10 4/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Wed, 14 Mar 2018 13:44:33 +0530
Message-Id: <20180314081434.30875-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
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
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes since v9:
 - Using device_link_del_dev() to delete the device link, instead of
   doing it in two steps - device_link_find() to first find the link, and
   then calling device_link_del().

 drivers/iommu/arm-smmu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 56a04ae80bf3..4cf270ffd449 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	if (pm_runtime_enabled(smmu->dev)) {
+		struct device_link *link;
+
+		/*
+		 * Establish the link between smmu and master, so that the
+		 * smmu gets runtime enabled/disabled as per the master's
+		 * needs.
+		 */
+		link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+		if (!link) {
+			dev_warn(smmu->dev,
+				 "Unable to add link to the consumer %s\n",
+				 dev_name(dev));
+			ret = -ENODEV;
+			goto out_unlink;
+		}
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
@@ -1486,6 +1507,9 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	if (pm_runtime_enabled(smmu->dev))
+		device_link_del_dev(dev, smmu->dev);
+
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
