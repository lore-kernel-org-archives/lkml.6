Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD63DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F18420693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F18420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeGRI4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:56:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeGRI4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:56:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A37B120798; Wed, 18 Jul 2018 10:19:33 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6185120720;
        Wed, 18 Jul 2018 10:19:33 +0200 (CEST)
Message-ID: <fa741d96804aec4c2caa40b14eb01081b8b1c954.camel@bootlin.com>
Subject: Re: [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for lowest
 plane alpha support
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com
Date:   Wed, 18 Jul 2018 10:19:33 +0200
In-Reply-To: <20180717122547.d5tkizuuj6676ilc@flea.home>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
         <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
         <20180717122547.d5tkizuuj6676ilc@flea.home>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zpv3SOCEIkNFr5Ek0wTc"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zpv3SOCEIkNFr5Ek0wTc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2018-07-17 at 14:25 +0200, Maxime Ripard wrote:
> On Tue, Jul 17, 2018 at 10:52:30AM +0200, Paul Kocialkowski wrote:
> > Not all sunxi platforms with the first version of the Display Engine
> > support an alpha component on the plane with the lowest z position
> > (as in: lowest z-pos), that gets blended with the background color.
> >=20
> > In particular, the A13 is known to have this limitation. However, it wa=
s
> > recently discovered that the A20 and A33 are capable of having alpha on
> > their lowest plane.
> >=20
> > Thus, this introduces a specific quirk to indicate such support,
> > per-platform. Since this was not tested on sun4i and sun6i platforms, a
> > conservative approach is kept and this feature is not supported.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/su=
n4i/sun4i_backend.c
> > index a3cc398d4d80..cdc4a8a91ea2 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -35,6 +35,8 @@
> >  struct sun4i_backend_quirks {
> >  	/* backend <-> TCON muxing selection done in backend */
> >  	bool needs_output_muxing;
> > +	/* alpha at the lowest z position is not always supported */
> > +	bool supports_lowest_plane_alpha;
> >  };
> > =20
> >  static void sun4i_backend_apply_color_correction(struct sunxi_engine *=
engine)
> > @@ -484,6 +486,7 @@ static void sun4i_backend_atomic_begin(struct sunxi=
_engine *engine,
> >  static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
> >  				      struct drm_crtc_state *crtc_state)
> >  {
> > +	struct sun4i_backend *backend =3D engine_to_sun4i_backend(engine);
> >  	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] =3D { =
0 };
>=20
> Your new variable should be here.

Ok, will do in v2.

> >  	struct drm_atomic_state *state =3D crtc_state->state;
> >  	struct drm_device *drm =3D state->dev;
> > @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_=
engine *engine,
> >  	}
> > =20
> >  	/* We can't have an alpha plane at the lowest position */
> > -	if (plane_states[0]->fb->format->has_alpha ||
> > -	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE))
> > +	if ((plane_states[0]->fb->format->has_alpha ||
> > +	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)) &&
> > +	    !backend->quirks->supports_lowest_plane_alpha)
> >  		return -EINVAL;
>=20
> This only partially does the job. This only allows to have an alpha
> plane at the lowest position, but the fact that the alpha works at the
> lowest position also means you can have two alpha planes now, and you
> didn't change that check.

You're right, the number of available planes with alpha has to be
changed accordingly. Will do in v2.

> The pipe allocation algorithm would also need to be checked.

=46rom my understanding, the limitation on the number of alpha planes only
takes effect after pipe allocation, so this change doesn't require
modifying the allocation algorithm.

Cheers and thanks for the review,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-zpv3SOCEIkNFr5Ek0wTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAltO+BUACgkQ3cLmz3+f
v9ExWgf+L7gFsIO9FwpYstc4j2bKaa5AIX4GxX9Ls+aud3l0+BjKvmqRXf2KXM8g
o4l3nCgHOWoGbxT7SA/vk20DRIu7irGODlsgJzUjuFdZVqu6urPfI7nUlF4ummxC
l5Xu5XmCZmkAi8mc6+lFgNHKr8YX0JJTwUkdKKB97Vz7CPz5YoQZ/QxjeryFzZ71
QPJDUfT1Bd0KRF4MP+0jv495dFctjPKUElIzZsYLGXGEkdKtX2TfHMGIX++NeZwd
IDhaKGEb3FYJxZL7b6XSFYbupzWYG+6MQ0i0B6cnWJ2xYrmGfrM5KrAc5sWWte8/
9b0NfyNGFURlh9B9gJ7qUGCTktfJCg==
=OfnP
-----END PGP SIGNATURE-----

--=-zpv3SOCEIkNFr5Ek0wTc--

