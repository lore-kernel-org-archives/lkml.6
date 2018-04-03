Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDCR3u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:29:50 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36446 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:29:46 -0400
X-Google-Smtp-Source: AIpwx4/3C0mXO0HxijyOSKuL8wIT47K9OilaJPp8Y4bOSqNdLYg0dtpDm/vQVgUNz8XP4qVApZXqiQEHKn4sWx9AYO0=
MIME-Version: 1.0
In-Reply-To: <20180403164715.GA5676@lunn.ch>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-3-git-send-email-tharvey@gateworks.com> <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
 <20180403164715.GA5676@lunn.ch>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 3 Apr 2018 10:29:44 -0700
Message-ID: <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 9:47 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Apr 03, 2018 at 08:48:27AM -0700, Tim Harvey wrote:
>> On Wed, Mar 28, 2018 at 8:14 AM, Tim Harvey <tharvey@gateworks.com> wrote:
>> > The Gateworks System Controller (GSC) is an I2C slave controller
>> > implemented with an MSP430 micro-controller whose firmware embeds the
>> > following features:
>> >  - I/O expander (16 GPIO's) using PCA955x protocol
>> >  - Real Time Clock using DS1672 protocol
>> >  - User EEPROM using AT24 protocol
>> >  - HWMON using custom protocol
>> >  - Interrupt controller with tamper detect, user pushbotton
>> >  - Watchdog controller capable of full board power-cycle
>> >  - Power Control capable of full board power-cycle
>> >
>> > see http://trac.gateworks.com/wiki/gsc for more details
>> >
>> <snip>
>> > +
>> > +/*
>> > + * gsc_powerdown - API to use GSC to power down board for a specific time
>> > + *
>> > + * secs - number of seconds to remain powered off
>> > + */
>> > +static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
>> > +{
>> > +       int ret;
>> > +       unsigned char regs[4];
>> > +
>> > +       dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
>> > +                secs);
>> > +       regs[0] = secs & 0xff;
>> > +       regs[1] = (secs >> 8) & 0xff;
>> > +       regs[2] = (secs >> 16) & 0xff;
>> > +       regs[3] = (secs >> 24) & 0xff;
>> > +       ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
>> > +
>> > +       return ret;
>> > +}
>>
>> Any feedback on the 'powerdown' sysfs attribute that hooks to this
>> function? This allows the GSC to disable the board primary power
>> supply for 2^32 seconds and is often used to 'reset' the board
>> although it could also be used to put the board in a power down state
>> longer. I'm wondering if there is a more appropriate API for this in
>> the kernel that I don't know about.
>
> Hi Tim
>
> RTC can cause wakeup when an alarm is set. It looks like the DS1672
> does not have this. But you are emulating the DS1672 right? You could
> add a second emulated RTC which does support an alarm? DS3232?

Andrew,

Thanks for the response!

An RTC alarm may indeed be a good route for the overall sleep
functionality I will look into that.

What about the 'reset' functionality? Is there something in the power
supply API for hooking in a GPIO based power switch (in my case it
would be i2c) as I would think that would be common for ATX supplies?
I didn't see anything in Documentation/power.

This is what led me to the restart handler idea. Ultimately when
someone issues a 'reboot' I would like it to use the GSC to
power-cycle the board.

>
>> I would also like to register a restart handler using this but I
>> believe that ARM restart handlers currently can not use I2C - is that
>> correct?
>
> There are plenty which use GPIOs, or UARTs. Not seen any which use
> i2c. What do you think does not work at this point?

I'll have to dig around for the e-mail thread. I recall someone else
trying to implement a restart handler for something hanging off i2c
and the issue was that by the time the (ARM) restart handler got
called interrupts were disabled making i2c unreliable. I have hooked
the ARM restart handler to my GSC powerdown in some kernels and have
had mixed results. When the handler gets called from a clean 'reboot'
things seem fine but if its called from some error condition that
halts the kernel it seems that i2c may not be reliable anymore.

Regards,

Tim
