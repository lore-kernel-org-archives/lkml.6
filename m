Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F01720857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfA3Ofy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:35:54 -0500
Received: from dd26836.kasserver.com ([85.13.145.193]:48974 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3Ofy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:35:54 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 09:35:54 EST
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com [77.116.173.211])
        by dd26836.kasserver.com (Postfix) with ESMTPSA id 50619336394D;
        Wed, 30 Jan 2019 15:26:10 +0100 (CET)
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
Subject: [PATCH v15 5/8] ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
Date:   Wed, 30 Jan 2019 11:39:41 +0100
Message-Id: <20190130103945.26692-6-dannym@scratchpost.org>
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

Since it's now possible to have a DAPM mixer control with multiple
channels, use it to cut down the total number of controls.

Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC
Playback Switch" name & layout the same as before for compatibility.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9d509ede2..279a7880d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -718,15 +718,15 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
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
 
@@ -762,11 +762,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 
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
@@ -808,12 +808,12 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
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
