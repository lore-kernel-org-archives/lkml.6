Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933239AbeBLWs5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:57 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37586 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932965AbeBLWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:39 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 33/45] rtc: ds1742: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:47 +0100
Message-Id: <20180212224759.15999-34-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1742.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 3abf1cbfb8ce..84e19fe2ca3b 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -196,11 +196,17 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 
 	pdata->last_jiffies = jiffies;
 	platform_set_drvdata(pdev, pdata);
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				  &ds1742_rtc_ops, THIS_MODULE);
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &ds1742_rtc_ops;
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		return ret;
+
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &pdata->nvram_attr);
 	if (ret)
 		dev_err(&pdev->dev, "Unable to create sysfs entry: %s\n",
-- 
2.16.1
