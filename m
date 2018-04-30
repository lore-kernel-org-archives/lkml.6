Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeD3HiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39828 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeD3HiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:22 -0400
X-Google-Smtp-Source: AB8JxZoYxgOh0stqP0bmtDF1MFMOttAJfcog4238wtVOt+dPwXyZuvf8lt42wnH28jxXIlOiOlleBA==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] gpio: 74xx-mmio: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:08 +0200
Message-Id: <20180430073819.31827-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use of_device_get_match_data() instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-74xx-mmio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 0475e8ec96d0..49616ec815ee 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -105,27 +105,22 @@ static int mmio_74xx_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct mmio_74xx_gpio_priv *priv;
 	struct resource *res;
 	void __iomem *dat;
 	int err;
 
-	of_id = of_match_device(mmio_74xx_gpio_ids, &pdev->dev);
-	if (!of_id)
-		return -ENODEV;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dat = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dat))
 		return PTR_ERR(dat);
 
-	priv->flags = (uintptr_t) of_id->data;
-
 	err = bgpio_init(&priv->gc, &pdev->dev,
 			 DIV_ROUND_UP(MMIO_74XX_BIT_CNT(priv->flags), 8),
 			 dat, NULL, NULL, NULL, NULL, 0);
-- 
2.17.0
