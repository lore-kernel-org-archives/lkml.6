Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966735AbeCHTOp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:14:45 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43029 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965656AbeCHTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:39 -0500
X-Google-Smtp-Source: AG47ELu64UHuhCMDtb1BnKKvytOFzqLj4cKzeXYf5Su4bMWsLG1N9vBJgAINbWX2Bbem1UDnfqJj2A==
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
Subject: [PATCH v5 12/21] nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
Date: Thu,  8 Mar 2018 11:11:56 -0800
Message-Id: <20180308191205.26943-13-andrew.smirnov@gmail.com>
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
 drivers/nvmem/lpc18xx_otp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 95268db155e9..549b5298ac4c 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -86,20 +86,9 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 	lpc18xx_otp_nvmem_config.dev = &pdev->dev;
 	lpc18xx_otp_nvmem_config.priv = otp;
 
-	nvmem = nvmem_register(&lpc18xx_otp_nvmem_config);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(&pdev->dev, &lpc18xx_otp_nvmem_config);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int lpc18xx_otp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id lpc18xx_otp_dt_ids[] = {
@@ -110,7 +99,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_otp_dt_ids);
 
 static struct platform_driver lpc18xx_otp_driver = {
 	.probe	= lpc18xx_otp_probe,
-	.remove	= lpc18xx_otp_remove,
 	.driver = {
 		.name	= "lpc18xx_otp",
 		.of_match_table = lpc18xx_otp_dt_ids,
-- 
2.14.3
