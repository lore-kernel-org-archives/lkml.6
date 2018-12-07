Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA76C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3332082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3332082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLGR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:57:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:35705 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeLGR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:57:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 09:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,327,1539673200"; 
   d="scan'208";a="128033502"
Received: from knelson-mobl3.amr.corp.intel.com (HELO [10.252.140.115]) ([10.252.140.115])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2018 09:57:13 -0800
Subject: Re: [PATCH v1] ASoC: Intel: kbl_da7219_max98927: fix the audio jack
 button remapping
To:     Zhuohao Lee <zhuohao@chromium.org>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Chang <changmax@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        linux-kernel@vger.kernel.org, "Zhi, Yong" <yong.zhi@intel.com>
References: <20181207090552.105205-1-zhuohao@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <90b46425-5dbd-2ba7-d57d-270d0ab68632@linux.intel.com>
Date:   Fri, 7 Dec 2018 11:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207090552.105205-1-zhuohao@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/18 3:05 AM, Zhuohao Lee wrote:
>  From the da7219 spec, the button A, B, C and D are remapped to
> 0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
> B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND

Ok, but could fix all da7219-based machine drivers then, the mappings 
are completely inconsistent:

kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0, 
KEY_MEDIA);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1, 
KEY_VOLUMEUP);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2, 
KEY_VOLUMEDOWN);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3, 
KEY_VOICECOMMAND);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0, 
KEY_PLAYPAUSE);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1, 
KEY_VOICECOMMAND);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2, 
KEY_VOLUMEUP);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3, 
KEY_VOLUMEDOWN);

Thanks!

>
> Change-Id: I67f929f226883bd289cb7beb0a7b23f40e7121e2
You want to remove those Change-Ids for upstream.
> Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> Signed-off-by: Max Chang  <changmax@chromium.org>
> ---
>   sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
> index 3fa1c3ca6d37..d3531f0eb357 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> @@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   
>   	jack = &ctx->kabylake_headset;
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
>   
>   	da7219_aad_jack_det(component, &ctx->kabylake_headset);
>   
