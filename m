Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26405C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC922214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC922214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJDJvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:51:45 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:55806 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeJDJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:51:45 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7tsQ-0006yb-Mw from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 20:00:34 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 20:00:31 -0700
Subject: Re: [PATCH linux-next v2 8/9] ASoC: rsnd: ssi: Request dedicated dma
 channels for busif0 to 7
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003090122.4508-1-jiada_wang@mentor.com>
 <87woqyplnr.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <7d213396-a56e-e83d-7d0b-7edf49911b41@mentor.com>
Date:   Thu, 4 Oct 2018 12:00:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87woqyplnr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/10/04 10:12, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> Currently ssi driver only request dma channel for SSI_0,
>> which is used to transfer data to/from busif0.
>>
>> But in GEN3 busif1 to busif7 also maybe used, dedicated dma channels
>> are requested for data transfer through these busif.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> (snip)
>> +	if (rsnd_ssi_use_busif(io)) {
>> +		if (is_play)
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "rxu");
>> +		else
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "txu");
>> +
>> +		if (rsnd_is_gen3(priv)) {
>> +			/*
>> +			 * Gen3 supports to use all available BUSIF
>> +			 */
>> +			int busif = rsnd_ssi_get_busif(io);
>> +
>> +			snprintf(name, SSI_DMA_NAME_SIZE, "%s%d", name, busif);
>> +		}
> I think unspecified GenX is better idea.
> For example, we might want to have same setting on Gen2 in the future.
> (and this is not Gen3 HW specific feature
>   But yes, we have SW side reason)
>
> How about like this ?
> We can keep compatibility, and both Gen2/Gen3 can use it.
>
> 	if (rsnd_ssi_use_busif(io)) {
> 		/*
> 		 * 1) try to find txu%d/rxu%d first
> 		 * 2) If can't find it, try to find old txu/rxu
> 		 */
> 	}
I think this is a good idea, by doing so,
in case GEN2 DT also starts to support different BUSIF,
then no driver side change is required.

I will update accordingly in next version

Thanks,
Jiada

