Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeEWIud (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:50:33 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44950 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeEWIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:50:30 -0400
X-Google-Smtp-Source: AB8JxZq2AYuTwDG4b9U4Stu0MnN3AYWv6txfxNTwlK/5u1xdWRdZJ/lE7u+yB0Wfq8aDqZXewssPzMyVPe7NmCX53OE=
MIME-Version: 1.0
In-Reply-To: <20180523083746.f4nkz4uhjwfgw7yz@verge.net.au>
References: <1526995765-29693-1-git-send-email-geert+renesas@glider.be> <20180523083746.f4nkz4uhjwfgw7yz@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 10:50:27 +0200
X-Google-Sender-Auth: zMPhzAkLL1q3nnHkUhviwJAgeHQ
Message-ID: <CAMuHMdV2VwoD3Le=T4-+Ek2E9tL+hmiR0r4cXxG9EH4GXV-uTw@mail.gmail.com>
Subject: Re: [PATCH/RFC] ARM: dts: r8a7791: Move enable-method to CPU nodes
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Wed, May 23, 2018 at 10:37 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, May 22, 2018 at 03:29:25PM +0200, Geert Uytterhoeven wrote:
>> According to Documentation/devicetree/bindings/arm/cpus.txt, the
>> "enable-method" property should be a property of the individual CPU
>> nodes, not of the parent "cpus" node.  However, on R-Car M2-W (and on
>> several other arm32 SoCs), the property is tied to the "cpus" node
>> instead.
>>
>> Secondary CPU bringup and CPU hot (un)plug work regardless, as
>> arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.
>>
>> The cpuidle code does not have such a fallback, so it does not detect
>> the enable-method.  Note that cpuidle does not support the
>> "renesas,apmu" enable-method yet, so for now this does not make any
>> difference.
>
> Is the implication that if we keep the current binding for cpu nodes
> then at some point we will need to update the cpuidle binding?

If we keep the current binding for cpu nodes, we indeed have to update
(common) Documentation/devicetree/bindings/arm/cpus.txt.

In addition, if we want to add renesas,apmu-based cpuidle support later,
we will have to update the common cpuidle code to look in /cpus, too.

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Arm64 and powerpc do not have such a fallback, but SH has, like arm32.
>>
>> This is marked RFC, as the alternative is to update the DT bindings to
>> keep the status quo.
>> ---
>>  arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
>> index d568bd22d6cbd855..b214cb8f52e47109 100644
>> --- a/arch/arm/boot/dts/r8a7791.dtsi
>> +++ b/arch/arm/boot/dts/r8a7791.dtsi
>> @@ -71,7 +71,6 @@
>>       cpus {
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> -             enable-method = "renesas,apmu";
>>
>>               cpu0: cpu@0 {
>>                       device_type = "cpu";
>> @@ -83,6 +82,7 @@
>>                       clock-latency = <300000>; /* 300 us */
>>                       power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
>>                       next-level-cache = <&L2_CA15>;
>> +                     enable-method = "renesas,apmu";
>>
>>                       /* kHz - uV - OPPs unknown yet */
>>                       operating-points = <1500000 1000000>,
>> @@ -101,6 +101,7 @@
>>                       clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
>>                       power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
>>                       next-level-cache = <&L2_CA15>;
>> +                     enable-method = "renesas,apmu";
>>               };
>>
>>               L2_CA15: cache-controller-0 {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
