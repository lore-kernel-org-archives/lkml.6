Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A865C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380F420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550663440;
	bh=pSw1aYmKuJXm3uSxXOHm/soDtFK9+aL9zcq1tn9NfWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p+QJ/9oplr8LY1FEWiCHehIYoQjwtX7yDKM5xQTrFjxjOMdcmTem5f0rlePCGIUP0
	 3BOQjmFjb3kVC/+tMb8tMnIv65iYN/mfzOGqDHWH+MJPvJYZ96QDdzKVOQ/w1NZ8Fi
	 Z8M2Hu5icWAZxKNxw8MDo9lScYzrtQc5rdV3dF7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfBTLui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfBTLuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:50:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380732086C;
        Wed, 20 Feb 2019 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550663436;
        bh=pSw1aYmKuJXm3uSxXOHm/soDtFK9+aL9zcq1tn9NfWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sv22PkZBYqg/ssR3ysOE3fPKu+9k9ycE9VX0b5uOIT28J2mouCen+xYlD/M2JMfJU
         0pwZ+AqYFEf3n/966HMAN2exQhliSKHxkJ47RNVzDjcX4NSzTNfysnLSaORno1TAR+
         lWxacoXOqwbrgDXa2b8VCN1LTIa6aOpeLOOEsjsE=
Date:   Wed, 20 Feb 2019 11:50:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 1/2] staging: iio: frequency: ad9834: Move frequency
 to standard iio types
Message-ID: <20190220115030.0de87cfc@archlinux>
In-Reply-To: <20190214164130.30085-1-beniamin.bia@analog.com>
References: <20190214164130.30085-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 18:41:29 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Frequency attribute is added with a standard type from iio framework
> instead of custom attribute. This is a small step towards removing any
> unnecessary custom attribute. Ad9834 will diverge from ad9833 in the
> future, that is why we have two identical arrays for ad9834 and 9833.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Hi Beniamin

When you make a change like this, please explain in detail how the ABI
changes.  Here I'm not sure we can actually map it to channels like this.
We are controlling the two frequencies of FSK not independent channels.

The ABI around this needs very careful thinking out.  I would document
your proposed ABI first and share that.  Once we reach agreement on the
ABI, the actual code should be more straight forward!

Thanks,

Jonathan

