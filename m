Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEOJ6I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:58:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38091 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbeEOJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:58:04 -0400
X-Google-Smtp-Source: AB8JxZol/kxSwZhCf3wzwiXFq/kVbSmFTYjDJvyQlp//y6PiBq+RzCQTNBH7U2zSe9V7oTx4Nqz2zg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: meson-gx: add device reset
Date: Tue, 15 May 2018 11:57:48 +0200
Message-Id: <20180515095748.6794-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180515095748.6794-1-jbrunet@baylibre.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger the reset line of the mmc controller while probing, if available.
The reset should be optional for now, at least until all related DT nodes
have the reset property.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4f972b879fe6..9bca359f7936 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/pinctrl/consumer.h>
@@ -1184,6 +1185,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	ret = device_reset_optional(&pdev->dev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "device reset failed: %d\n", ret);
+
+		return ret;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->regs)) {
-- 
2.14.3
