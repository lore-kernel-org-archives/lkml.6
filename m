Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5845FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E4C20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E4C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504435AbeKWXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:36:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59341 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403778AbeKWXgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:36:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 44788207B0; Fri, 23 Nov 2018 13:52:15 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id DD81920791;
        Fri, 23 Nov 2018 13:52:14 +0100 (CET)
Message-ID: <c838df0a552cfc34de426dc2bc61bcff4a858e10.camel@bootlin.com>
Subject: Re: [PATCH v2 31/43] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sean Paul <sean@poorly.run>, nd <nd@arm.com>
Date:   Fri, 23 Nov 2018 13:52:14 +0100
In-Reply-To: <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
         <20181123092515.2511-32-paul.kocialkowski@bootlin.com>
         <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wyKL1j16CiEHA02MKSd3"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wyKL1j16CiEHA02MKSd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-23 at 11:30 +0000, Brian Starkey wrote:
> Hi Paul,
>=20
> On Fri, Nov 23, 2018 at 10:25:03AM +0100, Paul Kocialkowski wrote:
> > This introduces a dedicated ioctl for allocating buffers for the VPU
> > tiling mode. It allows setting up buffers that comply to the hardware
> > alignment requirements, by aligning the stride and height to 32 bytes.
> >=20
> > Only YUV semiplanar and planar formats are allowed by the ioctl, as the
> > hardware does not support the tiling mode for other formats.
>=20
> What's the general feeling about a more generic version of this ioctl?
> There doesn't seem to be anything Allwinner-specific in the ioctl
> arguments.

That's a great suggestion, I am totally in favour of making a generic
fashion of this!

It would also remove the need for a new header dedicated to the sun4i-
drm driver, which was really only motivated by the need for this ioctl.

> It effectively boils down to:
>=20
> 	size =3D driver->get_fb_size_with_modifier(...);
>  	cma_obj =3D drm_gem_cma_create(drm, size);
>=20
> It would look exactly the same for Mali-DP, and probably others too.
> Is it better to try and define something we can share instead of Arm
> adding another nearly identical ioctl() later?
>=20
> I think the minimal viable thing would be to just add modifiers to
> your structure (I put them first because padding):
>=20
>   struct drm_gem_create_with_modifiers {
>   	__u64 modifiers[4];
>   	__u32 height;
>   	__u32 width;
>   	__u32 format;
>   	/* handle, offsets, pitches, size will be returned */
>   	__u32 handle;
>   	__u32 pitches[4];
>   	__u32 offsets[4];
>   	__u64 size;
>   };

That would totally work for me and our usecase.

Cheers,

Paul

