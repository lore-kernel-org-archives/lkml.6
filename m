Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47394C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8472243E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8472243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeKOXkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:40:18 -0500
Received: from ms.tdt.de ([195.243.126.94]:34254 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388290AbeKOXkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:40:17 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id BDAE021A66;
        Thu, 15 Nov 2018 13:32:22 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        piotr.krol@3mdeb.com, Eckert.Florian@googlemail.com,
        dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v4 2/2] platform: Add reset button device for PC Engines APU boards
Date:   Thu, 15 Nov 2018 14:32:01 +0100
Message-Id: <20181115133201.29092-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181115133201.29092-1-fe@dev.tdt.de>
References: <20181115133201.29092-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform/x86 device "gpio-keys-polled" for the frontpanel reset button.
This device uses the gpio-apu driver for APU borads from PC Engines.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/platform/x86/Kconfig                  |  11 +++
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/pcengines-apu-platform.c | 114 ++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/platform/x86/pcengines-apu-platform.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 54f6a40c75c6..5cd27c2174cb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1288,6 +1288,17 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config PCENGINES_APU_PLATFORM
+	bool "PCEngines APU System Support"
+	depends on X86_64 && DMI && GPIOLIB
+	help
+	  This option enables system support for the PCEngines APU platform.
+	  At present this just adds the GPIO reset button platform device on
+	  APU2/APU3 boards.
+
+	  Note: You must still enable the drivers for GPIO and LED support
+	  (GPIO_APU & LEDS_APU) to actually use the LEDs and the GPIOs.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 39ae94135406..f899cc4c6b48 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -96,3 +96,4 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)	+= intel_atomisp2_pm.o
+obj-$(CONFIG_PCENGINES_APU_PLATFORM)	+= pcengines-apu-platform.o
diff --git a/drivers/platform/x86/pcengines-apu-platform.c b/drivers/platform/x86/pcengines-apu-platform.c
new file mode 100644
index 000000000000..3bfbaa93cb11
--- /dev/null
+++ b/drivers/platform/x86/pcengines-apu-platform.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Specific setup for PC-Engines APU2/APU3 devices
+ *
+ * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
+ */
+
+#include <linux/dmi.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static const struct dmi_system_id apu2_gpio_dmi_table[] __initconst = {
+	/* PC Engines APU2 with "Legacy" bios < 4.0.8 */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU2")
+		}
+	},
+	/* PC Engines APU2 with "Legacy" bios >= 4.0.8 */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu2")
+		}
+	},
+	/* PC Engines APU2 with "Mainline" bios */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
+		}
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, apu2_gpio_dmi_table);
+
+static const struct dmi_system_id apu3_gpio_dmi_table[] __initconst = {
+	/* PC Engines APU3 with "Legacy" bios < 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		}
+	},
+	/* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu3")
+		}
+	},
+	/* PC Engines APU3 with "Mainline" bios */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
+		}
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, apu3_gpio_dmi_table);
+
+
+static struct gpio_keys_button apu_gpio_buttons[] = {
+	{
+		.code			= KEY_RESTART,
+		.gpio			= 20,
+		.active_low		= 1,
+		.desc			= "Reset button",
+		.type			= EV_KEY,
+		.debounce_interval	= 60,
+	}
+};
+
+static struct gpio_keys_platform_data apu_buttons_data = {
+	.buttons		= apu_gpio_buttons,
+	.nbuttons		= ARRAY_SIZE(apu_gpio_buttons),
+	.poll_interval		= 20,
+};
+
+static struct platform_device apu_button_dev = {
+	.name			= "gpio-keys-polled",
+	.id			= 1,
+	.dev = {
+		.platform_data		= &apu_buttons_data,
+	}
+};
+
+static int __init apu_init(void)
+{
+	if (!(dmi_check_system(apu2_gpio_dmi_table)) &&
+		!(dmi_check_system(apu3_gpio_dmi_table))) {
+		return -ENODEV;
+	}
+
+	return platform_device_register(&apu_button_dev);
+}
+
+static void __exit apu_exit(void)
+{
+	platform_device_unregister(&apu_button_dev);
+}
+
+module_init(apu_init);
+module_exit(apu_exit);
-- 
2.11.0

