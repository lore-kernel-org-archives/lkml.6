Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692AAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C322208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C322208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeG0OVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:21:30 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57524 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbeG0OV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:29 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fj2LI-0008VU-7A; Fri, 27 Jul 2018 13:59:36 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     jonathanh@nvidia.com, thierry.reding@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Subject: [PATCH 4/4] ASoC: tegra: i2s: Add support for more than 2 channels
Date:   Fri, 27 Jul 2018 13:59:31 +0100
Message-Id: <20180727125931.9794-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Cragg <edward.cragg@codethink.co.uk>

The CIF configuration and clock setting is currently hard coded for 2
channels. Since the hardware is capable of supporting 1-8 channels add
support for reading the channel count from the supplied parameters to
allow for better TDM support. It seems the original implementation of this
driver was fixed at 2 channels for simplicity, and not implementing TDM.

Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/soc/tegra/tegra30_i2s.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index e26c19ef7439..0f240d7989d0 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -138,16 +138,17 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct device *dev = dai->dev;
 	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int mask, val, reg;
-	int ret, sample_size, srate, i2sclock, bitcnt;
+	int ret, sample_size, srate, i2sclock, bitcnt, audio_bits, channels;
 	struct tegra30_ahub_cif_conf cif_conf;
 
-	if (params_channels(params) != 2)
+	if (params_channels(params) > 8)
 		return -EINVAL;
 
 	mask = TEGRA30_I2S_CTRL_BIT_SIZE_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		val = TEGRA30_I2S_CTRL_BIT_SIZE_16;
+		audio_bits = TEGRA30_AUDIOCIF_BITS_16;
 		sample_size = 16;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
@@ -157,6 +158,7 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		val = TEGRA30_I2S_CTRL_BIT_SIZE_32;
+		audio_bits = TEGRA30_AUDIOCIF_BITS_32;
 		sample_size = 32;
 		break;
 	default:
@@ -166,9 +168,10 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CTRL, mask, val);
 
 	srate = params_rate(params);
+	channels = params_channels(params);
 
 	/* Final "* 2" required by Tegra hardware */
-	i2sclock = srate * params_channels(params) * sample_size * 2;
+	i2sclock = srate * channels * sample_size * 2;
 
 	bitcnt = (i2sclock / (2 * srate)) - 1;
 	if (bitcnt < 0 || bitcnt > TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US)
@@ -188,10 +191,10 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_write(i2s->regmap, TEGRA30_I2S_TIMING, val);
 
 	cif_conf.threshold = 0;
-	cif_conf.audio_channels = 2;
-	cif_conf.client_channels = 2;
-	cif_conf.audio_bits = TEGRA30_AUDIOCIF_BITS_16;
-	cif_conf.client_bits = TEGRA30_AUDIOCIF_BITS_16;
+	cif_conf.audio_channels = channels;
+	cif_conf.client_channels = channels;
+	cif_conf.audio_bits = audio_bits;
+	cif_conf.client_bits = audio_bits;
 	cif_conf.expand = 0;
 	cif_conf.stereo_conv = 0;
 	cif_conf.replicate = 0;
@@ -329,7 +332,7 @@ static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE |
 			   SNDRV_PCM_FMTBIT_S24_LE |
@@ -338,7 +341,7 @@ static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE |
 			   SNDRV_PCM_FMTBIT_S24_LE |
-- 
2.11.0

