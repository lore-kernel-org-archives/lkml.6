Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeEaOB7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:01:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35712 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755195AbeEaOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:01:51 -0400
X-Google-Smtp-Source: ADUXVKK++Ak6mZ1FHoJllZ1Z3r51eyhI+z6biZ9PdFkzw04xFerMIzSG366GpuHR3UxdtkIrqDHf4g==
From: Bastian Germann <bastiangermann@fishpost.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Bastian Germann <bastiangermann@fishpost.de>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (asus_atk0110) Remove unused manual sysfs file management
Date: Thu, 31 May 2018 16:01:36 +0200
Message-Id: <20180531140136.13969-2-bastiangermann@fishpost.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180531140136.13969-1-bastiangermann@fishpost.de>
References: <20180531140136.13969-1-bastiangermann@fishpost.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the manual sysfs file creation and deletion that are now taken care
of by the (un)register calls via an attribute_group array.

Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>
---
 drivers/hwmon/asus_atk0110.c | 46 ------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 8a35fb27ff50..2f4955ec8437 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -263,14 +263,6 @@ static ssize_t atk_limit2_show(struct device *dev,
 	return sprintf(buf, "%lld\n", value);
 }
 
-static ssize_t atk_name_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "atk0110\n");
-}
-static struct device_attribute atk_name_attr =
-		__ATTR(name, 0444, atk_name_show, NULL);
-
 static void atk_init_attribute(struct device_attribute *attr, char *name,
 		sysfs_show_func show)
 {
@@ -1194,44 +1186,6 @@ static int atk_enumerate_new_hwmon(struct atk_data *data)
 	return err;
 }
 
-static int atk_create_files(struct atk_data *data)
-{
-	struct atk_sensor_data *s;
-	int err;
-
-	list_for_each_entry(s, &data->sensor_list, list) {
-		err = device_create_file(data->hwmon_dev, &s->input_attr);
-		if (err)
-			return err;
-		err = device_create_file(data->hwmon_dev, &s->label_attr);
-		if (err)
-			return err;
-		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
-		if (err)
-			return err;
-		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
-		if (err)
-			return err;
-	}
-
-	err = device_create_file(data->hwmon_dev, &atk_name_attr);
-
-	return err;
-}
-
-static void atk_remove_files(struct atk_data *data)
-{
-	struct atk_sensor_data *s;
-
-	list_for_each_entry(s, &data->sensor_list, list) {
-		device_remove_file(data->hwmon_dev, &s->input_attr);
-		device_remove_file(data->hwmon_dev, &s->label_attr);
-		device_remove_file(data->hwmon_dev, &s->limit1_attr);
-		device_remove_file(data->hwmon_dev, &s->limit2_attr);
-	}
-	device_remove_file(data->hwmon_dev, &atk_name_attr);
-}
-
 static void atk_free_sensors(struct atk_data *data)
 {
 	struct list_head *head = &data->sensor_list;
-- 
2.17.1
