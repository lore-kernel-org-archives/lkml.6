Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966068AbeBUPNo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:13:44 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45264 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934979AbeBUPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:13:41 -0500
X-Google-Smtp-Source: AH8x225IkW5tqnICOW8yUs4PElh6zDbF9GW7Q3IIDVS6wq+Wvb/vRwoeXy3NMuGCRV2GZ4bTH4zkgw==
Date: Wed, 21 Feb 2018 16:13:37 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] platform/x86: topstar-laptop: add Topstar U931/RVP7
 WLAN LED workaround
Message-ID: <ed6c10037d1d7dd92f89da412c9ccced3a4b1571.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519225570.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Topstar U931 laptops provide a LED synced with the WLAN adapter
hard-blocking state. Unfortunately, some models seem to be defective,
making impossible to hard-block the adapter with the WLAN switch and
thus the LED is useless.

An ACPI method is available to programmatically control this switch and
it indirectly allows to control the LED.

This commit registers the LED within the corresponding subsystem, making
possible for instance to use an rfkill-based trigger to synchronize the
LED with the device state.

This workaround is enabled automatically for Topstar U931/RVP7 laptops
based on a DMI check.

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/Kconfig          |   2 +
 drivers/platform/x86/topstar-laptop.c | 108 ++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9a8f96465cdc..bc66a31757db 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -742,6 +742,8 @@ config TOPSTAR_LAPTOP
 	depends on ACPI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
+	select LEDS_CLASS
+	select NEW_LEDS
 	---help---
 	  This driver adds support for hotkeys found on Topstar laptops.
 
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 792c90d62724..bf9761092c7e 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -18,8 +18,10 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
 
 #define TOPSTAR_LAPTOP_CLASS "topstar"
@@ -28,8 +30,77 @@ struct topstar_laptop {
 	struct acpi_device *device;
 	struct platform_device *platform;
 	struct input_dev *input;
+	struct led_classdev led;
 };
 
+/*
+ * LED
+ */
+
+static enum led_brightness topstar_led_get(struct led_classdev *led)
+{
+	return led->brightness;
+}
+
+static int topstar_led_set(struct led_classdev *led,
+		enum led_brightness state)
+{
+	struct topstar_laptop *topstar = container_of(led,
+			struct topstar_laptop, led);
+
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+	unsigned long long int ret;
+	acpi_status status;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = 0x83;
+
+	/*
+	 * Topstar ACPI returns 0x30001 when the LED is ON and 0x30000 when it
+	 * is OFF.
+	 */
+	status = acpi_evaluate_integer(topstar->device->handle,
+			"GETX", &params, &ret);
+	if (ACPI_FAILURE(status))
+		return -1;
+
+	/*
+	 * FNCX(0x83) toggles the LED (more precisely, it is supposed to
+	 * act as an hardware switch and disconnect the WLAN adapter but
+	 * it seems to be faulty on some models like the Topstar U931
+	 * Notebook).
+	 */
+	if ((ret == 0x30001 && state == LED_OFF)
+			|| (ret == 0x30000 && state != LED_OFF)) {
+		status = acpi_execute_simple_method(topstar->device->handle,
+				"FNCX", 0x83);
+		if (ACPI_FAILURE(status))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int topstar_led_init(struct topstar_laptop *topstar)
+{
+	topstar->led = (struct led_classdev) {
+		.default_trigger = "rfkill0",
+		.brightness_get = topstar_led_get,
+		.brightness_set_blocking = topstar_led_set,
+		.name = TOPSTAR_LAPTOP_CLASS "::wlan",
+	};
+
+	return led_classdev_register(&topstar->platform->dev, &topstar->led);
+}
+
+static void topstar_led_exit(struct topstar_laptop *topstar)
+{
+	led_classdev_unregister(&topstar->led);
+}
+
 /*
  * Input
  */
@@ -192,11 +263,37 @@ static void topstar_acpi_exit(struct topstar_laptop *topstar)
 	topstar_acpi_fncx_switch(topstar->device, false);
 }
 
+/*
+ * Enable software-based WLAN LED control on systems with defective
+ * hardware switch.
+ */
+static bool led_workaround;
+
+static int dmi_led_workaround(const struct dmi_system_id *id)
+{
+	led_workaround = true;
+	return 0;
+}
+
+static const struct dmi_system_id topstar_dmi_ids[] = {
+	{
+		.callback = dmi_led_workaround,
+		.ident = "Topstar U931/RVP7",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "U931"),
+			DMI_MATCH(DMI_BOARD_VERSION, "RVP7"),
+		},
+	},
+	{}
+};
+
 static int topstar_acpi_add(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar;
 	int err;
 
+	dmi_check_system(topstar_dmi_ids);
+
 	topstar = kzalloc(sizeof(struct topstar_laptop), GFP_KERNEL);
 	if (!topstar)
 		return -ENOMEM;
@@ -218,8 +315,16 @@ static int topstar_acpi_add(struct acpi_device *device)
 	if (err)
 		goto err_platform_exit;
 
+	if (led_workaround) {
+		err = topstar_led_init(topstar);
+		if (err)
+			goto err_input_exit;
+	}
+
 	return 0;
 
+err_input_exit:
+	topstar_input_exit(topstar);
 err_platform_exit:
 	topstar_platform_exit(topstar);
 err_acpi_exit:
@@ -233,6 +338,9 @@ static int topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
+	if (led_workaround)
+		topstar_led_exit(topstar);
+
 	topstar_input_exit(topstar);
 	topstar_platform_exit(topstar);
 	topstar_acpi_exit(topstar);
-- 
2.16.1
