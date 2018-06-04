Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeFDPK5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:10:57 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:38745 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750868AbeFDPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:10:55 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Date: Mon, 04 Jun 2018 17:09:56 +0200
Message-ID: <8937075.mEvrCV6laa@jernej-laptop>
In-Reply-To: <20180604115034.kuy35s4ajewapk4m@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net> <CAGb2v667pdjfHXYpBk1ER5sC8vgpcaOFKEbEByWoD1zh9Z0cyg@mail.gmail.com> <20180604115034.kuy35s4ajewapk4m@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 04. junij 2018 ob 13:50:34 CEST je Maxime Ripard napisal(a):
> On Fri, Jun 01, 2018 at 09:19:43AM -0700, Chen-Yu Tsai wrote:
> > On Fri, Jun 1, 2018 at 8:29 AM, Maxime Ripard <maxime.ripard@bootlin.com> 
wrote:
> > > On Thu, May 31, 2018 at 07:54:08PM +0200, Jernej Škrabec wrote:
> > >> Dne četrtek, 31. maj 2018 ob 11:21:33 CEST je Maxime Ripard napisal(a):
> > >> > On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> > >> > > >> > > + if (tcon->quirks->needs_tcon_top) {
> > >> > > >> > > +         struct device_node *np;
> > >> > > >> > > +
> > >> > > >> > > +         np = of_parse_phandle(dev->of_node,
> > >> > > >> > > "allwinner,tcon-top",
> > >> > > >> > > 0);
> > >> > > >> > > +         if (np) {
> > >> > > >> > > +                 struct platform_device *pdev;
> > >> > > >> > > +
> > >> > > >> > > +                 pdev = of_find_device_by_node(np);
> > >> > > >> > > +                 if (pdev)
> > >> > > >> > > +                         tcon->tcon_top =
> > >> > > >> > > platform_get_drvdata(pdev);
> > >> > > >> > > +                 of_node_put(np);
> > >> > > >> > > +
> > >> > > >> > > +                 if (!tcon->tcon_top)
> > >> > > >> > > +                         return -EPROBE_DEFER;
> > >> > > >> > > +         }
> > >> > > >> > > + }
> > >> > > >> > > +
> > >> > > >> > 
> > >> > > >> > I might have missed it, but I've not seen the bindings
> > >> > > >> > additions for
> > >> > > >> > that property. This shouldn't really be done that way anyway,
> > >> > > >> > instead
> > >> > > >> > of using a direct phandle, you should be using the of-graph,
> > >> > > >> > with the
> > >> > > >> > TCON-top sitting where it belongs in the flow of data.
> > >> > > >> 
> > >> > > >> Just to answer to the first question, it did describe it in
> > >> > > >> "[PATCH
> > >> > > >> 07/15] dt- bindings: display: sun4i-drm: Add R40 HDMI pipeline".
> > >> > > >> 
> > >> > > >> As why I designed it that way - HW representation could be
> > >> > > >> described
> > >> > > >> that way> >>
> > >> > > >> 
> > >> > > >> (ASCII art makes sense when fixed width font is used to view 
it):
> > >> > > >>                             / LCD0/LVDS0
> > >> > > >>                 
> > >> > > >>                 / TCON-LCD0
> > >> > > >>                 
> > >> > > >>                 |           \ MIPI DSI
> > >> > > >> 
> > >> > > >> mixer0          |
> > >> > > >> 
> > >> > > >>        \        / TCON-LCD1 - LCD1/LVDS1
> > >> > > >>        
> > >> > > >>         TCON-TOP
> > >> > > >>        
> > >> > > >>        /        \ TCON-TV0 - TVE0/RGB
> > >> > > >> 
> > >> > > >> mixer1          |          \
> > >> > > >> 
> > >> > > >>                 |           TCON-TOP - HDMI
> > >> > > >>                 |          
> > >> > > >>                 |          /
> > >> > > >>                 
> > >> > > >>                 \ TCON-TV1 - TVE1/RGB
> > >> > > >> 
> > >> > > >> This is a bit simplified, since there is also TVE-TOP, which is
> > >> > > >> responsible
> > >> > > >> for sharing 4 DACs between both TVE encoders. You can have two
> > >> > > >> TV outs
> > >> > > >> (PAL/ NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa. It
> > >> > > >> even
> > >> > > >> seems that you can arbitrarly choose which DAC is responsible
> > >> > > >> for
> > >> > > >> which signal, so there is a ton of possible end combinations,
> > >> > > >> but I'm
> > >> > > >> not 100% sure.
> > >> > > >> 
> > >> > > >> Even though I wrote TCON-TOP twice, this is same unit in HW. R40
> > >> > > >> manual
> > >> > > >> suggest more possibilities, although some of them seem wrong,
> > >> > > >> like RGB
> > >> > > >> feeding from LCD TCON. That is confirmed to be wrong when
> > >> > > >> checking BSP
> > >> > > >> code.
> > >> > > >> 
> > >> > > >> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0,
> > >> > > >> TVE1 and
> > >> > > >> LCD1 for pin muxing, although I'm not sure why is that needed at
> > >> > > >> all,
> > >> > > >> since according to R40 datasheet, TVE0 and TVE1 pins are
> > >> > > >> dedicated and
> > >> > > >> not on PORT D and PORT H, respectively, as TCON-TOP
> > >> > > >> documentation
> > >> > > >> suggest. However, HSYNC and PSYNC lines might be shared between
> > >> > > >> TVE
> > >> > > >> (when it works in RGB mode) and LCD. But that is just my guess
> > >> > > >> since
> > >> > > >> I'm not really familiar with RGB and LCD interfaces.
> > >> > > >> 
> > >> > > >> I'm really not sure what would be the best representation in
> > >> > > >> OF-graph.
> > >> > > >> Can you suggest one?
> > >> > > > 
> > >> > > > Rob might disagree on this one, but I don't see anything wrong
> > >> > > > with
> > >> > > > having loops in the graph. If the TCON-TOP can be both the input
> > >> > > > and
> > >> > > > output of the TCONs, then so be it, and have it described that
> > >> > > > way in
> > >> > > > the graph.
> > >> > > > 
> > >> > > > The code is already able to filter out nodes that have already
> > >> > > > been
> > >> > > > added to the list of devices we need to wait for in the component
> > >> > > > framework, so that should work as well.
> > >> > > > 
> > >> > > > And we'd need to describe TVE-TOP as well, even though we don't
> > >> > > > have a
> > >> > > > driver for it yet. That will simplify the backward compatibility
> > >> > > > later
> > >> > > > on.
> > >> > > 
> > >> > > I'm getting the feeling that TCON-TOP / TVE-TOP is the glue layer
> > >> > > that
> > >> > > binds everything together, and provides signal routing, kind of
> > >> > > like
> > >> > > DE-TOP on A64. So the signal mux controls that were originally
> > >> > > found
> > >> > > in TCON0 and TVE0 were moved out.
> > >> > > 
> > >> > > The driver needs to know about that, but the graph about doesn't
> > >> > > make
> > >> > > much sense directly. Without looking at the manual, I understand it
> > >> > > to
> > >> > > likely be one mux between the mixers and TCONs, and one between the
> > >> > > TCON-TVs and HDMI. Would it make more sense to just have the graph
> > >> > > connections between the muxed components, and remove TCON-TOP from
> > >> > > it, like we had in the past? A phandle could be used to reference
> > >> > > the TCON-TOP for mux controls, in addition to the clocks and
> > >> > > resets.
> > >> > > 
> > >> > > For TVE, we would need something to represent each of the output
> > >> > > pins,
> > >> > > so the device tree can actually describe what kind of signal, be it
> > >> > > each component of RGB/YUV or composite video, is wanted on each
> > >> > > pin,
> > >> > > if any. This is also needed on the A20 for the Cubietruck, so we
> > >> > > can
> > >> > > describe which pins are tied to the VGA connector, and which one
> > >> > > does
> > >> > > R, G, or B.
> > >> > 
> > >> > I guess we'll see how the DT maintainers feel about this, but my
> > >> > impression is that the OF graph should model the flow of data between
> > >> > the devices. If there's a mux somewhere, then the data is definitely
> > >> > going through it, and as such it should be part of the graph.
> > >> 
> > >> I concur, but I spent few days thinking how to represent this sanely in
> > >> graph, but I didn't find any good solution. I'll represent here my
> > >> idea and please tell your opinion before I start implementing it.
> > >> 
> > >> First, let me be clear that mixer0 and mixer1 don't have same
> > >> capabilities
> > >> (different number of planes, mixer0 supports writeback, mixer1 does
> > >> not,
> > >> etc.). Thus, it does matter which mixer is connected to which
> > >> TCON/encoder.
> > >> mixer0 is meant to be connected to main display and mixer1 to
> > >> auxiliary. That obviously depends on end system.
> > >> 
> > >> So, TCON TOP has 3 muxes, which have to be represented in graph. Two of
> > >> them are for mixer/TCON relationship (each of them 1 input and 4
> > >> possible outputs) and one for TV TCON/HDMI pair selection (2 possible
> > >> inputs, 1 output).
> > >> 
> > >> According to current practice in sun4i-drm driver, graph has to have
> > >> port 0, representing input and port 1, representing output. This would
> > >> mean that graph looks something like that:
> > >> 
> > >> tcon_top: tcon-top@1c70000 {
> > >> 
> > >>       compatible = "allwinner,sun8i-r40-tcon-top";
> > >>       ...
> > >>       ports {
> > >>       
> > >>               #address-cells = <1>;
> > >>               #size-cells = <0>;
> > >>               
> > >>               tcon_top_in: port@0 {
> > >>               
> > >>                       #address-cells = <1>;
> > >>                       #size-cells = <0>;
> > >>                       reg = <0>;
> > >>                       
> > >>                       tcon_top_in_mixer0: endpoint@0 {
> > >>                       
> > >>                               reg = <0>;
> > >>                               remote-endpoint = <&mixer0_out_tcon_top>;
> > >>                       
> > >>                       };
> > >>                       
> > >>                       tcon_top_in_mixer1: endpoint@1 {
> > >>                       
> > >>                               reg = <1>;
> > >>                               remote-endpoint = <&mixer1_out_tcon_top>;
> > >>                       
> > >>                       };
> > >>                       
> > >>                       tcon_top_in_tcon_tv: endpoint@2 {
> > >>                       
> > >>                               reg = <2>;
> > >>                               // here is HDMI input connection, part of
> > >>                               board DTS
> > >>                               remote-endpoint = <board specific phandle
> > >>                               to TV TCON output>;
> > >>                       
> > >>                       };
> > >>               
> > >>               };
> > >>               
> > >>               tcon_top_out: port@1 {
> > >>               
> > >>                       #address-cells = <1>;
> > >>                       #size-cells = <0>;
> > >>                       reg = <1>;
> > >>                       
> > >>                       tcon_top_out_tcon0: endpoint@0 {
> > >>                       
> > >>                               reg = <0>;
> > >>                               // here is mixer0 output connection, part
> > >>                               of board DTS
> > >>                               remote-endpoint = <board specific phandle
> > >>                               to TCON>;
> > >>                       
> > >>                       };
> > >>                       
> > >>                       tcon_top_out_tcon1: endpoint@1 {
> > >>                       
> > >>                               reg = <1>;
> > >>                               // here is mixer1 output connection, part
> > >>                               of board DTS
> > >>                               remote-endpoint = <board specific phandle
> > >>                               to TCON>;
> > >>                       
> > >>                       };
> > >>                       
> > >>                       tcon_top_out_hdmi: endpoint@2 {
> > >>                       
> > >>                               reg = <2>;
> > >>                               remote-endpoint = <&hdmi_in_tcon_top>;
> > >>                       
> > >>                       };
> > >>               
> > >>               };
> > >>       
> > >>       };
> > >> 
> > >> };
> > > 
> > > IIRC, each port is supposed to be one route for the data, so we would
> > > have multiple ports, one for the mixers in input and for the tcon in
> > > output, and one for the TCON in input and for the HDMI/TV in
> > > output. Rob might correct me here.

Ok, that seems more clean approach. I'll have to extend graph traversing 
algorithm in sun4i_drv.c, but that's no problem.

Just to be clear, you have in mind 3 pairs of ports (0/1 for mixer0 mux, 2/3 
for mixer1 and 4/5 for HDMI input), right? That way each mux is represented 
with one pair of ports, even numbered for input and odd numbered for output.

> > > 
> > >> tcon_tv0: lcd-controller@1c73000 {
> > >> 
> > >>       compatible = "allwinner,sun8i-r40-tcon-tv-0";
> > >>       ...
> > >>       ports {
> > >>       
> > >>               #address-cells = <1>;
> > >>               #size-cells = <0>;
> > >>               
> > >>               tcon_tv0_in: port@0 {
> > >>               
> > >>                       reg = <0>;
> > >>                       
> > >>                       tcon_tv0_in_tcon_top: endpoint {
> > >>                       
> > >>                               // endpoint depends on board, part of
> > >>                               board DTS
> > >>                               remote-endpoint = <phandle to one of
> > >>                               tcon_top_out_tcon>;
> > > 
> > > Just curious, what would be there?

Either phandle to tcon_top_out_tcon0 or tcon_top_out_tcon1.

> > > 
> > >>                       };
> > >>               
> > >>               };
> > >>               
> > >>               tcon_tv0_out: port@1 {
> > >>               
> > >>                       #address-cells = <1>;
> > >>                       #size-cells = <0>;
> > >>                       reg = <1>;
> > >>                       
> > >>                       // endpoints to TV TOP and TCON TOP HDMI input
> > >>                       ...
> > >>               
> > >>               };
> > >>       
> > >>       };
> > >> 
> > >> };
> > >> 
> > >> tcon_tv1: lcd-controller@1c74000 {
> > >> 
> > >>       compatible = "allwinner,sun8i-r40-tcon-tv-1";
> > >>       ...
> > >>       ports {
> > >>       
> > >>               #address-cells = <1>;
> > >>               #size-cells = <0>;
> > >>               
> > >>               tcon_tv1_in: port@0 {
> > >>               
> > >>                       reg = <0>;
> > >>                       
> > >>                       tcon_tv1_in_tcon_top: endpoint {
> > >>                       
> > >>                               // endpoint depends on board, part of
> > >>                               board DTS
> > >>                               remote-endpoint = <phandle to one of
> > >>                               tcon_top_out_tcon>;
> > >>                       
> > >>                       };
> > >>               
> > >>               };
> > >>               
> > >>               tcon_tv1_out: port@1 {
> > >>               
> > >>                       #address-cells = <1>;
> > >>                       #size-cells = <0>;
> > >>                       reg = <1>;
> > >>                       
> > >>                       // endpoints to TV TOP and TCON TOP HDMI input
> > >>                       ...
> > >>               
> > >>               };
> > >>       
> > >>       };
> > >> 
> > >> };
> > >> 
> > >> tcon_lcd0 and tcon_lcd1 would have similar connections, except that for
> > >> outputs would be LCD or LVDS panels or MIPI DSI encoder.
> > >> 
> > >> Please note that each TCON (there are 4 of them) would need to have
> > >> unique
> > >> compatible and have HW index stored in quirks data. It would be used by
> > >> TCON TOP driver for configuring muxes.
> > > 
> > > Can't we use the port/endpoint ID instead? If the mux is the only
> > > thing that changes, the compatible has no reason to. It's the same IP,
> > > and the only thing that changes is something that is not part of that
> > > IP.
> > 
> > I agree. Endpoint IDs should provide that information. I'm still not
> > sure How to encode multiple in/out mux groups in a device node though.
> 
> I guess we can do that through different ports?

Ok, I'll try to do something with "reg" property.

Best regards,
Jernej
