Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeD0I5C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:57:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33789 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeD0I4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:56:33 -0400
X-Google-Smtp-Source: AB8JxZrSFWQoEMyeRHfHAUnCQpGnaeVLYz/YByNAX7dolKqK1HL1JlGye9C68kbxd3lCh4HgCSpv5Q==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ASoC: tpa6130a2: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:10 +0530
Message-Id: <195792a282b569037357ca17e4baad19893f0609.1524819052.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 616cd4b..18f32b9 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -62,7 +62,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			return ret;
 		}
 		/* Power on */
-		if (data->power_gpio >= 0)
+		if (gpio_is_valid(data->power_gpio))
 			gpio_set_value(data->power_gpio, 1);
 
 		/* Sync registers */
@@ -72,7 +72,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			dev_err(data->dev,
 				"Failed to sync registers: %d\n", ret);
 			regcache_cache_only(data->regmap, true);
-			if (data->power_gpio >= 0)
+			if (gpio_is_valid(data->power_gpio))
 				gpio_set_value(data->power_gpio, 0);
 			ret2 = regulator_disable(data->supply);
 			if (ret2 != 0)
@@ -89,7 +89,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		regcache_cache_only(data->regmap, true);
 
 		/* Power off */
-		if (data->power_gpio >= 0)
+		if (gpio_is_valid(data->power_gpio))
 			gpio_set_value(data->power_gpio, 0);
 
 		ret = regulator_disable(data->supply);
@@ -259,7 +259,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 
 	data->id = id->driver_data;
 
-	if (data->power_gpio >= 0) {
+	if (gpio_is_valid(data->power_gpio)) {
 		ret = devm_gpio_request(dev, data->power_gpio,
 					"tpa6130a2 enable");
 		if (ret < 0) {
-- 
1.9.1
