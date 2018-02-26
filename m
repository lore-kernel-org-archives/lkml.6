Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeBZLRp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:17:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeBZLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:17:41 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: fix broken sound if use SRC in replay" to the asoc tree
In-Reply-To: <20180223121701.13372-1-suzuki.katsuhiro@socionext.com>
Message-Id: <E1eqGmk-0005WS-EY@debutante>
Date: Mon, 26 Feb 2018 11:17:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: fix broken sound if use SRC in replay

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

>From 398fa30bf138fd4b928dc11422abfe5486aaa8fe Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 23 Feb 2018 21:17:01 +0900
Subject: [PATCH] ASoC: uniphier: fix broken sound if use SRC in replay

This patch fixes settings for ports with SRC. These ports need to
set the fixed audio rate and clock. If not, the SRC outputs broken
sound.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 1e5f053d9f6b..1711361fc0c2 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -501,7 +501,7 @@ int aio_port_set_clk(struct uniphier_aio_sub *sub)
 				OPORTMXCTR2_MSSEL_MASTER |
 				OPORTMXCTR2_EXTLSIFSSEL_36 |
 				OPORTMXCTR2_DACCKSEL_1_2;
-		} else {
+		} else if (sub->swm->type == PORT_TYPE_SPDIF) {
 			if (sub->aio->pll_out >= ARRAY_SIZE(v_pll)) {
 				dev_err(dev, "PLL(%d) is invalid\n",
 					sub->aio->pll_out);
@@ -521,6 +521,11 @@ int aio_port_set_clk(struct uniphier_aio_sub *sub)
 				v |= OPORTMXCTR2_EXTLSIFSSEL_24;
 				break;
 			}
+		} else {
+			v = OPORTMXCTR2_ACLKSEL_A1 |
+				OPORTMXCTR2_MSSEL_MASTER |
+				OPORTMXCTR2_EXTLSIFSSEL_36 |
+				OPORTMXCTR2_DACCKSEL_1_2;
 		}
 		regmap_write(r, OPORTMXCTR2(sub->swm->oport.map), v);
 	} else {
@@ -550,11 +555,19 @@ int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 		       const struct snd_pcm_hw_params *params)
 {
 	struct regmap *r = sub->aio->chip->regmap;
+	unsigned int rate;
 	u32 v;
 	int ret;
 
 	if (!pass_through) {
-		ret = aio_port_set_rate(sub, params_rate(params));
+		if (sub->swm->type == PORT_TYPE_EVE ||
+		    sub->swm->type == PORT_TYPE_CONV) {
+			rate = 48000;
+		} else {
+			rate = params_rate(params);
+		}
+
+		ret = aio_port_set_rate(sub, rate);
 		if (ret)
 			return ret;
 
-- 
2.16.1
