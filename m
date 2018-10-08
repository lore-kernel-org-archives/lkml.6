Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02BC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA0F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA0F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJHQCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:02:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36628 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeJHQCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:02:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A6BC4207CC; Mon,  8 Oct 2018 10:51:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 746A5206A1;
        Mon,  8 Oct 2018 10:51:11 +0200 (CEST)
Date:   Mon, 8 Oct 2018 10:51:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
Message-ID: <20181008085112.mejpwvl3dpu7sopy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3donk7cvlzjru3b"
Content-Disposition: inline
In-Reply-To: <20181007093905.11253-26-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3donk7cvlzjru3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
>=20
> Add quirks support for TCON TOP.
>=20
> Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> structure.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> index 37158548b447..ed13233cad88 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -9,11 +9,17 @@
>  #include <linux/component.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
> =20
>  #include "sun8i_tcon_top.h"
> =20
> +struct sun8i_tcon_top_quirks {
> +	bool has_tcon_tv1;
> +	bool has_dsi;
> +};
> +
>  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
>  {
>  	return !!of_match_node(sun8i_tcon_top_of_table, node);
> @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, =
struct device *master,
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct clk_hw_onecell_data *clk_data;
>  	struct sun8i_tcon_top *tcon_top;
> +	const struct sun8i_tcon_top_quirks *quirks;
>  	struct resource *res;
>  	void __iomem *regs;
>  	int ret, i;
> =20
> +	quirks =3D of_device_get_match_data(&pdev->dev);
> +
>  	tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
>  	if (!tcon_top)
>  		return -ENOMEM;
> @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, =
struct device *master,
>  					     &tcon_top->reg_lock,
>  					     TCON_TOP_TCON_TV0_GATE, 0);
> =20
> -	clk_data->hws[CLK_TCON_TOP_TV1] =3D
> -		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> -					     &tcon_top->reg_lock,
> -					     TCON_TOP_TCON_TV1_GATE, 1);
> +	if (quirks->has_tcon_tv1) {
> +		clk_data->hws[CLK_TCON_TOP_TV1] =3D
> +			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> +						     &tcon_top->reg_lock,
> +						     TCON_TOP_TCON_TV1_GATE, 1);
> +	} else {
> +		clk_data->hws[CLK_TCON_TOP_TV1] =3D NULL;
> +	}
> =20
> -	clk_data->hws[CLK_TCON_TOP_DSI] =3D
> -		sun8i_tcon_top_register_gate(dev, "dsi", regs,
> -					     &tcon_top->reg_lock,
> -					     TCON_TOP_TCON_DSI_GATE, 2);
> +	if (quirks->has_dsi) {
> +		clk_data->hws[CLK_TCON_TOP_DSI] =3D
> +			sun8i_tcon_top_register_gate(dev, "dsi", regs,
> +						     &tcon_top->reg_lock,
> +						     TCON_TOP_TCON_DSI_GATE, 2);
> +	} else {
> +		clk_data->hws[CLK_TCON_TOP_DSI] =3D NULL;

clk_data has been kzalloc'd so its content is already NULL.

And you shouldn't have brackets for single line blocks.

with that fixed,

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c3donk7cvlzjru3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7Gn8ACgkQ0rTAlCFN
r3RZfxAAlDsjMRdnM/QxxcMgdZs8xc9ZaFsW+F4rF7OTurcMmCkEkDjYJElqygEw
QGShhO1a0FPOoaeYdX+799pk8iSi6JHlwgvFlQyG0+DGqOWoXVytfKqFyXOs/kbn
/0vgjE12661PD3w+5JMU+ncuPIgpIkjBAY9nV7dzFC31/yfizoT4MipYBwrfpldb
QfXT+5fLw+txMt53thGv6ovK0c9gu6Vw6Fybr1E5EV1oFj3z0RFshfMr36yGPA8l
3SIJfe2Sqf8sgOFfjzsSi2YXf+TdA4K+UvUxNNAsI5Grd0ln8MBNNYhXY+ayYpjX
X8LFqIuxQ87O6nQvfieRecqBXmuIcN7jlnv9ayO0gjog5guP534B4YVlBlKtZQe0
qCuSs9ORXBgcouCQpyWo8wlbQKn2lmrGxTTUiQWKlr5uCDUvipB2kAzmTYNP89Ys
xx8BCLa2Og5wU9Z8ky9C66u+rgbIeiAxSh39ZgjZY1U3Ms2Gf8VdEyT3s0TRiurS
qLkfHXQLpRM/zun2/mHIfogthDAQHK0KjuaG3TaIuaLOvQZjwNzTcsStvOyLbpEA
TfrPgk9DXTA+T2oPO6ip1Dlx2rQI8xrZEr5sIUc5jwGCPf/TTpaBwCoMrjQfeuYZ
GGuZbYUQW02lDW8HxiAkhLVZIKqJW+BQiGgQjTPZLzCfVNoek28=
=n5G0
-----END PGP SIGNATURE-----

--c3donk7cvlzjru3b--
