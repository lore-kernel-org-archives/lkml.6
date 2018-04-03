Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbeDCIRY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:17:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39738 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754856AbeDCIRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:17:22 -0400
Date: Tue, 3 Apr 2018 10:17:11 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: sun4i: add DMA transfers support
Message-ID: <20180403081711.rqsp77mgnuvlnzt5@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-7-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhiohrrbift4fmzp"
Content-Disposition: inline
In-Reply-To: <20180329185907.27281-7-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhiohrrbift4fmzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 09:59:07PM +0300, Sergey Suloev wrote:
> +static int sun4i_spi_dma_setup(struct device *dev,
> +			       struct resource *res)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +	struct dma_slave_config dma_sconf;
> +	int ret;
> +
> +	master->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> +	if (IS_ERR(master->dma_tx)) {
> +		dev_err(dev, "Unable to acquire DMA TX channel\n");
> +		ret =3D PTR_ERR(master->dma_tx);
> +		goto out;
> +	}
> +
> +	dma_sconf.direction =3D DMA_MEM_TO_DEV;
> +	dma_sconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;

I guess that would depend on the size of the transfer, right?

> +	dma_sconf.dst_addr =3D res->start + SUN4I_TXDATA_REG;
> +	dma_sconf.dst_maxburst =3D 1;
> +	dma_sconf.src_maxburst =3D 1;

And a burst of 1 seems sub-optimal here.

> +	ret =3D sun4i_spi_dma_setup(&pdev->dev, res);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER) {
> +			/* wait for the dma driver to load */
> +			goto err_free_master;
> +		}
> +		dev_warn(&pdev->dev, "DMA transfer not supported\n");

Saying why it's not supported would be great.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yhiohrrbift4fmzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDOIYACgkQ0rTAlCFN
r3TTnBAAgcFscT4aSqpBZIvbBl4ZyzqGYOoxXFaYBE9m+tnkrbpVU0aIVx4Zfogg
M5d0r+FkrS6IhKSCCQ6xabOJN8EQvB1bkk7whcq8+584YcGxeqbAuAqY9pqARJ+f
9Nn5MUkLATPqgzT8efuu+Fjfwj4g4DHDWFiFqOcULPVYLfiYySkWfqYfPhGAdHKd
2AARSbFuURp3JeIspP/N9xMx9Oggw0J+Ba5R5KwMyF+/qhwGue0vsB3/JOMACg9E
eHlTXxUYfM2oCL1Jybh7xUvnumrwQnixYnNGJZV66v+twI/UjXsXpSVJhDkL8rDG
+HNZvaH2x5ymhpiTgm/6IWvYW5IdeB6WZXoV4cM1qHBQMBrpgQI+vofoSf7LJiWY
RnACbUk9ls3Sh+zrZY3Xn0ZsneQ303EcvCrRyQuir5bXCUi6dCCZH4iWG2060pO3
U1mxL7DshzLUfjl0rB31rjjm6VpeclvlASHcVSqHlO3Ax34nSkwIysLEAkeQq+nU
CfsAvwJAjtDHMGPlfjKG+kPZ0otO66ZTfcE6X+mgHQtr/odcL05nn3u/VX1LJUqn
b3ILTtVC1qop+W0+umEB9avV8dd8OM6GtN0TrgDrzTfrJNgbLr+0wpas+jm8g/m+
MP6m9eycG6N7e/vIjPkbAGuP4oJHJDAYHzKHvLCddq4J9zUZJ8s=
=7lOd
-----END PGP SIGNATURE-----

--yhiohrrbift4fmzp--
