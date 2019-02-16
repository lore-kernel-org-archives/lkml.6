Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E05222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfBPI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:29:13 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:52968 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbfBPI3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:29:12 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BFD7E839596E74F27884;
        Sat, 16 Feb 2019 16:29:09 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1G8T1RK021056;
        Sat, 16 Feb 2019 16:29:01 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021616291311-251067 ;
          Sat, 16 Feb 2019 16:29:13 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 3/4]  misc/pvpanic: Avoid initializing multiple pvpanic devices
Date:   Sun, 17 Feb 2019 00:50:42 +0800
Message-Id: <1550335843-108902-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550335843-108902-1-git-send-email-peng.hao2@zte.com.cn>
References: <1550335843-108902-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-16 16:29:13,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-16 16:28:42,
        Serialize complete at 2019-02-16 16:28:42
X-MAIL: mse01.zte.com.cn x1G8T1RK021056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid initializing multiple pvpanic devices when configure multiple
pvpanic device driver type. Make sure that only one pvpanic device
is working.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/pvpanic.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index ccadec0..fbb5038 100644
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
 
@@ -50,6 +53,12 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 	struct platform_device *pdev;
 	int ret;
 
+	mutex_lock(&pvpanic_data.lock);
+	if (pvpanic_data.pdev) {
+		mutex_unlock(&pvpanic_data.lock);
+		return -EEXIST;
+	}
+
 	pdev = platform_device_alloc("pvpanic", -1);
 	if (!pdev)
 		return -ENOMEM;
@@ -64,9 +73,11 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
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
-- 
1.8.3.1

