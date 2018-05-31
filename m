Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeEaPbx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755369AbeEaPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:31:49 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, Cristian.Birsan@microchip.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
Message-ID: <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Date: Thu, 31 May 2018 08:31:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VFVvDj020085

Quoting Rob Herring (2018-05-31 07:20:57)
> On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
> <codrin.ciubotariu@microchip.com> wrote:
> > On 31.05.2018 03:58, Rob Herring wrote:
> >>
> >> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
> >>>
> >>> The I2S mux clock can be used to select the I2S input clock. The
> >>> available parents are the peripheral and the generated clocks.
> >>>
> >>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>> ---
> >>>   .../devicetree/bindings/clock/at91-clock.txt       | 34
> >>> ++++++++++++++++++++++
> >>>   1 file changed, 34 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> index 51c259a..1c46b3c 100644
> >>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> @@ -90,6 +90,8 @@ Required properties:
> >>>         "atmel,sama5d2-clk-audio-pll-pmc"
> >>>                 at91 audio pll output on AUDIOPLLCLK that feeds the PMC
> >>>                 and can be used by peripheral clock or generic clock
> >>> +       "atmel,sama5d2-clk-i2s-mux":
> >>> +               at91 I2S clock source selection
> >>
> >>
> >> Is this boolean or takes some values. If latter, what are valid values?
> >
> >
> > This is the compatible string of the clock driver.
> 
> Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
> still a plan to fix this?

I'm also interested in a plan.

> >>
> >>> +               compatible = "atmel,sama5d2-clk-i2s-mux";
> >>> +               #address-cells = <1>;
> >>> +               #size-cells = <0>;
> >>
> >>
> >> How do you address this block? My guess is you don't because it is just
> >> part of some other block and you are just creating this node to
> >> instantiate a driver. Just make the node for the actual h/w block a
> >> clock provider and define the clock ids (0 and 1).
> >
> >
> > This block is not addressed, but its children are. The register we access in
> > this driver is not part of other block. It's a SFR register, accessed
> > through syscon and it has nothing to do with the I2S IP (see SAMA5D2 DS,
> > page 1256, fig. 44-1: I2SC Block Diagram) that is the consumer of this
> > clock. Adding a clock-id property in the I2S node would be just like v3 of
> > this series, with the difference that we use clock-id instead of alias id to
> > set the clock parent, which is not how you suggested back then.
> 
> I wasn't suggesting a clock-id property, but a clock specifier (i.e.
> make #clock-cells 1).
> 
> But AT91 clocks are all a mess, so I don't know what to tell you.
> 

If #clock-cells of 1 works then we should go with that. It's still weird
that we need random nodes to add more clks, but I guess that's how it's
going to be for each at91 clk driver until it changes to be one big
provider node.
