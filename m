Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeDDHKm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:10:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38400 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeDDHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:10:41 -0400
Date: Wed, 4 Apr 2018 09:10:39 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] spi: sun4i: restrict transfer length in PIO-mode
Message-ID: <20180404071039.2kiizzkzzogsk3o4@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-3-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5s32d26kspvte6f"
Content-Disposition: inline
In-Reply-To: <20180403152905.1524-3-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5s32d26kspvte6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:29:01PM +0300, Sergey Suloev wrote:
> There is no need to handle the 3/4 FIFO empty interrupt
> as the maximum supported transfer length in PIO mode
> is 64 bytes.
> As long as a problem was reported previously with filling FIFO
> on A10s we want to stick with 63 bytes depth.
>=20
> Changes in v2:
> 1) Restored processing of 3/4 FIFO full interrupt.
>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun4i.c | 37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 4141003..08fd007 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -22,7 +22,12 @@
> =20
>  #include <linux/spi/spi.h>
> =20
> -#define SUN4I_FIFO_DEPTH		64
> +/*
> + * FIFO length is 64 bytes
> + * But filling the FIFO fully might cause a timeout
> + * on some devices, for example on spi2 on A10s
> + */
> +#define SUN4I_FIFO_DEPTH		63

The FIFO depth is 64 bytes, so the code should remain the same at
least from that regard.

>  #define SUN4I_RXDATA_REG		0x00
> =20
> @@ -202,7 +207,7 @@ static void sun4i_spi_set_cs(struct spi_device *spi, =
bool enable)
> =20
>  static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
>  {
> -	return SUN4I_FIFO_DEPTH - 1;
> +	return SUN4I_FIFO_DEPTH;
>  }
> =20
>  static int sun4i_spi_transfer_one(struct spi_master *master,
> @@ -216,11 +221,8 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
>  	int ret =3D 0;
>  	u32 reg;
> =20
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> -		return -EMSGSIZE;
> -
> -	if (tfr->tx_buf && tfr->len >=3D SUN4I_MAX_XFER_SIZE)
> +	/* We don't support transfers larger than FIFO depth */
> +	if (tfr->len > SUN4I_FIFO_DEPTH)
>  		return -EMSGSIZE;

This essentially reverts 196737912da5, why?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--l5s32d26kspvte6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEem4ACgkQ0rTAlCFN
r3Q1mA//f8KiQiJRkgbslVR6N6IzVRjn6I2BTsOQyQD2Uvaaz4w9cqjwbejaZjEv
Z0/9bPqKTnTraLjOg//sf8EcTVh6ZT9AdhB3eEKGrzjNiN4BFyegHETgR5Kvgp/x
iCO4bipdVSG0Ar/I/12Cy21eK+oJgVWDDuoU9vPpENVaESs5r2oUU9j9ffDv9XRM
0h7nBUXW9cD7q4305PpLZw3LTBTVUOwmpg3n2UzVpPbP7dxKg7p0L8DhjUOXs/Te
3Thl1o0A7tkPn8doJo6i0pXOmswL7GbRQWGJvAsJUL+IfG0gZvAW3V9cGwQKXD7r
IyaiPcwasavH1I/I9fP7kp1B1i9+CpsySC9MVITEcDZYnSjXPMcpaoHUTA4A/mRX
oRSfGv7FtbNpKvyoZXKSuMpEtEzrDPZFelUpfdparCVNY7YNkZN6jB5uXgQJ2Iqw
k8KShkTazxUNjGBP9+fkgwQML4PUoIKEgl8Ugs/iguVeahcN35ObEmehVlVC+k5M
zBPfHqQgB0T7HV5DemKGSJBpfs0XU2m7dOjaLX16nNW5UIzmlWZb2fny6DQLy+Y0
g/UnBk9pLXCseX3w0Hgn0Qbgh0B8RnIeh+xQNu3CQzPxXf/IfDIV+iqsevJvkuE9
5+qhTRjLTbMrkhq1hxrWL+9ITmD0JET+/9jk+iAxa5ijk9MpL5w=
=VK+/
-----END PGP SIGNATURE-----

--l5s32d26kspvte6f--
