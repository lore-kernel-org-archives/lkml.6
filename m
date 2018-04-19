Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeDSOPx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:15:53 -0400
Received: from sauhun.de ([88.99.104.3]:45342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeDSOHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:06 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 38/61] pinctrl: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:08 +0200
Message-Id: <20180419140641.27926-39-wsa+renesas@sang-engineering.com>
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

 drivers/pinctrl/pinctrl-amd.c       | 6 ++----
 drivers/pinctrl/pinctrl-at91-pio4.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 04ae139671c8..c2c7067b0660 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -777,8 +777,7 @@ static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 
 static int amd_gpio_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct amd_gpio *gpio_dev = platform_get_drvdata(pdev);
+	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
 	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	int i;
 
@@ -796,8 +795,7 @@ static int amd_gpio_suspend(struct device *dev)
 
 static int amd_gpio_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct amd_gpio *gpio_dev = platform_get_drvdata(pdev);
+	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
 	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	int i;
 
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 4b57a13758a4..7065068f73f5 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -831,8 +831,7 @@ static struct pinctrl_desc atmel_pinctrl_desc = {
 
 static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
 	int i, j;
 
 	/*
@@ -860,8 +859,7 @@ static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
 
 static int __maybe_unused atmel_pctrl_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
 	int i, j;
 
 	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
-- 
2.11.0
