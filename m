Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeBLWzM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:55:12 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37559 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932933AbeBLWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 18/45] rtc: rv8803: put struct nvmem_config on the stack
Date: Mon, 12 Feb 2018 23:47:32 +0100
Message-Id: <20180212224759.15999-19-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid allocating memory for struct nvmem_config.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index c10132d8cf2e..6fb5041f750b 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -68,7 +68,6 @@ struct rv8803_data {
 	struct mutex flags_lock;
 	u8 ctrl;
 	enum rv8803_type type;
-	struct nvmem_config nvmem_cfg;
 };
 
 static int rv8803_read_reg(const struct i2c_client *client, u8 reg)
@@ -528,6 +527,15 @@ static int rv8803_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct rv8803_data *rv8803;
 	int err, flags;
+	struct nvmem_config nvmem_cfg = {
+		.name = "rv8803_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = 1,
+		.reg_read = rv8803_nvram_read,
+		.reg_write = rv8803_nvram_write,
+		.priv = client,
+	};
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -582,21 +590,13 @@ static int rv8803_probe(struct i2c_client *client,
 		}
 	}
 
-	rv8803->nvmem_cfg.name = "rv8803_nvram",
-	rv8803->nvmem_cfg.word_size = 1,
-	rv8803->nvmem_cfg.stride = 1,
-	rv8803->nvmem_cfg.size = 1,
-	rv8803->nvmem_cfg.reg_read = rv8803_nvram_read,
-	rv8803->nvmem_cfg.reg_write = rv8803_nvram_write,
-	rv8803->nvmem_cfg.priv = client;
-
 	rv8803->rtc->ops = &rv8803_rtc_ops;
 	rv8803->rtc->nvram_old_abi = true;
 	err = rtc_register_device(rv8803->rtc);
 	if (err)
 		return err;
 
-	rtc_nvmem_register(rv8803->rtc, &rv8803->nvmem_cfg);
+	rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
 
 	err = rv8803_write_reg(rv8803->client, RV8803_EXT, RV8803_EXT_WADA);
 	if (err)
-- 
2.16.1
