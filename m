Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A18C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED39217B7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAATuLJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED39217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHCXaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbeHCXaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:30:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A939B2178D;
        Fri,  3 Aug 2018 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533331923;
        bh=niDOM7N3Q0lhyHwqdBcGNVW9PKYr6Hn6JcPfOkCbjUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lAATuLJj9YxpvLEaKn1uqL7iN4zLcTPXKUdF8448ar25BRc9nbv/eo6M54IS2UTg5
         bzLyhaBQPk+c7/eOHYfzF45OON6oLnDWBLRicw5f5A6mEzCFST7tz4ozNSxYXUMLzn
         ok3+J/DLjZJgjsNNyd0PnYaXgfx0rgJLuWWRFy7Q=
Date:   Fri, 3 Aug 2018 22:31:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] iio:adxl372: Add sampling frequency support
Message-ID: <20180803223158.13435a88@archlinux>
In-Reply-To: <1533301341-26560-6-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
        <1533301341-26560-6-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 16:02:20 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch adds the option for the user to select the sampling frequency.
> Also, the user can read the available frequencies and read the currently
> set frequency via the read_raw function. The frequency can be set via the
> write_raw function.
> 
> When the frequency is set, the bandwidth is also checked and ensured
> that it is constrained to at most half of the sampling frequency. Also, the
> activity and inactivity timers have to be updated because they depend on
> the selected ODR.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
This one is good.  Will pick up with the others unless someone finds
an issue in the meantime.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index e31e096..80b1838 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -217,7 +217,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index = index,						\
>  	.scan_type = {							\
>  		.sign = 's',						\
> @@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
>  	return ret;
>  }
>  
> +static int adxl372_find_closest_match(const int *array,
> +				      unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (val <= array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}
> +
>  static int adxl372_set_bandwidth(struct adxl372_state *st,
>  				 enum adxl372_bandwidth bw)
>  {
> @@ -639,6 +653,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		*val2 = ADXL372_USCALE;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = adxl372_samp_freq_tbl[st->odr];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adxl372_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	int odr_index, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
> +					ARRAY_SIZE(adxl372_samp_freq_tbl),
> +					val);
> +		ret = adxl372_set_odr(st, odr_index);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
> +		 */
> +		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
> +		 */
> +		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The maximum bandwidth is constrained to at most half of
> +		 * the ODR to ensure that the Nyquist criteria is not violated
> +		 */
> +		if (st->bw > odr_index)
> +			ret = adxl372_set_bandwidth(st, odr_index);
> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -766,8 +825,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
>  	.set_trigger_state = adxl372_dready_trig_set_state,
>  };
>  
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> +
> +static struct attribute *adxl372_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adxl372_attrs_group = {
> +	.attrs = adxl372_attributes,
> +};
> +
>  static const struct iio_info adxl372_info = {
> +	.attrs = &adxl372_attrs_group,
>  	.read_raw = adxl372_read_raw,
> +	.write_raw = adxl372_write_raw,
>  	.debugfs_reg_access = &adxl372_reg_access,
>  	.hwfifo_set_watermark = adxl372_set_watermark,
>  };

