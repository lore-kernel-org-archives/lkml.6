Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739D2082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7739D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbeLBGfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:35:53 -0500
Received: from mail5.windriver.com ([192.103.53.11]:41218 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeLBGfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:35:53 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB1JJh9c005396
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 1 Dec 2018 11:21:01 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:20:34 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/9] iommu/mediatek: Make it explicitly non-modular
Date:   Sat, 1 Dec 2018 14:19:12 -0500
Message-ID: <1543691957-17608-5-git-send-email-paul.gortmaker@windriver.com>
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

drivers/iommu/Kconfig:config MTK_IOMMU_V1
drivers/iommu/Kconfig:  bool "MTK IOMMU Version 1 (M4U gen1) Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not even used by this driver, the init ordering
remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-mediatek@lists.infradead.org
Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/mtk_iommu_v1.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 27867b862d7a..5fbf3cecb87f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -1,4 +1,6 @@
 /*
+ * IOMMU API for MTK architected m4u v1 implementations
+ *
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Honghui Zhang <honghui.zhang@mediatek.com>
  *
@@ -35,7 +37,7 @@
 #include <linux/spinlock.h>
 #include <asm/barrier.h>
 #include <asm/dma-iommu.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <soc/mediatek/smi.h>
 #include "mtk_iommu.h"
@@ -704,15 +706,4 @@ static int __init m4u_init(void)
 {
 	return platform_driver_register(&mtk_iommu_driver);
 }
-
-static void __exit m4u_exit(void)
-{
-	return platform_driver_unregister(&mtk_iommu_driver);
-}
-
 subsys_initcall(m4u_init);
-module_exit(m4u_exit);
-
-MODULE_DESCRIPTION("IOMMU API for MTK architected m4u v1 implementations");
-MODULE_AUTHOR("Honghui Zhang <honghui.zhang@mediatek.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4

