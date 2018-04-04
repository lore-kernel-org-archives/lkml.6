Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDDHAn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:00:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37954 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbeDDHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:00:42 -0400
Date: Wed, 4 Apr 2018 09:00:39 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] spi: sun6i: add DMA transfers support
Message-ID: <20180404070039.56vxg22l32px4r3m@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-7-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7tspdc6l4hljay2w"
Content-Disposition: inline
In-Reply-To: <20180403154449.2443-7-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tspdc6l4hljay2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:44:49PM +0300, Sergey Suloev wrote:
> DMA transfers are now available for sun6i and sun8i SoCs.
> The DMA mode is used automatically as soon as requested
> transfer length is more than FIFO length.
>=20
> Changes in v3:
> 1) Debug log enhancements.
>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> ---
>  drivers/spi/spi-sun6i.c | 331 ++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 294 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 2fa9d6e..7f41871 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -14,6 +14,8 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -55,17 +57,20 @@
> =20
>  #define SUN6I_FIFO_CTL_REG		0x18
>  #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK	0xff
> -#define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS	0
> +#define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS	0

Why are you changing that name

> +#define SUN6I_FIFO_CTL_RF_DRQ_EN		BIT(8)
>  #define SUN6I_FIFO_CTL_RF_RST			BIT(15)
>  #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK	0xff
> -#define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS	16
> +#define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_POS	16

Ditto.

> +#define SUN6I_FIFO_CTL_TF_DRQ_EN		BIT(24)
>  #define SUN6I_FIFO_CTL_TF_RST			BIT(31)
> +#define SUN6I_FIFO_CTL_DMA_DEDICATE		BIT(9)|BIT(25)
> =20
>  #define SUN6I_FIFO_STA_REG		0x1c
>  #define SUN6I_FIFO_STA_RF_CNT_MASK		0x7f
> -#define SUN6I_FIFO_STA_RF_CNT_BITS		0
> +#define SUN6I_FIFO_STA_RF_CNT_POS		0

Ditto.

>  #define SUN6I_FIFO_STA_TF_CNT_MASK		0x7f
> -#define SUN6I_FIFO_STA_TF_CNT_BITS		16
> +#define SUN6I_FIFO_STA_TF_CNT_POS		16

Ditto.

