Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEBVSH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:18:07 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:42628 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEBVR4 (ORCPT
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
Subject: [PATCH v14 3/8] ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
Date: Wed,  2 May 2018 23:07:55 +0200
Message-Id: <20180502210800.1971-4-dannym@scratchpost.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180502210800.1971-1-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
Tags: patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's now possible to have a DAPM mixer control with multiple channels,
use it to cut down the total number of controls.

Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC Playback
Switch" name & layout the same as before for compatibility.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 4af286f44a67..b62af407967f 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -715,15 +715,15 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
 		       sun7i_codec_micin_preamp_gain_scale),
 };
 
-static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
-};
-
-static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
+			1, 0),
+	SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_RDACRMIXS,
+			1, 0),
+	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
 };
 
@@ -759,11 +759,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_left_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_right_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 
 	/* Global Mixer Enable */
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
@@ -805,12 +805,12 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", NULL, "Mixer Enable" },
-	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
-	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
