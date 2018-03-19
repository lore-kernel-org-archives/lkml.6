Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967758AbeCSRCN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:02:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36803 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966700AbeCSQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:02 -0400
X-Google-Smtp-Source: AG47ELuJmvOm/z8z0hQXpDNnH5DcKskQjVAB8UsEkj9C+muc++2U2qA081Eqjsq7+A6s+dDa/HHoiw==
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device id
Date: Mon, 19 Mar 2018 09:10:58 -0700
Message-Id: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
I2C device id") added a function to return the standard I2C device ID.
Use that function to verify the device ID of a given device.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC:
- Compile tested only
- Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
  against all parts from a given manufacturer ?

 drivers/i2c/i2c-core-base.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 16a3b73375a6..4e4372b064f6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2009,6 +2009,40 @@ int i2c_get_device_id(const struct i2c_client *client,
 }
 EXPORT_SYMBOL_GPL(i2c_get_device_id);
 
+/**
+ * i2c_verify_device_id - verify device ID
+ * @client: The device to query
+ * @id: Expected device ID
+ *
+ * Returns negative errno on error, zero on success.
+ */
+int i2c_verify_device_id(const struct i2c_client *client,
+			 const struct i2c_device_identity *id)
+{
+	struct i2c_device_identity real_id;
+	int ret;
+
+	if (id->manufacturer_id == I2C_DEVICE_ID_NONE)
+		return 0;
+
+	ret = i2c_get_device_id(client, &real_id);
+	if (ret < 0)
+		return ret;
+
+	if (id->manufacturer_id != real_id.manufacturer_id ||
+	    id->part_id != real_id.part_id ||
+	    (id->die_revision != I2C_DEVICE_DIE_REVISION_ANY &&
+	     id->die_revision != real_id.die_revision)) {
+		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
+			real_id.manufacturer_id, real_id.part_id,
+			real_id.die_revision);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_verify_device_id);
+
 /* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 44ad14e016b5..45bae9717ecb 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -189,6 +189,8 @@ i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					  u8 command, u8 length, u8 *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
+int i2c_verify_device_id(const struct i2c_client *client,
+			 const struct i2c_device_identity *id);
 #endif /* I2C */
 
 /**
@@ -216,6 +218,7 @@ struct i2c_device_identity {
 #define I2C_DEVICE_ID_NONE                         0xffff
 	u16 part_id;
 	u8 die_revision;
+#define I2C_DEVICE_DIE_REVISION_ANY		     0xff
 };
 
 enum i2c_alert_protocol {
-- 
2.7.4
