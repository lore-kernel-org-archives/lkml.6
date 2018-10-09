Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CEC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9110F20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9110F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJIOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:24:43 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57031 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:24:43 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g9m8k-0007ZQ-1u from Jiada_Wang@mentor.com ; Tue, 09 Oct 2018 00:09:10 -0700
Received: from [172.30.112.244] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 9 Oct 2018 00:09:06 -0700
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
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <ed602ba8-6dc5-005c-3267-47aa378b6c0a@mentor.com>
Date:   Tue, 9 Oct 2018 16:09:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8hward4.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

Thanks for your comment

On 2018/10/09 9:44, Kuninori Morimoto wrote:
> Hi Jiada
>
>> SSI can work in following modes
>> 1. Basic Mode: (channel 1, 2, 4, 6, 8, 16)
>> 2. TDM Extended Mode: (channel 6, 8)
>> 3. TDM Split Mode: (channel 1, 2)
>> 4. TDM Ex-Split mode: (Channel 2, 4, 6, 8, 10)
> (snip)
>>> So, my opinions for BUSIFn support are
>>> 	- SSI mode should be selected automatically
>> can you give me your idea, how to automatically determine working mode,
>> when user plays 2 channel stream on playback dai-link
> If my understanding was correct, we can do like this
> If DT indicated sound card has dai-link x N, tdm-slots = <M>,
> 	If (N, M) = (1, 2) : Basic mode
> 	If (N, M) = (1, >2): TDM mode
> 	If (N, M) = (2, 4) : TDM Split mode
> 	If (N, M) = (2, >4): TDM Ex-Split mode
> 	If (N, M) = (>2, 8): TDM Split mode
> 	...
>
> Maybe some combination was wrong, but we can do something like this ?
The idea to consider tdm_slot when determine SSI mode makes sense to me,
by checking runtime channel and tdm_slots combination,
I think SSI mode can be automatically selected like following:

1ch:  (tdm_slots < 4) Basic mode, (tdm_slots >= 4) TDM Split mode
2ch: (2 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
4ch: (4 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
6ch: (6 <= tdm_slots < 8) Basic mode, (tdm_slots == 8) TDM Extended 
mode, (8 < tdm_slots) TDM Ex-Split mode
8ch: (6 <= tdm_slots < 8) TDM Extended mode, (8 <= tdm_slots < 16) Basic 
mode, (tdm_slots == 16) TDM Ex-Split
10ch: TDM Ex-Split mode
16ch: Basic Mode

>> for example user asks dai-link0 to playback 2ch audio stream,
>> driver can't determine which mode to work, as it can be Basic mode,
>> Split mode or Ex-Split mode.
> Why do we need to use Basic mode if HW has TDM Split mode connection?
> If user playbacks 2ch audio in such situation,
> we can use TDM Split mode (= only 2ch has sound, other channel has no sound ?)
> user might start to playback for other channels.
> I'm not sure how it works...
>>> 	- BUSIFn connection should be selected on DT
>> since which BUSIFx is used during audio data transfer, is not
>> consideration of user,
>> I think your previous suggestion, (automatically select BUSIFx) makes
>> more sense
> I'm not yet sure detail, but in your idea, does it mean,
> BUSIFx connection might be exchanged runtime ?
no BUSIFx shouldn't be changed during runtime, my idea is BUSIFx can be 
automatically selected
when corresponding dai-link is not active

The reason I added rsnd_ssi_select_busif(io, chan) in rsnd_hw_params() 
in patch ASoC: rsnd: add busif property to dai stream of v2 patch-set,
is because runtime channel is necessary information to determine which 
BUSIFx to select,
(which is mentioned in above)
and at this stage (rsnd_hw_params()), all other control settings 
(register setting, dma address calculation etc)
haven't been done, so corresponding dai-link can be considered to be not 
active at this timing
but maybe you have better suggestion when to automatically select BUSIFx

What is your opinion?

Thanks,
Jiada
> I think BUSIFx connection shouldn't exchanged runtime IMO.
> Otherwise, sound position can't be fixed, and user can't control
> sound, I think...

>
> Best regards
> ---
> Kuninori Morimoto

