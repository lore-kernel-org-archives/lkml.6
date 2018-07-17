Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C979ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C060320C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C060320C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGQM6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:58:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37673 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeGQM6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:58:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7B40B2093C; Tue, 17 Jul 2018 14:25:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48CCB206ED;
        Tue, 17 Jul 2018 14:25:47 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:25:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
Message-ID: <20180717122547.d5tkizuuj6676ilc@flea.home>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
 <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cmpifpotgosgerup"
Content-Disposition: inline
In-Reply-To: <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmpifpotgosgerup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 10:52:30AM +0200, Paul Kocialkowski wrote:
> Not all sunxi platforms with the first version of the Display Engine
> support an alpha component on the plane with the lowest z position
> (as in: lowest z-pos), that gets blended with the background color.
>=20
> In particular, the A13 is known to have this limitation. However, it was
> recently discovered that the A20 and A33 are capable of having alpha on
> their lowest plane.
>=20
> Thus, this introduces a specific quirk to indicate such support,
> per-platform. Since this was not tested on sun4i and sun6i platforms, a
> conservative approach is kept and this feature is not supported.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4=
i/sun4i_backend.c
> index a3cc398d4d80..cdc4a8a91ea2 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -35,6 +35,8 @@
>  struct sun4i_backend_quirks {
>  	/* backend <-> TCON muxing selection done in backend */
>  	bool needs_output_muxing;
> +	/* alpha at the lowest z position is not always supported */
> +	bool supports_lowest_plane_alpha;
>  };
> =20
>  static void sun4i_backend_apply_color_correction(struct sunxi_engine *en=
gine)
> @@ -484,6 +486,7 @@ static void sun4i_backend_atomic_begin(struct sunxi_e=
ngine *engine,
>  static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  				      struct drm_crtc_state *crtc_state)
>  {
> +	struct sun4i_backend *backend =3D engine_to_sun4i_backend(engine);
>  	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] =3D { 0 =
};

Your new variable should be here.

>  	struct drm_atomic_state *state =3D crtc_state->state;
>  	struct drm_device *drm =3D state->dev;
> @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_en=
gine *engine,
>  	}
> =20
>  	/* We can't have an alpha plane at the lowest position */
> -	if (plane_states[0]->fb->format->has_alpha ||
> -	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE))
> +	if ((plane_states[0]->fb->format->has_alpha ||
> +	    (plane_states[0]->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)) &&
> +	    !backend->quirks->supports_lowest_plane_alpha)
>  		return -EINVAL;

This only partially does the job. This only allows to have an alpha
plane at the lowest position, but the fact that the alpha works at the
lowest position also means you can have two alpha planes now, and you
didn't change that check.

The pipe allocation algorithm would also need to be checked.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--cmpifpotgosgerup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltN4EoACgkQ0rTAlCFN
r3SZwg/9E96mSffRGEjq9L3ZgNFCaE048ee53yPdWJM/bFzDSDP8MeuRlKtjHgV7
ODi26zwTJgu5t2jBSNRRQYlYuoaSd2nXnAlJMfWzDDyGQKgxlXcQMTwzxnsqRoCH
0r9GLrSlPVJgtNYwVge+HBwkhcT2gD4ZpE2CByu+N6C4UGgXQGJh3U1Ytqnb3Tdh
a7zbtpUjvIEGTpDaxrKgfFk/iQWu0nufQBlMhjuG6A1s+NqqdQKSMAH2tng1jZEL
zKlsvGayhWev3IPu0m4DKqJaU6WHjJYI+zTd5BvmtCQD7n+Ew8JzX+5v6N+oDyfh
WQlAVLM2Y8x7crlCw7B3A8gQH2YmITu8LuISLYCYaiAoJ/6vuhVYuvC8qZUr7SfB
Yc1AuBfbrwXq0PzlA31hY8M4q3HoV1dqM/+PttT01cm4Tn1T4G14AOZx9x5faiqx
aT4TlYyqgf7MW0fZyjbKilV1FC6dvQ2hNtXKtdXFaqKy1tZt9MnM6JplHF2mmeE/
F1uWEwjX8Min1wbhCYGN4f6h+z8/P0ZEVVhc5+4ZZRdHK+rOvBHeQmIW+AhS7T3D
xdTnHSjpzWYPwDhgQ/o7oSsZD8vmUubjeYVSIpQHd38bXii84Z5Ga1kybGQdkOJT
giumpS5pIUYjKMu2QTP7niy92O+b7lhCc2GOgvxp1derpQQwX8I=
=wqRC
-----END PGP SIGNATURE-----

--cmpifpotgosgerup--
