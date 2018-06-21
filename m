Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A0FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0E3204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0E3204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeFUJD1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:03:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47206 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754363AbeFUJDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:03:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E5CF720CFE; Thu, 21 Jun 2018 11:03:21 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8BED52092B;
        Thu, 21 Jun 2018 11:03:11 +0200 (CEST)
Message-ID: <d19e2594f11963b218d7f09b4a50e9df36330dbe.camel@bootlin.com>
Subject: Re: [PATCH 2/9] media: cedrus: Add wrappers around container_of for
 our buffers
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
Date:   Thu, 21 Jun 2018 11:03:11 +0200
In-Reply-To: <20180613140714.1686-3-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
         <20180613140714.1686-3-maxime.ripard@bootlin.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XkHNW+2PPnHf+ivRpA0m"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XkHNW+2PPnHf+ivRpA0m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> The cedrus driver sub-classes the vb2_v4l2_buffer structure, but doesn't
> provide any function to wrap around the proper container_of call that nee=
ds
> to be duplicated in every calling site.
>=20
> Add wrappers to make sure its opaque to the users and they don't have to
> care anymore.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../platform/sunxi/cedrus/sunxi_cedrus_common.h      | 12 ++++++++++++
>  .../media/platform/sunxi/cedrus/sunxi_cedrus_hw.c    |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h b/=
drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> index ee6883ef9cb7..b1ed1c8cb130 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> @@ -89,6 +89,18 @@ struct sunxi_cedrus_buffer {
>  	struct list_head list;
>  };
> =20
> +static inline

I'm not a big fan of spreading the type qualifiers on two distinct lines
instead of having a longer single line (reminds me of the GNU coding
style a bit), but this is purely cosmetic.

Cheers,

Paul

> +struct sunxi_cedrus_buffer *vb2_v4l2_to_cedrus_buffer(const struct vb2_v=
4l2_buffer *p)
> +{
> +	return container_of(p, struct sunxi_cedrus_buffer, vb);
> +}
> +
> +static inline
> +struct sunxi_cedrus_buffer *vb2_to_cedrus_buffer(const struct vb2_buffer=
 *p)
> +{
> +	return vb2_v4l2_to_cedrus_buffer(to_vb2_v4l2_buffer(p));
> +}
> +
>  struct sunxi_cedrus_dev {
>  	struct v4l2_device v4l2_dev;
>  	struct video_device vfd;
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c b/driv=
ers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> index 5783bd985855..fc688a5c1ea3 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> @@ -108,8 +108,8 @@ static irqreturn_t sunxi_cedrus_ve_irq(int irq, void =
*dev_id)
>  		return IRQ_HANDLED;
>  	}
> =20
> -	src_buffer =3D container_of(src_vb, struct sunxi_cedrus_buffer, vb);
> -	dst_buffer =3D container_of(dst_vb, struct sunxi_cedrus_buffer, vb);
> +	src_buffer =3D vb2_v4l2_to_cedrus_buffer(src_vb);
> +	dst_buffer =3D vb2_v4l2_to_cedrus_buffer(dst_vb);
> =20
>  	/* First bit of MPEG_STATUS indicates success. */
>  	if (ctx->job_abort || !(status & 0x01))
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-XkHNW+2PPnHf+ivRpA0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsrac8ACgkQ3cLmz3+f
v9HFmgf/aIXwnztdvw5bePsyuoGb2CAA4h3dfo9ddQ2AcDtVU7baPUW1OgLeFsEx
SgS4i/a7/jPUtcugrYNfCXQNk1AiWg6Z0PJCk33SXUpID2u+4zdNn29t5yOWu29O
OHi0u1s0wgBlq/hXH1hlGDKSe/V4WFNBlLjZj61oxhDh2AHrLo6lo4DO9wKQ2BaI
+ZZEeooLBvH/zfaaWXI24npAKecdvSwfq+89JH4XqN87EFzq5ORq1/1GhD0V6AWs
p8gkAETBtALc955mu/qWmwZXeez4uruqGrpeu6eLUhR71pog12VtzxxGqNTynq3u
YoT+++HN4BlW6vDX1OA3LJE9R6pGSw==
=38y6
-----END PGP SIGNATURE-----

--=-XkHNW+2PPnHf+ivRpA0m--