> ---
> Changes in v2:
> 	-the personal email address was replaced by the work email
> 	-separate define for frequency channel
> 	-address field from channel specification was removed
> 	-frequency variables were replaced by an array
> 	-specified in comment why we have differente chan_spec for ad9834 and ad9833
> 	-enum used for write_frequency function
> 
>  drivers/staging/iio/frequency/ad9834.c | 110 ++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f036f75d1f22..561617046c20 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -81,6 +81,8 @@ struct ad9834_state {
>  	struct spi_message		freq_msg;
>  	struct mutex                    lock;   /* protect sensor state */
>  
> +	unsigned long			frequency[2];
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -89,6 +91,11 @@ struct ad9834_state {
>  	__be16				freq_data[2];
>  };
>  
> +enum ad9834_ch_addr {
> +	AD9834_CHANNEL_ADDRESS0,
> +	AD9834_CHANNEL_ADDRESS1,
> +};
> +
>  /**
>   * ad9834_supported_device_ids:
>   */
> @@ -100,6 +107,24 @@ enum ad9834_supported_device_ids {
>  	ID_AD9838,
>  };
>  
> +#define AD9833_CHANNEL(chan) {						\
> +		.type = IIO_ALTVOLTAGE,					\
> +		.indexed = 1,						\
> +		.output = 1,						\
> +		.channel = (chan),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +}
> +
> +static const struct iio_chan_spec ad9833_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec ad9834_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
>  static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
> @@ -109,10 +134,12 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  }
>  
>  static int ad9834_write_frequency(struct ad9834_state *st,
> -				  unsigned long addr, unsigned long fout)
> +				  enum ad9834_ch_addr addr,
> +				  unsigned long fout)
>  {
>  	unsigned long clk_freq;
>  	unsigned long regval;
> +	int ret;
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -121,13 +148,27 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  
>  	regval = ad9834_calc_freqreg(clk_freq, fout);
>  
> -	st->freq_data[0] = cpu_to_be16(addr | (regval &
> -				       RES_MASK(AD9834_FREQ_BITS / 2)));
> -	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
> -				       (AD9834_FREQ_BITS / 2)) &
> -				       RES_MASK(AD9834_FREQ_BITS / 2)));
> +	if (addr == AD9834_CHANNEL_ADDRESS0) {

So this if statement picks between the two addresses with no other differences?
That's fine, but use a local variable for the register address to simplify
the code.

> +		st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ0 | (regval &
> +					       RES_MASK(AD9834_FREQ_BITS / 2)));
> +		st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ0 | ((regval >>
> +					       (AD9834_FREQ_BITS / 2)) &
> +					       RES_MASK(AD9834_FREQ_BITS / 2)));
> +	} else {
> +		st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ1 | (regval &
> +					       RES_MASK(AD9834_FREQ_BITS / 2)));
> +		st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ1 | ((regval >>
> +					       (AD9834_FREQ_BITS / 2)) &
> +					       RES_MASK(AD9834_FREQ_BITS / 2)));
> +	}
> +
> +	ret = spi_sync(st->spi, &st->freq_msg);
> +	if (ret)
> +		return ret;
> +
> +	st->frequency[(int)addr] = fout;
>  
> -	return spi_sync(st->spi, &st->freq_msg);
> +	return 0;
>  }
>  
>  static int ad9834_write_phase(struct ad9834_state *st,
> @@ -140,6 +181,39 @@ static int ad9834_write_phase(struct ad9834_state *st,
>  	return spi_sync(st->spi, &st->msg);
>  }
>  
> +static int ad9834_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		*val = st->frequency[chan->channel];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad9834_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		return ad9834_write_frequency(st,
> +					      (enum ad9834_ch_addr)chan->channel,
> +					      val);
> +	default:
> +		return  -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t ad9834_write(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf,
> @@ -157,10 +231,6 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> -	case AD9834_REG_FREQ0:
> -	case AD9834_REG_FREQ1:
> -		ret = ad9834_write_frequency(st, this_attr->address, val);
> -		break;
>  	case AD9834_REG_PHASE0:
>  	case AD9834_REG_PHASE1:
>  		ret = ad9834_write_phase(st, this_attr->address, val);
> @@ -323,8 +393,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
>  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> @@ -342,8 +410,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -361,8 +427,6 @@ static struct attribute *ad9834_attributes[] = {
>  };
>  
>  static struct attribute *ad9833_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,

This may be a problem...  These don't fit in the existing ABI in that they
are (IIRC) two different frequencies for the same channel, not two different
channels...  This is meant for simple FSK modulation.

>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -384,11 +448,15 @@ static const struct attribute_group ad9833_attribute_group = {
>  };
>  
>  static const struct iio_info ad9834_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9834_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad9833_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9833_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -435,9 +503,13 @@ static int ad9834_probe(struct spi_device *spi)
>  	switch (st->devid) {
>  	case ID_AD9833:
>  	case ID_AD9837:
> +		indio_dev->channels = ad9833_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9833_channels);
>  		indio_dev->info = &ad9833_info;
>  		break;
>  	default:

For future reference, I would definitely like to see the options that
lead to here explicitly listed.  Semantically it's not a 'default'
but rather an alternative equally valid choice.
People also tend to grep for their devid ;)

> +		indio_dev->channels = ad9834_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9834_channels);
>  		indio_dev->info = &ad9834_info;
>  		break;
>  	}
> @@ -474,11 +546,11 @@ static int ad9834_probe(struct spi_device *spi)
>  		goto error_clock_unprepare;
>  	}
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
> +	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS0, 1000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
> +	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS1, 5000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  

