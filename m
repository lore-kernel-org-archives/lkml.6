Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF820645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DF820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJDKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:07:01 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:56467 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJDKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:07:01 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7u7A-0000o2-VS from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 20:15:49 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 20:15:45 -0700
Subject: Re: [PATCH linux-next v2 1/9] arm64: r8a7795: add dma request number
 for busif0 ~ busif7
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003085855.4305-1-jiada_wang@mentor.com>
 <20181003085855.4305-2-jiada_wang@mentor.com>
 <87y3bepmgb.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <bd6eb187-8064-97f5-fe87-fc68f0cc1190@mentor.com>
Date:   Thu, 4 Oct 2018 12:15:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3bepmgb.wl-kuninori.morimoto.gx@renesas.com>
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


On 2018/10/04 9:55, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> This patch adds dma request number for busif0 ~ busif7
>> to be used by GEN3 series. GEN2 continues to use rxu/txu
>> for busif data transfer.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 164 ++++++++++++++++++++---
>>   1 file changed, 144 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> index b5f2273caca4..fc6100eddfed 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -1923,53 +1923,177 @@
>>   			rcar_sound,ssi {
>>   				ssi0: ssi-0 {
>>   					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
>> -					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
>> -					dma-names = "rx", "tx", "rxu", "txu";
>> +					dmas = <&audma0 0x01>, <&audma1 0x02>,
>> +					       <&audma0 0x15>, <&audma1 0x16>,
>> +					       <&audma0 0x15>, <&audma1 0x16>,
>> +					       <&audma0 0x35>, <&audma1 0x36>,
>> +					       <&audma0 0x37>, <&audma1 0x38>,
>> +					       <&audma0 0x47>, <&audma1 0x48>,
>> +					       <&audma0 0x3f>, <&audma1 0x40>,
>> +					       <&audma0 0x43>, <&audma1 0x44>,
>> +					       <&audma0 0x4f>, <&audma1 0x50>,
>> +					       <&audma0 0x53>, <&audma1 0x54>;
>> +					dma-names = "rx", "tx",
>> +						    "rxu", "txu",
>> +						    "rxu0", "txu0",
>> +						    "rxu1", "txu1",
>> +						    "rxu2", "txu2",
>> +						    "rxu3", "txu3",
>> +						    "rxu4", "txu4",
>> +						    "rxu5", "txu5",
>> +						    "rxu6", "txu6",
>> +						    "rxu7", "txu7";
> In theory, I think DT side patch should be posted/applied
> if driver side patch was accepted.
> And, Gen3 side DT doesn't need "rxu/txu" I think.
OK, I will separate DT and driver side change,
will remove DT change in next version.


Thanks,
Jiada

