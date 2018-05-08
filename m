Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbeEHIpQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:45:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:12383 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932358AbeEHIpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:45:11 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: use DAPM to change source of line-in
Date: Tue,  8 May 2018 17:45:09 +0900
Message-Id: <20180508084509.21616-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces mixer switch to DAPM one for changing audio source
of line-in.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/evea.c | 55 +++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index 73fd6730095c..f9c10165fbc1 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -54,8 +54,21 @@ struct evea_priv {
 	int switch_hp;
 };
 
+static const char * const linsw1_sel1_text[] = {
+	"LIN1", "LIN2", "LIN3"
+};
+
+static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
+	ALINSW1, ALINSW1_SEL1_SHIFT,
+	linsw1_sel1_text);
+
+static const struct snd_kcontrol_new linesw1_mux[] = {
+	SOC_DAPM_ENUM("Line In 1 Source", linsw1_sel1_enum),
+};
+
 static const struct snd_soc_dapm_widget evea_widgets[] = {
-	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("Line In 1 Mux", SND_SOC_NOPM, 0, 0, linesw1_mux),
 	SND_SOC_DAPM_INPUT("LIN1_LP"),
 	SND_SOC_DAPM_INPUT("LIN1_RP"),
 	SND_SOC_DAPM_INPUT("LIN2_LP"),
@@ -63,7 +76,9 @@ static const struct snd_soc_dapm_widget evea_widgets[] = {
 	SND_SOC_DAPM_INPUT("LIN3_LP"),
 	SND_SOC_DAPM_INPUT("LIN3_RP"),
 
-	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC HP", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC LO1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC LO2", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("HP1_L"),
 	SND_SOC_DAPM_OUTPUT("HP1_R"),
 	SND_SOC_DAPM_OUTPUT("LO2_L"),
@@ -71,17 +86,22 @@ static const struct snd_soc_dapm_widget evea_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route evea_routes[] = {
-	{ "ADC", NULL, "LIN1_LP" },
-	{ "ADC", NULL, "LIN1_RP" },
-	{ "ADC", NULL, "LIN2_LP" },
-	{ "ADC", NULL, "LIN2_RP" },
-	{ "ADC", NULL, "LIN3_LP" },
-	{ "ADC", NULL, "LIN3_RP" },
-
-	{ "HP1_L", NULL, "DAC" },
-	{ "HP1_R", NULL, "DAC" },
-	{ "LO2_L", NULL, "DAC" },
-	{ "LO2_R", NULL, "DAC" },
+	{ "Line In 1", NULL, "ADC" },
+	{ "ADC", NULL, "Line In 1 Mux" },
+	{ "Line In 1 Mux", "LIN1", "LIN1_LP" },
+	{ "Line In 1 Mux", "LIN1", "LIN1_RP" },
+	{ "Line In 1 Mux", "LIN2", "LIN2_LP" },
+	{ "Line In 1 Mux", "LIN2", "LIN2_RP" },
+	{ "Line In 1 Mux", "LIN3", "LIN3_LP" },
+	{ "Line In 1 Mux", "LIN3", "LIN3_RP" },
+
+	{ "DAC HP", NULL, "Headphone 1" },
+	{ "DAC LO1", NULL, "Line Out 1" },
+	{ "DAC LO2", NULL, "Line Out 2" },
+	{ "HP1_L", NULL, "DAC HP" },
+	{ "HP1_R", NULL, "DAC HP" },
+	{ "LO2_L", NULL, "DAC LO2" },
+	{ "LO2_R", NULL, "DAC LO2" },
 };
 
 static void evea_set_power_state_on(struct evea_priv *evea)
@@ -280,16 +300,7 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
-static const char * const linsw1_sel1_text[] = {
-	"LIN1", "LIN2", "LIN3"
-};
-
-static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
-	ALINSW1, ALINSW1_SEL1_SHIFT,
-	linsw1_sel1_text);
-
 static const struct snd_kcontrol_new evea_controls[] = {
-	SOC_ENUM("Line Capture Source", linsw1_sel1_enum),
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
-- 
2.17.0
