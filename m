Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeBLWvX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:51:23 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37599 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeBLWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:48 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 43/45] rtc: tx4939: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:57 +0100
Message-Id: <20180212224759.15999-44-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 1f4013d8ae7b..75c3887fbc6c 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -283,10 +283,16 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 	if (devm_request_irq(&pdev->dev, irq, tx4939_rtc_interrupt,
 			     0, pdev->name, &pdev->dev) < 0)
 		return -EBUSY;
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				  &tx4939_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
+
+	rtc->ops = &tx4939_rtc_ops;
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		return ret;
+
 	pdata->rtc = rtc;
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
 
-- 
2.16.1
