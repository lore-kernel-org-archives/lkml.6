Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030356AbeBNN30 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:29:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030326AbeBNN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:21 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Ensure names of supplied clocks are unique" to the asoc tree
In-Reply-To: <20180212161538.22669-3-s.nawrocki@samsung.com>
Message-Id: <E1elx7f-00070w-No@debutante>
Date: Wed, 14 Feb 2018 13:29:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Ensure names of supplied clocks are unique

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

>From aa274c5cfd13381372d2dace32b7354ccba7d2ab Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:33 +0100
Subject: [PATCH] ASoC: samsung: i2s: Ensure names of supplied clocks are
 unique

In order to support multiple instances of the I2S IP block the platform
device name is prepended to each clock registered by the driver.
The clock-output-names property is now not used, this should not cause
any issues as, for example, CDCLK clock is referenced through DT 'clocks'
property, not by name.

This change allows to have both I2S0 and I2S1 enabled simultaneously
on exynos5433 and working properly when #clock-cells property is specified
in respective DT nodes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index aeba0ae890ea..5088d12faeda 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1193,11 +1193,13 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
 
 static int i2s_register_clock_provider(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
+	struct device *dev = &pdev->dev;
+	struct i2s_dai *i2s = dev_get_drvdata(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
 	int ret, i;
 
@@ -1214,30 +1216,38 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 		clk_put(rclksrc);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(i2s_clk_desc); i++) {
+		i2s_clk_name[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
+						dev_name(dev), i2s_clk_desc[i]);
+		if (!i2s_clk_name[i])
+			return -ENOMEM;
+	}
+
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
 		u32 val = readl(i2s->addr + I2SPSR);
 		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
 
 		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
-				"i2s_rclksrc", p_names, ARRAY_SIZE(p_names),
+				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
+				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
 		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
-				"i2s_presc", "i2s_rclksrc",
+				i2s_clk_name[CLK_I2S_RCLK_PSR],
+				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
-		p_names[0] = "i2s_presc";
+		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
 		i2s->clk_data.clk_num = 2;
 	}
-	of_property_read_string_index(dev->of_node,
-				"clock-output-names", 0, &clk_name[0]);
 
-	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev, clk_name[0],
-				p_names[0], CLK_SET_RATE_PARENT,
+	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
+				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
+				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
-- 
2.16.1
