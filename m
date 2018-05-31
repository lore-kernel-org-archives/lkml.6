Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeEaVKE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:10:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34460 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeEaVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:10:02 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] rtc: test: allow registering many devices
Date: Thu, 31 May 2018 23:09:56 +0200
Message-Id: <20180531210959.2472-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
References: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a loop to register RTC devices

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index f0eb8e0c5055..796c45dee661 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -13,7 +13,9 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-static struct platform_device *test0 = NULL, *test1 = NULL;
+#define MAX_RTC_TEST 3
+
+struct platform_device *pdev[MAX_RTC_TEST];
 
 static int test_rtc_read_alarm(struct device *dev,
 	struct rtc_wkalrm *alrm)
@@ -122,47 +124,45 @@ static struct platform_driver test_driver = {
 
 static int __init test_init(void)
 {
-	int err;
+	int i, err;
 
 	if ((err = platform_driver_register(&test_driver)))
 		return err;
 
-	if ((test0 = platform_device_alloc("rtc-test", 0)) == NULL) {
-		err = -ENOMEM;
-		goto exit_driver_unregister;
+	err = -ENOMEM;
+	for (i = 0; i < MAX_RTC_TEST; i++) {
+		pdev[i] = platform_device_alloc("rtc-test", i);
+		if (!pdev[i])
+			goto exit_free_mem;
 	}
 
-	if ((test1 = platform_device_alloc("rtc-test", 1)) == NULL) {
-		err = -ENOMEM;
-		goto exit_put_test0;
+	for (i = 0; i < MAX_RTC_TEST; i++) {
+		err = platform_device_add(pdev[i]);
+		if (err)
+			goto exit_device_del;
 	}
 
-	if ((err = platform_device_add(test0)))
-		goto exit_put_test1;
-
-	if ((err = platform_device_add(test1)))
-		goto exit_del_test0;
-
 	return 0;
 
-exit_del_test0:
-	platform_device_del(test0);
+exit_device_del:
+	for (; i > 0; i--)
+		platform_device_del(pdev[i - 1]);
 
-exit_put_test1:
-	platform_device_put(test1);
+exit_free_mem:
+	for (i = 0; i < MAX_RTC_TEST; i++)
+		platform_device_put(pdev[i]);
 
-exit_put_test0:
-	platform_device_put(test0);
-
-exit_driver_unregister:
 	platform_driver_unregister(&test_driver);
 	return err;
 }
 
 static void __exit test_exit(void)
 {
-	platform_device_unregister(test0);
-	platform_device_unregister(test1);
+	int i;
+
+	for (i = 0; i < MAX_RTC_TEST; i++)
+		platform_device_unregister(pdev[i]);
+
 	platform_driver_unregister(&test_driver);
 }
 
-- 
2.17.0
