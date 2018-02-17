Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeBQOJm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 09:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbeBQOJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 09:09:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E84217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 14:09:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: <broonie@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/5] iio: accel: bcm150: Remove handling for regmap
 raw_read_max
Message-ID: <20180217140935.74447c0b@archlinux>
In-Reply-To: <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
        <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 17:52:19 +0000
Charles Keepax <ckeepax@opensource.cirrus.com> wrote:

> The regmap core now handles splitting up transactions according to
> max_raw_read, so this code is no longer required in client drivers.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Hi Charles,

This looks fine to me.  I'll need to wait for Mark's patches to work
their way through to mainline before I can apply this however.

Please give me a poke when that has happened if it looks like I have
forgotten it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 870f92ef61c2..3d2e6b501bf9 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -838,29 +838,12 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>  	int sample_length = 3 * 2;
>  	int ret;
>  	int total_length = samples * sample_length;
> -	int i;
> -	size_t step = regmap_get_raw_read_max(data->regmap);
> -
> -	if (!step || step > total_length)
> -		step = total_length;
> -	else if (step < total_length)
> -		step = sample_length;
> -
> -	/*
> -	 * Seems we have a bus with size limitation so we have to execute
> -	 * multiple reads
> -	 */
> -	for (i = 0; i < total_length; i += step) {
> -		ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
> -				      &buffer[i], step);
> -		if (ret)
> -			break;
> -	}
>  
> +	ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
> +			      buffer, total_length);
>  	if (ret)
>  		dev_err(dev,
> -			"Error transferring data from fifo in single steps of %zu\n",
> -			step);
> +			"Error transferring data from fifo: %d\n", ret);
>  
>  	return ret;
>  }
