Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCTWeY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:34:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34091 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeCTWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:51 -0400
X-Google-Smtp-Source: AG47ELtTRmp/Es3U2MBWYkxBBCWHtySIn8QeLrVtj87ftOJQ7ZzB3JRoeS1cPAU8vb5X9T8mqDLE7Q==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] platform/chrome: chromeos_laptop - factor out getting IRQ from DMI
Date: Tue, 20 Mar 2018 15:31:31 -0700
Message-Id: <20180320223138.234724-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will make code instantiating I2C device a bit clearer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 35 +++++++++++++++--------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 08ce7a105e768..96e962ff38e87 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -120,36 +120,47 @@ static struct i2c_board_info atmel_1664s_device = {
 	.flags		= I2C_CLIENT_WAKE,
 };
 
+static int chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
+{
+	const struct dmi_device *dmi_dev;
+	const struct dmi_dev_onboard *dev_data;
+
+	dmi_dev = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, dmi_name, NULL);
+	if (!dmi_dev) {
+		pr_err("failed to find DMI device '%s'\n", dmi_name);
+		return -ENOENT;
+	}
+
+	dev_data = dmi_dev->device_data;
+	if (!dev_data) {
+		pr_err("failed to get data from DMI for '%s'\n", dmi_name);
+		return -EINVAL;
+	}
+
+	return dev_data->instance;
+}
+
 static struct i2c_client *__add_probed_i2c_device(
 		const char *name,
 		int bus,
 		struct i2c_board_info *info,
 		const unsigned short *alt_addr_list)
 {
-	const struct dmi_device *dmi_dev;
-	const struct dmi_dev_onboard *dev_data;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client = NULL;
 	const unsigned short addr_list[] = { info->addr, I2C_CLIENT_END };
 
 	if (bus < 0)
 		return NULL;
+
 	/*
 	 * If a name is specified, look for irq platform information stashed
 	 * in DMI_DEV_TYPE_DEV_ONBOARD by the Chrome OS custom system firmware.
 	 */
 	if (name) {
-		dmi_dev = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, name, NULL);
-		if (!dmi_dev) {
-			pr_err("failed to dmi find device %s\n", name);
-			return NULL;
-		}
-		dev_data = (struct dmi_dev_onboard *)dmi_dev->device_data;
-		if (!dev_data) {
-			pr_err("failed to get data from dmi for %s\n", name);
+		info->irq = chromeos_laptop_get_irq_from_dmi(name);
+		if (info->irq < 0)
 			return NULL;
-		}
-		info->irq = dev_data->instance;
 	}
 
 	adapter = i2c_get_adapter(bus);
-- 
2.16.2.804.g6dcf76e118-goog
