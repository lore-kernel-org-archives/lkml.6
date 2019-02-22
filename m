Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C76206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w6YWOCwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfBVVgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:36:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42676 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dDtUTT74GC6yr5O31VSC4aeqhf9iztJgzeJokroGz9U=; b=w6YWOCwat2bHHpe6jF3oX2NHc
        UZ3FF9QaeAXPgkiuY3TWtS4mrAZFperHC1piozbKGortCsYH6BluXunYDHWzgiZnyhCTu7ShoT1Wc
        dL+f77+uhg5lwnWZFfT3buTV33zPqhu2uuv4CNxJRVZXiPhGTddtWOwgGdhQFI47ogGftDK3LWOZK
        DnMst/P317ifyqb70u/VjJbacn8sTVrDVUpOC0tdBEdvtCctXfPWWP6P7yueVcwxSlWL+yARDsn1o
        lEsS6WvQ/6r9PM974TIngAgHYbr0HENKZJfz+iDdUitxI7JlArXMhojDDMXHudcZtX5oudPIevSDN
        N8mEfddzg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51366)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gxIUQ-0004Zs-In; Fri, 22 Feb 2019 21:36:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gxIUN-0002Ws-IK; Fri, 22 Feb 2019 21:36:11 +0000
Date:   Fri, 22 Feb 2019 21:36:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider
 calculation
Message-ID: <20190222213611.ogahe24h4t37ndhy@shell.armlinux.org.uk>
References: <20190222201641.yryc5pg6i4jkdj7d@shell.armlinux.org.uk>
 <20190222211833.17439-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222211833.17439-1-TheSven73@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:18:33PM -0500, Sven Van Asbroeck wrote:
> Russell, thank you so much for your patience, help and explanation, I really
> appreciate it !
> 
> Yes, that would keep the current users in business without them having to
> change anything.
> 
> Of course, poor souls like myself would have to patch, say, simple-card so we
> could provide a bclk ratio in the devicetree. Which would then propagate down
> to the tda998x via hdmi-codec. Which is fine by me.

It probably would be better to try and find some generic way to deal
with this.

After all, the I2S source probably knows which ratios it supports.
Given that many sinks support a limited set of values as well, if
ASoC core knew the supported set at each end of an I2S DAI format
link, it could probably select a working bclk ratio automatically.

> Combining your two previous suggestions, I get the following. Now sample_width
> can be removed from tda998x_audio_params, as it's no longer used.
> 
> Would this be a good start?

There's actually two threads of conversation going, and I recently had
a reply from the maintainer of hdmi-codec suggesting a way forward - so
I've coded that up as the three RFC patches you should have just
received.

That should allow you to merely add a snd_soc_dai_set_bclk_ratio() call
to set the bclk ratio while avoiding any breakage for existing users.

It does still contain my "FIXME" comment, so it isn't the final
solution yet.  One of the down-sides to the hdmi-codec shim is that it
doesn't know which DAI formats nor which bclk ratios the hdmi-codec
it's attached to supports, which makes validation against the codec
capabilities rather awkward.

Sorry to have cut across your patch below.

> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index a7c39f39793f..a306994ecc79 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -893,19 +893,25 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>  		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
>  		clksel_aip = AIP_CLKSEL_AIP_I2S;
>  		clksel_fs = AIP_CLKSEL_FS_ACLK;
> -		switch (params->sample_width) {
> +		switch (params->bclk_ratio) {
>  		case 16:
> +			cts_n = CTS_N_M(3) | CTS_N_K(0);
> +			break;
> +		case 32:
>  			cts_n = CTS_N_M(3) | CTS_N_K(1);
>  			break;
> -		case 18:
> -		case 20:
> -		case 24:
> +		case 48:
>  			cts_n = CTS_N_M(3) | CTS_N_K(2);
>  			break;
> -		default:
> -		case 32:
> +		case 64:
>  			cts_n = CTS_N_M(3) | CTS_N_K(3);
>  			break;
> +		case 128:
> +			cts_n = CTS_N_M(0) | CTS_N_K(0);
> +			break;
> +		default:
> +			dev_err(&priv->hdmi->dev, "unsupported I2S bclk ratio\n");
> +			return -EINVAL;
>  		}
>  		break;
>  
> @@ -982,7 +988,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
>  	struct tda998x_priv *priv = dev_get_drvdata(dev);
>  	int i, ret;
>  	struct tda998x_audio_params audio = {
> -		.sample_width = params->sample_width,
> +		.bclk_ratio = daifmt->bclk_ratio,
>  		.sample_rate = params->sample_rate,
>  		.cea = params->cea,
>  	};
> @@ -1004,6 +1010,23 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
>  			if (priv->audio_port[i].format == AFMT_I2S)
>  				audio.config = priv->audio_port[i].config;
>  		audio.format = AFMT_I2S;
> +		if (!audio.bclk_ratio) {
> +			/* compatibility */
> +			switch (params->sample_width) {
> +			case 16:
> +				audio.bclk_ratio = 32;
> +				break;
> +			case 18:
> +			case 20:
> +			case 24:
> +				audio.bclk_ratio = 48;
> +				break;
> +			default:
> +			case 32:
> +				audio.bclk_ratio = 64;
> +				break;
> +			}
> +		}
>  		break;
>  	case HDMI_SPDIF:
>  		for (i = 0; i < ARRAY_SIZE(priv->audio_port); i++)
> diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
> index 3cb25ccbe5e6..039e1d9af2e0 100644
> --- a/include/drm/i2c/tda998x.h
> +++ b/include/drm/i2c/tda998x.h
> @@ -14,7 +14,7 @@ enum {
>  struct tda998x_audio_params {
>  	u8 config;
>  	u8 format;
> -	unsigned sample_width;
> +	u8 bclk_ratio;
>  	unsigned sample_rate;
>  	struct hdmi_audio_infoframe cea;
>  	u8 status[5];
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 9483c55f871b..0fca69880dc3 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -42,6 +42,7 @@ struct hdmi_codec_daifmt {
>  	unsigned int frame_clk_inv:1;
>  	unsigned int bit_clk_master:1;
>  	unsigned int frame_clk_master:1;
> +	unsigned int bclk_ratio;
>  };
>  
>  /*
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index d00734d31e04..d82f26854c90 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -524,6 +524,17 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>  				       &hcp->daifmt[dai->id], &hp);
>  }
>  
> +static int hdmi_codec_set_bclk_ratio(struct snd_soc_dai *dai,
> +				     unsigned int ratio)
> +{
> +	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> +
> +	/* FIXME: some validation here would be good? */
> +	hcp->daifmt[dai->id].bclk_ratio = ratio;
> +
> +	return 0;
> +}
> +
>  static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
>  			      unsigned int fmt)
>  {
> @@ -593,7 +604,11 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
>  		}
>  	}
>  
> -	hcp->daifmt[dai->id] = cf;
> +	hcp->daifmt[dai->id].fmt = cf.fmt;
> +	hcp->daifmt[dai->id].bit_clk_inv = cf.bit_clk_inv;
> +	hcp->daifmt[dai->id].frame_clk_inv = cf.frame_clk_inv;
> +	hcp->daifmt[dai->id].bit_clk_master = cf.bit_clk_master;
> +	hcp->daifmt[dai->id].frame_clk_master = cf.frame_clk_master;
>  
>  	return ret;
>  }
> @@ -615,6 +630,7 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
>  	.startup	= hdmi_codec_startup,
>  	.shutdown	= hdmi_codec_shutdown,
>  	.hw_params	= hdmi_codec_hw_params,
> +	.set_bclk_ratio	= hdmi_codec_set_bclk_ratio,
>  	.set_fmt	= hdmi_codec_set_fmt,
>  	.digital_mute	= hdmi_codec_digital_mute,
>  };
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
