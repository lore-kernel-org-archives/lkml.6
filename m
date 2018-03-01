Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965583AbeCACuf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:50:35 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:47764 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965554AbeCACud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:50:33 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
To: jdelvare@suse.com, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2] hwmon: g762: handle cleanup with devm_add_action
Date: Thu, 1 Mar 2018 19:03:22 +0800
Message-Id: <1519902202-80883-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-03-01 10:50:08,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-03-01 10:49:51,
        Serialize complete at 2018-03-01 10:49:51
X-MAIL: mse01.zte.com.cn w212o2Mw032818
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code and use devm_add_action() to handle cleanup.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/hwmon/g762.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 6d1208b..49046b4 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -128,7 +128,6 @@ enum g762_regs {
 			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
 
 struct g762_data {
-	struct device *hwmon_dev;
 	struct i2c_client *client;
 	struct clk *clk;
 
@@ -174,6 +173,9 @@ struct g762_data {
 		      */
 };
 
+static void g762_remove(void *data);
+
+
 /*
  * Convert count value from fan controller register (FAN_SET_CNT) into fan
  * speed RPM value. Note that the datasheet documents a basic formula;
@@ -626,6 +628,7 @@ static int g762_of_clock_enable(struct i2c_client *client)
 	data = i2c_get_clientdata(client);
 	data->clk = clk;
 
+	devm_add_action(&client->dev, g762_remove, data);
 	return 0;
 
  clk_unprep:
@@ -1051,9 +1054,17 @@ static inline int g762_fan_init(struct device *dev)
 					 data->fan_cmd1);
 }
 
+static void g762_remove(void *data)
+{
+	struct g762_data *g762 = data;
+
+	g762_of_clock_disable(g762->client);
+}
+
 static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct g762_data *data;
 	int ret;
 
@@ -1080,35 +1091,16 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return ret;
 	ret = g762_of_prop_import(client);
 	if (ret)
-		goto clock_dis;
+		return ret;
 	/* ... or platform_data */
 	ret = g762_pdata_prop_import(client);
 	if (ret)
-		goto clock_dis;
+		return ret;
 
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							    data, g762_groups);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto clock_dis;
-	}
-
-	return 0;
-
- clock_dis:
-	g762_of_clock_disable(client);
-
-	return ret;
-}
-
-static int g762_remove(struct i2c_client *client)
-{
-	struct g762_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	g762_of_clock_disable(client);
-
-	return 0;
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct i2c_driver g762_driver = {
@@ -1117,7 +1109,6 @@ static int g762_remove(struct i2c_client *client)
 		.of_match_table = of_match_ptr(g762_dt_match),
 	},
 	.probe	  = g762_probe,
-	.remove	  = g762_remove,
 	.id_table = g762_id,
 };
 
-- 
1.8.3.1
