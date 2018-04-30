Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeD3TJQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:09:16 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:42059 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeD3TJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:09:13 -0400
X-Google-Smtp-Source: AB8JxZqfZqX6p6mlNVWeyNRTCbsjpvxnaCLKS08VXJ3IBFsuxjjryoRaTvghfSDhU1YyeDL6+oAlCGlCfQ0RGttYMxo=
MIME-Version: 1.0
In-Reply-To: <20180430093907.GA2476@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-4-git-send-email-wesley@sifive.com> <20180430093907.GA2476@ulmo>
From: Wesley Terpstra <wesley@sifive.com>
Date: Mon, 30 Apr 2018 12:09:11 -0700
Message-ID: <CAMgXwThkz5Ah6tWds9rY7BPOP2xM8qh9MgDc85RbTUnMFgEDew@mail.gmail.com>
Subject: Re: [PATCH 3/3] pwm-sifive: add a driver for SiFive SoC PWM
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wesley W . Terpstra" <wesley@terpstra.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thank you very much for this detailed review! I really
appreciate it, as this is just the first driver of several we would
like to upstream and getting the reviews front-loaded like this will
really help us improve the subsequent drivers before trying to
upstream them.

On Mon, Apr 30, 2018 at 2:39 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Please include a SPDX license identifier here. That's the preferred way
> to specify the license these days.

Done

>> +#include <dt-bindings/pwm/pwm.h>
> There should be no need to include this in a driver.

Done

>> +             if (state->polarity == PWM_POLARITY_NORMAL)
>> +                     state->duty_cycle = state->period - state->duty_cycle;
>
> That's not the right way to handle polarity. The above often has the
> same effect as inversed polarity, but it's not generally the right thing
> to do. Please only support polarity if your hardware can actually really
> reverse it. The above is something that PWM consumers (such as the
> backlight driver) should take care of.

I don't know how to declare non-support for polarity. How do I do that?

I still want DTS references to state whether or not the polarity
should be reversed, because the PWM might be connected with either
positive or negative logic to an LED, for example.

>> +     state->polarity   = PWM_POLARITY_INVERSED;
> Is the polarity really reversed by default on this IP?

Yes. In the sense that the PWM is low while the counter is less than
the duty-cycle, and high when >= the duty-cycle.

Note that this also means it's possible to achieve a constant high
value, but impossible to achieve a constant low value, other than
approximate.

> I don't think this is a good idea. Nobody should be allowed to just
> change the PWM period without letting the PWM controller have a say in
> the matter.

I agree and I intend to fight hard to make sure that future chips don't do this.

> Is this ever really an issue?

Unfortunately, yes. This chip has only one PLL output that controls
almost everything. The core runs at the PLL's output. The bus runs at
half the PLL's output. Each peripheral clock is a divided down version
of the bus clock.

> Does the PWM controller use a shared clock that changes rate frequently?

When you want to change the CPU frequency, you have to update all the
peripheral device clock dividers. It sucks, but that's what has to
happen if the core clock is changed. Fortunately, this is not done
dynamically, but might be done during boot.

For PWM, this is not a big issue, because the period mostly does not
matter as it's broken already. However, for an active SPI transfer,
this can be problematic.

>> +     ret = of_property_read_u32(node, "sifive,npwm", &chip->npwm);
>> +     if (ret < 0 || chip->npwm > MAX_PWM)
>> +             chip->npwm = MAX_PWM;
>
> I don't see this documented in the DT bindings. I also don't see a need
> for it. Under what circumstances would you want to change this?

The PWM controller can have less than 4 channels. I could try to probe
how many there are by poking registers, but that seems risky if the
PWM is attached to something.

Shall I just add this to the dt-bindings?

>> +     pwm->irq = platform_get_irq(pdev, 0);
>> +     if (pwm->irq < 0) {
>> +             dev_err(dev, "Unable to find interrupt\n");
>> +             return pwm->irq;
>> +     }
>
> You don't do anything with this, why bother retrieving it?

Mostly to ensure that it is included in the DTS so that I can rely on
it being there in any future driver updates.

>> +     dev_info(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> Please don't do this.

Removed.
