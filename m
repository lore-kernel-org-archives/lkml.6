Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934174AbeEIJrn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:47:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbeEIJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:47:42 -0400
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: evea: use DAPM to change source of line-in" to the asoc tree
In-Reply-To: <20180508084509.21616-1-suzuki.katsuhiro@socionext.com>
Message-Id: <20180509094731.ECBA844007A@finisterre.ee.mobilebroadband>
Date: Wed,  9 May 2018 10:47:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: evea: use DAPM to change source of line-in

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

>From e5ba319882d78030b054dee4eeaf758340b2756f Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Tue, 8 May 2018 17:45:09 +0900
Subject: [PATCH] ASoC: uniphier: evea: use DAPM to change source of line-in

This patch replaces mixer switch to DAPM one for changing audio source
of line-in.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
