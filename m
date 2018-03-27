Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeC0In6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:43:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37798 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeC0Imo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:42:44 -0400
Message-ID: <1522140098.1110.40.camel@bootlin.com>
Subject: Re: [PATCH 09/10] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:41:38 +0200
In-Reply-To: <20180323104856.qo7w376xr3gcznmm@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-10-paul.kocialkowski@bootlin.com>
         <20180323104856.qo7w376xr3gcznmm@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3OjRB9vRt7hXtHXTu7nI"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3OjRB9vRt7hXtHXTu7nI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-03-23 at 11:48 +0100, Maxime Ripard wrote:
> Hi,
>=20
> On Wed, Mar 21, 2018 at 04:29:03PM +0100, Paul Kocialkowski wrote:
> > This introduces a dedicated ioctl for allocating tiled buffers in
> > the
> > Allwinner MB32 format, that comes with a handful of specific
> > constraints. In particular, the stride of the buffers is expected to
> > be
> > aligned to 32 bytes.
>=20
> You should have more details here. What are those constraints, what is
> the expected user? Can you use it only for the scanout, like the dumb
> buffers, or also for the other devices in the system?

Agreed.

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 96
> > +++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_drv.h |  2 +
> >  include/uapi/drm/sun4i_drm.h      | 42 +++++++++++++++++
> >  3 files changed, 140 insertions(+)
> >  create mode 100644 include/uapi/drm/sun4i_drm.h
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > index d374bb61c565..e9cb03d34b44 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -21,11 +21,18 @@
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_of.h>
> > +#include <drm/sun4i_drm.h>
> > =20
> >  #include "sun4i_drv.h"
> >  #include "sun4i_frontend.h"
> >  #include "sun4i_framebuffer.h"
> >  #include "sun4i_tcon.h"
> > +#include "sun4i_format.h"
> > +
> > +static const struct drm_ioctl_desc sun4i_drv_ioctls[] =3D {
> > +	DRM_IOCTL_DEF_DRV(SUN4I_GEM_CREATE_TILED,
> > drm_sun4i_gem_create_tiled,
> > +			  DRM_AUTH | DRM_RENDER_ALLOW),
>=20
> Why do you need DRM_RENDER_ALLOW? as far as I know, this is only
> useful for render-nodes.

It's probably undeeded indeed.

> > +};
> > =20
> >  DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
> > =20
> > @@ -34,6 +41,8 @@ static struct drm_driver sun4i_drv_driver =3D {
> > =20
> >  	/* Generic Operations */
> >  	.lastclose		=3D drm_fb_helper_lastclose,
> > +	.ioctls			=3D sun4i_drv_ioctls,
> > +	.num_ioctls		=3D ARRAY_SIZE(sun4i_drv_ioctls),
> >  	.fops			=3D &sun4i_drv_fops,
> >  	.name			=3D "sun4i-drm",
> >  	.desc			=3D "Allwinner sun4i Display
> > Engine",
> > @@ -69,6 +78,93 @@ int drm_sun4i_gem_dumb_create(struct drm_file
> > *file_priv,
> >  	return drm_gem_cma_dumb_create_internal(file_priv, drm,
> > args);
> >  }
> > =20
> > +int drm_sun4i_gem_create_tiled(struct drm_device *drm, void *data,
> > +			       struct drm_file *file_priv)
> > +{
> > +	struct drm_sun4i_gem_create_tiled *args =3D data;
> > +	struct drm_gem_cma_object *cma_obj;
> > +	struct drm_gem_object *gem_obj;
> > +	uint32_t luma_stride, chroma_stride;
> > +	uint32_t luma_height, chroma_height;
> > +	int ret;
> > +
> > +	if (!sun4i_format_supports_tiling(args->format))
> > +		return -EINVAL;
> > +
> > +	memset(args->pitches, 0, sizeof(args->pitches));
> > +	memset(args->offsets, 0, sizeof(args->offsets));
> > +
> > +	/* Stride and height are aligned to 32 bytes for MB32 tiled
> > format. */
> > +	luma_stride =3D ALIGN(args->width, 32);
> > +	luma_height =3D ALIGN(args->height, 32);
> > +
> > +	if (sun4i_format_is_semiplanar(args->format)) {
> > +		chroma_stride =3D luma_stride;
> > +
> > +		if (sun4i_format_is_yuv420(args->format))
> > +			chroma_height =3D ALIGN(DIV_ROUND_UP(args-
> > >height, 2), 32);
> > +		else if (sun4i_format_is_yuv422(args->format))
> > +			chroma_height =3D luma_height;
> > +		else
> > +			return -EINVAL;
> > +
> > +		args->pitches[0] =3D luma_stride;
> > +		args->pitches[1] =3D chroma_stride;
> > +
> > +		args->offsets[0] =3D 0;
> > +		args->offsets[1] =3D luma_stride * luma_height;
> > +
> > +		args->size =3D luma_stride * luma_height +
> > +			     chroma_stride * chroma_height;
> > +	} else if (sun4i_format_is_planar(args->format)) {
> > +		if (sun4i_format_is_yuv411(args->format)) {
> > +			chroma_stride =3D ALIGN(DIV_ROUND_UP(args-
> > >width, 4), 32);
> > +			chroma_height =3D luma_height;
> > +		} if (sun4i_format_is_yuv420(args->format)) {
> > +			chroma_stride =3D ALIGN(DIV_ROUND_UP(args-
> > >width, 2), 32);
> > +			chroma_height =3D ALIGN(DIV_ROUND_UP(args-
> > >height, 2), 32);
> > +		} else if (sun4i_format_is_yuv422(args->format)) {
> > +			chroma_stride =3D ALIGN(DIV_ROUND_UP(args-
> > >width, 2), 32);
> > +			chroma_height =3D luma_height;
> > +		} else {
> > +			return -EINVAL;
> > +		}
> > +
> > +		args->pitches[0] =3D luma_stride;
> > +		args->pitches[1] =3D chroma_stride;
> > +		args->pitches[2] =3D chroma_stride;
> > +
> > +		args->offsets[0] =3D 0;
> > +		args->offsets[1] =3D luma_stride * luma_height;
> > +		args->offsets[2] =3D luma_stride * luma_height +
> > +				   chroma_stride * chroma_height;
> > +
> > +		args->size =3D luma_stride * luma_height +
> > +			     chroma_stride * chroma_height * 2;
> > +	} else {
> > +		/* No support for packed formats in tiled mode. */
> > +		return -EINVAL;
> > +	}
> > +
> > +	cma_obj =3D drm_gem_cma_create(drm, args->size);
> > +	if (IS_ERR(cma_obj))
> > +		return PTR_ERR(cma_obj);
> > +
> > +	gem_obj =3D &cma_obj->base;
> > +
> > +	/*
> > +	 * allocate a id of idr table where the obj is registered
> > +	 * and handle has the id what user can see.
> > +	 */
> > +	ret =3D drm_gem_handle_create(file_priv, gem_obj, &args-
> > >handle);
> > +	/* drop reference from allocate - handle holds it now. */
> > +	drm_gem_object_put_unlocked(gem_obj);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return PTR_ERR_OR_ZERO(cma_obj);
> > +}
> > +
> >  static void sun4i_remove_framebuffers(void)
> >  {
> >  	struct apertures_struct *ap;
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h
> > b/drivers/gpu/drm/sun4i/sun4i_drv.h
> > index 47969711a889..308ff4bfcdd5 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.h
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
> > @@ -26,5 +26,7 @@ struct sun4i_drv {
> >  int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
> >  			      struct drm_device *drm,
> >  			      struct drm_mode_create_dumb *args);
> > +int drm_sun4i_gem_create_tiled(struct drm_device *dev, void *data,
> > +			       struct drm_file *file_priv);
>=20
> Do you need it to be non-static, and part of the header as well?

Here as well, I just find that it looks more readable that way, below
the drm driver structure definition instead of above it.

> I'll let the DRM-misc maintainers comment on the validity of the new
> ioctl.

Cheers,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-3OjRB9vRt7hXtHXTu7nI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq6A8IACgkQ3cLmz3+f
v9HcCAf/Zft0yw0Qib9nvZwlqFJTq8dZLlE8bBt3YsA0bn0CVp3A81iCc9zrZcl3
xPDwkFyX/layT3FtKbQVydOmUBwbkYiEwS+dBFPSSGhRPZRI/x0zYYrSUxrIkSJs
/f18g/4NuXgFvFXihp/LpPBQoCau/4RCG7ADNJiBa689qrwhu0zktzxe84Umz3qY
ijsPoefFuy+gfHIGhDSpUeK3nmXlQqP1eNSLvutenhLlcDXvxHT4n7cknUWlZqXQ
wmvb6h8oYwIlNzqMokAHYSDJSGaTIYxqKU/TZpQLRzc/4b4HJGcxMQMtJbasGrRm
5p4DM5rxWmekXBOX1AImL5ngLy0FfA==
=utnW
-----END PGP SIGNATURE-----

--=-3OjRB9vRt7hXtHXTu7nI--
