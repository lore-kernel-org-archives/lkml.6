Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A15220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A15220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeK0ABt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:01:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeK0ABt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:01:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 907DC492BB05;
        Mon, 26 Nov 2018 21:07:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 21:07:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <jkosina@suse.cz>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] platform/x86: intel-ips: fix 'passing zero to ERR_PTR()' warning
Date:   Mon, 26 Nov 2018 21:06:46 +0800
Message-ID: <20181126130646.22568-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
drivers/platform/x86/intel_ips.c:1314
 ips_debugfs_init() warn: passing zero to 'PTR_ERR'
drivers/platform/x86/intel_ips.c:1328
 ips_debugfs_init() warn: passing zero to 'PTR_ERR'

If error occurs,debugfs_create_dir/debugfs_create_file
return NULL while debugfs is enabled, which should not
passing to ERR_PTR.

Fixes: aa7ffc01d254 ("x86 platform driver: intelligent power sharing driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/platform/x86/intel_ips.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 225638a..a5d1a68 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1311,8 +1311,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
 
 	ips->debug_root = debugfs_create_dir("ips", NULL);
 	if (!ips->debug_root) {
-		dev_err(ips->dev, "failed to create debugfs entries: %ld\n",
-			PTR_ERR(ips->debug_root));
+		dev_err(ips->dev, "failed to create debugfs entries\n")
 		return;
 	}
 
@@ -1325,8 +1324,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
 					  ips->debug_root, node,
 					  &ips_debugfs_ops);
 		if (!ent) {
-			dev_err(ips->dev, "failed to create debug file: %ld\n",
-				PTR_ERR(ent));
+			dev_err(ips->dev, "failed to create debug file\n");
 			goto err_cleanup;
 		}
 	}
-- 
2.7.0


