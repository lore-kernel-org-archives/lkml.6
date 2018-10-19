Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBCECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB29821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB29821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJTBcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:32:06 -0400
Received: from mr41.theemaillaundry.net ([109.169.43.45]:38084 "EHLO
        mr41.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeJTBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:32:05 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 21:32:03 EDT
Received: from mr40.theemaillaundry.net (mr40.theemaillaundry.net [109.169.43.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr41.theemaillaundry.net (Postfix) with ESMTPS id 1E0AD204BA;
        Fri, 19 Oct 2018 18:16:06 +0100 (IST)
Received: from mr30.theemaillaundry.net (mr30.theemaillaundry.net [78.46.72.43])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr40.theemaillaundry.net (Postfix) with ESMTPS id 7BED73FE19;
        Fri, 19 Oct 2018 18:16:04 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mr30.theemaillaundry.net (Postfix) with ESMTP id 96CA92416CA;
        Fri, 19 Oct 2018 18:16:02 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr30.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr30.theemaillaundry.net ([127.0.0.1])
        by localhost (mr30.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M_MtmGFBGKEi; Fri, 19 Oct 2018 18:16:01 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr30.theemaillaundry.net (Postfix) with ESMTPS id 801872414F6;
        Fri, 19 Oct 2018 18:16:01 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gDYNT-0005CM-LS; Fri, 19 Oct 2018 18:16:01 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v2 2/3] leds: upboard: Add LED support
Date:   Fri, 19 Oct 2018 18:15:33 +0100
Message-Id: <1539969334-24577-3-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539969334-24577-1-git-send-email-dan@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Arteaga <javier@emutex.com>

Allow userspace to use the on-board LEDs as "upboard:<color>:".

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Javier Arteaga <javier@emutex.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/leds/Kconfig        |  10 +++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-upboard.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 44097a3..0ed8857 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -756,6 +756,16 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP Squared"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD
+	help
+	  This option enables support for the LEDs on the UP Squared board.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 420b5d2..c85f18f 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 0000000..34a6973
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// UP Board LED driver
+//
+// Copyright (c) 2018, Emutex Ltd.
+//
+// Author: Javier Arteaga <javier@emutex.com>
+//
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/upboard.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/acpi.h>
+
+#define to_upboard_led(cdev) container_of(cdev, struct upboard_led, cdev)
+
+static const char * const upboard_led_names[] = {
+	"upboard:blue:",
+	"upboard:yellow:",
+	"upboard:green:",
+	"upboard:red:",
+};
+
+struct upboard_led {
+	struct regmap_field *field;
+	struct led_classdev cdev;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = to_upboard_led(cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+}
+
+static void upboard_led_brightness_set(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct upboard_led *led = to_upboard_led(cdev);
+
+	regmap_field_write(led->field, brightness);
+}
+
+static int upboard_led_probe(struct platform_device *pdev)
+{
+	unsigned int led_index = pdev->id;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct upboard_led *led;
+	struct regmap *regmap;
+	struct reg_field conf = {
+		.reg = UPBOARD_REG_FUNC_EN0,
+		.lsb = led_index,
+		.msb = led_index,
+	};
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev || strcmp(acpi_device_hid(adev), "AANT0F01"))
+		return -ENODEV;
+
+	if (led_index >= ARRAY_SIZE(upboard_led_names))
+		return -EINVAL;
+
+	if (!dev->parent)
+		return -EINVAL;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -EINVAL;
+
+	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->field = devm_regmap_field_alloc(dev, regmap, conf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = upboard_led_names[led_index];
+
+	return devm_led_classdev_register(dev, &led->cdev);
+}
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_ALIAS("platform:upboard-led");
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

