Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA163C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E649220856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM+xQkZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E649220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeICA23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICA23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:28:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799D820837;
        Sun,  2 Sep 2018 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535919093;
        bh=hwfdmOIcG88zrlzIL2hIr9sKj11BSK1JuQund55fUHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GM+xQkZq5kL08bbHJuJ8iCEGl1pllCYzz2h9N7ETo9PkSGBJ3zz9UbgOYLiswPL0X
         KTjsNVEFFDSVxGBfv14l5VinfYRlNene9K+hGF5x0zoeZ5Wtbl+TmTwWdv4D/ve9D2
         tL7VHDO/rGo+dBOLF/f/Hig126iAzDE3mUPf6zqA=
Date:   Sun, 2 Sep 2018 21:11:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180902211125.0098c808@archlinux>
In-Reply-To: <20180830154518.29507-19-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-19-embed3d@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 17:45:06 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> For adding newer sensor some basic rework of the code is necessary.
> 
> This patch reworks the driver to be able to handle more than one
> thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
> Because of this the maximal sensor count value was set to 4.
> 
> The sensor_id value is set during sensor registration and is for each
> registered sensor indiviual. This makes it able to differntiate the
> sensors when the value is read from the register.
> 
> In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
> was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
> in the temp_read function automatically sensor 0. A check for the
> sensor_id is here not required since the old sensors only have one
> thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
> function only used by the "older" sensors (before A33) where the
> thermal sensor was a cobination of an adc and a thermal sensor.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
One additional comment inline..

Just a suggestion to make things slightly easier to read / review.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c   | 63 +++++++++++++++++++++++++------------
>  include/linux/iio/adc/sun4i-gpadc.h |  3 ++
>  2 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index c12de48c4e86..18ab72e52d78 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -69,6 +69,7 @@ struct gpadc_data {
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
>  	u32		temp_data_base;
> +	int		sensor_count;
>  };
>  
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -84,6 +85,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count = 1,
>  };
>  
>  static const struct gpadc_data sun5i_gpadc_data = {
> @@ -97,6 +99,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count = 1,
>  };
>  
>  static const struct gpadc_data sun6i_gpadc_data = {
> @@ -110,6 +113,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
>  	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
>  	.support_irq = true,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count = 1,
>  };
>  
>  static const struct gpadc_data sun8i_a33_gpadc_data = {
> @@ -117,6 +121,13 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.temp_scale = 162,
>  	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
>  	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count = 1,
> +};
> +
> +struct sun4i_sensor_tzd {
> +	struct sun4i_gpadc_iio		*info;
> +	struct thermal_zone_device	*tzd;
> +	unsigned int			sensor_id;
>  };
>  
>  struct sun4i_gpadc_iio {
> @@ -130,7 +141,7 @@ struct sun4i_gpadc_iio {
>  	const struct gpadc_data		*data;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
> -	struct thermal_zone_device	*tzd;
> +	struct sun4i_sensor_tzd		tzds[MAX_SENSOR_COUNT];
>  	struct device			*sensor_device;
>  	struct clk			*bus_clk;
>  	struct clk			*mod_clk;
> @@ -280,7 +291,8 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  			SUN4I_GPADC_IRQ_FIFO_DATA);
>  }
>  
> -static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
> +				int sensor)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
>  
> @@ -290,7 +302,8 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  
>  	pm_runtime_get_sync(indio_dev->dev.parent);
>  
> -	regmap_read(info->regmap, info->data->temp_data_base, val);
> +	regmap_read(info->regmap, info->data->temp_data_base + 0x4 * sensor,
> +			val);
>  
>  	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>  	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> @@ -334,7 +347,7 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
>  			ret = sun4i_gpadc_adc_read(indio_dev, chan->channel,
>  						   val);
>  		else
> -			ret = sun4i_gpadc_temp_read(indio_dev, val);
> +			ret = sun4i_gpadc_temp_read(indio_dev, val, 0);
>  
>  		if (ret)
>  			return ret;
> @@ -420,10 +433,11 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>  
>  static int sun4i_gpadc_get_temp(void *data, int *temp)
>  {
> -	struct sun4i_gpadc_iio *info = data;
> +	struct sun4i_sensor_tzd *tzd = data;
> +	struct sun4i_gpadc_iio *info = tzd->info;
>  	int val, scale, offset;
>  
> -	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> +	if (sun4i_gpadc_temp_read(info->indio_dev, &val, tzd->sensor_id))
>  		return -ETIMEDOUT;
>  
>  	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
> @@ -569,7 +583,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_gpadc_iio *info;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, i;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>  	if (!indio_dev)
> @@ -603,18 +617,24 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> -	info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
> -						    0, info,
> -						    &sun4i_ts_tz_ops);
> -	/*
> -	 * Do not fail driver probing when failing to register in
> -	 * thermal because no thermal DT node is found.
> -	 */
> -	if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
> -		dev_err(&pdev->dev,
> -			"could not register thermal sensor: %ld\n",
> -			PTR_ERR(info->tzd));
> -		return PTR_ERR(info->tzd);
> +	for (i = 0; i < info->data->sensor_count; i++) {

This feels like a good place to factor out the code into a utility
function that just does one of them.  That should hopefully
reduce the indenting etc enough to make the code easier to read.

> +		info->tzds[i].info = info;
> +		info->tzds[i].sensor_id = i;
> +
> +		info->tzds[i].tzd = thermal_zone_of_sensor_register(
> +				info->sensor_device,
> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
> +		/*
> +		 * Do not fail driver probing when failing to register in
> +		 * thermal because no thermal DT node is found.
> +		 */
> +		if (IS_ERR(info->tzds[i].tzd) && \
> +				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
> +			dev_err(&pdev->dev,
> +				"could not register thermal sensor: %ld\n",
> +				PTR_ERR(info->tzds[i].tzd));
> +			return PTR_ERR(info->tzds[i].tzd);
> +		}
>  	}
>  
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> @@ -639,11 +659,14 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
> +	int i;
>  
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> -	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
> +	for (i = 0; i < info->data->sensor_count; i++)
> +		thermal_zone_of_sensor_unregister(info->sensor_device,
> +						  info->tzds[i].tzd);
>  
>  	if (!info->data->support_irq)
>  		iio_map_array_unregister(indio_dev);
> diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
> index d6850f39dcfb..99feeba28105 100644
> --- a/include/linux/iio/adc/sun4i-gpadc.h
> +++ b/include/linux/iio/adc/sun4i-gpadc.h
> @@ -99,4 +99,7 @@
>  	.datasheet_name = _name,				\
>  }
>  
> +/* SUNXI_THS COMMON REGISTERS + DEFINES */
> +#define MAX_SENSOR_COUNT				4
> +
>  #endif

