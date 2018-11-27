Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD515C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767FF20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUl0fPDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767FF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeK0UOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:14:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40622 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbeK0UOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:14:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so21266860wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H3nepWnIIVTNJfdteZYM7cfL/QdrCjjFIHQeH00IWIk=;
        b=UUl0fPDBFe29w5g+yiPn9iVO3BFCrylDs15x9NyuA2F0dZ/CCi3TO5ECpMCmINn7Lr
         3YvoKW4/mFgF8/rqf2/Rk+KYAYTLy9kMR454rByOS5Umd24pfmLqoIfwGpaXoNbP5YOV
         B2WmeIoNiqIml2ltZ+b7hae5cvqZmM5D5oou4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H3nepWnIIVTNJfdteZYM7cfL/QdrCjjFIHQeH00IWIk=;
        b=hcw94NOitcjGk4Pvg83hCd0nRLlWYdBnEevqKYd2CbS69ePt4aAVrV1UExqqzYFmhO
         4dTS9bs58RWvokZrtlYyKmBJN21mxAsEPCepo5Emr12ZiBc4s+H0EFLBoY8riQROG3kP
         6GbjwcUwAF0/wdTb5vlUkQ1TbfGocqjfPeBEq6K/u+TWllzzTt0IDHaGwv1bP6Z/YL/+
         Jb8BWk8VzGHD7wqvIi7pjII7ly9fbv+ZxLN959uU4/VuS8+qqXCqEqVPEpkkiIfKTzOu
         HE+RCOMAvy5eln6z67fU+8FzcV8H9H8667AOUf1UZ06VW3iWIkS03376iLhkTQ3N0PnX
         0pkQ==
X-Gm-Message-State: AGRZ1gK0/Bk1ME4RW/rKPZIjEGqB4mpWmZOVTKOwDoNfIr1OVTWOFmiX
        HEoOMqunh9uoH/PQHTD/thGCXT/4QCk=
X-Google-Smtp-Source: AJdET5ev8ZFG+5dBPRvD2vDB9E8UACPPb6zoKCTtW1YCWMdSsdIzNHx0O1TtdwZksD+/j2M29fUSpw==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr27143639wma.151.1543310237925;
        Tue, 27 Nov 2018 01:17:17 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s139sm5070668wmd.3.2018.11.27.01.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:17:17 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: qcom: sdm845: Create and setup
 jack in init callback
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-2-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3036c1c3-84a6-0306-1aff-434e1087f6ad@linaro.org>
Date:   Tue, 27 Nov 2018 09:17:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181124110948.209019-2-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Add a callback for init ops on dai_link to create and setup jack.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/sdm845.c | 57 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 95d8d4422dae0..43c03f8e8cdc2 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -8,6 +8,8 @@
>   #include <linux/of_device.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> +#include <sound/jack.h>
> +#include <uapi/linux/input-event-codes.h>
>   #include "common.h"
>   #include "qdsp6/q6afe.h"
>   
> @@ -17,6 +19,8 @@
>   #define MI2S_BCLK_RATE		1536000
>   
>   struct sdm845_snd_data {
> +	struct snd_soc_jack jack;
> +	bool jack_setup;
>   	struct snd_soc_card *card;
>   	uint32_t pri_mi2s_clk_count;
>   	uint32_t sec_mi2s_clk_count;
> @@ -100,6 +104,54 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>   	return ret;
>   }
>   
> +static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_component *component;
> +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +	struct snd_soc_card *card = rtd->card;
> +	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
> +	int i, rval;
> +
> +	if (!pdata->jack_setup) {
> +		struct snd_jack *jack;
> +
> +		rval = snd_soc_card_jack_new(card, "Headset Jack",
> +				SND_JACK_HEADSET |
> +				SND_JACK_HEADPHONE |
> +				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +				SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +				&pdata->jack, NULL, 0);
> +
> +		if (rval < 0) {
> +			dev_err(card->dev, "Unable to add Headphone Jack\n");
> +			return rval;
> +		}
> +
> +		jack = pdata->jack.jack;
> +
> +		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +		pdata->jack_setup = true;
> +	}
> +
> +	for (i = 0 ; i < dai_link->num_codecs; i++) {
> +		struct snd_soc_dai *dai = rtd->codec_dais[i];
> +
> +		component = dai->component;
> +		rval = snd_soc_component_set_jack(
> +				component, &pdata->jack, NULL);
> +		if (rval != 0 && rval != -ENOTSUPP) {
> +			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
> +			return rval;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +
>   static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   {
>   	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> @@ -220,7 +272,7 @@ static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
>   	SND_SOC_DAPM_MIC("Int Mic", NULL),
>   };
>   
> -static void sdm845_add_be_ops(struct snd_soc_card *card)
> +static void sdm845_add_ops(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai_link *link;
>   	int i;
> @@ -230,6 +282,7 @@ static void sdm845_add_be_ops(struct snd_soc_card *card)
>   			link->ops = &sdm845_be_ops;
>   			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
>   		}
> +		link->init = sdm845_dai_init;
>   	}
>   }
>   
> @@ -264,7 +317,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
>   	data->card = card;
>   	snd_soc_card_set_drvdata(card, data);
>   
> -	sdm845_add_be_ops(card);
> +	sdm845_add_ops(card);
>   	ret = snd_soc_register_card(card);
>   	if (ret) {
>   		dev_err(dev, "Sound card registration failed\n");
> 
