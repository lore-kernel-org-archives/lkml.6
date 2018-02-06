Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932146AbeBFTtn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:49:43 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39914 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeBFTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:49:40 -0500
X-Google-Smtp-Source: AH8x225U5zU82QOmATJL7g80s38mVWF2qThP4GSYArtqJKpDVY7bKBi20eN+VkLkk8E8+Z+OYiD1ImA0fQthaQCD/sA=
MIME-Version: 1.0
In-Reply-To: <20180206190614.GL9465@builder>
References: <20180125163216.29018-1-rnayak@codeaurora.org> <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org> <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
 <20180206190614.GL9465@builder>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2018 11:49:37 -0800
X-Google-Sender-Auth: SUryFvK3IMydiz_NbEK0KUMWnIU
Message-ID: <CAD=FV=Whxf1VRJ6qx9mioEEkTeS+uJfJKPbOMcGy-Wigh_NORw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 6, 2018 at 11:06 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 06 Feb 10:37 PST 2018, Doug Anderson wrote:
>
>> Hi,
>>
>> On Fri, Jan 26, 2018 at 2:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 01/25, Rajendra Nayak wrote:
>> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> >> new file mode 100644
>> >> index 000000000000..b97f99e6f4b4
>> >> --- /dev/null
>> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> >> @@ -0,0 +1,32 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/*
>> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> >> + */
>> >> +
>> >> +&tlmm {
>> >
>> > I'm not the maintainer, but I find this approach to the pins
>> > really annoying. I have to flip to another file to figure out how
>> > a board has configured the pins. And we may bring in a bunch of
>> > settings that we don't ever use on some board too. Why can't we
>> > put the settings in the board file directly?
>>
>> I'm not so familiar with how things work with Qualcomm, but in general
>> I think putting this in the "board" file is a bad idea.  I'd be OK
>> with putting this directly in the SoC file (though it might get
>> unwieldy?), but not moving things to the board file as was done with
>> v2 of this patch.
>>
>> Said another way: nearly board that uses SDM845 that uses UART2 will
>> have the same definitions for these pins so we shouldn't be
>> duplicating it across every board, right?
>>
>
> We've run into several cases where different boards uses the same
> function but requires board specific electrical configuration.
>
> So what we decided was to keep the pinmux in the soc-file (where e.g.
> the uart definition is) and then extend it with the board specific
> electrical properties (the pinconf), in the board files.
>
> This does come with the complexity of having the pinctrl nodes split in
> two places, but the responsibilities of the two parts is clear and we
> remove the need for all board files to ensure the appropriate pinmux is
> in place.
>
>
> NB. We did discuss adding "sane defaults" for the pinconf in the soc
> dtsi, but we end up spending considerable time debugging issues stemming
> from not having the right pinconf; so better make this explicit and say
> that the board has to specify it's config.

Whoops, saw your responses _after_ I sent my response to v2.  In any
case this makes sense to me then!  On Rockchip boards I've been
involved in we often added "sane defaults", but I can see how that
could be confusing in different ways.  I'm happy with your choice and
it seems like a happy medium.  The sdm845.dtsi file can have the main
definition of the nodes and can thus refer to the nodes.  Then you
just add the extra bit in the board file.

What you propose is not what happened in v2 of the series
<https://patchwork.kernel.org/patch/10194201/> though.  In v2 _both_
the pinconf and the pinmux moved to the board file.  That's wrong.


To make it concrete, you'd have something like this (this has the
wrong bindings from the UART, but folks get the picture hopefully):


In sdm845.dtsi:

    qup_uart2: serial@a84000 {
      compatible = "qcom,geni-console", "qcom,geni-uart";
      reg = <0xa84000 0x4000>;
      reg-names = "se_phys";
      clock-names = "se-clk", "m-ahb", "s-ahb";
      clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>,
         <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
         <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
      pinctrl-names = "default", "sleep";
      pinctrl-0 = <&qup_uart2_default>;
      pinctrl-1 = <&qup_uart2_sleep>;
      interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
      qcom,wrapper-core = <&qup_1>;
      status = "disabled";
    };

    tlmm: pinctrl@3400000 {
      compatible = "qcom,sdm845-pinctrl";
      reg = <0x03400000 0xc00000>;
      interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
      gpio-controller;
      #gpio-cells = <2>;
      interrupt-controller;
      #interrupt-cells = <2>;

      qup_uart2_default: qup_uart2_default {
        pinmux {
          function = "qup9";
          pins = "gpio4", "gpio5";
        };
      };

      qup_uart2_sleep: qup_uart2_sleep {
        pinmux {
          function = "gpio";
          pins = "gpio4", "gpio5";
        };
      };
    };

In sdm845-mtp.dts:

&qup_uart2_default {
  pinconf {
    pins = "gpio4", "gpio5";
    drive-strength = <2>;
    bias-disable;
  };
};

&qup_uart2_sleep {
  pinconf {
    pins = "gpio4", "gpio5";
    drive-strength = <2>;
    bias-disable;
  };
};
