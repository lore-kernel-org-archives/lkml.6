Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B712C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB77B20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWXAI+e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB77B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCTur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:50:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40258 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJCTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:50:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id t22-v6so4060853lfb.7;
        Wed, 03 Oct 2018 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=18WF22CnRg5vBmmVnaEShERpPi6A2+ap9KztaTaVPN4=;
        b=HWXAI+e7ap7fAx4cJPi7hpN2MZRoHj23BA7KrmV8L60nhlACVHKPCy4pdjJM7m1QMF
         ez5sUzPYc1tKltmTKWe8SzxbJwTxgxeMwo2mRsSiRXCb4OQ9p9er+GHTHWUdZD0S4tLw
         /mFDg9EC6XYmQylnVJ5a/kOOFDPIqdxxAEn2jzgOnSxmAnyO0KFM5z4jQZIGslOM9nAO
         DiHFHJhArP9HaX8QJ1Zld64JZLkicxMrpVh1Um1DzsBcCtWg1slz01qJMHHYhDKsRlZu
         ZekWXlROpOOJ19CF2zIU3yqvcfunzSuhyI7hCNyxzR1rYuG24dA6KnAkBnjWbJwdtBBG
         iOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=18WF22CnRg5vBmmVnaEShERpPi6A2+ap9KztaTaVPN4=;
        b=ZdHw0IK3/UX5C1j8uLQ1k8UFhAKU7TzjcBpY19K3YSA4NU6Jz0BHAvSVz/7spbXO5E
         woUBmjOR0DJie3wunA6fZKBE7zHJT/fpqVSTIaMZow0Dsv0CqtdHb903vucViMKTFrh2
         NHJ0jqAobLL//dSVOia3q+kWUbMsTy71l7cylKwgUi0nrtzA4pf0FvlQLUm4QhX1SuJG
         72DJZVNCbJb3eTJKM5arO6zUOWY6+NxIu9u8aj3DiNiV9cIdA3N8ucjItsQwN3TRh7ar
         szVGPvp+Caf79LIgUy2rAfS64kmUH5ejNZbyeQZDKEffUqSY2dnHxMjSLMowauJoUVIY
         f4EA==
X-Gm-Message-State: ABuFfojWQW2Po+u2BR4G3+x9oSOJ7MphP6KfdnyQU+9e9qIXtEQSZa0i
        8GW+4UPDURGLydOzY6tbIpk=
X-Google-Smtp-Source: ACcGV61fV/X3bgUMhrk5x02lfXZcwysU0k+7t+4b2QWlnDfzjf6SIG8aQaLuem2MACFp2/LN6Ga3Pg==
X-Received: by 2002:a19:990c:: with SMTP id b12-v6mr982811lfe.18.1538571745847;
        Wed, 03 Oct 2018 06:02:25 -0700 (PDT)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id v19-v6sm352266lji.10.2018.10.03.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:02:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@lists.infradead.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date:   Wed,  3 Oct 2018 15:03:26 +0200
Message-Id: <20181003130326.10283-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909225605.16463-2-jmkrzyszt@gmail.com>
References: <20180909225605.16463-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
to the driver probe function so device initialization can be deferred
instead of aborted if a GPIO pin is not yet available.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changelog:
v4:
- added Reviewed-by: Linus Walleij
- resubmitted as a standalone patch for inclusion via fbdev tree again

v3:
- rebased on top of v4.19-rc1 with all dependencies mentioned in v2
  changelog satisfied

v2/v2:
- resubmitted in a series as [PATCH v2 1/3 v2] for inclusion via omap
  tree

v2:
- removed problematic error code conversion no longer needed if used on
  top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late devices
  back to init_machine") and commit 8853daf3b4ac ("gpiolib: Defer on
  non-DT find_chip_by_name() failure") already in linux-next
- resubmitted as a standalone patch for inclusion via fbdev tree

Ininally submitted in a series as [PATCH 4/6] 

 drivers/video/fbdev/omap/lcd_ams_delta.c | 55 +++++++++++++-------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index e8c748a0dfe2..cddbd00cbf9f 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -24,11 +24,10 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
 
@@ -41,6 +40,8 @@
 /* LCD class device section */
 
 static int ams_delta_lcd;
+static struct gpio_desc *gpiod_vblen;
+static struct gpio_desc *gpiod_ndisp;
 
 static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
 {
@@ -99,41 +100,17 @@ static struct lcd_ops ams_delta_lcd_ops = {
 
 /* omapfb panel section */
 
-static const struct gpio _gpios[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_VBLEN,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_vblen",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_NDISP,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_ndisp",
-	},
-};
-
-static int ams_delta_panel_init(struct lcd_panel *panel,
-		struct omapfb_device *fbdev)
-{
-	return gpio_request_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
-static void ams_delta_panel_cleanup(struct lcd_panel *panel)
-{
-	gpio_free_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
 static int ams_delta_panel_enable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 1);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 1);
+	gpiod_set_value(gpiod_ndisp, 1);
+	gpiod_set_value(gpiod_vblen, 1);
 	return 0;
 }
 
 static void ams_delta_panel_disable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 0);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 0);
+	gpiod_set_value(gpiod_vblen, 0);
+	gpiod_set_value(gpiod_ndisp, 0);
 }
 
 static struct lcd_panel ams_delta_panel = {
@@ -154,8 +131,6 @@ static struct lcd_panel ams_delta_panel = {
 	.pcd		= 0,
 	.acb		= 37,
 
-	.init		= ams_delta_panel_init,
-	.cleanup	= ams_delta_panel_cleanup,
 	.enable		= ams_delta_panel_enable,
 	.disable	= ams_delta_panel_disable,
 };
@@ -166,9 +141,23 @@ static struct lcd_panel ams_delta_panel = {
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
 	struct lcd_device *lcd_device = NULL;
-#ifdef CONFIG_LCD_CLASS_DEVICE
 	int ret;
 
+	gpiod_vblen = devm_gpiod_get(&pdev->dev, "vblen", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_vblen)) {
+		ret = PTR_ERR(gpiod_vblen);
+		dev_err(&pdev->dev, "VBLEN GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+	gpiod_ndisp = devm_gpiod_get(&pdev->dev, "ndisp", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ndisp)) {
+		ret = PTR_ERR(gpiod_ndisp);
+		dev_err(&pdev->dev, "NDISP GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+#ifdef CONFIG_LCD_CLASS_DEVICE
 	lcd_device = lcd_device_register("omapfb", &pdev->dev, NULL,
 						&ams_delta_lcd_ops);
 
-- 
2.16.4

