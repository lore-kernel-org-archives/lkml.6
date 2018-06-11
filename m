Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XHOYHqbbHVvhCgAAmS7hNA
	; Mon, 11 Jun 2018 02:49:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1FA5B607A4; Mon, 11 Jun 2018 02:49:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAB2D60908;
	Mon, 11 Jun 2018 02:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAB2D60908
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeFKCtw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:49:52 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:39617 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeFKCtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:49:51 -0400
X-Greylist: delayed 2789 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 22:49:51 EDT
Received: from [192.168.1.2] (210.161.151.153.ap.dti.ne.jp [153.151.161.210])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5B23Ks6083588
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 11 Jun 2018 11:03:21 +0900 (JST)
        (envelope-from suzuki.katsuhiro@socionext.com)
Subject: Re: [alsa-devel] [PATCH] ASoC: audio-graph-card: add hp and mic
 detect gpios same as simple-card
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180608080843.11097-1-suzuki.katsuhiro@socionext.com>
 <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Message-ID: <a397e5b7-f6bd-17b5-2105-5875085467e5@socionext.com>
Date: Mon, 11 Jun 2018 11:03:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Morimoto-san,

Thank you for your reviewing.

On 06/11/18 08:52, Kuninori Morimoto wrote:
> 
> Hi Katsuhiro-san
> 
> Thank you for your patch
> 
>> This patch adds headphone and microphone jack detection gpios as same
>> as simple-card driver. This feature move into simple-card-utils from
>> simple-card to avoid the duplicating code.
>>
>> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>> ---
> 
> I think it can be 2 patches ?
>   1. move function from simple-card to simple-card-utils
>   2. use it from audio-graph-card
> 

OK, I'll split this patch.


>> +static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
>> +{
>> +	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
>> +	int ret;
>> +
>> +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>   static int asoc_graph_card_probe(struct platform_device *pdev)
>>   {
>>   	struct graph_card_data *priv;
>> @@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
>>   	card->num_links	= num;
>>   	card->dapm_widgets = asoc_graph_card_dapm_widgets;
>>   	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
>> +	card->probe	= asoc_graph_soc_card_probe;
> 
> Current simple-card is calling init_hp/init_mic from
> asoc_simple_card_dai_init(), and audio-graph-card has
> asoc_graph_card_dai_init().
> simple/audio card are doing samethings in different style.
> Thus, I want to synchronized whole simple/audio card.
> 

Ah, right. I need to add more one patch.

   1. move function from simple-card to simple-card-utils
   2. change calling init_hp/mic from soc_dai_link.init() to
      soc_card.probe()
   3. use it from audio-graph-card


Regards,
--
Katsuhiro Suzuki


> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
