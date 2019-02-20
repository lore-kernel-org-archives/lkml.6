Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F64C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550663571;
	bh=FODlWQ4NZTH4CElnlFVgoYr9h8whV+1jLBJrnICdWjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yx4BL0y2hNbS9DRtgqsngQc7hEuGS0d1gmk3/X31E/DHXlufHTMy2ofcFxPB5JZMq
	 LPP26X30MG0msSomzqzP5bVHc7m6rtGpeaPLWmd9pLBEumUq/8E3QxL5DdZRr7cj7L
	 +Nkc41MZp5bPuPI9VupFppgocFAxqf/IqZHPcnJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBTLwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfBTLws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:52:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26722086C;
        Wed, 20 Feb 2019 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550663567;
        bh=FODlWQ4NZTH4CElnlFVgoYr9h8whV+1jLBJrnICdWjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TKDllRujn96sPGjqQLMKPd2gsIPBE0Y07O6LPR7HpNh1ECc63GJk5y5kMgeELIzwU
         x0VDAgLokfdeEefgjpN49zYeX93BLbtkMY6NeNBIO9UQ5Vg+qbbmOttCgZRb4+1UWG
         n7xVUdYpMV02zc4AowyD8b7v9y4SlhZDpnwRROqM=
Date:   Wed, 20 Feb 2019 11:52:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 2/2] staging: iio: frequency: ad9834: Move phase and
 scale to standard iio attribute
Message-ID: <20190220115241.62d88739@archlinux>
In-Reply-To: <20190214164130.30085-2-beniamin.bia@analog.com>
References: <20190214164130.30085-1-beniamin.bia@analog.com>
        <20190214164130.30085-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 18:41:30 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The custom phase and scale attributes were moved to standard iio types.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Hi, 

This hits the same fundamental questions of ABI as the FSK
elements in the previous patch, just now for Phase Shift Keying.

Unfortunately this ABI element is a strong part of the reason
these DDS chips have languished in staging a long time.
It is not easy to generalize.  On that note, we also want to
take into account any other chips that will want to share ABI with
this one as we define it.

Jonathan

> ---
> Changes in v2:
> 	-the personal email address was replaced by the work email
> 	-separate define for every phase channel
> 	-enum used for write_phase functions
> 	-phase variables were replaced by an array
> 
>  drivers/staging/iio/frequency/ad9834.c | 53 ++++++++++++++++----------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 561617046c20..4366b6121154 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -82,6 +82,7 @@ struct ad9834_state {
>  	struct mutex                    lock;   /* protect sensor state */
>  
>  	unsigned long			frequency[2];
> +	unsigned long			phase[2];
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -113,6 +114,8 @@ enum ad9834_supported_device_ids {
>  		.output = 1,						\
>  		.channel = (chan),					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +						| BIT(IIO_CHAN_INFO_PHASE),\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  }
>  
>  static const struct iio_chan_spec ad9833_channels[] = {
> @@ -172,13 +175,26 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  }
>  
>  static int ad9834_write_phase(struct ad9834_state *st,
> -			      unsigned long addr, unsigned long phase)
> +			      enum ad9834_ch_addr addr,
> +			      unsigned long phase)
>  {
> +	int ret;
> +
>  	if (phase > BIT(AD9834_PHASE_BITS))
>  		return -EINVAL;
> -	st->data = cpu_to_be16(addr | phase);
>  
> -	return spi_sync(st->spi, &st->msg);
> +	if (addr == AD9834_CHANNEL_ADDRESS0)
> +		st->data = cpu_to_be16(AD9834_REG_PHASE0 | phase);
> +	else
> +		st->data = cpu_to_be16(AD9834_REG_PHASE1 | phase);
> +
> +	ret = spi_sync(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	st->phase[(int)addr] = phase;
> +
> +	return 0;
>  }
>  
>  static int ad9834_read_raw(struct iio_dev *indio_dev,
> @@ -191,6 +207,13 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_FREQUENCY:
>  		*val = st->frequency[chan->channel];
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		*val = st->phase[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*1 hz */
> +		*val = 1;
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -207,6 +230,10 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
>  		return ad9834_write_frequency(st,
>  					      (enum ad9834_ch_addr)chan->channel,
>  					      val);
> +	case IIO_CHAN_INFO_PHASE:
> +		return ad9834_write_phase(st,
> +					  (enum ad9834_ch_addr)chan->channel,
> +					  val);
>  	default:
>  		return  -EINVAL;
>  	}
> @@ -231,10 +258,6 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> -	case AD9834_REG_PHASE0:
> -	case AD9834_REG_PHASE1:
> -		ret = ad9834_write_phase(st, this_attr->address, val);
> -		break;
>  	case AD9834_OPBITEN:
>  		if (st->control & AD9834_MODE) {
>  			ret = -EINVAL;  /* AD9843 reserved mode */
> @@ -394,12 +417,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   */
>  
>  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
> -static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
> -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
>  static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
> -static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
>  static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  	ad9834_write, AD9834_PIN_SW);
> @@ -410,10 +429,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
> -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> @@ -427,10 +442,6 @@ static struct attribute *ad9834_attributes[] = {
>  };
>  
>  static struct attribute *ad9833_attributes[] = {
> -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> @@ -554,11 +565,11 @@ static int ad9834_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
> +	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS0, 512);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
> +	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS1, 1024);
>  	if (ret)
>  		goto error_clock_unprepare;
>  

