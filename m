Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbeDTLjJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:39:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38529 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbeDTLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:39:07 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 20 Apr 2018 13:38:59 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Peter Rosin <peda@axentia.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20180420113859.GL4235@w540>
References: <20180419162751.25223-1-peda@axentia.se>
 <20180420085235.GI4235@w540>
 <6354350.l8DgUyNhLT@avalon>
 <7f709cea-e1f4-2204-7320-5a1075d721d1@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <7f709cea-e1f4-2204-7320-5a1075d721d1@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,

On Fri, Apr 20, 2018 at 01:05:21PM +0200, Peter Rosin wrote:
> On 2018-04-20 12:18, Laurent Pinchart wrote:
> > Hello,
> >
> > On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
> >> Hi Peter,
> >>     I've been a bit a pain in the arse for you recently, but please
> >> bear with me a bit more, and sorry for jumping late on the band wagon.
> >>
> >> On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
> >>> Hi!
> >>>
> >>> I naively thought that since there was support for both nxp,tda19988 (in
> >>> the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
> >>> But it wasn't, so I started looking around and realized I had to fix
> >>> things.
> >>>
> >>> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
> >>> component, but now in v3 I fix things by making the tda998x driver
> >>> a bridge instead. This was after a suggestion from Boris Brezillion
>
> That should be Brezillon, sorry for being sloppy with the spelling.
>
> >>> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
> >>> after comparing what was needed, I too find the bridge approach better.
> >>>
> >>> In addition to the above, our PCB interface between the SAMA5D3 and the
> >>> HDMI encoder is only using 16 bits, and this has to be described
> >>> somewhere, or the atmel-hlcdc driver have no chance of selecting the
> >>> correct output mode. Since I have similar problems with a ds90c185 lvds
> >>> encoder I added patches to override the atmel-hlcdc output format via
> >>> DT properties compatible with the media video-interface binding and
> >>> things start to play together.
> >>>
> >>> Since this series superseeds the bridge series [1], I have included the
> >>> leftover bindings patch for the ti,ds90c185 here.
> >>
> >> I feel like this series would look better if it would make use of the
> >> proposed bridge media bus format support I have recently sent out [1]
> >> (and which was not there when you first sent v1).
> >>
> >> I understand your fundamental problem here is that the bus format
> >> that should be reported by your bridge is different from the ones
> >> actually supported by the TDA19988 chip, as the wirings ground some
> >> of the input pins.
> >>
> >> Although this is defintely something that could be described in the
> >> bridge's own OF node with the 'bus_width' property, and what I would do,
> >> now that you have made a bridge out from the tda19988 driver, is:
> >>
> >> 1) Set the bridge accepted input bus_format parsing its pin
> >> configuration, or default it if that's not implemented yet.
> >> This will likely be rgb888. You can do that using the trivial
> >> support for bridge input image formats implemented by my series.
> >> 2) Specify in the bridge endpoint a 'bus_width' of <16>
> >> 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
> >> and parse the remote endpoint property 'bus_width' and get the <16>
> >> value back.
> >
> > Parsing properties of remote nodes should be avoided as much as possible, as
> > they need to be interpreted in the context of the DT bindings related to the
> > compatible string applicable to that node. I'd rather have the bus_width
> > property in the local endpoint node.
>
> In addition to that, my view of this binding
>
> 	endpoint {
> 		bus-type = <0>;

bus-type is used by v4l2_fwnode helpers to decide which type of bus
they're dealing with iirc. Here it seems to me it has no added
value, also because in your bindings description "it shall be 0" and
it is not parsed anywhere in you code, but no big deal....

> 		bus-widht = <16>;
> 	};
>
> is that it always means rgb565. See further below.
>
> >> 4) Set the correct format in the atmel hlcd driver to accommodate a
> >> bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
> >> or are there other possible combinations I am missing?)
> >>
> >> I would consider this better mostly because in this series you are
> >> creating a semantic for the whole DRM subsystem on the 'bus_width'
> >> property, where numerical values as '12', '16' etc are arbitrary tied
> >> to the selection of a media bus format. At least you should use a
> >> common set of defines [1] between the device tree and the driver,
> >> but this looks anyway fragile imho.
> >
> > This I agree with though. Combining the remote bus format with the local bus
> > width should fix the problem without having to parse remote properties.
>
> My thinking was that the binding with bus-type = <0> and bus-width = <bpp>
> would mean a parallel bus (type 0 means auto-detect and with a bus-width that
> auto-detect means a parallel bus) and the most natural/common interpretation
> of that bus-width. For bus widths of 12, 16, 18, 24, 30 etc I think that
> would be rgb444, rgb565, rgb666, rgb888, rgb101010 (or, I'm first so I get
> to define the default). If you have some other interpretation of a bus with
> that width, you'd need to extend the video-interface binding with some way
> of saying what you need, perhaps using some kind of data mapping or something
> to say e.g. bgr666. And you'd need some kind of indicator if you have YUV
> signals instead of RGB, and LVDS isn't a completely parallel bus, so you'd
> need something for that. Etc.

