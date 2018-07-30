Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0704FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9202220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9202220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeG3LU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:20:29 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2013 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3LU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:20:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5ede5d0000>; Mon, 30 Jul 2018 02:46:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 02:46:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 02:46:18 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 09:46:15 +0000
Subject: Re: [PATCH 4/4] ASoC: tegra: i2s: Add support for more than 2
 channels
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@lists.codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-5-jorge.sanjuan@codethink.co.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d81d5c3c-2b2f-308f-d98e-d39c5d5d147f@nvidia.com>
Date:   Mon, 30 Jul 2018 10:46:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727125931.9794-5-jorge.sanjuan@codethink.co.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/07/18 13:59, Jorge Sanjuan wrote:
> From: Edward Cragg <edward.cragg@codethink.co.uk>
> 
> The CIF configuration and clock setting is currently hard coded for 2
> channels. Since the hardware is capable of supporting 1-8 channels add
> support for reading the channel count from the supplied parameters to
> allow for better TDM support. It seems the original implementation of this
> driver was fixed at 2 channels for simplicity, and not implementing TDM.
> 
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_i2s.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> index e26c19ef7439..0f240d7989d0 100644
> --- a/sound/soc/tegra/tegra30_i2s.c
> +++ b/sound/soc/tegra/tegra30_i2s.c
> @@ -138,16 +138,17 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
>  	struct device *dev = dai->dev;
>  	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>  	unsigned int mask, val, reg;
> -	int ret, sample_size, srate, i2sclock, bitcnt;
> +	int ret, sample_size, srate, i2sclock, bitcnt, audio_bits, channels;
>  	struct tegra30_ahub_cif_conf cif_conf;
>  
> -	if (params_channels(params) != 2)
> +	if (params_channels(params) > 8)
>  		return -EINVAL;

For normal I2S mode, channels should always be 2 and so it could be worth checking
if we are using TDM mode here or not.

>  
>  	mask = TEGRA30_I2S_CTRL_BIT_SIZE_MASK;
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
>  		val = TEGRA30_I2S_CTRL_BIT_SIZE_16;
> +		audio_bits = TEGRA30_AUDIOCIF_BITS_16;
>  		sample_size = 16;
>  		break;
>  	case SNDRV_PCM_FORMAT_S24_LE:
> @@ -157,6 +158,7 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  	case SNDRV_PCM_FORMAT_S32_LE:
>  		val = TEGRA30_I2S_CTRL_BIT_SIZE_32;
> +		audio_bits = TEGRA30_AUDIOCIF_BITS_32;
>  		sample_size = 32;
>  		break;
>  	default:
> @@ -166,9 +168,10 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
>  	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CTRL, mask, val);
>  
>  	srate = params_rate(params);
> +	channels = params_channels(params);
>  
>  	/* Final "* 2" required by Tegra hardware */
> -	i2sclock = srate * params_channels(params) * sample_size * 2;
> +	i2sclock = srate * channels * sample_size * 2;
>  
>  	bitcnt = (i2sclock / (2 * srate)) - 1;
>  	if (bitcnt < 0 || bitcnt > TEGRA30_I2S_TIMING_CHANNEL_BIT_COUNT_MASK_US)
> @@ -188,10 +191,10 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
>  	regmap_write(i2s->regmap, TEGRA30_I2S_TIMING, val);
>  
>  	cif_conf.threshold = 0;
> -	cif_conf.audio_channels = 2;
> -	cif_conf.client_channels = 2;
> -	cif_conf.audio_bits = TEGRA30_AUDIOCIF_BITS_16;
> -	cif_conf.client_bits = TEGRA30_AUDIOCIF_BITS_16;
> +	cif_conf.audio_channels = channels;
> +	cif_conf.client_channels = channels;
> +	cif_conf.audio_bits = audio_bits;
> +	cif_conf.client_bits = audio_bits;
>  	cif_conf.expand = 0;
>  	cif_conf.stereo_conv = 0;
>  	cif_conf.replicate = 0;
> @@ -329,7 +332,7 @@ static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
>  	.playback = {
>  		.stream_name = "Playback",
>  		.channels_min = 2,
> -		.channels_max = 2,
> +		.channels_max = 8,
>  		.rates = SNDRV_PCM_RATE_8000_96000,
>  		.formats = SNDRV_PCM_FMTBIT_S32_LE |
>  			   SNDRV_PCM_FMTBIT_S24_LE |
> @@ -338,7 +341,7 @@ static const struct snd_soc_dai_driver tegra30_i2s_dai_template = {
>  	.capture = {
>  		.stream_name = "Capture",
>  		.channels_min = 2,
> -		.channels_max = 2,
> +		.channels_max = 8,
>  		.rates = SNDRV_PCM_RATE_8000_96000,
>  		.formats = SNDRV_PCM_FMTBIT_S32_LE |
>  			   SNDRV_PCM_FMTBIT_S24_LE |
> 

Otherwise, assuming that you fix patch 3/4 and rebase this one, looks good to me.

Cheers
Jon

-- 
nvpublic
