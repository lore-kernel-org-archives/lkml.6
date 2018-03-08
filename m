Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966701AbeCHTOV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:14:21 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38346 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966181AbeCHTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:42 -0500
X-Google-Smtp-Source: AG47ELtVPkK7RQRjmK7LieBNaSRX24D9tkDZ+1lZs61d4S94QruCIL/lHnLGhL09zlR54gdWyp5xuQ==
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
Subject: [PATCH v5 14/21] nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
Date: Thu,  8 Mar 2018 11:11:58 -0800
Message-Id: <20180308191205.26943-15-andrew.smirnov@gmail.com>
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
 drivers/nvmem/bcm-ocotp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 5e9e324427f9..24c30fa475cc 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -302,27 +302,17 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 
 	priv->config = &bcm_otpc_nvmem_config;
 
-	nvmem = nvmem_register(&bcm_otpc_nvmem_config);
+	nvmem = devm_nvmem_register(dev, &bcm_otpc_nvmem_config);
 	if (IS_ERR(nvmem)) {
 		dev_err(dev, "error registering nvmem config\n");
 		return PTR_ERR(nvmem);
 	}
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int bcm_otpc_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct platform_driver bcm_otpc_driver = {
 	.probe	= bcm_otpc_probe,
-	.remove	= bcm_otpc_remove,
 	.driver = {
 		.name	= "brcm-otpc",
 		.of_match_table = bcm_otpc_dt_ids,
-- 
2.14.3
