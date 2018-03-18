Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeCRKWv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 06:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbeCRKWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 06:22:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:22:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/adc/nau7802: Improve unlocking of a mutex in
 nau7802_read_raw()
Message-ID: <20180318102243.4cb99daa@archlinux>
In-Reply-To: <f2874cab-329b-297f-2b4a-bfc72755123d@users.sourceforge.net>
References: <f2874cab-329b-297f-2b4a-bfc72755123d@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 20:56:25 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Mar 2018 20:52:26 +0100
> 
> * Add a jump target so that a call of the function "mutex_unlock" is stored
>   only once in this function implementation.
> 
> * Replace two calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Similar to other cases, this non obvious error handling flow rather implies
that this block of code might work better as a utility function called from
the case statement.

> ---
>  drivers/iio/adc/nau7802.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index 8997e74a8847..68d06a492760 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -303,10 +303,8 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
>  		 *   - Channel 2 is value 1 in the CHS register
>  		 */
>  		ret = i2c_smbus_read_byte_data(st->client, NAU7802_REG_CTRL2);
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto unlock;
>  
>  		if (((ret & NAU7802_CTRL2_CHS_BIT) && !chan->channel) ||
>  				(!(ret & NAU7802_CTRL2_CHS_BIT) &&
> @@ -316,18 +314,15 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
>  					NAU7802_REG_CTRL2,
>  					NAU7802_CTRL2_CHS(chan->channel) |
>  					NAU7802_CTRL2_CRS(st->sample_rate));
> -
> -			if (ret < 0) {
> -				mutex_unlock(&st->lock);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				goto unlock;
>  		}
>  
>  		if (st->client->irq)
>  			ret = nau7802_read_irq(indio_dev, chan, val);
>  		else
>  			ret = nau7802_read_poll(indio_dev, chan, val);
> -
> +unlock:
>  		mutex_unlock(&st->lock);
blank line before simple returns.  It isn't a major enough part to be
worth the noise of adding them to existing code, but there is no reason
to take them out!

>  		return ret;
>  
