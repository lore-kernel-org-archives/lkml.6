Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE39C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE7F20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE7F20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeK0J33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:29:29 -0500
Received: from mail1.windriver.com ([147.11.146.13]:44277 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeK0J33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:29:29 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wAQMXZQN015332
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 26 Nov 2018 14:33:35 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 14:33:34 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Date:   Mon, 26 Nov 2018 17:31:34 -0500
Message-ID: <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
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
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/ipmmu-vmsa.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9e2655f1c1bf..de39ef992d8a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * IPMMU VMSA
+ * IOMMU API for Renesas VMSA-compatible IPMMU
+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
@@ -14,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_iommu.h>
@@ -968,7 +970,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	},
 };
 
-MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
 
 static int ipmmu_probe(struct platform_device *pdev)
 {
@@ -1140,15 +1141,4 @@ static int __init ipmmu_init(void)
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

