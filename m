Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeEVIx7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:53:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38757 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeEVIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:53:56 -0400
X-Google-Smtp-Source: AB8JxZpLL/Ao+O7KVOSqi1G+1D7dEO6cYJNCBVcESs1AF6rAVnzckG3lkoh/pS9ICCzw+8KaVwNi1g==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dgreid@chromium.org, broonie@kernel.org
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeffy.chen@rock-chips.com, Lin Huang <hl@rock-chips.com>
Subject: [PATCH 2/2] ASoC: rockchip: cdn-dp sound output use spdif
Date: Tue, 22 May 2018 16:53:42 +0800
Message-Id: <1526979222-32478-2-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
References: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some monitors care about the parity bit in the sub-frame of I2S,
but the cdn-dp always set this bit to "1", so these monitors
do not have sound output if use i2s, use spdif can fix this issue.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 46 +----------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9a10181..f184168 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -220,45 +220,6 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int rockchip_sound_cdndp_hw_params(struct snd_pcm_substream *substream,
-					  struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int mclk, ret;
-
-	/* in bypass mode, the mclk has to be one of the frequencies below */
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 24000:
-	case 32000:
-	case 48000:
-	case 64000:
-	case 96000:
-		mclk = 12288000;
-		break;
-	case 11025:
-	case 22050:
-	case 44100:
-	case 88200:
-		mclk = 11289600;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
-				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set cpu clock out %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -293,10 +254,6 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
-static const struct snd_soc_ops rockchip_sound_cdndp_ops = {
-	.hw_params = rockchip_sound_cdndp_hw_params,
-};
-
 static const struct snd_soc_ops rockchip_sound_dmic_ops = {
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
@@ -323,8 +280,7 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
 		.stream_name = "DP PCM",
-		.codec_dai_name = "i2s-hifi",
-		.ops = &rockchip_sound_cdndp_ops,
+		.codec_dai_name = "spdif-hifi",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
-- 
2.7.4
