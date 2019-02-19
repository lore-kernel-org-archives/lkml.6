Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC6521848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfBSDG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:06:28 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:61884 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfBSDG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:06:28 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 882AE8836E39CE43A462;
        Tue, 19 Feb 2019 11:06:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1J36I0T092436;
        Tue, 19 Feb 2019 11:06:18 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021911063027-595576 ;
          Tue, 19 Feb 2019 11:06:30 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V6 3/4]  misc/pvpanic: Avoid initializing multiple pvpanic devices
Date:   Tue, 19 Feb 2019 19:27:47 +0800
Message-Id: <1550575668-6240-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550575668-6240-1-git-send-email-peng.hao2@zte.com.cn>
References: <1550575668-6240-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-19 11:06:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-19 11:06:14,
        Serialize complete at 2019-02-19 11:06:14
X-MAIL: mse01.zte.com.cn x1J36I0T092436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid initializing multiple pvpanic devices when configure multiple
pvpanic device driver type. Make sure that only one pvpanic device
is working.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index ccadec0..3c9d957 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -15,10 +15,13 @@
 #include <linux/types.h>
 
 static struct {
+	struct mutex lock;
 	struct platform_device *pdev;
 	void __iomem *base;
 	bool is_ioport;
-} pvpanic_data;
+} pvpanic_data = {
+	.lock = __MUTEX_INITIALIZER(pvpanic_data.lock),
+};
 
 #define PVPANIC_PANICKED        (1 << 0)
 
@@ -50,9 +53,17 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 	struct platform_device *pdev;
 	int ret;
 
+	mutex_lock(&pvpanic_data.lock);
+	if (pvpanic_data.pdev) {
+		mutex_unlock(&pvpanic_data.lock);
+		return -EEXIST;
+	}
+
 	pdev = platform_device_alloc("pvpanic", -1);
-	if (!pdev)
+	if (!pdev) {
+		mutex_unlock(&pvpanic_data.lock);
 		return -ENOMEM;
+	}
 
 	pdev->dev.parent = dev;
 
@@ -64,9 +75,11 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 	if (ret)
 		goto err;
 	pvpanic_data.pdev = pdev;
+	mutex_unlock(&pvpanic_data.lock);
 
 	return 0;
 err:
+	mutex_unlock(&pvpanic_data.lock);
 	platform_device_put(pdev);
 	return ret;
 }
@@ -74,8 +87,10 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 
 void pvpanic_remove_device(void)
 {
+	mutex_lock(&pvpanic_data.lock);
 	platform_device_unregister(pvpanic_data.pdev);
 	pvpanic_data.pdev = NULL;
+	mutex_unlock(&pvpanic_data.lock);
 }
 EXPORT_SYMBOL_GPL(pvpanic_remove_device);
 
-- 
1.8.3.1

