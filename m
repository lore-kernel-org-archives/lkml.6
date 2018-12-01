Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ADF2082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5ADF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeLBGfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:35:16 -0500
Received: from mail5.windriver.com ([192.103.53.11]:41190 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeLBGfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:35:16 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB1JJh9d005396
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 1 Dec 2018 11:21:12 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:21:04 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 5/9] iommu/ipmmu-vmsa: Make it explicitly non-modular
Date:   Sat, 1 Dec 2018 14:19:13 -0500
Message-ID: <1543691957-17608-6-git-send-email-paul.gortmaker@windriver.com>
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

drivers/iommu/Kconfig:config IPMMU_VMSA
drivers/iommu/Kconfig:        bool "Renesas VMSA-compatible IPMMU"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not even used by this driver, the init ordering
remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/ipmmu-vmsa.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9e2655f1c1bf..e1276da38e0d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * IPMMU VMSA
+ * IOMMU API for Renesas VMSA-compatible IPMMU
+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
@@ -11,10 +12,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_iommu.h>
@@ -968,8 +969,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	},
 };
 
-MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
-
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
@@ -1140,15 +1139,4 @@ static int __init ipmmu_init(void)
 	setup_done = true;
 	return 0;
 }
-
-static void __exit ipmmu_exit(void)
-{
-	return platform_driver_unregister(&ipmmu_driver);
-}
-
 subsys_initcall(ipmmu_init);
-module_exit(ipmmu_exit);
-
-MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4

