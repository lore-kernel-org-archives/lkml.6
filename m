Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933392AbeEHSUR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:20:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43054 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbeEHSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:33 -0400
X-Google-Smtp-Source: AB8JxZq5XzLDhdiCdfJOkYpMyiIEXowRnfEarHx6iUI4OkJE54nwVEmg4E0LYNeCFwtKvPFU3x+MAA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/9] iommu/tegra: gart: Clean up driver probe failure unwinding
Date: Tue,  8 May 2018 21:16:56 +0300
Message-Id: <20180508181700.5169-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly clean up allocated resources on driver probe failure.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 08e0de4087d1..39305224c48d 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -466,8 +466,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU\n");
-		iommu_device_sysfs_remove(&gart->iommu);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	gart->dev = &pdev->dev;
@@ -483,7 +482,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto iommu_unregister;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -493,6 +493,13 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	tegra_mc_register_gart(&gart->mc_gart_handle);
 
 	return 0;
+
+iommu_unregister:
+	iommu_device_unregister(&gart->iommu);
+remove_sysfs:
+	iommu_device_sysfs_remove(&gart->iommu);
+
+	return ret;
 }
 
 static const struct dev_pm_ops tegra_gart_pm_ops = {
-- 
2.17.0
