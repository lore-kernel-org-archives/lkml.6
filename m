Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA615C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E2F20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwgjHKDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E2F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755912AbeFSFFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755884AbeFSFFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:05:36 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505B92083A;
        Tue, 19 Jun 2018 05:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529384736;
        bh=VP7UyJ0X4IRPZPD3Thmg2M8Zhalfvx7iN/71Znd/97Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwgjHKDFD9LCQJ4342TBzMTP/DEbgaLq9wb5+qgeh0fwrA8tbc+SHK5cIP/Inku+T
         fzs9WVyOXQ/Nu5+tiwfBPBGIiU5ZsmhNh2EuNPx8fKcanLgVnDip2rZmP0yMU476Mx
         6crOv6r5K4lTZ6/YRTV0+J1bbFo/S6fn/T1/tD8c=
Date:   Tue, 19 Jun 2018 10:35:27 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180619050527.GR25852@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 16:46, Rohit kumar wrote:

> +struct sdm845_snd_data {
> +	struct snd_soc_card *card;
> +	struct regulator *vdd_supply;
> +	struct snd_soc_dai_link dai_link[];
> +};
> +
> +static struct mutex pri_mi2s_res_lock;
> +static struct mutex quat_tdm_res_lock;

any reason why the locks can't be part of sdm845_snd_data?
Also why do we need two locks ?

> +static atomic_t pri_mi2s_clk_count;
> +static atomic_t quat_tdm_clk_count;

Any specific reason for using atomic variables?

> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
> +
> +static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int ret = 0;
> +	int channels, slot_width;
> +
> +	channels = params_channels(params);
> +	if (channels < 1 || channels > 8) {

I though ch = 0 would be caught by framework and IIRC ASoC doesn't
support more than 8 channels

> +		pr_err("%s: invalid param channels %d\n",
> +				__func__, channels);
> +		return -EINVAL;
> +	}
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		slot_width = 32;
> +		break;
> +	default:
> +		pr_err("%s: invalid param format 0x%x\n",
> +				__func__, params_format(params));

why not use dev_err, bonus you get device name printer with the logs :)

> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> +{
> +	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +
> +	pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);

It is good for debug but not very useful here, so removing it would be
good

> +	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX:
> +	case PRIMARY_MI2S_TX:
> +		mutex_lock(&pri_mi2s_res_lock);
> +		if (atomic_inc_return(&pri_mi2s_clk_count) == 1) {
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_MCLK_1,
> +				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +		}
> +		mutex_unlock(&pri_mi2s_res_lock);

why do we need locking here? Can you please explain that.

> +		snd_soc_dai_set_fmt(cpu_dai, fmt);
> +		break;

empty line after break helps in readability

> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	int ret, num_links;
> +	struct sdm845_snd_data *data;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ret;
> +	}

so if we dont find audio-routing, then? we seems to continue..

-- 
~Vinod
