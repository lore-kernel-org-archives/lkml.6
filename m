Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934730AbeBLMwQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:52:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:52:14 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Ensure the RCLK rate is properly determined" to the asoc tree
In-Reply-To: <20180205154403.13520-2-s.nawrocki@samsung.com>
Message-Id: <E1elDad-0006V3-Vj@debutante>
Date: Mon, 12 Feb 2018 12:52:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

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

>From 647d04f8e07afc7c3b7a42b3ee01a8b28db29631 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 5 Feb 2018 16:43:56 +0100
Subject: [PATCH] ASoC: samsung: i2s: Ensure the RCLK rate is properly
 determined

If the RCLK mux clock configuration is specified in DT and no set_sysclk()
callback is used in the sound card driver the sclk_srcrate field will remain
set to 0, leading to an incorrect PSR divider setting.
To fix this the frequency value is retrieved from the CLK_I2S_RCLK_SRC clock,
so the actual RCLK mux selection is taken into account.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 233f1c9a4b6c..aeba0ae890ea 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -656,8 +656,12 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		tmp |= mod_slave;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		/* Set default source clock in Master mode */
-		if (i2s->rclk_srcrate == 0)
+		/*
+		 * Set default source clock in Master mode, only when the
+		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
+		 * clock configuration assigned in DT is not overwritten.
+		 */
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -881,6 +885,11 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+
+		if (i2s->rclk_srcrate == 0 && rclksrc && !IS_ERR(rclksrc))
+			i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
-- 
2.16.1
