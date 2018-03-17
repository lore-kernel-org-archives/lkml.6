Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeCQKF5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 06:05:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55530 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeCQKF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 06:05:56 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v2] spi: jcore: disable ref_clk after getting its rate
Date: Sat, 17 Mar 2018 13:05:44 +0300
Message-Id: <1521281144-2561-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521238878-27159-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not disable ref_clk on remove.
According to the comment, the only reason to enable the clock is to get
its rate. So, it should be safe to disable clk just after that.

By the way, clk_prepare_enable() looks to be more appropriate
than clk_enable() here.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2: There is no reason to wait for remove to disable ref_clk.

 drivers/spi/spi-jcore.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index dafed6280df3..702fe573a47b 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -184,10 +184,11 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	 */
 	clock_freq = 50000000;
 	clk = devm_clk_get(&pdev->dev, "ref_clk");
-	if (!IS_ERR_OR_NULL(clk)) {
-		if (clk_enable(clk) == 0)
+	if (!IS_ERR(clk)) {
+		if (clk_prepare_enable(clk) == 0) {
 			clock_freq = clk_get_rate(clk);
-		else
+			clk_disable_unprepare(clk);
+		} else
 			dev_warn(&pdev->dev, "could not enable ref_clk\n");
 	}
 	hw->clock_freq = clock_freq;
@@ -198,10 +199,8 @@ static int jcore_spi_probe(struct platform_device *pdev)
 
 	/* Register our spi controller */
 	err = devm_spi_register_master(&pdev->dev, master);
-	if (err) {
-		clk_disable(clk);
+	if (err)
 		goto exit;
-	}
 
 	return 0;
 
-- 
2.7.4
