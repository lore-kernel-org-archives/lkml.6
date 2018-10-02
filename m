Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A3C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8A2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8A2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJBOk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:40:29 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:33535 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJBOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:40:29 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7FZe-0007Vd-8M from Jiada_Wang@mentor.com ; Tue, 02 Oct 2018 00:58:30 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 2 Oct 2018 00:58:26 -0700
Subject: Re: [PATCH linux-next 09/10] ASoC: rsnd: add busif property to dai
 stream
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20180927051212.18032-1-jiada_wang@mentor.com>
 <87in2qtr6f.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <042e51bb-7c48-9145-51f2-b6687c044c19@mentor.com>
Date:   Tue, 2 Oct 2018 16:58:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87in2qtr6f.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/09/28 9:21, Kuninori Morimoto wrote:
> Hi Jiada
>
>
>> SSI may use different busif for data transfer, this patch
>> adds busif property to each dai stream, to indicate the
>> busif used by playback/capture stream.
> (snip)
>> +	io_playback->busif = rsnd_busif_get(priv, dai_i);
>> +	io_capture->busif  = rsnd_busif_get(priv, rsnd_rdai_nr(priv) + dai_i);
> (snip)
>> +	busif = devm_kcalloc(dev, 2 * nr, sizeof(*busif), GFP_KERNEL);
> (snip)
>> @@ -456,6 +456,7 @@ struct rsnd_dai_stream {
>>   	struct rsnd_mod *dma;
>>   	struct rsnd_dai *rdai;
>>   	struct device *dmac_dev; /* for IPMMU */
>> +	struct rsnd_kctrl_cfg_s *busif;
>>   	u32 parent_ssi_status;
>>   };
> It looks very complex to me.
> Why don't you just have "busif" on rsnd_dai_stream, instead of "*busif" ?
yes, it can be replaced with *busif instead,
but it will result in some reorder of declarations in rsnd.h
will update this patch in v2 patch set.

  Thanks,
Jiada
>>   int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
>>   {
>> -	return 0; /* BUSIF0 only for now */
>> +	if (!rsnd_ssi_use_busif(io))
>> +		return 0;
>> +
>> +	return io->busif->val;
>>   }
> Who/How update val ?
>

