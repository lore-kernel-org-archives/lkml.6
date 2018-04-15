Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDOSQh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbeDOSQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865C72176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 19:16:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iio:dac:ad5686: Add support for various number
 of channels
Message-ID: <20180415191630.4a848bbd@archlinux>
In-Reply-To: <1523447551-13278-1-git-send-email-stefan.popa@analog.com>
References: <1523375832-29402-1-git-send-email-stefan.popa@analog.com>
        <1523447551-13278-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:52:31 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch adds a new num_channels attribute as part of the
> ad5686_chip_info struct which replaces the AD5686_DAC_CHANNELS define. This
> is a necessary step, since this driver should support similar devices which
> differ only in the number of channels.
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Refactored the patch to add num_channels and the new macro forms
> 	  for the existing parts.
> Changes in v3:
> 	- Nothing changed, just follow the patch set version.
> 
>  drivers/iio/dac/ad5686.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e328513..87d6e6e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -18,8 +18,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define AD5686_DAC_CHANNELS			4
> -
>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> @@ -45,12 +43,14 @@
>  /**
>   * struct ad5686_chip_info - chip specific information
>   * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> + * @num_channels:	number of channels
>   * @channel:		channel specification
>  */
>  
>  struct ad5686_chip_info {
>  	u16				int_vref_mv;
> -	struct iio_chan_spec		channel[AD5686_DAC_CHANNELS];
> +	unsigned int			num_channels;
> +	struct iio_chan_spec		*channels;
>  };
>  
>  /**
> @@ -268,14 +268,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  	{ },
>  };
>  
> -#define AD5868_CHANNEL(chan, bits, _shift) {			\
> +#define AD5868_CHANNEL(chan, addr, bits, _shift) {		\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.output = 1,					\
>  		.channel = chan,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> -		.address = AD5686_ADDR_DAC(chan),		\
> +		.address = addr,				\
>  		.scan_type = {					\
>  			.sign = 'u',				\
>  			.realbits = (bits),			\
> @@ -285,31 +285,36 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  		.ext_info = ad5686_ext_info,			\
>  }
>  
> +#define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 1, bits, _shift),		\
> +		AD5868_CHANNEL(1, 2, bits, _shift),		\
> +		AD5868_CHANNEL(2, 4, bits, _shift),		\
> +		AD5868_CHANNEL(3, 8, bits, _shift),		\
> +}
> +
> +DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
> +DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
> +DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
> +
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  	[ID_AD5684] = {
> -		.channel[0] = AD5868_CHANNEL(0, 12, 4),
> -		.channel[1] = AD5868_CHANNEL(1, 12, 4),
> -		.channel[2] = AD5868_CHANNEL(2, 12, 4),
> -		.channel[3] = AD5868_CHANNEL(3, 12, 4),
> +		.channels = ad5684_channels,
> +		.num_channels = 4,
>  		.int_vref_mv = 2500,
>  	},
>  	[ID_AD5685] = {
> -		.channel[0] = AD5868_CHANNEL(0, 14, 2),
> -		.channel[1] = AD5868_CHANNEL(1, 14, 2),
> -		.channel[2] = AD5868_CHANNEL(2, 14, 2),
> -		.channel[3] = AD5868_CHANNEL(3, 14, 2),
> +		.channels = ad5685r_channels,
>  		.int_vref_mv = 2500,
> +		.num_channels = 4,
>  	},
>  	[ID_AD5686] = {
> -		.channel[0] = AD5868_CHANNEL(0, 16, 0),
> -		.channel[1] = AD5868_CHANNEL(1, 16, 0),
> -		.channel[2] = AD5868_CHANNEL(2, 16, 0),
> -		.channel[3] = AD5868_CHANNEL(3, 16, 0),
> +		.channels = ad5686_channels,
> +		.num_channels = 4,
>  		.int_vref_mv = 2500,
>  	},
>  };
>  
> -
>  static int ad5686_probe(struct spi_device *spi)
>  {
>  	struct ad5686_state *st;
> @@ -353,8 +358,8 @@ static int ad5686_probe(struct spi_device *spi)
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad5686_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channel;
> -	indio_dev->num_channels = AD5686_DAC_CHANNELS;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
>  
>  	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
>  				!!voltage_uv, 0);
