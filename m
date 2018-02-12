Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeBLWsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:35 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37548 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeBLWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 10/45] rtc: ds1511: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:24 +0100
Message-Id: <20180212224759.15999-11-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1511.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 1e95312a6f2e..b1e51a4c2908 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -479,13 +479,14 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	pdata->rtc->ops = &ds1511_rtc_ops;
 
 	ds1511_nvmem_cfg.priv = &pdev->dev;
-	pdata->rtc->nvmem_config = &ds1511_nvmem_cfg;
 	pdata->rtc->nvram_old_abi = true;
 
 	ret = rtc_register_device(pdata->rtc);
 	if (ret)
 		return ret;
 
+	rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
+
 	/*
 	 * if the platform has an interrupt in mind for this device,
 	 * then by all means, set it
-- 
2.16.1
