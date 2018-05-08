Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933585AbeEHSRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:17:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42953 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeEHSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:34 -0400
X-Google-Smtp-Source: AB8JxZqU0EbI2fWAnGKH1ORKXC01/KwgSq3lG4OlLFQbr3UpzGNeaPKN3WkRI1YbvS6GJ/k85DOSEQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/9] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date: Tue,  8 May 2018 21:16:57 +0300
Message-Id: <20180508181700.5169-7-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART can't handle all devices, ignore devices that aren't related to GART.
Device tree must explicitly assign GART IOMMU to the devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 39305224c48d..5b2d27620350 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -366,6 +366,26 @@ static void gart_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(&gart_handle->iommu, dev);
 }
 
+static int gart_iommu_check_device(struct gart_device *gart,
+				   struct device *dev);
+
+struct iommu_group *gart_iommu_device_group(struct device *dev)
+{
+	int err;
+
+	err = gart_iommu_check_device(gart_handle, dev);
+	if (err)
+		return ERR_PTR(err);
+
+	return generic_device_group(dev);
+}
+
+static int gart_iommu_of_xlate(struct device *dev,
+			       struct of_phandle_args *args)
+{
+	return 0;
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -374,14 +394,24 @@ static const struct iommu_ops gart_iommu_ops = {
 	.detach_dev	= gart_iommu_detach_dev,
 	.add_device	= gart_iommu_add_device,
 	.remove_device	= gart_iommu_remove_device,
-	.device_group	= generic_device_group,
+	.device_group	= gart_iommu_device_group,
 	.map		= gart_iommu_map,
 	.map_sg		= default_iommu_map_sg,
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
+static int gart_iommu_check_device(struct gart_device *gart,
+				   struct device *dev)
+{
+	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &gart_iommu_ops)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int tegra_gart_suspend(struct device *dev)
 {
 	struct gart_device *gart = dev_get_drvdata(dev);
@@ -462,6 +492,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.17.0
