Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeC3SUB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:20:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33675 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbeC3ST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:19:58 -0400
X-Google-Smtp-Source: AIpwx4/ehDG62vJLEiLXqCozn5TtiQcx1qW8yLdQCNB+XKp2u+cGRDhuXOda4Dg9qipy1pYvTZHreQ==
Date: Fri, 30 Mar 2018 11:19:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
Message-ID: <20180330181954.GA17580@roeck-us.net>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net>
 <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 10:49:38AM -0700, Tim Harvey wrote:
> On Thu, Mar 29, 2018 at 6:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Mar 28, 2018 at 08:14:03AM -0700, Tim Harvey wrote:
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> ---
> >>  drivers/watchdog/Kconfig   |  10 ++++
> >>  drivers/watchdog/Makefile  |   1 +
> >>  drivers/watchdog/gsc_wdt.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 157 insertions(+)
> >>  create mode 100644 drivers/watchdog/gsc_wdt.c
> >>
> <snip>
> >> +
> >> +static const struct watchdog_info gsc_wdt_info = {
> >> +     .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> >
> > Please confirm that WDIOF_MAGICCLOSE is not set on purpose.
> >
> >> +     .identity = "GSC Watchdog"
> >> +};
> >> +
> <snip>
> >> +
> >> +static int gsc_wdt_probe(struct platform_device *pdev)
> >> +{
> >> +     struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
> >> +     struct device *dev = &pdev->dev;
> >> +     struct gsc_wdt *wdt;
> >> +     int ret;
> >> +     unsigned int reg;
> >> +
> <snip>
> >> +     /* ensure WD bit enabled */
> >> +     if (regmap_read(gsc->regmap, GSC_CTRL_1, &reg))
> >> +             return -EIO;
> >> +     if (!(reg & (1 << GSC_CTRL_1_WDT_ENABLE))) {
> >
> > BIT()
> >
> >> +             dev_err(dev, "not enabled - must be manually enabled\n");
> >
> > This doesn't make sense. Bail out if the watchdog is disabled ? Why ?
> >
> >> +             return -EINVAL;
> >> +     }
> >> +
> <snip>
> >> +
> >> +     watchdog_set_nowayout(&wdt->wdt_dev, 1);
> >
> > WATCHDOG_NOWAYOUT ?
> >
> 
> Guenter,
> 
> Thanks for the review!
> 
> The watchdog implementation of the GSC is such that it is enabled and
> reset via a single non-volatile I2C register bit. If this bit is set
> the watchdog will start ticking down automatically on board power up.
> The register definitions don't provide a condition where it can be
> enabled in a volatile way such that after board power-cycle it is
> disabled again nor do they provide a separate register for enable vs
> reset.
> 
> In the typical case the user boots the board, driver registers
> watchdog, userspace watchdog daemon enables watchdog and it starts
> ticking. User now powers down the board and later powers it back up.
> The watchdog was enabled previously by userspace and the register is
> non-volatile so the watchdog starts ticking before the kernel driver
> and watchdog daemon yet the user breaks out into the bootloader or
> boots a different OS without a watchdog daemon and the board resets
> without them expecting it. The feature that the watchdog starts
> ticking at board power-up before the CPU has even fetched code was
> part of its design and was put there to work around some SoC errata
> that can cause the CPU to fail to fetch boot code. This has caused me
> to implement a watchdog driver that never actually 'enables' or
> 'disables' the watchdog which is why there is no MAGIC CLOSE and why I

Yet the driver does enable and disable the watchdog in its start and stop
functions. And I have no idea what that has to do with the MAGICCLOSE
functionality, which is quite orthogonal to the start/stop functionality.

> always set nowayout. Its possible this is a fairly unique case of a
> watchdog. The probe failure if the watchdog isn't enabled is because I
> don't want a non-enabled watchdog to get enabled just because the
> driver/daemon were there.
> 
Huh ? The whole purpose of a watchdog is for it to be enabled when
the watchdog device is opened.

> I agree it's a very strange behavior and I'm not sure how to best
> document or support it with the Linux watchdog API. I welcome any
> recomendations!
> 

Sorry, I fail to understand your logic.

You do not explain why your code bails out if the watchdog is not already
running. That does not make sense.

You are saying that you don't want the watchdog driver to enable the watchdog.
Since its whole purpose is to enable the watchdog if/when the watchdog device
is opened, that doesn't make sense either.

At the same time, you do not tell the watchdog core that the watchdog is
already running, meaning the system _will_ reboot unless the watchdog
device is opened within the watchdog timeout period. Again, that does not
make sense.

Maybe it all makes sense to you, but not to me, sorry.

Guenter
