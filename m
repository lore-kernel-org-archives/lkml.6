Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D008C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F7324F38
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yL4CA0Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F7324F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeFXN7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbeFXN67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:58:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8D724F36;
        Sun, 24 Jun 2018 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529848739;
        bh=ReMylAa4fodVauumqYMu3kQB0Dkj5PlE083A46KfFIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yL4CA0Wk9Epbuu++ljXt2jmEii+5JeXwkkhtADPO6K/LwOYLnCPJeT+vOPChReP8K
         KO79VDNlaWLFsN/K4/haAEgngykxbElHQLzj2xxyMAT2VhZQNEY/zfJaExKKQkY+q4
         wQ+qRM0mdj2WYAlVWKvhY4ldo7MbreH8lT/ur82Y=
Date:   Sun, 24 Jun 2018 14:58:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: add support for
 oversampling resolution
Message-ID: <20180624145854.718f0c7a@archlinux>
In-Reply-To: <1529567781-21033-1-git-send-email-eugen.hristev@microchip.com>
References: <1529567781-21033-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 10:56:21 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> This implements oversampling support for the SAMA5d2 ADC device.
> Enabling oversampling : OSR can improve resolution from 12 bits to
> 13 or 14 bits.
> Changing the channel specification to have 14 bits, and we shift the value
> 1 bit to the left if we have oversampling for just one extra bit, and two
> bits to the left if we have no oversampling (old support).
> From this commit on, the converted values for all the voltage channels
> change to 14 bits real data, with most insignificant two bits always zero
> if oversampling is not enabled.
> sysfs object oversampling_ratio has been enabled and
> oversampling_ratio_available will list possible values (1 or 4 or 16) having
> 1 as default (no oversampling, 1 sample for each conversion).
> Special care was required for the triggered buffer scenario (+ DMA), to
> adjust the values accordingly.
> Touchscreen measurements supported by this driver are not affected by
> oversampling, they are still on 12 bits (scale handing is already included
> in the driver).
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>  - updated channel spec to 14 bits as reviewed by Jonathan.
> This makes things much simpler, and no more INT_PLUS_MICRO values.
>  - tidy up the extra line which was forgotten there
>  - renamed 0SAMPLES macro to 1SAMPLES , which makes more sense (1 sample for
> each conversion is the actual number we have). other OSR values are 4SAMPLES
> or 16SAMPLES per conversion.
>  - made code a bit clearer to read by having a per array adjust function
> instead of those ugly casts I was using in v1. This is needed to adjust
> the values recieved from DMA for each u16 storage bits per conversion (shift
> left or not according to OSR setting).
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 189 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 163 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 58c4c2b..adf1d69 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -130,6 +130,15 @@
>  #define AT91_SAMA5D2_OVER	0x3c
>  /* Extended Mode Register */
>  #define AT91_SAMA5D2_EMR	0x40
> +/* Extended Mode Register - Oversampling rate */
> +#define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
> +#define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
> +#define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
> +#define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
> +#define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
> +
> +/* Extended Mode Register - Averaging on single trigger event */
> +#define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
>  /* Compare Window Register */
>  #define AT91_SAMA5D2_CWR	0x44
>  /* Channel Gain Register */
> @@ -248,6 +257,11 @@
>  #define AT91_HWFIFO_MAX_SIZE_STR	"128"
>  #define AT91_HWFIFO_MAX_SIZE		128
>  
> +/* Possible values for oversampling ratio */
> +#define AT91_OSR_1SAMPLES		1
> +#define AT91_OSR_4SAMPLES		4
> +#define AT91_OSR_16SAMPLES		16
> +
>  #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
> @@ -256,12 +270,13 @@
>  		.scan_index = num,					\
>  		.scan_type = {						\
>  			.sign = 'u',					\
> -			.realbits = 12,					\
> +			.realbits = 14,					\
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.datasheet_name = "CH"#num,				\
>  		.indexed = 1,						\
>  	}
> @@ -276,12 +291,13 @@
>  		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
>  		.scan_type = {						\
>  			.sign = 's',					\
> -			.realbits = 12,					\
> +			.realbits = 14,					\
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.datasheet_name = "CH"#num"-CH"#num2,			\
>  		.indexed = 1,						\
>  	}
> @@ -299,7 +315,8 @@
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.datasheet_name = name,					\
>  	}
>  #define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
> @@ -313,7 +330,8 @@
>  			.storagebits = 16,				\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.datasheet_name = name,					\
>  	}
>  
> @@ -384,6 +402,7 @@ struct at91_adc_state {
>  	const struct iio_chan_spec	*chan;
>  	bool				conversion_done;
>  	u32				conversion_value;
> +	unsigned int			oversampling_ratio;
>  	struct at91_adc_soc_info	soc_info;
>  	wait_queue_head_t		wq_data_available;
>  	struct at91_adc_dma		dma_st;
> @@ -475,6 +494,77 @@ static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
>  	return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
>  }
>  
> +static void at91_adc_config_emr(struct at91_adc_state *st)
> +{
> +	/* configure the extended mode register */
> +	unsigned int emr = at91_adc_readl(st, AT91_SAMA5D2_EMR);
> +
> +	/* select oversampling per single trigger event */
> +	emr |= AT91_SAMA5D2_EMR_ASTE(1);
> +
> +	/* delete leftover content if it's the case */
> +	emr &= ~AT91_SAMA5D2_EMR_OSR_MASK;
> +
> +	/* select oversampling ratio from configuration */
> +	switch (st->oversampling_ratio) {
> +	case AT91_OSR_1SAMPLES:
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES) &
> +		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		break;
> +	case AT91_OSR_4SAMPLES:
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES) &
> +		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		break;
> +	case AT91_OSR_16SAMPLES:
> +		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES) &
> +		       AT91_SAMA5D2_EMR_OSR_MASK;
> +		break;
> +	};
> +
> +	at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
> +}
> +
> +static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
> +{
> +	if (st->oversampling_ratio == AT91_OSR_1SAMPLES) {
> +		/*
> +		 * in this case we only have 12 bits of real data, but channel
> +		 * is registered as 14 bits, so shift left two bits
> +		 */
> +		*val <<= 2;
> +	} else if (st->oversampling_ratio == AT91_OSR_4SAMPLES) {
> +		/*
> +		 * in this case we have 13 bits of real data, but channel
> +		 * is registered as 14 bits, so left shift one bit
> +		 */
> +		*val <<= 1;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static void at91_adc_adjust_val_osr_array(struct at91_adc_state *st, void *buf,
> +					  int len)
> +{
> +	int i = 0, val;
> +	u16 *buf_u16 = (u16 *) buf;
> +
> +	/*
> +	 * We are converting each two bytes (each sample).
> +	 * First convert the byte based array to u16, and convert each sample
> +	 * separately.
> +	 * Each value is two bytes in an array of chars, so to not shift
> +	 * more than we need, save the value separately.
> +	 * len is in bytes, so divide by two to get number of samples.
> +	 */
> +	while (i < len / 2) {
> +		val = buf_u16[i];
> +		at91_adc_adjust_val_osr(st, &val);
> +		buf_u16[i] = val;
> +		i++;
> +	}
> +}
> +
>  static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
>  {
>  	u32 clk_khz = st->current_sample_rate / 1000;
> @@ -916,6 +1006,7 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int i = 0;
> +	int val;
>  	u8 bit;
>  
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> @@ -936,7 +1027,9 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  		 * Thus, emit a warning.
>  		 */
>  		if (chan->type == IIO_VOLTAGE) {
> -			st->buffer[i] = at91_adc_readl(st, chan->address);
> +			val = at91_adc_readl(st, chan->address);
> +			at91_adc_adjust_val_osr(st, &val);
> +			st->buffer[i] = val;
>  		} else {
>  			st->buffer[i] = 0;
>  			WARN(true, "This trigger cannot handle this type of channel");
> @@ -972,6 +1065,14 @@ static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
>  	interval = div_s64((ns - st->dma_st.dma_ts), sample_count);
>  
>  	while (transferred_len >= sample_size) {
> +		/*
> +		 * for all the values in the current sample,
> +		 * adjust the values inside the buffer for oversampling
> +		 */
> +		at91_adc_adjust_val_osr_array(st,
> +					&st->dma_st.rx_buf[st->dma_st.buf_idx],
> +					sample_size);
> +
>  		iio_push_to_buffers_with_timestamp(indio_dev,
>  				(st->dma_st.rx_buf + st->dma_st.buf_idx),
>  				(st->dma_st.dma_ts + interval * sample_index));
> @@ -1212,7 +1313,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> -		return ret;
> +		return at91_adc_adjust_val_osr(st, val);
>  	}
>  	if (chan->type == IIO_PRESSURE) {
>  		ret = iio_device_claim_direct_mode(indio_dev);
> @@ -1225,7 +1326,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
>  
> -		return ret;
> +		return at91_adc_adjust_val_osr(st, val);
>  	}
>  
>  	/* in this case we have a voltage channel */
> @@ -1254,9 +1355,9 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  
>  	if (ret > 0) {
>  		*val = st->conversion_value;
> +		ret = at91_adc_adjust_val_osr(st, val);
>  		if (chan->scan_type.sign == 's')
>  			*val = sign_extend32(*val, 11);
> -		ret = IIO_VAL_INT;
>  		st->conversion_done = false;
>  	}
>  
> @@ -1292,6 +1393,10 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  		*val = at91_adc_get_sample_freq(st);
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->oversampling_ratio;
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1303,16 +1408,28 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> -	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> -		return -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
> +		    (val != AT91_OSR_16SAMPLES))
> +			return -EINVAL;
> +		/* if no change, optimize out */
> +		if (val == st->oversampling_ratio)
> +			return 0;
> +		st->oversampling_ratio = val;
> +		/* update ratio */
> +		at91_adc_config_emr(st);
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < st->soc_info.min_sample_rate ||
> +		    val > st->soc_info.max_sample_rate)
> +			return -EINVAL;
>  
> -	if (val < st->soc_info.min_sample_rate ||
> -	    val > st->soc_info.max_sample_rate)
> +		at91_adc_setup_samp_freq(st, val);
> +		return 0;
> +	default:
>  		return -EINVAL;
> -
> -	at91_adc_setup_samp_freq(st, val);
> -
> -	return 0;
> +	};
>  }
>  
>  static void at91_adc_dma_init(struct platform_device *pdev)
> @@ -1446,14 +1563,6 @@ static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static const struct iio_info at91_adc_info = {
> -	.read_raw = &at91_adc_read_raw,
> -	.write_raw = &at91_adc_write_raw,
> -	.update_scan_mode = &at91_adc_update_scan_mode,
> -	.of_xlate = &at91_adc_of_xlate,
> -	.hwfifo_set_watermark = &at91_adc_set_watermark,
> -};
> -
>  static void at91_adc_hw_init(struct at91_adc_state *st)
>  {
>  	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
> @@ -1466,6 +1575,9 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
>  
>  	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
> +
> +	/* configure extended mode register */
> +	at91_adc_config_emr(st);
>  }
>  
>  static ssize_t at91_adc_get_fifo_state(struct device *dev,
> @@ -1496,6 +1608,20 @@ static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
>  static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
>  static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
>  
> +static IIO_CONST_ATTR(oversampling_ratio_available,
> +		      __stringify(AT91_OSR_1SAMPLES) " "
> +		      __stringify(AT91_OSR_4SAMPLES) " "
> +		      __stringify(AT91_OSR_16SAMPLES));
> +
> +static struct attribute *at91_adc_attributes[] = {
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group at91_adc_attribute_group = {
> +	.attrs = at91_adc_attributes,
> +};
> +
>  static const struct attribute *at91_adc_fifo_attributes[] = {
>  	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
>  	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> @@ -1504,6 +1630,15 @@ static const struct attribute *at91_adc_fifo_attributes[] = {
>  	NULL,
>  };
>  
> +static const struct iio_info at91_adc_info = {
> +	.attrs = &at91_adc_attribute_group,
> +	.read_raw = &at91_adc_read_raw,
> +	.write_raw = &at91_adc_write_raw,
> +	.update_scan_mode = &at91_adc_update_scan_mode,
> +	.of_xlate = &at91_adc_of_xlate,
> +	.hwfifo_set_watermark = &at91_adc_set_watermark,
> +};
> +
>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -1532,6 +1667,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	bitmap_set(&st->touch_st.channels_bitmask,
>  		   AT91_SAMA5D2_TOUCH_P_CHAN_IDX, 1);
>  
> +	st->oversampling_ratio = AT91_OSR_1SAMPLES;
> +
>  	ret = of_property_read_u32(pdev->dev.of_node,
>  				   "atmel,min-sample-rate-hz",
>  				   &st->soc_info.min_sample_rate);