The fundamental issue here is that you're tying the bus with to an
image format. Why <16> can't be, say, MEDIA_BUS_FMT_YVYU8_1X16? it
spans to 16 bits, doesn't it? And I'm sorry but the 'I'm first so I
get to define defaults' argument doesn't apply here.

So, it is my opinion you need to expose an image format somewhere. And
it is my opinion again, which can be very wrong ofc, that this place
is the bridge driver.

You need to adjust the output to accommodate wirings? You can use the
bus_width on the hlcd side, as Laurent suggested, but the bus width
does not tie to any image format at all, even more if you're making
that decision in a drm-wide function.

>
> Because the word from Rob was that there should be one common binding that
> describes video interfaces. I started an implementation that interprets that
> binding in a drm context in
> [PATCH 3/7] drm: of: introduce drm_of_media_bus_fmt

As usual, one should try to reuse as much as possible of the existing
bindings. That's a totally different thing compared to assign to a bus
width property an associated image format for the whole DRM subsystem

ot: those properties should be moved outside of
media/video_interfaces.txt sooner or later, to a more generic place...

>
> With that view, any input format specification of the bridge is not helpful
> for me since what the bridge specifies (without help) is going to be wrong

No it's not useless. I can have an encoder that can provide both YUV
and RGB formats. If your bridge accepts RGB I want to know that, and
the bus_width is unrelated imho.

> anyway. End result, I need to specify the format manually on either the
> bridge or the atmel-hlcdc side, and I happen to think that the correct side
> is with the atmel-hlcdc, because that is where my issue originates. In short,
> the "drm: bridge: Add support for static image formats" series is unrelated
> as far as I can tell.

I may be biased on this, so I let other to judge and provide more
suggestions.

Thanks
   j

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa2dFTAAoJEHI0Bo8WoVY8irMP/jB3Ca0uJnp1srmzhNRB18te
GP0W4+A3VD+jfrfGK7Tzx/iEbBFq0erMPbl84k4FszWoeLCLMxFKsjbobPvtS4pg
G5IcWEaZTji9ZkhJIZfb0wVMxd/plSThM50UWGTqgPTPhabLEZgkai5gl+1STg5z
Iyr4/TjTfAZ73zsdHz8rNFSnsUtOx9Jse/fT3m7LCyhkFLX4/x7wc4n6q7ZrOTHb
x8672LqUs/I3Ut2nf6E4afMfc02ta3r72isAazd91quhbMJKm+FFVWMrM/DdawmD
c189HlYEesVs50UrNehRW/f7NL4nLIQCmLi3O+GNXJc98qq4ShaW1V3gR1+3BOT8
f/wFaEYU38DGYZr4+ZSVhTav8FQ/MpHcRR7uzq1B8TaHk7D4skmnSG2pBQMvN3kO
cqi5POi/lZRrZ0ycTK5TEdAAeuk6MUBNjv8LVVHL4LhyZRcYIgJXRhLpZbooThWU
0wV1HhktZsduWCyXFVwdeE6sLn5JMaCAP2qil2H2NP4ETh0tktCjgKLLICYyjq5Z
1oj8BwKBsZXQMXb0M+u+dcwHYUUfXfTCYnsLxkWIRN9HXfvA9D6aBdNFdGQ8t3RP
D3dYWArL0OR50z4RkuZkExN6B3XM4/7C49Foi91dKqo9oYfomQQQUx9jUFcjLF3N
8H8ZWDBrybdVZkDMDRKv
=exX7
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
