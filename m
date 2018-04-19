Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeDSOG5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:06:57 -0400
Received: from sauhun.de ([88.99.104.3]:45234 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbeDSOGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:50 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/61] bus: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:34 +0200
Message-Id: <20180419140641.27926-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/bus/brcmstb_gisb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 68ac3e93b600..f58ff67e97ac 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -150,8 +150,7 @@ static ssize_t gisb_arb_get_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	u32 timeout;
 
 	mutex_lock(&gdev->lock);
@@ -165,8 +164,7 @@ static ssize_t gisb_arb_set_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	int val, ret;
 
 	ret = kstrtoint(buf, 10, &val);
@@ -418,8 +416,7 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int brcmstb_gisb_arb_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
 
@@ -431,8 +428,7 @@ static int brcmstb_gisb_arb_suspend(struct device *dev)
  */
 static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
 
-- 
2.11.0
