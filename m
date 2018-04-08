Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeDHQdn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeDHQdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:33:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BF221772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 8 Apr 2018 17:33:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: sca3000: Handle errors returned by
 'sca3000_configure_ring()' in 'sca3000_probe()'
Message-ID: <20180408173336.7be562f3@archlinux>
In-Reply-To: <20180402165953.9110-1-christophe.jaillet@wanadoo.fr>
References: <20180402165953.9110-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Apr 2018 18:59:53 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'sca3000_configure_ring()' can fail, so test its return value and
> propagate it if needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Un-tested and not 100% sure that we should bail-out if it fails.
Good catch - and yes we should bail out on error here.

I'll pick this one up when we finish discussion of patch 1.
(or possibly in v2 if you agree with my suggestion there).

Thanks,

Jonathan
> ---
>  drivers/iio/accel/sca3000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index dae4c594c170..45285edd216f 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1486,7 +1486,9 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	sca3000_configure_ring(indio_dev);
> +	ret = sca3000_configure_ring(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	if (spi->irq) {
>  		ret = request_threaded_irq(spi->irq,
