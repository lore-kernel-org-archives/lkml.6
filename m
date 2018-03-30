Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC3MwZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeC3MwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:52:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6931921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 13:47:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 06/10] iio: adc: at91-sama5d2_adc: add support for
 position and pressure channels
Message-ID: <20180330134724.1c103989@archlinux>
In-Reply-To: <1522153963-1121-7-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
 <1522153963-1121-7-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 15:32:39 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> This implements the support for position and pressure for the included
> touchscreen support in the SAMA5D2 SOC ADC block.
> Two position channels are added and one for pressure.
> They can be read in raw format, or through a buffer.
> A normal use case is for a consumer driver to register a callback buffer
> for these channels.
> When the touchscreen channels are in the active scan mask,
> the driver will start the touchscreen sampling and push the data to the
> buffer.
> 
> Some parts of this patch are based on initial original work by
> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Looks pretty good to me.  A few minor comments inline.

Jonathan

> ---
> Changes in v2:
>  - the support is now based on callback buffer.
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 452 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 443 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 8729d65..29a7fb9 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -102,14 +102,26 @@
>  #define AT91_SAMA5D2_LCDR	0x20
>  /* Interrupt Enable Register */
>  #define AT91_SAMA5D2_IER	0x24
> +/* Interrupt Enable Register - TS X measurement ready */
> +#define AT91_SAMA5D2_IER_XRDY   BIT(20)
> +/* Interrupt Enable Register - TS Y measurement ready */
> +#define AT91_SAMA5D2_IER_YRDY   BIT(21)
> +/* Interrupt Enable Register - TS pressure measurement ready */
> +#define AT91_SAMA5D2_IER_PRDY   BIT(22)
>  /* Interrupt Enable Register - general overrun error */
>  #define AT91_SAMA5D2_IER_GOVRE BIT(25)
> +/* Interrupt Enable Register - Pen detect */
> +#define AT91_SAMA5D2_IER_PEN    BIT(29)
> +/* Interrupt Enable Register - No pen detect */
> +#define AT91_SAMA5D2_IER_NOPEN  BIT(30)
>  /* Interrupt Disable Register */
>  #define AT91_SAMA5D2_IDR	0x28
>  /* Interrupt Mask Register */
>  #define AT91_SAMA5D2_IMR	0x2c
>  /* Interrupt Status Register */
>  #define AT91_SAMA5D2_ISR	0x30
> +/* Interrupt Status Register - Pen touching sense status */
> +#define AT91_SAMA5D2_ISR_PENS   BIT(31)
>  /* Last Channel Trigger Mode Register */
>  #define AT91_SAMA5D2_LCTMR	0x34
>  /* Last Channel Compare Window Register */
> @@ -131,8 +143,38 @@
>  #define AT91_SAMA5D2_CDR0	0x50
>  /* Analog Control Register */
>  #define AT91_SAMA5D2_ACR	0x94
> +/* Analog Control Register - Pen detect sensitivity mask */
> +#define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(1, 0)
> +
>  /* Touchscreen Mode Register */
>  #define AT91_SAMA5D2_TSMR	0xb0
> +/* Touchscreen Mode Register - No touch mode */
> +#define AT91_SAMA5D2_TSMR_TSMODE_NONE           0
> +/* Touchscreen Mode Register - 4 wire screen, no pressure measurement */
> +#define AT91_SAMA5D2_TSMR_TSMODE_4WIRE_NO_PRESS 1
> +/* Touchscreen Mode Register - 4 wire screen, pressure measurement */
> +#define AT91_SAMA5D2_TSMR_TSMODE_4WIRE_PRESS    2
> +/* Touchscreen Mode Register - 5 wire screen */
> +#define AT91_SAMA5D2_TSMR_TSMODE_5WIRE          3
> +/* Touchscreen Mode Register - Average samples mask */
> +#define AT91_SAMA5D2_TSMR_TSAV_MASK             GENMASK(5, 4)
> +/* Touchscreen Mode Register - Average samples */
> +#define AT91_SAMA5D2_TSMR_TSAV(x)               ((x) << 4)
> +/* Touchscreen Mode Register - Touch/trigger frequency ratio mask */
> +#define AT91_SAMA5D2_TSMR_TSFREQ_MASK           GENMASK(11, 8)
> +/* Touchscreen Mode Register - Touch/trigger frequency ratio */
> +#define AT91_SAMA5D2_TSMR_TSFREQ(x)             ((x) << 8)
> +/* Touchscreen Mode Register - Pen Debounce Time mask */
> +#define AT91_SAMA5D2_TSMR_PENDBC_MASK           GENMASK(31, 28)
> +/* Touchscreen Mode Register - Pen Debounce Time */
> +#define AT91_SAMA5D2_TSMR_PENDBC(x)            ((x) << 28)
> +/* Touchscreen Mode Register - No DMA for touch measurements */
> +#define AT91_SAMA5D2_TSMR_NOTSDMA               BIT(22)
> +/* Touchscreen Mode Register - Disable pen detection */
> +#define AT91_SAMA5D2_TSMR_PENDET_DIS            (0 << 24)
> +/* Touchscreen Mode Register - Enable pen detection */
> +#define AT91_SAMA5D2_TSMR_PENDET_ENA            BIT(24)
> +
>  /* Touchscreen X Position Register */
>  #define AT91_SAMA5D2_XPOSR	0xb4
>  /* Touchscreen Y Position Register */
> @@ -151,6 +193,12 @@
>  #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL 2
>  /* Trigger Mode external trigger any edge */
>  #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY 3
> +/* Trigger Mode internal periodic */
> +#define AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC 5
> +/* Trigger Mode - trigger period mask */
> +#define AT91_SAMA5D2_TRGR_TRGPER_MASK           GENMASK(31, 16)
> +/* Trigger Mode - trigger period */
> +#define AT91_SAMA5D2_TRGR_TRGPER(x)             ((x) << 16)
>  
>  /* Correction Select Register */
>  #define AT91_SAMA5D2_COSR	0xd0
> @@ -169,6 +217,22 @@
>  #define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
>  #define AT91_SAMA5D2_DIFF_CHAN_CNT 6
>  
> +#define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> +					 AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
> +
> +#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> +					 AT91_SAMA5D2_DIFF_CHAN_CNT * 2)
> +#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX   (AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
> +#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX   (AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
> +#define AT91_SAMA5D2_MAX_CHAN_IDX	AT91_SAMA5D2_TOUCH_P_CHAN_IDX
> +
> +#define TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
> +#define TOUCH_PEN_DETECT_DEBOUNCE_US    200
> +
> +#define XYZ_MASK			GENMASK(11, 0)
> +
> +#define MAX_POS_BITS			12
> +
Please prefix these defines as the chances of a clash with these generic names
is very high.

