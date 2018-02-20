Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeBTUZS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:25:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47544 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbeBTUZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:25:17 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/rockchip: Perform a reset on shutdown
Date: Tue, 20 Feb 2018 20:25:04 +0000
Message-Id: <20180220202504.19275-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to do a kexec whilst the iommus are still on is proving to be
a challenging exercise. It is terribly unsafe, as we're reusing the
memory allocated for the page tables, leading to a likely crash.

Let's implement a shutdown method that will at least try to stop
DMA from going crazy behind our back. Note that we need to be
extra cautious when doing so, as the IOMMU may not be clocked
if controlled by a another master, as typical on Rockchip system.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9d991c2d8767..6a3719e118da 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1209,6 +1209,23 @@ static int rk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rk_iommu_shutdown(struct platform_device *pdev)
+{
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+
+	/*
+	 * Be careful not to try to shutdown an otherwise unused
+	 * IOMMU, as it is likely not to be clocked, and accessing it
+	 * would just block. An IOMMU without a domain is likely to be
+	 * unused, so let's use this as a (weak) guard.
+	 */
+	if (iommu && iommu->domain) {
+		rk_iommu_enable_stall(iommu);
+		rk_iommu_disable_paging(iommu);
+		rk_iommu_force_reset(iommu);
+	}
+}
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1218,6 +1235,7 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
 	.remove = rk_iommu_remove,
+	.shutdown = rk_iommu_shutdown,
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
-- 
2.14.2
