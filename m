Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeD1Wqg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 18:46:36 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52440 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeD1Wqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 18:46:34 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] spi: meson-spicc: Fix error handling in meson_spicc_probe()
Date: Sun, 29 Apr 2018 01:46:23 +0300
Message-Id: <1524955583-22760-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a2a9cde3-5192-ce05-cc5c-d0191f0e811a@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_spi_register_master() fails in meson_spicc_probe(),
spicc->core is left undisabled. The patch fixes that.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
v2: Fix subject as Neil Armstrong noted.

 drivers/spi/spi-meson-spicc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 5c82910e3480..7fe4488ace57 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -574,10 +574,15 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		master->max_speed_hz = rate >> 2;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (!ret)
-		return 0;
+	if (ret) {
+		dev_err(&pdev->dev, "spi master registration failed\n");
+		goto out_clk;
+	}
 
-	dev_err(&pdev->dev, "spi master registration failed\n");
+	return 0;
+
+out_clk:
+	clk_disable_unprepare(spicc->core);
 
 out_master:
 	spi_master_put(master);
-- 
2.7.4
