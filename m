Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16EC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FF12082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FF12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbeLBGek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:34:40 -0500
Received: from mail1.windriver.com ([147.11.146.13]:40907 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeLBGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:34:40 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB1JLKkn028944
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 1 Dec 2018 11:21:20 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:21:19 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Hiroshi Doyu <hdoyu@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH 7/9] iommu/tegra: Make it explicitly non-modular
Date:   Sat, 1 Dec 2018 14:19:15 -0500
Message-ID: <1543691957-17608-8-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config TEGRA_IOMMU_GART
drivers/iommu/Kconfig:  bool "Tegra GART IOMMU Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We replace module.h with moduleparam.h since the file does actually
declare some module_param() and the easiest way to keep back
compatibility with existing use cases is to leave it as-is for now.

The init function was missing an __init annotation, so it was added.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-tegra@vger.kernel.org
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/tegra-gart.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 7b1361d57a17..da6a4e357b2b 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
  *
+ * Author: Hiroshi DOYU <hdoyu@nvidia.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -19,7 +21,8 @@
 
 #define pr_fmt(fmt)	"%s(): " fmt, __func__
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -478,20 +481,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
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
@@ -501,34 +490,22 @@ static const struct of_device_id tegra_gart_of_match[] = {
 	{ .compatible = "nvidia,tegra20-gart", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
 	.driver = {
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
 		.of_match_table = tegra_gart_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
-static int tegra_gart_init(void)
+static int __init tegra_gart_init(void)
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
-module_param(gart_debug, bool, 0644);
 
+module_param(gart_debug, bool, 0644);
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
-MODULE_ALIAS("platform:tegra-gart");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4

