Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeDBQH1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:07:27 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39059 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeDBQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:07:23 -0400
X-Google-Smtp-Source: AIpwx48NM03mZ5Xhe0TBKS0EzCA78tuS0G+wUcaFk1wYkbWjNHxN4/DCzyb/5rm7EGUG/kLJmAAYzdQyGzpP/p+5y54=
MIME-Version: 1.0
In-Reply-To: <20180330181954.GA17580@roeck-us.net>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net> <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
 <20180330181954.GA17580@roeck-us.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 2 Apr 2018 09:07:19 -0700
Message-ID: <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 11:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Mar 30, 2018 at 10:49:38AM -0700, Tim Harvey wrote:
>> On Thu, Mar 29, 2018 at 6:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Wed, Mar 28, 2018 at 08:14:03AM -0700, Tim Harvey wrote:
>> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> >> ---
>> >>  drivers/watchdog/Kconfig   |  10 ++++
>> >>  drivers/watchdog/Makefile  |   1 +
>> >>  drivers/watchdog/gsc_wdt.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 157 insertions(+)
>> >>  create mode 100644 drivers/watchdog/gsc_wdt.c
>> >>
>> <snip>
>> >> +
>> >> +static const struct watchdog_info gsc_wdt_info = {
>> >> +     .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>> >
>> > Please confirm that WDIOF_MAGICCLOSE is not set on purpose.
>> >
>> >> +     .identity = "GSC Watchdog"
>> >> +};
>> >> +
>> <snip>
>> >> +
>> >> +static int gsc_wdt_probe(struct platform_device *pdev)
>> >> +{
>> >> +     struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
>> >> +     struct device *dev = &pdev->dev;
>> >> +     struct gsc_wdt *wdt;
>> >> +     int ret;
>> >> +     unsigned int reg;
>> >> +
>> <snip>
>> >> +     /* ensure WD bit enabled */
>> >> +     if (regmap_read(gsc->regmap, GSC_CTRL_1, &reg))
>> >> +             return -EIO;
>> >> +     if (!(reg & (1 << GSC_CTRL_1_WDT_ENABLE))) {
>> >
>> > BIT()
>> >
>> >> +             dev_err(dev, "not enabled - must be manually enabled\n");
>> >
>> > This doesn't make sense. Bail out if the watchdog is disabled ? Why ?
>> >
>> >> +             return -EINVAL;
>> >> +     }
>> >> +
>> <snip>
>> >> +
>> >> +     watchdog_set_nowayout(&wdt->wdt_dev, 1);
>> >
>> > WATCHDOG_NOWAYOUT ?
>> >
>>
>> Guenter,
>>
>> Thanks for the review!
>>
>> The watchdog implementation of the GSC is such that it is enabled and
>> reset via a single non-volatile I2C register bit. If this bit is set
>> the watchdog will start ticking down automatically on board power up.
>> The register definitions don't provide a condition where it can be
>> enabled in a volatile way such that after board power-cycle it is
>> disabled again nor do they provide a separate register for enable vs
>> reset.
>>
>> In the typical case the user boots the board, driver registers
>> watchdog, userspace watchdog daemon enables watchdog and it starts
>> ticking. User now powers down the board and later powers it back up.
>> The watchdog was enabled previously by userspace and the register is
>> non-volatile so the watchdog starts ticking before the kernel driver
>> and watchdog daemon yet the user breaks out into the bootloader or
>> boots a different OS without a watchdog daemon and the board resets
>> without them expecting it. The feature that the watchdog starts
>> ticking at board power-up before the CPU has even fetched code was
>> part of its design and was put there to work around some SoC errata
>> that can cause the CPU to fail to fetch boot code. This has caused me
>> to implement a watchdog driver that never actually 'enables' or
>> 'disables' the watchdog which is why there is no MAGIC CLOSE and why I
>
> Yet the driver does enable and disable the watchdog in its start and stop
> functions. And I have no idea what that has to do with the MAGICCLOSE
> functionality, which is quite orthogonal to the start/stop functionality.
>
>> always set nowayout. Its possible this is a fairly unique case of a
>> watchdog. The probe failure if the watchdog isn't enabled is because I
>> don't want a non-enabled watchdog to get enabled just because the
>> driver/daemon were there.
>>
> Huh ? The whole purpose of a watchdog is for it to be enabled when
> the watchdog device is opened.
>
>> I agree it's a very strange behavior and I'm not sure how to best
>> document or support it with the Linux watchdog API. I welcome any
>> recomendations!
>>
>
> Sorry, I fail to understand your logic.
>
> You do not explain why your code bails out if the watchdog is not already
> running. That does not make sense.
>
> You are saying that you don't want the watchdog driver to enable the watchdog.
> Since its whole purpose is to enable the watchdog if/when the watchdog device
> is opened, that doesn't make sense either.
>
> At the same time, you do not tell the watchdog core that the watchdog is
> already running, meaning the system _will_ reboot unless the watchdog
> device is opened within the watchdog timeout period. Again, that does not
> make sense.
>
> Maybe it all makes sense to you, but not to me, sorry.

Guenter,

Right, I'm likely not explaining it well. Let me show the registers
and describe the feature from the GSC perspective:

I2C registers: non-volatile registers (battery backed)
0x01: GSC_CTRL_1: Sleep Wakeup Timer Control
 bit 4: WATCHDOG_TIME: 0=30 second timeout, 1=60 second timeout
 bit 5: WATCHDOG_ENABLE: 0=disable watchdog, 1=enable/reset watchdog timer

The GSC has the ability to enable/disable the primary board power
supply. In the event that the watchdog timer is enabled and reaches 0
it will power cycle the board by disabling the primary power supply
for 1 second then enabling it again. The GSC_CTRL_1 bits retain their
state during power cycles thus if WATCHDOG_ENABLE=1 and the board
power cycles the watchdog starts counting down immediately and host
software must either disable it or start resetting it before the
timeout period.

The 'use case' we have been using this in for a couple years is that
users who want to use this watchdog will enable it externally (we have
a command in the bootloader) and if enabled the kernel driver (that
I'm proposing here which we've been using out-of-tree) will register
the watchdog device and the userspace watchdog process can open the
device and start tickling it. If the watchdog is never enabled (or
disabled via the bootloader command) the kernel driver fails to probe
and the SoC's watchdog can be used. The reason this feature was added
to the GSC is that we had some errata with one of the SoC's we use
such that it's internal reset was not resetting enough of the chip and
in some cases we also wanted an external PMIC to be reset as well
which is accomplished by cycling the primary power supply.

What I'm proposing here is a watchdog driver that only has the ability
to 'reset' the watchdog timer 'if enabled'. Because the same register
is used to enable as well as reset the timer I don't want to
enable/reset it if it isn't already enabled.

Because start/stop are mandatory I suppose I could make stop a nop and
make start only set WATCHDOG_TIME if it's already set. I was thinking
that I would simply have the driver probe fail if the watchdog wasn't
externally already enabled and let /dev/watchdog0 be the sometimes
lesser valued SoC watchdog.

Regards,

Tim
