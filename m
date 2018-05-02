Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEBVSN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:18:13 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:42634 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeEBVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:17:58 -0400
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Danny Milosavljevic <dannym@scratchpost.org>,
        Andrea Bondavalli <andrea.bondavalli74@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v14 7/8] ASoC: sun4i-codec: Add Differential Line Source
Date: Wed,  2 May 2018 23:07:59 +0200
Message-Id: <20180502210800.1971-8-dannym@scratchpost.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180502210800.1971-1-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
Tags: patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Differential Line Source for Allwinner A10 and Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 4125d9ef0eb6..45dcb80a1da9 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -110,6 +110,7 @@
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_LNPREG			(13)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -705,6 +706,20 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_difflinein_source[] = {
+	"Stereo",
+	"Differential",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_LNRDF,
+			    sun4i_codec_difflinein_source);
+
+static const struct snd_kcontrol_new sun4i_codec_difflinein_source_controls =
+	SOC_DAPM_ENUM("Differential Line Source",
+		      sun4i_codec_enum_difflinein_source);
+
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
@@ -825,6 +840,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	/* MUX */
+	SND_SOC_DAPM_MUX("Differential Line Source", SND_SOC_NOPM,
+			 0, 0,
+			 &sun4i_codec_difflinein_source_controls),
+
 	SND_SOC_DAPM_INPUT("Line Right"),
 	SND_SOC_DAPM_INPUT("Line Left"),
 	SND_SOC_DAPM_INPUT("FM Right"),
@@ -884,6 +904,10 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
 	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
 	{ "Mic2", NULL, "VMIC" },
+
+	/* LNRDF Routes */
+	{ "Differential Line Source", "Differential", "Line Left" },
+	{ "Differential Line Source", "Differential", "Line Right" },
 };
 
 struct sun4i_codec_quirks {
