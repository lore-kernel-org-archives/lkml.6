Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4568C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E12146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550664650;
	bh=kBLIvt+BwNMZ4NXB6/DD8Fp6ceWVWnGpEWpSzWOwy3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TfFlngYzKRNkZTbw/HJXr4j0k357+vleVcYsbG3qCRMYNz5kkrojynb1iPosOFNcW
	 0BLH4gfWASr6GM5CrDjZ/OXXzgBK9NY1YlT7497Hjepwg4Lvc7HrXbbUnsD0nzOvJ9
	 5Zinw7XBLKDiZ9sWpMmBdPnXBdb0ua9zQxea4454=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfBTMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfBTMKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:10:49 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B2C20C01;
        Wed, 20 Feb 2019 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550664648;
        bh=kBLIvt+BwNMZ4NXB6/DD8Fp6ceWVWnGpEWpSzWOwy3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+ow22Bqizka1zeQmAKyFap3i3zFXA6F2YLx5WxRP4MfV13ekD33j7ZVl20gc+/9F
         9y+ErFSLy1B3C0uGcbHGMpiZXAPdWixn8ze3etaF07UGyYdWONlya8QWIJtbP58sAC
         8IgiPp3MVeLUCrfstmyFWgHTSxvNOki9WCC+vDvY=
Date:   Wed, 20 Feb 2019 12:10:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v2] iio/gyro/bmg160: Use millidegrees for temperature
 scale
Message-ID: <20190220121042.6459176b@archlinux>
In-Reply-To: <1550043707-13040-1-git-send-email-mike.looijmans@topic.nl>
References: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
        <1550043707-13040-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 08:41:47 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Standard unit for temperature is millidegrees Celcius, whereas this driver
> was reporting in degrees. Fix the scale factor in the driver.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
> v2: Don't touch val2 when returning IIO_VAL_INT
>     Only touch val when returning a value
> 
>  drivers/iio/gyro/bmg160_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 63ca316..92c07ab 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -582,11 +582,10 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return bmg160_get_filter(data, val);
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val2 = 500000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			*val = 500;
> +			return IIO_VAL_INT;
>  		case IIO_ANGL_VEL:
>  		{
>  			int i;
> @@ -594,6 +593,7 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
>  			for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
>  				if (bmg160_scale_table[i].dps_range ==
>  							data->dps_range) {
> +					*val = 0;
>  					*val2 = bmg160_scale_table[i].scale;
>  					return IIO_VAL_INT_PLUS_MICRO;
>  				}

