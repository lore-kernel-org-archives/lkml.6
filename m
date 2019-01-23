Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A5CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E00421019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfAWHYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:24:38 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:16536 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:24:36 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 529F466200670903FACD;
        Wed, 23 Jan 2019 15:24:34 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N7OPjN027469;
        Wed, 23 Jan 2019 15:24:25 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012315244759-23701699 ;
          Wed, 23 Jan 2019 15:24:47 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 3/6]  misc/pvpanic: add API for pvpanic driver framework
Date:   Wed, 23 Jan 2019 23:47:25 +0800
Message-Id: <1548258448-62013-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 15:24:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 15:24:18,
        Serialize complete at 2019-01-23 15:24:18
X-MAIL: mse01.zte.com.cn x0N7OPjN027469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic_add/remove_device API. Follow-up patches will use them to
add/remove specific drivers into framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/pvpanic.c | 32 ++++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h | 14 ++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 227ab4e..f842ee4 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -48,6 +48,38 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
+int pvpanic_add_device(struct device *dev, struct resource *res)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("pvpanic", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = dev;
+
+	ret = platform_device_add_resources(pdev, res, 1);
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+	pvpanic_data.pdev = pdev;
+
+	return 0;
+err:
+	platform_device_put(pdev);
+	return -1;
+}
+
+void pvpanic_remove_device(void)
+{
+	platform_device_unregister(pvpanic_data.pdev);
+	pvpanic_data.pdev = NULL;
+}
+
 static int pvpanic_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 0000000..a72ca59
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* pvpanic driver framework header file
+ *
+ * Copyright (C) 2019 ZTE Ltd.
+ * Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#ifndef __DRIVERS_MISC_PVPANIC_H
+#define __DRIVERS_MISC_PVPANIC_H
+
+extern int pvpanic_add_device(struct device *dev, struct resource *res);
+extern void pvpanic_remove_device(void);
+
+#endif
-- 
1.8.3.1

