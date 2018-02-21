Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBUV55 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:57:57 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35877 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:57:55 -0500
X-Google-Smtp-Source: AH8x226mgGy/0JCkLjJ+ZGbdhaoN5FFgN/V68kYsNjJSMvw6bQT0U2TYXGtNhtYuOay/hdYqtyBxfVTgTVPFnwLEC1w=
MIME-Version: 1.0
In-Reply-To: <20180221194526.49183-1-delroth@google.com>
References: <20180221125512.8265-1-delroth@google.com> <20180221194526.49183-1-delroth@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 23:57:53 +0200
Message-ID: <CAHp75VfXmzgQp1sDqYnsSNVxSmW-D4BhFdQK4tGmUg9oXZcnXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: add driver for bh1730fvc chips
To: Pierre Bourdon <delroth@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:45 PM, Pierre Bourdon <delroth@google.com> wrote:
> Ambient light sensor that supports visible light and IR measurements and
> configurable gain/integration time.
>
> Changed in v2:
> * Split off DT documentation change into a separate commit.
> * Use i2c's probe_new.

Btw, how big the difference with existing drivers?

> +       default:
> +               return -1;

Better to

return -EINVAL;

> +       highest = max(visible, ir);
> +
> +       /*
> +        * If the read value is being clamped, assume the worst and go to the
> +        * lowest possible gain. The alternative is doing multiple
> +        * recalibrations, which would be slower and have the same effect.
> +        */
> +       if (highest == USHRT_MAX)
> +               highest *= 128;
> +       else
> +               highest = (highest * 128) / bh1730_gain_multiplier(bh1730);

In both cases you multiply.
Why not just

     highest = max(visible, ir) * 128;

if (highest < USHRT_MAX)
...
?

> +       millilux = (u64)USEC_PER_MSEC * (visible_coef * visible - ir_coef * ir);

I'm not sure I understand how time units is related to lux one.

> +       millilux /= bh1730_gain_multiplier(bh1730);
> +       millilux *= 103;
> +       millilux /= itime_us;
> +       return millilux;
> +}

> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1730));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +

> +       indio_dev->dev.parent = &client->dev;

Strange, it's not done in IIO core... Jonathan, is it true that in
case of devm_iio_device_alloc() all drivers use supplied struct device
as a parent one?
If so, doesn't make sense to modify IIO core to do this?

> +static int bh1730_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +

> +       iio_device_unregister(indio_dev);

Hmm... Do you still need this even with devm IIO in ->probe()?


> +#ifdef CONFIG_OF
> +#endif

This...

> +               .of_match_table = of_match_ptr(of_bh1730_match),

...and of_match_ptr() now pointless.

-- 
With Best Regards,
Andy Shevchenko
