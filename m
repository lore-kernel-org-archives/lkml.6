Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeC0IZY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:25:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37133 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbeC0IZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:25:22 -0400
Message-ID: <1522139057.1110.24.camel@bootlin.com>
Subject: Re: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:24:17 +0200
In-Reply-To: <20180323100659.vojpyt7eazioevdj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
         <20180323100659.vojpyt7eazioevdj@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7bcErZJfZH02xpdLfTT9"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7bcErZJfZH02xpdLfTT9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-03-23 at 11:06 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the frontend supports a specific format,
> > an
> > explicit list and a related helper are introduced.
> >=20
> > They are then used to determine whether the frontend can actually
> > support
> > the requested format when it was selected to be used.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44
> > ++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
> >  3 files changed, 50 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 7703ba989743..1fad0714c70e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct
> > sunxi_engine *engine,
> >  		struct drm_format_name_buf format_name;
> > =20
> >  		if (sun4i_backend_plane_uses_frontend(plane_state))
> > {
> > +			if (!sun4i_frontend_format_is_supported(fb-
> > >format->format)) {
> > +				DRM_DEBUG_DRIVER("Frontend plane
> > check failed\n");
> > +				return -EINVAL;
> > +			}
> > +
>=20
> So you're checking if the frontend doesn't support it and if the
> backend doesn't support it. Who supports it then? :)

That's the case case where the format is not supported by either of the
hardware blocks. For instance, requesting ARGB with tiling will fail,
although ARGB without tiling will work. It seems that modetest assumes
that modifiers only apply to YUV (in which case there are no unsupported
cases), but I think userspace might still request RGB+tiling
combinations. I don't currently see a way to report to which format the
tiling applies (thus we have to expect that it can come with any of the
supported formats).

> Like I was saying, this should be moved to the previous patch, within
> sun4i_backend_plane_uses_frontend.

If we get both tests (no backend support and frontend support) into one
function, we cannot detect that the format is actually unsupported and
return an error in the atomic check.

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

This list is not indended to reflect what the driver supports, but only
what the backend can support (to correctly select whether a
format/modifier couple should go to the frontend or backend)!

The complete list that is reported to userspace for global driver
support is sun4i_layer_formats in sun4i_layer.c.

Cheers,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-7bcErZJfZH02xpdLfTT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq5/7EACgkQ3cLmz3+f
v9G2cQf+K/MtPvMYYtQnAsTI0qX+WQ3GTGebUCdsU7VipBhuW8TPUTGRzAiuV7+T
le0wz5L7gQ8Yk+Og9zGN9RbNBJ26YcITtBjp27uiSJL3Lwb4W7VHDWWw/HYkf8JP
oad02Hmmn67S5esGhwemJlh25W2XubJKIJQAPBz4xtPo4ODVEw2ecYB6qd4HJTPF
V/On/9M7qwVM6CMbFybMJ0zn+/qbZGyDLYh7eTPk1ZQgubK3M0VqEdYRqf5Shtpm
12WqoXjn4QWn9+/P0W6I/SA5icFVWdDBmwVE9vQHAHrY4Bl/x+FvkUoVmLb0zHup
rfMPx/vwTsjyMSL3dxLWkQjXM3pxaw==
=kBmk
-----END PGP SIGNATURE-----

--=-7bcErZJfZH02xpdLfTT9--
