Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B42086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5B42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeKZT47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:56:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZT47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:56:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BFA9520D31; Mon, 26 Nov 2018 10:03:28 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5FB7320701;
        Mon, 26 Nov 2018 10:03:18 +0100 (CET)
Message-ID: <8598fbb06768c0701571d43f4148a3891ad8ff12.camel@bootlin.com>
Subject: Re: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking
 YUV sub-sampling
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Ayan Halder <Ayan.Halder@arm.com>
Cc:     nd <nd@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 26 Nov 2018 10:03:17 +0100
In-Reply-To: <20181123172308.GR9144@intel.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
         <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
         <20181123165532.GA22326@arm.com> <20181123172308.GR9144@intel.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bKXIetVKq/YjlhcXtyi8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bKXIetVKq/YjlhcXtyi8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-23 at 19:23 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Fri, Nov 23, 2018 at 04:55:33PM +0000, Ayan Halder wrote:
> > On Fri, Nov 23, 2018 at 10:24:44AM +0100, Paul Kocialkowski wrote:
> >=20
> > Hi Paul,
> >=20
> > > This introduces new format helpers that use the previously-introduced
> > > format info helpers for checking YUV sub-sampling.
> > >=20
> > > Only the format fourcc is required by these helpers and the formats a=
re
> > > iterated from the list.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/drm_fourcc.c | 105 +++++++++++++++++++++++++++++++++=
++
> > >  include/drm/drm_fourcc.h     |   5 ++
> > >  2 files changed, 110 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourc=
c.c
> > > index b56e773f9f63..6d395c586ad5 100644
> > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > @@ -492,6 +492,111 @@ bool drm_format_is_yuv_planar(uint32_t format)
> > >  }
> > >  EXPORT_SYMBOL(drm_format_is_yuv_planar);
> > > =20
> > > +/**
> > > + * drm_format_is_yuv_sampling_410 - check that the format is a YUV f=
ormat with
> > > + * 4:1:0 sub-sampling
> > > + * @format: pixel format
> > > + *
> > > + * Returns:
> > > + * A boolean indicating whether the format is a YUV format with 4:1:=
0
> > > + * sub-sampling.
> > > + */
> > > +bool drm_format_is_yuv_sampling_410(uint32_t format)
> > > +{
> > > +	const struct drm_format_info *info;
> > > +
> > > +	info =3D drm_format_info(format);
> > > +	if (!info)
> > > +		return false;
>=20
> Looks like you're doing a lot of drm_format_info(fb->format->format),
> which doesn't make sense. Not to mention that each lookup is a linear
> search so the costs may start to add up.
>=20
> Unless there's a really good reason I'd rather we try to remove all
> the current helpers that do these lookups, and not add any more.

I totally agree that we should be passing the drm_format_info structure
onwards to all the driver helpers so we don't have to do the lookup each
time.

I thought it was still somewhat acceptable to have lookup fashions of
these format helpers, but I am totally in favor of getting rid of them
(and other lookup helpers eventually).

I'll remove the lookup YUV format helpers and convert this series to
passing the full drm_format_info everywhere needed.

Cheers,

Paul

> > > +
> > > +	return drm_format_info_is_yuv_sampling_410(info);
> > > +}
> > > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_410);
> > > +
> > > +/**
> > > + * drm_format_is_yuv_sampling_411 - check that the format is a YUV f=
ormat with
> > > + * 4:1:1 sub-sampling
> > > + * @format: pixel format
> > > + *
> > > + * Returns:
> > > + * A boolean indicating whether the format is a YUV format with 4:1:=
1
> > > + * sub-sampling.
> > > + */
> > > +bool drm_format_is_yuv_sampling_411(uint32_t format)
> > > +{
> > > +	const struct drm_format_info *info;
> > > +
> > > +	info =3D drm_format_info(format);
> > > +	if (!info)
> > > +		return false;
> > > +
> > > +	return drm_format_info_is_yuv_sampling_411(info);
> > > +}
> > > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_411);
> > > +
> > > +/**
> > > + * drm_format_is_yuv_sampling_420 - check that the format is a YUV f=
ormat with
> > > + * 4:2:0 sub-sampling
> > > + * @format: pixel format
> > > + *
> > > + * Returns:
> > > + * A boolean indicating whether the format is a YUV format with 4:2:=
0
> > > + * sub-sampling.
> > > + */
> > > +bool drm_format_is_yuv_sampling_420(uint32_t format)
> > > +{
> > > +	const struct drm_format_info *info;
> > > +
> > > +	info =3D drm_format_info(format);
> > > +	if (!info)
> > > +		return false;
> > > +
> > > +	return drm_format_info_is_yuv_sampling_420(info);
> > > +}
> > > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_420);
> > > +
> > > +/**
> > > + * drm_format_is_yuv_sampling_422 - check that the format is a YUV f=
ormat with
> > > + * 4:2:2 sub-sampling
> > > + * @format: pixel format
> > > + *
> > > + * Returns:
> > > + * A boolean indicating whether the format is a YUV format with 4:2:=
2
> > > + * sub-sampling.
> > > + */
> > > +bool drm_format_is_yuv_sampling_422(uint32_t format)
> > > +{
> > > +	const struct drm_format_info *info;
> > > +
> > > +	info =3D drm_format_info(format);
> > > +	if (!info)
> > > +		return false;
> > > +
> > > +	return drm_format_info_is_yuv_sampling_422(info);
> > > +}
> > > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_422);
> > > +
> > > +/**
> > > + * drm_format_is_yuv_sampling_444 - check that the format is a YUV f=
ormat with
> > > + * 4:4:4 sub-sampling
> > > + * @format: pixel format
> > > + *
> > > + * Returns:
> > > + * A boolean indicating whether the format is a YUV format with 4:4:=
4
> > > + * sub-sampling.
> > > + */
> > > +bool drm_format_is_yuv_sampling_444(uint32_t format)
> > > +{
> > > +	const struct drm_format_info *info;
> > > +
> > > +	info =3D drm_format_info(format);
> > > +	if (!info)
> > > +		return false;
> > > +
> > > +	return drm_format_info_is_yuv_sampling_444(info);
> > > +}
> > > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_444);
> > > +
> > >  /**
> > >   * drm_format_info_block_width - width in pixels of block.
> > >   * @info: pixel format info
> > > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> > > index d170b7b323f7..cf082d8b6ad4 100644
> > > --- a/include/drm/drm_fourcc.h
> > > +++ b/include/drm/drm_fourcc.h
> > > @@ -278,6 +278,11 @@ bool drm_format_is_yuv(uint32_t format);
> > >  bool drm_format_is_yuv_packed(uint32_t format);
> > >  bool drm_format_is_yuv_semiplanar(uint32_t format);
> > >  bool drm_format_is_yuv_planar(uint32_t format);
> > > +bool drm_format_is_yuv_sampling_410(uint32_t format);
> > > +bool drm_format_is_yuv_sampling_411(uint32_t format);
> > > +bool drm_format_is_yuv_sampling_420(uint32_t format);
> > > +bool drm_format_is_yuv_sampling_422(uint32_t format);
> > > +bool drm_format_is_yuv_sampling_444(uint32_t format);
> > >  unsigned int drm_format_info_block_width(const struct drm_format_inf=
o *info,
> > >  					 int plane);
> > >  unsigned int drm_format_info_block_height(const struct drm_format_in=
fo *info,
> > > --=20
> > > 2.19.1
> > >=20
> > From patches [PATCH v2 08/43] till [PATCH v2 12/43], looks good to me.
> >=20
> > How about clubbing all the drm_format_helper functions together in a
> > separate file (call it drm_fourcc_helper.c)? This way, we could
> > keep the __drm_format_info[] only drm_fourcc.c.
> >=20
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-bKXIetVKq/YjlhcXtyi8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlv7ttUACgkQ3cLmz3+f
v9HsNQf+Ify8eWnG0z5Uj7O1DH0NRASlhAaJofz2laZpSVEix1IRM0QVHv825Rdu
BnYCYAo11Z1OM6zFXJtQcyp0kXnlTv/Vtf/UT2c5/BKYRI2uWrzCNMqz9IJGJzXG
QbaDQRReN6ylkl+r/wSSW0Ny6aXSUUit/5WO2BeATZ6nywzmIMCBLwsR5m9Ngb/L
1cB1QpKlyKGZhGxhTE3ks24SE2QfL7b8QX5bOuInZFvVZWEHy0KhFex1crbxUgZp
9tB9L7FJiksLJSF3rZh7tBbzZHQLPNEmu/VWOPzFhyuRUNBmnD21RVuhxh0nQV6D
bvJ3azrrONmyAZhO1M01vSB2Qrh5iw==
=PKmP
-----END PGP SIGNATURE-----

--=-bKXIetVKq/YjlhcXtyi8--

