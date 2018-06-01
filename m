Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeFAPO4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:14:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55832 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeFAPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:14:40 -0400
X-Google-Smtp-Source: ADUXVKIaWqloqvDBu6YjcSqJVOpIU5J46neMwtUek2ZHV/fxPe9DGHPXdNpgsbNeTTgmkZ7VXP4IMQ==
From: Bastian Germann <bastiangermann@fishpost.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bastian Germann <bastiangermann@fishpost.de>,
        Luca Tettamanti <kronos.it@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] hwmon: (asus_atk0110) Make use of device managed memory
Date: Fri,  1 Jun 2018 17:14:19 +0200
Message-Id: <20180601151419.15820-3-bastiangermann@fishpost.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601151419.15820-1-bastiangermann@fishpost.de>
References: <8afcabf0-94c2-8068-5252-491494108a0c@roeck-us.net>
 <20180601151419.15820-1-bastiangermann@fishpost.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* variants of kstrdup and kzalloc. Get rid of kfree cleanups.

Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>
---
 drivers/hwmon/asus_atk0110.c | 44 +++++++-----------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 33748cc07acc..91af065d0e4d 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -190,7 +190,6 @@ static int atk_add(struct acpi_device *device);
 static int atk_remove(struct acpi_device *device);
 static void atk_print_sensor(struct atk_data *data, union acpi_object *obj);
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value);
-static void atk_free_sensors(struct atk_data *data);
 
 static struct acpi_driver atk_driver = {
 	.name	= ATK_HID,
@@ -906,15 +905,13 @@ static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 	limit1 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT1);
 	limit2 = atk_get_pack_member(data, obj, HWMON_PACK_LIMIT2);
 
-	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return -ENOMEM;
 
-	sensor->acpi_name = kstrdup(name->string.pointer, GFP_KERNEL);
-	if (!sensor->acpi_name) {
-		err = -ENOMEM;
-		goto out;
-	}
+	sensor->acpi_name = devm_kstrdup(dev, name->string.pointer, GFP_KERNEL);
+	if (!sensor->acpi_name)
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&sensor->list);
 	sensor->type = type;
@@ -955,9 +952,6 @@ static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 	(*num)++;
 
 	return 1;
-out:
-	kfree(sensor);
-	return err;
 }
 
 static int atk_enumerate_old_hwmon(struct atk_data *data)
@@ -998,8 +992,7 @@ static int atk_enumerate_old_hwmon(struct atk_data *data)
 		dev_warn(dev, METHOD_OLD_ENUM_TMP ": ACPI exception: %s\n",
 				acpi_format_exception(status));
 
-		ret = -ENODEV;
-		goto cleanup;
+		return -ENODEV;
 	}
 
 	pack = buf.pointer;
@@ -1020,8 +1013,7 @@ static int atk_enumerate_old_hwmon(struct atk_data *data)
 		dev_warn(dev, METHOD_OLD_ENUM_FAN ": ACPI exception: %s\n",
 				acpi_format_exception(status));
 
-		ret = -ENODEV;
-		goto cleanup;
+		return -ENODEV;
 	}
 
 	pack = buf.pointer;
@@ -1035,9 +1027,6 @@ static int atk_enumerate_old_hwmon(struct atk_data *data)
 	ACPI_FREE(buf.pointer);
 
 	return count;
-cleanup:
-	atk_free_sensors(data);
-	return ret;
 }
 
 static int atk_ec_present(struct atk_data *data)
@@ -1213,17 +1202,6 @@ static int atk_init_attribute_groups(struct atk_data *data)
 	return 0;
 }
 
-static void atk_free_sensors(struct atk_data *data)
-{
-	struct list_head *head = &data->sensor_list;
-	struct atk_sensor_data *s, *tmp;
-
-	list_for_each_entry_safe(s, tmp, head, list) {
-		kfree(s->acpi_name);
-		kfree(s);
-	}
-}
-
 static int atk_register_hwmon(struct atk_data *data)
 {
 	struct device *dev = &data->acpi_dev->dev;
@@ -1323,7 +1301,7 @@ static int atk_add(struct acpi_device *device)
 
 	dev_dbg(&device->dev, "adding...\n");
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&device->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1375,18 +1353,15 @@ static int atk_add(struct acpi_device *device)
 		goto out;
 	err = atk_register_hwmon(data);
 	if (err)
-		goto cleanup;
+		goto out;
 
 	atk_debugfs_init(data);
 
 	device->driver_data = data;
 	return 0;
-cleanup:
-	atk_free_sensors(data);
 out:
 	if (data->disable_ec)
 		atk_ec_ctl(data, 0);
-	kfree(data);
 	return err;
 }
 
@@ -1399,7 +1374,6 @@ static int atk_remove(struct acpi_device *device)
 
 	atk_debugfs_cleanup(data);
 
-	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
 
 	if (data->disable_ec) {
@@ -1407,8 +1381,6 @@ static int atk_remove(struct acpi_device *device)
 			dev_err(&device->dev, "Failed to disable EC\n");
 	}
 
-	kfree(data);
-
 	return 0;
 }
 
-- 
2.17.1
