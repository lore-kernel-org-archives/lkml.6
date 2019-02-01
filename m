Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D39BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAD9218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WvYdfYnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfBAPhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:37:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6576 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfBAPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:37:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5467870000>; Fri, 01 Feb 2019 07:36:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 07:37:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 07:37:08 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 15:37:06 +0000
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
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
Date:   Fri, 1 Feb 2019 23:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549035399; bh=dcZZ3L5tO8XRb2PfNJdhsg3I3b34TUwbub/q4ZQpWto=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WvYdfYndSGy/n6jHLURLI1YCqQXQ3j3cfIFB0lkOrM1+w9Y3/feTLTnV0u0n3gD7+
         z/va35jyr9gJkC3eHLJPjwQMdx2l1vLWhIE1jQWdFGWJ3TFfITfAxqkRw1PaxcOjan
         MmoxQUolBj6xl5TcNiNtaY4uEFKPmBngoeg77Yjn6YbCwtQWKgoLf08JF52wJi+Yc5
         sW0PCxwFp5NPaAc87h8QdzkrkazVsJjlnWUqMcXtmeb4nGmLhM0dBcs2j/vQsf889V
         m9ZPF1GqzZo3RnZS6ke2kcm0gfxH1nPFV9zeHreLJzJKbIWUiH3XqzGYlLxosAzFP7
         9e/PleT+WQ3Bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 11:13 PM, Dmitry Osipenko wrote:
> 01.02.2019 17:13, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 2/1/19 9:54 PM, Jon Hunter wrote:
>>>
>>> On 01/02/2019 13:11, Dmitry Osipenko wrote:
>>>> 01.02.2019 16:06, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> 01.02.2019 6:36, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>>> (TMR10-TMR13). We need these timers to work as clock event device an=
d to
>>>>>> replace the ARMv8 architected timer due to it can't survive across t=
he
>>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a w=
ake-up
>>>>>> source when CPU suspends in power down state.
>>>>>>
>>>>>> Also convert the original driver to use timer-of API.
>>>>>>
>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>>> ---
snip.
>>>>>> +}
>>>>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_=
timer_init);
>>>>>> +#else /* CONFIG_ARM */
>>>>>> +static int __init tegra20_init_timer(struct device_node *np)
>>>>>> +{
>>>>> What about T132? Isn't it ARM64 which uses tegra20-timer IP? At least=
 T132 DT suggests so and seems this change will break it.
>>>>>
>>>>> [snip]
>>>>>
>>>>
>>>> Ah, noticed the "depends on ARM" in Kconfig.. Seems okay then.
>>>>
>>>
>>>
>>> This is a good point, because even though we had 'depends on ARM', this
>>> still means that the Tegra132 DT is incorrect.
>>>
>>> Joseph, can you take a quick look at Tegra132?
>>
>> Hi Jon and Dmitry,
>>
>> No worry about T132, T132 uses arch timer (v7). The tegra20 timer driver=
 has never been used. We should fix the dtsi file later.
>=20
> Hi Joseph,
>=20
> So is T132 HW actually incompatible with the tegra20-timer? If it's compa=
tible, then I think the driver's code should be made more universal to supp=
ort T132.
>=20

 From HW point of view, the TIMER1 ~ TIMER4 is compatible with=20
"nvidia,tegra20-timer". But Tegra132 actually has 10 timers which are=20
exactly the same as Tegra30. So it should backward compatible with=20
"nvidia,tegra30-timer", which is tegra_wdt driver now. And Tegra132=20
should never use this driver.

The Tegra timer driver should only be used on Tegra20/30/210, three=20
platforms only. Others use arch timer driver for system timer driver.

So we don't really need to take care the usage on other Tegra platforms.

Thanks,
Joseph
