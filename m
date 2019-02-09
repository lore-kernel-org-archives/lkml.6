Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CEDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0B21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549734404;
	bh=Brf+M1lHBNUMUy7IO1k87FbUF4obgcDm9IPURiOzZx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o97MfqEAlVZcezbwd92ljzNzoRG9slKbVUiDpWoepW4kO8xqi1ckxoZuHjJRdEEPj
	 odZMal/psMISfYskMWogIgFXeNhgNdsBpDVOUbcb2AkkP9jpAjxO0NEFmxNvUK59+p
	 uPRyBrgTG3RtLKdv50kYAIUIkjA2BY9W0UH3ilnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBIRqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfBIRql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:46:41 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463B1214DA;
        Sat,  9 Feb 2019 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549734400;
        bh=Brf+M1lHBNUMUy7IO1k87FbUF4obgcDm9IPURiOzZx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZHY1PmGuBRQN6EkXxb9nHige8259KLMLdbMHY0ERVujDuJgs2Ug2Ps/t/4T1I6U7q
         zHSYKStdxCxrlZxISlwyMZh/BB9oiODd7cbBVPztulWVQr3U/4zSdW882BhodMNYwI
         8jvLAbpv6MkyJcpKDNHh1Yke4KfmmpR5qJxbwgyI=
Date:   Sat, 9 Feb 2019 17:46:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <biabeniamin@outlook.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH 2/2] staging: iio: frequency: ad9834: Move phase and
 scale to standard iio attribute
Message-ID: <20190209174634.45a37eba@archlinux>
In-Reply-To: <20190206120542.16617-2-biabeniamin@outlook.com>
References: <20190206120542.16617-1-biabeniamin@outlook.com>
        <20190206120542.16617-2-biabeniamin@outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 14:05:42 +0200
Beniamin Bia <biabeniamin@outlook.com> wrote:

> The custom phase and scale attributes were moved to standard iio types.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Similar comments apply as to patch 1.

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9834.c | 54 +++++++++++++++-----------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 370e8263899e..3ecf976ddefe 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -30,8 +30,7 @@
>  
>  #define AD9834_REG_CMD		0
>  #define AD9834_REG_FREQ(chann)	(BIT(14) << (chann))
> -#define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
> -#define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
> +#define AD9834_REG_PHASE(chann)	(BIT(15) | BIT(14) | ((chann) << 13UL))
>  
>  /* Command Control Bits */
>  
> @@ -82,6 +81,8 @@ struct ad9834_state {
>  
>  	unsigned long			frequency0;
>  	unsigned long			frequency1;
> +	unsigned long			phase0;
> +	unsigned long			phase1;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -109,6 +110,8 @@ enum ad9834_supported_device_ids {
>  		.address = (_chan),					\
>  		.channel = (_chan),					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +						| BIT(IIO_CHAN_INFO_PHASE),\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  }
>  
>  static const struct iio_chan_spec ad9833_channels[] = {
> @@ -164,11 +167,22 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  static int ad9834_write_phase(struct ad9834_state *st,
>  			      unsigned long addr, unsigned long phase)
>  {
> +	int ret;
> +
>  	if (phase > BIT(AD9834_PHASE_BITS))
>  		return -EINVAL;
> -	st->data = cpu_to_be16(addr | phase);
> +	st->data = cpu_to_be16(AD9834_REG_PHASE(addr) | phase);
> +
> +	ret = spi_sync(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
>  
> -	return spi_sync(st->spi, &st->msg);
> +	if (addr == 0)
> +		st->phase0 = phase;
> +	else
> +		st->phase1 = phase;
> +
> +	return 0;
>  }
>  
>  static int ad9834_read_raw(struct iio_dev *indio_dev,
> @@ -184,6 +198,16 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
>  		else
>  			*val = st->frequency1;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->address == 0)
> +			*val = st->phase0;
> +		else
> +			*val = st->phase1;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*1 hz */
> +		*val = 1;
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -198,6 +222,8 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_FREQUENCY:
>  		return ad9834_write_frequency(st, chan->address, val);
> +	case IIO_CHAN_INFO_PHASE:
> +		return ad9834_write_phase(st, chan->address, val);
>  	default:
>  		return  -EINVAL;
>  	}
> @@ -222,10 +248,6 @@ static ssize_t ad9834_write(struct device *dev,
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
> @@ -385,12 +407,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
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
> @@ -401,10 +419,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
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
> @@ -418,10 +432,6 @@ static struct attribute *ad9834_attributes[] = {
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
> @@ -545,11 +555,11 @@ static int ad9834_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
> +	ret = ad9834_write_phase(st, 0, 512);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
> +	ret = ad9834_write_phase(st, 1, 1024);
Similar comments. Nicer to use an enum for this and name them.

>  	if (ret)
>  		goto error_clock_unprepare;
>  

