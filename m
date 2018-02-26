Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBZTeu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:34:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:41935 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbeBZTes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:34:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="21214077"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1] extcon: int3496: Ignore incorrect IoRestriction for ID pin
Date: Mon, 26 Feb 2018 21:34:44 +0200
Message-Id: <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 70216fd937fe introduced a workaround for incorrect
IoRestriction mode in ACPI table.

Now, when GPIO ACPI library does it in generic way, just set
an appropriate quirk flag instead.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-int3496.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index 191e99f06a9a..acaccb128fc4 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -50,7 +50,11 @@ static const struct acpi_gpio_params vbus_gpios = { INT3496_GPIO_VBUS_EN, 0, fal
 static const struct acpi_gpio_params mux_gpios = { INT3496_GPIO_USB_MUX, 0, false };
 
 static const struct acpi_gpio_mapping acpi_int3496_default_gpios[] = {
-	{ "id-gpios", &id_gpios, 1 },
+	/*
+	 * Some platforms have a bug in ACPI GPIO description making IRQ
+	 * GPIO to be output only. Ask the GPIO core to ignore this limit.
+	 */
+	{ "id-gpios", &id_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
 	{ "vbus-gpios", &vbus_gpios, 1 },
 	{ "mux-gpios", &mux_gpios, 1 },
 	{ },
@@ -112,9 +116,6 @@ static int int3496_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->gpio_usb_id);
 		dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
 		return ret;
-	} else if (gpiod_get_direction(data->gpio_usb_id) != GPIOF_DIR_IN) {
-		dev_warn(dev, FW_BUG "USB ID GPIO not in input mode, fixing\n");
-		gpiod_direction_input(data->gpio_usb_id);
 	}
 
 	data->usb_id_irq = gpiod_to_irq(data->gpio_usb_id);
-- 
2.16.1
