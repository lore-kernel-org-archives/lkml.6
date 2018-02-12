Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbeBLWzv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:55:51 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37553 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeBLWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 15/45] rtc: pcf85363: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:29 +0100
Message-Id: <20180212224759.15999-16-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call rtc_nvmem_register instead of letting the core do it and stop using
the nvmem_config member of struct rtc_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index ea04e9f0930b..a1fe833d2431 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -164,6 +164,7 @@ static int pcf85363_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct pcf85363 *pcf85363;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -193,10 +194,13 @@ static int pcf85363_probe(struct i2c_client *client,
 	pcf85363->nvmem_cfg.reg_read = pcf85363_nvram_read;
 	pcf85363->nvmem_cfg.reg_write = pcf85363_nvram_write;
 	pcf85363->nvmem_cfg.priv = pcf85363;
-	pcf85363->rtc->nvmem_config = &pcf85363->nvmem_cfg;
 	pcf85363->rtc->ops = &rtc_ops;
 
-	return rtc_register_device(pcf85363->rtc);
+	ret = rtc_register_device(pcf85363->rtc);
+
+	rtc_nvmem_register(pcf85363->rtc, &pcf85363->nvmem_cfg);
+
+	return ret;
 }
 
 static const struct of_device_id dev_ids[] = {
-- 
2.16.1
