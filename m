Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeDKOjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:39:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55884 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeDKOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:38:35 -0400
X-Google-Smtp-Source: AIpwx4+PLn3dTMVK15QO5tSpj985QnPkmsksV3v+EqEugNiOPHFdKcNnLroaG8G9nARkyDzYUfrozA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/3] eeprom: at24: use devm_nvmem_register()
Date: Wed, 11 Apr 2018 16:38:26 +0200
Message-Id: <20180411143828.1046-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411143828.1046-1-brgl@bgdev.pl>
References: <20180411143828.1046-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have a managed variant of nvmem_register(). Use it
in at24_probe().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f207aea..02c9dd835547 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -685,7 +685,7 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.word_size = 1;
 	nvmem_config.size = pdata.byte_len;
 
-	at24->nvmem = nvmem_register(&nvmem_config);
+	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
 		goto err_clients;
@@ -718,8 +718,6 @@ static int at24_remove(struct i2c_client *client)
 
 	at24 = i2c_get_clientdata(client);
 
-	nvmem_unregister(at24->nvmem);
-
 	for (i = 1; i < at24->num_addresses; i++)
 		i2c_unregister_device(at24->client[i].client);
 
-- 
2.17.0
