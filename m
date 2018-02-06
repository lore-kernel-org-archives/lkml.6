Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeBFSpu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:45:50 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45361 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeBFSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:45:44 -0500
X-Google-Smtp-Source: AH8x227/fWD6mMF0nDMFijQ7eGX7E8skwsxTrJxMqXP+XCl27NDvYyVZJ17pQQUZzSQabKKjYC8Tq7y/D3Lf4DfT6NE=
MIME-Version: 1.0
In-Reply-To: <4aa2ab13-7890-6904-86b3-e2dbcb6d6daa@lechnology.com>
References: <20180205155222.22189-1-brgl@bgdev.pl> <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
 <CAMpxmJUDbwkcJt_kx9GX+qY10xiGAp-j3+kXM-q3WP1VGwr0UQ@mail.gmail.com>
 <54dbdb98-e0e4-c8c9-fec4-2f050745d9be@ti.com> <794024f3-f87a-58ed-2722-a4a2d09df3ce@lechnology.com>
 <4aa2ab13-7890-6904-86b3-e2dbcb6d6daa@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 6 Feb 2018 19:45:42 +0100
Message-ID: <CAMRc=Mcf0aEQvieNaZ3cMHJTE23Gf1jUNf0=vuO9-PA=9ObDvQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 19:25 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/06/2018 12:16 PM, David Lechner wrote:
>>
>> On 02/06/2018 07:51 AM, Sekhar Nori wrote:
>>>
>>> On Tuesday 06 February 2018 06:38 PM, Bartosz Golaszewski wrote:
>>>>
>>>> 2018-02-06 12:07 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>>>>>
>>>>> On Monday 05 February 2018 09:22 PM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>
>>>>>> Make nand work with the common clock framework by specifying which
>>>>>> clock should be used and what name to look up.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>> ---
>>>>>>   arch/arm/boot/dts/da850-evm.dts | 3 +++
>>>>>>   1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/da850-evm.dts
>>>>>> b/arch/arm/boot/dts/da850-evm.dts
>>>>>> index a86a8a1816f2..2602ad8e99ee 100644
>>>>>> --- a/arch/arm/boot/dts/da850-evm.dts
>>>>>> +++ b/arch/arm/boot/dts/da850-evm.dts
>>>>>> @@ -296,6 +296,9 @@
>>>>>>                        reg = <0 0x02000000 0x02000000
>>>>>>                               1 0x00000000 0x00008000>;
>>>>>>
>>>>>> +                     clocks = <&psc0 3>;
>>>>>> +                     clock-names = "aemif";
>>>>>
>>>>>
>>>>> Looks like this is being added only to satisfy the devm_clk_get() call
>>>>> in nand_davinci_probe() which I think is superfluous since we also
>>>>> enable the same clock in aemif_probe().
>>>>>
>>>>> Perhaps the better solution is to drip the clk code in
>>>>> drivers/mtd/nand/davinci_nand.c and shift legacy code to start using
>>>>> drivers/memory/aemif.c as well? This way we can also drop
>>>>> arch/arm/mach-davinci/aemif.c
>>>>>
>>>>> Thanks,
>>>>> Sekhar
>>>>
>>>>
>>>> Yes, this sounds good, but I think we should leave it for later as an
>>>> additional improvement, once everything else is in place. I think
>>>> these patches should be applied together with David's series in order
>>>> to not break the support on davinci boards and the aemif work would go
>>>> in later as a follow-up. How about that?
>>>
>>>
>>> No, I dont think we should add temporary hacks to DT to work around
>>> driver issues (I do think its a hack since the clock belongs to aemif
>>> module not NAND flash).
>>>
>>> An easier driver hack might be to not treat devm_clk_get() failure in
>>> davinci_nand.c as catastrophic. It will safely fail in DT case and we
>>> should get the clock in legacy boot case.
>>>
>>> I think we are looking at a driver update dependency anyway.
>>
>>
>> It looks like keystone.dtsi is using the clock-ranges property in the
>> aemif node to pass the clock to child nodes. Could we not do the same
>> in da850.dtsi?
>
>
> Bartosz, please try this instead of your patch.
>
> FYI, this is just following the existing memory-controllers/ti-aemif.txt
> device tree bindings, so not a "hack".
>
> ---
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 3a1f2ce..ff9d807 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -796,6 +796,8 @@
>                 ranges = <0 0 0x60000000 0x08000000
>                           1 0 0x68000000 0x00008000>;
>                 clocks = <&psc0 3>;
> +               clock-names = "aemif";
> +               clock-ranges;
>                 status = "disabled";
>         };
>         memctrl: memory-controller@b0000000 {
> ---

Yes, this works. Sekhar: can we include it in David's series, while
still keeping the plan to move legacy boards to using the aemif
driver?

Best regards,
Bartosz
