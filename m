Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeC0I2v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:28:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeC0I2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:28:49 -0400
Message-ID: <1522139264.1110.28.camel@bootlin.com>
Subject: Re: [PATCH 06/10] drm/sun4i: Move and extend format-related helpers
 and tables
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:27:44 +0200
In-Reply-To: <20180323101338.z422gpxcsdre5hgj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-7-paul.kocialkowski@bootlin.com>
         <20180323101338.z422gpxcsdre5hgj@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3hIbo6OazuSzo0imDAvC"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3hIbo6OazuSzo0imDAvC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-03-23 at 11:13 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:29:00PM +0100, Paul Kocialkowski wrote:
> > This moves the various helpers and tables related to format
> > detection
> > and conversion to a dedicated file, while adding a bunch of new
> > helpers
> > (especially for YUV and tiling support) along the way.
>=20
> The addition of new helpers should be in a separate patch.

Fair enough.

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/Makefile        |   1 +
> >  drivers/gpu/drm/sun4i/sun4i_backend.c |  54 ++--------
> >  drivers/gpu/drm/sun4i/sun4i_format.c  | 193
> > ++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_format.h  |  35 ++++++
> >  4 files changed, 235 insertions(+), 48 deletions(-)
> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.c
> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.h
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/Makefile
> > b/drivers/gpu/drm/sun4i/Makefile
> > index 582607c0c488..c89c42ff803e 100644
> > --- a/drivers/gpu/drm/sun4i/Makefile
> > +++ b/drivers/gpu/drm/sun4i/Makefile
> > @@ -4,6 +4,7 @@ sun4i-frontend-y		+=3D sun4i_frontend.o
> > =20
> >  sun4i-drm-y			+=3D sun4i_drv.o
> >  sun4i-drm-y			+=3D sun4i_framebuffer.o
> > +sun4i-drm-y			+=3D sun4i_format.o
> > =20
> >  sun4i-drm-hdmi-y		+=3D sun4i_hdmi_ddc_clk.o
> >  sun4i-drm-hdmi-y		+=3D sun4i_hdmi_enc.o
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 1fad0714c70e..e8af9f3cf20b 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -29,6 +29,7 @@
> >  #include "sun4i_drv.h"
> >  #include "sun4i_frontend.h"
> >  #include "sun4i_layer.h"
> > +#include "sun4i_format.h"
> >  #include "sunxi_engine.h"
> > =20
> >  struct sun4i_backend_quirks {
> > @@ -36,50 +37,6 @@ struct sun4i_backend_quirks {
> >  	bool needs_output_muxing;
> >  };
> > =20
> > -static const u32 sunxi_rgb2yuv_coef[12] =3D {
> > -	0x00000107, 0x00000204, 0x00000064, 0x00000108,
> > -	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
> > -	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
> > -};
> > -
> > -static const u32 sunxi_bt601_yuv2rgb_coef[12] =3D {
> > -	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
> > -	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
> > -	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
> > -};
> > -
> > -static inline bool sun4i_backend_format_is_planar_yuv(uint32_t
> > format)
> > -{
> > -	switch (format) {
> > -	case DRM_FORMAT_YUV411:
> > -	case DRM_FORMAT_YUV422:
> > -	case DRM_FORMAT_YUV444:
> > -		return true;
> > -	default:
> > -		return false;
> > -	}
> > -}
> > -
> > -static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t
> > format)
> > -{
> > -	switch (format) {
> > -	case DRM_FORMAT_YUYV:
> > -	case DRM_FORMAT_YVYU:
> > -	case DRM_FORMAT_UYVY:
> > -	case DRM_FORMAT_VYUY:
> > -		return true;
> > -
> > -	default:
> > -		return false;
> > -	}
> > -}
> > -
> > -static inline bool sun4i_backend_format_is_yuv(uint32_t format)
> > -{
> > -	return sun4i_backend_format_is_planar_yuv(format) ||
> > -		sun4i_backend_format_is_packed_yuv422(format);
> > -}
> > -
> >  static void sun4i_backend_apply_color_correction(struct
> > sunxi_engine *engine)
> >  {
> >  	int i;
> > @@ -259,7 +216,7 @@ static int
> > sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
> >  			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN,
> >  			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
> > =20
> > -	if (sun4i_backend_format_is_packed_yuv422(format))
> > +	if (sun4i_format_is_packed_yuv422(format))
> >  		val |=3D SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
> >  	else
> >  		DRM_DEBUG_DRIVER("Unknown YUV format\n");
> > @@ -310,7 +267,7 @@ int sun4i_backend_update_layer_formats(struct
> > sun4i_backend *backend,
> >  	DRM_DEBUG_DRIVER("Switching display backend interlaced mode
> > %s\n",
> >  			 interlaced ? "on" : "off");
> > =20
> > -	if (sun4i_backend_format_is_yuv(fb->format->format))
> > +	if (sun4i_format_is_yuv(fb->format->format))
> >  		return sun4i_backend_update_yuv_format(backend,
> > layer, plane);
> > =20
> >  	ret =3D sun4i_backend_drm_format_to_layer(fb->format->format,=20
> > &val);
> > @@ -404,7 +361,7 @@ int sun4i_backend_update_layer_buffer(struct
> > sun4i_backend *backend,
> >  	 */
> >  	paddr -=3D PHYS_OFFSET;
> > =20
> > -	if (sun4i_backend_format_is_yuv(fb->format->format))
> > +	if (sun4i_format_is_yuv(fb->format->format))
> >  		return sun4i_backend_update_yuv_buffer(backend, fb,
> > paddr);
> > =20
> >  	/* Write the 32 lower bits of the address (in bits) */
> > @@ -549,10 +506,11 @@ static int sun4i_backend_atomic_check(struct
> > sunxi_engine *engine,
> >  		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
> >  				 drm_get_format_name(fb->format-
> > >format,
> >  						     &format_name))
> > ;
> > +
> >  		if (fb->format->has_alpha)
> >  			num_alpha_planes++;
> > =20
> > -		if (sun4i_backend_format_is_yuv(fb->format-
> > >format)) {
> > +		if (sun4i_format_is_yuv(fb->format->format)) {
> >  			DRM_DEBUG_DRIVER("Plane FB format is
> > YUV\n");
> >  			num_yuv_planes++;
> >  		}
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_format.c
> > b/drivers/gpu/drm/sun4i/sun4i_format.c
> > new file mode 100644
> > index 000000000000..3830767e6d5b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sun4i/sun4i_format.c
> > @@ -0,0 +1,193 @@
> > +/*
> > + * Copyright (C) 2015-2018 Free Electrons/Bootlin
> > + *
> > + * Maxime Ripard <maxime.ripard@bootlin.com>
> > + * Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/component.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_reserved_mem.h>
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_fb_helper.h>
> > +#include <drm/drm_of.h>
> > +
> > +#include "sun4i_drv.h"
> > +#include "sun4i_format.h"
>=20
> I guess a lot of these headers are not needed.

Yes indeed, I'll cleanup the list in v2.

> > +
> > +const u32 sunxi_rgb2yuv_coef[12] =3D {
> > +	0x00000107, 0x00000204, 0x00000064, 0x00000108,
> > +	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
> > +	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
> > +};
> > +
> > +const u32 sunxi_bt601_yuv2rgb_coef[12] =3D {
> > +	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
> > +	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
> > +	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
> > +};
> > +
> > +bool sun4i_format_is_rgb(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_ARGB4444:
> > +	case DRM_FORMAT_RGBA4444:
> > +	case DRM_FORMAT_ARGB1555:
> > +	case DRM_FORMAT_RGBA5551:
> > +	case DRM_FORMAT_RGB888:
> > +	case DRM_FORMAT_RGB565:
> > +	case DRM_FORMAT_XRGB8888:
> > +	case DRM_FORMAT_ARGB8888:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_yuv(uint32_t format)
> > +{
> > +	return sun4i_format_is_yuv411(format) ||
> > +	       sun4i_format_is_yuv420(format) ||
> > +	       sun4i_format_is_yuv422(format) ||
> > +	       sun4i_format_is_yuv444(format);
> > +}
> > +
> > +bool sun4i_format_is_yuv411(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_YUV411:
> > +	case DRM_FORMAT_YVU411:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_yuv420(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_NV12:
> > +	case DRM_FORMAT_NV21:
> > +	case DRM_FORMAT_YUV420:
> > +	case DRM_FORMAT_YVU420:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_yuv422(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_YUYV:
> > +	case DRM_FORMAT_YVYU:
> > +	case DRM_FORMAT_UYVY:
> > +	case DRM_FORMAT_VYUY:
> > +	case DRM_FORMAT_NV16:
> > +	case DRM_FORMAT_NV61:
> > +	case DRM_FORMAT_YUV422:
> > +	case DRM_FORMAT_YVU422:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_yuv444(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_YUV444:
> > +	case DRM_FORMAT_YVU444:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_packed(uint32_t format)
> > +{
> > +	if (sun4i_format_is_rgb(format))
> > +		return true;
> > +
> > +	switch (format) {
> > +	case DRM_FORMAT_YUYV:
> > +	case DRM_FORMAT_YVYU:
> > +	case DRM_FORMAT_UYVY:
> > +	case DRM_FORMAT_VYUY:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_semiplanar(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_NV12:
> > +	case DRM_FORMAT_NV21:
> > +	case DRM_FORMAT_NV16:
> > +	case DRM_FORMAT_NV61:
> > +	case DRM_FORMAT_NV24:
> > +	case DRM_FORMAT_NV42:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_is_planar(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_YUV410:
> > +	case DRM_FORMAT_YVU410:
> > +	case DRM_FORMAT_YUV411:
> > +	case DRM_FORMAT_YVU411:
> > +	case DRM_FORMAT_YUV420:
> > +	case DRM_FORMAT_YVU420:
> > +	case DRM_FORMAT_YUV422:
> > +	case DRM_FORMAT_YVU422:
> > +	case DRM_FORMAT_YUV444:
> > +	case DRM_FORMAT_YVU444:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool sun4i_format_supports_tiling(uint32_t format)
> > +{
> > +	switch (format) {
> > +	/* Semiplanar */
> > +	case DRM_FORMAT_NV12:
> > +	case DRM_FORMAT_NV21:
> > +	case DRM_FORMAT_NV16:
> > +	case DRM_FORMAT_NV61:
> > +	/* Planar */
> > +	case DRM_FORMAT_YUV420:
> > +	case DRM_FORMAT_YVU420:
> > +	case DRM_FORMAT_YUV422:
> > +	case DRM_FORMAT_YVU422:
> > +	case DRM_FORMAT_YUV411:
> > +	case DRM_FORMAT_YVU411:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_format.h
> > b/drivers/gpu/drm/sun4i/sun4i_format.h
> > new file mode 100644
> > index 000000000000..1d6364cd3681
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sun4i/sun4i_format.h
> > @@ -0,0 +1,35 @@
> > +/*
> > + * Copyright (C) 2015-2018 Free Electrons/Bootlin
> > + *
> > + * Maxime Ripard <maxime.ripard@bootlin.com>
> > + * Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> > +
> > +#ifndef _SUN4I_FORMAT_H_
> > +#define _SUN4I_FORMAT_H_
> > +
> > +extern const u32 sunxi_rgb2yuv_coef[12];
> > +extern const u32 sunxi_bt601_yuv2rgb_coef[12];
> > +
> > +bool sun4i_format_is_rgb(uint32_t format);
> > +bool sun4i_format_is_yuv(uint32_t format);
> > +bool sun4i_format_is_yuv411(uint32_t format);
> > +bool sun4i_format_is_yuv420(uint32_t format);
> > +bool sun4i_format_is_yuv422(uint32_t format);
> > +bool sun4i_format_is_yuv444(uint32_t format);
> > +bool sun4i_format_is_packed(uint32_t format);
> > +bool sun4i_format_is_semiplanar(uint32_t format);
> > +bool sun4i_format_is_planar(uint32_t format);
> > +bool sun4i_format_supports_tiling(uint32_t format);
>=20
> If we're going to add so many of them, then we should really consider
> to move them to drm_fourcc.c instead. Every one has some variation of
> some of these functions, we don't really need to duplicate it all the
> time.

Should I try to get that through in this patchset and have sun4i-drm be
their first user? Also, does introducing such a change require
identifying duplicates of these functions in each DRM driver's codebase?

Cheers,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-3hIbo6OazuSzo0imDAvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq6AIAACgkQ3cLmz3+f
v9FxJwf+PdxP3ZodZs8vBv8Z1QQFAFeojOikdiAN9dLygmubb26+2xKgQm1x4M1i
HoLRriuIoBNH9g4P4E9z8znL5WSZ9BG17S8HHXy40H9+1aytgl9EHvD4Nq/rUEZu
Gyv8/sZMdG8S6QpCSpMERJojCz23lwAGo29fuPbZVGkA7MWdJeHI/gV7op8NmYxR
Wi14n9N5wskCjLCVfSR13XEcpZkW80NGERH+kTC5p0NrRdLxFlukxzLCgk/UWC1Z
ngiQZQYGI7lNjympvxjcil/2D31p+Bi5PisYIP2wUcjQFBzI9t8bKDqWqNovtL/b
HSyG4egpChWplT9d556/xN+sAtGhwg==
=odXO
-----END PGP SIGNATURE-----

--=-3hIbo6OazuSzo0imDAvC--
