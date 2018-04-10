Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeDJNMz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:12:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53745 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeDJNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:12:25 -0400
X-Google-Smtp-Source: AIpwx4/wJBh0KYzBVyTbSwJucCGyyeFE6uljB5bmDDvTcT2ZS++ecTsJXq+N2GgQzgAY8fE6TaL7jQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/4] eeprom: at24: provide and use a helper for releasing dummy i2c clients
Date: Tue, 10 Apr 2018 15:12:05 +0200
Message-Id: <20180410131206.25760-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410131206.25760-1-brgl@bgdev.pl>
References: <20180410131206.25760-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to drop two opencoded for loops. We also don't need to
check if the i2c client is NULL before calling i2c_unregister_device().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 5e56a99435c6..c57eaea181d8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -532,6 +532,14 @@ static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
 	return 0;
 }
 
+static void at24_remove_dummy_clients(struct at24_data *at24)
+{
+	int i;
+
+	for (i = 1; i < at24->num_addresses; i++)
+		i2c_unregister_device(at24->client[i].client);
+}
+
 static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 {
 	if (flags & AT24_FLAG_MAC) {
@@ -702,10 +710,7 @@ static int at24_probe(struct i2c_client *client)
 	return 0;
 
 err_clients:
-	for (i = 1; i < num_addresses; i++)
-		if (at24->client[i].client)
-			i2c_unregister_device(at24->client[i].client);
-
+	at24_remove_dummy_clients(at24);
 	pm_runtime_disable(dev);
 
 	return err;
@@ -714,13 +719,10 @@ static int at24_probe(struct i2c_client *client)
 static int at24_remove(struct i2c_client *client)
 {
 	struct at24_data *at24;
-	int i;
 
 	at24 = i2c_get_clientdata(client);
 
-	for (i = 1; i < at24->num_addresses; i++)
-		i2c_unregister_device(at24->client[i].client);
-
+	at24_remove_dummy_clients(at24);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.17.0
