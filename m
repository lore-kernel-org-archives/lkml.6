Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbeCHW0W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeCHW0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:26:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D986F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELv3LhlbeSRdOo+YYfCVxkRdrYUEIXPKKE53ZZp8wghlcyNvFKBRD9NEY9UUYTXz+K9J8O/CQ8ptVHFC8sW2fSc=
MIME-Version: 1.0
In-Reply-To: <20180308160249.GI5799@atomide.com>
References: <20180307182143.58383-1-tony@atomide.com> <20180308024806.vombsjullqw5gpmz@rob-hp-laptop>
 <20180308160249.GI5799@atomide.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Mar 2018 16:25:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK4gLh17H+=5qPHB6Zd+s2Nn9mYQHbRsP=7DLFMTcstig@mail.gmail.com>
Message-ID: <CAL_JsqK4gLh17H+=5qPHB6Zd+s2Nn9mYQHbRsP=7DLFMTcstig@mail.gmail.com>
Subject: Re: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
To: Tony Lindgren <tony@atomide.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Rob Herring <robh@kernel.org> [180308 02:49]:
>> On Wed, Mar 07, 2018 at 10:21:43AM -0800, Tony Lindgren wrote:
>> > +TI RSTCTRL Reset Controller
>> > +
>> > +Required properties:
>> > +- compatible : "ti,rstctrl"
>> > +- reg : Should contain 1 register ranges(address and length)
>> > +- #reset-cells: 1
>> > +
>> > +Example:
>> > +   prm_gfx: prm@1100 {
>> > +           compatible = "simple-bus";
>>
>> What's a PRM?
>
> PRM is power and reset manager. There is one instance per
> interconnect instance (clockdomain). PRM shows the status of
> the connected devices in the interconnect, such as device
> context lost and hardware wake-up dependencies. It also
> contains a single reset controller register for external
> accelerators such as DSP. The reset controller instance then
> has 1 - 3 bits for external accelerator sub device resets.
> Then there is a reset status register that shows the reset
> reason for the external accelerator.
>
>> > +           #address-cells = <1>;
>> > +           #size-cells = <1>;
>> > +           ranges = <0 0x1100 0x100>;
>>
>> And what else is in this range?
>
> In PRM, there are also registers for each interconnect device
> context lost and wake-up dependencies. We don't have a driver
> for that yet, it's handled by the SoC init code currently.

Regardless of having/needing a driver, you should take a stab at doing
the binding at least. It doesn't make sense to do the binding of the
child without doing the parent.

> Unlike the binding for reset controller, the binding for
> wake-up dependencies and context lost should look similar
> binding to the clkctrl clock binding we have. That's because
> there are tons of those registers.
>
>> > +
>> > +           gfx_rstctrl: rstctrl@4 {
>> > +                   compatible = "ti,rstctrl";
>> > +                   reg = <0x4 0x4>;
>>
>> Anytime I see a single register in DT I worry about scaling. How many of
>> these in an SoC?
>
> There are not many instances of the reset controller. There
> is one register per interconnect instance for external
> accelerators, so about 3 - 10 reset controller registers
> per SoC.

Okay, seems a reasonable number.

However, couldn't you just have PRM node(s) and have that register as
a simple reset driver (along with anything else it handles).

Rob
