Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65FC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BE420820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfBDJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:34:38 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45577 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfBDJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:34:37 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9BB5CC000E;
        Mon,  4 Feb 2019 09:34:28 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:34:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Message-ID: <20190204093427.vg63e5xmd7u52leh@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p42mp7wsvouznbye"
Content-Disposition: inline
In-Reply-To: <20190203155628.16767-3-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p42mp7wsvouznbye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>=20
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>=20
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>=20
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>=20
> ---
>=20
> This should be backported to stable kernels in case people try to run
> new device trees (that declare newly supported modes) with old kernels.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7415af8c8ff6..a01433012db0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		goto error_free_dma;
> =20
> +	/*
> +	 * If we don't support delay chains in the SoC, we can't use any
> +	 * of the DDR speed modes. Mask them out in case the device
> +	 * tree specifies the properties for them, which gets added to
> +	 * the caps by mmc_of_parse() above.
> +	 */
> +	if (!(host->cfg->clk_delays || host->use_new_timings))
> +		mmc->caps &=3D ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> +			       MMC_CAP_1_2V_DDR);
> +
> +	/* TODO: UHS modes untested due to lack of supporting boards */
> +	mmc->caps &=3D ~MMC_CAP_UHS;

I've tested up to SDR104 and it works on the A64 at least

> +	/* TODO: This driver doesn't support HS200 and HS400 modes yet */
> +	mmc->caps2 &=3D ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);

And HS200 works too.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--p42mp7wsvouznbye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFgHIwAKCRDj7w1vZxhR
xQSuAQDzqY3AgbX6jdcqPJZ8CyLaVSntDctVN1OhIxNi/NLn0gEA/LUVZ2v6jW7j
y5XrPWcvFc9RMdlngq/1H74VfzPbXgU=
=FTPy
-----END PGP SIGNATURE-----

--p42mp7wsvouznbye--
