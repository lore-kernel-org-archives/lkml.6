Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA7C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3084206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3084206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeI2V4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:56:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55847 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbeI2V4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:56:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7EF9F2075C; Sat, 29 Sep 2018 17:27:58 +0200 (CEST)
Received: from localhost (unknown [212.145.226.70])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3B753206D0;
        Sat, 29 Sep 2018 17:27:58 +0200 (CEST)
Date:   Sat, 29 Sep 2018 17:27:58 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 08/12] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
Message-ID: <20180929152758.g3goxwjud2ym5rft@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-9-jagan@amarulasolutions.com>
 <20180927171451.7iqt2nt2log5qojf@flea>
 <CAMty3ZDxpLwVDsgVMjX+6+uz89sQ1aZaXHHZ+-5aogrA4MHmqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xe5bugg4kqq4qxfb"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDxpLwVDsgVMjX+6+uz89sQ1aZaXHHZ+-5aogrA4MHmqw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xe5bugg4kqq4qxfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 11:03:19PM +0530, Jagan Teki wrote:
> On Thu, Sep 27, 2018 at 10:44 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 05:18:46PM +0530, Jagan Teki wrote:
> > > Accordingly to BPI-M64-bsp DE DSI code Video start delay
> > > can be computed by subtracting total vertical timing with
> > > front porch timing and with adding 1 delay line for TCON.
> >
> > This is what the current code is doing as well.
>=20
> The current code
> return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>=20
> (mode->vsync_end - mode->vdisplay) =3D front porch + sync
>=20
> but I'm updating here only front porch.
>=20
> >
> > > This patch simply add the start_delay logic from BPI-M64-bsp,
> > > w/o this new computation, the DSI on A64 encounter vblank time out.
> > >
> > > [CRTC:36:crtc-0] vblank wait timed out
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 9918fdb990ff..217db74c6dc3 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi=
 *dsi,
> > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > >                                          struct drm_display_mode *mod=
e)
> > >  {
> > > -     return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> > > +     u32 vfp =3D mode->vsync_start - mode->vdisplay;
>=20
> let me explain this.
>=20
> Actual code from Allwinner
> u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
>=20
> So,
>=20
> =3D> (panel->lcd_vt - panel->lcd_y) - (panel->lcd_vbp)
> =3D> (front porch + sync + back porch) - (back porch + sync)

Unless Allwinner is doing something fishy, in which case that should
be mentionned, the back porch doesn't contain the sync pulse.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xe5bugg4kqq4qxfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluvmf0ACgkQ0rTAlCFN
r3T3RxAAikSkcLX64xL4ADEaM4iclHBK2Ny9w5ont72SDIPINg16ropWPGImoMcB
pv6NSMPvqAMiOw09wdUWRQRWMf53RLqGoZAMyB9P8E2WWg51OZ9lYCL1XKRzIrdv
NTN2452YF1eIfT7hDNuS+lLWeQVV0q36x5flkA8L7tMXvqM2//GVq/k21FBTNNXr
fUqxdTxAEivmIO8eVB14rgcruZSlyFyYRyqjLZIqFityeOWxBpzRPyj5YmP3kLZl
4NJPPCIv8RhqyOXWQbzmEFmVRp/4bHkQT+0WdnDBVrBIKGG85pS45J5mnlrYK094
cO8xZHRxYoV3jm5xdzMzLwiOQ5yYD867CIUwgVsQMT/0E8wzfRhZG4FuxEVbyZJL
YaTjxMC9GwzJgTu7GDCFgx/IaGqLhBO52iYLwNUcZDA9WCuwNN7N3/iirTFhegEU
IshO6l6UOr/HyTAdlAoF4tTtaJ4YtYDYhLBMcH8D56u/jV1ef5y405NLEubtL8ko
eXEfC4Xw1aoOhQ8xmBeqzTBfmR9FzAg+B5qIxiDGJqpemgxwkG31/VI7rDfk6S9h
cSV/jP3hIgTQXHq9es+NQ46dokpNt8MPJ+B0gh3pzo0dLDfC/3sBSKaPrcbdZlzR
Bbkgp8cA7XB4dRZ3ebBZtZtuA5ri73FZJL37ABSptILhC2vgzX8=
=3cYf
-----END PGP SIGNATURE-----

--xe5bugg4kqq4qxfb--
