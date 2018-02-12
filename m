Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbeBLWwr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:52:47 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37592 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeBLWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 37/45] rtc: stk17ta8: make alarms useful
Date: Mon, 12 Feb 2018 23:47:51 +0100
Message-Id: <20180212224759.15999-38-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IRQs are disabled when the rtc driver is removed (e.g. when
shutting down the platform).
This means that the RTC will be unable to wakeup the platform.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stk17ta8.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index a456cb6177ea..39a80491e567 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -340,11 +340,8 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 
 static int stk17ta8_rtc_remove(struct platform_device *pdev)
 {
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-
 	sysfs_remove_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
-	if (pdata->irq > 0)
-		writeb(0, pdata->ioaddr + RTC_INTERRUPTS);
+
 	return 0;
 }
 
-- 
2.16.1
