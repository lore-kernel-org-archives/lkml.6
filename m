Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936379AbeE0JcE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbeE0JcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:32:03 -0400
Date: Sun, 27 May 2018 10:31:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: 104-quad-8: Provide defines for magic numbers
Message-ID: <20180527103158.477e9353@archlinux>
In-Reply-To: <3b4452fd58136d15e4188f465657db5911a01dc6.1527193661.git.vilhelm.gray@gmail.com>
References: <cover.1527193661.git.vilhelm.gray@gmail.com>
        <3b4452fd58136d15e4188f465657db5911a01dc6.1527193661.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 16:37:58 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds several register and bit defines to help improve the
> clarity of the code by cleaning up magic numbers throughout the driver
> source code.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Hi William

I'd prefer a prefix to cut down on likely naming clashes between
these and things in headers in the future.

Jonathan
> ---
>  drivers/iio/counter/104-quad-8.c | 86 ++++++++++++++++++++++----------
>  1 file changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index 4be85ec54af4..7d605d783051 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -59,6 +59,39 @@ struct quad8_iio {
>  	unsigned int base;
>  };
>  
> +#define REG_CHANNEL_OPERATION 0x11
> +#define REG_INDEX_INPUT_LEVELS 0x16
> +/* Borrow Toggle flip-flop */
> +#define FLAG_BT BIT(0)
> +/* Carry Toggle flip-flop */
> +#define FLAG_CT BIT(1)
> +/* Error flag */
> +#define FLAG_E BIT(4)
> +/* Up/Down flag */
> +#define FLAG_UD BIT(5)
> +/* Reset and Load Signal Decoders */
> +#define CTR_RLD 0x00
> +/* Counter Mode Register */
> +#define CTR_CMR 0x20
> +/* Input / Output Control Register */
> +#define CTR_IOR 0x40
> +/* Index Control Register */
> +#define CTR_IDR 0x60
> +/* Reset Byte Pointer (three byte data pointer) */
> +#define RLD_RESET_BP 0x01
> +/* Reset Counter */
> +#define RLD_RESET_CNTR 0x02
> +/* Reset Borrow Toggle, Carry Toggle, Compare Toggle, and Sign flags */
> +#define RLD_RESET_FLAGS 0x04
> +/* Reset Error flag */
> +#define RLD_RESET_E 0x06
> +/* Preset Register to Counter */
> +#define RLD_PRESET_CNTR 0x08
> +/* Transfer Counter to Output Latch */
> +#define RLD_CNTR_OUT 0x10
> +#define CHAN_OP_ENABLE_COUNTERS 0x00
> +#define CHAN_OP_RESET_COUNTERS 0x01
> +
>  static int quad8_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
> @@ -72,19 +105,20 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->type == IIO_INDEX) {
> -			*val = !!(inb(priv->base + 0x16) & BIT(chan->channel));
> +			*val = !!(inb(priv->base + REG_INDEX_INPUT_LEVELS)
> +				& BIT(chan->channel));
>  			return IIO_VAL_INT;
>  		}
>  
>  		flags = inb(base_offset + 1);
> -		borrow = flags & BIT(0);
> -		carry = !!(flags & BIT(1));
> +		borrow = flags & FLAG_BT;
> +		carry = !!(flags & FLAG_CT);
>  
>  		/* Borrow XOR Carry effectively doubles count range */
>  		*val = (borrow ^ carry) << 24;
>  
>  		/* Reset Byte Pointer; transfer Counter to Output Latch */
> -		outb(0x11, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_BP | RLD_CNTR_OUT, base_offset + 1);
>  
>  		for (i = 0; i < 3; i++)
>  			*val |= (unsigned int)inb(base_offset) << (8 * i);
> @@ -120,17 +154,17 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		/* Reset Byte Pointer */
> -		outb(0x01, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_BP, base_offset + 1);
>  
>  		/* Counter can only be set via Preset Register */
>  		for (i = 0; i < 3; i++)
>  			outb(val >> (8 * i), base_offset);
>  
>  		/* Transfer Preset Register to Counter */
> -		outb(0x08, base_offset + 1);
> +		outb(CTR_RLD | RLD_PRESET_CNTR, base_offset + 1);
>  
>  		/* Reset Byte Pointer */
> -		outb(0x01, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_BP, base_offset + 1);
>  
>  		/* Set Preset Register back to original value */
>  		val = priv->preset[chan->channel];
> @@ -138,9 +172,9 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  			outb(val >> (8 * i), base_offset);
>  
>  		/* Reset Borrow, Carry, Compare, and Sign flags */
> -		outb(0x04, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_FLAGS, base_offset + 1);
>  		/* Reset Error flag */
> -		outb(0x06, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_E, base_offset + 1);
>  
>  		return 0;
>  	case IIO_CHAN_INFO_ENABLE:
> @@ -153,7 +187,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
>  
>  		/* Load I/O control configuration */
> -		outb(0x40 | ior_cfg, base_offset + 1);
> +		outb(CTR_IOR | ior_cfg, base_offset + 1);
>  
>  		return 0;
>  	case IIO_CHAN_INFO_SCALE:
> @@ -217,7 +251,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
>  	priv->preset[chan->channel] = preset;
>  
>  	/* Reset Byte Pointer */
> -	outb(0x01, base_offset + 1);
> +	outb(CTR_RLD | RLD_RESET_BP, base_offset + 1);
>  
>  	/* Set Preset Register */
>  	for (i = 0; i < 3; i++)
> @@ -258,7 +292,7 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>  		(unsigned int)preset_enable << 1;
>  
>  	/* Load I/O control configuration to Input / Output Control Register */
> -	outb(0x40 | ior_cfg, base_offset);
> +	outb(CTR_IOR | ior_cfg, base_offset);
>  
>  	return len;
>  }
> @@ -274,7 +308,7 @@ static int quad8_get_noise_error(struct iio_dev *indio_dev,
>  	struct quad8_iio *const priv = iio_priv(indio_dev);
>  	const int base_offset = priv->base + 2 * chan->channel + 1;
>  
> -	return !!(inb(base_offset) & BIT(4));
> +	return !!(inb(base_offset) & FLAG_E);
>  }
>  
>  static const struct iio_enum quad8_noise_error_enum = {
> @@ -294,7 +328,7 @@ static int quad8_get_count_direction(struct iio_dev *indio_dev,
>  	struct quad8_iio *const priv = iio_priv(indio_dev);
>  	const int base_offset = priv->base + 2 * chan->channel + 1;
>  
> -	return !!(inb(base_offset) & BIT(5));
> +	return !!(inb(base_offset) & FLAG_UD);
>  }
>  
>  static const struct iio_enum quad8_count_direction_enum = {
> @@ -324,7 +358,7 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
>  		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
>  
>  	/* Load mode configuration to Counter Mode Register */
> -	outb(0x20 | mode_cfg, base_offset);
> +	outb(CTR_CMR | mode_cfg, base_offset);
>  
>  	return 0;
>  }
> @@ -364,7 +398,7 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
>  	priv->synchronous_mode[chan->channel] = synchronous_mode;
>  
>  	/* Load Index Control configuration to Index Control Register */
> -	outb(0x60 | idr_cfg, base_offset);
> +	outb(CTR_IDR | idr_cfg, base_offset);
>  
>  	return 0;
>  }
> @@ -410,7 +444,7 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
>  	priv->quadrature_mode[chan->channel] = quadrature_mode;
>  
>  	/* Load mode configuration to Counter Mode Register */
> -	outb(0x20 | mode_cfg, base_offset);
> +	outb(CTR_CMR | mode_cfg, base_offset);
>  
>  	return 0;
>  }
> @@ -446,7 +480,7 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
>  	priv->index_polarity[chan->channel] = index_polarity;
>  
>  	/* Load Index Control configuration to Index Control Register */
> -	outb(0x60 | idr_cfg, base_offset);
> +	outb(CTR_IDR | idr_cfg, base_offset);
>  
>  	return 0;
>  }
> @@ -556,28 +590,28 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	priv->base = base[id];
>  
>  	/* Reset all counters and disable interrupt function */
> -	outb(0x01, base[id] + 0x11);
> +	outb(CHAN_OP_RESET_COUNTERS, base[id] + REG_CHANNEL_OPERATION);
>  	/* Set initial configuration for all counters */
>  	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
>  		base_offset = base[id] + 2 * i;
>  		/* Reset Byte Pointer */
> -		outb(0x01, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_BP, base_offset + 1);
>  		/* Reset Preset Register */
>  		for (j = 0; j < 3; j++)
>  			outb(0x00, base_offset);
>  		/* Reset Borrow, Carry, Compare, and Sign flags */
> -		outb(0x04, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_FLAGS, base_offset + 1);
>  		/* Reset Error flag */
> -		outb(0x06, base_offset + 1);
> +		outb(CTR_RLD | RLD_RESET_E, base_offset + 1);
>  		/* Binary encoding; Normal count; non-quadrature mode */
> -		outb(0x20, base_offset + 1);
> +		outb(CTR_CMR, base_offset + 1);
>  		/* Disable A and B inputs; preset on index; FLG1 as Carry */
> -		outb(0x40, base_offset + 1);
> +		outb(CTR_IOR, base_offset + 1);
>  		/* Disable index function; negative index polarity */
> -		outb(0x60, base_offset + 1);
> +		outb(CTR_IDR, base_offset + 1);
>  	}
>  	/* Enable all counters */
> -	outb(0x00, base[id] + 0x11);
> +	outb(CHAN_OP_ENABLE_COUNTERS, base[id] + REG_CHANNEL_OPERATION);
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
