Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030338AbeBNN3V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:29:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030316AbeBNN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:18 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access" to the asoc tree
In-Reply-To: <20180212161538.22669-4-s.nawrocki@samsung.com>
Message-Id: <E1elx7c-0006xU-JW@debutante>
Date: Wed, 14 Feb 2018 13:29:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 48279c53fd1d09dc0d1b6ebb9f21732c507cea0b Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:34 +0100
Subject: [PATCH] ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1
 access

It seems both PCLK_I2S1 and SCLK_I2S1 clocks need to be enabled before
I2S1 control registers can be accessed on exynos5433. If SCLK clock
is disabled an exception is triggered. To fix this parent clock of
the RCLK_SRC clock is assigned to pri_dai->op_clk so required gate
clock is handled by the runtime PM ops.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 5088d12faeda..7b57ad11ca15 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1404,9 +1404,14 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = i2s_register_clock_provider(pdev);
-	if (!ret)
-		return 0;
+	if (ret < 0)
+		goto err_disable_pm;
+
+	pri_dai->op_clk = clk_get_parent(pri_dai->clk_table[CLK_I2S_RCLK_SRC]);
+
+	return 0;
 
+err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
 	clk_disable_unprepare(pri_dai->clk);
-- 
2.16.1
