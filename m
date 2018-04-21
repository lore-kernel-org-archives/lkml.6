Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeDUITx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:19:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59592 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeDUITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:19:50 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
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
Date: Sat, 21 Apr 2018 11:20:00 +0300
Message-ID: <1980444.sF26are89T@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180420112204.GK4235@w540>
References: <20180419162751.25223-1-peda@axentia.se> <6354350.l8DgUyNhLT@avalon> <20180420112204.GK4235@w540>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Friday, 20 April 2018 14:22:04 EEST jacopo mondi wrote:
> On Fri, Apr 20, 2018 at 01:18:13PM +0300, Laurent Pinchart wrote:
> > On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
> > > Hi Peter,
> > > 
> > > I've been a bit a pain in the arse for you recently, but please
> > > bear with me a bit more, and sorry for jumping late on the band wagon.
> > > 
> > > On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
> > > > Hi!
> > > > 
> > > > I naively thought that since there was support for both nxp,tda19988
> > > > (in the tda998x driver) and the atmel-hlcdc, things would be a smooth
> > > > ride. But it wasn't, so I started looking around and realized I had to
> > > > fix things.
> > > > 
> > > > In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
> > > > component, but now in v3 I fix things by making the tda998x driver
> > > > a bridge instead. This was after a suggestion from Boris Brezillion
> > > > (the atmel-hlcdc maintainer), so there was some risk of bias ... but
> > > > after comparing what was needed, I too find the bridge approach
> > > > better.
> > > > 
> > > > In addition to the above, our PCB interface between the SAMA5D3 and
> > > > the HDMI encoder is only using 16 bits, and this has to be described
> > > > somewhere, or the atmel-hlcdc driver have no chance of selecting the
> > > > correct output mode. Since I have similar problems with a ds90c185
> > > > lvds encoder I added patches to override the atmel-hlcdc output format
> > > > via DT properties compatible with the media video-interface binding
> > > > and things start to play together.
> > > > 
> > > > Since this series superseeds the bridge series [1], I have included
> > > > the leftover bindings patch for the ti,ds90c185 here.
> > > 
> > > I feel like this series would look better if it would make use of the
> > > proposed bridge media bus format support I have recently sent out [1]
> > > (and which was not there when you first sent v1).
> > > 
> > > I understand your fundamental problem here is that the bus format
> > > that should be reported by your bridge is different from the ones
> > > actually supported by the TDA19988 chip, as the wirings ground some
> > > of the input pins.
> > > 
> > > Although this is defintely something that could be described in the
> > > bridge's own OF node with the 'bus_width' property, and what I would do,
> > > now that you have made a bridge out from the tda19988 driver, is:
> > > 
> > > 1) Set the bridge accepted input bus_format parsing its pin
> > > configuration, or default it if that's not implemented yet.
> > > This will likely be rgb888. You can do that using the trivial
> > > support for bridge input image formats implemented by my series.
> > > 2) Specify in the bridge endpoint a 'bus_width' of <16>
> > > 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
> > > and parse the remote endpoint property 'bus_width' and get the <16>
> > > value back.
> > 
> > Parsing properties of remote nodes should be avoided as much as possible,
> > as they need to be interpreted in the context of the DT bindings related
> > to the compatible string applicable to that node. I'd rather have the
> > bus_width property in the local endpoint node.
> 
> Right, I see...
> Well, in Peter's case, the bus width, being a consequence of
> wirings, can be described safely in both endpoints, right?

If we look at it from the endpoints' point of view, the display controller has 
to output a 16-bit format, and the HDMI encoder receives a 24-bit format. The 
conversion is due to PCB wiring so there's no DT node to describe that. I thus 
believe the right description to be bus-width = <16> on the display controller 
side, and bus-width = <24> on the HDMI encoder side.

This being said, even if the bus-width property was set to 16 on both sides, 
what I frown upon is parsing a property of the HDMI encoder DT node in the 
display controller driver.

> > > 4) Set the correct format in the atmel hlcd driver to accommodate a
> > > bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
> > > or are there other possible combinations I am missing?)
> > > 
> > > I would consider this better mostly because in this series you are
> > > creating a semantic for the whole DRM subsystem on the 'bus_width'
> > > property, where numerical values as '12', '16' etc are arbitrary tied
> > > to the selection of a media bus format. At least you should use a
> > > common set of defines [1] between the device tree and the driver,
> > > but this looks anyway fragile imho.
> > 
> > This I agree with though. Combining the remote bus format with the local
> > bus width should fix the problem without having to parse remote
> > properties.
> > 
> > > Have I maybe missed some parts of the problem you are trying to solve
> > > here?
> > > 
> > > [1] drm: bridge: Add support for static image formats
> > > 
> > >     https://lwn.net/Articles/752296/
> > > 
> > > [2] include/uapi/linux/media-bus-format.h
> > > 
> > > > Anyway, this series solves some real issues for my HW.
> > > > 
> > > > Changes since v2   https://lkml.org/lkml/2018/4/17/385
> > > > - patch 2/7 fixed spelling and added an example
> > > > - patch 4/7 parse the DT up front and store the result indexed by
> > > > encoder
> > > > - old patch 5/6 and 6/6 dropped
> > > > - patch 5-7/7 are new and makes the tda998x driver a drm_bridge
> > > > 
> > > > Changes since v1   https://lkml.org/lkml/2018/4/9/294
> > > > - added reviewed-by from Rob to patch 1/6
> > > > - patch 2/6 changed so that the bus format override is in the endpoint
> > > > 
> > > >   DT node, and follows the binding of media video-interfaces.
> > > > 
> > > > - patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
> > > > 
> > > >   media video-interface binding (partially).
> > > > 
> > > > - patch 4/6 now makes use of the above helper (and also fixes problems
> > > > 
> > > >   with the 3/5 patch from v1 when no override was specified).
> > > > 
> > > > - do not mention unrelated connector display_info details in the cover
> > > > 
> > > >   letter and commit messages.
> > > > 
> > > > [1]
> > > > "Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
> > > > "Bridge" series v1   https://lkml.org/lkml/2018/3/17/221
> > > > 
> > > > Peter Rosin (7):
> > > >   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
> > > >   dt-bindings: display: atmel: optional video-interface of endpoints
> > > >   drm: of: introduce drm_of_media_bus_fmt
> > > >   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
> > > >   drm/i2c: tda998x: find the drm_device via the drm_connector
> > > >   drm/i2c: tda998x: split encoder and component functions from the
> > > >   work
> > > >   drm/i2c: tda998x: register as a drm bridge
> > > >  
> > > >  .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 +++
> > > >  .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
> > > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  71 ++++++--
> > > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
> > > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  40 +++-
> > > >  drivers/gpu/drm/drm_of.c                           |  38 ++++
> > > >  drivers/gpu/drm/i2c/tda998x_drv.c                  | 201 ++++++++++--
> > > >  include/drm/drm_of.h                               |   7 +
> > > >  8 files changed, 342 insertions(+), 51 deletions(-)

-- 
Regards,

Laurent Pinchart
