Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeEHHMQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:12:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46955 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeEHHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:12:15 -0400
X-Google-Smtp-Source: AB8JxZpry23vDbDmORu6EMDB7xphQ05A+Ofod6CyYu+S4Y/wJdSFodoGk7AM4KnZsmAIAmZ0CoDyJA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: morbidrsa@gmail.com, wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] watchdog: mena21_wdt: Drop unnecessary mutex lock
Date: Tue,  8 May 2018 15:12:06 +0800
Message-Id: <20180508071206.13375-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a mutex in the watchdog core which serializes
calls to the various API functions. 
So the mutex lock "drv->lock" is unnecessary and can be dropped.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/watchdog/mena21_wdt.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 25d5d2b8cfbe..0be7f50e8ff9 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -31,7 +31,6 @@ enum a21_wdt_gpios {
 
 struct a21_wdt_drv {
 	struct watchdog_device wdt;
-	struct mutex lock;
 	unsigned gpios[NUM_GPIOS];
 };
 
@@ -55,12 +54,8 @@ static int a21_wdt_start(struct watchdog_device *wdt)
 {
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
-	mutex_lock(&drv->lock);
-
 	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 1);
 
-	mutex_unlock(&drv->lock);
-
 	return 0;
 }
 
@@ -68,12 +63,8 @@ static int a21_wdt_stop(struct watchdog_device *wdt)
 {
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
-	mutex_lock(&drv->lock);
-
 	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 0);
 
-	mutex_unlock(&drv->lock);
-
 	return 0;
 }
 
@@ -81,14 +72,10 @@ static int a21_wdt_ping(struct watchdog_device *wdt)
 {
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
-	mutex_lock(&drv->lock);
-
 	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 0);
 	ndelay(10);
 	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 1);
 
-	mutex_unlock(&drv->lock);
-
 	return 0;
 }
 
@@ -108,8 +95,6 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 		return -EINVAL;
 	}
 
-	mutex_lock(&drv->lock);
-
 	if (timeout == 1)
 		gpio_set_value(drv->gpios[GPIO_WD_FAST], 1);
 	else
@@ -117,8 +102,6 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 
 	wdt->timeout = timeout;
 
-	mutex_unlock(&drv->lock);
-
 	return 0;
 }
 
@@ -191,7 +174,6 @@ static int a21_wdt_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	mutex_init(&drv->lock);
 	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
 	watchdog_set_nowayout(&a21_wdt, nowayout);
 	watchdog_set_drvdata(&a21_wdt, drv);
-- 
2.17.0
