Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeBVXWP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:22:15 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36360 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeBVXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:22:13 -0500
X-Google-Smtp-Source: AH8x227K8cgRM2UGVJdbOGtgHmJwqsqMj0idt8lTByAlEVu56V2JuX3X3OMCeyJenaH9R2HtsEyX3Q==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 2/2] power: reset: gpio-poweroff: Support for timeout from device property
Date: Thu, 22 Feb 2018 15:17:14 -0800
Message-Id: <20180222231714.11843-2-mdf@kernel.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222231714.11843-1-mdf@kernel.org>
References: <20180222231714.11843-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading a timeout value from device property.
Fall back to previous default of 3s if nothing is specified.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
Changes from v2:
- use device_property_read_{bool,u32} instead of of equivalent

Changes from v1:
- of_property_read_u32() overwrites the output only if it succeeds,
  simplify error handling
---

 drivers/power/reset/gpio-poweroff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index be3d81ff51cc..6273ad3b411d 100644
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
+static u32 timeout = DEFAULT_TIMEOUT_MS;
 
 static void gpio_poweroff_do_poweroff(void)
 {
@@ -40,7 +42,7 @@ static void gpio_poweroff_do_poweroff(void)
 	gpiod_set_value(reset_gpio, 1);
 
 	/* give it some time */
-	mdelay(3000);
+	mdelay(timeout);
 
 	WARN_ON(1);
 }
@@ -58,12 +60,14 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	input = of_property_read_bool(pdev->dev.of_node, "input");
+	input = device_property_read_bool(&pdev->dev, "input");
 	if (input)
 		flags = GPIOD_IN;
 	else
 		flags = GPIOD_OUT_LOW;
 
+	device_property_read_u32(&pdev->dev, "timeout-ms", &timeout);
+
 	reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
 	if (IS_ERR(reset_gpio))
 		return PTR_ERR(reset_gpio);
-- 
2.16.1
