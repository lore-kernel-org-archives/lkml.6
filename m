Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeBLWs3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37535 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbeBLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:26 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/45] rtc: ds1307: put struct nvmem_config on the stack
Date: Mon, 12 Feb 2018 23:47:23 +0100
Message-Id: <20180212224759.15999-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid allocating memory for struct nvmem_config as it is only necessary at
the nvmem registration.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index c146411a2099..4021d478b9f3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -114,7 +114,6 @@ enum ds_type {
 #	define RX8025_BIT_XST		0x20
 
 struct ds1307 {
-	struct nvmem_config	nvmem_cfg;
 	enum ds_type		type;
 	unsigned long		flags;
 #define HAS_NVRAM	0		/* bit 0 == sysfs file active */
@@ -1702,16 +1701,18 @@ static int ds1307_probe(struct i2c_client *client,
 		return err;
 
 	if (chip->nvram_size) {
-		ds1307->nvmem_cfg.name = "ds1307_nvram";
-		ds1307->nvmem_cfg.word_size = 1;
-		ds1307->nvmem_cfg.stride = 1;
-		ds1307->nvmem_cfg.size = chip->nvram_size;
-		ds1307->nvmem_cfg.reg_read = ds1307_nvram_read;
-		ds1307->nvmem_cfg.reg_write = ds1307_nvram_write;
-		ds1307->nvmem_cfg.priv = ds1307;
+		struct nvmem_config nvmem_cfg = {
+			.name = "ds1307_nvram",
+			.word_size = 1,
+			.stride = 1,
+			.size = chip->nvram_size,
+			.reg_read = ds1307_nvram_read,
+			.reg_write = ds1307_nvram_write,
+			.priv = ds1307,
+		};
 
 		ds1307->rtc->nvram_old_abi = true;
-		rtc_nvmem_register(ds1307->rtc, &ds1307->nvmem_cfg);
+		rtc_nvmem_register(ds1307->rtc, &nvmem_cfg);
 	}
 
 	ds1307_hwmon_register(ds1307);
-- 
2.16.1
