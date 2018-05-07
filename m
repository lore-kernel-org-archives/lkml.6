Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeEGXfR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:35:17 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:38893 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeEGXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:35:15 -0400
X-Google-Smtp-Source: AB8JxZriHqDInfUgQwbTfz6GoRP0HB+hPomaYsd8JeDROH65do6KIs+ybrGKd2DZx9kS71+eQZ7KIg==
Date: Mon, 7 May 2018 16:35:11 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: Add msm8998 SoC and MTP board support
Message-ID: <20180507233511.GC14924@minitux>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
 <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152573399648.138124.10341359049104453178@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 May 15:59 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-04-27 22:42:47)
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > new file mode 100644
> > index 000000000000..d6665e4f801f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > +
> > +/ {
> > +       model = "Qualcomm Technologies, Inc. MSM 8998";
> > +
> > +       interrupt-parent = <&intc>;
> > +
> > +       qcom,msm-id = <292 0x0>;
> 
> No update to dtbtool?
> 

This allows me to concatenate the dtb to the Image.gz and boot the
device. From my scripts I see that I tried to use dtbTool before
reverting to this...

[..]
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&CPU0>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU1>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU2>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU3>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
> > +                               core0 {
> > +                                       cpu = <&CPU4>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU5>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU6>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU7>;
> > +                               };
> > +                       };
> > +               };
> 
> I still wonder if this is accurate, but OK.
> 

Afaict it matches downstream, not sure if I'm missing something?

[..]
> > +       intc: interrupt-controller@17a00000 {
> > +               compatible = "arm,gic-v3";
> > +               reg = <0x17a00000 0x10000>,       /* GICD */
> > +                     <0x17b00000 0x100000>;      /* GICR * 8 */
> > +               #interrupt-cells = <3>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +               interrupt-controller;
> > +               #redistributor-regions = <1>;
> > +               redistributor-stride = <0x0 0x20000>;
> 
> Is this needed? The redistributor stuff can be left out if there's only
> one right?
> 

#redistributor-regions is listed as optional if there's more than 1, the
stride is still needed.

Afaict the stride still needs to be specified, as it's different from
the default 64kb.

> > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       blsp2_uart1: serial@c1b0000 {
> 
> Clk name says uart2 though?
> 

That's because it's the wrong clock. Thanks!

> > +               compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> > +               reg = <0xc1b0000 0x1000>;
> > +               interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
> > +                        <&gcc GCC_BLSP2_AHB_CLK>;
> > +               clock-names = "core", "iface";
> > +               status = "disabled";
> > +       };

Regards,
Bjorn
