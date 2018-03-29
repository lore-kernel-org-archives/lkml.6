Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeC2H4e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:56:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60186 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeC2H4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:56:33 -0400
Date: Thu, 29 Mar 2018 09:56:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
Message-ID: <20180329075621.it3xltsqw4tbgeyu@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
 <20180323100330.2sijtsp5bdyyel5a@flea>
 <1522138128.1110.11.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtk33tmc6oplh2xv"
Content-Disposition: inline
In-Reply-To: <1522138128.1110.11.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtk33tmc6oplh2xv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:08:48AM +0200, Paul Kocialkowski wrote:
> On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> > On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > > In order to check whether the backend supports a specific format, an
> > > explicit list and a related helper are introduced.
> > >=20
> > > They are then used to determine whether the frontend should be used
> > > for
> > > a layer, when the format is not supported by the backend.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > > ++++++++++++++++++++++++++++++++++-
> > >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > index 274a1db6fa8e..7703ba989743 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > @@ -172,6 +172,39 @@ static int
> > > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> > >  	return 0;
> > >  }
> > > =20
> > > +static const uint32_t sun4i_backend_formats[] =3D {
> > > +	/* RGB */
> > > +	DRM_FORMAT_ARGB4444,
> > > +	DRM_FORMAT_RGBA4444,
> > > +	DRM_FORMAT_ARGB1555,
> > > +	DRM_FORMAT_RGBA5551,
> > > +	DRM_FORMAT_RGB565,
> > > +	DRM_FORMAT_RGB888,
> > > +	DRM_FORMAT_XRGB8888,
> > > +	DRM_FORMAT_BGRX8888,
> > > +	DRM_FORMAT_ARGB8888,
> > > +	/* YUV422 */
> > > +	DRM_FORMAT_YUYV,
> > > +	DRM_FORMAT_YVYU,
> > > +	DRM_FORMAT_UYVY,
> > > +	DRM_FORMAT_VYUY,
> >=20
> > Ordering them by alphabetical order would be better.
>=20
> Frankly I find it a lot harder to read when the formats are not grouped
> by "family". This is the drm_fourcc enumeration order, which has some
> kind of logic behind it. What is the advantage of alphabetical ordering
> here?

It's self-sufficient and self-explanatory. The sorting here, while it
would make sense lack both: you need to refer to the drm_fourcc.h file
to get the sorting right (which makes it harder to edit and review,
and thus more error prone), and it assumes that the editor knows about
that sorting in the first place.

And it's an assumption we can't really make, since some people will
edit that structure in the first place without any background at all
with DRM, or even graphics in general.

While the assumption you have to make for the alphabetical order is
that one knows the latin alphabet, which is a pretty obvious one when
you're doing C programming.

> > > +	 */
> > > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > > +		return true;
> >=20
> > Even though there's a comment, this is not really natural. We are
> > checking whether the frontend supports the current plane_state, so it
> > just makes more sense to check whether the frontend supports the
> > format, rather than if the backend doesn't support them.
>=20
> The rationale behind this logic is that we should try to use the backend
> first and only use the frontend as a last resort. Some formats are
> supported by both and checking that the backend supports a format first
> ensures that we don't bring up the frontend without need.

You can achieve pretty much the same thing by doing:

if (!sun4i_frontend_format_is_supported())
	return false;

if (!using_scaling)
	return false;

if (using_2x_or_4x_scaling)
	return false;

return true;

This is really about whitelisting vs blacklisting, so I'm not sure
what that would really change in the case you described above.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vtk33tmc6oplh2xv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq8nCQACgkQ0rTAlCFN
r3RWuQ//RSt87RdGUuQfLFsykXYfxxG7zc4i87zFRSSD/Jh6ySEMjYS5zHsaaDL4
U5MjXqakPe1y25PkVM2tIoEkTeUnYFX9Sw9aQojIfPPR7tekZ+Tbxf0LSBD4FS+U
y5l8DsJLahaa5YZ0GysRpU0TWpgkgjEMHPTJuwgIX6hpQ1BBNyi9o7DUWMJfCrtd
kfM13s3BsYnQUzZJvmrv7qiKcXhQR5lbIj8x/VYpdT1IaJeaXduq05LL9YggZogd
FW3JLW+6m6GiiVJs0VekdoihoKcY2lS/vtGDaIrtJ2GB6Mdki5mD8H1v/jYr8o5n
9mDM7PtXwa86ah7u6b6I+BUT523eQ4Aa2KTzA4pbEQsILLAPZmUynxf1H5wHXBMW
P5cetSR6mpKIny0wVoQjrDJDxzVbYWYooyPIVLeVdy7cELCMFq/M5l12l6zPdvcP
9Yu67m0nLDIL6ZB7o2/wfHtIKoefBAUoSK/VotVUo79/vFoTzBpKeGi4rtGAD17k
gMLE7QDEZhtgSDYZOV1nqaSyBVnGpvpgty/RNCU/yZ4dtdndbym98Ah4HwgtC9iu
IEmhGTue9A7CIURyiugc16NlFXLJSJ0lsg2NSi+dtvd/uRMYJvRyK3rxS5vV0Odo
yniSQd85Qwha1lKyQ5ezdCSOISvhSl74zh4sSZ6xqkFBka8miDI=
=kw/d
-----END PGP SIGNATURE-----

--vtk33tmc6oplh2xv--
