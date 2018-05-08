Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeEHSRk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:17:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38919 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbeEHSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:31 -0400
X-Google-Smtp-Source: AB8JxZq3sj5Dd0wRPpIUnmYtnbVpfYJJ6lgKWT+Qb574Z5e9rHzw6E3q599QCO9T7Gupx5c14dH3qw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/9] iommu/tegra: gart: Remove code related to module unloading
Date: Tue,  8 May 2018 21:16:54 +0300
Message-Id: <20180508181700.5169-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART driver is built-in, hence it can't be unloaded. This patch merely
removes the dead code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index de48943bf843..268d29fb9097 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -502,20 +502,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_gart_remove(struct platform_device *pdev)
-{
-	struct gart_device *gart = platform_get_drvdata(pdev);
-
-	iommu_device_unregister(&gart->iommu);
-	iommu_device_sysfs_remove(&gart->iommu);
-
-	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	gart_handle = NULL;
-	return 0;
-}
-
 static const struct dev_pm_ops tegra_gart_pm_ops = {
 	.suspend	= tegra_gart_suspend,
 	.resume		= tegra_gart_resume,
@@ -529,26 +515,21 @@ MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
 	.driver = {
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
 		.of_match_table = tegra_gart_of_match,
+		.suppress_bind_attrs = true,
 	},
+	.prevent_deferred_probe = true,
 };
 
 static int tegra_gart_init(void)
 {
 	return platform_driver_register(&tegra_gart_driver);
 }
-
-static void __exit tegra_gart_exit(void)
-{
-	platform_driver_unregister(&tegra_gart_driver);
-}
-
 subsys_initcall(tegra_gart_init);
-module_exit(tegra_gart_exit);
+
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-- 
2.17.0