>  /*
>   * Maximum number of bytes to hold conversion from all channels
>   * without the timestamp.
> @@ -222,6 +286,37 @@
>  		.indexed = 1,						\
>  	}
>  
> +#define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
> +	{								\
> +		.type = IIO_POSITIONRELATIVE,				\
> +		.modified = 1,						\
> +		.channel = num,						\
> +		.channel2 = mod,					\
> +		.scan_index = num,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 12,					\
> +			.storagebits = 16,				\
> +		},							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.datasheet_name = name,					\
> +	}
> +#define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
> +	{								\
> +		.type = IIO_PRESSURE,					\
> +		.channel = num,						\
> +		.scan_index = num,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 12,					\
> +			.storagebits = 16,				\
> +		},							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.datasheet_name = name,					\
> +	}
> +
>  #define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
>  #define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
>  
> @@ -260,6 +355,22 @@ struct at91_adc_dma {
>  	s64				dma_ts;
>  };
>  
> +/**
> + * at91_adc_touch - at91-sama5d2 touchscreen information struct
> + * @sample_period_val:		the value for periodic trigger interval
> + * @touching:			is the pen touching the screen or not
> + * @x_pos:			temporary placeholder for pressure computation
> + * @channels_bitmask:		bitmask with the touchscreen channels enabled
> + * @workq:			workqueue for buffer data pushing
> + */
> +struct at91_adc_touch {
> +	u16				sample_period_val;
> +	bool				touching;
> +	u16				x_pos;
> +	unsigned long			channels_bitmask;
> +	struct work_struct		workq;
> +};
> +
>  struct at91_adc_state {
>  	void __iomem			*base;
>  	int				irq;
> @@ -267,6 +378,7 @@ struct at91_adc_state {
>  	struct regulator		*reg;
>  	struct regulator		*vref;
>  	int				vref_uv;
> +	unsigned int			current_sample_rate;
>  	struct iio_trigger		*trig;
>  	const struct at91_adc_trigger	*selected_trig;
>  	const struct iio_chan_spec	*chan;
> @@ -275,6 +387,7 @@ struct at91_adc_state {
>  	struct at91_adc_soc_info	soc_info;
>  	wait_queue_head_t		wq_data_available;
>  	struct at91_adc_dma		dma_st;
> +	struct at91_adc_touch		touch_st;
>  	u16				buffer[AT91_BUFFER_MAX_HWORDS];
>  	/*
>  	 * lock to prevent concurrent 'single conversion' requests through
> @@ -329,8 +442,10 @@ static const struct iio_chan_spec at91_adc_channels[] = {
>  	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
>  	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
>  	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
> -	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_SINGLE_CHAN_CNT
> -				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
> +	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_TIMESTAMP_CHAN_IDX),
> +	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_X_CHAN_IDX, "x", IIO_MOD_X),
> +	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, "y", IIO_MOD_Y),
> +	AT91_SAMA5D2_CHAN_PRESSURE(AT91_SAMA5D2_TOUCH_P_CHAN_IDX, "pressure"),
>  };
>  
>  static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
> @@ -354,6 +469,162 @@ at91_adc_chan_get(struct iio_dev *indio_dev, int chan)
>  	return indio_dev->channels + index;
>  }
>  
> +static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
> +				    const struct of_phandle_args *iiospec)
> +{
> +	return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
> +}
> +
> +static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
> +{
> +	u32 clk_khz = st->current_sample_rate / 1000;
> +	int i = 0;
> +	u16 pendbc;
> +	u32 tsmr, acr;
> +
> +	if (!state) {
> +		/* disabling touch IRQs and setting mode to no touch enabled */
> +		at91_adc_writel(st, AT91_SAMA5D2_IDR,
> +				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
> +		at91_adc_writel(st, AT91_SAMA5D2_TSMR, 0);
> +		return 0;
> +	}
> +	/*
> +	 * debounce time is in microseconds, we need it in milliseconds to
> +	 * multiply with kilohertz, so, divide by 1000, but after the multiply.
> +	 * round up to make sure pendbc is at least 1
> +	 */
> +	pendbc = round_up(TOUCH_PEN_DETECT_DEBOUNCE_US * clk_khz / 1000, 1);
> +
> +	/* get the required exponent */
> +	while (pendbc >> i++)
> +		;
> +
> +	pendbc = i;
> +
> +	tsmr = AT91_SAMA5D2_TSMR_TSMODE_4WIRE_PRESS;
> +
> +	tsmr |= AT91_SAMA5D2_TSMR_TSAV(2) & AT91_SAMA5D2_TSMR_TSAV_MASK;
> +	tsmr |= AT91_SAMA5D2_TSMR_PENDBC(pendbc) &
> +		AT91_SAMA5D2_TSMR_PENDBC_MASK;
> +	tsmr |= AT91_SAMA5D2_TSMR_NOTSDMA;
> +	tsmr |= AT91_SAMA5D2_TSMR_PENDET_ENA;
> +	tsmr |= AT91_SAMA5D2_TSMR_TSFREQ(2) & AT91_SAMA5D2_TSMR_TSFREQ_MASK;
> +
> +	at91_adc_writel(st, AT91_SAMA5D2_TSMR, tsmr);
> +
> +	acr =  at91_adc_readl(st, AT91_SAMA5D2_ACR);
> +	acr &= ~AT91_SAMA5D2_ACR_PENDETSENS_MASK;
> +	acr |= 0x02 & AT91_SAMA5D2_ACR_PENDETSENS_MASK;
> +	at91_adc_writel(st, AT91_SAMA5D2_ACR, acr);
> +
> +	/* Sample Period Time = (TRGPER + 1) / ADCClock */
> +	st->touch_st.sample_period_val = round_up((TOUCH_SAMPLE_PERIOD_US *
> +					 clk_khz / 1000) - 1, 1);
> +	/* enable pen detect IRQ */
> +	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
> +
> +	return 0;
> +}
> +
> +static u16 at91_adc_touch_x_pos(struct at91_adc_state *st)
> +{
> +	u32 val;
> +	u32 xscale, x, xpos;
> +
> +	/* x position = (x / xscale) * max, max = 2^MAX_POS_BITS - 1 */
> +	val = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
> +	if (!val)
> +		dev_dbg(&iio_priv_to_dev(st)->dev, "x_pos is 0\n");
> +
> +	xpos = val & XYZ_MASK;
> +	x = (xpos << MAX_POS_BITS) - xpos;
> +	xscale = (val >> 16) & XYZ_MASK;
> +	if (xscale == 0) {
> +		dev_err(&iio_priv_to_dev(st)->dev, "xscale is 0\n");
> +		return 0;
> +	}
> +	x /= xscale;
> +	st->touch_st.x_pos = x;
> +
> +	return x;
> +}
> +
> +static u16 at91_adc_touch_y_pos(struct at91_adc_state *st)
> +{
> +	u32 val;
> +	u32 yscale, y, ypos;
> +
> +	/* y position = (y / yscale) * max, max = 2^MAX_POS_BITS - 1 */
> +	val = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
> +	if (!val)
> +		dev_dbg(&iio_priv_to_dev(st)->dev, "y_pos is 0\n");
> +
> +	ypos = val & XYZ_MASK;
> +	y = (ypos << MAX_POS_BITS) - ypos;
> +	yscale = (val >> 16) & XYZ_MASK;
> +
> +	if (yscale == 0) {
> +		dev_err(&iio_priv_to_dev(st)->dev, "yscale is 0\n");
> +		return 0;
> +	}
> +
> +	y /= yscale;
> +
> +	return y;
This is obviously very similar to the above and feels like you need
some wrappers around a single function?
Just the xpos store needs to be outside the shared function.

> +}
> +
> +static u16 at91_adc_touch_pressure(struct at91_adc_state *st)
> +{
> +	u32 val;
> +	u32 z1, z2;
> +	u32 pres;
> +	u32 rxp = 1;
> +	u32 factor = 1000;
> +
> +	/* calculate the pressure */
> +	val = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
> +	z1 = val & XYZ_MASK;
> +	z2 = (val >> 16) & XYZ_MASK;
> +
> +	if (z1 != 0)
> +		pres = rxp * (st->touch_st.x_pos * factor / 1024) *
> +			(z2 * factor / z1 - factor) /
> +			factor;
> +	else
> +		pres = 0xFFFF;       /* no pen contact */
Would a pressure value of 0 not make more sense?

> +
> +	return pres;
> +}
> +
> +static int at91_adc_read_position(struct at91_adc_state *st, int chan, u16 *val)
> +{
> +	*val = 0;
> +	if (!st->touch_st.touching)
> +		return -ENODATA;
> +	if (chan == AT91_SAMA5D2_TOUCH_X_CHAN_IDX)
> +		*val = at91_adc_touch_x_pos(st);
> +	else if (chan == AT91_SAMA5D2_TOUCH_Y_CHAN_IDX)
> +		*val = at91_adc_touch_y_pos(st);
> +	else
> +		return -ENODATA;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int at91_adc_read_pressure(struct at91_adc_state *st, int chan, u16 *val)
> +{
> +	*val = 0;
> +	if (!st->touch_st.touching)
> +		return -ENODATA;
> +	if (chan == AT91_SAMA5D2_TOUCH_P_CHAN_IDX)
> +		*val = at91_adc_touch_pressure(st);
> +	else
> +		return -ENODATA;
> +
> +	return IIO_VAL_INT;
> +}
> +
>  static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> @@ -373,7 +644,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
>  		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
>  
> -		if (!chan)
> +		if (!chan || chan->type != IIO_VOLTAGE)
I think this would be more robust if we had it matching what it was rather
than what it wasn't.  Otherwise we'll get a temperature sensor on this
part at somepoint and it'll break.

>  			continue;
>  		if (state) {
>  			at91_adc_writel(st, AT91_SAMA5D2_CHER,
> @@ -520,7 +791,17 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
>  static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int ret;
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	/* check if we are enabling triggered buffer or the touchscreen */
> +	if (bitmap_subset(indio_dev->active_scan_mask,
> +			  &st->touch_st.channels_bitmask,
> +			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> +		/* touchscreen enabling */
> +		at91_adc_configure_touch(st, true);
Given you have that returning a value (be it always 0 I think)
better to pass that on here as well.

> +		return 0;
> +	}
> +	/* we continue with the triggered buffer */
>  	ret = at91_adc_dma_start(indio_dev);
>  	if (ret) {
>  		dev_err(&indio_dev->dev, "buffer postenable failed\n");
> @@ -536,6 +817,16 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	int ret;
>  	u8 bit;
>  
> +	/* check if we are disabling triggered buffer or the touchscreen */
> +	if (bitmap_subset(indio_dev->active_scan_mask,
> +			  &st->touch_st.channels_bitmask,
> +			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> +		/* touchscreen disable */
> +		at91_adc_configure_touch(st, false);
> +		return 0;
> +	}
> +
> +	/* continue with the triggered buffer */
>  	ret = iio_triggered_buffer_predisable(indio_dev);
>  	if (ret < 0)
>  		dev_err(&indio_dev->dev, "buffer predisable failed\n");
> @@ -556,7 +847,7 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  		struct iio_chan_spec const *chan =
>  					at91_adc_chan_get(indio_dev, bit);
>  
> -		if (!chan)
> +		if (!chan && chan->type != IIO_VOLTAGE)
>  			continue;
>  		if (st->dma_st.dma_chan)
>  			at91_adc_readl(st, chan->address);
> @@ -622,7 +913,10 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  
>  		if (!chan)
>  			continue;
> -		st->buffer[i] = at91_adc_readl(st, chan->address);
> +		if (chan->type == IIO_VOLTAGE)
> +			st->buffer[i] = at91_adc_readl(st, chan->address);
> +		else
> +			st->buffer[i] = 0;
Please explain this one with a comment.

>  		i++;
>  	}
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
> @@ -736,6 +1030,7 @@ static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
>  
>  	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
>  		freq, startup, prescal);
> +	st->current_sample_rate = freq;
>  }
>  
>  static unsigned at91_adc_get_sample_freq(struct at91_adc_state *st)
> @@ -751,23 +1046,109 @@ static unsigned at91_adc_get_sample_freq(struct at91_adc_state *st)
If st->current_sample_rate is always valid, then
can we just use that for the get call?

>  	return f_adc;
>  }
>  
> +static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +	u8 bit;
> +	u16 val;
> +	int i = 0;
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 AT91_SAMA5D2_MAX_CHAN_IDX + 1) {
> +		struct iio_chan_spec const *chan =
> +					 at91_adc_chan_get(indio_dev, bit);
> +
> +		if (chan->type == IIO_POSITIONRELATIVE)
> +			at91_adc_read_position(st, chan->channel, &val);
> +		else if (chan->type == IIO_PRESSURE)
> +			at91_adc_read_pressure(st, chan->channel, &val);
> +		else
> +			continue;
> +		st->buffer[i] = val;
> +		i++;
> +	}
> +	/* schedule work to push to buffers */
I would expand the comment to say why you don't just do it directly.

> +	schedule_work(&st->touch_st.workq);
> +}
> +
> +static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
> +{
> +	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_PEN);
> +	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_NOPEN |
> +			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
> +			AT91_SAMA5D2_IER_PRDY);
> +	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
> +			AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC |
> +			AT91_SAMA5D2_TRGR_TRGPER(st->touch_st.sample_period_val));
> +	st->touch_st.touching = true;
> +}
> +
> +static void at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +
> +	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
> +			AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
> +	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_NOPEN |
> +			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
> +			AT91_SAMA5D2_IER_PRDY);
> +	st->touch_st.touching = false;
> +
> +	at91_adc_touch_data_handler(indio_dev);
> +
> +	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
> +}
> +
> +static void at91_adc_workq_handler(struct work_struct *workq)
> +{
> +	struct at91_adc_touch *touch_st = container_of(workq,
> +					struct at91_adc_touch, workq);
> +	struct at91_adc_state *st = container_of(touch_st,
> +					struct at91_adc_state, touch_st);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +
> +	iio_push_to_buffers(indio_dev, st->buffer);
> +}
> +
>  static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  {
>  	struct iio_dev *indio = private;
>  	struct at91_adc_state *st = iio_priv(indio);
>  	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
>  	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
> +	u32 rdy_mask = AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
> +			AT91_SAMA5D2_IER_PRDY;
>  
>  	if (!(status & imr))
>  		return IRQ_NONE;
> -
> -	if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
> +	if (status & AT91_SAMA5D2_IER_PEN) {
> +		/* pen detected IRQ */
> +		at91_adc_pen_detect_interrupt(st);
> +	} else if ((status & AT91_SAMA5D2_IER_NOPEN)) {
> +		/* nopen detected IRQ */
> +		at91_adc_no_pen_detect_interrupt(st);
> +	} else if ((status & AT91_SAMA5D2_ISR_PENS) &&
> +		   ((status & rdy_mask) == rdy_mask)) {
> +		/* periodic trigger IRQ - during pen sense */
> +		at91_adc_touch_data_handler(indio);
> +	} else if (status & AT91_SAMA5D2_ISR_PENS) {
> +		/*
> +		 * touching, but the measurements are not ready yet.
> +		 * read and ignore.
> +		 */
> +		status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
> +		status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
> +		status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
> +	} else if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
> +		/* triggered buffer without DMA */
>  		disable_irq_nosync(irq);
>  		iio_trigger_poll(indio->trig);
>  	} else if (iio_buffer_enabled(indio) && st->dma_st.dma_chan) {
> +		/* triggered buffer with DMA - should not happen */
>  		disable_irq_nosync(irq);
>  		WARN(true, "Unexpected irq occurred\n");
>  	} else if (!iio_buffer_enabled(indio)) {
> +		/* software requested conversion */
>  		st->conversion_value = at91_adc_readl(st, st->chan->address);
>  		st->conversion_done = true;
>  		wake_up_interruptible(&st->wq_data_available);
> @@ -791,6 +1172,21 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		mutex_lock(&st->lock);
>  
> +		if (chan->type == IIO_POSITIONRELATIVE) {
> +			ret = at91_adc_read_position(st,
> +						     chan->channel, (u16 *)val);
Odd line breaking, I'd expect chan->channel on the first line..

These exit paths are a bit ugly. Perhaps it is time to pull the
INFO_RAW block out as a utility function. Then the indenting will 
be less allowing a simple single exit point with the unlocking all
in one place.

> +			mutex_unlock(&st->lock);
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		}
> +		if (chan->type == IIO_PRESSURE) {
> +			ret = at91_adc_read_pressure(st,
> +						     chan->channel, (u16 *)val);
> +			mutex_unlock(&st->lock);
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		}
> +
>  		st->chan = chan;
>  
>  		if (chan->differential)
> @@ -974,9 +1370,29 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	return 0;
>  }
>  
> +static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				     const unsigned long *scan_mask)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	if (bitmap_subset(scan_mask, &st->touch_st.channels_bitmask,
> +			  AT91_SAMA5D2_MAX_CHAN_IDX + 1))
> +		return 0;
> +	/*
> +	 * if the new bitmap is a combination of touchscreen and regular
> +	 * channels, then we are not fine
> +	 */
> +	if (bitmap_intersects(&st->touch_st.channels_bitmask, scan_mask,
> +			      AT91_SAMA5D2_MAX_CHAN_IDX + 1))
> +		return -EBUSY;
> +	return 0;
> +}
> +
>  static const struct iio_info at91_adc_info = {
>  	.read_raw = &at91_adc_read_raw,
>  	.write_raw = &at91_adc_write_raw,
> +	.update_scan_mode = &at91_adc_update_scan_mode,
> +	.of_xlate = &at91_adc_of_xlate,
>  	.hwfifo_set_watermark = &at91_adc_set_watermark,
>  };
>  
> @@ -1044,13 +1460,20 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  	indio_dev->info = &at91_adc_info;
>  	indio_dev->channels = at91_adc_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
>  
>  	st = iio_priv(indio_dev);
>  
> +	bitmap_set(&st->touch_st.channels_bitmask,
> +		   AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
> +	bitmap_set(&st->touch_st.channels_bitmask,
> +		   AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, 1);
> +	bitmap_set(&st->touch_st.channels_bitmask,
> +		   AT91_SAMA5D2_TOUCH_P_CHAN_IDX, 1);
> +
>  	ret = of_property_read_u32(pdev->dev.of_node,
>  				   "atmel,min-sample-rate-hz",
>  				   &st->soc_info.min_sample_rate);
> @@ -1100,6 +1523,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	init_waitqueue_head(&st->wq_data_available);
>  	mutex_init(&st->lock);
> +	INIT_WORK(&st->touch_st.workq, at91_adc_workq_handler);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
> @@ -1272,8 +1696,18 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
>  	at91_adc_hw_init(st);
>  
>  	/* reconfiguring trigger hardware state */
> -	if (iio_buffer_enabled(indio_dev))
> +	if (!iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	/* check if we are enabling triggered buffer or the touchscreen */
> +	if (bitmap_subset(indio_dev->active_scan_mask,
> +			  &st->touch_st.channels_bitmask,
> +			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> +		/* touchscreen enabling */
> +		at91_adc_configure_touch(st, true);
> +	} else {
>  		at91_adc_configure_trigger(st->trig, true);
> +	}
>  
>  	return 0;
>  
