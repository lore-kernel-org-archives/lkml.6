Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C25EC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1BE2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1BE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJDJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:34:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:54753 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:34:32 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7tbm-0004sB-Sb from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 19:43:22 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 19:43:19 -0700
Subject: Re: [alsa-devel] [PATCH linux-next v2 9/9] ASoC: rsnd: add busif
 property to dai stream
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003090136.4556-1-jiada_wang@mentor.com>
 <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <557e63d1-dbb7-4232-b53e-4a5499024180@mentor.com>
Date:   Thu, 4 Oct 2018 11:43:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/10/04 10:41, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> in GEN3 SSI may use different BUSIF for data transfer,
>> this patch adds busif property to each dai stream,
>> to indicate the BUSIF used by playback/capture stream.
>>
>> Also adds rsnd_ssi_select_busif() to automatically select
>> BUSIF (currently only BUSIF0 is selected)
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   sound/soc/sh/rcar/core.c |  3 +++
>>   sound/soc/sh/rcar/dma.c  | 31 +++++++++++++++++++++++++++++++
>>   sound/soc/sh/rcar/rsnd.h |  3 +++
>>   sound/soc/sh/rcar/ssi.c  | 30 +++++++++++++++++++++++++++++-
>>   4 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
>> index 40d7dc4f7839..5e3e6e65bcdf 100644
>> --- a/sound/soc/sh/rcar/core.c
>> +++ b/sound/soc/sh/rcar/core.c
>> @@ -1158,6 +1158,9 @@ static int rsnd_hw_params(struct snd_pcm_substream *substream,
>>   	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
>>   	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
>>   	int ret;
>> +	int chan = rsnd_runtime_channel_for_ssi_with_params(io, hw_params);
>> +
>> +	rsnd_ssi_select_busif(io, chan);
> If my understanding was correct, the chance to use BUSIFx is when TDM split mode.
Yes, only when SSI works in Split/Ex-Split mode, BUSIFx other than 0 is 
necessary
> And this patch selects it on runtime (= hw_param) ?
Because, in order to automatically determine BUSIF number,
information like SSI mode (non-Split/Split/Ex-Split), runtime channel, 
are required
(in our internal implementation, SSI mode is selected by kctrl)
because of this, in this patch, BUSIF is selected on runtime

> But, I think we can/should select it on probe timing from DT connection.
> Am I misunderstanding ?
with the above reasoning, BUSIF is selected on runtime.
what do you think?

Thanks,
Jiada
> I'm not sure how to select, but adding new ssiuX0 - ssiuX7
> is realistic idea (parse sound card is not realistic...) ?
> If so, your rxu/txu DMA can be more simple ?

