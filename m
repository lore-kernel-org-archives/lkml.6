Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCWHiy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:38:54 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:49182 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:38:53 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1aa2618b7b4f3a13ffde7be213a1c0ad>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 01/14] iommu/rockchip: Prohibit unbind and remove
Date: Fri, 23 Mar 2018 15:38:01 +0800
Message-Id: <20180323073814.5802-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of IOMMUs cannot be done reliably.

This is similar to exynos iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v8:
Rebase on newest for-next.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
Rewrite commit message.

Changes in v3:
Also remove remove() and module_exit() as Tomasz suggested.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 6a3719e118da..e7fb824d123e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1197,18 +1197,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int rk_iommu_remove(struct platform_device *pdev)
-{
-	struct rk_iommu *iommu = platform_get_drvdata(pdev);
-
-	if (iommu) {
-		iommu_device_sysfs_remove(&iommu->iommu);
-		iommu_device_unregister(&iommu->iommu);
-	}
-
-	return 0;
-}
-
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
 	struct rk_iommu *iommu = platform_get_drvdata(pdev);
@@ -1234,11 +1222,11 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
-	.remove = rk_iommu_remove,
 	.shutdown = rk_iommu_shutdown,
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
+		   .suppress_bind_attrs = true,
 	},
 };
 
@@ -1266,14 +1254,7 @@ static int __init rk_iommu_init(void)
 		platform_driver_unregister(&rk_iommu_domain_driver);
 	return ret;
 }
-static void __exit rk_iommu_exit(void)
-{
-	platform_driver_unregister(&rk_iommu_driver);
-	platform_driver_unregister(&rk_iommu_domain_driver);
-}
-
 subsys_initcall(rk_iommu_init);
-module_exit(rk_iommu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for Rockchip");
 MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
-- 
2.11.0
