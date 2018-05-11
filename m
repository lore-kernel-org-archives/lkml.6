Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEKI7w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:59:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35079 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeEKI7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:59:50 -0400
Date: Fri, 11 May 2018 10:59:38 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Message-ID: <20180511085938.wjmdsdjfvdxd4shk@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180509071226.ivh4s3wtczg2u7zw@flea>
 <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="makdxzrl7mgv4ors"
Content-Disposition: inline
In-Reply-To: <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--makdxzrl7mgv4ors
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 01:31:23PM +0200, Paul Kocialkowski wrote:
> On Wed, 2018-05-09 at 09:12 +0200, Maxime Ripard wrote:
> > On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> > > This adds timings for the RGB666 variant of the Innolux AT070TN90 pan=
el,
> > > as found on the Ainol AW1 tablet.
> > >=20
> > > The panel also supports RGB888 output. When RGB666 mode is used inste=
ad,
> > > the two extra lanes per component are grounded.
> > >=20
> > > In the future, it might become necessary to introduce a dedicated
> > > device-tree property to specify the bus format to use instead of the
> > > default one for the panel. This will allow supporting different bus
> > > formats for the same panel modes.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/p=
anel/panel-simple.c
> > > index cbf1ab404ee7..32e30d5a8f08 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn=
24 =3D {
> > >  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
> > >  };
> > > =20
> > > +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> > > +	.clock =3D 40000,
> > > +	.hdisplay =3D 800,
> > > +	.hsync_start =3D 800 + 112,
> > > +	.hsync_end =3D 800 + 112 + 1,
> > > +	.htotal =3D 800 + 112 + 1 + 87,
> > > +	.vdisplay =3D 480,
> > > +	.vsync_start =3D 480 + 141,
> > > +	.vsync_end =3D 480 + 141 + 1,
> > > +	.vtotal =3D 480 + 141 + 1 + 38,
> > > +	.vrefresh =3D 60,
> > > +};
> > > +
> > > +static const struct panel_desc innolux_at070tn90 =3D {
> > > +	.modes =3D &innolux_at070tn90_mode,
> > > +	.num_modes =3D 1,
> > > +	.size =3D {
> > > +		.width =3D 154,
> > > +		.height =3D 86,
> > > +	},
> > > +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> > > +};
> > > +
> >=20
> > I'm not really convinced this is the right approach. You said it
> > yourself, the panel is using a 24-bits interface, and you just happen
> > to have a tablet that routed it using a 18-bits interface instead.
> >=20
> > That doesn't belong in the driver, especially associated to the
> > compatible, but where the routing is described: in the device
> > tree. And given that the panel interface is a 24 bits panel, if we
> > were to have a default, we should have this one, and not the one
> > fitting your use case.
>=20
> I fully agree, this is why I suggested introducing a dedicated dt
> property for selecting the bus format (in the commit message). I still
> proposed this patch as a temporary solution, but I'm definitely willing
> to craft a proper solution as well.
>=20
> Here is an initial proposition:
> 1. Making bus_format an array in struct panel_desc and listing all the
> relevant bus formats that the panel can support there;

I'm not sure this is needed, the input format is always the same in
your case, the panel will always take a 24 bits RGB value. What you
want to change is the encoder output format (and I guess you want that
to be meaningful to enable or not the dithering).

> 2. Introducing an optional "bus-format" dt property that indicates which
> bus format to use, and using the first index of the bus formats array if
> the property is not present;

I guess the width would be enough, and that way we can take the
bus-width format that is already defined (but used in the v4l2
framework, not in DRM yet).

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--makdxzrl7mgv4ors
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1W3kACgkQ0rTAlCFN
r3R/YA/+J96FS3A3NUE7VKrBbD3TzHN7jwLsc5qPl/k/osnzdLDHNZvUw3bi+04z
5Q1qP33GziahZrbj4VScr620Ok2PkxEsVimXrjSrkq89lpO5HUVtVSJQ9XN4j2tl
diuRbe9Fuafg20h4reIdvoDJ0LCf8qAe6G58WFyh0EmAq5rfui+9+R+2hHNG9EPO
ox1/GBIvKZo1uLZF7eyWFgyvrAjMYYAS5/U4HEX2SzTJBKjt9t7pGUXdkMlkvbZF
HJAIZrsOLUpz9kVQ6deLajfW+fdL10smcgv07Kh4CP1Z8lFVfPIx4JyrDmJwoD3t
DZtX8JKXQdYdAhdy6qhxgDQMtWuriipHICgaxVcrGd0adGSM9o2x7R3usYeU/KaU
GwARofKnwqA1tyRSfVAGAde2EHNtALiP1GY5jJdAGm+PI7gecGDPY9vKoH47oUAe
hj01/qAJzogyIgv4021yuJssi+FEd7NCj2LeCMAUPEJDK4jhqkFGet0q77+VnRVE
YLSTmAjXmLKfM78bSsT82sevtDng9iFs/NXl54ZByr9pKCGwidMnqXpwTGYFB+cv
uCKwQ1yC4YvIUtxkla9FfHoLGy4yYqDArX2H8OpXbGGT5bT2wt4d5kMQxYOC51T1
q7ceqt3PDiVHiV3x2S+U9EwXudXJc8hkm3O/lbfO5JiMI7pcAWo=
=gm5b
-----END PGP SIGNATURE-----

--makdxzrl7mgv4ors--
