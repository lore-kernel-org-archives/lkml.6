Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeB1OpV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:45:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42785 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbeB1Olm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:42 -0500
X-Google-Smtp-Source: AG47ELtQuSvdsxcwSmJtpipQmvMr9uS6DTfNcx+zBzrLbEGN88IlK7jlRpTdWKbkJAhUunW85IaDYw==
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
Subject: [PATCH v4 12/22] nvmem: meson-efuse: Convert to use devm_nvmem_register()
Date: Wed, 28 Feb 2018 06:40:56 -0800
Message-Id: <20180228144106.16363-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228144106.16363-1-andrew.smirnov@gmail.com>
References: <20180228144106.16363-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all of the code related to .remove hook and make use of
devm_nvmem_register() instead.

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
 drivers/nvmem/meson-efuse.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index a43c68f90937..66029fc85ba9 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -60,25 +60,15 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig.reg_read = meson_efuse_read;
 	econfig.size = size;
 
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int meson_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct platform_driver meson_efuse_driver = {
 	.probe = meson_efuse_probe,
-	.remove = meson_efuse_remove,
 	.driver = {
 		.name = "meson-efuse",
 		.of_match_table = meson_efuse_match,
-- 
2.14.3
