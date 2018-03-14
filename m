Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNMjE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:39:04 -0400
Received: from mx.socionext.com ([202.248.49.38]:57093 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeCNMjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:39:02 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing source of line-in
Date: Wed, 14 Mar 2018 21:39:00 +0900
Message-Id: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mixer switch for changing audio source of line-in.
We can choose one of LIN1, 2, 3, default is LIN1.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/evea.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index 439f14f91b23..73fd6730095c 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -18,6 +18,8 @@
 
 #define AADCPOW(n)                           (0x0078 + 0x04 * (n))
 #define   AADCPOW_AADC_POWD                   BIT(0)
+#define ALINSW1                              0x0088
+#define   ALINSW1_SEL1_SHIFT                  3
 #define AHPOUTPOW                            0x0098
 #define   AHPOUTPOW_HP_ON                     BIT(4)
 #define ALINEPOW                             0x009c
@@ -278,7 +280,16 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
+static const char * const linsw1_sel1_text[] = {
+	"LIN1", "LIN2", "LIN3"
+};
+
+static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
+	ALINSW1, ALINSW1_SEL1_SHIFT,
+	linsw1_sel1_text);
+
 static const struct snd_kcontrol_new evea_controls[] = {
+	SOC_ENUM("Line Capture Source", linsw1_sel1_enum),
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
-- 
2.16.1
