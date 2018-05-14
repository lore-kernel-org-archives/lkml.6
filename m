Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeENUkc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:40:32 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:43706 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENUka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:40:30 -0400
Message-ID: <abeac1ee792b8f063001c4c280ca7f0167ac59be.camel@paulk.fr>
Subject: Re: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux
 AT070TN90
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Date: Mon, 14 May 2018 22:40:15 +0200
In-Reply-To: <20180511085938.wjmdsdjfvdxd4shk@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
         <20180509071226.ivh4s3wtczg2u7zw@flea>
         <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
         <20180511085938.wjmdsdjfvdxd4shk@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-viS6L8A31GZMGGCmnqJq"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-viS6L8A31GZMGGCmnqJq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 11 mai 2018 =C3=A0 10:59 +0200, Maxime Ripard a =C3=A9crit :
> On Wed, May 09, 2018 at 01:31:23PM +0200, Paul Kocialkowski wrote:
> > On Wed, 2018-05-09 at 09:12 +0200, Maxime Ripard wrote:
> > > On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> > > > This adds timings for the RGB666 variant of the Innolux AT070TN90 p=
anel,
> > > > as found on the Ainol AW1 tablet.
> > > >=20
> > > > The panel also supports RGB888 output. When RGB666 mode is used ins=
tead,
> > > > the two extra lanes per component are grounded.
> > > >=20
> > > > In the future, it might become necessary to introduce a dedicated
> > > > device-tree property to specify the bus format to use instead of th=
e
> > > > default one for the panel. This will allow supporting different bus
> > > > formats for the same panel modes.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++=
++
> > > >  1 file changed, 26 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm=
/panel/panel-simple.c
> > > > index cbf1ab404ee7..32e30d5a8f08 100644
> > > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > > @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043=
tn24 =3D {
> > > >  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDG=
E,
> > > >  };
> > > > =20
> > > > +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> > > > +	.clock =3D 40000,
> > > > +	.hdisplay =3D 800,
> > > > +	.hsync_start =3D 800 + 112,
> > > > +	.hsync_end =3D 800 + 112 + 1,
> > > > +	.htotal =3D 800 + 112 + 1 + 87,
> > > > +	.vdisplay =3D 480,
> > > > +	.vsync_start =3D 480 + 141,
> > > > +	.vsync_end =3D 480 + 141 + 1,
> > > > +	.vtotal =3D 480 + 141 + 1 + 38,
> > > > +	.vrefresh =3D 60,
> > > > +};
> > > > +
> > > > +static const struct panel_desc innolux_at070tn90 =3D {
> > > > +	.modes =3D &innolux_at070tn90_mode,
> > > > +	.num_modes =3D 1,
> > > > +	.size =3D {
> > > > +		.width =3D 154,
> > > > +		.height =3D 86,
> > > > +	},
> > > > +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> > > > +};
> > > > +
> > >=20
> > > I'm not really convinced this is the right approach. You said it
> > > yourself, the panel is using a 24-bits interface, and you just happen
> > > to have a tablet that routed it using a 18-bits interface instead.
> > >=20
> > > That doesn't belong in the driver, especially associated to the
> > > compatible, but where the routing is described: in the device
> > > tree. And given that the panel interface is a 24 bits panel, if we
> > > were to have a default, we should have this one, and not the one
> > > fitting your use case.
> >=20
> > I fully agree, this is why I suggested introducing a dedicated dt
> > property for selecting the bus format (in the commit message). I still
> > proposed this patch as a temporary solution, but I'm definitely willing
> > to craft a proper solution as well.
> >=20
> > Here is an initial proposition:
> > 1. Making bus_format an array in struct panel_desc and listing all the
> > relevant bus formats that the panel can support there;
>=20
> I'm not sure this is needed, the input format is always the same in
> your case, the panel will always take a 24 bits RGB value. What you
> want to change is the encoder output format (and I guess you want that
> to be meaningful to enable or not the dithering).

Isn't the panel format supposed to match what the encoder's output
should be aiming for? In my case, that would be RGB666, so the idea
would be specifying both MEDIA_BUS_FMT_RGB666_1X18 and
MEDIA_BUS_FMT_RGB888_1X24 in a list of supported bus formats for the
panel. This way, both my setup and RGB888 setups can be supported.

> > 2. Introducing an optional "bus-format" dt property that indicates whic=
h
> > bus format to use, and using the first index of the bus formats array i=
f
> > the property is not present;
>=20
> I guess the width would be enough, and that way we can take the
> bus-width format that is already defined (but used in the v4l2
> framework, not in DRM yet).

Well, we already have bus-format defines on the DRM side and it feels
like mapping these directly in device-tree would be more useful as a
description of the hardware than just having the bus width.

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-viS6L8A31GZMGGCmnqJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlr59C8ACgkQhP3B6o/u
lQw8rA/+O1nbscogyRVKWs96j8i+PkNZYCFqCTiffAvqmsTA5uIVMgEZnePoGEJn
3QQ+aBMcsNku7CeQSx3pnfjD87is4g1f/XCMHrtS1Q3R4zb6W9hUS5KqLxSClPd2
ehqOh9lgueEpYrvy2tvO2RE1J9kOIlvsexfdainyfXUrpeGLenTPMJ/81gtJIH2t
zoo7FKlNvwrv4POEivip/CpvK3GuzZRZ3VVXNOcjWjjyjlL698RRCSagclwwxpI4
k3EvEOS9CoV7lK69eXWqMTKAqn/WtTv8o4oJWxaGf83nafI0Sp8SQhDjmuuK/QLZ
eNfELyCB2rn543qAEjUV2oyjMF9MMHts+B3hbMnBHdZbDl5e19pe8wvPQlX8cjXa
ZZPcHgjVyzsVGyFUsodbPcMpZ8zCzzgHHVwlWtbg0NZWhqp6giSLwsWElYgY2uli
aqvOjEYZKyl7YKT47Y0qGK2zVd7t0TmVFp6Szin/pYcFo8rh6KLJdQZeBO9k3t7n
VWCyTmVMNHdL1eGTo+zTVtDFmX5UMEv4Muj54Ma3I5NkPYtc2criVExADk19bqRX
O6JkEsDKxNNEDHm2F8UjYg8zVyOUYL220dtRTQvUxuU8Bwpe77gfCSoVfM0hm9Vi
LnQEwRW28SmheCaxeR2yX1/NZFvOAXPypuvVlacS+HIVXIwi30A=
=q9Ob
-----END PGP SIGNATURE-----

--=-viS6L8A31GZMGGCmnqJq--
