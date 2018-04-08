Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDHQc2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752859AbeDHQc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:32:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90AA217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 8 Apr 2018 17:32:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: sca3000: Fix an error handling path in
 'sca3000_probe()'
Message-ID: <20180408173220.7f2483c7@archlinux>
In-Reply-To: <20180402165942.9056-1-christophe.jaillet@wanadoo.fr>
References: <20180402165942.9056-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Apr 2018 18:59:42 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In case of error, we must undo the previous 'sca3000_configure_ring()' call
> in order to free some memory.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Perhaps we can simplify this by using devm_iio_kfifo_allocate in
the ring configure function?

> ---
>  drivers/iio/accel/sca3000.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index f33dadf7b262..dae4c594c170 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1496,7 +1496,7 @@ static int sca3000_probe(struct spi_device *spi)
>  					   "sca3000",
>  					   indio_dev);
>  		if (ret)
> -			return ret;
> +			goto error_unconfigure_ring;
>  	}
>  	indio_dev->setup_ops = &sca3000_ring_setup_ops;
>  	ret = sca3000_clean_setup(st);
> @@ -1513,6 +1513,9 @@ static int sca3000_probe(struct spi_device *spi)
>  	if (spi->irq)
>  		free_irq(spi->irq, indio_dev);
>  
> +error_unconfigure_ring:
> +	sca3000_unconfigure_ring(indio_dev);
> +
>  	return ret;
>  }
>  
