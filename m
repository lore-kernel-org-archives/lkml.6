Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755004AbeCSBDo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:03:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbeCSBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:37 -0400
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add syscon property for UniPhier sound system" to the asoc tree
In-Reply-To: <20180316070813.17969-3-suzuki.katsuhiro@socionext.com>
Message-Id: <20180319010329.17912440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add syscon property for UniPhier sound system

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

>From 7c3c20f2bec1e8bdaadd551a4b75f1834a7cb974 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 16 Mar 2018 16:08:13 +0900
Subject: [PATCH] ASoC: uniphier: add syscon property for UniPhier sound system

This patch adds syscon property for specifying soc-glue core.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state. After
resetting of SoC Hi-Z state is selected. This driver set to signal
output state when syscon property is available.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 21 +++++++++++++++++++++
 sound/soc/uniphier/aio-cpu.c  | 11 +++++++++++
 sound/soc/uniphier/aio-reg.h  |  3 +++
 sound/soc/uniphier/aio.h      |  2 ++
 4 files changed, 37 insertions(+)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 1711361fc0c2..6d50042a4571 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -83,6 +83,27 @@ u64 aio_rb_space_to_end(struct uniphier_aio_sub *sub)
 	return rb_space_to_end(sub->wr_offs, sub->rd_offs, sub->compr_bytes);
 }
 
+/**
+ * aio_iecout_set_enable - setup IEC output via SoC glue
+ * @chip: the AIO chip pointer
+ * @enable: false to stop the output, true to start
+ *
+ * Set enabled or disabled S/PDIF signal output to out of SoC via AOnIEC pins.
+ * This function need to call at driver startup.
+ *
+ * The regmap of SoC glue is specified by 'socionext,syscon' optional property
+ * of DT. This function has no effect if no property.
+ */
+void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
+{
+	struct regmap *r = chip->regmap_sg;
+
+	if (!r)
+		return;
+
+	regmap_write(r, SG_AOUTEN, (enable) ? ~0 : 0);
+}
+
 /**
  * aio_chip_set_pll - set frequency to audio PLL
  * @chip  : the AIO chip pointer
diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 7cf2316c69a2..1e5eb8e6f8c7 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -387,6 +388,7 @@ int uniphier_aio_dai_probe(struct snd_soc_dai *dai)
 		sub->spec = spec;
 	}
 
+	aio_iecout_set_enable(aio->chip, true);
 	aio_chip_init(aio->chip);
 	aio->chip->active = 1;
 
@@ -431,6 +433,7 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 	if (ret)
 		goto err_out_clock;
 
+	aio_iecout_set_enable(aio->chip, true);
 	aio_chip_init(aio->chip);
 
 	for (i = 0; i < ARRAY_SIZE(aio->sub); i++) {
@@ -477,6 +480,14 @@ int uniphier_aio_probe(struct platform_device *pdev)
 	if (!chip->chip_spec)
 		return -EINVAL;
 
+	chip->regmap_sg = syscon_regmap_lookup_by_phandle(dev->of_node,
+							  "socionext,syscon");
+	if (IS_ERR(chip->regmap_sg)) {
+		if (PTR_ERR(chip->regmap_sg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		chip->regmap_sg = NULL;
+	}
+
 	chip->clk = devm_clk_get(dev, "aio");
 	if (IS_ERR(chip->clk))
 		return PTR_ERR(chip->clk);
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index eaf2c65acf14..136d3563cf44 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -23,6 +23,9 @@
 
 #include <linux/bitops.h>
 
+/* soc-glue */
+#define SG_AOUTEN                       0x1c04
+
 /* SW view */
 #define A2CHNMAPCTR0(n)                 (0x00000 + 0x40 * (n))
 #define A2RBNMAPCTR0(n)                 (0x01000 + 0x40 * (n))
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 793334675cb3..8cab4a553a97 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -296,6 +296,7 @@ struct uniphier_aio_chip {
 	struct clk *clk;
 	struct reset_control *rst;
 	struct regmap *regmap;
+	struct regmap *regmap_sg;
 	int active;
 };
 
@@ -323,6 +324,7 @@ u64 aio_rbt_cnt_to_end(struct uniphier_aio_sub *sub);
 u64 aio_rb_space(struct uniphier_aio_sub *sub);
 u64 aio_rb_space_to_end(struct uniphier_aio_sub *sub);
 
+void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable);
 int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
 		     unsigned int freq);
 void aio_chip_init(struct uniphier_aio_chip *chip);
-- 
2.16.2
