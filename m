Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB544C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DB720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="YCPO2lFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DB720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pmeerw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbeHARR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:17:28 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:37628 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389437AbeHARR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:17:28 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id D91D5E27F4; Wed,  1 Aug 2018 17:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pmeerw.net; s=mail;
        t=1533137471; bh=DekOIM3LzQgEXdD1vURG42gVEDtv5zhAoX980krtPQw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YCPO2lFQ12c4wv8BXTwuLE8jpgP9OK8h2cOvqN0oxvYWdmrDAoIBwnYvl3ebXEg8g
         cmFPFhHs4d3NNaQmdrYSDgXySJIpjry7OSF2GHxE7QUc/Jsk8LxZzyh14GRY89X7Sw
         KEL3Yc1mb85JYhzuGrfwZTgT8vqYm0UI4yNLpfP8=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id CE001E022C;
        Wed,  1 Aug 2018 17:31:11 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:31:11 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Stefan Popa <stefan.popa@analog.com>
cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio:adxl372: Add FIFO and interrupts support
In-Reply-To: <1533136692-31935-1-git-send-email-stefan.popa@analog.com>
Message-ID: <alpine.DEB.2.21.1808011721040.22146@vps.pmeerw.net>
References: <1533136692-31935-1-git-send-email-stefan.popa@analog.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch adds support for the adxl372 FIFO. In order to accomplish this,
> triggered buffers were used.
> 
> The number of FIFO samples which trigger the watermark interrupt can be
> configured by using the buffer watermark. The FIFO format is determined by
> configuring the scan elements for each axis. Moreover, the FIFO can also
> be configured in the XYZ peak mode.
> 
> The FIFO data is pushed to the IIO device's buffer.

some minor comments below

> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:	  
> 	- removed DT bindings changes from this patch.
> 	- removed the linux/gpio/consumer.h header.
> 	- used regmap_pipe_read() instead of regmap_bulk_read() when
> 	  reading data from the FIFO.
> 	- used multiple regmap_write() calls instead of a single
> 	  regmap_bulk_write() if there is no fast path.
> 	- used be32_to_cpu() inside the adxl372_get_status() function.
> 	- added a new in_accel_x&y&z_peak scan element which allows the
> 	  user to set the FIFO into XYZ peak mode.
> 	- used a adxl372_axis_lookup_table() to determine the fifo format
> 	  from the active_scan_mask.
> 	- made IRQ optional.
> 
>  drivers/iio/accel/adxl372.c | 362 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 361 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 7d5092d..68862bf 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -6,12 +6,19 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  /* ADXL372 registers definition */
>  #define ADXL372_DEVID			0x00
> @@ -123,6 +130,8 @@
>  #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
>  #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
>  
> +#define ADXL372_FIFO_SIZE			512

is this bytes or entries?
seems to be entries

