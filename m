Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720342082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720342082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeLJULU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:11:20 -0500
Received: from mail5.windriver.com ([192.103.53.11]:36166 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeLJULT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:11:19 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBAKAK8c006993
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 10 Dec 2018 12:10:35 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Mon, 10 Dec 2018 12:10:10 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 CE68A2E0922; Mon, 10 Dec 2018 15:10:09 -0500 (EST)
Date:   Mon, 10 Dec 2018 15:10:09 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 17/18] mfd: wm8350-core: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181210201009.GD11670@windriver.com>
References: <1544213465-16259-1-git-send-email-paul.gortmaker@windriver.com>
 <1544213465-16259-18-git-send-email-paul.gortmaker@windriver.com>
 <20181210063853.GU26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181210063853.GU26661@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 17/18] mfd: wm8350-core: drop unused MODULE_ tags from non-modular code] On 10/12/2018 (Mon 06:38) Lee Jones wrote:

> On Fri, 07 Dec 2018, Paul Gortmaker wrote:

[...]

> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: patches@opensource.cirrus.com
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> When you submit this patch again (collecting more Acks or
> what-have-you), please re-order your tags chronologically.

Thanks. Will do.  Here is v3 --> v3a ; adding the orphan function
removal rightfully requested by Charles.  With an ack or two on this,
I will send a v4 with all Acks and in order after SOB, and hopefully
we are done here, and can avoid a v5 of this series.

Thanks for your patience everyone.
Paul.
--


From 4711117ed697823f61974bdea5678e6ce225cf9b Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 6 Jul 2016 16:46:39 -0400
Subject: [PATCH] mfd: wm8350-core: drop unused module infrastructure from
 non-modular code

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

