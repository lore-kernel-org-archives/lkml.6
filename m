Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBWMRE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:17:04 -0500
Received: from mx.socionext.com ([202.248.49.38]:47445 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBWMRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:17:03 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: fix broken sound if use SRC in replay
Date: Fri, 23 Feb 2018 21:17:01 +0900
Message-Id: <20180223121701.13372-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes settings for ports with SRC. These ports need to
set the fixed audio rate and clock. If not, the SRC outputs broken
sound.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
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
