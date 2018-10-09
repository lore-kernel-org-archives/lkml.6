Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50BBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C5B214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5B214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJIR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:57:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41855 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJIR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:57:23 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g9pRl-0007ng-2G from Jiada_Wang@mentor.com ; Tue, 09 Oct 2018 03:41:01 -0700
Received: from [172.30.112.244] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 9 Oct 2018 03:40:57 -0700
Subject: Re: [alsa-devel] [PATCH linux-next v2 9/9] ASoC: rsnd: add busif
 property to dai stream
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003090136.4556-1-jiada_wang@mentor.com>
 <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
 <557e63d1-dbb7-4232-b53e-4a5499024180@mentor.com>
 <87pnwqpeni.wl-kuninori.morimoto.gx@renesas.com>
 <a5712f6a-a61b-f6c4-4f3d-a6d4a60bcfab@mentor.com>
 <87h8hward4.wl-kuninori.morimoto.gx@renesas.com>
 <ed602ba8-6dc5-005c-3267-47aa378b6c0a@mentor.com>
 <877eirbmcf.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <c60ffb70-b70e-4764-3d64-d8d5bf67413d@mentor.com>
Date:   Tue, 9 Oct 2018 19:40:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877eirbmcf.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

Thanks for your feedback

On 2018/10/09 16:47, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thanks for your feedback
>
>> 1ch:  (tdm_slots < 4) Basic mode, (tdm_slots >= 4) TDM Split mode
>> 2ch: (2 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
>> 4ch: (4 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
>> 6ch: (6 <= tdm_slots < 8) Basic mode, (tdm_slots == 8) TDM Extended
>> mode, (8 < tdm_slots) TDM Ex-Split mode
>> 8ch: (6 <= tdm_slots < 8) TDM Extended mode, (8 <= tdm_slots < 16)
>> Basic mode, (tdm_slots == 16) TDM Ex-Split
>> 10ch: TDM Ex-Split mode
>> 16ch: Basic Mode
> Sorry, but I couldn't understand what this table means ?
> For example, what does "1ch" mean ?
> It looks like "1ch playback by TDM"...
sorry for vague explanation,
by "1ch" I mean runtime 1 channel playback
for example:
if user plays 1 channel stream, by checking tdm_slots value,
if it is < 4, then it can't be working in Split mode, so driver will
automatically set SSI to work in Basic mode, otherwise, SSI will
work in TDM Split mode.

>> The reason I added rsnd_ssi_select_busif(io, chan) in rsnd_hw_params()
>> in patch ASoC: rsnd: add busif property to dai stream of v2 patch-set,
>> is because runtime channel is necessary information to determine which
>> BUSIFx to select,
>> (which is mentioned in above)
>> and at this stage (rsnd_hw_params()), all other control settings
>> (register setting, dma address calculation etc)
>> haven't been done, so corresponding dai-link can be considered to be
>> not active at this timing
>> but maybe you have better suggestion when to automatically select BUSIFx
> My image is like this.
>
> 	sound {
> 		compatible = "simple-scu-audio-card or new card";
> 		...
> 		simple-audio-card,convert-channels = <8>;
> 		...
> 		busif0: simple-audio-card,cpu@0 { sound-dai = <&rcar_sound 0>; };
> 		busif1: simple-audio-card,cpu@1 { sound-dai = <&rcar_sound 1>; };
> 		busif2: simple-audio-card,cpu@2 { sound-dai = <&rcar_sound 2>; };
> 		busif3: simple-audio-card,cpu@3 { sound-dai = <&rcar_sound 3>; };
> 		        simple-audio-card,codec { sound-dai = <&xxx>;          };
> 	};
>
> 	rcar_sound {
> 		dai0 { playback = <&ssiu0 ssi0>; }
> 		dai1 { playback = <&ssiu1 ssi0>; }
> 		dai2 { playback = <&ssiu2 ssi0>; }
> 		dai3 { playback = <&ssiu3 ssi0>; }
> 	};
After re-think about BUSIFx selection, I agree with you,
it shouldn't be random, and select it via device-tree, as you have 
already demonstrated
is a good idea

Based on our discussion so far, I think we both agree on the following 
points
1. Driver select SSI mode automatically (by checking tdm_slots, runtime 
channel, etc)
2. Driver parse BUSIFx for each dai-link from device-tree

I will review my v2 patch-set, drop changes violate to above two points


Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto

