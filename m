Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeCFD2y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:28:54 -0500
Received: from regular1.263xmail.com ([211.150.99.139]:50038 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeCFD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:28:47 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <464865229e4a8f1c36020871e927eebb>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 12/14] iommu/rockchip: Fix error handling in init
Date: Tue,  6 Mar 2018 11:27:57 +0800
Message-Id: <20180306032759.29069-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306032759.29069-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to undo bus_set_iommu() in the error path, so move it to the
end of rk_iommu_probe().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
Move bus_set_iommu() to rk_iommu_probe().

 drivers/iommu/rockchip-iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 1346bbb8a3e7..2448a0528e39 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1133,6 +1133,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
+	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1158,19 +1160,6 @@ static struct platform_driver rk_iommu_driver = {
 
 static int __init rk_iommu_init(void)
 {
-	struct device_node *np;
-	int ret;
-
-	np = of_find_matching_node(NULL, rk_iommu_dt_ids);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-	if (ret)
-		return ret;
-
 	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
-- 
2.11.0
