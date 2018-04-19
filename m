Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeDSOJz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:09:55 -0400
Received: from sauhun.de ([88.99.104.3]:45416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbeDSOHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:15 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 57/61] video: fbdev: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:27 +0200
Message-Id: <20180419140641.27926-58-wsa+renesas@sang-engineering.com>
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

 drivers/video/fbdev/auo_k190x.c        | 12 ++++--------
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  6 ++----
 drivers/video/fbdev/sh_mobile_meram.c  |  6 ++----
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 9d24d1b3e9ef..9bf6a6e02342 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -776,8 +776,7 @@ static void auok190x_recover(struct auok190xfb_par *par)
  */
 static int __maybe_unused auok190x_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info *info = platform_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct auok190xfb_par *par = info->par;
 	struct auok190x_board *board = par->board;
 	u16 standby_param;
@@ -823,8 +822,7 @@ static int __maybe_unused auok190x_runtime_suspend(struct device *dev)
 
 static int __maybe_unused auok190x_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info *info = platform_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct auok190xfb_par *par = info->par;
 	struct auok190x_board *board = par->board;
 
@@ -857,8 +855,7 @@ static int __maybe_unused auok190x_runtime_resume(struct device *dev)
 
 static int __maybe_unused auok190x_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info *info = platform_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct auok190xfb_par *par = info->par;
 	struct auok190x_board *board = par->board;
 	int ret;
@@ -897,8 +894,7 @@ static int __maybe_unused auok190x_suspend(struct device *dev)
 
 static int __maybe_unused auok190x_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info *info = platform_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct auok190xfb_par *par = info->par;
 	struct auok190x_board *board = par->board;
 
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c3a46506e47e..86bd4090b011 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2354,8 +2354,7 @@ static int sh_mobile_lcdc_resume(struct device *dev)
 
 static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_priv *priv = dev_get_drvdata(dev);
 
 	/* turn off LCDC hardware */
 	lcdc_write(priv, _LDCNT1R, 0);
@@ -2365,8 +2364,7 @@ static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
 
 static int sh_mobile_lcdc_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_priv *priv = dev_get_drvdata(dev);
 
 	__sh_mobile_lcdc_start(priv);
 
diff --git a/drivers/video/fbdev/sh_mobile_meram.c b/drivers/video/fbdev/sh_mobile_meram.c
index baadfb207b2e..f5d8bd7ef509 100644
--- a/drivers/video/fbdev/sh_mobile_meram.c
+++ b/drivers/video/fbdev/sh_mobile_meram.c
@@ -572,8 +572,7 @@ EXPORT_SYMBOL_GPL(sh_mobile_meram_cache_update);
 #ifdef CONFIG_PM
 static int sh_mobile_meram_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	struct sh_mobile_meram_priv *priv = dev_get_drvdata(dev);
 	unsigned int i, j;
 
 	for (i = 0; i < MERAM_REGS_SIZE; i++)
@@ -596,8 +595,7 @@ static int sh_mobile_meram_suspend(struct device *dev)
 
 static int sh_mobile_meram_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	struct sh_mobile_meram_priv *priv = dev_get_drvdata(dev);
 	unsigned int i, j;
 
 	for (i = 0; i < 32; i++) {
-- 
2.11.0