> Thanks,
> -Brian
>=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > drivers/gpu/drm/sun4i/sun4i_drv.c | 89 +++++++++++++++++++++++++++++++
> > include/uapi/drm/sun4i_drm.h      | 42 +++++++++++++++
> > 2 files changed, 131 insertions(+)
> > create mode 100644 include/uapi/drm/sun4i_drm.h
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/=
sun4i_drv.c
> > index ccdeae6299eb..5ae32973cf34 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -21,6 +21,7 @@
> > #include <drm/drm_gem_cma_helper.h>
> > #include <drm/drm_fb_helper.h>
> > #include <drm/drm_of.h>
> > +#include <drm/sun4i_drm.h>
> >=20
> > #include "sun4i_drv.h"
> > #include "sun4i_frontend.h"
> > @@ -28,6 +29,92 @@
> > #include "sun4i_tcon.h"
> > #include "sun8i_tcon_top.h"
> >=20
> > +int drm_sun4i_gem_create_tiled(struct drm_device *drm, void *data,
> > +			       struct drm_file *file_priv)
> > +{
> > +	struct drm_sun4i_gem_create_tiled *args =3D data;
> > +	struct drm_gem_cma_object *cma_obj;
> > +	struct drm_gem_object *gem_obj;
> > +	uint32_t luma_stride, chroma_stride;
> > +	uint32_t luma_height, chroma_height;
> > +	uint32_t chroma_width;
> > +	const struct drm_format_info *info;
> > +	int ret;
> > +
> > +	info =3D drm_format_info(args->format);
> > +	if (!info)
> > +		return -EINVAL;
> > +
> > +	/* The tiled output format only applies to non-packed YUV formats. */
> > +	if (!info->is_yuv || info->num_planes =3D=3D 1)
> > +		return -EINVAL;
> > +
> > +	memset(args->pitches, 0, sizeof(args->pitches));
> > +	memset(args->offsets, 0, sizeof(args->offsets));
> > +
> > +	/* Stride and height are aligned to 32 bytes for our tiled format. */
> > +	luma_stride =3D ALIGN(args->width, 32);
> > +	luma_height =3D ALIGN(args->height, 32);
> > +
> > +	chroma_width =3D args->width;
> > +
> > +	/* Semiplanar formats have both U and V data in their chroma plane. *=
/
> > +	if (drm_format_info_is_yuv_semiplanar(info))
> > +		chroma_width *=3D 2;
> > +
> > +	chroma_stride =3D ALIGN(DIV_ROUND_UP(chroma_width, info->hsub), 32);
> > +	chroma_height =3D ALIGN(DIV_ROUND_UP(args->height, info->vsub), 32);
> > +
> > +	if (drm_format_info_is_yuv_semiplanar(info)) {
> > +		args->pitches[0] =3D luma_stride;
> > +		args->pitches[1] =3D chroma_stride;
> > +
> > +		args->offsets[0] =3D 0;
> > +		args->offsets[1] =3D luma_stride * luma_height;
> > +
> > +		args->size =3D luma_stride * luma_height +
> > +			     chroma_stride * chroma_height;
> > +	} else if (drm_format_info_is_yuv_planar(info)) {
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
> > +		/* No support for other formats in tiled mode. */
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
> > +	ret =3D drm_gem_handle_create(file_priv, gem_obj, &args->handle);
> > +	/* drop reference from allocate - handle holds it now. */
> > +	drm_gem_object_put_unlocked(gem_obj);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return PTR_ERR_OR_ZERO(cma_obj);
> > +}
> > +
> > +static const struct drm_ioctl_desc sun4i_drv_ioctls[] =3D {
> > +	DRM_IOCTL_DEF_DRV(SUN4I_GEM_CREATE_TILED, drm_sun4i_gem_create_tiled,
> > +			  DRM_UNLOCKED),
> > +};
> > +
> > static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
> > 				     struct drm_device *drm,
> > 				     struct drm_mode_create_dumb *args)
> > @@ -44,6 +131,8 @@ static struct drm_driver sun4i_drv_driver =3D {
> > 	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIV=
ER_ATOMIC,
> >=20
> > 	/* Generic Operations */
> > +	.ioctls			=3D sun4i_drv_ioctls,
> > +	.num_ioctls		=3D ARRAY_SIZE(sun4i_drv_ioctls),
> > 	.fops			=3D &sun4i_drv_fops,
> > 	.name			=3D "sun4i-drm",
> > 	.desc			=3D "Allwinner sun4i Display Engine",
> > diff --git a/include/uapi/drm/sun4i_drm.h b/include/uapi/drm/sun4i_drm.=
h
> > new file mode 100644
> > index 000000000000..2c77584b057b
> > --- /dev/null
> > +++ b/include/uapi/drm/sun4i_drm.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/* sun4i_drm.h
> > + *
> > + * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com=
>
> > + *
> > + * This program is free software; you can redistribute  it and/or modi=
fy it
> > + * under  the terms of  the GNU General  Public License as published b=
y the
> > + * Free Software Foundation;  either version 2 of the  License, or (at=
 your
> > + * option) any later version.
> > + */
> > +
> > +#ifndef _UAPI_SUN4I_DRM_H_
> > +#define _UAPI_SUN4I_DRM_H_
> > +
> > +#include "drm.h"
> > +
> > +#if defined(__cplusplus)
> > +extern "C" {
> > +#endif
> > +
> > +struct drm_sun4i_gem_create_tiled {
> > +	__u32 height;
> > +	__u32 width;
> > +	__u32 format;
> > +	/* handle, offsets, pitches, size will be returned */
> > +	__u32 handle;
> > +	__u32 pitches[4];
> > +	__u32 offsets[4];
> > +	__u64 size;
> > +};
> > +
> > +#define DRM_SUN4I_GEM_CREATE_TILED	0x00
> > +
> > +#define DRM_IOCTL_SUN4I_GEM_CREATE_TILED \
> > +	DRM_IOWR(DRM_COMMAND_BASE + DRM_SUN4I_GEM_CREATE_TILED, \
> > +		 struct drm_sun4i_gem_create_tiled)
> > +
> > +#if defined(__cplusplus)
> > +}
> > +#endif
> > +
> > +#endif /* _UAPI_SUN4I_DRM_H_ */
> > --=20
> > 2.19.1
> >=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-wyKL1j16CiEHA02MKSd3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlv39/4ACgkQ3cLmz3+f
v9EvJggAhckpy2/VD0havwtKp4EM8UMD08Ze5PBhKOQJ4mb9DgfuUbebff+BConj
oM6BHBslXITxmQi2drXOOFcRzKvLKoFOy23MgLyImniRAV2mkHe6cZ1pdppGfZyx
wHUGQm8KRuZkRhUPhDwm4RXGyH0gm5WUdHhGoQzGPCQm3Cq3PXuZUlVPyi4w1QpL
rGGbPZhzr8jZnMCWYmGTYYev0DPp9dkySKOKedxOgukBQ6uOl4uC20Oelul2ERUW
dthQA4uvJkOeIhEqPQDVkZcHb6fhi5kb2Wo+Oxt0AOXn5MevTykv4LSla6k+HMDJ
oYM4Xqp15N4ljhNV1+sSBqiho57xeQ==
=X2ZE
-----END PGP SIGNATURE-----

--=-wyKL1j16CiEHA02MKSd3--

