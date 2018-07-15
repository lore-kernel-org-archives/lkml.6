Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CBECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54A208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxELs2G3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54A208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeGOK7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeGOK7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:59:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E48208C2;
        Sun, 15 Jul 2018 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531651001;
        bh=4jH9OMLaAKtny7ivF/8ooITSg2mRW83/+l4mgLAwJio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DxELs2G3vksfo4+qPTEhidkhT4MPEKJvPN/4+1M3sKFU5ZIdZilgBnLxWImkFA9bP
         XJXiLB8LFg0jvk7EwJqRYRdFPlVza4rsYEeA1KygoEXvIw8gx8DWPhoRDTKqzfNyal
         R7Mzap4gSpxBpYpN03QNBFaj0LMzEjtuPpcVAcU8=
Date:   Sun, 15 Jul 2018 11:36:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio:adxl372: Add filter bandwidth support
Message-ID: <20180715113636.5394c756@archlinux>
In-Reply-To: <1531409818-20300-1-git-send-email-stefan.popa@analog.com>
References: <1531409818-20300-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 18:36:58 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch adds the option for the user to select the filter bandwidth. The
> user can also read the available bandwidths which are always adjusted to be
> at most half of the sampling frequency. Furthermore, the currently selected
> bandwidth can be read via the read_raw function, while the write_raw sets a
> new bandwidth value.
> 

How will the youth of today learn about aliasing if we are so nice to them?
 :)  Good user friendly design choice btw.  If someone is doing something
crazy where they actually want the aliasing they can hack the driver.

This and the previous are fine.

Nice driver, you just ran into some 'old' problems in one or two places
that it would be good to finally solve.

> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 498c740..a73482e 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -199,6 +199,10 @@ static const int adxl372_samp_freq_tbl[5] = {
>  	400, 800, 1600, 3200, 6400,
>  };
>  
> +static const int adxl372_bw_freq_tbl[5] = {
> +	200, 400, 800, 1600, 3200,
> +};
> +
>  #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
> @@ -206,7 +210,8 @@ static const int adxl372_samp_freq_tbl[5] = {
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> -				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
>  	.scan_index = index,						\
>  	.scan_type = {							\
>  		.sign = 's',						\
> @@ -585,6 +590,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = adxl372_samp_freq_tbl[st->odr];
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = adxl372_bw_freq_tbl[st->bw];
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -595,7 +603,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long info)
>  {
>  	struct adxl372_state *st = iio_priv(indio_dev);
> -	int odr_index, ret;
> +	int odr_index, bw_index, ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -613,11 +621,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
>  			ret = adxl372_set_bandwidth(st, odr_index);
>  
>  		return ret;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
> +					ARRAY_SIZE(adxl372_bw_freq_tbl),
> +					val);
> +		return adxl372_set_bandwidth(st, bw_index);
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	int i;
> +	size_t len = 0;
> +
> +	for (i = 0; i <= st->odr; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +				 "%d ", adxl372_bw_freq_tbl[i]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
>  static ssize_t adxl372_get_fifo_enabled(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
> @@ -768,9 +799,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
>  };
>  
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> +static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
> +		       0444, adxl372_show_filter_freq_avail, NULL, 0);
>  
>  static struct attribute *adxl372_attributes[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  

