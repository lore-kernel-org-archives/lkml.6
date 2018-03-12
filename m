Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeCLMgr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:36:47 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33473 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeCLMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:36:45 -0400
X-Originating-IP: 2.224.242.101
Date: Mon, 12 Mar 2018 13:30:42 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
Message-ID: <20180312123042.GA12967@w540>
References: <CGME20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b@epcas3p3.samsung.com>
 <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
 <81b25fde-63fa-aacc-1bf4-f2a7b60b19ef@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <81b25fde-63fa-aacc-1bf4-f2a7b60b19ef@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andrzej,

On Mon, Mar 12, 2018 at 10:07:27AM +0100, Andrzej Hajda wrote:
> On 09.03.2018 14:51, Jacopo Mondi wrote:
> > Hello,
> >    after some discussion on the proposed bindings for generic lvds decoder and
> > Thine THC63LVD1024, I decided to drop the THC63 specific part and just live with
> > a transparent decoder that does not support any configuration from DT.
> >
> > Dropping THC63 support to avoid discussion on how to better implement support
> > for a DRM bridge with 2 input ports and focus on LVDS mode propagation through
> > bridges as explained in v1 cover letter (for DRM people: please see [1] as why
> > I find difficult to implement support for bridges with multiple input endpoints)
> >
> > Same base branch as v1, with same patches for V3M Eagle applied on top.
> > git://jmondi.org/linux v3m/v4.16-rc3/base
> >
> > Thanks
> >    j
> >
> > v1 -> v2:
> > - Drop support for THC63LVD1024
> >
> > [1] I had a quick at how to model a DRM bridge with multiple input
> > ports, and I see a blocker in how DRM identifies and matches bridges using
> > the devices node in place of the endpoint nodes.
> >
> > As THC63LVD1024 supports up to 2 LVDS inputs and 2 LVDS outputs, I see only
> > a few ways to support that:
> >  1) register 2 drm bridges from the same driver (one for each input/output pair)
> >     but they would both be matches on the same device node when the preceding
> >     bridge calls "of_drm_find_bridge()".
> >  2) register a single bridge with multiple "next bridges", but when the bridge
> >     gets attached I don't see a way on how to identify on which next bridge
> >     "drm_bridge_attach()" on, as it depends on the endpoint the current bridge
> >     has been attached on first, and we don't have that information.
> >  3) Register more instances of the same chip in DTS, one for each input/output
> >     pair. They gonna share supplies and gpios, and I don't like that.
> >
> > I had a quick look at the currently in mainline bridges and none of them has
> > multiple input endpoints, except for HDMI audio endpoint, which I haven't found
> > in use in any DTS. I guess the problem has been already debated and maybe solved
> > in the past, so feel free to point me to other sources.
>
> I think this is is a step in wrong direction, IMHO. Your previous
> patchset was quite OK, at least bindings, IMHO. Few things needed only
> polishing.
> Here we have unmanaged/transparent bridge, which is totally different,
> what happened to regulators and gpios from previous iteration.
> I do not have schematics of the board, but I guess respective pins of
> the bridge must be connected somehow.
> I think the problem you want to avoid (double bridge) should not be a
> problem at all.
> I suppose the most important is to have correct bindings - as they need
> to be stable.
> If you really must to do hacks better is to put them into driver.
>

I understand. The "transparent bridge" is of no actual use, but I don't see
how the "double bridge" thing is not an issue if I were to develop
support for the actual Thine chip.

Please see my reply from yesterday to Archit. I still think having two
bridges is somehow an issue...

While we clarify that, would it be fine an initial driver version for
the actualt Thine chip with a single input support[1]? I would ditch this
transparent bridge and resume working on a THC63LVD1024 driver from
comments received on v1.

Thanks
  j

[1] Single input support implies a single input port in DT bindings
even if the chip supports two, and my understanding was that you
didn't like this.


> Regards
> Andrzej
>
> >
> > Jacopo Mondi (3):
> >   dt-bindings: display: bridge: Document LVDS to parallel decoder
> >   drm: bridge: Add LVDS decoder driver
> >   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
> >
> >  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
> >  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 +++++++++++++++++++++
> >  5 files changed, 237 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
> >  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
> >
> > --
> > 2.7.4
> >
> >
> >
> >
>

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJapnLyAAoJEHI0Bo8WoVY8i4kP/3TjOqmc4R2Zxj8/FytFa6wC
4jkRrTZica3Fa9O+lSpmxJ4m71PbjDuMVptWZrpr7MYGfTUrgIERRVi3DxAlmEja
uWWhBqaYZ1flOUeKr94JMMEw29EedcFbAJb01buf3a0iRUTYWqoov78p4rX8a3B+
0/JLNryFvOE5GiJoB2ojh0FMHJZ9lJUBQOqfIomkfPA6d9Ifw/khYiBELiXBbr3q
iZwsmGOVZYVYJaYRRBKCV5r8WzKeIX54EejPhG1r2ZSRdpgBHzlTThn6pumGABg9
5QcjT1xxQ0yzH8CD2A7nDekxlNGQrK2m83zj4DnPoCuhnANm7GplaOyDdJLmAXox
wCDF2/PYg09lznQ6OloawZRd4NKbQSTBNzqEnlhuX+kCfd5Gdu1S150vmREJ5da3
Xfl9DK3YxYwoM5FcRx737QpEbUxEN+vh5y/ut42CKmlWx5vEekhhxVUGsVW32Vf9
RAywIcdxzmfAAZILy234KHconVyRtRFszYJTSBLlVJxTfdzrhGi/eyBrZqxKYCrp
vbFbRzyQ/6DxElRVSPx6V6+xYAA8mBoQdSDshGHPQ1h34N537zdLhFB3qsiOrqZa
fOBkHN2tsW4bLMtqwNxNx/dNbZgTKLeFaEvFslqZ9pTwtHr2P9jB4fHLAtyAfypH
MhuQW7mAgsy9sPinup1C
=Kks4
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
