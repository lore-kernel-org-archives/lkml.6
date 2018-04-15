Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDOTSC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 15:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeDOTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 15:18:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA1B2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:17:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: sca3000: Fix an error handling path in
 'sca3000_probe()'
Message-ID: <20180415201755.62a73e7d@archlinux>
In-Reply-To: <20180408194401.18348-1-christophe.jaillet@wanadoo.fr>
References: <20180408194401.18348-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Apr 2018 21:44:01 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use 'devm_iio_kfifo_allocate()' instead of 'iio_kfifo_allocate()' in order
> to simplify code and avoid a memory leak in an error path in
> 'sca3000_probe()'. A call to 'sca3000_unconfigure_ring()' was missing.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I thought about queueing this up as a fix, but as it is unlikely
to be hit and there is another patch (which isn't a fix) dependent
on it I went with the worst of both worlds and took it for the next
merge window whilst marking it for stable.

I added a note to the description to say why for when people see
it next cycle

Thanks,

Jonathan

> ---
> v2: Use a devm_ function to fix the leak reported in v1.
>     This makes 'sca3000_unconfigure_ring()' useless and simplify code.
> ---
>  drivers/iio/accel/sca3000.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index f33dadf7b262..562f125235db 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1277,7 +1277,7 @@ static int sca3000_configure_ring(struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer;
>  
> -	buffer = iio_kfifo_allocate();
> +	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>  	if (!buffer)
>  		return -ENOMEM;
>  
> @@ -1287,11 +1287,6 @@ static int sca3000_configure_ring(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
> -{
> -	iio_kfifo_free(indio_dev->buffer);
> -}
> -
>  static inline
>  int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
>  {
> @@ -1546,8 +1541,6 @@ static int sca3000_remove(struct spi_device *spi)
>  	if (spi->irq)
>  		free_irq(spi->irq, indio_dev);
>  
> -	sca3000_unconfigure_ring(indio_dev);
> -
>  	return 0;
>  }
>  
