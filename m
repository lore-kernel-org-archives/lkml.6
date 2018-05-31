Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeEaP5V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755482AbeEaP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:57:15 -0400
X-Google-Smtp-Source: ADUXVKLqf2P9pibsRhQ1x6xlob88Qdz5n20YNZLqdekFYNTvRid1c62Fnbh1bnVmrxnmhmdOtVEOUvU0xh2SE96/VbE=
MIME-Version: 1.0
In-Reply-To: <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop> <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com> <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 May 2018 10:56:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
Message-ID: <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
To: Stephen Boyd <sboyd@kernel.org>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, Cristian.Birsan@microchip.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:31 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Rob Herring (2018-05-31 07:20:57)
>> On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
>> <codrin.ciubotariu@microchip.com> wrote:
>> > On 31.05.2018 03:58, Rob Herring wrote:
>> >>
>> >> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
>> >>>
>> >>> The I2S mux clock can be used to select the I2S input clock. The
>> >>> available parents are the peripheral and the generated clocks.
>> >>>
>> >>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> >>> ---
>> >>>   .../devicetree/bindings/clock/at91-clock.txt       | 34
>> >>> ++++++++++++++++++++++
>> >>>   1 file changed, 34 insertions(+)
>> >>>
>> >>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
>> >>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
>> >>> index 51c259a..1c46b3c 100644
>> >>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
>> >>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
>> >>> @@ -90,6 +90,8 @@ Required properties:
>> >>>         "atmel,sama5d2-clk-audio-pll-pmc"
>> >>>                 at91 audio pll output on AUDIOPLLCLK that feeds the PMC
>> >>>                 and can be used by peripheral clock or generic clock
>> >>> +       "atmel,sama5d2-clk-i2s-mux":
>> >>> +               at91 I2S clock source selection
>> >>
>> >>
>> >> Is this boolean or takes some values. If latter, what are valid values?
>> >
>> >
>> > This is the compatible string of the clock driver.
>>
>> Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
>> still a plan to fix this?
>
> I'm also interested in a plan.
>
>> >>
>> >>> +               compatible = "atmel,sama5d2-clk-i2s-mux";
>> >>> +               #address-cells = <1>;
>> >>> +               #size-cells = <0>;
>> >>
>> >>
>> >> How do you address this block? My guess is you don't because it is just
>> >> part of some other block and you are just creating this node to
>> >> instantiate a driver. Just make the node for the actual h/w block a
>> >> clock provider and define the clock ids (0 and 1).
>> >
>> >
>> > This block is not addressed, but its children are. The register we access in
>> > this driver is not part of other block. It's a SFR register, accessed
>> > through syscon and it has nothing to do with the I2S IP (see SAMA5D2 DS,
>> > page 1256, fig. 44-1: I2SC Block Diagram) that is the consumer of this
>> > clock. Adding a clock-id property in the I2S node would be just like v3 of
>> > this series, with the difference that we use clock-id instead of alias id to
>> > set the clock parent, which is not how you suggested back then.
>>
>> I wasn't suggesting a clock-id property, but a clock specifier (i.e.
>> make #clock-cells 1).
>>
>> But AT91 clocks are all a mess, so I don't know what to tell you.
>>
>
> If #clock-cells of 1 works then we should go with that. It's still weird
> that we need random nodes to add more clks, but I guess that's how it's
> going to be for each at91 clk driver until it changes to be one big
> provider node.

Seems to me that clock additions could use a new binding and we start
with a new driver that handles these few clocks initially. But I
haven't looked whether both can coexist.

Rob
