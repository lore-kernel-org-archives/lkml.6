Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeB1Omf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:42:35 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45842 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeB1Olx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:53 -0500
X-Google-Smtp-Source: AH8x227m5kc5vuk3ENdPywmuZto/vVrd4OCw4EPVEQL9hrJWkhY6//pT3pEWL3gV5lJHlbl+AKKSmA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 20/22] nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
Date: Wed, 28 Feb 2018 06:41:04 -0800
Message-Id: <20180228144106.16363-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228144106.16363-1-andrew.smirnov@gmail.com>
References: <20180228144106.16363-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's "dev" variable for this already. Use it.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/rockchip-efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index ca686f8f5166..593d9b0b5506 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -268,21 +268,21 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_chip),
+	efuse = devm_kzalloc(dev, sizeof(struct rockchip_efuse_chip),
 			     GFP_KERNEL);
 	if (!efuse)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-	efuse->clk = devm_clk_get(&pdev->dev, "pclk_efuse");
+	efuse->clk = devm_clk_get(dev, "pclk_efuse");
 	if (IS_ERR(efuse->clk))
 		return PTR_ERR(efuse->clk);
 
-	efuse->dev = &pdev->dev;
+	efuse->dev = dev;
 	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
 				 &econfig.size))
 		econfig.size = resource_size(res);
-- 
2.14.3
