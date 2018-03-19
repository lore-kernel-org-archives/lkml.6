Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966827AbeCSRCT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:02:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42622 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966704AbeCSQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:04 -0400
X-Google-Smtp-Source: AG47ELvuhnWTajMkxgf9dVVE+wM0NziWKbysmsTWFkmQCgBuHyhIxVQtM0RL9R14J/jJwZxzz7psOw==
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/2] i2c: mux: pca954x: Use API function to verify device ID
Date: Mon, 19 Mar 2018 09:10:59 -0700
Message-Id: <1521475859-16765-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use i2c_verify_device_id() to verify the device ID in the probe function.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC: Compile tested only

 drivers/i2c/muxes/i2c-mux-pca954x.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 09bafd3e68fa..80b7db26b02a 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -148,6 +148,7 @@ static const struct chip_desc chips[] = {
 		.id = {
 			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
 			.part_id = 0x10b,
+			.die_revision = I2C_DEVICE_DIE_REVISION_ANY,
 		},
 	},
 	[pca_9847] = {
@@ -157,6 +158,7 @@ static const struct chip_desc chips[] = {
 		.id = {
 			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
 			.part_id = 0x108,
+			.die_revision = I2C_DEVICE_DIE_REVISION_ANY,
 		},
 	},
 	[pca_9848] = {
@@ -165,6 +167,7 @@ static const struct chip_desc chips[] = {
 		.id = {
 			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
 			.part_id = 0x10a,
+			.die_revision = I2C_DEVICE_DIE_REVISION_ANY,
 		},
 	},
 	[pca_9849] = {
@@ -174,6 +177,7 @@ static const struct chip_desc chips[] = {
 		.id = {
 			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
 			.part_id = 0x109,
+			.die_revision = I2C_DEVICE_DIE_REVISION_ANY,
 		},
 	},
 };
@@ -400,23 +404,9 @@ static int pca954x_probe(struct i2c_client *client,
 	else
 		data->chip = &chips[id->driver_data];
 
-	if (data->chip->id.manufacturer_id != I2C_DEVICE_ID_NONE) {
-		struct i2c_device_identity id;
-
-		ret = i2c_get_device_id(client, &id);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-
-		if (!ret &&
-		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
-		     id.part_id != data->chip->id.part_id)) {
-			dev_warn(&client->dev,
-				 "unexpected device id %03x-%03x-%x\n",
-				 id.manufacturer_id, id.part_id,
-				 id.die_revision);
-			return -ENODEV;
-		}
-	}
+	ret = i2c_verify_device_id(client, &data->chip->id);
+	if (ret < 0 && ret != -EOPNOTSUPP)
+		return ret;
 
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
-- 
2.7.4
