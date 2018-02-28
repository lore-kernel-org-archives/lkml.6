Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeB1Hl2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:41:28 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:62786 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeB1Hl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:41:27 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
To: jdelvare@suse.com, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] hwmon: g762: handle cleanup with devm_add_action
Date: Wed, 28 Feb 2018 23:51:46 +0800
Message-Id: <1519833106-74874-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-28 15:38:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-28 15:38:16,
        Serialize complete at 2018-02-28 15:38:16
X-MAIL: mse01.zte.com.cn w1S7cNZS096475
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code and use devm_add_action() to handle cleanup.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/hwmon/g762.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 6d1208b..48e60d8 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -128,7 +128,6 @@ enum g762_regs {
 			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
 
 struct g762_data {
-	struct device *hwmon_dev;
 	struct i2c_client *client;
 	struct clk *clk;
 
@@ -1051,9 +1050,17 @@ static inline int g762_fan_init(struct device *dev)
 					 data->fan_cmd1);
 }
 
+static void g762_remove(void *data)
+{
+	struct g762_data *g762 = data;
+	struct i2c_client *client = g762->client;
+
+	g762_of_clock_disable(client);
+}
 static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct g762_data *data;
 	int ret;
 
@@ -1086,10 +1093,12 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (ret)
 		goto clock_dis;
 
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
-							    data, g762_groups);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
+	devm_add_action(dev, g762_remove, data);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, g762_groups);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
 		goto clock_dis;
 	}
 
@@ -1101,23 +1110,12 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return ret;
 }
 
-static int g762_remove(struct i2c_client *client)
-{
-	struct g762_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	g762_of_clock_disable(client);
-
-	return 0;
-}
-
 static struct i2c_driver g762_driver = {
 	.driver = {
 		.name = DRVNAME,
 		.of_match_table = of_match_ptr(g762_dt_match),
 	},
 	.probe	  = g762_probe,
-	.remove	  = g762_remove,
 	.id_table = g762_id,
 };
 
-- 
1.8.3.1
