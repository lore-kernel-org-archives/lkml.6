Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755075AbeCSBEE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:04:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755037AbeCSBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:57 -0400
From: Mark Brown <broonie@kernel.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, linux-spi@vger.kernel.org
Subject: Applied "spi: jcore: disable ref_clk after getting its rate" to the spi tree
In-Reply-To: <1521281144-2561-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <20180319010349.B66AA440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: jcore: disable ref_clk after getting its rate

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7c2861a6fb2c502d7b7aa85415e178f3c527a468 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 17 Mar 2018 13:05:44 +0300
Subject: [PATCH] spi: jcore: disable ref_clk after getting its rate

The driver does not disable ref_clk on remove.
According to the comment, the only reason to enable the clock is to get
its rate. So, it should be safe to disable clk just after that.

By the way, clk_prepare_enable() looks to be more appropriate
than clk_enable() here.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.16.2
