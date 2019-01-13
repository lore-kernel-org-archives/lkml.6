Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0328C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFEC20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfAMUAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:17 -0500
Received: from mail.windriver.com ([147.11.1.11]:65258 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfAMUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:07 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIeguf029203
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:40:43 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:40:42 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 17/18] mfd: wm8350-core: drop unused module infrastructure from non-modular code
Date:   Sun, 13 Jan 2019 13:36:48 -0500
Message-ID: <1547404609-14161-18-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_WM8350
drivers/mfd/Kconfig:    bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We replace module.h with init.h and export.h ; the latter since the
file does export some symbols.

Previous demodularizaion work has made wm8350_device_exit() no longer
used, so it is also removed from the 8350 core code.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm8350-core.c       | 30 ++----------------------------
 include/linux/mfd/wm8350/core.h |  1 -
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/wm8350-core.c b/drivers/mfd/wm8350-core.c
index 8a07c5634aee..9e1070f26b11 100644
--- a/drivers/mfd/wm8350-core.c
+++ b/drivers/mfd/wm8350-core.c
@@ -13,7 +13,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/bug.h>
 #include <linux/device.h>
@@ -442,30 +443,3 @@ int wm8350_device_init(struct wm8350 *wm8350, int irq,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm8350_device_init);
-
-void wm8350_device_exit(struct wm8350 *wm8350)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8350->pmic.led); i++)
-		platform_device_unregister(wm8350->pmic.led[i].pdev);
-
-	for (i = 0; i < ARRAY_SIZE(wm8350->pmic.pdev); i++)
-		platform_device_unregister(wm8350->pmic.pdev[i]);
-
-	platform_device_unregister(wm8350->wdt.pdev);
-	platform_device_unregister(wm8350->rtc.pdev);
-	platform_device_unregister(wm8350->power.pdev);
-	platform_device_unregister(wm8350->hwmon.pdev);
-	platform_device_unregister(wm8350->gpio.pdev);
-	platform_device_unregister(wm8350->codec.pdev);
-
-	if (wm8350->irq_base)
-		free_irq(wm8350->irq_base + WM8350_IRQ_AUXADC_DATARDY, wm8350);
-
-	wm8350_irq_exit(wm8350);
-}
-EXPORT_SYMBOL_GPL(wm8350_device_exit);
-
-MODULE_DESCRIPTION("WM8350 AudioPlus PMIC core driver");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index 509481d9cf19..202d9bde2c7c 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -643,7 +643,6 @@ struct wm8350_platform_data {
  */
 int wm8350_device_init(struct wm8350 *wm8350, int irq,
 		       struct wm8350_platform_data *pdata);
-void wm8350_device_exit(struct wm8350 *wm8350);
 
 /*
  * WM8350 device IO
-- 
2.7.4

