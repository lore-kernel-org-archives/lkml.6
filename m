Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167201AbeBOUym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:54:42 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41226 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBOUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:54:39 -0500
X-Google-Smtp-Source: AH8x227j9uDU1qOyg7uMTcjdaY/xBJWpSI07jteYpengR7e7uCAH0dNT8U/FVNWIfr2b7UiuRXugcA==
From: Moritz Fischer <moritz.fischer@ettus.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, sre@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] power: reset: gpio-poweroff: Add support for timeout from DT
Date: Thu, 15 Feb 2018 12:49:26 -0800
Message-Id: <20180215204926.23347-2-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215204926.23347-1-moritz.fischer@ettus.com>
References: <20180215204926.23347-1-moritz.fischer@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Add support for reading a timeout value from devicetree.
Fall back to previous default of 3s if nothing is specified.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/power/reset/gpio-poweroff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index be3d81ff51cc..bc9fad17d22a 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -19,11 +19,13 @@
 #include <linux/of_platform.h>
 #include <linux/module.h>
 
+#define DEFAULT_TIMEOUT_MS 3000
 /*
  * Hold configuration here, cannot be more than one instance of the driver
  * since pm_power_off itself is global.
  */
 static struct gpio_desc *reset_gpio;
+static u32 timeout;
 
 static void gpio_poweroff_do_poweroff(void)
 {
@@ -40,7 +42,7 @@ static void gpio_poweroff_do_poweroff(void)
 	gpiod_set_value(reset_gpio, 1);
 
 	/* give it some time */
-	mdelay(3000);
+	mdelay(timeout);
 
 	WARN_ON(1);
 }
@@ -49,6 +51,7 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 {
 	bool input = false;
 	enum gpiod_flags flags;
+	int ret;
 
 	/* If a pm_power_off function has already been added, leave it alone */
 	if (pm_power_off != NULL) {
@@ -64,6 +67,10 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	else
 		flags = GPIOD_OUT_LOW;
 
+	ret = of_property_read_u32(pdev->dev.of_node, "timeout", &timeout);
+	if (ret)
+		timeout = DEFAULT_TIMEOUT_MS;
+
 	reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
 	if (IS_ERR(reset_gpio))
 		return PTR_ERR(reset_gpio);
-- 
2.16.1
