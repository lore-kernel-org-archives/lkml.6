Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966173AbeCHTMl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:12:41 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38440 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeCHTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:35 -0500
X-Google-Smtp-Source: AG47ELs5UxkIE+lk8wigpMdYCs2T04k/4oicrkZVc14Pao0TWOsYAdxtDoe1rI5u50eZYtH6SwHjyQ==
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
Subject: [PATCH v5 10/21] nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
Date: Thu,  8 Mar 2018 11:11:54 -0800
Message-Id: <20180308191205.26943-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
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
 drivers/nvmem/meson-mx-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 41d3a3c1104e..a085563e39e3 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -233,25 +233,13 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->core_clk);
 	}
 
-	efuse->nvmem = nvmem_register(&efuse->config);
-	if (IS_ERR(efuse->nvmem))
-		return PTR_ERR(efuse->nvmem);
+	efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
 
-	platform_set_drvdata(pdev, efuse);
-
-	return 0;
-}
-
-static int meson_mx_efuse_remove(struct platform_device *pdev)
-{
-	struct meson_mx_efuse *efuse = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(efuse->nvmem);
+	return PTR_ERR_OR_ZERO(efuse->nvmem);
 }
 
 static struct platform_driver meson_mx_efuse_driver = {
 	.probe = meson_mx_efuse_probe,
-	.remove = meson_mx_efuse_remove,
 	.driver = {
 		.name = "meson-mx-efuse",
 		.of_match_table = meson_mx_efuse_match,
-- 
2.14.3
