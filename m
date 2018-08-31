Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5372CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7EC2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7EC2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHaNNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:13:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33438 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeHaNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:13:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A54FD207EB; Fri, 31 Aug 2018 11:07:23 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7813A203EC;
        Fri, 31 Aug 2018 11:07:23 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:07:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 19/30] iio: adc: sun4i-gpadc-iio: rework: support
 nvmem calibration data
Message-ID: <20180831090722.zf65lkozjpozngu5@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-20-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vminzmpyj645vdzq"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-20-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vminzmpyj645vdzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:07PM +0200, Philipp Rossak wrote:
> This patch reworks the driver to support nvmem calibration cells.
> The driver checks if the nvmem calibration is supported and reads out
> the nvmem.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 18ab72e52d78..2fd73d143815 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -70,6 +71,7 @@ struct gpadc_data {
>  	bool		has_mod_clk;
>  	u32		temp_data_base;
>  	int		sensor_count;
> +	bool		supports_nvmem;
>  };
> =20
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -146,6 +148,7 @@ struct sun4i_gpadc_iio {
>  	struct clk			*bus_clk;
>  	struct clk			*mod_clk;
>  	struct reset_control		*reset;
> +	u32				calibration_data[2];
>  };
> =20
>  static const struct iio_chan_spec sun4i_gpadc_channels[] =3D {
> @@ -484,6 +487,9 @@ static int sun4i_gpadc_probe_dt(struct platform_devic=
e *pdev,
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
> +	struct nvmem_cell *cell;
> +	ssize_t cell_size;
> +	u32 *cell_data;
> =20
>  	info->data =3D of_device_get_match_data(&pdev->dev);
>  	if (!info->data)
> @@ -494,6 +500,24 @@ static int sun4i_gpadc_probe_dt(struct platform_devi=
ce *pdev,
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> +	if (info->data->supports_nvmem) {
> +
> +		cell =3D nvmem_cell_get(&pdev->dev, "calibration");
> +		if (IS_ERR(cell)) {
> +			if (PTR_ERR(cell) =3D=3D -EPROBE_DEFER)
> +				return PTR_ERR(cell);

You're masking real errors here, if the issue isn't that the property
isn't found.

> +		} else {
> +			cell_data =3D (u32 *)nvmem_cell_read(cell, &cell_size);
> +			if (cell_size !=3D 8)
> +				dev_err(&pdev->dev,
> +					"Calibration data has wrong size\n");
> +			else {
> +				info->calibration_data[0] =3D cell_data[0];
> +				info->calibration_data[1] =3D cell_data[1];

How are those calibration data organized when there is multiple channels?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vminzmpyj645vdzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBUkACgkQ0rTAlCFN
r3QGzA/+OHo55PLU4ohaSuYddAdzC0WLJT/1Sndf5tKhMC1xP7BtKtfMr1SBnPTT
ljwqrA3D4s2ACsYE9LQLx08D90jQGOltwFlVJ0hh+Ufo8PZD6XppxJHJP8Fk9jeF
GXzrDp47zBDcTvoewjzOGV4TV4lZfTbL6CmGSQw+1w26Sh1+YS4dvAOLhEF9shw7
iSDcgQ+PGB/ZEXRB5oeJ1IP+d1vXaTYMK+ltI88h7aI7JCkPMyJslWZhoBN7Ve3o
mbKu5OnK2sHoxtcAbqZ4VRfg9uuEc3p3P4gUtd8BWrw1vy364jI0Pi77TVh3wZSq
xcJgAZ17pP/O4s8WH3tO5Jd6Odyokdf+tWhObC/RAGYxBCNztDWiijk0m/HLSIyS
/Lb5wlrErULSRv9eJzBBvnjIVME4bPGdtSgtoZe4T7spV8DhKoZUVNawAs94kEqL
6ZL95Rslca/WUVYZeAVQTjkwR7kBxEARMBu9nDbUO+waaeZJnr3BfvJf6slTEaA0
VShOHxRGsx3Bzwpe+xC8NBniqEHvBH66VoMtD2B41Ocqkgo6oiFKD0tfldY71fZc
GnEfs9Z53hSicx5nx/phynGvv/PIUkyF0xcpWGHbVQ/MazjmCwUsMTbnDkbz8qZx
/fqsZjTWhJjnfUEhMOR2aZwEc21A6hGQ9GyT7J/DIfj4EkaKel0=
=qbor
-----END PGP SIGNATURE-----

--vminzmpyj645vdzq--
