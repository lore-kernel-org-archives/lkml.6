Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeEBVR6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:17:58 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:42604 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeEBVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:17:56 -0400
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
Subject: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture Select, Right Capture Select
Date: Wed,  2 May 2018 23:08:00 +0200
Message-Id: <20180502210800.1971-9-dannym@scratchpost.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180502210800.1971-1-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
Tags: patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Left Capture Select and Right Capture Select for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 45dcb80a1da9..1a4ba3bae5da 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -706,6 +706,25 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_capture_source[] = {
+	"Line",
+	"FM",
+	"Mic1",
+	"Mic2",
+	"Mic1,Mic2",
+	"Mic1+Mic2",
+	"Output Mixer",
+	"Line,Mic1",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_ADCIS,
+			    sun4i_codec_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
+	SOC_DAPM_ENUM("Capture Source", sun4i_codec_enum_capture_source);
+
 static const char * const sun4i_codec_difflinein_source[] = {
 	"Stereo",
 	"Differential",
@@ -841,6 +860,10 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 			    &sun4i_codec_pa_mute),
 
 	/* MUX */
+	SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
+	SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
 	SND_SOC_DAPM_MUX("Differential Line Source", SND_SOC_NOPM,
 			 0, 0,
 			 &sun4i_codec_difflinein_source_controls),
@@ -908,6 +931,33 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	/* LNRDF Routes */
 	{ "Differential Line Source", "Differential", "Line Left" },
 	{ "Differential Line Source", "Differential", "Line Right" },
+
+	/* Right ADC Input Routes */
+	{ "Right Capture Select", "Line", "Line Right" },
+	{ "Right Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Right Capture Select", "FM", "FM Right" },
+	{ "Right Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1,Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Output Mixer", "Right Mixer" },
+	{ "Right Capture Select", "Line,Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right ADC", NULL, "Right Capture Select" },
+
+	/* Left ADC Input Routes */
+	{ "Left Capture Select", "Line", "Line Left" },
+	{ "Left Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Left Capture Select", "FM", "FM Left" },
+	{ "Left Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1,Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Output Mixer", "Left Mixer" },
+	{ "Left Capture Select", "Line,Mic1", "Line Left" },
+	{ "Left Capture Select", "Line,Mic1", "Differential Line Capture Switch" },
+	{ "Left ADC", NULL, "Left Capture Select" },
 };
 
 struct sun4i_codec_quirks {