> =20
>  #define SUN6I_CLK_CTL_REG		0x24
>  #define SUN6I_CLK_CTL_CDR2_MASK			0xff
> @@ -135,7 +140,7 @@ static inline u32 sun6i_spi_get_tx_fifo_count(struct =
sun6i_spi *sspi)
>  {
>  	u32 reg =3D sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
> =20
> -	reg >>=3D SUN6I_FIFO_STA_TF_CNT_BITS;
> +	reg >>=3D SUN6I_FIFO_STA_TF_CNT_POS;
> =20
>  	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
>  }
> @@ -148,7 +153,7 @@ static inline void sun6i_spi_drain_fifo(struct sun6i_=
spi *sspi, int len)
>  	/* See how much data is available */
>  	reg =3D sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
>  	reg &=3D SUN6I_FIFO_STA_RF_CNT_MASK;
> -	cnt =3D reg >> SUN6I_FIFO_STA_RF_CNT_BITS;
> +	cnt =3D reg >> SUN6I_FIFO_STA_RF_CNT_POS;
> =20
>  	if (len > cnt)
>  		len =3D cnt;
> @@ -177,6 +182,15 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_=
spi *sspi, int len)
>  	}
>  }
> =20
> +static bool sun6i_spi_can_dma(struct spi_master *master,
> +			      struct spi_device *spi,
> +			      struct spi_transfer *tfr)
> +{
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +
> +	return tfr->len > sspi->fifo_depth;
> +}
> +
>  static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	struct sun6i_spi *sspi =3D spi_master_get_devdata(spi->master);
> @@ -208,6 +222,9 @@ static size_t sun6i_spi_max_transfer_size(struct spi_=
device *spi)
>  	struct spi_master *master =3D spi->master;
>  	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> =20
> +	if (master->can_dma)
> +		return SUN6I_MAX_XFER_SIZE;
> +
>  	return sspi->fifo_depth;
>  }
> =20
> @@ -268,16 +285,187 @@ static int sun6i_spi_wait_for_transfer(struct spi_=
device *spi,
>  	return 0;
>  }
> =20
> +static void sun6i_spi_dma_callback(void *param)
> +{
> +	struct spi_master *master =3D param;
> +
> +	dev_dbg(&master->dev, "DMA transfer complete\n");
> +	spi_finalize_current_transfer(master);
> +}
> +
> +static int sun6i_spi_dmap_prep_tx(struct spi_master *master,
> +				  struct spi_transfer *tfr,
> +				  dma_cookie_t *cookie)
> +{
> +	struct dma_async_tx_descriptor *chan_desc =3D NULL;
> +
> +	chan_desc =3D dmaengine_prep_slave_sg(master->dma_tx,
> +					    tfr->tx_sg.sgl, tfr->tx_sg.nents,
> +					    DMA_TO_DEVICE,
> +					    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!chan_desc) {
> +		dev_err(&master->dev,
> +			"Couldn't prepare TX DMA slave\n");
> +		return -EIO;
> +	}
> +
> +	chan_desc->callback =3D sun6i_spi_dma_callback;
> +	chan_desc->callback_param =3D master;
> +
> +	*cookie =3D dmaengine_submit(chan_desc);
> +	dma_async_issue_pending(master->dma_tx);
> +
> +	return 0;
> +}
> +
> +static int sun6i_spi_dmap_prep_rx(struct spi_master *master,
> +				  struct spi_transfer *tfr,
> +				  dma_cookie_t *cookie)
> +{
> +	struct dma_async_tx_descriptor *chan_desc =3D NULL;
> +
> +	chan_desc =3D dmaengine_prep_slave_sg(master->dma_rx,
> +					    tfr->rx_sg.sgl, tfr->rx_sg.nents,
> +					    DMA_FROM_DEVICE,
> +					    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!chan_desc) {
> +		dev_err(&master->dev,
> +			"Couldn't prepare RX DMA slave\n");
> +		return -EIO;
> +	}
> +
> +	chan_desc->callback =3D sun6i_spi_dma_callback;
> +	chan_desc->callback_param =3D master;
> +
> +	*cookie =3D dmaengine_submit(chan_desc);
> +	dma_async_issue_pending(master->dma_rx);
> +
> +	return 0;
> +}
> +
> +static int sun6i_spi_transfer_one_dma(struct spi_device *spi,
> +				      struct spi_transfer *tfr)
> +{
> +	struct spi_master *master =3D spi->master;
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +	dma_cookie_t tx_cookie =3D 0,rx_cookie =3D 0;
> +	enum dma_status status;
> +	int ret;
> +	u32 reg, trig_level =3D 0;
> +
> +	dev_dbg(&master->dev, "Using DMA mode for transfer\n");
> +
> +	/* Disable interrupts */
> +	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
> +
> +	reg =3D sun6i_spi_read(sspi, SUN6I_FIFO_CTL_REG);
> +
> +	if (sspi->tx_buf) {
> +		ret =3D sun6i_spi_dmap_prep_tx(master, tfr, &tx_cookie);
> +		if (ret)
> +			goto out;
> +
> +		reg |=3D SUN6I_FIFO_CTL_TF_DRQ_EN;
> +
> +		trig_level =3D sspi->fifo_depth;
> +		reg &=3D ~SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK;
> +		reg |=3D (trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_POS);
> +	}
> +
> +	if (sspi->rx_buf) {
> +		ret =3D sun6i_spi_dmap_prep_rx(master, tfr, &rx_cookie);
> +		if (ret)
> +			goto out;
> +
> +		reg |=3D SUN6I_FIFO_CTL_RF_DRQ_EN;
> +
> +		trig_level =3D 1;
> +		reg &=3D ~SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK;
> +		reg |=3D (trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS);
> +	}
> +
> +	/* Enable Dedicated DMA requests */
> +	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> +			reg | SUN6I_FIFO_CTL_DMA_DEDICATE);
> +
> +	/* Start transfer */
> +	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
> +
> +	ret =3D sun6i_spi_wait_for_transfer(spi, tfr);
> +	if (ret)
> +		goto out;
> +
> +	if (sspi->tx_buf && (status =3D dma_async_is_tx_complete(master->dma_tx,
> +			tx_cookie, NULL, NULL))) {
> +		dev_warn(&master->dev,
> +			"DMA returned completion status of: %s\n",
> +			status =3D=3D DMA_ERROR ? "error" : "in progress");
> +	}
> +	if (sspi->rx_buf && (status =3D dma_async_is_tx_complete(master->dma_rx,
> +			rx_cookie, NULL, NULL))) {
> +		dev_warn(&master->dev,
> +			"DMA returned completion status of: %s\n",
> +			status =3D=3D DMA_ERROR ? "error" : "in progress");
> +	}

I'm not sure why that would be needed.

