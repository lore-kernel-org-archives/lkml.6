Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeDDGuv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:50:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37757 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeDDGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:50:50 -0400
Date: Wed, 4 Apr 2018 08:50:48 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180404065048.n76r3ytuznd6fqsl@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2g666rsck4bpfrm"
Content-Disposition: inline
In-Reply-To: <20180403154449.2443-4-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2g666rsck4bpfrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:44:46PM +0300, Sergey Suloev wrote:
> There is no need to handle 3/4 empty interrupt as the maximum
> supported transfer length in PIO mode is equal to FIFO depth,
> i.e. 128 bytes for sun6i and 64 bytes for sun8i SoCs.
>
> Changes in v3:
> 1) Restored processing of 3/4 FIFO full interrupt.
>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun6i.c | 41 +++++++++++++++++------------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 78acc1f..c09ad10 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -207,7 +207,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi,=
 bool enable)
> =20
>  static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
>  {
> -	return SUN6I_MAX_XFER_SIZE - 1;
> +	struct spi_master *master =3D spi->master;
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +
> +	return sspi->fifo_depth;

Doesn't that effectively revert 3288d5cb40c0 ?

Why do you need to do so?

>  }
> =20
>  static int sun6i_spi_prepare_message(struct spi_master *master,
> @@ -255,8 +258,14 @@ static int sun6i_spi_transfer_one(struct spi_master =
*master,
>  	int ret =3D 0;
>  	u32 reg;
> =20
> -	if (tfr->len > SUN6I_MAX_XFER_SIZE)
> -		return -EINVAL;
> +	/* A zero length transfer never finishes if programmed
> +	   in the hardware */

Improper comment style here. Please make sure to run checkpatch before
sending your patches.

> +	if (!tfr->len)
> +		return 0;

Can that case even happen?

> +	/* Don't support transfer larger than the FIFO */
> +	if (tfr->len > sspi->fifo_depth)
> +		return -EMSGSIZE;

You're changing the return type, why?

>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf =3D tfr->tx_buf;
> @@ -278,8 +287,7 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  	 */
>  	trig_level =3D sspi->fifo_depth / 4 * 3;
>  	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> -			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
> -			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
> +			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
> =20
> =20
>  	reg =3D sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> @@ -343,11 +351,8 @@ static int sun6i_spi_transfer_one(struct spi_master =
*master,
>  	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> =20
>  	/* Enable the interrupts */
> -	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
>  	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
>  					 SUN6I_INT_CTL_RF_RDY);
> -	if (tx_len > sspi->fifo_depth)
> -		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);

This would also need to be explained in your commit log.

> =20
>  	/* Start the transfer */
>  	reg =3D sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> @@ -376,7 +381,9 @@ out:
>  static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
>  {
>  	struct sun6i_spi *sspi =3D dev_id;
> -	u32 status =3D sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
> +	u32 status;
> +
> +	status =3D sun6i_spi_read(sspi, SUN6I_INT_STA_REG);

Why is this change needed?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--x2g666rsck4bpfrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEdccACgkQ0rTAlCFN
r3S+eQ/9HbB9a0Bu9GSUqKNddsUQGUv8G9PmtADvdnB/zX1UZeN5AjSDFhVRdXGK
juXLAvllnJchNZr6YICSRJdTLWuno9ZltZ3WwZBRVdlSMulhov9y0Nl1TrLMadmW
d7kkR5B9eJ2TNH8gM6k9HDKKnOjmg86eOY6kkWy0E2JUD+mG6q26Fx2mG3X2P6P3
Loa2mGoDzJ10mhoNqcX6Cu7aw5Eu5Lf9piTJ9+fRANCKOzDarP5HFcdRb0F0fRKz
1Wgw/xg5NvMxXy49ve1bLaCjDWe1snzdRN+UaoiOe+dbjfTEakyHWSPwlXwOfsHX
gTnv6TUUwZKzllVMlQj4k0NjnQztVAnUdxw/3YXSueiMfVXawCkMEWXHtCtb/foc
qVJa6lqU99gRqPFrXEtK+LI/Q/7trLnqmDopvkVwuJ8ti5jJ8rHG4HhFgJzHJln2
wA0LV9Hfkr+fgxq424Wm7Vp0ESL232fJadHsc68feQfq2D6hLi7sBah6maT6SNQ6
Abr+ds/kOLygUv1rHcM8eGhlsS1fXO3fefMyS3jzSYSlip/CrbncDlHVNJYCKiaD
Y41MeiFCywzPlkRFr4z6UPBz2m0wRsJyt/xgl2BuDzMIA4tKruYq+Bc5bkne19KU
9AD7p7liQbusxWKGZDDXz3sAKnbd3VMSLB6xGcux4yxVlq5eGi8=
=8VxK
-----END PGP SIGNATURE-----

--x2g666rsck4bpfrm--
