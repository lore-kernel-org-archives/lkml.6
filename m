Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeDSOKc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:10:32 -0400
Received: from sauhun.de ([88.99.104.3]:45626 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753553AbeDSOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:12 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 50/61] thermal: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:20 +0200
Message-Id: <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/rockchip_thermal.c | 8 +++-----
 drivers/thermal/spear_thermal.c    | 8 +++-----
 drivers/thermal/zx2967_thermal.c   | 6 ++----
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f36375d5a16c..9c7643d62ed7 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1327,8 +1327,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 
 static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
+	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
@@ -1346,8 +1345,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 
 static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
+	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
 	int i;
 	int error;
 
@@ -1376,7 +1374,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 					      id, thermal->regs,
 					      thermal->tshut_temp);
 		if (error)
-			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
+			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
 				__func__, thermal->tshut_temp, error);
 	}
 
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 81b35aace9de..8b9d567134d0 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -56,8 +56,7 @@ static struct thermal_zone_device_ops ops = {
 
 static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 
@@ -73,15 +72,14 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
 
 static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 	int ret = 0;
 
 	ret = clk_enable(stdev->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't enable clock\n");
+		dev_err(dev, "Can't enable clock\n");
 		return ret;
 	}
 
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 6acce0bce7c0..145ebf371598 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -207,8 +207,7 @@ MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
 #ifdef CONFIG_PM_SLEEP
 static int zx2967_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
 
 	if (priv && priv->clk_topcrm)
 		clk_disable_unprepare(priv->clk_topcrm);
@@ -221,8 +220,7 @@ static int zx2967_thermal_suspend(struct device *dev)
 
 static int zx2967_thermal_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
 	int error;
 
 	error = clk_prepare_enable(priv->clk_topcrm);
-- 
2.11.0
