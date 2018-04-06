Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDFPTx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:19:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752832AbeDFPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:19:50 -0400
Date: Fri, 6 Apr 2018 16:19:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Stefan Popa <stefan.popa@analog.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio:dac:ad5686: Add
 AD5672R/AD5676/AD5676R/AD5684R/AD5685R/AD5686R support
Message-ID: <20180406161920.0000247d@huawei.com>
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
        <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 16:55:18 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5684R/AD5685R/AD5686R are a family of 4 channel DACs with 12-bit,
> 14-bit and 16-bit precision respectively. The devices come either with a
> built-in reference or no built-in reference.
> 
> The AD5672R/AD5676/AD5676R are similar, except that they have 8 channels
> instead of 4.
> 
> Datasheets:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5672R_5676R.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686R_5685R_5684R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
For ease of review, I would prefer to see this split into 2 patches.
First refactor to add num channels and the new macro forms for existing parts.
Then add the new parts.


Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 97 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index f7f975c..5fb0179 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -19,8 +19,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define AD5686_DAC_CHANNELS			4
> -
>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> @@ -46,12 +44,14 @@
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
> @@ -88,9 +88,14 @@ struct ad5686_state {
>   */
>  
>  enum ad5686_supported_device_ids {
> +	ID_AD5672R,
> +	ID_AD5676,
> +	ID_AD5676R,
>  	ID_AD5684,
> -	ID_AD5685,
> +	ID_AD5684R,
> +	ID_AD5685R,
>  	ID_AD5686,
> +	ID_AD5686R
>  };
>  static int ad5686_spi_write(struct ad5686_state *st,
>  			     u8 cmd, u8 addr, u16 val, u8 shift)
> @@ -269,14 +274,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
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
> @@ -286,31 +291,72 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
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
> +#define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 0, bits, _shift),		\
> +		AD5868_CHANNEL(1, 1, bits, _shift),		\
> +		AD5868_CHANNEL(2, 2, bits, _shift),		\
> +		AD5868_CHANNEL(3, 3, bits, _shift),		\
> +		AD5868_CHANNEL(4, 4, bits, _shift),		\
> +		AD5868_CHANNEL(5, 5, bits, _shift),		\
> +		AD5868_CHANNEL(6, 6, bits, _shift),		\
> +		AD5868_CHANNEL(7, 7, bits, _shift),		\
> +}
> +
> +DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
> +DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
> +DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
> +DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
> +DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
> +
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
> +	[ID_AD5672R] = {
> +		.channels = ad5672_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5676] = {
> +		.channels = ad5676_channels,
> +		.num_channels = 8,
> +	},
> +	[ID_AD5676R] = {
> +		.channels = ad5676_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 8,
> +	},
>  	[ID_AD5684] = {
> -		.channel[0] = AD5868_CHANNEL(0, 12, 4),
> -		.channel[1] = AD5868_CHANNEL(1, 12, 4),
> -		.channel[2] = AD5868_CHANNEL(2, 12, 4),
> -		.channel[3] = AD5868_CHANNEL(3, 12, 4),
> +		.channels = ad5684_channels,
> +		.num_channels = 4,
> +	},
> +	[ID_AD5684R] = {
> +		.channels = ad5684_channels,
>  		.int_vref_mv = 2500,
> +		.num_channels = 4,
>  	},
> -	[ID_AD5685] = {
> -		.channel[0] = AD5868_CHANNEL(0, 14, 2),
> -		.channel[1] = AD5868_CHANNEL(1, 14, 2),
> -		.channel[2] = AD5868_CHANNEL(2, 14, 2),
> -		.channel[3] = AD5868_CHANNEL(3, 14, 2),
> +	[ID_AD5685R] = {
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
> +	},
> +	[ID_AD5686R] = {
> +		.channels = ad5686_channels,
>  		.int_vref_mv = 2500,
> +		.num_channels = 4,
>  	},
>  };
>  
> -
>  static int ad5686_probe(struct spi_device *spi)
>  {
>  	struct ad5686_state *st;
> @@ -354,8 +400,8 @@ static int ad5686_probe(struct spi_device *spi)
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
> @@ -387,9 +433,14 @@ static int ad5686_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad5686_id[] = {
> +	{"ad5672r", ID_AD5672R},
> +	{"ad5676", ID_AD5676},
> +	{"ad5676r", ID_AD5676R},
>  	{"ad5684", ID_AD5684},
> -	{"ad5685", ID_AD5685},
> +	{"ad5684r", ID_AD5684R},
> +	{"ad5685r", ID_AD5685R},
>  	{"ad5686", ID_AD5686},
> +	{"ad5686r", ID_AD5686R},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad5686_id);
