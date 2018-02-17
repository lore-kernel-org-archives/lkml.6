Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeBQMim (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 07:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeBQMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 07:38:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C14217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:38:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marc Titinger <marc.titinger@baylibre.com>,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH] iio: adc: ina2xx: Use 64-bit arithmetic instead of
 32-bit
Message-ID: <20180217123836.61cb3b25@archlinux>
In-Reply-To: <20180213165258.GA12967@embeddedor.com>
References: <20180213165258.GA12967@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 10:52:58 -0600
"Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:

> Add suffix ULL to constant 1000 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned).
> 
> The expression 1000 * sampling_us is currently being evaluated
> using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1463793
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
I've been trying to figure out if this matters in reality.
i.e. whether or not sampling_us is big enough for us to need
64 bit multiplication.
It's equal to the output for the macro SAMPLING_PERIOD(c)
(int_time_vbus + int_time_vshunt) * avg
So taking max values
(8244 + 68100) * 1024 = 78176256 
Then * 1000 which brings it well into the > 32bit range.

So the next question is when was this introduced.
I guess it was Stefan's recent patch but haven't checked yet...

Marc / Stephan, could you check if we are correct in thinking this is a real
bug rather than just a numerical oddity?

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ina2xx-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 0635a79..8649700 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -810,7 +810,7 @@ static int ina2xx_capture_thread(void *data)
>  		 * multiple times, i.e. samples are dropped.
>  		 */
>  		do {
> -			timespec64_add_ns(&next, 1000 * sampling_us);
> +			timespec64_add_ns(&next, 1000ULL * sampling_us);
>  			delta = timespec64_sub(next, now);
>  			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
>  		} while (delay_us <= 0);
