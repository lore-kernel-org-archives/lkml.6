Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF471C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C422082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C422082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbeLBGfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:35:17 -0500
Received: from mail5.windriver.com ([192.103.53.11]:41192 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeLBGfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:35:17 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB1JJh9V005396
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 1 Dec 2018 11:19:53 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:19:32 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH 2/9] iommu/rockchip: Make it explicitly non-modular
Date:   Sat, 1 Dec 2018 14:19:10 -0500
Message-ID: <1543691957-17608-3-git-send-email-paul.gortmaker@windriver.com>
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

drivers/iommu/Kconfig:config ROCKCHIP_IOMMU
drivers/iommu/Kconfig:  bool "Rockchip IOMMU Support"

...meaning that it currently is not being built as a module by anyone.

The bind/unbind/remove was already explicitly disabled in commit
98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").

Lets remove the remaining traces of  modular infrastructure, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ad3e2b97469e..c9ba9f377f63 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1,4 +1,9 @@
 /*
+ * IOMMU API for Rockchip
+ *
+ * Module Authors:	Simon Xue <xxm@rock-chips.com>
+ *			Daniel Kurtz <djkurtz@chromium.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -17,7 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
@@ -1281,7 +1286,6 @@ static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
@@ -1299,8 +1303,3 @@ static int __init rk_iommu_init(void)
 	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
-
-MODULE_DESCRIPTION("IOMMU API for Rockchip");
-MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
-MODULE_ALIAS("platform:rockchip-iommu");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4

