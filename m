Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeDVJPM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:15:12 -0400
Received: from sauhun.de ([88.99.104.3]:37614 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeDVJOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:20 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dmaengine: ste_dma40: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:13 +0200
Message-Id: <20180422091415.7587-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/ste_dma40.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c2b089af0420..1bc149af990e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2889,8 +2889,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 #ifdef CONFIG_PM_SLEEP
 static int dma40_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
@@ -2904,8 +2903,7 @@ static int dma40_suspend(struct device *dev)
 
 static int dma40_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 	int ret = 0;
 
 	if (base->lcpa_regulator) {
@@ -2970,8 +2968,7 @@ static void d40_save_restore_registers(struct d40_base *base, bool save)
 
 static int dma40_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 
 	d40_save_restore_registers(base, true);
 
@@ -2985,8 +2982,7 @@ static int dma40_runtime_suspend(struct device *dev)
 
 static int dma40_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
+	struct d40_base *base = dev_get_drvdata(dev);
 
 	d40_save_restore_registers(base, false);
 
-- 
2.11.0
