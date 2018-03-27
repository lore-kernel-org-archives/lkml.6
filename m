Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeC0IBv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:01:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36111 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeC0IBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:01:49 -0400
Message-ID: <1522137643.1110.4.camel@bootlin.com>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 10:00:43 +0200
In-Reply-To: <20180323095529.5nptn5achjt3esog@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
         <20180323095529.5nptn5achjt3esog@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VXrm6PjPabLMelrs/Uhr"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VXrm6PjPabLMelrs/Uhr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-03-23 at 10:55 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
> > The YUV channel was only disabled in
> > sun4i_backend_update_layer_formats,
> > which is not called when the frontend is selected.
> >=20
> > Thus, creating a layer with a YUV format handled by the backend and
> > then
> > switching to a format that requires the frontend would keep the YUV
> > channel enabled for the layer.
> >=20
> > This explicitly disables the YUV channel for the layer when using
> > the
> > frontend as well. It also sets the relevant interlace bit, which was
> > missing in the frontend path as well.
>=20
> This should be part of a separate patch. Usually, if you write "it
> also does..." at the end of your commit log, it's a pretty good
> indication that it should be another patch :)

I must say, I figured that this part was missing in the frontend path by
chance and couldn't really test the feature, so I'm also tempted to drop
it altogether. What do you think?

Also, is interlacing actually used on any of the video outputs we
support? Perhaps RGB?

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 17 ++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun4i_backend.h |  3 ++-
> >  drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 +-
> >  3 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index e07a33adc51d..b98dafda52f8 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -294,8 +294,10 @@ int sun4i_backend_update_layer_formats(struct
> > sun4i_backend *backend,
> >  }
> > =20
> >  int sun4i_backend_update_layer_frontend(struct sun4i_backend
> > *backend,
> > -					int layer, uint32_t fmt)
> > +					int layer, struct drm_plane
> > *plane,
> > +					uint32_t fmt)
> >  {
> > +	bool interlaced =3D false;
>=20
> There's no need to pass the full drm_plane pointer, you can just pass
> a boolean to tell if it is interlaced or not.

Yes that'll do just as well.

Thanks,

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-VXrm6PjPabLMelrs/Uhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq5+isACgkQ3cLmz3+f
v9ELFgf/btbgiV1vhsojEtIvmKNfqTXxExc4odqFDQipFFE4D28DbdPgsjsXZLjG
T65rJNfHwXuIiATZdd5Bjc0KZpxOzfYxrPrb/W91V1/3rtLkWE2U11JDmz9eGPIF
vDml0b+ZhAKbc0t9KwAVgAfa6JzhAb2ciKJ7HEPzAGvyq3oLgREs7hp8QtqwC3Mt
lgUG3Wz8KOZQ6gm4GoSa6kxReWq3L2Vr0uX/lYeh1Ho1cuwsBhp5M7xh14vCOfoz
lSy/zb8hEiXDG8m7UMkObdx4G3cP6YVonfYLGeNzAP6NmPsQ01TCq2hroSNlS1Q/
vJk5QtG/pXqw+Z3oFb1pF/OKzbqdnA==
=nJpH
-----END PGP SIGNATURE-----

--=-VXrm6PjPabLMelrs/Uhr--
