Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeCVKXT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeCVKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:22:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68F8160C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, robdclark@gmail.com, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, lukas@wunner.de, tfiga@chromium.org,
        linux-arm-msm@vger.kernel.org, vivek.gautam@codeaurora.org
Subject: [PATCH v11 3/4] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Thu, 22 Mar 2018 15:52:03 +0530
Message-Id: <20180322102204.14760-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
References: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
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
 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3383c6657857..da50fd979d5f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	if (pm_runtime_enabled(smmu->dev) &&
+	    !device_link_add(dev, smmu->dev,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE)) {
+		dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
+			dev_name(dev));
+		ret = -ENODEV;
+		goto out_unlink;
+	}
+
 	return 0;
 
+out_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_master_free_smes(fwspec);
 out_cfg_free:
 	kfree(cfg);
 out_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
