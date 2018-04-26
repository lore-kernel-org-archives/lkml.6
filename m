Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756463AbeDZLyT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:54:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbeDZLyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:54:16 -0400
From: Mark Brown <broonie@kernel.org>
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>, ldv-project@linuxtesting.org,
        sil2review@lists.osadl.org, linux-spi@vger.kernel.org
Subject: Applied "spi/bcm63xx-hspi: Enable the clock before calling clk_get_rate()." to the spi tree
In-Reply-To: <20180426072801.GB4117@er01809n.ebgroup.elektrobit.com>
Message-Id: <E1fBfTJ-0007nD-91@debutante>
Date: Thu, 26 Apr 2018 12:53:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi/bcm63xx-hspi: Enable the clock before calling clk_get_rate().

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

>From 0d7412ed1f5dc0858eb4f29650a8c9c5cce8b285 Mon Sep 17 00:00:00 2001
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Date: Thu, 26 Apr 2018 09:28:02 +0200
Subject: [PATCH] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().

Enable the clock prior to calling clk_get_rate(), because clk_get_rate()
should only be called if the clock is enabled.

Additionally, prepare/enable the pll_clk before calling clk_get_rate()
for the same reason.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index cbcba614b253..c23849f7aa7b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -352,22 +352,31 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate = clk_get_rate(clk);
 	if (!rate) {
 		struct clk *pll_clk = devm_clk_get(dev, "pll");
 
-		if (IS_ERR(pll_clk))
-			return PTR_ERR(pll_clk);
+		if (IS_ERR(pll_clk)) {
+			ret = PTR_ERR(pll_clk);
+			goto out_disable_clk;
+		}
+
+		ret = clk_prepare_enable(pll_clk);
+		if (ret)
+			goto out_disable_clk;
 
 		rate = clk_get_rate(pll_clk);
-		if (!rate)
-			return -EINVAL;
+		clk_disable_unprepare(pll_clk);
+		if (!rate) {
+			ret = -EINVAL;
+			goto out_disable_clk;
+		}
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master) {
 		ret = -ENOMEM;
-- 
2.17.0
