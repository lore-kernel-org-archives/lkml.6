Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeBLWwU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:52:20 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37595 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbeBLWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:48 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 38/45] rtc: stk17ta8: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:52 +0100
Message-Id: <20180212224759.15999-39-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stk17ta8.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 39a80491e567..f936accf622f 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -328,11 +328,16 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				  &stk17ta8_rtc_ops, THIS_MODULE);
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(pdata->rtc))
 		return PTR_ERR(pdata->rtc);
 
+	pdata->rtc->ops = &stk17ta8_rtc_ops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret)
+		return ret;
+
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
 
 	return ret;
-- 
2.16.1
