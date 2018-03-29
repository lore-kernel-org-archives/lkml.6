Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeC2JDY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:03:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33975 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeC2JDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:03:23 -0400
Date: Thu, 29 Mar 2018 11:03:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
Message-ID: <20180329090321.3s3xaizybekqsbq5@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
 <20180323100659.vojpyt7eazioevdj@flea>
 <1522139057.1110.24.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rjp3jkc4ffe6ng6"
Content-Disposition: inline
In-Reply-To: <1522139057.1110.24.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rjp3jkc4ffe6ng6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:24:17AM +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> On Fri, 2018-03-23 at 11:06 +0100, Maxime Ripard wrote:
> > On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> > > In order to check whether the frontend supports a specific format,
> > > an
> > > explicit list and a related helper are introduced.
> > >=20
> > > They are then used to determine whether the frontend can actually
> > > support
> > > the requested format when it was selected to be used.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
> > >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44
> > > ++++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
> > >  3 files changed, 50 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > index 7703ba989743..1fad0714c70e 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct
> > > sunxi_engine *engine,
> > >  		struct drm_format_name_buf format_name;
> > > =20
> > >  		if (sun4i_backend_plane_uses_frontend(plane_state))
> > > {
> > > +			if (!sun4i_frontend_format_is_supported(fb-
> > > >format->format)) {
> > > +				DRM_DEBUG_DRIVER("Frontend plane
> > > check failed\n");
> > > +				return -EINVAL;
> > > +			}
> > > +
> >=20
> > So you're checking if the frontend doesn't support it and if the
> > backend doesn't support it. Who supports it then? :)
>=20
> That's the case case where the format is not supported by either of the
> hardware blocks. For instance, requesting ARGB with tiling will fail,
> although ARGB without tiling will work. It seems that modetest assumes
> that modifiers only apply to YUV (in which case there are no unsupported
> cases), but I think userspace might still request RGB+tiling
> combinations. I don't currently see a way to report to which format the
> tiling applies (thus we have to expect that it can come with any of the
> supported formats).

Then I guess this is a check that could be moved out of that
condition, or even as part of the generic side of atomic_check. That
looks not really specific to the driver itself.

> > Like I was saying, this should be moved to the previous patch, within
> > sun4i_backend_plane_uses_frontend.
>=20
> If we get both tests (no backend support and frontend support) into one
> function, we cannot detect that the format is actually unsupported and
> return an error in the atomic check.

This is already covered by drm_atomic_plane_check:
https://elixir.bootlin.com/linux/v4.16-rc7/source/drivers/gpu/drm/drm_atomi=
c.c#L884

So we'll only end up being called here if we have a format we support.

> > > +static const uint32_t sun4i_frontend_formats[] =3D {
> > > +	/* RGB */
> > > +	DRM_FORMAT_XRGB8888,
> > > +	DRM_FORMAT_BGRX8888,
> > > +	/* YUV444 */
> > > +	DRM_FORMAT_YUV444,
> > > +	DRM_FORMAT_YVU444,
> > > +	/* YUV422 */
> > > +	DRM_FORMAT_YUYV,
> > > +	DRM_FORMAT_YVYU,
> > > +	DRM_FORMAT_UYVY,
> > > +	DRM_FORMAT_VYUY,
> > > +	DRM_FORMAT_NV16,
> > > +	DRM_FORMAT_NV61,
> > > +	DRM_FORMAT_YUV422,
> > > +	DRM_FORMAT_YVU422,
> > > +	/* YUV420 */
> > > +	DRM_FORMAT_NV12,
> > > +	DRM_FORMAT_NV21,
> > > +	DRM_FORMAT_YUV420,
> > > +	DRM_FORMAT_YVU420,
> > > +	/* YUV411 */
> > > +	DRM_FORMAT_YUV411,
> > > +	DRM_FORMAT_YVU411,
> > > +};
> >=20
> > I think this list should reflect what the driver currently supports,
> > not what the hardware supports.
>=20
> This list is not indended to reflect what the driver supports, but only
> what the backend can support (to correctly select whether a
> format/modifier couple should go to the frontend or backend)!

I know, and it's not my point. The whole point is that you don't need
that full list in the first place to achieve what you want to achieve
with this patch.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3rjp3jkc4ffe6ng6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq8q9gACgkQ0rTAlCFN
r3QafA//TE7B81PdUpmBJf6RrM4f7/FimTBUH8jDfrlcZBo57fO880oK1uHLf6cr
m+6T8ZPHhmZptBCrYfXzmlAEOYBX7p816ui/kRfWwkoVCHF+MwCHLBecOlCEZuTJ
LItJh/pczJg+NPnkC4xWWs1V1SY17pA6OOJ+Sq2xtDZmgcn84D3ULNJUXDB3e9Ac
SeSxulIfIDfY8k1ZvAavjPSPpSv1oIYj7a13MmpXKBeYpD2l6h9m+mDV6njCE8ib
U98oftoWzyNbsFQxm1F7W/lSz06WJCpZdxJcdey0k0/jEiaBVp/8Lg1GyLX5uRUF
MDq6+5JqiC1KW6kk4AXeeppaB6Eth44ld+K83/GyaP9CGQVv66Q3xZMqPCPecjgS
PUBz5feCo/0y8/7wr231aT1wOcZg4hkF/RGLgkExhuX4Wd+T1twXZlLZh5JKLQp7
hFk3tMe0v9WgSEJUFsRVV6Ycvo9YtwBfVA9w/DlTs56PckJYrNGMQwkGJrN7DU3m
YFVR17U2FsuwjDsJi6zFpxX2NtuJFsEchE6MAireVb9bj71Z9KA38EA5IkT4tAeo
13fRc7rWwV/w2A3paChNPeMG39/ZnNWGRTiqV7f8b51SLbf477fYB1KktJhVnjx5
EULEO3jhm+AC5UOq57vjUgi0N/AZg1S+DVdWV3fdKljpRZamI5Y=
=cn/P
-----END PGP SIGNATURE-----

--3rjp3jkc4ffe6ng6--
