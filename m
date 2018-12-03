Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D69B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D69B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLCKz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:55:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58457 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:55:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E8EA20747; Mon,  3 Dec 2018 11:54:50 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D9DE2039F;
        Mon,  3 Dec 2018 11:54:40 +0100 (CET)
Date:   Mon, 3 Dec 2018 11:54:40 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 01/10] dma-engine: sun4i: Add a quirk to support
 different chips
Message-ID: <20181203105440.jxy6ue75ic2fc5t5@flea>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzmbnq5naxbvf7yw"
Content-Disposition: inline
In-Reply-To: <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzmbnq5naxbvf7yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(you don't really need the RFC tag. RFC tags are usually meant to ask
comments on the general approach, not the implementation).

On Mon, Dec 03, 2018 at 12:23:08AM +0300, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
> registers has different addresses. Total dma channels, endpoint counts
> and max burst counts are also different.
>=20
> In order to support F1C100s add a quirk structure to hold IC specific
> data.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/dma/sun4i-dma.c | 138 +++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 106 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index f4ed3f1..e86b424 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -34,6 +35,8 @@
>  #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>  #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
> =20
> +#define SUN4I_MAX_BURST	8
> +
>  /** Normal DMA register values **/
> =20
>  /* Normal DMA source/destination data request type values */
> @@ -126,6 +129,32 @@
>  	 SUN4I_DDMA_PARA_DST_WAIT_CYCLES(2) |				\
>  	 SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(2))
> =20
> +/*
> + * Hardware channels / ports representation
> + *
> + * The hardware is used in several SoCs, with differing numbers
> + * of channels and endpoints. This structure ties those numbers
> + * to a certain compatible string.
> + */
> +struct sun4i_dma_config {
> +	u32 ndma_nr_max_channels;
> +	u32 ndma_nr_max_vchans;
> +
> +	u32 ddma_nr_max_channels;
> +	u32 ddma_nr_max_vchans;
> +
> +	u32 dma_nr_max_channels;
> +
> +        void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
> +        void (*set_src_data_width)(u32 *p_cfg, s8 data_width);

This should be indented with tabs, not spaces.

> +	int (*convert_burst)(u32 maxburst);
> +
> +	u8 ndma_drq_sdram;
> +	u8 ddma_drq_sdram;
> +
> +	u8 max_burst;

You'd be better off using a bitmask wit hthe supported bursts, like
we're doing in sun6i-dma.

> +};
> +
>  struct sun4i_dma_pchan {
>  	/* Register base of channel */
>  	void __iomem			*base;
> @@ -163,7 +192,7 @@ struct sun4i_dma_contract {
>  };
> =20
>  struct sun4i_dma_dev {
> -	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
> +	unsigned long *pchans_used;
>  	struct dma_device		slave;
>  	struct sun4i_dma_pchan		*pchans;
>  	struct sun4i_dma_vchan		*vchans;
> @@ -171,6 +200,7 @@ struct sun4i_dma_dev {
>  	struct clk			*clk;
>  	int				irq;
>  	spinlock_t			lock;
> +	const struct sun4i_dma_config *cfg;

This should be aligned to the rest of the members, using tabs.

>  };
> =20
>  static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -193,7 +223,17 @@ static struct device *chan2dev(struct dma_chan *chan)
>  	return &chan->dev->device;
>  }
> =20
> -static int convert_burst(u32 maxburst)
> +static void set_dst_data_width_a10(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |=3D SUN4I_DMA_CFG_DST_DATA_WIDTH(data_width);
> +}
> +
> +static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |=3D SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
> +}
> +
> +static int convert_burst_a10(u32 maxburst)
>  {
>  	if (maxburst > 8)
>  		return -EINVAL;
> @@ -226,15 +266,15 @@ static struct sun4i_dma_pchan *find_and_use_pchan(s=
truct sun4i_dma_dev *priv,
>  	int i, max;
> =20
>  	/*
> -	 * pchans 0-SUN4I_NDMA_NR_MAX_CHANNELS are normal, and
> -	 * SUN4I_NDMA_NR_MAX_CHANNELS+ are dedicated ones
> +	 * pchans 0-priv->cfg->ndma_nr_max_channels are normal, and
> +	 * priv->cfg->ndma_nr_max_channels+ are dedicated ones

This should be next to the structure you just created.

>  	 */
>  	if (vchan->is_dedicated) {
> -		i =3D SUN4I_NDMA_NR_MAX_CHANNELS;
> -		max =3D SUN4I_DMA_NR_MAX_CHANNELS;
> +		i =3D priv->cfg->ndma_nr_max_channels;
> +		max =3D priv->cfg->dma_nr_max_channels;
>  	} else {
>  		i =3D 0;
> -		max =3D SUN4I_NDMA_NR_MAX_CHANNELS;
> +		max =3D priv->cfg->ndma_nr_max_channels;
>  	}
> =20
>  	spin_lock_irqsave(&priv->lock, flags);
> @@ -437,6 +477,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr=
_t src, dma_addr_t dest,
>  		      size_t len, struct dma_slave_config *sconfig,
>  		      enum dma_transfer_direction direction)
>  {
> +	struct sun4i_dma_dev *priv =3D to_sun4i_dma_dev(chan->device);
>  	struct sun4i_dma_promise *promise;
>  	int ret;
> =20
> @@ -460,13 +501,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_ad=
dr_t src, dma_addr_t dest,
>  		sconfig->src_addr_width, sconfig->dst_addr_width);
> =20
>  	/* Source burst */
> -	ret =3D convert_burst(sconfig->src_maxburst);
> +	ret =3D priv->cfg->convert_burst(sconfig->src_maxburst);
>  	if (ret < 0)
>  		goto fail;
>  	promise->cfg |=3D SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
> =20
>  	/* Destination burst */
> -	ret =3D convert_burst(sconfig->dst_maxburst);
> +	ret =3D priv->cfg->convert_burst(sconfig->dst_maxburst);
>  	if (ret < 0)
>  		goto fail;
>  	promise->cfg |=3D SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
> @@ -475,13 +516,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_ad=
dr_t src, dma_addr_t dest,
>  	ret =3D convert_buswidth(sconfig->src_addr_width);
>  	if (ret < 0)
>  		goto fail;
> -	promise->cfg |=3D SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
> +	priv->cfg->set_src_data_width(&promise->cfg, ret);
> =20
>  	/* Destination bus width */
>  	ret =3D convert_buswidth(sconfig->dst_addr_width);
>  	if (ret < 0)
>  		goto fail;
> -	promise->cfg |=3D SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
> +	priv->cfg->set_dst_data_width(&promise->cfg, ret);
> =20
>  	return promise;
> =20
> @@ -503,6 +544,7 @@ static struct sun4i_dma_promise *
>  generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t =
dest,
>  		      size_t len, struct dma_slave_config *sconfig)
>  {
> +	struct sun4i_dma_dev *priv =3D to_sun4i_dma_dev(chan->device);
>  	struct sun4i_dma_promise *promise;
>  	int ret;
> =20
> @@ -517,13 +559,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_ad=
dr_t src, dma_addr_t dest,
>  		SUN4I_DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
> =20
>  	/* Source burst */
> -	ret =3D convert_burst(sconfig->src_maxburst);
> +	ret =3D priv->cfg->convert_burst(sconfig->src_maxburst);
>  	if (ret < 0)
>  		goto fail;
>  	promise->cfg |=3D SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
> =20
>  	/* Destination burst */
> -	ret =3D convert_burst(sconfig->dst_maxburst);
> +	ret =3D priv->cfg->convert_burst(sconfig->dst_maxburst);
>  	if (ret < 0)
>  		goto fail;
>  	promise->cfg |=3D SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
> @@ -532,13 +574,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_ad=
dr_t src, dma_addr_t dest,
>  	ret =3D convert_buswidth(sconfig->src_addr_width);
>  	if (ret < 0)
>  		goto fail;
> -	promise->cfg |=3D SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
> +	priv->cfg->set_src_data_width(&promise->cfg, ret);
> =20
>  	/* Destination bus width */
>  	ret =3D convert_buswidth(sconfig->dst_addr_width);
>  	if (ret < 0)
>  		goto fail;
> -	promise->cfg |=3D SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
> +	priv->cfg->set_dst_data_width(&promise->cfg, ret);
> =20
>  	return promise;
> =20
> @@ -615,6 +657,7 @@ static struct dma_async_tx_descriptor *
>  sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
>  			  dma_addr_t src, size_t len, unsigned long flags)
>  {
> +	struct sun4i_dma_dev *priv =3D to_sun4i_dma_dev(chan->device);
>  	struct sun4i_dma_vchan *vchan =3D to_sun4i_dma_vchan(chan);
>  	struct dma_slave_config *sconfig =3D &vchan->cfg;
>  	struct sun4i_dma_promise *promise;
> @@ -631,8 +674,8 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_=
addr_t dest,
>  	 */
>  	sconfig->src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	sconfig->dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> -	sconfig->src_maxburst =3D 8;
> -	sconfig->dst_maxburst =3D 8;
> +	sconfig->src_maxburst =3D priv->cfg->max_burst;
> +	sconfig->dst_maxburst =3D priv->cfg->max_burst;
> =20
>  	if (vchan->is_dedicated)
>  		promise =3D generate_ddma_promise(chan, src, dest, len, sconfig);
> @@ -647,11 +690,13 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dm=
a_addr_t dest,
> =20
>  	/* Configure memcpy mode */
>  	if (vchan->is_dedicated) {
> -		promise->cfg |=3D SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM=
) |
> -				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM);
> +		promise->cfg |=3D
> +			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ddma_drq_sdram) |
> +			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ddma_drq_sdram);
>  	} else {
> -		promise->cfg |=3D SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM=
) |
> -				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
> +		promise->cfg |=3D
> +			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
> +			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
>  	}
> =20
>  	/* Fill the contract with our only promise */
> @@ -666,6 +711,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_=
addr_t buf, size_t len,
>  			  size_t period_len, enum dma_transfer_direction dir,
>  			  unsigned long flags)
>  {
> +	struct sun4i_dma_dev *priv =3D to_sun4i_dma_dev(chan->device);
>  	struct sun4i_dma_vchan *vchan =3D to_sun4i_dma_vchan(chan);
>  	struct dma_slave_config *sconfig =3D &vchan->cfg;
>  	struct sun4i_dma_promise *promise;
> @@ -701,7 +747,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_=
addr_t buf, size_t len,
>  	if (dir =3D=3D DMA_MEM_TO_DEV) {
>  		src =3D buf;
>  		dest =3D sconfig->dst_addr;
> -		endpoints =3D SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
> +		endpoints =3D SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
>  			    SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
>  			    SUN4I_DMA_CFG_DST_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO);
>  	} else {
> @@ -709,7 +755,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_=
addr_t buf, size_t len,
>  		dest =3D buf;
>  		endpoints =3D SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
>  			    SUN4I_DMA_CFG_SRC_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO) |
> -			    SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
> +			    SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
>  	}
> =20
>  	/*
> @@ -772,6 +818,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct=
 scatterlist *sgl,
>  			unsigned int sg_len, enum dma_transfer_direction dir,
>  			unsigned long flags, void *context)
>  {
> +	struct sun4i_dma_dev *priv =3D to_sun4i_dma_dev(chan->device);
>  	struct sun4i_dma_vchan *vchan =3D to_sun4i_dma_vchan(chan);
>  	struct dma_slave_config *sconfig =3D &vchan->cfg;
>  	struct sun4i_dma_promise *promise;
> @@ -797,11 +844,11 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, stru=
ct scatterlist *sgl,
>  	if (vchan->is_dedicated) {
>  		io_mode =3D SUN4I_DDMA_ADDR_MODE_IO;
>  		linear_mode =3D SUN4I_DDMA_ADDR_MODE_LINEAR;
> -		ram_type =3D SUN4I_DDMA_DRQ_TYPE_SDRAM;
> +		ram_type =3D priv->cfg->ddma_drq_sdram;
>  	} else {
>  		io_mode =3D SUN4I_NDMA_ADDR_MODE_IO;
>  		linear_mode =3D SUN4I_NDMA_ADDR_MODE_LINEAR;
> -		ram_type =3D SUN4I_NDMA_DRQ_TYPE_SDRAM;
> +		ram_type =3D priv->cfg->ndma_drq_sdram;
>  	}
> =20
>  	if (dir =3D=3D DMA_MEM_TO_DEV)
> @@ -1130,6 +1177,10 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	priv->cfg =3D of_device_get_match_data(&pdev->dev);
> +	if (!priv->cfg)
> +		return -ENODEV;
> +
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base))
> @@ -1178,23 +1229,26 @@ static int sun4i_dma_probe(struct platform_device=
 *pdev)
> =20
>  	priv->slave.dev =3D &pdev->dev;
> =20
> -	priv->pchans =3D devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_CHANNELS,
> +	priv->pchans =3D devm_kcalloc(&pdev->dev, priv->cfg->dma_nr_max_channel=
s,
>  				    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
>  	priv->vchans =3D devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_VCHANS,
>  				    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
> -	if (!priv->vchans || !priv->pchans)
> +	priv->pchans_used =3D devm_kcalloc(&pdev->dev,
> +			BITS_TO_LONGS(priv->cfg->dma_nr_max_channels),
> +			sizeof(unsigned long), GFP_KERNEL);

I'm not sure we really need a dynamic allocation here. Just keep the
bitmap, and use the bigger size.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kzmbnq5naxbvf7yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAULcAAKCRDj7w1vZxhR
xTSWAP9QOg4x7/ccG0wWsCikWJNVgUsiaz8x3lC+zHtbqBoJMAD/aWdaSn0KQo4i
jEsodKmVyMSSC/cRWU+Ayw1fYhzpgAo=
=HFAR
-----END PGP SIGNATURE-----

--kzmbnq5naxbvf7yw--
