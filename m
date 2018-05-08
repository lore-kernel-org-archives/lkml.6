Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeEHJjv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:39:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39978 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbeEHJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:39:49 -0400
X-Google-Smtp-Source: AB8JxZprBByuq6z7wdbhHJts89xIm5IYxkkC0A4HbpHH1bOffrRRmdFZ0epnOnkvAkJHuRNbm7N+Lw==
From: Lei YU <mine260309@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Lei YU <mine260309@gmail.com>
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
Date: Tue,  8 May 2018 17:39:27 +0800
Message-Id: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock source for aspeed pwm is set to 24MHz, so use the hard-coded
clock frequency instead of the one in device tree.

Otherwise, in case of the clock specified in device tree is not 24MHz,
the fan speed will be incorrect.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 693a3d5..e83b8df 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -922,7 +922,6 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	struct resource *res;
 	struct device *hwmon;
-	struct clk *clk;
 	int ret;
 
 	np = dev->of_node;
@@ -956,12 +955,10 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE_EXT, 0);
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return -ENODEV;
-	priv->clk_freq = clk_get_rate(clk);
 	aspeed_set_clock_enable(priv->regmap, true);
+	// The clock source is set to 24MHz
 	aspeed_set_clock_source(priv->regmap, 0);
+	priv->clk_freq = 24000000;
 
 	aspeed_create_type(priv);
 
-- 
2.7.4
