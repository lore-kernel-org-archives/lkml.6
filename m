Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeB1OnU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:43:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43228 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbeB1Olu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:50 -0500
X-Google-Smtp-Source: AG47ELvzU6SuD3UUX7EaUZ+rYpY54KROsAYjY5eDpl9hNldpKxYjMOptz1vmkp8nLvV2uE3ozkkzNg==
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
Subject: [PATCH v4 18/22] nvmem: rockchip-efuse: Make use of of_device_get_match_data()
Date: Wed, 28 Feb 2018 06:41:02 -0800
Message-Id: <20180228144106.16363-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228144106.16363-1-andrew.smirnov@gmail.com>
References: <20180228144106.16363-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code a bit by using of_device_get_match_data() instead of
of_match_device().

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
index 8ebb103abe23..ca686f8f5166 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -259,11 +259,11 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct rockchip_efuse_chip *efuse;
-	const struct of_device_id *match;
+	const void *data;
 	struct device *dev = &pdev->dev;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	data = of_device_get_match_data(dev);
+	if (!data) {
 		dev_err(dev, "failed to get match data\n");
 		return -EINVAL;
 	}
@@ -286,7 +286,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
 				 &econfig.size))
 		econfig.size = resource_size(res);
-	econfig.reg_read = match->data;
+	econfig.reg_read = data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
 	nvmem = devm_nvmem_register(dev, &econfig);
-- 
2.14.3
