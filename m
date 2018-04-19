Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDSOPf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:15:35 -0400
Received: from sauhun.de ([88.99.104.3]:45416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753503AbeDSOHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:06 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Subject: [PATCH 39/61] pinctrl: intel: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:09 +0200
Message-Id: <20180419140641.27926-40-wsa+renesas@sang-engineering.com>
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

 drivers/pinctrl/intel/pinctrl-baytrail.c   | 6 ++----
 drivers/pinctrl/intel/pinctrl-cherryview.c | 6 ++----
 drivers/pinctrl/intel/pinctrl-intel.c      | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 6b52ea1440a6..71dadf8081af 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1848,8 +1848,7 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int byt_gpio_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct byt_gpio *vg = platform_get_drvdata(pdev);
+	struct byt_gpio *vg = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < vg->soc_data->npins; i++) {
@@ -1877,8 +1876,7 @@ static int byt_gpio_suspend(struct device *dev)
 
 static int byt_gpio_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct byt_gpio *vg = platform_get_drvdata(pdev);
+	struct byt_gpio *vg = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < vg->soc_data->npins; i++) {
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index b1ae1618fefe..dd9b2554548f 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1752,8 +1752,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int chv_pinctrl_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct chv_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct chv_pinctrl *pctrl = dev_get_drvdata(dev);
 	unsigned long flags;
 	int i;
 
@@ -1786,8 +1785,7 @@ static int chv_pinctrl_suspend_noirq(struct device *dev)
 
 static int chv_pinctrl_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct chv_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct chv_pinctrl *pctrl = dev_get_drvdata(dev);
 	unsigned long flags;
 	int i;
 
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 1e24a6b8a64e..04a052292619 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1409,8 +1409,7 @@ static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned pin)
 
 int intel_pinctrl_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	struct intel_community_context *communities;
 	struct intel_pad_context *pads;
 	int i;
@@ -1471,8 +1470,7 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
 
 int intel_pinctrl_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	const struct intel_community_context *communities;
 	const struct intel_pad_context *pads;
 	int i;
-- 
2.11.0
