Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeDUIh4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:37:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59660 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeDUIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:37:51 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: jacopo mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
Date: Sat, 21 Apr 2018 11:38:00 +0300
Message-ID: <1549346.R82tLOL7eo@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <840625e9-42ff-49b7-605a-202b4d980beb@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se> <20180420113859.GL4235@w540> <840625e9-42ff-49b7-605a-202b4d980beb@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Friday, 20 April 2018 15:55:50 EEST Peter Rosin wrote:
> On 2018-04-20 13:38, jacopo mondi wrote:
> > On Fri, Apr 20, 2018 at 01:05:21PM +0200, Peter Rosin wrote:
> >> On 2018-04-20 12:18, Laurent Pinchart wrote:
> >>> On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
> >>>> Hi Peter,
> >>>> 
> >>>> I've been a bit a pain in the arse for you recently, but please
> >>>> bear with me a bit more, and sorry for jumping late on the band wagon.
> >>>> 
> >>>> On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
> >>>>> Hi!
> >>>>> 
> >>>>> I naively thought that since there was support for both nxp,tda19988
> >>>>> (in the tda998x driver) and the atmel-hlcdc, things would be a smooth
> >>>>> ride. But it wasn't, so I started looking around and realized I had to
> >>>>> fix things.
> >>>>> 
> >>>>> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
> >>>>> component, but now in v3 I fix things by making the tda998x driver
> >>>>> a bridge instead. This was after a suggestion from Boris Brezillion
> >> 
> >> That should be Brezillon, sorry for being sloppy with the spelling.
> >> 
> >>>>> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
> >>>>> after comparing what was needed, I too find the bridge approach
> >>>>> better.
> >>>>> 
> >>>>> In addition to the above, our PCB interface between the SAMA5D3 and
> >>>>> the HDMI encoder is only using 16 bits, and this has to be described
> >>>>> somewhere, or the atmel-hlcdc driver have no chance of selecting the
> >>>>> correct output mode. Since I have similar problems with a ds90c185
> >>>>> lvds encoder I added patches to override the atmel-hlcdc output format
> >>>>> via DT properties compatible with the media video-interface binding
> >>>>> and things start to play together.
> >>>>> 
> >>>>> Since this series superseeds the bridge series [1], I have included
> >>>>> the leftover bindings patch for the ti,ds90c185 here.
> >>>> 
> >>>> I feel like this series would look better if it would make use of the
> >>>> proposed bridge media bus format support I have recently sent out [1]
> >>>> (and which was not there when you first sent v1).
> >>>> 
> >>>> I understand your fundamental problem here is that the bus format
> >>>> that should be reported by your bridge is different from the ones
> >>>> actually supported by the TDA19988 chip, as the wirings ground some
> >>>> of the input pins.
> >>>> 
> >>>> Although this is defintely something that could be described in the
> >>>> bridge's own OF node with the 'bus_width' property, and what I would
> >>>> do, now that you have made a bridge out from the tda19988 driver, is:
> >>>> 
> >>>> 1) Set the bridge accepted input bus_format parsing its pin
> >>>> configuration, or default it if that's not implemented yet.
> >>>> This will likely be rgb888. You can do that using the trivial
> >>>> support for bridge input image formats implemented by my series.
> >>>> 2) Specify in the bridge endpoint a 'bus_width' of <16>
> >>>> 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
> >>>> and parse the remote endpoint property 'bus_width' and get the <16>
> >>>> value back.
> >>> 
> >>> Parsing properties of remote nodes should be avoided as much as
> >>> possible, as they need to be interpreted in the context of the DT
> >>> bindings related to the compatible string applicable to that node. I'd
> >>> rather have the bus_width property in the local endpoint node.
> >> 
> >> In addition to that, my view of this binding
> >> 
> >> 	endpoint {
> >> 		bus-type = <0>;
> > 
> > bus-type is used by v4l2_fwnode helpers to decide which type of bus
> > they're dealing with iirc. Here it seems to me it has no added
> > value, also because in your bindings description "it shall be 0" and
> > it is not parsed anywhere in you code, but no big deal....
> 
> bus-type is indeed parsed and verified to be zero which means auto-detect
> according to the video-interfaces binding. An auto-detect bus-type with
> a given bus-width means a parallel interface IIUC.

I believe you could leave it out though. Your display controller only supports 
parallel buses, so there's no need to specify the bus type explicitly.

> From patch 3/7:
> 
> 	if (of_property_read_u32(node, "bus-type", &bus_type))
> 		return 0;
> 	if (bus_type != 0)
> 		return -EINVAL;
> 
> >> 		bus-widht = <16>;
> >> 	};
> >> 
> >> is that it always means rgb565. See further below.
> >> 
> >>>> 4) Set the correct format in the atmel hlcd driver to accommodate a
> >>>> bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
> >>>> or are there other possible combinations I am missing?)
> >>>> 
> >>>> I would consider this better mostly because in this series you are
> >>>> creating a semantic for the whole DRM subsystem on the 'bus_width'
> >>>> property, where numerical values as '12', '16' etc are arbitrary tied
> >>>> to the selection of a media bus format. At least you should use a
> >>>> common set of defines [1] between the device tree and the driver,
> >>>> but this looks anyway fragile imho.
> >>> 
> >>> This I agree with though. Combining the remote bus format with the local
> >>> bus width should fix the problem without having to parse remote
> >>> properties.
> >> 
> >> My thinking was that the binding with bus-type = <0> and bus-width =
> >> <bpp> would mean a parallel bus (type 0 means auto-detect and with a bus-
> >> width that auto-detect means a parallel bus) and the most natural/common
> >> interpretation of that bus-width. For bus widths of 12, 16, 18, 24, 30
> >> etc I think that would be rgb444, rgb565, rgb666, rgb888, rgb101010 (or,
> >> I'm first so I get to define the default). If you have some other
> >> interpretation of a bus with that width, you'd need to extend the
> >> video-interface binding with some way of saying what you need, perhaps
> >> using some kind of data mapping or something to say e.g. bgr666. And
> >> you'd need some kind of indicator if you have YUV signals instead of
> >> RGB, and LVDS isn't a completely parallel bus, so you'd need something
> >> for that. Etc.
> > 
> > The fundamental issue here is that you're tying the bus with to an
> > image format. Why <16> can't be, say, MEDIA_BUS_FMT_YVYU8_1X16? it
> > spans to 16 bits, doesn't it? And I'm sorry but the 'I'm first so I
> > get to define defaults' argument doesn't apply here.
> 
> I never said that <16> could not be something YUV. I said that <16> without
> any further information is RGB. But you are right, the fundamental issue
> is that I want to specify the full format in the endpoint node, while you
> do not for some reason I don't understand. And maybe saying that "<16>
> without more info is RGB" is too presumptuous, but then I think that the
> right fix is adding something clearly indicating RGB is the way to go, so
> that there is a way for endpoints to specify RGB565 (or whatever is needed).

I think that would lack genericity though. I could easily imagine a setup 
similar to yours where the bridge can accept different types of parallel 
formats (RGB, BGR, YUV, ...). While the bus width is a property of the PCB 
routing and is thus fixed, the format wouldn't be a property of the platform 
but would be dynamic. I believe that combining the bus-width DT property that 
carries static platform information with the dynamic format reported by the 
bridge (through the API proposed by Jacopo) would then be a more generic 
approach.

You don't have to depend on Jacopo's patch series though, I would be totally 
fine with assuming that a 16-bit width means RGB565 in the atmel-hlcdc driver. 
What I'm not comfortable with is hardcoding that assumption in the helper 
defined in patch 3/7. I would thus propose moving that code to the atmel-hlcdc 
driver for now, and creating a generic helper that uses both bus-width and the 
format queried from the bridge when Jacopo's series makes it to mainline. 
Would that be an acceptable approach for you ?

> > So, it is my opinion you need to expose an image format somewhere. And
> > it is my opinion again, which can be very wrong ofc, that this place
> > is the bridge driver.
> 
> I don't see why the input side is better than the output side when it
> comes to specifying these details? The input side is as likely to have
> different options as the output side.

DRM/KMS is built upon a sink to source model, where userspace specifies the 
format on the connector at the output of a pipeline, and the formats along the 
chain of bridges are then computed automatically. That's why we usually query 
formats supported by sinks and configure sources accordingly.

> > You need to adjust the output to accommodate wirings? You can use the
> > bus_width on the hlcd side, as Laurent suggested, but the bus width
> > does not tie to any image format at all, even more if you're making
> > that decision in a drm-wide function.
> > 
> >> Because the word from Rob was that there should be one common binding
> >> that describes video interfaces. I started an implementation that
> >> interprets that binding in a drm context in
> >> [PATCH 3/7] drm: of: introduce drm_of_media_bus_fmt
> > 
> > As usual, one should try to reuse as much as possible of the existing
> > bindings. That's a totally different thing compared to assign to a bus
> > width property an associated image format for the whole DRM subsystem
> > 
> > ot: those properties should be moved outside of
> > media/video_interfaces.txt sooner or later, to a more generic place...
> > 
> >> With that view, any input format specification of the bridge is not
> >> helpful for me since what the bridge specifies (without help) is going to
> >> be wrong
> > 
> > No it's not useless. I can have an encoder that can provide both YUV
> > and RGB formats. If your bridge accepts RGB I want to know that, and
> > the bus_width is unrelated imho.
> 
> I didn't say useless *period*, I said not helpful *for me*. What I mean is
> that since I have an encoder that can only output RGB formats, asking the
> bridge if it expects RGB is rather useless. It adds nothing whatsoever.
> 
> >> anyway. End result, I need to specify the format manually on either the
> >> bridge or the atmel-hlcdc side, and I happen to think that the correct
> >> side
> >> is with the atmel-hlcdc, because that is where my issue originates. In
> >> short, the "drm: bridge: Add support for static image formats" series is
> >> unrelated as far as I can tell.
> > 
> > I may be biased on this, so I let other to judge and provide more
> > suggestions.

-- 
Regards,

Laurent Pinchart
