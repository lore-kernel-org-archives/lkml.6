Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236ADC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D9E20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AwDeX8U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfBBQE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:04:56 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4109 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBBQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:04:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c55bf830000>; Sat, 02 Feb 2019 08:04:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 02 Feb 2019 08:04:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 02 Feb 2019 08:04:48 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 16:04:46 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
 <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <e2bcf87a-1cf4-c149-9b72-10fe46052f9e@nvidia.com>
Date:   Sun, 3 Feb 2019 00:04:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549123459; bh=Wgrp3zwbX7fCu/fjyxmLXE0T0P95Qlrfo03Klo+AyrM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AwDeX8U0LMOdD0kdz3X6imrlfNfkKkVYxFHOEFQQGbZ3lNAy8nos6N86m+c+znP0m
         vxN1jC+a3GrR3f1V3Bj4OuQWgdSEqXyEc9buutHJE2FMR9RDgvSHRzb09pwCfkqrvj
         IOuTrHtlgjfLCbIvxEw7JSM31H3KUVfOB/n7LWU0doOaY4AmqQ/wlsvb/JdXU11gcR
         N+QDVOo8oZzQBgQqx0tBAdvo1QEgQwZl1+P4g2nIpbaY5bvP/zdEJYtigvOmG2P9XW
         460allxHl+9Wzy3RwwgHXxA1qlIj7sWiC9BVrkF4QLy3UothrTe7+WX1v7BZcDlJ6u
         yEViMxb8L+L0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/19 9:30 PM, Dmitry Osipenko wrote:
> 01.02.2019 18:37, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 2/1/19 11:13 PM, Dmitry Osipenko wrote:
>>> 01.02.2019 17:13, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 2/1/19 9:54 PM, Jon Hunter wrote:
>>>>>
>>>>> On 01/02/2019 13:11, Dmitry Osipenko wrote:
>>>>>> 01.02.2019 16:06, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>> 01.02.2019 6:36, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>>>>> (TMR10-TMR13). We need these timers to work as clock event device =
and to
>>>>>>>> replace the ARMv8 architected timer due to it can't survive across=
 the
>>>>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a=
 wake-up
>>>>>>>> source when CPU suspends in power down state.
>>>>>>>>
>>>>>>>> Also convert the original driver to use timer-of API.
>>>>>>>>
>>>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>>>>> ---
>> snip.
>>>>>>>> +}
>>>>>>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra21=
0_timer_init);
>>>>>>>> +#else /* CONFIG_ARM */
>>>>>>>> +static int __init tegra20_init_timer(struct device_node *np)
>>>>>>>> +{
>>>>>>> What about T132? Isn't it ARM64 which uses tegra20-timer IP? At lea=
st T132 DT suggests so and seems this change will break it.
>>>>>>>
>>>>>>> [snip]
>>>>>>>
>>>>>>
>>>>>> Ah, noticed the "depends on ARM" in Kconfig.. Seems okay then.
>>>>>>
>>>>>
>>>>>
>>>>> This is a good point, because even though we had 'depends on ARM', th=
is
>>>>> still means that the Tegra132 DT is incorrect.
>>>>>
>>>>> Joseph, can you take a quick look at Tegra132?
>>>>
>>>> Hi Jon and Dmitry,
>>>>
>>>> No worry about T132, T132 uses arch timer (v7). The tegra20 timer driv=
er has never been used. We should fix the dtsi file later.
>>>
>>> Hi Joseph,
>>>
>>> So is T132 HW actually incompatible with the tegra20-timer? If it's com=
patible, then I think the driver's code should be made more universal to su=
pport T132.
>>>
>>
>>  From HW point of view, the TIMER1 ~ TIMER4 is compatible with "nvidia,t=
egra20-timer". But Tegra132 actually has 10 timers which are exactly the sa=
me as Tegra30. So it should backward compatible with "nvidia,tegra30-timer"=
, which is tegra_wdt driver now. And Tegra132 should never use this driver.
>=20
> Then shouldn't device tree look like this? Why TMR7-TMR0 are not defined =
there?
Yeah, they need to revisit and fix.
>=20
> 	timer@60005000 {
> 		compatible =3D "nvidia,tegra124-timer", "nvidia,tegra30-timer", "nvidia=
,tegra20-timer";
> 		reg =3D <0x0 0x60005000 0x0 0x400>;
> 		interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> 			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> 			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> 			     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> 			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&tegra_car TEGRA124_CLK_TIMER>;
> 		clock-names =3D "timer";
> 	};
>=20
> TMR 0,6,7,8,9 should define a shared interrupt as well, but seems the sha=
red interrupt provider is not supported in upstream.
>=20
> Also note that seems T124/132 device tree has a typo (I'm looking at TK1 =
TRM), TMR6 IRQ is 152 and not 122.
>=20
> And T30 device tree looks incorrect, TRM says that TMR1-TMR5 have a "dedi=
cated interrupt bit", but not TMR6.
>=20
Yeah, noticed that as well. Because the wdt driver doesn't need IRQ=20
support and they (Tegra114/124/132) use arch timer. So everything just=20
works fine.

Thanks,
Joseph
