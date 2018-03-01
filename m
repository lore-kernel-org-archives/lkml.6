Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967339AbeCAKVZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:21:25 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:52302 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934985AbeCAKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:21:21 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <c2eb12126c23b7f06051380c36afcae8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v6 14/14] iommu/rockchip: Support sharing IOMMU between masters
Date: Thu,  1 Mar 2018 18:18:37 +0800
Message-Id: <20180301101837.27969-15-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There would be some masters sharing the same IOMMU device. Put them in
the same iommu group and share the same iommu domain.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
Remove rk_iommudata->domain.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0e0a42f41818..f4ce7706fc34 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -104,6 +104,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct iommu_group *group;
 };
 
 struct rk_iommudata {
@@ -1083,6 +1084,15 @@ static void rk_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *rk_iommu_device_group(struct device *dev)
+{
+	struct rk_iommu *iommu;
+
+	iommu = rk_iommu_from_dev(dev);
+
+	return iommu->group;
+}
+
 static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
@@ -1114,7 +1124,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
-	.device_group = generic_device_group,
+	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 };
@@ -1183,9 +1193,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	iommu->group = iommu_group_alloc();
+	if (IS_ERR(iommu->group)) {
+		err = PTR_ERR(iommu->group);
+		goto err_unprepare_clocks;
+	}
+
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		goto err_unprepare_clocks;
+		goto err_put_group;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
@@ -1209,6 +1225,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
+err_put_group:
+	iommu_group_put(iommu->group);
 err_unprepare_clocks:
 	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
 	return err;
-- 
2.11.0
