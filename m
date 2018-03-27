Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeC0IJ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:09:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36552 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbeC0IJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:09:53 -0400
Message-ID: <1522138128.1110.11.camel@bootlin.com>
Subject: Re: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:08:48 +0200
In-Reply-To: <20180323100330.2sijtsp5bdyyel5a@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
         <20180323100330.2sijtsp5bdyyel5a@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7YxdHzJFmXMgAXat6VNd"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7YxdHzJFmXMgAXat6VNd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the backend supports a specific format, an
> > explicit list and a related helper are introduced.
> >=20
> > They are then used to determine whether the frontend should be used
> > for
> > a layer, when the format is not supported by the backend.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > ++++++++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> >  2 files changed, 48 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 274a1db6fa8e..7703ba989743 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -172,6 +172,39 @@ static int
> > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> >  	return 0;
> >  }
> > =20
> > +static const uint32_t sun4i_backend_formats[] =3D {
> > +	/* RGB */
> > +	DRM_FORMAT_ARGB4444,
> > +	DRM_FORMAT_RGBA4444,
> > +	DRM_FORMAT_ARGB1555,
> > +	DRM_FORMAT_RGBA5551,
> > +	DRM_FORMAT_RGB565,
> > +	DRM_FORMAT_RGB888,
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_BGRX8888,
> > +	DRM_FORMAT_ARGB8888,
> > +	/* YUV422 */
> > +	DRM_FORMAT_YUYV,
> > +	DRM_FORMAT_YVYU,
> > +	DRM_FORMAT_UYVY,
> > +	DRM_FORMAT_VYUY,
>=20
> Ordering them by alphabetical order would be better.

Frankly I find it a lot harder to read when the formats are not grouped
by "family". This is the drm_fourcc enumeration order, which has some
kind of logic behind it. What is the advantage of alphabetical ordering
here?

> > +};
> > +
> > +bool sun4i_backend_format_is_supported(uint32_t fmt)
> > +{
> > +	bool found =3D false;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(sun4i_backend_formats); i++) {
> > +		if (sun4i_backend_formats[i] =3D=3D fmt) {
> > +			found =3D true;
> > +			break;
>=20
> return true?

Definitely.

> > +		}
> > +	}
> > +
> > +	return found;
> > +}
> > +
> >  int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
> >  				     int layer, struct drm_plane
> > *plane)
> >  {
> > @@ -436,15 +469,28 @@ static bool
> > sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
> >  {
> >  	struct sun4i_layer *layer =3D plane_to_sun4i_layer(state-
> > >plane);
> >  	struct sun4i_backend *backend =3D layer->backend;
> > +	struct drm_framebuffer *fb =3D state->fb;
> > =20
> >  	if (IS_ERR(backend->frontend))
> >  		return false;
> > =20
> > +	/*
> > +	 * Let's pretend that every format is either supported by
> > the backend or
> > +	 * the frontend. This is not true in practice, as some
> > tiling modes are
> > +	 * not supported by either. There is still room to check
> > this later in
> > +	 * the atomic check process.
>=20
> Then I guess there these tiling modes will not be exposed and we won't
> ever get that far, wouldn't we?

This comment is indeed a bit irrelevant at this stage given that the
tiling modifier was not introduced yet. So in practice, this never
happens with this patch. I should probably move it to a subsequent one.

> > +	 */
> > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > +		return true;
>=20
> Even though there's a comment, this is not really natural. We are
> checking whether the frontend supports the current plane_state, so it
> just makes more sense to check whether the frontend supports the
> format, rather than if the backend doesn't support them.

The rationale behind this logic is that we should try to use the backend
first and only use the frontend as a last resort. Some formats are
supported by both and checking that the backend supports a format first
ensures that we don't bring up the frontend without need.

Cheers,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-7YxdHzJFmXMgAXat6VNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq5/BAACgkQ3cLmz3+f
v9EpBQf+MGBvlBKQs5IFljknOQ0NY7nauEqUAVxNtGLO9ZRdytdo+5tJA+6kFujw
K/J8b0YObb6qFmteKltlbRc4cCWYnUZNT+LssSk13oTDaTKTiIpGzaxGuLrnVXqC
QfVH7fptxTmM5uE75cfF3gsZZRO5yjopdwJuKu3VfjNVpKzNHFhslG6p9T8LO+Tb
Exs0P/5YNLHlrKnNg9QU0S7heCULEBu/4dF62tpgJZFLynDtnhVzQYISijMNhNv/
7oIxAtGquIQQYQRjZt0FCxoP1S+0ZfF8Dpmejc/SGtw167v46adDRhJ2721PmUQz
cbk4tF9u+H/YriACylCrYNl55hId2A==
=buD5
-----END PGP SIGNATURE-----

--=-7YxdHzJFmXMgAXat6VNd--
