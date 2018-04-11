Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbeDKOi5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:38:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34682 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeDKOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:38:38 -0400
X-Google-Smtp-Source: AIpwx4+igceXlaB37i+T/e2YGpfCTy5yk9CsxxT4ryXAOtz8k2fvfSfh8Z3YPzWhPNWpsOWcX7B14g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/3] eeprom: at24: provide a separate routine for creating dummy i2c clients
Date: Wed, 11 Apr 2018 16:38:28 +0200
Message-Id: <20180411143828.1046-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411143828.1046-1-brgl@bgdev.pl>
References: <20180411143828.1046-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code responsible for creating the dummy i2c clients used by
chips taking multiple slave addresses to a separate function.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 49 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 163ef7bf18e3..b00e2b5c47e8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -540,6 +540,37 @@ static void at24_remove_dummy_clients(struct at24_data *at24)
 		i2c_unregister_device(at24->client[i].client);
 }
 
+static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
+				  struct regmap_config *regmap_config)
+{
+	struct i2c_client *base_client, *dummy_client;
+	unsigned short int addr;
+	struct regmap *regmap;
+	struct device *dev;
+
+	base_client = at24->client[0].client;
+	dev = &base_client->dev;
+	addr = base_client->addr + index;
+
+	dummy_client = i2c_new_dummy(base_client->adapter,
+				     base_client->addr + index);
+	if (!dummy_client) {
+		dev_err(dev, "address 0x%02x unavailable\n", addr);
+		return -EADDRINUSE;
+	}
+
+	regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
+	if (IS_ERR(regmap)) {
+		i2c_unregister_device(dummy_client);
+		return PTR_ERR(regmap);
+	}
+
+	at24->client[index].client = dummy_client;
+	at24->client[index].regmap = regmap;
+
+	return 0;
+}
+
 static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 {
 	if (flags & AT24_FLAG_MAC) {
@@ -645,20 +676,10 @@ static int at24_probe(struct i2c_client *client)
 
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
-		at24->client[i].client = i2c_new_dummy(client->adapter,
-						       client->addr + i);
-		if (!at24->client[i].client) {
-			dev_err(dev, "address 0x%02x unavailable\n",
-				client->addr + i);
-			err = -EADDRINUSE;
-			goto err_clients;
-		}
-		at24->client[i].regmap = devm_regmap_init_i2c(
-						at24->client[i].client,
-						&regmap_config);
-		if (IS_ERR(at24->client[i].regmap)) {
-			err = PTR_ERR(at24->client[i].regmap);
-			goto err_clients;
+		err = at24_make_dummy_client(at24, i, &regmap_config);
+		if (err) {
+			at24_remove_dummy_clients(at24);
+			return err;
 		}
 	}
 
-- 
2.17.0