> +out:
> +	if (ret) {
> +		dev_dbg(&master->dev, "DMA channel teardown\n");
> +		if (sspi->tx_buf)
> +			dmaengine_terminate_sync(master->dma_tx);
> +		if (sspi->rx_buf)
> +			dmaengine_terminate_sync(master->dma_rx);
> +	}

That can be addressed through additional labels.

> +	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);

Why are you doing a PIO access here?

> +	return ret;
> +}
> +
> +static int sun6i_spi_transfer_one_pio(struct spi_device *spi,
> +				      struct spi_transfer *tfr)
> +{
> +	struct spi_master *master =3D spi->master;
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +	unsigned int trig_level;
> +	int ret;
> +
> +	/* Disable DMA requests */
> +	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG, 0);
> +
> +	/*
> +	 * Setup FIFO interrupt trigger level
> +	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
> +	 * value used in old generation of Allwinner SPI controller.
> +	 * (See spi-sun4i.c)
> +	 */
> +	trig_level =3D sspi->fifo_depth / 4 * 3;
> +	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> +			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS));
> +
> +	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> +
> +	/* Enable the interrupts */
> +	sun6i_spi_set(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC |
> +					       SUN6I_INT_CTL_RF_RDY);
> +
> +	/* Start transfer */
> +	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
> +
> +	ret =3D sun6i_spi_wait_for_transfer(spi, tfr);
> +
> +	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
> +
> +	return ret;
> +}
> +
>  static int sun6i_spi_transfer_one(struct spi_master *master,
>  				  struct spi_device *spi,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> -	unsigned int mclk_rate, div, timeout;
> -	unsigned int start, end, tx_time;
> -	unsigned int trig_level;
> +	unsigned int mclk_rate, div;
>  	unsigned int tx_len =3D 0;
> -	int ret =3D 0;
>  	u32 reg;
> =20
>  	/* A zero length transfer never finishes if programmed
> @@ -285,10 +473,15 @@ static int sun6i_spi_transfer_one(struct spi_master=
 *master,
>  	if (!tfr->len)
>  		return 0;
> =20
> -	/* Don't support transfer larger than the FIFO */
> -	if (tfr->len > sspi->fifo_depth)
> +	if (tfr->len > SUN6I_MAX_XFER_SIZE)
>  		return -EMSGSIZE;
> =20
> +	if (!master->can_dma) {
> +		/* Don't support transfer larger than the FIFO */
> +		if (tfr->len > sspi->fifo_depth)
> +			return -EMSGSIZE;
> +	}
> +
>  	sspi->tx_buf =3D tfr->tx_buf;
>  	sspi->rx_buf =3D tfr->rx_buf;
>  	sspi->len =3D tfr->len;
> @@ -300,16 +493,6 @@ static int sun6i_spi_transfer_one(struct spi_master =
*master,
>  	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
>  			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
> =20
> -	/*
> -	 * Setup FIFO interrupt trigger level
> -	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
> -	 * value used in old generation of Allwinner SPI controller.
> -	 * (See spi-sun4i.c)
> -	 */
> -	trig_level =3D sspi->fifo_depth / 4 * 3;
> -	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> -			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
> -
>  	/*
>  	 * If it's a TX only transfer, we don't want to fill the RX
>  	 * FIFO with bogus data
> @@ -364,22 +547,10 @@ static int sun6i_spi_transfer_one(struct spi_master=
 *master,
>  	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
>  			SUN6I_BURST_CTL_CNT_STC(tx_len));
> =20
> -	/* Fill the TX FIFO */
> -	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> -
> -	/* Enable the interrupts */
> -	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
> -					 SUN6I_INT_CTL_RF_RDY);
> -
> -	/* Start the transfer */
> -	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
> -
> -	/* Wait for completion */
> -	ret =3D sun6i_spi_wait_for_transfer(spi, tfr);
> -
> -	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
> +	if (sun6i_spi_can_dma(master, spi, tfr))
> +		return sun6i_spi_transfer_one_dma(spi, tfr);
> =20
> -	return ret;
> +	return sun6i_spi_transfer_one_pio(spi, tfr);

You should really split the function creation here into a separate patch

>  }
> =20
>  static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
> @@ -409,6 +580,77 @@ static irqreturn_t sun6i_spi_handler(int irq, void *=
dev_id)
>  	return IRQ_NONE;
>  }
> =20
> +static int sun6i_spi_dma_setup(struct platform_device *pdev,
> +			       struct resource *res)
> +{
> +	struct spi_master *master =3D platform_get_drvdata(pdev);
> +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> +	struct dma_slave_config dma_sconf;
> +	int ret;
> +
> +	master->dma_tx =3D dma_request_slave_channel_reason(&pdev->dev, "tx");
> +	if (IS_ERR(master->dma_tx)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA TX channel\n");
> +		ret =3D PTR_ERR(master->dma_tx);
> +		goto out;
> +	}
> +
> +	dma_sconf.direction =3D DMA_MEM_TO_DEV;
> +	dma_sconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconf.dst_addr =3D res->start + SUN6I_TXDATA_REG;
> +	dma_sconf.dst_maxburst =3D 1;
> +	dma_sconf.src_maxburst =3D 1;
> +
> +	ret =3D dmaengine_slave_config(master->dma_tx, &dma_sconf);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to configure DMA TX slave\n");
> +		goto err_rel_tx;
> +	}
> +
> +	master->dma_rx =3D dma_request_slave_channel_reason(&pdev->dev, "rx");
> +	if (IS_ERR(master->dma_rx)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA RX channel\n");
> +		ret =3D PTR_ERR(master->dma_rx);
> +		goto err_rel_tx;
> +	}
> +
> +	dma_sconf.direction =3D DMA_DEV_TO_MEM;
> +	dma_sconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconf.src_addr =3D res->start + SUN6I_RXDATA_REG;
> +	dma_sconf.src_maxburst =3D 1;
> +	dma_sconf.dst_maxburst =3D 1;
> +
> +	ret =3D dmaengine_slave_config(master->dma_rx, &dma_sconf);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to configure DMA RX slave\n");
> +		goto err_rel_rx;
> +	}
> +
> +	/* don't set can_dma unless both channels are valid*/
> +	master->can_dma =3D sun6i_spi_can_dma;
> +
> +	return 0;
> +
> +err_rel_rx:
> +	dma_release_channel(master->dma_rx);
> +err_rel_tx:
> +	dma_release_channel(master->dma_tx);
> +out:
> +	master->dma_tx =3D NULL;
> +	master->dma_rx =3D NULL;
> +	return ret;
> +}
> +
> +static void sun6i_spi_dma_release(struct spi_master *master)
> +{
> +	if (master->can_dma) {
> +		dma_release_channel(master->dma_rx);
> +		dma_release_channel(master->dma_tx);
> +	}
> +}
> +
>  static int sun6i_spi_runtime_resume(struct device *dev)
>  {
>  	struct spi_master *master =3D dev_get_drvdata(dev);
> @@ -530,6 +772,16 @@ static int sun6i_spi_probe(struct platform_device *p=
dev)
>  		goto err_free_master;
>  	}
> =20
> +	ret =3D sun6i_spi_dma_setup(pdev, res);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER) {
> +			/* wait for the dma driver to load */

There's no need for that comment.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7tspdc6l4hljay2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEeBcACgkQ0rTAlCFN
r3SBAw//Vf99TKHsfMsG0KBZTjOhe0D1f0NvNw7E0q5HAvWJ5imJZKJ2YOHFbACl
4rfPWs9cH8JLvMKw6YdRI5nFeP8GERJSefwpUanXW0GBAgBsH2a5hVFeDwTFMjW9
4tcCzYjDn+pIaJuMuwrg4JwIpYHeX7B8J/t+mPzRw0TG0zZY+XRI5tpc2zjWufJI
GT23m2N7xCXSiYWWZiN9oTsEeoq0f6X/lnOsWebYOkdj8FE+qJ+QGpmOziPO5gc4
NcSWhLr9mNnhf3qoUYnYpMGmgmcQohni61HDJ1yJ85nhYFg8vSdQWP8Xduf9HDJA
0FxJBwvJ/NVfeWGi2bmGZbsTNxYYU/YEiUrq/fNLxlfydAQZnmoFbVVcgXyVf6HE
OPYQ22vpggvp2P65QKtcOVu53cRs3Qb4iJF3jv1HJwvosaemR/ZFz1+KiRsBczvA
GCcS+4QLfbqgFE4OZ69vaM8Dzb9XtiXBD0s2YFJ0MSDQQ4XMdlvoj25grpmvw9hu
RRRTy4Qdg4WUkcZGqTrrcm6WD+NBks8IQ0awx12QuhXXsEiq4FjndN9UK7NFKqSQ
jnmrH3eFvxiHD+VXCflMM7Uoy1hlBeV8gVxAfSuUlaD7con3kAurD4ysbuNKA9Fv
AAbCk0k93xg7Bx8VXK4uYgxMCuE4m6VhOxi//eWx3IPFb1pAIlA=
=8zR7
-----END PGP SIGNATURE-----

--7tspdc6l4hljay2w--
