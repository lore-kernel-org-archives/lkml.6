Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966662AbeCHTOG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:14:06 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966228AbeCHTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:43 -0500
X-Google-Smtp-Source: AG47ELtikmkgjzlOdPpH9nllcS41OAy3rnO67ZGbTNbo/qYbXVF8ZUp+dEOucHi6pIX/D/aNFLDXOQ==
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
Subject: [PATCH v5 15/21] nvmem: qfprom: Convert to use devm_nvmem_register()
Date: Thu,  8 Mar 2018 11:11:59 -0800
Message-Id: <20180308191205.26943-16-andrew.smirnov@gmail.com>
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
 drivers/nvmem/qfprom.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index cb3b48b47d64..4f650baad983 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -47,13 +47,6 @@ static int qfprom_reg_write(void *context,
 	return 0;
 }
 
-static int qfprom_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
@@ -82,13 +75,9 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.dev = dev;
 	econfig.priv = priv;
 
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
-
-	platform_set_drvdata(pdev, nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id qfprom_of_match[] = {
@@ -99,7 +88,6 @@ MODULE_DEVICE_TABLE(of, qfprom_of_match);
 
 static struct platform_driver qfprom_driver = {
 	.probe = qfprom_probe,
-	.remove = qfprom_remove,
 	.driver = {
 		.name = "qcom,qfprom",
 		.of_match_table = qfprom_of_match,
-- 
2.14.3
