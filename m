Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeDDGpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:45:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37558 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeDDGpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:45:03 -0400
Date: Wed, 4 Apr 2018 08:45:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: sun6i: coding style/readability improvements
Message-ID: <20180404064501.3sfo67ynkplk4vyx@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-2-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gcvk7fpi35c7tfij"
Content-Disposition: inline
In-Reply-To: <20180403154449.2443-2-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcvk7fpi35c7tfij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:44:44PM +0300, Sergey Suloev wrote:
> Minor changes to fulfill the coding style and improve
> the readability of the code.
>=20
> Changes in v2:
> 1) Fixed issue with misplacing a piece of code that requires access
> to the transfer structure into sun6i_spi_prepare_message() function
> where the transfer structure is not available.

This shouldn't be in your commit log.

> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 58 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 8533f4e..88ad45e 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -88,8 +88,12 @@
>  #define SUN6I_TXDATA_REG		0x200
>  #define SUN6I_RXDATA_REG		0x300
> =20
> +#define SUN6I_SPI_MODE_BITS		(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LS=
B_FIRST)
> +
> +#define SUN6I_SPI_MAX_SPEED_HZ		100000000
> +#define SUN6I_SPI_MIN_SPEED_HZ		3000
> +
>  struct sun6i_spi {
> -	struct spi_master	*master;
>  	void __iomem		*base_addr;
>  	struct clk		*hclk;
>  	struct clk		*mclk;
> @@ -189,6 +193,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, =
bool enable)
>  	else
>  		reg &=3D ~SUN6I_TFR_CTL_CS_LEVEL;
> =20
> +	/* We want to control the chip select manually */
> +	reg |=3D SUN6I_TFR_CTL_CS_MANUAL;
> +
>  	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
>  }
> =20
> @@ -197,6 +204,39 @@ static size_t sun6i_spi_max_transfer_size(struct spi=
_device *spi)
>  	return SUN6I_MAX_XFER_SIZE - 1;
>  }
> =20
> +static int sun6i_spi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct spi_device *spi =3D msg->spi;
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +	u32 reg;
> +
> +	/*
> +	 * Setup the transfer control register: Chip Select,
> +	 * polarities, etc.
> +	 */
> +	reg =3D sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> +
> +	if (spi->mode & SPI_CPOL)
> +		reg |=3D SUN6I_TFR_CTL_CPOL;
> +	else
> +		reg &=3D ~SUN6I_TFR_CTL_CPOL;
> +
> +	if (spi->mode & SPI_CPHA)
> +		reg |=3D SUN6I_TFR_CTL_CPHA;
> +	else
> +		reg &=3D ~SUN6I_TFR_CTL_CPHA;
> +
> +	if (spi->mode & SPI_LSB_FIRST)
> +		reg |=3D SUN6I_TFR_CTL_FBS;
> +	else
> +		reg &=3D ~SUN6I_TFR_CTL_FBS;
> +
> +	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
> +
> +	return 0;
> +}
> +

You're doing way more than just "coding style improvements", please
split the patches accordingly.

And slow down between versions, you had 0 review on the v1 and the v2,
and you're at v3 already in just a couple of days.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gcvk7fpi35c7tfij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEdGwACgkQ0rTAlCFN
r3R06A/+Ledb/akRsFwWs9PD4e8hkX3LCy7FQFRi3NxtNwiftrWvd3+QD8HWBe49
9gHNSdcylBDsrIcefhmzPtPNyXoVJmmIjuV7+GQyesmo7NVxAV53IsqvccYvriGk
6P130mGhzB9m8edu/Tb6SHi+1OHMRTcXkS+bOxabbksUpC0F7CfqZGn0mHx+EgT/
w4r2H8vA9i9pjJZmWWrvy4PkblGfZVW3/5aufZtJYD3JIH+hIAryx5415kcZ6y3B
LEvZ/2WYofbgQNFq37uEzRnUyVJ/7IbG3zOX01gBmWpyWJ94rBzJKHumnD4chs2T
H3j8izQ/TrxPcjfS8rLxV0f6M1X6MQ7kI8zntD19dt/qr0blz6i4NdSgWS53Ykgx
xdYgBbN3fEIAfmEBtLPqg6X9Zy2EIJGUhYrsCYgd1SWDU5q+MQvxRyr+x1gM3qWG
348sbPDAyO+Rg2JfXtCSm5pUOt4gTlynhsrWzbsvilUiPE3X75bzl0bi2ZZYe7k3
U1NcccN+63Ag9Vm+Hv9+XsmUEDt44+JoNcQF6GSkZemAcyxiJVh1IVvEq3hL81xr
CXDVu5H9qixhOStNgbug4XAl38b4hOeFMWFBd9XBPlNNodSUMfXyZEgR0iGtyHuy
vEZCuYAFv3+DneM7ZZoQp8puqv6c6GU5udso+wNsK8FjWpwnJpw=
=r6iy
-----END PGP SIGNATURE-----

--gcvk7fpi35c7tfij--
