Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62CC21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62CC21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJDNwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:52:20 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34818 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:52:20 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7xcb-0002dV-Bc from Jiada_Wang@mentor.com ; Thu, 04 Oct 2018 00:00:29 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 4 Oct 2018 00:00:26 -0700
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
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <a5712f6a-a61b-f6c4-4f3d-a6d4a60bcfab@mentor.com>
Date:   Thu, 4 Oct 2018 16:00:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87pnwqpeni.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


Thanks for your comments


On 2018/10/04 12:43, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your feedback
>
>>>> in GEN3 SSI may use different BUSIF for data transfer,
>>>> this patch adds busif property to each dai stream,
>>>> to indicate the BUSIF used by playback/capture stream.
>>>>
>>>> Also adds rsnd_ssi_select_busif() to automatically select
>>>> BUSIF (currently only BUSIF0 is selected)
>>>>
>>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>>> ---
> (snip)
>>> And this patch selects it on runtime (= hw_param) ?
>> Because, in order to automatically determine BUSIF number,
>> information like SSI mode (non-Split/Split/Ex-Split), runtime channel,
>> are required
>> (in our internal implementation, SSI mode is selected by kctrl)
>> because of this, in this patch, BUSIF is selected on runtime
>>
>>> But, I think we can/should select it on probe timing from DT connection.
>>> Am I misunderstanding ?
>> with the above reasoning, BUSIF is selected on runtime.
>> what do you think?
> I have no objection that you are customizing your kernel locally.
> But, upstreaming kernel based on it is not acceptable for me.
> I'm not sure detail of your local implementation, but I don't think we
> need to select SSI mode by kctrl.
> If my understanding was correct, it can also be selected automatically somehow.
> Or, am I misunderstanding ?
SSI can work in following modes
1. Basic Mode: (channel 1, 2, 4, 6, 8, 16)
2. TDM Extended Mode: (channel 6, 8)
3. TDM Split Mode: (channel 1, 2)
4. TDM Ex-Split mode: (Channel 2, 4, 6, 8, 10)

for example user asks dai-link0 to playback 2ch audio stream,
driver can't determine which mode to work, as it can be Basic mode, 
Split mode or Ex-Split mode.

> I could understand what you want to do, and yes, I can agree that we want/need
> to have it on upstream. Thank you very much to indicating it to me.
> But we need to consider more how to implement it.
> Especially, it is related to DT bindings.
> As you already know, if it is implemented on upstream kernel, we need to keep
> compatibility in the future, and it is very difficult.
Yes, I agree with you, upstream need to consider lots of things
>
> So, my opinions for BUSIFn support are
> 	- SSI mode should be selected automatically
can you give me your idea, how to automatically determine working mode,
when user plays 2 channel stream on playback dai-link
> 	- BUSIFn connection should be selected on DT
since which BUSIFx is used during audio data transfer, is not 
consideration of user,
I think your previous suggestion, (automatically select BUSIFx) makes 
more sense

Thanks,
Jiada
> 	  (I think we don't want random sound output position ?)
> 	  - To select it, we need to have new "ssiu" DT seetings,
> 	    or parse sound card. Maybe adding ssiu is realistic.
>
>
> Best regards
> ---
> Kuninori Morimoto

