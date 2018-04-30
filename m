Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeD3Hih (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37278 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeD3Hie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:34 -0400
X-Google-Smtp-Source: AB8JxZqHmZgVpPpOecRyJxR8rIrEtHdxAoswBgp9jAtSsT9QNnSrtwwh70em9we+rVDsQCW+TnqfqQ==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] gpio: syscon: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:16 +0200
Message-Id: <20180430073819.31827-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430073819.31827-1-thierry.reding@gmail.com>
References: <20180430073819.31827-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use of_device_get_match_data() instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-syscon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 537cec7583fc..2512acd99027 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -182,20 +182,15 @@ MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
 static int syscon_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct syscon_gpio_priv *priv;
 	struct device_node *np = dev->of_node;
 	int ret;
 
-	of_id = of_match_device(syscon_gpio_ids, dev);
-	if (!of_id)
-		return -ENODEV;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->data = of_id->data;
+	priv->data = of_device_get_match_data(dev);
 
 	if (priv->data->compatible) {
 		priv->syscon = syscon_regmap_lookup_by_compatible(
-- 
2.17.0
