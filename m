Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BC6C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E6B21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544968304;
	bh=Kwfk9nsyyvXbz9AHPtkTlVLJpJjkf5k9W5bzsr87Zms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BZtlGKipV5IVxDzB9nAEIl/l38pT2V3asK5NXprqQrEn7mlw8qmszIkDiSR5LwfVq
	 ydZeHphC2AzTcQMDMUPkH1n3u8FOsqpMNMxRcSv628oZQ+UX2qmn3qTBL3wCs9OwhZ
	 5s1N60wT9YBfobw8fPMC3GR3RTgoFK9V6ccSrZ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeLPNvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbeLPNvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:51:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABCF2086C;
        Sun, 16 Dec 2018 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544968302;
        bh=Kwfk9nsyyvXbz9AHPtkTlVLJpJjkf5k9W5bzsr87Zms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OqhwEK7fdJkgghkFMxAB/6UHQTAbQT2S1xEIP9W0yDuE+YpAzK7/2FTisOkED16O7
         M0OdjR2OKEMAnmP7KAJLPpMRJ77iz+tK3NHi7VhcpffNeGdMHe0QbNd82p4jOTbrQf
         zK88VT1osaMnKIHfbLXWo+z8CWUGexmQ+m1mYrb8=
Date:   Sun, 16 Dec 2018 13:51:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 06/11] staging: iio: adc: ad7606: Use find_closest()
 macro
Message-ID: <20181216135136.7c7bde18@archlinux>
In-Reply-To: <1544705183-13288-7-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-7-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:18 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> When looking for the available scale or oversampling ratio, it is better
> to use the find_closest() macro. This simplifies the code and also does
> not require an exact value to be entered from the user space.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Nice little cleanup.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c | 58 +++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 13aeeec..0925379 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/sched.h>
>  #include <linux/module.h>
> +#include <linux/util_macros.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -30,8 +31,12 @@
>   * Scales are computed as 5000/32768 and 10000/32768 respectively,
>   * so that when applied to the raw values they provide mV values
>   */
> -static const unsigned int scale_avail[2][2] = {
> -	{0, 152588}, {0, 305176}
> +static const unsigned int scale_avail[2] = {
> +	152588, 305176
> +};
> +
> +static const unsigned int ad7606_oversampling_avail[7] = {
> +	1, 2, 4, 8, 16, 32, 64,
>  };
>  
>  static int ad7606_reset(struct ad7606_state *st)
> @@ -148,8 +153,8 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		*val = (short)ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = scale_avail[st->range][0];
> -		*val2 = scale_avail[st->range][1];
> +		*val = 0;
> +		*val2 = scale_avail[st->range];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->oversampling;
> @@ -165,8 +170,8 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
>  	int i, len = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
> -				 scale_avail[i][0], scale_avail[i][1]);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> +				 scale_avail[i]);
>  
>  	buf[len - 1] = '\n';
>  
> @@ -175,18 +180,6 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
>  
>  static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
>  
> -static int ad7606_oversampling_get_index(unsigned int val)
> -{
> -	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(supported); i++)
> -		if (val == supported[i])
> -			return i;
> -
> -	return -EINVAL;
> -}
> -
>  static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val,
> @@ -195,36 +188,29 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	DECLARE_BITMAP(values, 3);
> -	int ret, i;
> +	int i;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = -EINVAL;
>  		mutex_lock(&st->lock);
> -		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
> -			if (val2 == scale_avail[i][1]) {
> -				gpiod_set_value(st->gpio_range, i);
> -				st->range = i;
> -
> -				ret = 0;
> -				break;
> -			}
> +		i = find_closest(val2, scale_avail, ARRAY_SIZE(scale_avail));
> +		gpiod_set_value(st->gpio_range, i);
> +		st->range = i;
>  		mutex_unlock(&st->lock);
>  
> -		return ret;
> +		return 0;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		if (val2)
>  			return -EINVAL;
> -		ret = ad7606_oversampling_get_index(val);
> -		if (ret < 0)
> -			return ret;
> +		i = find_closest(val, ad7606_oversampling_avail,
> +				 ARRAY_SIZE(ad7606_oversampling_avail));
>  
> -		values[0] = ret;
> +		values[0] = i;
>  
>  		mutex_lock(&st->lock);
> -		gpiod_set_array_value(3, st->gpio_os->desc, st->gpio_os->info,
> -				      values);
> -		st->oversampling = val;
> +		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> +				      st->gpio_os->info, values);
> +		st->oversampling = ad7606_oversampling_avail[i];
>  		mutex_unlock(&st->lock);
>  
>  		return 0;

