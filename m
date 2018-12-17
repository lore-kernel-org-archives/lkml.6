Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47328C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1374620675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeLQGBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:01:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:01:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1gYlxo-0005u0-IC; Mon, 17 Dec 2018 07:01:12 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1gYlxn-0004C9-9P; Mon, 17 Dec 2018 07:01:11 +0100
Date:   Mon, 17 Dec 2018 07:01:11 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] mailbox: imx: Fix clk handling in imx_mu_probe()
Message-ID: <20181217060111.hsay6vhqpxyfdbiu@pengutronix.de>
References: <1544914904-3809-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s7owgsepa225a342"
Content-Disposition: inline
In-Reply-To: <1544914904-3809-1-git-send-email-khoroshilov@ispras.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:52:23 up 187 days, 15:01, 90 users,  load average: 0.14, 0.15,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s7owgsepa225a342
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On Sun, Dec 16, 2018 at 02:01:44AM +0300, Alexey Khoroshilov wrote:
> Handling of devm_clk_get() suggests that the driver should support
> lack of priv->clk. But imx_mu_probe() fails on clk_prepare_enable(NULL)
> in that case.
>=20
> The patch removes the try to enable absent clk and adds error handling
> for mbox_controller_register().
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/mailbox/imx-mailbox.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 363d35d5e49d..ddde398f576e 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -292,10 +292,12 @@ static int imx_mu_probe(struct platform_device *pde=
v)
>  		priv->clk =3D NULL;
>  	}
> =20
> -	ret =3D clk_prepare_enable(priv->clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable clock\n");
> -		return ret;
> +	if (priv->clk) {
> +		ret =3D clk_prepare_enable(priv->clk);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable clock\n");
> +			return ret;
> +		}
>  	}
> =20
>  	for (i =3D 0; i < IMX_MU_CHANS; i++) {
> @@ -324,7 +326,13 @@ static int imx_mu_probe(struct platform_device *pdev)
> =20
>  	imx_mu_init_generic(priv);
> =20
> -	return mbox_controller_register(&priv->mbox);
> +	ret =3D mbox_controller_register(&priv->mbox);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
> =20
>  static int imx_mu_remove(struct platform_device *pdev)
> --=20
> 2.7.4
>=20
>=20

NACK for this patch.

Here are code snippets from clk framework:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
/* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
static inline int clk_prepare_enable(struct clk *clk)
{
	int ret;

	ret =3D clk_prepare(clk);
	if (ret)
		return ret;
	ret =3D clk_enable(clk);
	if (ret)
		clk_unprepare(clk);

	return ret;
}

int clk_prepare(struct clk *clk)
{
	if (!clk)
		return 0;

	return clk_core_prepare_lock(clk->core);
}

int clk_enable(struct clk *clk)
{
	if (!clk)
		return 0;

	return clk_core_enable_lock(clk->core);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

As you can see, complete code path is NULL resistant. Are you trying to
fix some real issue, or it is a theoretical work?

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--s7owgsepa225a342
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlwXO6AACgkQdQOiSHVI
77QKeQf/VZ9xfjMcC9bDfdTndYtnwIm8ugM4cuoxE30GiaOVK0F9T2zene/USVUl
HDEtF6A4TF6s6sQCFsEZ1dYYePftCS6OU4hGykqf5HYkFceCVgnG7UrJjolwgPC2
yIndgvoUex0qkKDDzSiKIh7Sa0113XtxTJvrWGrCSmKys/RcqG17+sSlcsey2+A0
Xts8RyOpDytTStN+3xF2mX1RcQ32jfCAs3gEAU9Kvv6PH49QBV5+2I/mZ0nlNVFB
xBhCi/GR89DRVlvcdXiaEt2S7t+9KAI8yAb6SknerQ6YuyIPbKl0YlMXZz2A3yXm
Pfa8teKiyy5ZYtA2SCHKylF30+tmbA==
=godA
-----END PGP SIGNATURE-----

--s7owgsepa225a342--
