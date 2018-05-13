Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeEMO4r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:56:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33205 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:56:44 -0400
X-Google-Smtp-Source: AB8JxZp/3x2/4d0N02SOjSeP9RCM2xtWOkHUh8JovVl1Z7EdLSgLvjqUwwgf85Hwbj/VTCusT9vgVk3KAxs44mQ3yMg=
MIME-Version: 1.0
In-Reply-To: <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com> <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 17:56:43 +0300
Message-ID: <CAHp75Vf=eJbJPv5=y3fDKZapAnmABD0=v+WRhrBhMv+RSoBnKg@mail.gmail.com>
Subject: Re: [PATCH v3] Input: add bu21029 touch driver
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>, Zhu Yi <yi.zhu5@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 5:22 PM, Mark Jonas <mark.jonas@de.bosch.com> wrote:

> Add Rohm BU21029 resistive touch panel controller support with I2C
> interface.

> +#include <linux/of.h>

This becomes redundant (see below).

> +#define STOP_DELAY_US  50L
> +#define START_DELAY_MS 2L
> +#define BUF_LEN        8L

No need to use L for such small numbers. Integer promotion is a part
of C standard.

> +#define SCALE_12BIT    (1 << 12)
> +#define MAX_12BIT      ((1 << 12) - 1)

BIT(12)
GENMASK(11, 0)

> +static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
> +{
> +       struct i2c_client *i2c = bu21029->client;
> +       u8 buf[BUF_LEN];
> +       int error = bu21029_touch_report(bu21029);

> +

Redundant empty line.

> +       if (error) {

> +               dev_err(&i2c->dev, "failed to report (error: %d)\n", error);

Potential spamming case.

> +               return IRQ_NONE;
> +       }

> +static void bu21029_stop_chip(struct input_dev *dev)
> +{
> +       struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
> +
> +       disable_irq(bu21029->client->irq);
> +       del_timer_sync(&bu21029->timer);
> +
> +       /* put chip into reset */
> +       gpiod_set_value_cansleep(bu21029->reset_gpios, 1);

> +       udelay(STOP_DELAY_US);

udelay() ?!

> +}
> +

> +static int bu21029_start_chip(struct input_dev *dev)
> +{

> +       u16 hwid;
> +
> +       /* take chip out of reset */
> +       gpiod_set_value_cansleep(bu21029->reset_gpios, 0);

> +       mdelay(START_DELAY_MS);

mdelay()?!

> +
> +       error = i2c_smbus_read_i2c_block_data(i2c,
> +                                             BU21029_HWID_REG,
> +                                             2,
> +                                             (u8 *)&hwid);
> +       if (error < 0) {
> +               dev_err(&i2c->dev, "failed to read HW ID\n");
> +               goto out;
> +       }
> +

> +       if (cpu_to_be16(hwid) != SUPPORTED_HWID) {

Hmm... Why cpu_to_be16() is required?

> +               dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
> +               error = -ENODEV;
> +               goto out;
> +       }
> +}

> +static int bu21029_parse_dt(struct bu21029_ts_data *bu21029)

You can get rid of DT requirement by...

> +{
> +       struct device *dev = &bu21029->client->dev;
> +       struct device_node *np = dev->of_node;
> +       u32 val32;
> +       int error;

> +       if (!np) {
> +               dev_err(dev, "no device tree data\n");
> +               return -EINVAL;
> +       }

(this becomes redundant)

> +
> +       bu21029->reset_gpios = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(bu21029->reset_gpios)) {
> +               error = PTR_ERR(bu21029->reset_gpios);
> +               if (error != -EPROBE_DEFER)
> +                       dev_err(dev, "invalid 'reset-gpios':%d\n", error);
> +               return error;
> +       }
> +

> +       if (of_property_read_u32(np, "rohm,x-plate-ohms", &val32)) {

...simple calling device_property_read_u32() instead.

> +               dev_err(dev, "invalid 'x-plate-ohms' supplied\n");
> +               return -EINVAL;
> +       }
> +       bu21029->x_plate_ohms = val32;
> +
> +       touchscreen_parse_properties(bu21029->in_dev, false, &bu21029->prop);
> +
> +       return 0;
> +}

> +#ifdef CONFIG_PM_SLEEP

Instead...

> +static int bu21029_suspend(struct device *dev)

...use __maby_unused annotation.

> +static int bu21029_resume(struct device *dev)

Ditto.

-- 
With Best Regards,
Andy Shevchenko
