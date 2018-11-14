Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94042086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94042086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbeKNRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:37:51 -0500
Received: from ms.tdt.de ([195.243.126.94]:57814 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeKNRhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:37:50 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 7978321971;
        Wed, 14 Nov 2018 07:27:07 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     linus.walleij@linaro.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, andy.shevchenko@gmail.com, joe@perches.com,
        chunkeey@gmail.com, piotr.krol@3mdeb.com, dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/2] kernel: Add reset button platform device for APU2/APU3
Date:   Wed, 14 Nov 2018 08:26:58 +0100
Message-Id: <20181114072658.11457-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181114072658.11457-1-fe@dev.tdt.de>
References: <20181114072658.11457-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will add a x86 platform device "gpio-keys-polled" which uses the
new gpio-apu drive for APU2 and APU3 boards from PC Engines.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 arch/x86/Kconfig               | 14 ++++++++
 arch/x86/platform/Makefile     |  1 +
 arch/x86/platform/amd/Makefile |  1 +
 arch/x86/platform/amd/apu.c    | 72 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 arch/x86/platform/amd/Makefile
 create mode 100644 arch/x86/platform/amd/apu.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d734f3c8234..97c53286fdb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2820,6 +2820,20 @@ config TS5500
 
 endif # X86_32
 
+if X86_64
+config APU
+	bool "PCEngines APU System Support"
+	help
+	  This option enables system support for the PCEngines APU platform.
+	  At present this just sets up the reset button control on
+	  APU2/APU3 boards. However, other system specific setup should
+	  get added here.
+
+	  Note: You must still enable the drivers for GPIO and LED support
+	  (GPIO_APU & LEDS_APU) to actually use the LEDs and the GPIOs
+
+endif # X86_64
+
 config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index d0e835470d01..a95d18810c29 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Platform specific code goes here
 obj-y	+= atom/
+obj-y	+= amd/
 obj-y	+= ce4100/
 obj-y	+= efi/
 obj-y	+= geode/
diff --git a/arch/x86/platform/amd/Makefile b/arch/x86/platform/amd/Makefile
new file mode 100644
index 000000000000..bf04c5799d7f
--- /dev/null
+++ b/arch/x86/platform/amd/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_APU)		+=apu.o
diff --git a/arch/x86/platform/amd/apu.c b/arch/x86/platform/amd/apu.c
new file mode 100644
index 000000000000..a4b695881177
--- /dev/null
+++ b/arch/x86/platform/amd/apu.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Specific setup for PC-Engines APU2/APU3 devices
+ *
+ * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/dmi.h>
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
+static struct platform_device apu_buttons_dev = {
+	.name			= "gpio-keys-polled",
+	.id			= 1,
+	.dev = {
+		.platform_data		= &apu_buttons_data,
+	}
+};
+
+static struct platform_device *apu_devs[] __initdata = {
+		&apu_buttons_dev,
+};
+
+static void __init register_apu(void)
+{
+	/* Setup push button control through gpio-apu driver */
+	platform_add_devices(apu_devs, ARRAY_SIZE(apu_devs));
+}
+
+static int __init apu_init(void)
+{
+	if (!dmi_match(DMI_SYS_VENDOR, "PC Engines")) {
+		pr_err("No PC Engines board detected\n");
+		return -ENODEV;
+	}
+
+	if (!(dmi_match(DMI_PRODUCT_NAME, "APU2") ||
+	      dmi_match(DMI_PRODUCT_NAME, "apu2") ||
+	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2") ||
+	      dmi_match(DMI_PRODUCT_NAME, "APU3") ||
+	      dmi_match(DMI_PRODUCT_NAME, "apu3") ||
+	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu3"))) {
+		pr_err("Unknown PC Engines board: %s\n",
+			dmi_get_system_info(DMI_PRODUCT_NAME));
+		return -ENODEV;
+	}
+
+	register_apu();
+
+	return 0;
+}
+
+device_initcall(apu_init);
-- 
2.11.0

