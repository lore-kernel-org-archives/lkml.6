Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971744AbeEXWBh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:01:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39021 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966688AbeEXWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:01:33 -0400
X-Google-Smtp-Source: AB8JxZprJu6XAIl5BFhUV3gkcfljFumZZNrxKkkfoUNfAZtFGky3EXS4xlmLE8po+5klw2ZRCW8nuA==
MIME-Version: 1.0
In-Reply-To: <20180524085021.qto6266adjvpj6ai@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-7-jernej.skrabec@siol.net> <20180521080759.rgviuva65ijcfm2e@flea>
 <218132669.UY7RKz0VPx@jernej-laptop> <20180524085021.qto6266adjvpj6ai@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 May 2018 15:01:09 -0700
X-Gmail-Original-Message-ID: <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
Message-ID: <CAGb2v65whE-qW++cg+gu_o2O1dDdCWkumQB41nt3Aqa75Wp3dg@mail.gmail.com>
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 1:50 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, May 21, 2018 at 07:27:46PM +0200, Jernej Škrabec wrote:
>> Hi,
>>
>> Dne ponedeljek, 21. maj 2018 ob 10:07:59 CEST je Maxime Ripard napisal(a):
>> > On Sat, May 19, 2018 at 08:31:18PM +0200, Jernej Skrabec wrote:
>> > > If SoC has TCON TOP unit, it has to be configured from TCON, since it
>> > > has all information needed. Additionally, if it is TCON TV, it must also
>> > > enable bus gate inside TCON TOP unit.
>> >
>> > Why?
>>
>> I'll explain my design decision below.
>>
>> >
>> > > Add support for such TCONs.
>> > >
>> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > > ---
>> > >
>> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
>> > >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  8 ++++++++
>> > >  2 files changed, 36 insertions(+)
>> > >
>> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..e0c562ce1c22
>> > > 100644
>> > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>> > >
>> > >           dev_err(dev, "Couldn't get the TCON bus clock\n");
>> > >           return PTR_ERR(tcon->clk);
>> > >
>> > >   }
>> > >
>> > > +
>> > > + if (tcon->quirks->needs_tcon_top && tcon->quirks->has_channel_1) {
>> > > +         tcon->top_clk = devm_clk_get(dev, "tcon-top");
>> > > +         if (IS_ERR(tcon->top_clk)) {
>> > > +                 dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
>> > > +                 return PTR_ERR(tcon->top_clk);
>> > > +         }
>> > > +         clk_prepare_enable(tcon->top_clk);
>> > > + }
>> > > +
>> > >
>> > >   clk_prepare_enable(tcon->clk);
>> > >
>> > >   if (tcon->quirks->has_channel_0) {
>> > >
>> > > @@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>> > >
>> > >  static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
>> > >  {
>> > >
>> > >   clk_disable_unprepare(tcon->clk);
>> > >
>> > > + clk_disable_unprepare(tcon->top_clk);
>> > >
>> > >  }
>> > >
>> > >  static int sun4i_tcon_init_irq(struct device *dev,
>> > >
>> > > @@ -980,6 +991,23 @@ static int sun4i_tcon_bind(struct device *dev, struct
>> > > device *master,>
>> > >   tcon->id = engine->id;
>> > >   tcon->quirks = of_device_get_match_data(dev);
>> > >
>> > > + if (tcon->quirks->needs_tcon_top) {
>> > > +         struct device_node *np;
>> > > +
>> > > +         np = of_parse_phandle(dev->of_node, "allwinner,tcon-top", 0);
>> > > +         if (np) {
>> > > +                 struct platform_device *pdev;
>> > > +
>> > > +                 pdev = of_find_device_by_node(np);
>> > > +                 if (pdev)
>> > > +                         tcon->tcon_top = platform_get_drvdata(pdev);
>> > > +                 of_node_put(np);
>> > > +
>> > > +                 if (!tcon->tcon_top)
>> > > +                         return -EPROBE_DEFER;
>> > > +         }
>> > > + }
>> > > +
>> >
>> > I might have missed it, but I've not seen the bindings additions for
>> > that property. This shouldn't really be done that way anyway, instead
>> > of using a direct phandle, you should be using the of-graph, with the
>> > TCON-top sitting where it belongs in the flow of data.
>>
>> Just to answer to the first question, it did describe it in "[PATCH 07/15] dt-
>> bindings: display: sun4i-drm: Add R40 HDMI pipeline".
>>
>> As why I designed it that way - HW representation could be described that way
>> (ASCII art makes sense when fixed width font is used to view it):
>>
>>                             / LCD0/LVDS0
>>                 / TCON-LCD0
>>                 |           \ MIPI DSI
>> mixer0          |
>>        \        / TCON-LCD1 - LCD1/LVDS1
>>         TCON-TOP
>>        /        \ TCON-TV0 - TVE0/RGB
>> mixer1          |          \
>>                 |           TCON-TOP - HDMI
>>                 |          /
>>                 \ TCON-TV1 - TVE1/RGB
>>
>> This is a bit simplified, since there is also TVE-TOP, which is responsible
>> for sharing 4 DACs between both TVE encoders. You can have two TV outs (PAL/
>> NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It even seems that you
>> can arbitrarly choose which DAC is responsible for which signal, so there is a
>> ton of possible end combinations, but I'm not 100% sure.
>>
>> Even though I wrote TCON-TOP twice, this is same unit in HW. R40 manual
>> suggest more possibilities, although some of them seem wrong, like RGB feeding
>> from LCD TCON. That is confirmed to be wrong when checking BSP code.
>>
>> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0, TVE1 and LCD1 for
>> pin muxing, although I'm not sure why is that needed at all, since according
>> to R40 datasheet, TVE0 and TVE1 pins are dedicated and not on PORT D and PORT
>> H, respectively, as TCON-TOP documentation suggest. However, HSYNC and PSYNC
>> lines might be shared between TVE (when it works in RGB mode) and LCD. But
>> that is just my guess since I'm not really familiar with RGB and LCD
>> interfaces.
>>
>> I'm really not sure what would be the best representation in OF-graph. Can you
>> suggest one?
>
> Rob might disagree on this one, but I don't see anything wrong with
> having loops in the graph. If the TCON-TOP can be both the input and
> output of the TCONs, then so be it, and have it described that way in
> the graph.
>
> The code is already able to filter out nodes that have already been
> added to the list of devices we need to wait for in the component
> framework, so that should work as well.
>
> And we'd need to describe TVE-TOP as well, even though we don't have a
> driver for it yet. That will simplify the backward compatibility later
> on.

I'm getting the feeling that TCON-TOP / TVE-TOP is the glue layer that
binds everything together, and provides signal routing, kind of like
DE-TOP on A64. So the signal mux controls that were originally found
in TCON0 and TVE0 were moved out.

The driver needs to know about that, but the graph about doesn't make
much sense directly. Without looking at the manual, I understand it to
likely be one mux between the mixers and TCONs, and one between the
TCON-TVs and HDMI. Would it make more sense to just have the graph
connections between the muxed components, and remove TCON-TOP from
it, like we had in the past? A phandle could be used to reference
the TCON-TOP for mux controls, in addition to the clocks and resets.

For TVE, we would need something to represent each of the output pins,
so the device tree can actually describe what kind of signal, be it
each component of RGB/YUV or composite video, is wanted on each pin,
if any. This is also needed on the A20 for the Cubietruck, so we can
describe which pins are tied to the VGA connector, and which one does
R, G, or B.


Regards
ChenYu
