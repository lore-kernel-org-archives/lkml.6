Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0421904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QKSbY6rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfBSJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:01:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4441 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:01:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6bc5d10000>; Tue, 19 Feb 2019 01:01:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2019 01:01:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Feb 2019 01:01:06 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 09:01:04 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
 <87731d61-10f6-0842-a90f-0c78ffba9ef7@nvidia.com>
 <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
Date:   Tue, 19 Feb 2019 17:00:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550566865; bh=Of4rckaBTBqLneyOBEUuKLGJJlzZ4kNfxRlShvTeqDk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QKSbY6rl1KF1YrRJquZIHwyPTETZqepZduF23SQDETBLYDSJY6OgfT/x6ZKME5iL2
         sP1kk09TW9Z5i9pBiFZBR1+odIGP2fCn9Re2MvhciQ4DayMS8JLjq+pOdnK6HwFjLG
         IQvh7x+GwDXf+s40E1DhVlTOs1RJnzoDmirsKFYndIZ1xkiaSpP0AX77AEss5KP6rV
         azK8h32QzC8bEMfPM9aRNMT/MSBoIlp34IJk7YPQ7p71evnpBg0DSGV6Q2SLaqny+0
         pOxLd2cQgENSmUWtwKiu3f4hCZfhD6cF2WczGRuC+AxHFG/jAuTg5zoe94+RHjDIh5
         iw8k0QE0i6Wsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:39 PM, Daniel Lezcano wrote:
> On 18/02/2019 10:01, Joseph Lo wrote:
>> On 2/15/19 11:14 PM, Daniel Lezcano wrote:
>>> On 01/02/2019 17:16, Joseph Lo wrote:
>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>> (TMR10-TMR13). We need these timers to work as clock event device and =
to
>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>>> wake-up
>>>> source when CPU suspends in power down state.
>>>>
>>>> Also convert the original driver to use timer-of API.
>>>>
>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>> v6:
>>>>  =C2=A0 * refine the timer defines
>>>>  =C2=A0 * add ack tag from Jon.
>>>> v5:
>>>>  =C2=A0 * add ack tag from Thierry
>>>> v4:
>>>>  =C2=A0 * merge timer-tegra210.c in previous version into timer-tegra2=
0.c
>>>> v3:
>>>>  =C2=A0 * use timer-of API
>>>> v2:
>>>>  =C2=A0 * add error clean-up code
>>>> ---
[snip]
>>>> +=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cpu) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timer_of *cpu_to;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to =3D per_cpu_ptr(&te=
gra_to, cpu);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->of_base.base =3D t=
imer_reg_base +
>>>> TIMER_BASE_FOR_CPU(cpu);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->of_clk.rate =3D ti=
mer_of_rate(to);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.cpumask =3D=
 cpumask_of(cpu);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.irq =3D
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ir=
q_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_to->clkevt.irq) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
_err("%s: can't map IRQ for CPU%d\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, cpu);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EINVAL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_set_status_flags(cpu_t=
o->clkevt.irq, IRQ_NOAUTOEN);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D request_irq(cpu_to=
->clkevt.irq, tegra_timer_isr,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TIMER | IRQF_NOBALANCING,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to->clkevt.name, &cpu_to->clkevt);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
_err("%s: cannot setup irq %d for CPU%d\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __func__, cpu_to->clkevt.irq, cpu);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EINVAL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out_irq;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> You should configure the timer in the tegra_timer_setup() function
>>> instead of using this cpu loop.
>>>
>>
>> I think I still need to leave 'irq_of_parse_and_map' and 'request_irq'
>> here. Is that ok?
>=20
> Perhaps you can store the np pointer in the private data structure of
> timer-of and let the timer_of API to retrieve the irq in the cpuhp
> callbacks.
>=20
> irq_of_parse_and_map will be called by timer-of.
>=20
> I'm not sure irq_set_status_flags really operates on the irq because it
> is called after request_irq.
>=20

I did some experiments today. The 'irq_of_parse_and_map', 'request_irq'=20
and 'setup_irq' are not able to run in the atomic section that=20
tegra_timer_setup would be triggered in.

So I think I still need to leave the IRQ configuration code here in the=20
loop. Should I move others to 'tegra_timer_setup' or just keep as the=20
same in this patch?

Thanks,
Joseph
