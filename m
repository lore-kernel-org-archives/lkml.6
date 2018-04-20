Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbeDTIwq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:52:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57791 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDTIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:52:44 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 20 Apr 2018 10:52:35 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
Message-ID: <20180420085235.GI4235@w540>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,
    I've been a bit a pain in the arse for you recently, but please
bear with me a bit more, and sorry for jumping late on the band wagon.

On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
> Hi!
>
> I naively thought that since there was support for both nxp,tda19988 (in
> the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
> But it wasn't, so I started looking around and realized I had to fix
> things.
>
> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
> component, but now in v3 I fix things by making the tda998x driver
> a bridge instead. This was after a suggestion from Boris Brezillion
> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
> after comparing what was needed, I too find the bridge approach better.
>
> In addition to the above, our PCB interface between the SAMA5D3 and the
> HDMI encoder is only using 16 bits, and this has to be described
> somewhere, or the atmel-hlcdc driver have no chance of selecting the
> correct output mode. Since I have similar problems with a ds90c185 lvds
> encoder I added patches to override the atmel-hlcdc output format via
> DT properties compatible with the media video-interface binding and
> things start to play together.
>
> Since this series superseeds the bridge series [1], I have included the
> leftover bindings patch for the ti,ds90c185 here.
>

I feel like this series would look better if it would make use of the
proposed bridge media bus format support I have recently sent out [1]
(and which was not there when you first sent v1).

I understand your fundamental problem here is that the bus format
that should be reported by your bridge is different from the ones
actually supported by the TDA19988 chip, as the wirings ground some
of the input pins.

Although this is defintely something that could be described in the
bridge's own OF node with the 'bus_width' property, and what I would do,
now that you have made a bridge out from the tda19988 driver, is:

1) Set the bridge accepted input bus_format parsing its pin
configuration, or default it if that's not implemented yet.
This will likely be rgb888. You can do that using the trivial
support for bridge input image formats implemented by my series.
2) Specify in the bridge endpoint a 'bus_width' of <16>
3) In your atmel-hlcd get both the image format of the bridge (rgb888)
and parse the remote endpoint property 'bus_width' and get the <16>
value back.
4) Set the correct format in the atmel hlcd driver to accommodate a
bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
or are there other possible combinations I am missing?)

I would consider this better mostly because in this series you are
creating a semantic for the whole DRM subsystem on the 'bus_width'
property, where numerical values as '12', '16' etc are arbitrary tied
to the selection of a media bus format. At least you should use a
common set of defines [1] between the device tree and the driver,
but this looks anyway fragile imho.

Have I maybe missed some parts of the problem you are trying to solve
here?

Thank you
   j

[1] drm: bridge: Add support for static image formats
    https://lwn.net/Articles/752296/
[2] include/uapi/linux/media-bus-format.h
> Anyway, this series solves some real issues for my HW.
>
> Cheers,
> Peter
>
> Changes since v2   https://lkml.org/lkml/2018/4/17/385
> - patch 2/7 fixed spelling and added an example
> - patch 4/7 parse the DT up front and store the result indexed by encoder
> - old patch 5/6 and 6/6 dropped
> - patch 5-7/7 are new and makes the tda998x driver a drm_bridge
>
> Changes since v1   https://lkml.org/lkml/2018/4/9/294
> - added reviewed-by from Rob to patch 1/6
> - patch 2/6 changed so that the bus format override is in the endpoint
>   DT node, and follows the binding of media video-interfaces.
> - patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
>   media video-interface binding (partially).
> - patch 4/6 now makes use of the above helper (and also fixes problems
>   with the 3/5 patch from v1 when no override was specified).
> - do not mention unrelated connector display_info details in the cover
>   letter and commit messages.
>
> [1]
> "Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
> "Bridge" series v1   https://lkml.org/lkml/2018/3/17/221
>
> Peter Rosin (7):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   dt-bindings: display: atmel: optional video-interface of endpoints
>   drm: of: introduce drm_of_media_bus_fmt
>   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
>   drm/i2c: tda998x: find the drm_device via the drm_connector
>   drm/i2c: tda998x: split encoder and component functions from the work
>   drm/i2c: tda998x: register as a drm bridge
>
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 +++
>  .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  71 ++++++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  40 +++-
>  drivers/gpu/drm/drm_of.c                           |  38 ++++
>  drivers/gpu/drm/i2c/tda998x_drv.c                  | 201 ++++++++++++++++++---
>  include/drm/drm_of.h                               |   7 +
>  8 files changed, 342 insertions(+), 51 deletions(-)
>
> --
> 2.11.0
>

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa2apSAAoJEHI0Bo8WoVY8EN8P/iha5EDBNNbyC1sJqm4rQa4z
m1EmpzaZZLy6+15ZQ0zwSJhoEg53WOWJRypb8jcmU+JbTDIKEkN/srgsSf6MEC/R
39t2SAmPNmynjyQl9bcU9En+Bx+zySftMRa8u+ljpm+mvAuLZuLwRLPuKTAcj0W2
V7OthAx0Fmu6n2EvDTlxY2VA9hTArAiin06RSI4Hwb0PtIJkECeT3ndiYTHNk8K9
5zvMDuEHyZKBUbdc9pwu6l2mZZGsDyiXikESTdGXmP4VQzoENe/p+Qo6b7AZpsIW
rRr9k1XULgiPan4BAy4QZ1wpYuvhPjZCRNJBNnAw/Fe08/LB5Bxb8qba9ntjjml3
/FBkFLzzbjlXAH7raBMQR7VqcDoBsaXzxBIhn/ZQVABGnW5gxHOCLol0QoCq71O0
rZOhfwrRWgbmZmEFilYIXI4BPKvflpDDWLrelC+sS6jmi5OaFFMc+s4cQgphWS72
iJbpQrcesPfmbVWzT1iv2Tu4md5Tg+SAORrrhpfUOeP8eiCi+nbLXV6JZRI2/tYO
Kqz8WpJaP1DKqUKFurEHdW/L7ofWm/U7Au53tNYjm3L8t/6GX7YTdgfUvRePyZMn
MHO1qEMXKaITvqAu93A4w67Kb7cv3yK22tAMSGqKcgdu4K+PO7jooT5bDjBkwefX
2OsRorz8dIHmH/Pg4tPN
=OfZf
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
