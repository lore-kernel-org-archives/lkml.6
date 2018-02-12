Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeBLW5a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:57:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37549 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932693AbeBLWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 11/45] rtc: ds1511: put ds1511_nvmem_cfg on the stack
Date: Mon, 12 Feb 2018 23:47:25 +0100
Message-Id: <20180212224759.15999-12-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ds1511_nvmem_cfg to the stack of ds1511_rtc_probe. This results in a
very small code size reduction and make it safer on systems with two
similar RTCs:

   text	   data	    bss	    dec	    hex	filename
   2128	    164	      4	   2296	    8f8	drivers/rtc/rtc-ds1511.o.before
   2175	    100	      4	   2279	    8e7	drivers/rtc/rtc-ds1511.o.after

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index b1e51a4c2908..5f55214db9f8 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -422,20 +422,20 @@ static int ds1511_nvram_write(void *priv, unsigned int pos, void *buf,
 	return 0;
 }
 
-static struct nvmem_config ds1511_nvmem_cfg = {
-	.name = "ds1511_nvram",
-	.word_size = 1,
-	.stride = 1,
-	.size = DS1511_RAM_MAX,
-	.reg_read = ds1511_nvram_read,
-	.reg_write = ds1511_nvram_write,
-};
-
 static int ds1511_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct rtc_plat_data *pdata;
 	int ret = 0;
+	struct nvmem_config ds1511_nvmem_cfg = {
+		.name = "ds1511_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = DS1511_RAM_MAX,
+		.reg_read = ds1511_nvram_read,
+		.reg_write = ds1511_nvram_write,
+		.priv = &pdev->dev,
+	};
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -478,7 +478,6 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc->ops = &ds1511_rtc_ops;
 
-	ds1511_nvmem_cfg.priv = &pdev->dev;
 	pdata->rtc->nvram_old_abi = true;
 
 	ret = rtc_register_device(pdata->rtc);
-- 
2.16.1
