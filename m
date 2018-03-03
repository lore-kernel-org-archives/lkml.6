Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeCCPhb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbeCCPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:37:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209562178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:37:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pierre Bourdon <delroth@google.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 1/2] iio: light: add driver for bh1730fvc chips
Message-ID: <20180303153723.40773aae@archlinux>
In-Reply-To: <CAHp75VfEaaJfREj5jBk7uwr2aRL96JN4Co=tir9Foy6L9=_o8A@mail.gmail.com>
References: <20180228001525.96044-1-delroth@google.com>
        <CAHp75VfEaaJfREj5jBk7uwr2aRL96JN4Co=tir9Foy6L9=_o8A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 17:06:09 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Feb 28, 2018 at 2:15 AM, Pierre Bourdon <delroth@google.com> wrote:
> > Ambient light sensor that supports visible light and IR measurements and
> > configurable gain/integration time.
> >
> > This is written as an additional driver instead of being added into the
> > existing bh1750 / bh1780 drivers. The bh1730 chip is significantly
> > different from either of these two:
> >
> > * bh1750 is not fully smbus compatible and only partially supports
> >   continuous reading mode since not all of its supported chips have this
> >   feature.
> >
> > * bh1780 does gain adjustment in hardware and exposes lux values
> >   directly, as opposed to bh1730 which provides two raw channels (IR +
> >   visible light) and requires manual gain adjustment and lux computation
> >   in the driver.
> >  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Andy, one quick query inline for you.
(I'm just curious ;)

> 
> Some minors below. You might address them.
Given we aren't at that close to the merge window opening and these
are all minor changes, it probably makes sense to address them.

Andy has left it up to you however and I don't feel strongly
enough about any of these if you want to leave things as they are.

So let me know either way.

Jonathan

> 
> > Changed in v2:
> > * Split off DT documentation change into a separate commit.
> > * Use i2c's probe_new.
> >
> > Changed in v3:
> > * Moved from 64 bit to 32 bit arithmetic where possible.
> > * Changed IIO channel configuration for consistency with other drivers.
> > * Refactored mathematical computations for readability.
> > * Removed unnecessary CONFIG_OF checks.
> >
> > Signed-off-by: Pierre Bourdon <delroth@google.com>
> > ---
> >  drivers/iio/light/Kconfig  |  10 +
> >  drivers/iio/light/Makefile |   1 +
> >  drivers/iio/light/bh1730.c | 434 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 445 insertions(+)
> >  create mode 100644 drivers/iio/light/bh1730.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 93fd421b10d7..286a7f78762b 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -63,6 +63,16 @@ config APDS9960
> >           To compile this driver as a module, choose M here: the
> >           module will be called apds9960
> >
> > +config BH1730
> > +       tristate "ROHM BH1730 ambient light sensor"
> > +       depends on I2C
> > +       help
> > +        Say Y here to build support for the ROHM BH1730FVC ambient
> > +        light sensor.
> > +
> > +        To compile this driver as a module, choose M here: the module will
> > +        be called bh1730.
> > +
> >  config BH1750
> >         tristate "ROHM BH1750 ambient light sensor"
> >         depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index f714067a7816..eb9010a10536 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_ADJD_S311)         += adjd_s311.o
> >  obj-$(CONFIG_AL3320A)          += al3320a.o
> >  obj-$(CONFIG_APDS9300)         += apds9300.o
> >  obj-$(CONFIG_APDS9960)         += apds9960.o
> > +obj-$(CONFIG_BH1730)           += bh1730.o
> >  obj-$(CONFIG_BH1750)           += bh1750.o
> >  obj-$(CONFIG_BH1780)           += bh1780.o
> >  obj-$(CONFIG_CM32181)          += cm32181.o
> > diff --git a/drivers/iio/light/bh1730.c b/drivers/iio/light/bh1730.c
> > new file mode 100644
> > index 000000000000..4a23fbd6ff84
> > --- /dev/null
> > +++ b/drivers/iio/light/bh1730.c
> > @@ -0,0 +1,434 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ROHM BH1730 ambient light sensor driver
> > + *
> > + * Copyright (c) 2018 Google, Inc.
> > + * Author: Pierre Bourdon <delroth@google.com>
> > + *
> > + * Based on a previous non-iio BH1730FVC driver:
> > + * Copyright (C) 2012 Samsung Electronics. All rights reserved.
> > + * Author: Won Huh <won.huh@samsung.com>
> > + *
> > + * Data sheets:
> > + *  http://www.rohm.com/web/global/datasheet/BH1730FVC/bh1730fvc-e
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/time.h>
> > +
> > +#define BH1730_CMD_BIT BIT(7)
> > +
> > +#define BH1730_REG_CONTROL     0x00
> > +#define BH1730_REG_TIMING      0x01
> > +#define BH1730_REG_INTERRUPT   0x02
> > +#define BH1730_REG_THLLOW      0x03
> > +#define BH1730_REG_THLHIGH     0x04
> > +#define BH1730_REG_THHLOW      0x05
> > +#define BH1730_REG_THHHIGH     0x06
> > +#define BH1730_REG_GAIN                0x07
> > +#define BH1730_REG_ID          0x12
> > +#define BH1730_REG_DATA0LOW    0x14
> > +#define BH1730_REG_DATA0HIGH   0x15
> > +#define BH1730_REG_DATA1LOW    0x16
> > +#define BH1730_REG_DATA1HIGH   0x17
> > +
> > +#define BH1730_CONTROL_POWER_ON                BIT(0)
> > +#define BH1730_CONTROL_MEASURE         BIT(1)
> > +
> > +#define BH1730_INTERNAL_CLOCK_NS       2800
> > +
> > +#define BH1730_DEFAULT_INTEG_MS                150
> > +
> > +enum bh1730_gain {
> > +       BH1730_GAIN_1X = 0,
> > +       BH1730_GAIN_2X,
> > +       BH1730_GAIN_64X,
> > +       BH1730_GAIN_128X,
> > +};
> > +#define BH1730_MAX_GAIN_MULTIPLIER 128
> > +
> > +struct bh1730_data {
> > +       struct i2c_client *client;
> > +       enum bh1730_gain gain;
> > +       int itime;
> > +};
> > +#define BH1730_MAX_GAIN_MULTIPLIER 128
> > +
> > +static int bh1730_read_word(struct bh1730_data *bh1730, u8 reg)
> > +{
> > +       int ret = i2c_smbus_read_word_data(bh1730->client,
> > +                                          BH1730_CMD_BIT | reg);
> > +       if (ret < 0)
> > +               dev_err(&bh1730->client->dev,
> > +                       "i2c read failed error %d, register %01x\n",
> > +                       ret, reg);
> > +
> > +       return ret;
> > +}
> > +
> > +static int bh1730_write(struct bh1730_data *bh1730, u8 reg, u8 val)
> > +{
> > +       int ret = i2c_smbus_write_byte_data(bh1730->client,
> > +                                           BH1730_CMD_BIT | reg,
> > +                                           val);
> > +       if (ret < 0)
> > +               dev_err(&bh1730->client->dev,
> > +                       "i2c write failed error %d, register %01x\n",
> > +                       ret, reg);
> > +
> > +       return ret;
> > +}
> > +
> > +static int gain_setting_to_multiplier(enum bh1730_gain gain)
> > +{
> > +       switch (gain) {
> > +       case BH1730_GAIN_1X:
> > +               return 1;
> > +       case BH1730_GAIN_2X:
> > +               return 2;
> > +       case BH1730_GAIN_64X:
> > +               return 64;
> > +       case BH1730_GAIN_128X:
> > +               return 128;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int bh1730_gain_multiplier(struct bh1730_data *bh1730)
> > +{
> > +       int multiplier = gain_setting_to_multiplier(bh1730->gain);
> > +
> > +       if (multiplier < 0) {
> > +               dev_warn(&bh1730->client->dev,
> > +                        "invalid gain multiplier settings: %d\n",
> > +                        bh1730->gain);
> > +               bh1730->gain = BH1730_GAIN_1X;
> > +               multiplier = 1;
> > +       }
> > +
> > +       return multiplier;
> > +}
> > +
> > +static int bh1730_itime_us(struct bh1730_data *bh1730)
> > +{
> > +       return (BH1730_INTERNAL_CLOCK_NS * 964 * (256 - bh1730->itime))
> > +                       / NSEC_PER_USEC;  
> 
> Better to leave / on the above line
> 
> Or
> 
> /* At worst case mul will be 688296000, so, there is no 32-bit overflow */
> ...()
> {
> int mul = BH1730_INTERNAL_CLOCK_NS * 964 * (256 - bh1730->itime);
> 
> return mul / NSEC_PER_USEC;
> }
> 
> > +}
> > +
> > +static int bh1730_set_gain(struct bh1730_data *bh1730, enum bh1730_gain gain)
> > +{
> > +       int ret = bh1730_write(bh1730, BH1730_REG_GAIN, gain);
> > +
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       bh1730->gain = gain;
> > +
> > +       return 0;
> > +}
> > +
> > +static int bh1730_set_integration_time_ms(struct bh1730_data *bh1730,
> > +                                         int time_ms)
> > +{
> > +       int ret, time_ns, itime;
> > +
> > +       /* Prefilter obviously invalid time_ms values that would overflow. */
> > +       if (time_ms <= 0 || time_ms > 1000)
> > +               goto out_of_range;
> > +
> > +       time_ns = time_ms * NSEC_PER_MSEC;
> > +       itime = 256 - DIV_ROUND_CLOSEST(time_ns,
> > +                                       BH1730_INTERNAL_CLOCK_NS * 964);
> > +
> > +       /* ITIME == 0 is reserved for manual integration mode. */  
> 
> > +       if (itime <= 0 || itime > 255)  
> 
> Just side note: Suprisingly how many in_range() implementations we
> have in kernel...
I guess one of those things that is so simple it's not worth having
one true in_range to rule them all ;)

> 
> > +               goto out_of_range;
> > +
> > +       ret = bh1730_write(bh1730, BH1730_REG_TIMING, itime);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       bh1730->itime = itime;
> > +
> > +       return 0;
> > +
> > +out_of_range:
> > +       dev_warn(&bh1730->client->dev, "integration time out of range: %dms\n",
> > +                time_ms);
> > +
> > +       return -ERANGE;
> > +}
> > +
> > +static void bh1730_wait_for_next_measurement(struct bh1730_data *bh1730)
> > +{
> > +       udelay(bh1730_itime_us(bh1730) +
> > +               DIV_ROUND_UP(BH1730_INTERNAL_CLOCK_NS * 714, NSEC_PER_USEC));  
> 
> int step = DIV_ROUND_UP(BH1730_INTERNAL_CLOCK_NS * 714, NSEC_PER_USEC);
> 
> udelay(... + step);
> 
> ?
> 
> > +}
> > +
> > +static int bh1730_adjust_gain(struct bh1730_data *bh1730)
> > +{
> > +       int visible, ir, highest, gain, ret, i;  
> 
> int visible, ir, highest, gain;
> unsigned int i;

Is there a strong reason for this one that I'm missing?
(beyond personal taste!)

> int ret;
> 
> > +
> > +       visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> > +       if (visible < 0)
> > +               return visible;
> > +
> > +       ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> > +       if (ir < 0)
> > +               return ir;
> > +
> > +       highest = max(visible, ir);
> > +
> > +       /*
> > +        * If the read value is being clamped, assume the worst and go to the
> > +        * lowest possible gain. The alternative is doing multiple
> > +        * recalibrations, which would be slower and have the same effect.
> > +        */
> > +       if (highest == USHRT_MAX)
> > +               gain = 1;
> > +       else
> > +               gain = bh1730_gain_multiplier(bh1730);
> > +
> > +       highest = (highest * BH1730_MAX_GAIN_MULTIPLIER) / gain;
> > +
> > +       /*
> > +        * Find the lowest gain multiplier which puts the measured values
> > +        * above 1024. This threshold is chosen to match the gap between 2X
> > +        * multiplier and 64X (next available) while keeping some margin.
> > +        */
> > +       for (i = BH1730_GAIN_1X; i < BH1730_GAIN_128X; ++i) {  
> 
> > +               int adj = highest * gain_setting_to_multiplier(i) /
> > +                               BH1730_MAX_GAIN_MULTIPLIER;  
> 
> I would rather
> 
> int adj;
> 
> adj = ...;
> if (adj ...)
>  break;
> 
> > +
> > +               if (adj >= 1024)
> > +                       break;
> > +       }
> > +
> > +       if (i != bh1730->gain) {
> > +               ret = bh1730_set_gain(bh1730, i);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               bh1730_wait_for_next_measurement(bh1730);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int bh1730_get_millilux(struct bh1730_data *bh1730)
> > +{
> > +       int visible, ir, visible_coef, ir_coef;
> > +       u64 millilux;
> > +
> > +       visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> > +       if (visible < 0)
> > +               return visible;
> > +
> > +       ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> > +       if (ir < 0)
> > +               return ir;
> > +  
> 
> > +       if (ir * 1000 / visible < 500) {
> > +               visible_coef = 5002;
> > +               ir_coef = 7502;
> > +       } else if (ir * 1000 / visible < 754) {
> > +               visible_coef = 2250;
> > +               ir_coef = 2000;
> > +       } else if (ir * 1000 / visible < 1029) {
> > +               visible_coef = 1999;
> > +               ir_coef = 1667;
> > +       } else if (ir * 1000 / visible < 1373) {
> > +               visible_coef = 885;
> > +               ir_coef = 583;
> > +       } else if (ir * 1000 / visible < 1879) {
> > +               visible_coef = 309;
> > +               ir_coef = 165;
> > +       } else {
> > +               return 0;
> > +       }  
> 
> > +
> > +       millilux = 103ULL * (visible_coef * visible - ir_coef * ir);
> > +       millilux *= USEC_PER_MSEC;  
> 
> Can it be one line?
> 
> > +       do_div(millilux, bh1730_itime_us(bh1730));
> > +       do_div(millilux, bh1730_gain_multiplier(bh1730));
> > +
> > +       /*
> > +        * Overflow here can only happen in extreme conditions:
> > +        * - Completely saturated visible light sensor and no measured IR.
> > +        * - Integration time < 16ms (driver currently defaults to 150ms).
> > +        */
> > +       if (millilux > INT_MAX)
> > +               return -ERANGE;
> > +
> > +       return (int)millilux;
> > +}
> > +
> > +static int bh1730_power_on(struct bh1730_data *bh1730)
> > +{
> > +       return bh1730_write(bh1730, BH1730_REG_CONTROL,
> > +                           BH1730_CONTROL_POWER_ON | BH1730_CONTROL_MEASURE);
> > +}
> > +
> > +static int bh1730_set_defaults(struct bh1730_data *bh1730)
> > +{
> > +       int ret;
> > +
> > +       ret = bh1730_set_gain(bh1730, BH1730_GAIN_1X);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = bh1730_set_integration_time_ms(bh1730, BH1730_DEFAULT_INTEG_MS);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       bh1730_wait_for_next_measurement(bh1730);
> > +
> > +       return 0;
> > +}
> > +
> > +static int bh1730_power_off(struct bh1730_data *bh1730)
> > +{
> > +       return bh1730_write(bh1730, BH1730_REG_CONTROL, 0);
> > +}
> > +
> > +static int bh1730_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +       struct bh1730_data *bh1730 = iio_priv(indio_dev);
> > +       int data_reg, ret;
> > +
> > +       ret = bh1730_adjust_gain(bh1730);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_PROCESSED:
> > +               ret = bh1730_get_millilux(bh1730);
> > +               if (ret < 0)
> > +                       return ret;
> > +               *val = ret / 1000;
> > +               *val2 = (ret % 1000) * 1000;
> > +               return IIO_VAL_INT_PLUS_MICRO;
> > +       case IIO_CHAN_INFO_RAW:
> > +               switch (chan->channel2) {
> > +               case IIO_MOD_LIGHT_CLEAR:
> > +                       data_reg = BH1730_REG_DATA0LOW;
> > +                       break;
> > +               case IIO_MOD_LIGHT_IR:
> > +                       data_reg = BH1730_REG_DATA1LOW;
> > +                       break;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +               ret = bh1730_read_word(bh1730, data_reg);
> > +               if (ret < 0)
> > +                       return ret;
> > +               ret = ret * 1000 / bh1730_gain_multiplier(bh1730);  
> 
> > +               *val = ret / 1000;
> > +               *val2 = (ret % 1000) * 1000;
> > +               return IIO_VAL_INT_PLUS_MICRO;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info bh1730_info = {
> > +       .read_raw = bh1730_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec bh1730_channels[] = {
> > +       {
> > +               .type = IIO_LIGHT,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +       },
> > +       {
> > +               .type = IIO_INTENSITY,
> > +               .modified = 1,
> > +               .channel2 = IIO_MOD_LIGHT_CLEAR,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +       },
> > +       {
> > +               .type = IIO_INTENSITY,
> > +               .modified = 1,
> > +               .channel2 = IIO_MOD_LIGHT_IR,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +       },
> > +};
> > +
> > +static int bh1730_probe(struct i2c_client *client)
> > +{
> > +       struct bh1730_data *bh1730;
> > +       struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> > +       struct iio_dev *indio_dev;
> > +       int ret;
> > +
> > +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> > +               return -EIO;
> > +
> > +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1730));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       bh1730 = iio_priv(indio_dev);
> > +       bh1730->client = client;
> > +       i2c_set_clientdata(client, indio_dev);
> > +
> > +       ret = bh1730_power_on(bh1730);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = bh1730_set_defaults(bh1730);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       indio_dev->dev.parent = &client->dev;
> > +       indio_dev->info = &bh1730_info;
> > +       indio_dev->name = "bh1730";
> > +       indio_dev->channels = bh1730_channels;
> > +       indio_dev->num_channels = ARRAY_SIZE(bh1730_channels);
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +       ret = iio_device_register(indio_dev);
> > +       if (ret)
> > +               goto out_power_off;
> > +       return 0;
> > +
> > +out_power_off:
> > +       bh1730_power_off(bh1730);
> > +       return ret;
> > +}
> > +
> > +static int bh1730_remove(struct i2c_client *client)
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +       struct bh1730_data *bh1730 = iio_priv(indio_dev);
> > +
> > +       iio_device_unregister(indio_dev);
> > +       return bh1730_power_off(bh1730);
> > +}
> > +
> > +static const struct of_device_id of_bh1730_match[] = {
> > +       { .compatible = "rohm,bh1730fvc" },  
> 
> > +       {},  
> 
> No need to have a comma.
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, of_bh1730_match);
> > +
> > +static struct i2c_driver bh1730_driver = {
> > +       .probe_new = bh1730_probe,
> > +       .remove = bh1730_remove,
> > +       .driver = {
> > +               .name = "bh1730",
> > +               .of_match_table = of_bh1730_match,
> > +       },
> > +};
> > +module_i2c_driver(bh1730_driver);
> > +
> > +MODULE_AUTHOR("Pierre Bourdon <delroth@google.com>");
> > +MODULE_DESCRIPTION("ROHM BH1730FVC driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.16.2.395.g2e18187dfd-goog
> >  
> 
> 
> 
