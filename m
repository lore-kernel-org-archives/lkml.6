Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A2FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE03205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE03205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJPVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:47:56 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:38654 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJPVr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:47:56 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 97712BFE9C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:57:19 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 183CEC1036; Tue, 16 Oct 2018 15:57:19 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 8E38FC102F;
        Tue, 16 Oct 2018 15:57:09 +0200 (CEST)
Message-ID: <23f66de8a3e55cba253b89328f0f268a7c4df29d.camel@paulk.fr>
Subject: Re: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date:   Tue, 16 Oct 2018 15:57:41 +0200
In-Reply-To: <20180323100659.vojpyt7eazioevdj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
         <20180323100659.vojpyt7eazioevdj@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ccw5O2IjhWAC8Q6cOR/7"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ccw5O2IjhWAC8Q6cOR/7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 23 mars 2018 =C3=A0 11:06 +0100, Maxime Ripard a =C3=A9crit :
> On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the frontend supports a specific format, an
> > explicit list and a related helper are introduced.
> >=20
> > They are then used to determine whether the frontend can actually suppo=
rt
> > the requested format when it was selected to be used.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44 ++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
> >  3 files changed, 50 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/su=
n4i/sun4i_backend.c
> > index 7703ba989743..1fad0714c70e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct sunxi=
_engine *engine,
> >  		struct drm_format_name_buf format_name;
> > =20
> >  		if (sun4i_backend_plane_uses_frontend(plane_state)) {
> > +			if (!sun4i_frontend_format_is_supported(fb->format->format)) {
> > +				DRM_DEBUG_DRIVER("Frontend plane check failed\n");
> > +				return -EINVAL;
> > +			}
> > +
>=20
> So you're checking if the frontend doesn't support it and if the
> backend doesn't support it. Who supports it then? :)
>=20
> Like I was saying, this should be moved to the previous patch, within
> sun4i_backend_plane_uses_frontend.

You're right, this isn't the right place to put it.
sun4i_backend_plane_uses_frontend should definitely guarantee that the
format is supported.

> > +static const uint32_t sun4i_frontend_formats[] =3D {
> > +	/* RGB */
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_BGRX8888,
> > +	/* YUV444 */
> > +	DRM_FORMAT_YUV444,
> > +	DRM_FORMAT_YVU444,
> > +	/* YUV422 */
> > +	DRM_FORMAT_YUYV,
> > +	DRM_FORMAT_YVYU,
> > +	DRM_FORMAT_UYVY,
> > +	DRM_FORMAT_VYUY,
> > +	DRM_FORMAT_NV16,
> > +	DRM_FORMAT_NV61,
> > +	DRM_FORMAT_YUV422,
> > +	DRM_FORMAT_YVU422,
> > +	/* YUV420 */
> > +	DRM_FORMAT_NV12,
> > +	DRM_FORMAT_NV21,
> > +	DRM_FORMAT_YUV420,
> > +	DRM_FORMAT_YVU420,
> > +	/* YUV411 */
> > +	DRM_FORMAT_YUV411,
> > +	DRM_FORMAT_YVU411,
> > +};
>=20
> I think this list should reflect what the driver currently supports,
> not what the hardware supports.

Agreed, this should be updated with the follow-up patch that adds YUV
support.

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-ccw5O2IjhWAC8Q6cOR/7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvF7lUACgkQhP3B6o/u
lQxHKg/9EE9HsCWeYxoBsubeXu6sLBRG5Hkrh/op4WBc+wNotPE6Kgs9XQINWGpq
AUKG2VShYqUseW8bes0v0Vv2h5CIW0zgoudnT+HKuqg3RtxgcMib6ZGea8swUqCA
cBBlzEDDMUvyQ9/6JdDAREGmXrSPAkI8vkCtCGQzLmw9yYgtcYG2aBFqie/hUQGn
REob+cOCZA4ATOev8TVV0HJoElK5BwMGxLdcZMl3HndiX0WcpJDbMLtRCZQptRN2
2eovzGpoMENMOxQwUBp+TZP85dlq0FbJFZWuGB9TcXKIl1zWzT2nILfM/ieTDuR2
KYRMBRfy496Z0/k36V03ec9QPkz9x7dTcWlcNSDXtcVF8tDX6i8Wwof3EYcLGScM
KtMhqoCdsbsX454LKpZbneUycJ/a7VoLc5uy3k9UZ/GG7PQYmdsA1PVSwc+QCEPX
D0jpCdn757DDM6XjEZprhtUSAXfHqWF0u5+gIY+hvLRmQvssMMt8y5dqJpb2Ffqh
76iQdKs1JYzFRIRLgBdKKT9HTPuSaWLMR6jD3WmPc68JOiElsgP5bDKGYg0TbCVH
iTAdQ5s4AWkVgzLBjeh/pIAJS2K+Ufw7eB1kdofjrEuqJgW9k+gzi1ap4I/KWvdL
9h0Ih8X/41SVHqW6BxhEGPUYnhavNHnloYJwCd1swxYSu6kVLtg=
=Hfjb
-----END PGP SIGNATURE-----

--=-ccw5O2IjhWAC8Q6cOR/7--

