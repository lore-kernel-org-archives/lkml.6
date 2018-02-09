Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBIAHs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:07:48 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36747 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBIAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:07:46 -0500
X-Google-Smtp-Source: AH8x22669fsB8ne0N/J7W2KglbTW1+Nlbse009uwXeYlPXSvd2Scq8oe9Lwwlo7nir/qHrOIRHJgciQFdl4s4Yat4NY=
MIME-Version: 1.0
In-Reply-To: <CAHb3i=uvj_KS4tZ_qZjQdMZ2CCg9_+11FbmvmF4D5DFGtaAW=g@mail.gmail.com>
References: <1517818975-11427-1-git-send-email-tmaimon77@gmail.com>
 <1517818975-11427-3-git-send-email-tmaimon77@gmail.com> <CAFd5g445Ae-uBO52sn1WH67tMgc0n_sbi6cS-SuKLhR__D98kg@mail.gmail.com>
 <CAHb3i=un-LjnV+DWBMkEcDKNFyEi63wh0RR0dHWsHpv2K9erTw@mail.gmail.com> <CAHb3i=uvj_KS4tZ_qZjQdMZ2CCg9_+11FbmvmF4D5DFGtaAW=g@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 8 Feb 2018 16:07:44 -0800
Message-ID: <CAFd5g44vTyOciaT5+YcVOdxd0=7sxWb3r+gO6_DFv3bmS=EL-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] clk: npcm: add NPCM7xx clock driver
To: Tali Perry <tali.perry1@gmail.com>
Cc: =?UTF-8?Q?=E2=80=8B_Tomer_Maimon?= <tmaimon77@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>> +
>> +       /* Define fixed clocks.
>> +        * Notice: the following clocks are fixed value on NPCM7XX and should
>> +        * not be changed.
>> +        * therefor they are not exposed to the dev tree .
>
> I am not convinced. The top level .dtsi is usually SoC specific.
>
> - CLKREF should be fixed on 25MHz. I didn't want to put it in DT since
> it might appear as something that is changeable.
>  on npcm750 all clocks are set in ROM +BB (several possible settings)
> , so this entire driver is only used for reading the current clock
> settings. All clocks are read only and derived from CLKREF. CLKREF is
> fixed so no point in putting it in DT and exposing it outside of this
> driver.

I understand your rationale, but the *.dtsi is typically used to describe the
SoC, things that cannot change. For example, consider
arch/arm/boot/dts/nuvoton-npcm750.dtsi, it describes the CPU cores, cache
hierarchy, peripherals and what busses they reside on, memory layout, etc. None
of these things are configurable; the *.dtsi just describes the SoC. Typically,
a *.dts is made for a particular board and imports a *.dtsi and does some
configuration, but it is not supposed to override things like what I listed
above (amoung other things).

There are several reasons that you put this information that cannot change in a
*.dtsi. For one it is a convenient, all in one place description of the SoC that
serves as a form of documentation. But more importantly, if you were to create a
variation of the 750 with a different number of cores, a different memory
layout, a different reference clock, etc, you could potentiallly use the same
drivers for both SoCs, and you would only have to write a new *.dtsi. I know you
may have no intention to do this, but many other CPU vendors do. And for this
reason, this is how drivers are expected to be written.

I hope this makes sense.

>
>> +        */
>> +       pr_debug("\tclk register fixed clocks\n");
>> +       hw = clk_hw_register_fixed_rate(NULL, NPCM7XX_CLK_S_REFCLK,
>> +               NULL, 0, 25000000);
>> +       hw = clk_hw_register_fixed_rate(NULL, NPCM7XX_CLK_S_SYSBYPCK,
>> +               NULL, 0, 800000000); // rarely used. mostly testing. TBD: remove
>> +       hw = clk_hw_register_fixed_rate(NULL, NPCM7XX_CLK_S_MCBYPCK,
>> +               NULL, 0, 800000000); // rarely used.  mostly testing. TBD:remove
>> +
>> +
<snip>
