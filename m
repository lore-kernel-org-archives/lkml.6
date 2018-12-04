Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395582081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395582081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLDPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:22:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37784 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:22:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09BB620736; Tue,  4 Dec 2018 16:22:09 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB33F20711;
        Tue,  4 Dec 2018 16:21:58 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:21:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 04/21] drm/sun4i: frontend: Pass DRM format info to
 input mode helper
Message-ID: <20181204152158.rclvmyql6ct5jley@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qmeysasvn3o4kko2"
Content-Disposition: inline
In-Reply-To: <20181204142218.16284-5-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmeysasvn3o4kko2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:01PM +0100, Paul Kocialkowski wrote:
> The helper returning the input mode needs to know the number of planes
> for the provided format. Passing the fourcc requires iterating through
> the format info list in order to return the number of planes.
>=20
> Pass the DRM format info structure directly instead, since it's
> available to the caller. Also rename the input format in the caller
> function to keep things consistent.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 1a7ebc45747e..c436fa97928f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -116,9 +116,11 @@ static int sun4i_frontend_drm_format_to_input_fmt(ui=
nt32_t fmt, u32 *val)
>  	}
>  }
> =20
> -static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *va=
l)
> +static int
> +sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *fo=
rmat,
> +					u32 *val)
>  {
> -	if (drm_format_num_planes(fmt) =3D=3D 1)
> +	if (format->num_planes =3D=3D 1)
>  		*val =3D SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
>  	else
>  		return -EINVAL;
> @@ -183,12 +185,13 @@ int sun4i_frontend_update_formats(struct sun4i_fron=
tend *frontend,
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	struct drm_framebuffer *fb =3D state->fb;
> -	uint32_t format =3D fb->format->format;
> +	const struct drm_format_info *format =3D fb->format;
>  	u32 out_fmt_val;
>  	u32 in_fmt_val, in_mod_val, in_ps_val;
>  	int ret;
> =20
> -	ret =3D sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
> +	ret =3D sun4i_frontend_drm_format_to_input_fmt(format->format,
> +						     &in_fmt_val);
>  	if (ret) {
>  		DRM_DEBUG_DRIVER("Invalid input format\n");
>  		return ret;
> @@ -200,7 +203,8 @@ int sun4i_frontend_update_formats(struct sun4i_fronte=
nd *frontend,
>  		return ret;
>  	}
> =20
> -	ret =3D sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
> +	ret =3D sun4i_frontend_drm_format_to_input_sequence(format->format,
> +							  &in_ps_val);

To keep things really consistent, we should also convert those
functions to get a drm_format_info pointer instead of the fourcc :)

It can come as a later patch though.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qmeysasvn3o4kko2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAablgAKCRDj7w1vZxhR
xbaYAP9zYcfLDWwRHSXU8pqm4aNDYNt0WyMbJYv+h9Z/TWElbgEAupxGTM3QRuOO
3pk1BQlS5v4jeD7cuC0VLI563zlARAU=
=/Sxa
-----END PGP SIGNATURE-----

--qmeysasvn3o4kko2--
