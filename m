Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C159218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfA3Of5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:35:57 -0500
Received: from dd26836.kasserver.com ([85.13.145.193]:49008 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbfA3Ofz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:35:55 -0500
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com [77.116.173.211])
        by dd26836.kasserver.com (Postfix) with ESMTPSA id A8538336589F;
        Wed, 30 Jan 2019 15:26:14 +0100 (CET)
From:   Danny Milosavljevic <dannym@scratchpost.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Danny Milosavljevic <dannym@scratchpost.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 7/8] ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM Playback Switch
Date:   Wed, 30 Jan 2019 11:39:43 +0100
Message-Id: <20190130103945.26692-8-dannym@scratchpost.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
References: <20190130103945.26692-1-dannym@scratchpost.org>
MIME-Version: 1.0
Tags:   patch
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FM Playback Volume for Allwinner A10 and Allwinner A20.
Add FM Left, FM Right, FM Playback Switch for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 87bb16e59..2ec7a4397 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -64,7 +64,10 @@
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
 #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
+#define SUN4I_CODEC_DAC_ACTL_FMG			(23)
 #define SUN4I_CODEC_DAC_ACTL_MICG			(20)
+#define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
+#define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
 #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
 #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
@@ -683,6 +686,8 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale, -450, 150,
+			    0);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
 			    0);
 static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
@@ -696,6 +701,9 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
+		       sun4i_codec_fmin_loopback_gain_scale),
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
@@ -711,6 +719,9 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
+		       sun4i_codec_fmin_loopback_gain_scale),
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
@@ -732,6 +743,9 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
 	SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_MIC1LS,
 			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
@@ -800,6 +814,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("FM Right"),
+	SND_SOC_DAPM_INPUT("FM Left"),
 	SND_SOC_DAPM_INPUT("Mic1"),
 	SND_SOC_DAPM_INPUT("Mic2"),
 
@@ -820,12 +836,14 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
