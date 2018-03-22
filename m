Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeCVIYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 04:24:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35418 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbeCVIYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 04:24:11 -0400
Message-ID: <1521706988.1175.4.camel@bootlin.com>
Subject: Re: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date: Thu, 22 Mar 2018 09:23:08 +0100
In-Reply-To: <CAGb2v65JqT2go2kX+yEWeWiQX6U5PFoXEbbatBXRyLyujxyouw@mail.gmail.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
         <CAGb2v65JqT2go2kX+yEWeWiQX6U5PFoXEbbatBXRyLyujxyouw@mail.gmail.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G3MpKllsdvlC8s3d1AMg"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G3MpKllsdvlC8s3d1AMg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Thu, 2018-03-22 at 14:47 +0800, Chen-Yu Tsai wrote:
> On Wed, Mar 21, 2018 at 11:28 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > It turns out that the frontend is not capable of preserving the
> > alpha
> > component (that is always set to 0xff), so only support XRGB8888
> > instead.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
> >  drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index b98dafda52f8..274a1db6fa8e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -440,6 +440,10 @@ static bool
> > sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
> >         if (IS_ERR(backend->frontend))
> >                 return false;
> >=20
> > +       /*
> > +        * TODO: Don't use the frontend for x2/x4 scaling and allow
> > RGB formats
> > +        * with an alpha component then.
>=20
> This and the commit log are kind of conflicting. Is it just the scalar
> that doesn't
> work with an alpha component, or the whole frontend?

It's the whole frontend that does not support alpha in its output
formats. I'm talking about scaling here because that's still the main
reason to use the frontend. On the other hand, the backend allows
integer scaling with an alpha component, hence the comment.

Do you think I need to rework the comment/commit log?

Thanks for the review,

Paul

> > +        */
> >         return sun4i_backend_plane_uses_scaler(state);
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > index ddf6cfa6dd23..3ea925584891 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > @@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
> >  static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32
> > *val)
> >  {
> >         switch (fmt) {
> > -       case DRM_FORMAT_ARGB8888:
> > +       case DRM_FORMAT_XRGB8888:
> >                 *val =3D 5;
> >                 return 0;
> >=20
> > @@ -120,7 +120,6 @@ static int
> > sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
> >  {
> >         switch (fmt) {
> >         case DRM_FORMAT_XRGB8888:
> > -       case DRM_FORMAT_ARGB8888:
> >                 *val =3D 2;
> >                 return 0;
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > index eb93df445a10..15238211a61a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > @@ -100,9 +100,9 @@ static void
> > sun4i_backend_layer_atomic_update(struct drm_plane *plane,
> >                 sun4i_frontend_update_coord(frontend, plane);
> >                 sun4i_frontend_update_buffer(frontend, plane);
> >                 sun4i_frontend_update_formats(frontend, plane,
> > -                                             DRM_FORMAT_ARGB8888);
> > +                                             DRM_FORMAT_XRGB8888);
> >                 sun4i_backend_update_layer_frontend(backend, layer-
> > >id, plane,
> > -                                                   DRM_FORMAT_ARGB8
> > 888);
> > +                                                   DRM_FORMAT_XRGB8
> > 888);
> >                 sun4i_frontend_enable(frontend);
> >         } else {
> >                 sun4i_backend_update_layer_formats(backend, layer-
> > >id, plane);
> > --
> > 2.16.2
> >=20
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-G3MpKllsdvlC8s3d1AMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlqzZ+wACgkQ3cLmz3+f
v9HiAAf8DK2aPhGGCZwFqYHdAqGtDmyvufnY77YuxCj4BcCV2CrRjkppoo/3LmGg
JZa2l3oguPRli6PV/dvbLAPuZ6eFLdk+YgI2TW901lW7mfBwNzzO6IC6DaRxzfJb
quOooJrnmLMk4RRIMCBmGcMo1M9GW4u6ciEJc3C5hdfcse2x57HW0Py2gK1RK51A
m4tAOxMtjRPGKoX/e/QqSYrCPuac90xNuYEykREiK+1D3w47WQui4xeheI0GIM/M
T6INoytSEkxHavF3hUdXHySIwBGjKm4D7etSIY7mUiAKVUwnRiWVBTpKvCGfk49S
bgSluaz3kuS6g6o29Ukd4521radU2Q==
=15P8
-----END PGP SIGNATURE-----

--=-G3MpKllsdvlC8s3d1AMg--
