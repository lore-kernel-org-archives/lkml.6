Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B491C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C220652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2C220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHaN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:58:39 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58571 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeHaN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:58:39 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EF49442097;
        Fri, 31 Aug 2018 09:51:47 +0000 (UTC)
Message-ID: <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
Subject: Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Philipp Rossak <embed3d@gmail.com>
Cc:     mark.rutland@arm.com, geert+renesas@glider.be,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-sunxi@googlegroups.com, clabbe.montjoie@gmail.com,
        pmeerw@pmeerw.net, lee.jones@linaro.org, lars@metafoo.de,
        quentin.schulz@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        devicetree@vger.kernel.org, arnd@arndb.de, vilhelm.gray@gmail.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        rdunlap@infradead.org, arnaud.pouliquen@st.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de, knaack.h@gmx.de,
        eugen.hristev@microchip.com, jic23@kernel.org
Date:   Fri, 31 Aug 2018 17:51:41 +0800
In-Reply-To: <20180831091137.wkbbipssyd6mqfbt@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
         <20180830154518.29507-22-embed3d@gmail.com>
         <20180831091137.wkbbipssyd6mqfbt@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-08-31五的 11:11 +0200，Maxime Ripard写道：
> On Thu, Aug 30, 2018 at 05:45:09PM +0200, Philipp Rossak wrote:
> > This patch adds support for the H3 ths sensor.
> > 
> > The H3 supports interrupts. The interrupt is configured to update
> > the
> > the sensor values every second. The calibration data is writen at
> > the
> > begin of the init process.
> > 
> > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > ---
> >  drivers/iio/adc/sun4i-gpadc-iio.c   | 91
> > +++++++++++++++++++++++++++++++++++++
> >  include/linux/iio/adc/sun4i-gpadc.h | 18 ++++++++
> >  2 files changed, 109 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c
> > b/drivers/iio/adc/sun4i-gpadc-iio.c
> > index c7b46c82e3e5..d5c7971b2558 100644
> > --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> > +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> > @@ -72,6 +72,7 @@ struct gpadc_data {
> >  	u32		temp_data_base;
> >  	int		sensor_count;
> >  	bool		supports_nvmem;
> > +	u32		ths_irq_clear;
> >  };
> >  
> >  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void
> > *dev_id);
> > @@ -79,6 +80,10 @@ static irqreturn_t
> > sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> >  static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
> >  static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
> >  
> > +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
> > +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
> > +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
> > +
> >  static const struct gpadc_data sun4i_gpadc_data = {
> >  	.temp_offset = -1932,
> >  	.temp_scale = 133,
> > @@ -137,6 +142,22 @@ static const struct gpadc_data
> > sun8i_a33_gpadc_data = {
> >  	.sensor_count = 1,
> >  };
> >  
> > +static const struct gpadc_data sun8i_h3_ths_data = {
> > +	.temp_offset = -1791,
> > +	.temp_scale = -121,
> > +	.temp_data_base = SUN8I_H3_THS_TDATA0,
> > +	.ths_irq_thread = sunx8i_h3_irq_thread,
> > +	.support_irq = true,
> > +	.has_bus_clk = true,
> > +	.has_bus_rst = true,
> > +	.has_mod_clk = true,
> > +	.sensor_count = 1,
> > +	.supports_nvmem = true,
> > +	.ths_resume = sun8i_h3_ths_resume,
> > +	.ths_suspend = sun8i_h3_ths_suspend,
> > +	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0,
> > +};
> > +
> >  struct sun4i_sensor_tzd {
> >  	struct sun4i_gpadc_iio		*info;
> >  	struct thermal_zone_device	*tzd;
> > @@ -409,6 +430,31 @@ static irqreturn_t
> > sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data)
> > +{
> > +	struct sun4i_gpadc_iio *info = data;
> > +	int i;
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> > +			info->data->ths_irq_clear);
> > +
> > +	for (i = 0; i < info->data->sensor_count; i++)
> > +		thermal_zone_device_update(info->tzds[i].tzd,
> > +						THERMAL_EVENT_TEMP_SAMP
> > LE);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
> > +{
> > +//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> > +//			info->calibration_data[0]);
> > +//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> > +//			info->calibration_data[1]);
> 
> Don't put commented code.

Personally I suggest to leave out all SID or calibration related
patches here.

Currently we seems to be wrongly converting SID to big endian, however,
the orgnization of the THS calibration data on H6 shows that it's
surely little endian:

It consists a temperature value in 1/10 celsuis as unit, and some
thermal register readout values, which are the values read out at the
given temperature, and every value here (the temperature and the
readout) are all half word length.

Let the temperature value be AABB, the two readout values be XXYY and
ZZWW, the oragnization is:
BB AA YY XX WW ZZ ** ** .

When converting the SID to big endian, it becomes:
XX YY AA BB ** ** ZZ WW ,
which is non-sense, and not able to do sub-word cell addressing.

Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
whether it will break compatibility.)

Philipp, could you delay to send any code that uses SID?

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static int sun4i_gpadc_runtime_suspend(struct device *dev)
> >  {
> >  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> > @@ -428,6 +474,16 @@ static int sun4i_ths_suspend(struct
> > sun4i_gpadc_iio *info)
> >  	return 0;
> >  }
> >  
> > +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info)
> > +{
> > +	/* Disable ths interrupt */
> > +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> > +	/* Disable temperature sensor */
> > +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> > +
> > +	return 0;
> > +}
> > +
> >  static int sun4i_gpadc_runtime_resume(struct device *dev)
> >  {
> >  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> > @@ -454,6 +510,37 @@ static int sun4i_ths_resume(struct
> > sun4i_gpadc_iio *info)
> >  	return 0;
> >  }
> >  
> > +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
> > +{
> > +	u32 value;
> > +
> > +	sun8i_h3_calibrate(info);
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
> > +			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> > +			SUN8I_H3_THS_ACQ1(0x3f));
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> > +			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
> > +			SUN4I_GPADC_CTRL3_FILTER_EN |
> > +			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
> > +			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> > +			SUN8I_H3_THS_TEMP_PERIOD(0x55));
> > +
> > +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
> > +
> > +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> > +			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);
> 
> Ideally, all these values should have a comment explaining what they
> are.
> 
> And we really start to have a lot of registers defines. We'd be
> better
> off using regmap_fields.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

