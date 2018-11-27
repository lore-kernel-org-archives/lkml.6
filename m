Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0932086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0932086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeK0OGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:06:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeK0OGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:06:25 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67B5320065C8;
        Tue, 27 Nov 2018 11:09:59 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 11:09:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <jkosina@suse.cz>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] platform/x86: intel-ips: remove unnecessary checks in ips_debugfs_init
Date:   Tue, 27 Nov 2018 11:09:38 +0800
Message-ID: <20181127030938.18160-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Greg KH explained in:
https://lkml.org/lkml/2015/8/15/114

There no need to check the return value of debugfs_create_file/
debugfs_create_dir.

This also fix static code checker warnings:

drivers/platform/x86/intel_ips.c:1314
 ips_debugfs_init() warn: passing zero to 'PTR_ERR'
drivers/platform/x86/intel_ips.c:1328
 ips_debugfs_init() warn: passing zero to 'PTR_ERR'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/platform/x86/intel_ips.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 225638a..5c5dc82 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1310,32 +1310,17 @@ static void ips_debugfs_init(struct ips_driver *ips)
 	int i;
 
 	ips->debug_root = debugfs_create_dir("ips", NULL);
-	if (!ips->debug_root) {
-		dev_err(ips->dev, "failed to create debugfs entries: %ld\n",
-			PTR_ERR(ips->debug_root));
-		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(ips_debug_files); i++) {
-		struct dentry *ent;
 		struct ips_debugfs_node *node = &ips_debug_files[i];
 
 		node->ips = ips;
-		ent = debugfs_create_file(node->name, S_IFREG | S_IRUGO,
-					  ips->debug_root, node,
-					  &ips_debugfs_ops);
-		if (!ent) {
-			dev_err(ips->dev, "failed to create debug file: %ld\n",
-				PTR_ERR(ent));
-			goto err_cleanup;
-		}
+		debugfs_create_file(node->name, S_IFREG | S_IRUGO,
+				    ips->debug_root, node,
+				    &ips_debugfs_ops);
 	}
 
 	return;
-
-err_cleanup:
-	ips_debugfs_cleanup(ips);
-	return;
 }
 #endif /* CONFIG_DEBUG_FS */
 
-- 
2.7.0


