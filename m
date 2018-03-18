Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeCRKTA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 06:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbeCRKS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 06:18:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:18:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/adc/ad7291: Improve unlocking of a mutex in
 ad7291_read_raw()
Message-ID: <20180318101853.756785b4@archlinux>
In-Reply-To: <a53248a9-4422-4436-aa43-bfbd2b60a85f@users.sourceforge.net>
References: <a53248a9-4422-4436-aa43-bfbd2b60a85f@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 20:16:27 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Mar 2018 20:08:40 +0100
> 
> * Add a jump target so that a call of the function "mutex_unlock" is stored
>   only once in this function implementation.
> 
> * Replace three calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/iio/adc/ad7291.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index a862b5d8fb4b..b2c3d4c79909 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -335,27 +335,27 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  			mutex_lock(&chip->state_lock);
>  			/* If in autocycle mode drop through */
>  			if (chip->command & AD7291_AUTOCYCLE) {
> -				mutex_unlock(&chip->state_lock);
> -				return -EBUSY;
> +				ret = -EBUSY;
> +				goto unlock;
>  			}
>  			/* Enable this channel alone */
>  			regval = chip->command & (~AD7291_VOLTAGE_MASK);
>  			regval |= BIT(15 - chan->channel);
>  			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
> -			if (ret < 0) {
> -				mutex_unlock(&chip->state_lock);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				goto unlock;
> +
>  			/* Read voltage */
>  			ret = i2c_smbus_read_word_swapped(chip->client,
>  							  AD7291_VOLTAGE);
> -			if (ret < 0) {
> -				mutex_unlock(&chip->state_lock);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				goto unlock;
> +
>  			*val = ret & AD7291_VALUE_MASK;
> +			ret = IIO_VAL_INT;
> +unlock:
>  			mutex_unlock(&chip->state_lock);
> -			return IIO_VAL_INT;
> +			return ret;
This localized error handling makes for complex code flow.  It does however
suggest that perhaps this block of code would be better in it's own function
with nice clean internal error handling.

>  		case IIO_TEMP:
>  			/* Assumes tsense bit of command register always set */
>  			ret = i2c_smbus_read_word_swapped(chip->client,

Markus, please throttle these patches to one at a time.  If you send lots
of similar patches before anyone has reviewed any of them it wastes both
your and reviewers time.

Thanks,

Jonathan
