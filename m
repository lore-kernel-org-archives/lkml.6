Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862BEC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42451204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42451204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeFUJNd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:13:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47746 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbeFUJNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:13:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7ED84206D8; Thu, 21 Jun 2018 11:13:29 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1EFB9203D9;
        Thu, 21 Jun 2018 11:13:19 +0200 (CEST)
Message-ID: <18ffd09bf91908886aebbad127e612775b7f0bf8.camel@bootlin.com>
Subject: Re: [PATCH 3/9] media: cedrus: Add a macro to check for the
 validity of a control
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>, hans.verkuil@cisco.com,
        acourbot@chromium.org, sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 21 Jun 2018 11:13:19 +0200
In-Reply-To: <20180613140714.1686-4-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
         <20180613140714.1686-4-maxime.ripard@bootlin.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VQE9UU1GTYaO8ZSYHoUI"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VQE9UU1GTYaO8ZSYHoUI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> During our frame decoding setup, we need to check a number of controls to
> make sure that they are properly filled before trying to access them.
>=20
> It's not too bad with MPEG2 since there's just a single one, but with the
> upcoming increase of codecs, and the integration of more complex codecs,
> this logic will be duplicated a significant number of times. H264 for
> example uses 4 different controls.
>=20
> Add a macro that expands to the proper check in order to reduce the
> duplication.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../platform/sunxi/cedrus/sunxi_cedrus_dec.c     | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c b/dri=
vers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> index 8c92af34ebeb..c19acf9626c4 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> @@ -110,15 +110,16 @@ void sunxi_cedrus_device_run(void *priv)
> =20
>  	spin_lock_irqsave(&ctx->dev->irq_lock, flags);
> =20
> +#define CHECK_CONTROL(ctx, ctrl)					\
> +	if (!ctx->ctrls[(ctrl)]) {					\

Although this was not introduced in this patch, I believe this approach
won't work since ctx->ctrls[i] is a pointer returned from
v4l2_ctrl_new_custom(hdl, &cfg, NULL), which will always be non-null
after calling cedrus_init_ctrls.

Perhaps checking ctx->ctrls[i].p_cur.p would be the right thing to
check, but I'm unsure about that.

> +		v4l2_err(&(ctx)->dev->v4l2_dev, "Invalid " #ctrl " control\n"); \
> +		(ctx)->job_abort =3D 1;					\
> +		goto unlock_complete;					\
> +	}
> +
>  	switch (ctx->vpu_src_fmt->fourcc) {
>  	case V4L2_PIX_FMT_MPEG2_FRAME:
> -		if (!ctx->ctrls[SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR]) {
> -			v4l2_err(&ctx->dev->v4l2_dev,
> -				 "Invalid MPEG2 frame header control\n");
> -			ctx->job_abort =3D 1;
> -			goto unlock_complete;
> -		}
> -
> +		CHECK_CONTROL(ctx, SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR);
>  		run.mpeg2.hdr =3D get_ctrl_ptr(ctx, SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_=
HDR);
>  		sunxi_cedrus_mpeg2_setup(ctx, &run);
> =20
> @@ -128,6 +129,7 @@ void sunxi_cedrus_device_run(void *priv)
>  	default:
>  		ctx->job_abort =3D 1;
>  	}

Maybe add a newline here?

Cheers,

Paul

> +#undef CHECK_CONTROL
> =20
>  unlock_complete:
>  	spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-VQE9UU1GTYaO8ZSYHoUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsrbC8ACgkQ3cLmz3+f
v9FWTwgAlcGN1gPoncx1y38kxL7Z7K0/XVu2lLjn2+n2fSHP6WJj+QtBUuQEfa1y
IX+/UBeXFrZvx49GH9A9fmXsbGRME56ocRDLR4koNopdaQrWdbgNx6NACEUgEK3A
zWimSjS18/qJj6js1OyRVsnZpU7hfuL7yfTt5e9a03ybYPQ7BtVfJsh0MXSxyDur
z6evE9taF3d37tMkCuf81y7l5qlvbKu1menzn9CT9+M5HbUDysdpDcuMOBdnmLXd
+zICme6Abs7UZfPE6sEMSBPkAUwpG4/M8LrfOF7lUGOZ3RZ9K9XwcUhQeeMfjeXH
BHvWvyDJEzmMAtszIlu6eVArR+KsgA==
=uWyX
-----END PGP SIGNATURE-----

--=-VQE9UU1GTYaO8ZSYHoUI--

