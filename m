Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC2JSa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:18:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34320 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeC2JS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:18:29 -0400
Date: Thu, 29 Mar 2018 11:18:27 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maksims Matjakubovs <maksims.matjakubovs@gmail.com>
Cc: broonie@kernel.org, wens@csie.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] Allwinner SPI sun6i : add dual mode support.
Message-ID: <20180329091827.jfvrikkslavqms2n@flea>
References: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eo6otboxu2q4hh"
Content-Disposition: inline
In-Reply-To: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47eo6otboxu2q4hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maksims,

Thanks for your patch.

It looks pretty good, but there's a few things that you'll need to
adjust.

The prefix in your commit title should start with "spi: sun6i:
<title>", in this case "spi: sun6i: Add Dual Mode Support" would be
great.

On Tue, Mar 27, 2018 at 07:11:02PM +0300, Maksims Matjakubovs wrote:
> Added Dual mode half duplex Rx and Tx support to Allwinner sun6i/sun8i SP=
I driver.
> Main changes is related to SUN6I_BURST_CTL_CNT_REG register.
> SPI transmit is in Dual mode if STC (Master Single Mode Transmit Counter)=
 is 0 and DRM (Master Dual Mode RX Enable) is not set.
> SPI receive is in Dual mode if DRM (Master Dual Mode RX Enable) is set.
> Tested on Allwinner V3s (sun8i) CPU.
>=20
> Signed-off-by: Maksims Matjakubovs <maksims.matjakubovs@gmail.com>

This is mostly fine as well, but the commit log should be wrapped to
75 chars.

You'll find a tool to check for this kind of formatting and coding
style issues (and more) using scripts/checkpatch.pl (ideally with
--strict).

> ---
>  drivers/spi/spi-sun6i.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 8533f4e..2da52ed 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -84,6 +84,7 @@
> =20
>  #define SUN6I_BURST_CTL_CNT_REG		0x38
>  #define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & SUN6I_MAX_XFER_SIZE)
> +#define SUN6I_BURST_CTL_CNT_DRM		BIT(28)
> =20
>  #define SUN6I_TXDATA_REG		0x200
>  #define SUN6I_RXDATA_REG		0x300
> @@ -312,6 +313,8 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
>  	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
>  	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
> +			(tfr->tx_nbits =3D=3D SPI_NBITS_DUAL) ? 0 :
> +			(tfr->rx_nbits =3D=3D SPI_NBITS_DUAL) ? SUN6I_BURST_CTL_CNT_DRM :
>  			SUN6I_BURST_CTL_CNT_STC(tx_len));
> =20
>  	/* Fill the TX FIFO */
> @@ -480,7 +483,8 @@ static int sun6i_spi_probe(struct platform_device *pd=
ev)
>  	master->set_cs =3D sun6i_spi_set_cs;
>  	master->transfer_one =3D sun6i_spi_transfer_one;
>  	master->num_chipselect =3D 4;
> -	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST=
 |
> +				SPI_RX_DUAL | SPI_TX_DUAL;

This feature was introduced with the A80, but the older designs (A31,
A23, A33) don't seem to support it, so we should set these flags
conditionally, using the compatible for example.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--47eo6otboxu2q4hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq8r2IACgkQ0rTAlCFN
r3SHZQ/9GGtaIe60dV3Emr8G/IF1vjJoCAow43lyt5M0VM7JUAnry3ixoyKXFW9W
7HCvLZA8LRTA6gxdMAML9LpR2f6iLykQ51hCxqDEOql9DptJqbLyo4fIa9zNs16S
qWEdeLyRIFl/2hSerhLlNzoXjXq7E5vLJO7SEHPkEydsv5HdO2nxy93j3MipZRZU
1peqgAEchQK4PfVWnb4Nh19lo8jv+KwPa5R2CiQdruLZCa4vTT//9S3ggE9gFQfm
KjiRfkIRQIQoCcO4K38xjg2BC9YlCHwsVSYr/Dl81JX6zHRfFde2RXumXHZRJanm
gdVO1ZmFzYjmT5jjaoPinWVWMJdMfL3odxGuVKrw6lmzoGf23PjRkW8Xx1r4Ny8R
ShX9Q/qfB7FEg71IQRlVoHDbffAS9M8dXCxzPBzmdN1PVJU/rWtdiBTqSVs9DuA5
g31zuJ3Sp5aAG6+BtorJQib51MhZpSyLxYBOE9g3tZ29WCVunb7bQW6aNcc0EFhh
R0lU2fiR4gAJR87NfHBirVezFgvGCVqmjh5YqiPce5gETtSUVpA3DpFRYASlyn+Y
PwzPtzWFLIvmbitUHwc4IYowEUwkxEU72qCEc809TT1vat2ObNYxkYQbsNmMF0Cl
3E6QdfcOXMXtSbFtG8nyfy2VSBXZsS0q/eSP62bHMfuZaBqxT0w=
=eulY
-----END PGP SIGNATURE-----

--47eo6otboxu2q4hh--
