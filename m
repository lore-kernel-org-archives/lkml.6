Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEPRoH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:44:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40458 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeEPRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:44:01 -0400
X-Google-Smtp-Source: AB8JxZqzArtbHkmo0H/czteOg+4RByfclewegKIU5KCFi8B8PcyMVGpGBysawa7F7Og1C5biEremLw==
Date: Wed, 16 May 2018 10:43:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH v3] Input: add bu21029 touch driver
Message-ID: <20180516174357.GE21971@dtor-ws>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
 <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
 <e514418e94bc4e0492512f7ba24170af@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e514418e94bc4e0492512f7ba24170af@de.bosch.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:24:24PM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> Hello Andy,
> 
> > > Add Rohm BU21029 resistive touch panel controller support with I2C
> > > interface.
> > 
> > > +#include <linux/of.h>
> > 
> > This becomes redundant (see below).
> 
> Removed.
> 
> > > +#define STOP_DELAY_US  50L
> > > +#define START_DELAY_MS 2L
> > > +#define BUF_LEN        8L
> > 
> > No need to use L for such small numbers. Integer promotion is a part
> > of C standard.
> 
> OK.
> 
> > > +#define SCALE_12BIT    (1 << 12)
> > > +#define MAX_12BIT      ((1 << 12) - 1)
> > 
> > BIT(12)
> > GENMASK(11, 0)
> 
> We are not convinced that we should use BIT() and GENMASK() here.
> 
> The reason is that SCALE_12BIT is actually not used as a bit but as an
> input value for DIV_ROUND_CLOSEST. We think that the BIT() macro will
> hide the meaning of the value.
> 
> MAX_12BIT is also a value and not a bit mask. Thus, we also think that
> using the GENMASK() macro will hide its purpose. Also, the
> documentation of GENMASK() says that it is a mask and not a value.

I agree.

> 
> > > +static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
> > > +{
> > > +       struct i2c_client *i2c = bu21029->client;
> > > +       u8 buf[BUF_LEN];
> > > +       int error = bu21029_touch_report(bu21029);
> > 
> > > +
> > 
> > Redundant empty line.
> 
> Removed.
> 
> > > +       if (error) {
> > 
> > > +               dev_err(&i2c->dev, "failed to report (error: %d)\n", error);
> > 
> > Potential spamming case.
> > 
> > > +               return IRQ_NONE;
> > > +       }
> 
> You are right, we will remove the error message.
> 
> > > +static void bu21029_stop_chip(struct input_dev *dev)
> > > +{
> > > +       struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
> > > +
> > > +       disable_irq(bu21029->client->irq);
> > > +       del_timer_sync(&bu21029->timer);
> > > +
> > > +       /* put chip into reset */
> > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
> > 
> > > +       udelay(STOP_DELAY_US);
> > 
> > udelay() ?!
> > 
> > > +}
> 
> According to the datasheet disabling the chip will take 30 microseconds.
> In the defines we added a buffer of 20 microseconds and thus
> STOP_DELAY_US is 50. The function guarantees that the chip is stopped
> before it returns.
> 
> We think that it is ok to use udelay() here because in normal operation
> the chip is not stopped. It is only stopped when loading or unloading
> the driver, or when the system suspends.
> 
> We would like to keep it like it is.

The issue is not with having delay here, but the kind of delay you are
using: udelay makes CPU spin for given amount of time; you really want
msleep() or usleep_range() here.

> 
> > > +static int bu21029_start_chip(struct input_dev *dev)
> > > +{
> > 
> > > +       u16 hwid;
> > > +
> > > +       /* take chip out of reset */
> > > +       gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
> > 
> > > +       mdelay(START_DELAY_MS);
> > 
> > mdelay()?!

Same here - replace with msleep().

> > 
> > > +
> > > +       error = i2c_smbus_read_i2c_block_data(i2c,
> > > +                                             BU21029_HWID_REG,
> > > +                                             2,
> > > +                                             (u8 *)&hwid);
> > > +       if (error < 0) {
> > > +               dev_err(&i2c->dev, "failed to read HW ID\n");
> > > +               goto out;
> > > +       }
> 
> After de-asserting the reset chip takes 1 millisecond until it is
> operational. We added a 1 millisecond buffer to it. Thus,
> START_DELAY_MS is 2.
> 
> The following I2C read will not succeed without waiting for the chip
> being ready.
> 
> > > +       if (cpu_to_be16(hwid) != SUPPORTED_HWID) {
> > 
> > Hmm... Why cpu_to_be16() is required?
> > 
> > > +               dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
> > > +               error = -ENODEV;
> > > +               goto out;
> > > +       }
> > > +}
> 
> You are right, it works but what we meant to do here is to convert the
> chip's value (big endian) into the CPU endianness. We will change it to
> be16_to_cpu().
> 
> > > +static int bu21029_parse_dt(struct bu21029_ts_data *bu21029)
> > 
> > You can get rid of DT requirement by...
> > 
> > > +{
> > > +       struct device *dev = &bu21029->client->dev;
> > > +       struct device_node *np = dev->of_node;
> > > +       u32 val32;
> > > +       int error;
> > 
> > > +       if (!np) {
> > > +               dev_err(dev, "no device tree data\n");
> > > +               return -EINVAL;
> > > +       }
> > 
> > (this becomes redundant)
> > 
> > > +
> > > +       bu21029->reset_gpios = devm_gpiod_get(dev, "reset",
> > GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(bu21029->reset_gpios)) {
> > > +               error = PTR_ERR(bu21029->reset_gpios);
> > > +               if (error != -EPROBE_DEFER)
> > > +                       dev_err(dev, "invalid 'reset-gpios':%d\n", error);
> > > +               return error;
> > > +       }
> > > +
> > 
> > > +       if (of_property_read_u32(np, "rohm,x-plate-ohms", &val32)) {
> > 
> > ...simple calling device_property_read_u32() instead.
> > 
> > > +               dev_err(dev, "invalid 'x-plate-ohms' supplied\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       bu21029->x_plate_ohms = val32;
> > > +
> > > +       touchscreen_parse_properties(bu21029->in_dev, false, &bu21029->prop);
> > > +
> > > +       return 0;
> > > +}
> 
> Thank you, changed.
> 
> > > +#ifdef CONFIG_PM_SLEEP
> > 
> > Instead...
> > 
> > > +static int bu21029_suspend(struct device *dev)
> > 
> > ...use __maby_unused annotation.
> > 
> > > +static int bu21029_resume(struct device *dev)
> > 
> > Ditto.
> 
> OK, added.

You also need to drop #ifdef CONFIG_SLEEP. That's the point: we want to
reduce amount of conditionally compiled code and use __maybe_unused to
shut off compiler warning about some functions not used in certain
configurations. We rely on linker to eliminate dead functions from
executable.

Thanks.

-- 
Dmitry