> +
>  /*
>   * At +/- 200g with 12-bit resolution, scale is computed as:
>   * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
> @@ -164,6 +173,44 @@ enum adxl372_bandwidth {
>  	ADXL372_BW_3200HZ,
>  };
>  
> +enum adxl372_fifo_format {
> +	ADXL372_XYZ_FIFO,
> +	ADXL372_X_FIFO,
> +	ADXL372_Y_FIFO,
> +	ADXL372_XY_FIFO,
> +	ADXL372_Z_FIFO,
> +	ADXL372_XZ_FIFO,
> +	ADXL372_YZ_FIFO,
> +	ADXL372_XYZ_PEAK_FIFO,
> +};
> +
> +enum adxl372_fifo_mode {
> +	ADXL372_FIFO_BYPASSED,
> +	ADXL372_FIFO_STREAMED,
> +	ADXL372_FIFO_TRIGGERED,
> +	ADXL372_FIFO_OLD_SAVED
> +};
> +
> +static const int adxl372_samp_freq_tbl[5] = {
> +	400, 800, 1600, 3200, 6400,
> +};
> +
> +struct adxl372_axis_lookup {
> +	unsigned int bits;
> +	enum adxl372_fifo_format fifo_format;
> +};
> +
> +static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
> +	{ BIT(0), ADXL372_X_FIFO },
> +	{ BIT(1), ADXL372_Y_FIFO },
> +	{ BIT(2), ADXL372_Z_FIFO },
> +	{ BIT(0) | BIT(1), ADXL372_XY_FIFO },
> +	{ BIT(0) | BIT(2), ADXL372_XZ_FIFO },
> +	{ BIT(1) | BIT(2), ADXL372_YZ_FIFO },
> +	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
> +	{ BIT(3), ADXL372_XYZ_PEAK_FIFO }

maybe end with ,

> +};
> +
>  #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
> @@ -171,25 +218,69 @@ enum adxl372_bandwidth {
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 12,						\
> +		.storagebits = 16,					\
> +		.shift = 4,						\
> +	},								\
>  }
>  
>  static const struct iio_chan_spec adxl372_channels[] = {
>  	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
>  	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
>  	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
> +		.extend_name = "peak",
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 4,
> +		}
> +	}

end with ,

>  };
>  
>  struct adxl372_state {
>  	struct spi_device		*spi;
>  	struct regmap			*regmap;
> +	struct iio_trigger		*dready_trig;
> +	enum adxl372_fifo_mode		fifo_mode;
> +	enum adxl372_fifo_format	fifo_format;
>  	enum adxl372_op_mode		op_mode;
>  	enum adxl372_act_proc_mode	act_proc_mode;
>  	enum adxl372_odr		odr;
>  	enum adxl372_bandwidth		bw;
>  	u32				act_time_ms;
>  	u32				inact_time_ms;
> +	u8				fifo_set_size;
> +	u8				int1_bitmask;
> +	u8				int2_bitmask;
> +	u16				watermark;
> +	__be16				fifo_buf[512];

maybe use ADXL372_FIFO_SIZE here?

> +};
> +
> +static const unsigned long adxl372_channel_masks[] = {
> +	BIT(0), BIT(1), BIT(2),
> +	BIT(0) | BIT(1),
> +	BIT(0) | BIT(2),
> +	BIT(1) | BIT(2),
> +	BIT(0) | BIT(1) | BIT(2),
> +	BIT(3),
> +	0
>  };
>  
> +static int adxl372_read_fifo(struct adxl372_state *st, u16 fifo_entries)
> +{
> +	return regmap_pipe_read(st->regmap, ADXL372_FIFO_DATA,
> +				st->fifo_buf, fifo_entries * 2);

sizeof(be16) instead of 2?

> +}
> +
>  static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
>  {
>  	__be16 regval;
> @@ -364,6 +455,107 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
>  	return ret;
>  }
>  
> +static int adxl372_set_interrupts(struct adxl372_state *st,
> +				  unsigned char int1_bitmask,
> +				  unsigned char int2_bitmask)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADXL372_INT1_MAP, int1_bitmask);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADXL372_INT2_MAP, int2_bitmask);
> +}
> +
> +static int adxl372_configure_fifo(struct adxl372_state *st)
> +{
> +	unsigned int fifo_samples, fifo_ctl;
> +	int ret;
> +
> +	/* FIFO must be configured while in standby mode */
> +	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	fifo_samples = st->watermark & 0xFF;
> +	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
> +		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
> +		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
> +
> +	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADXL372_FIFO_CTL, fifo_ctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
> +}
> +
> +static int adxl372_get_status(struct adxl372_state *st,
> +			      u8 *status1, u8 *status2,
> +			      u16 *fifo_entries)
> +{
> +	__be32 buf;

the buf may be a packed struct probably?

> +	u32 val;
> +	int ret;
> +
> +	/* STATUS, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */

STATUS1 maybe?

> +	ret = regmap_bulk_read(st->regmap, ADXL372_STATUS_1,
> +			       &buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	val = be32_to_cpu(buf);
> +
> +	*status1 = val >> 24;
> +	*status2 = val >> 16;

mask missing?

> +	/*
> +	 * FIFO_ENTRIES contains the least significant byte, and FIFO_ENTRIES2
> +	 * contains the two most significant bits
> +	 */
> +	*fifo_entries = val & 0x3FF;
> +
> +	return ret;
> +}
> +
> +static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	u8 status1, status2;
> +	u16 fifo_entries, i;

i should be just unsigned, not u16

> +	int ret;
> +
> +	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
> +	if (ret < 0)
> +		goto err;
> +
> +	if ((st->fifo_mode != ADXL372_FIFO_BYPASSED) &&
> +	    (ADXL372_STATUS_1_FIFO_FULL(status1))) {

parenthesis not needed

> +		/*
> +		 * When reading data from multiple axes from the FIFO,
> +		 * to ensure that data is not overwritten and stored out
> +		 * of order at least one sample set must be left in the
> +		 * FIFO after every read.
> +		 */
> +		fifo_entries -= st->fifo_set_size;
> +
> +		ret = adxl372_read_fifo(st, fifo_entries);
> +		if (ret < 0)
> +			goto err;
> +
> +		for (i = 0; i < fifo_entries * 2; i += st->fifo_set_size * 2)

this confuses me; 2 is what? use sizeof()

> +			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +	}
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static int adxl372_setup(struct adxl372_state *st)
>  {
>  	unsigned int regval;
> @@ -443,7 +635,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		ret = adxl372_read_axis(st, chan->address);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -459,9 +656,136 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static ssize_t adxl372_get_fifo_enabled(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->fifo_mode);
> +}
> +
> +static ssize_t adxl372_get_fifo_watermark(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->watermark);
> +}
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max,
> +		      __stringify(ADXL372_FIFO_SIZE));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adxl372_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adxl372_get_fifo_enabled, NULL, 0);
> +
> +static const struct attribute *adxl372_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static int adxl372_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adxl372_state *st  = iio_priv(indio_dev);
> +
> +	if (val > ADXL372_FIFO_SIZE)
> +		val = ADXL372_FIFO_SIZE;
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}
> +
> +static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	unsigned int mask;
> +	int i, ret;
> +
> +	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	mask = *indio_dev->active_scan_mask;
> +
> +	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
> +		if (mask == adxl372_axis_lookup_table[i].bits)
> +			break;
> +	}
> +
> +	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
> +
> +	if (st->fifo_format == ADXL372_XYZ_PEAK_FIFO)
> +		st->fifo_set_size = 3;
> +	else
> +		st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
> +						  indio_dev->masklength);
> +	/*
> +	 * The 512 FIFO samples can be allotted in several ways, such as:
> +	 * 170 sample sets of concurrent 3-axis data
> +	 * 256 sample sets of concurrent 2-axis data (user selectable)
> +	 * 512 sample sets of single-axis data
> +	 */
> +	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
> +		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
> +
> +	st->fifo_mode = ADXL372_FIFO_STREAMED;
> +
> +	ret = adxl372_configure_fifo(st);
> +	if (ret < 0) {
> +		st->fifo_mode = ADXL372_FIFO_BYPASSED;
> +		adxl372_set_interrupts(st, 0, 0);
> +		return ret;
> +	}
> +
> +	return iio_triggered_buffer_postenable(indio_dev);
> +}
> +
> +static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	adxl372_set_interrupts(st, 0, 0);
> +	st->fifo_mode = ADXL372_FIFO_BYPASSED;
> +	adxl372_configure_fifo(st);
> +
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
> +	.postenable = adxl372_buffer_postenable,
> +	.predisable = adxl372_buffer_predisable,
> +};
> +
> +static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
> +					 bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	unsigned long int mask = 0;
> +
> +	if (state)
> +		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
> +
> +	return adxl372_set_interrupts(st, mask, 0);
> +}
> +
> +static const struct iio_trigger_ops adxl372_trigger_ops = {
> +	.set_trigger_state = adxl372_dready_trig_set_state,
> +};
> +
>  static const struct iio_info adxl372_info = {
>  	.read_raw = adxl372_read_raw,
>  	.debugfs_reg_access = &adxl372_reg_access,
> +	.hwfifo_set_watermark = adxl372_set_watermark,
>  };
>  
>  static const struct regmap_config adxl372_spi_regmap_config = {
> @@ -495,10 +819,11 @@ static int adxl372_probe(struct spi_device *spi)
>  
>  	indio_dev->channels = adxl372_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
> +	indio_dev->available_scan_masks = adxl372_channel_masks;
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &adxl372_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  
>  	ret = adxl372_setup(st);
>  	if (ret < 0) {
> @@ -506,6 +831,41 @@ static int adxl372_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
> +					      indio_dev, NULL,
> +					      adxl372_trigger_handler,
> +					      &adxl372_buffer_ops);
> +	if (ret < 0)
> +		return ret;
> +
> +	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
> +
> +	if (st->spi->irq) {
> +		st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
> +							 "%s-dev%d",
> +							 indio_dev->name,
> +							 indio_dev->id);
> +		if (st->dready_trig == NULL)
> +			return -ENOMEM;
> +
> +		st->dready_trig->ops = &adxl372_trigger_ops;
> +		st->dready_trig->dev.parent = &st->spi->dev;
> +		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +		ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
> +		if (ret < 0)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(st->dready_trig);
> +
> +		ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
> +					iio_trigger_generic_data_rdy_poll,
> +					NULL,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					indio_dev->name, st->dready_trig);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(&st->spi->dev, indio_dev);
>  }
>  
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
