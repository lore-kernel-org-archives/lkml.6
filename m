Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1402084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwYwN2MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1402084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLLMrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:47:48 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33482 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeLLMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:47:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCClH5q069893;
        Wed, 12 Dec 2018 06:47:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544618837;
        bh=6On4rvssx1czr/01jCM2ZbfUNBi5Uv/F2BY6+zQj4ss=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pwYwN2MKXPDcTO9Gg+QSpdubwyrkgkJHj8ZDqCq4wNA/OXjbOh5cP2q8djaWDzCC5
         TTAypSi5JUqnFYe/+fcU3hdtqRaZ8LYaLV6cs+k7uCa598W4TsGj+5023yynDQLOW9
         zlsX2bN6yXSqQ5tM8WgCDLbjK4EqbdDtkok0/0kU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCClGvW041497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 06:47:17 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 06:47:16 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 06:47:16 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCClDlD023840;
        Wed, 12 Dec 2018 06:47:14 -0600
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
To:     Tony Lindgren <tony@atomide.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <433af235-47c9-8b22-aec2-afb1836c9ee0@ti.com>
Date:   Wed, 12 Dec 2018 14:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211053536.GJ6707@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2018 7.35, Tony Lindgren wrote:
> * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 05:16]:
>>
>> Hi Tony
>>
>>>> This looks a little bit strange for me.
>>>> Can you show me your DT for it ?
>>>
>>> Sure, adding also Sebastian to Cc. Here's what I currently have for droid 4
>>> dts with two codecs on I2S. Please just ignore the GNSS parts there..
>>>
>>> The TDM configuration is all done in the cpcap_audio_codec via set_tdm_slot().
>>> The modem voice call codec is a serdev driver :) I'll need some more time to
>>> be able to post patches but it's basically working for voice calls.
>>
>> Hmm... it seems strange...
>> I guess you are using "ti,omap4-mcbsp" driver (= linux/sound/soc/omap/omap-mcbsp.c)
>> Is this correct ?
> 
> Yes.
> 
>> If so, your driver is registering component as
>>
>> 	ret = devm_snd_soc_register_component(&pdev->dev,
>> 					      &omap_mcbsp_component,
>> 					      &omap_mcbsp_dai, 1);
>>
>> Your driver has only 1 DAI.
> 
> Yes I have a patch for omap-mcbsp.c too :)
> 
>>>  	mcbsp3_port: port {
>>> -		cpu_dai3: endpoint {
>>> +		cpu_dai3: endpoint@0 {
>>>  			dai-format = "dsp_a";
>>>  			frame-master = <&cpcap_audio_codec1>;
>>>  			bitclock-master = <&cpcap_audio_codec1>;
>>>  			remote-endpoint = <&cpcap_audio_codec1>;
>>>  		};
>>> +		cpu_dai_mdm: endpoint@1 {
>>> +			dai-format = "dsp_a";
>>> +			frame-master = <&cpcap_audio_codec1>;
>>> +			bitclock-master = <&cpcap_audio_codec1>;
>>> +			remote-endpoint = <&mot_mdm6600_audio_codec0>;
>>> +		};
>>
>> And here, you have 1 port, 2 endpoint.
>> Then, asoc_simple_card_get_dai_id() should return 1.
>>
>> And, your [2/2] patch,
>> I guess you are misunderstanding about "port" vs "endpoint",
>> or omap-mcbsp driver side need to update ?
> 
> Yes omap-mcbsp driver needs to be updated for multiple endpoints.
> 
> Adding Jarkko and Peter also to Cc, below is the WIP patch that I'm
> currently using for omap-mcbsp to add more DAIs.

Hrm.
McBSP have single DX and single DR pin. Iow each McBSP have single DAI.

> 
> So far nothing else to do in the omap-mcbsp as it's the cpcap hardware
> that configures the TDM timeslots. And I'm currently assuming the
> first instance is the master, I guess that should be parsed from the
> the frame-master dts property instead.
> 
> Regards,
> 
> Tony
> 
> 8< ----------------------
> diff --git a/sound/soc/omap/omap-mcbsp-priv.h b/sound/soc/omap/omap-mcbsp-priv.h
> --- a/sound/soc/omap/omap-mcbsp-priv.h
> +++ b/sound/soc/omap/omap-mcbsp-priv.h
> @@ -262,6 +262,8 @@ struct omap_mcbsp {
>  	struct omap_mcbsp_platform_data *pdata;
>  	struct omap_mcbsp_st_data *st_data;
>  	struct omap_mcbsp_reg_cfg cfg_regs;
> +	struct snd_soc_dai_driver *dais;
> +	int dai_count;
>  	struct snd_dmaengine_dai_dma_data dma_data[2];
>  	unsigned int dma_req[2];
>  	int dma_op_mode;
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_graph.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -1318,23 +1319,53 @@ static int omap_mcbsp_remove(struct snd_soc_dai *dai)
>  	return 0;
>  }
>  
> -static struct snd_soc_dai_driver omap_mcbsp_dai = {
> -	.probe = omap_mcbsp_probe,
> -	.remove = omap_mcbsp_remove,
> -	.playback = {
> -		.channels_min = 1,
> -		.channels_max = 16,
> -		.rates = OMAP_MCBSP_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> -	},
> -	.capture = {
> -		.channels_min = 1,
> -		.channels_max = 16,
> -		.rates = OMAP_MCBSP_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> -	},
> -	.ops = &mcbsp_dai_ops,
> -};
> +static int omap_mcbsp_init_dais(struct omap_mcbsp *mcbsp)
> +{
> +	struct device_node *np = mcbsp->dev->of_node;
> +	int i;
> +
> +	if (np)
> +		mcbsp->dai_count = of_graph_get_endpoint_count(np);
> +
> +	if (!mcbsp->dai_count)
> +		mcbsp->dai_count = 1;
> +
> +	mcbsp->dais = devm_kcalloc(mcbsp->dev, mcbsp->dai_count,
> +				   sizeof(*mcbsp->dais), GFP_KERNEL);
> +	if (!mcbsp->dais)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mcbsp->dai_count; i++) {
> +		struct snd_soc_dai_driver *dai = &mcbsp->dais[i];
> +
> +		dai->name = devm_kasprintf(mcbsp->dev, GFP_KERNEL, "%s-dai%i",
> +					   dev_name(mcbsp->dev), i);
> +
> +		if (i == 0) {
> +			dai->probe = omap_mcbsp_probe;
> +			dai->remove = omap_mcbsp_remove;
> +			dai->ops = &mcbsp_dai_ops;
> +		}
> +		dai->playback.channels_min = 1;
> +		dai->playback.channels_max = 16;
> +		dai->playback.rates = OMAP_MCBSP_RATES;
> +		if (mcbsp->pdata->reg_size == 2)
> +			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		else
> +			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +						SNDRV_PCM_FMTBIT_S32_LE;
> +		dai->capture.channels_min = 1;
> +		dai->capture.channels_max = 16;
> +		dai->capture.rates = OMAP_MCBSP_RATES;
> +		if (mcbsp->pdata->reg_size == 2)
> +			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		else
> +			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +					       SNDRV_PCM_FMTBIT_S32_LE;

I prefer to have the 'if (mcbsp->pdata->reg_size == 2)' grouped for
playback and capture in one place.

> +	}
> +
> +	return 0;
> +}
>  
>  static const struct snd_soc_component_driver omap_mcbsp_component = {
>  	.name		= "omap-mcbsp",
> @@ -1423,18 +1454,17 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
>  	mcbsp->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, mcbsp);
>  
> -	ret = omap_mcbsp_init(pdev);
> +	ret = omap_mcbsp_init_dais(mcbsp);
>  	if (ret)
>  		return ret;
>  
> -	if (mcbsp->pdata->reg_size == 2) {
> -		omap_mcbsp_dai.playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
> -		omap_mcbsp_dai.capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
> -	}
> +	ret = omap_mcbsp_init(pdev);
> +	if (ret)
> +		return ret;
>  
>  	ret = devm_snd_soc_register_component(&pdev->dev,
>  					      &omap_mcbsp_component,
> -					      &omap_mcbsp_dai, 1);
> +					      mcbsp->dais, mcbsp->dai_count);
>  	if (ret)
>  		return ret;
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
