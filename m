Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeBVO6Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:58:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50634 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeBVO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:58:13 -0500
X-Google-Smtp-Source: AH8x226zzfMKp3zP8ciZ4Ovnl7BhaenXyok/WMH6E1w9HYgoTozQpPNkFjmwB7fdZRFFLR3mK/XwrvksO2MUT8LdFcA=
MIME-Version: 1.0
In-Reply-To: <CAHp75VfXmzgQp1sDqYnsSNVxSmW-D4BhFdQK4tGmUg9oXZcnXg@mail.gmail.com>
References: <20180221125512.8265-1-delroth@google.com> <20180221194526.49183-1-delroth@google.com>
 <CAHp75VfXmzgQp1sDqYnsSNVxSmW-D4BhFdQK4tGmUg9oXZcnXg@mail.gmail.com>
From: "Pierre Bourdon (delroth)" <delroth@google.com>
Date: Thu, 22 Feb 2018 15:58:10 +0100
Message-ID: <CANEr7oVJosS5+XKqf+PBuwXG30cEqQFv_kvrgRdC=C+EvN67rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: add driver for bh1730fvc chips
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

Thanks for the review! Answers inline. I'll send a v3 when the two
open questions are resolved.

On Wed, Feb 21, 2018 at 10:57 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 21, 2018 at 9:45 PM, Pierre Bourdon <delroth@google.com> wrote:
>> Ambient light sensor that supports visible light and IR measurements and
>> configurable gain/integration time.
>>
>> Changed in v2:
>> * Split off DT documentation change into a separate commit.
>> * Use i2c's probe_new.
>
> Btw, how big the difference with existing drivers?

See https://lkml.org/lkml/2018/2/21/982 . In retrospect, I should have
added this to the commit message. It will be there in v3.

>> +       highest = max(visible, ir);
>> +
>> +       /*
>> +        * If the read value is being clamped, assume the worst and go to the
>> +        * lowest possible gain. The alternative is doing multiple
>> +        * recalibrations, which would be slower and have the same effect.
>> +        */
>> +       if (highest == USHRT_MAX)
>> +               highest *= 128;
>> +       else
>> +               highest = (highest * 128) / bh1730_gain_multiplier(bh1730);
>
> In both cases you multiply.
> Why not just
>
>      highest = max(visible, ir) * 128;
>
> if (highest < USHRT_MAX)
> ...
> ?

You'd need < USHRT_MAX * 128 then. I refactored this a bit but
differently. WDYT?

        if (highest == USHRT_MAX)
                gain = 1;
        else
                gain = bh1730_gain_multiplier(bh1730);

        highest = (highest * BH1730_MAX_GAIN_MULTIPLIER) / gain;

>> +       millilux = (u64)USEC_PER_MSEC * (visible_coef * visible - ir_coef * ir);
>
> I'm not sure I understand how time units is related to lux one.

Now looks like this, which should match the units together better
while keeping most multiplications before divisions (for accuracy).
Not much better I can do here I think, for example the magic "103" is
straight from the datasheet with no explanation.

        millilux = visible_coef * visible - ir_coef * ir;
        millilux = (millilux * USEC_PER_MSEC) / itime_us;
        millilux *= 103;
        millilux /= bh1730_gain_multiplier(bh1730);

>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1730));
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>
>> +       indio_dev->dev.parent = &client->dev;
>
> Strange, it's not done in IIO core... Jonathan, is it true that in
> case of devm_iio_device_alloc() all drivers use supplied struct device
> as a parent one?
> If so, doesn't make sense to modify IIO core to do this?

It doesn't seem like IIO core is doing it at this point. Should we
just leave that as-is for now and get everything fixed in a future
patch?

>> +static int bh1730_remove(struct i2c_client *client)
>> +{
>> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +       struct bh1730_data *bh1730 = iio_priv(indio_dev);
>> +
>
>> +       iio_device_unregister(indio_dev);
>
> Hmm... Do you still need this even with devm IIO in ->probe()?

I *think* so, but that's mostly because all the other IIO light
drivers that I've looked at are doing it. Can someone who knows the
IIO subsystem well weigh in?

Thanks!
Best,

-- 
Pierre Bourdon (delroth@)
