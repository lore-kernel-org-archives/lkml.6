Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9902133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9902133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeK0Jal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:30:41 -0500
Received: from mail5.windriver.com ([192.103.53.11]:59834 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbeK0Jal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:30:41 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAQMXleK002240
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 26 Nov 2018 14:33:57 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 14:33:36 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Rob Clark <robdclark@gmail.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 6/9] iommu: qcom_iommu: make it explicitly non-modular
Date:   Mon, 26 Nov 2018 17:31:35 -0500
Message-ID: <1543271498-28966-7-git-send-email-paul.gortmaker@windriver.com>
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

drivers/iommu/Kconfig:config MTK_IOMMU_V1
drivers/iommu/Kconfig:  bool "MTK IOMMU Version 1 (M4U gen1) Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init just becomes device_initcall for non-modules, the
init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/qcom_iommu.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index ee70e9921cf1..4c8f4fc54106 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -29,7 +29,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -908,7 +908,6 @@ static const struct of_device_id qcom_iommu_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
 
 static struct platform_driver qcom_iommu_driver = {
 	.driver	= {
@@ -934,15 +933,4 @@ static int __init qcom_iommu_init(void)
 
 	return ret;
 }
-
-static void __exit qcom_iommu_exit(void)
-{
-	platform_driver_unregister(&qcom_iommu_driver);
-	platform_driver_unregister(&qcom_iommu_ctx_driver);
-}
-
-module_init(qcom_iommu_init);
-module_exit(qcom_iommu_exit);
-
-MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
-MODULE_LICENSE("GPL v2");
+device_initcall(qcom_iommu_init);
-- 
2.7.4

