Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8662D208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8662D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJBOea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:34:30 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:33090 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJBOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:34:30 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7FTq-0006oT-FL from Jiada_Wang@mentor.com ; Tue, 02 Oct 2018 00:52:30 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 2 Oct 2018 00:52:26 -0700
Subject: Re: [PATCH linux-next 01/10] ASoC: rsnd: ssi: Request dedicated dma
 channels for busif1 to 7
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Mark Brown <broonie@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <dragos_tarcatu@mentor.com>, <twischer@de.adit-jv.com>,
        <tiwai@suse.com>, <perex@perex.cz>
References: <20180927050407.17765-1-jiada_wang@mentor.com>
 <20180927050407.17765-2-jiada_wang@mentor.com>
 <87k1n6trsf.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <01535cc6-bd85-aec1-b0ce-7ea9e60533d0@mentor.com>
Date:   Tue, 2 Oct 2018 16:52:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87k1n6trsf.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/09/28 9:08, Kuninori Morimoto wrote:
> Hi Jiada
> Cc: linux-renesas-soc ML
>
> Thank you for your patch
>
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> Currently ssi driver only request dma channel for SSI_0,
>> which is used to transfer data to/from busif0.
>>
>> But since busif1 to busif7 also maybe used, dedicated dma channels
>> are request for data transfer between these busif.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> (snip)
>> @@ -938,12 +940,20 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
>>   {
>>   	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
>>   	int is_play = rsnd_io_is_play(io);
>> -	char *name;
>> +	int busif = rsnd_ssi_get_busif(io);
>> +	char name[SSI_DMA_NAME_SIZE];
>>   
>> -	if (rsnd_ssi_use_busif(io))
>> -		name = is_play ? "rxu" : "txu";
>> -	else
>> -		name = is_play ? "rx" : "tx";
>> +	if (rsnd_ssi_use_busif(io)) {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
>> +	} else {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rx");
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "tx");
>> +	}
> Unfortunately, this patch breaks "git bisect", and Gen2 platforms.
> We need to keep existing "rxu/txu" more. Please consider compatibility.
> # we can remove it 2 or 3 version later ?
>
> If the commit which has this patch, but doesn't have [02/xx] or later,
> it can't use BUSIF.
>
> And your patch doesn't care Gen2 series.
> DT compatibility is very sensitive...
Thanks for your review comments, I will send out v2 patch set to take 
care of GEN2 series,
and move this patch after other DT related patches

Thanks,
Jiada
