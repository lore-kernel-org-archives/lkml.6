Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA77C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C5021855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfAXISE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:18:04 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:47420 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfAXIRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:17:45 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B19A8D8F86E68E706F51;
        Thu, 24 Jan 2019 16:17:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0O8HUJc030932;
        Thu, 24 Jan 2019 16:17:30 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012416180033-23927978 ;
          Thu, 24 Jan 2019 16:18:00 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V4 3/6]  misc/pvpanic: add API for pvpanic driver framework
Date:   Fri, 25 Jan 2019 00:40:35 +0800
Message-Id: <1548348038-69560-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-24 16:18:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-24 16:17:19,
        Serialize complete at 2019-01-24 16:17:19
X-MAIL: mse01.zte.com.cn x0O8HUJc030932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic_add/remove_device API. Follow-up patches will use them to
add/remove specific drivers into framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/pvpanic.c | 47 ++++++++++++++++++++++++++++++++++++++----
 drivers/misc/pvpanic/pvpanic.h | 15 ++++++++++++++
 2 files changed, 58 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index f44a884..6225dfb 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -14,7 +14,11 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-static void __iomem *base;
+static struct {
+	struct platform_device *pdev;
+	void __iomem *base;
+	bool is_ioport;
+} pvpanic_data;
 
 #define PVPANIC_PANICKED        (1 << 0)
 
@@ -25,7 +29,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	iowrite8(event, pvpanic_data.base);
 }
 
 static int
@@ -41,10 +45,43 @@
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
 static int pvpanic_platform_probe (struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	void __iomem *base;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res) {
@@ -59,8 +96,10 @@ static int pvpanic_platform_probe (struct platform_device *pdev)
 		base = ioport_map(res->start, resource_size(res));
 		if (!base)
 			return -ENODEV;
+		pvpanic_data.is_ioport = true;
         }
 
+	pvpanic_data.base = base;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
 
@@ -71,8 +110,8 @@ static int pvpanic_platform_remove(struct platform_device *pdev)
 {
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
-
-	iounmap(base);
+	if (pvpanic_data.is_ioport)
+		iounmap(pvpanic_data.base);
 
 	return 0;
 }
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 0000000..7fb6bb2
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* pvpanic driver framework header file
+ *
+ * Copyright (C) 2019 ZTE Ltd.
+ *
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

