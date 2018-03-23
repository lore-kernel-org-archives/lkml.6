Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeCWMxE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:53:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752525AbeCWMxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:53:02 -0400
Date: Fri, 23 Mar 2018 12:52:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] staging: iio: ad7746: Add comments
Message-ID: <20180323135236.00007d20@huawei.com>
In-Reply-To: <1521642539-4845-9-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-9-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:56 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Add comments to clarify some of the calculations made, specially when
> reading or writing values.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 8abba71..b6b99e2 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -420,6 +420,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> +		/* 2^16 in micro */
>  		val = (val2 * 1024) / 15625;
>  
>  		switch (chan->type) {
> @@ -546,6 +547,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out;
>  
> +		/*
> +		 * Either for Capacitance, Voltage or Temperature,
> +		 * the 0x000000 code represents negative full scale,
> +		 * the 0x800000 code represents zero scale, and
> +		 * the 0xFFFFFF code represents positive full scale.
> +		 */
> +
>  		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
This should be left for userspace to deal with.  That is it should be
exported as an offset for the various channels rather than applied here.

>  
>  		switch (chan->type) {
> @@ -557,7 +565,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			*val = (*val * 125) / 256;
>  			break;
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 1) /* supply_raw*/
> +
> +			/*
> +			 * The voltage from the VDD pin is internally
> +			 *  attenuated by 6.
Extra space before attenuated.
> +			 */
> +
> +			if (chan->channel == 1) /* supply_raw */
>  				*val = *val * 6;
>  			break;
>  		default:
> @@ -598,21 +612,28 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +
> +		/*
> +		 * CAPDAC Scale = 21pF_typ / 127
> +		 * CIN Scale = 8.192pF / 2^24
> +		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
> +		 */
> +
>  		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
> -			[chan->differential]) * 338646;
> +					  [chan->differential]) * 338646;
This change should have been in the alignment fixing patch, not here.

>  
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
> -			/* 8.192pf / 2^24 */
> +			/* CIN Scale: 8.192pf / 2^24 */
>  			*val =  0;
>  			*val2 = 488;
>  			ret = IIO_VAL_INT_PLUS_NANO;
>  			break;
>  		case IIO_VOLTAGE:
> -			/* 1170mV / 2^23 */
> +			/* VIN Scale: 1170mV / 2^23 */
>  			*val = 1170;
>  			*val2 = 23;
>  			ret = IIO_VAL_FRACTIONAL_LOG2;
> @@ -666,7 +687,8 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
>  	unsigned int tmp;
>  	int ret;
>  
> -	/* The default excitation outputs are not inverted, it should be stated
> +	/*
> +	 * The default excitation outputs are not inverted, it should be stated
>  	 * in the dt if needed.
>  	 */
>  
> @@ -678,7 +700,7 @@ static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
>  	ret = of_property_read_u32(np, "adi,exclvl", &tmp);
>  	if (ret || tmp > 3) {
>  		dev_warn(dev, "Wrong exclvl value, using default\n");
> -		pdata->exclvl = 3; /* default value */
> +		pdata->exclvl = 3;
>  	} else {
>  		pdata->exclvl = tmp;
>  	}
