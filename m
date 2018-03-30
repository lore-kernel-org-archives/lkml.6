Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeC3Rtn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:49:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55556 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeC3Rtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:49:40 -0400
X-Google-Smtp-Source: AIpwx4/LUCsKB2o8Xm2bFSeTX5N0fXozY9Oog6sKoWJdo7eJvJ7Yfq3y3zlMon2Ldb9cX8Psgz4KUWg3q3Q5LO7wqhk=
MIME-Version: 1.0
In-Reply-To: <20180330010757.GA12896@roeck-us.net>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com> <20180330010757.GA12896@roeck-us.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 Mar 2018 10:49:38 -0700
Message-ID: <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
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

On Thu, Mar 29, 2018 at 6:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Mar 28, 2018 at 08:14:03AM -0700, Tim Harvey wrote:
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  drivers/watchdog/Kconfig   |  10 ++++
>>  drivers/watchdog/Makefile  |   1 +
>>  drivers/watchdog/gsc_wdt.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 157 insertions(+)
>>  create mode 100644 drivers/watchdog/gsc_wdt.c
>>
<snip>
>> +
>> +static const struct watchdog_info gsc_wdt_info = {
>> +     .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>
> Please confirm that WDIOF_MAGICCLOSE is not set on purpose.
>
>> +     .identity = "GSC Watchdog"
>> +};
>> +
<snip>
>> +
>> +static int gsc_wdt_probe(struct platform_device *pdev)
>> +{
>> +     struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
>> +     struct device *dev = &pdev->dev;
>> +     struct gsc_wdt *wdt;
>> +     int ret;
>> +     unsigned int reg;
>> +
<snip>
>> +     /* ensure WD bit enabled */
>> +     if (regmap_read(gsc->regmap, GSC_CTRL_1, &reg))
>> +             return -EIO;
>> +     if (!(reg & (1 << GSC_CTRL_1_WDT_ENABLE))) {
>
> BIT()
>
>> +             dev_err(dev, "not enabled - must be manually enabled\n");
>
> This doesn't make sense. Bail out if the watchdog is disabled ? Why ?
>
>> +             return -EINVAL;
>> +     }
>> +
<snip>
>> +
>> +     watchdog_set_nowayout(&wdt->wdt_dev, 1);
>
> WATCHDOG_NOWAYOUT ?
>

Guenter,

Thanks for the review!

The watchdog implementation of the GSC is such that it is enabled and
reset via a single non-volatile I2C register bit. If this bit is set
the watchdog will start ticking down automatically on board power up.
The register definitions don't provide a condition where it can be
enabled in a volatile way such that after board power-cycle it is
disabled again nor do they provide a separate register for enable vs
reset.

In the typical case the user boots the board, driver registers
watchdog, userspace watchdog daemon enables watchdog and it starts
ticking. User now powers down the board and later powers it back up.
The watchdog was enabled previously by userspace and the register is
non-volatile so the watchdog starts ticking before the kernel driver
and watchdog daemon yet the user breaks out into the bootloader or
boots a different OS without a watchdog daemon and the board resets
without them expecting it. The feature that the watchdog starts
ticking at board power-up before the CPU has even fetched code was
part of its design and was put there to work around some SoC errata
that can cause the CPU to fail to fetch boot code. This has caused me
to implement a watchdog driver that never actually 'enables' or
'disables' the watchdog which is why there is no MAGIC CLOSE and why I
always set nowayout. Its possible this is a fairly unique case of a
watchdog. The probe failure if the watchdog isn't enabled is because I
don't want a non-enabled watchdog to get enabled just because the
driver/daemon were there.

I agree it's a very strange behavior and I'm not sure how to best
document or support it with the Linux watchdog API. I welcome any
recomendations!

Regards,

Tim
