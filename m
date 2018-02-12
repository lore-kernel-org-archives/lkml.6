Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932809AbeBLWsa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37532 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbeBLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:26 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/45] rtc: ds1307: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:22 +0100
Message-Id: <20180212224759.15999-9-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1307.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 923dde912f60..c146411a2099 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1696,6 +1696,11 @@ static int ds1307_probe(struct i2c_client *client,
 		}
 	}
 
+	ds1307->rtc->ops = chip->rtc_ops ?: &ds13xx_rtc_ops;
+	err = rtc_register_device(ds1307->rtc);
+	if (err)
+		return err;
+
 	if (chip->nvram_size) {
 		ds1307->nvmem_cfg.name = "ds1307_nvram";
 		ds1307->nvmem_cfg.word_size = 1;
@@ -1705,15 +1710,10 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->nvmem_cfg.reg_write = ds1307_nvram_write;
 		ds1307->nvmem_cfg.priv = ds1307;
 
-		ds1307->rtc->nvmem_config = &ds1307->nvmem_cfg;
 		ds1307->rtc->nvram_old_abi = true;
+		rtc_nvmem_register(ds1307->rtc, &ds1307->nvmem_cfg);
 	}
 
-	ds1307->rtc->ops = chip->rtc_ops ?: &ds13xx_rtc_ops;
-	err = rtc_register_device(ds1307->rtc);
-	if (err)
-		return err;
-
 	ds1307_hwmon_register(ds1307);
 	ds1307_clks_register(ds1307);
 
-- 
2.16.1
