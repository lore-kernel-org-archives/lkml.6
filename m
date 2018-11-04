Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C0C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8A2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F8A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeKDVbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:31:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40221 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeKDVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:31:11 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1FE248097D; Sun,  4 Nov 2018 13:16:19 +0100 (CET)
Date:   Sun, 4 Nov 2018 13:16:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] spi: pxa2xx: Add ready signal
Message-ID: <20181104121620.GV23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-11-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-11-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:35, Lubomir Rintel wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/spi/spi-pxa2xx.c | 12 ++++++++++++
>  drivers/spi/spi-pxa2xx.h |  3 +++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 3848842d68fd..a3b4b12c1077 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
>  	if (spi_controller_is_slave(master)) {
>  		while (drv_data->write(drv_data))
>  			;
> +		gpiod_set_value(drv_data->gpiod_ready, 1);
> +		udelay(1);
> +		gpiod_set_value(drv_data->gpiod_ready, 0);
>  	}
> =20
>  	/*
> @@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> +	if (platform_info->is_slave) {
> +		drv_data->gpiod_ready =3D devm_gpiod_get_optional(dev,
> +						"ready", GPIOD_OUT_LOW);
> +		if (IS_ERR(drv_data->gpiod_ready)) {
> +			status =3D (int)PTR_ERR(drv_data->gpiod_ready);
> +			goto out_error_clock_enabled;
> +		}
> +	}
> +
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
> index 513c53aaeab2..4e324da66ef7 100644
> --- a/drivers/spi/spi-pxa2xx.h
> +++ b/drivers/spi/spi-pxa2xx.h
> @@ -64,6 +64,9 @@ struct driver_data {
> =20
>  	/* GPIOs for chip selects */
>  	struct gpio_desc **cs_gpiods;
> +
> +	/* Optional slave FIFO ready signal */
> +	struct gpio_desc *gpiod_ready;
>  };
> =20
>  struct chip_data {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve4xQACgkQMOfwapXb+vIivgCgwIYjjAqLZS9vC0a7OEInLqWE
PVYAn28gAZ+IeMUn8H69Egfaqanrdkk5
=F2l8
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--
