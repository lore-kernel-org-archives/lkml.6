Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbeBLWzu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:55:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37557 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932930AbeBLWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 16/45] rtc: pcf85363: put struct nvmem_config on the stack
Date: Mon, 12 Feb 2018 23:47:30 +0100
Message-Id: <20180212224759.15999-17-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid allocating memory for struct nvmem_config.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index a1fe833d2431..64573cccf7fe 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -80,7 +80,6 @@ static struct i2c_driver pcf85363_driver;
 struct pcf85363 {
 	struct device		*dev;
 	struct rtc_device	*rtc;
-	struct nvmem_config	nvmem_cfg;
 	struct regmap		*regmap;
 };
 
@@ -164,6 +163,14 @@ static int pcf85363_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct pcf85363 *pcf85363;
+	struct nvmem_config nvmem_cfg = {
+		.name = "pcf85363-",
+		.word_size = 1,
+		.stride = 1,
+		.size = NVRAM_SIZE,
+		.reg_read = pcf85363_nvram_read,
+		.reg_write = pcf85363_nvram_write,
+	};
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -187,18 +194,12 @@ static int pcf85363_probe(struct i2c_client *client,
 	if (IS_ERR(pcf85363->rtc))
 		return PTR_ERR(pcf85363->rtc);
 
-	pcf85363->nvmem_cfg.name = "pcf85363-";
-	pcf85363->nvmem_cfg.word_size = 1;
-	pcf85363->nvmem_cfg.stride = 1;
-	pcf85363->nvmem_cfg.size = NVRAM_SIZE;
-	pcf85363->nvmem_cfg.reg_read = pcf85363_nvram_read;
-	pcf85363->nvmem_cfg.reg_write = pcf85363_nvram_write;
-	pcf85363->nvmem_cfg.priv = pcf85363;
 	pcf85363->rtc->ops = &rtc_ops;
 
 	ret = rtc_register_device(pcf85363->rtc);
 
-	rtc_nvmem_register(pcf85363->rtc, &pcf85363->nvmem_cfg);
+	nvmem_cfg.priv = pcf85363;
+	rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg);
 
 	return ret;
 }
-- 
2.16.1
