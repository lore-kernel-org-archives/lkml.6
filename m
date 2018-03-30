Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC3Rsp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:48:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36852 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeC3Rsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:48:42 -0400
X-Google-Smtp-Source: AIpwx495RbglAs8SdH1+CaM4I/IdMrhaoyR/ZcmCloPUqrLyBdGYlSOgjXaEBbvG3j5s9wrvqd4KbA==
Date: Fri, 30 Mar 2018 10:48:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
Message-ID: <20180330174838.GA141984@dtor-ws>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330010757.GA12896@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 06:07:57PM -0700, Guenter Roeck wrote:
> On Wed, Mar 28, 2018 at 08:14:03AM -0700, Tim Harvey wrote:
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/watchdog/Kconfig   |  10 ++++
> >  drivers/watchdog/Makefile  |   1 +
> >  drivers/watchdog/gsc_wdt.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 157 insertions(+)
> >  create mode 100644 drivers/watchdog/gsc_wdt.c
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index ca200d1..c9d4b2e 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -150,6 +150,16 @@ config GPIO_WATCHDOG_ARCH_INITCALL
> >  	  arch_initcall.
> >  	  If in doubt, say N.
> >  
> > +config GSC_WATCHDOG
> > +	tristate "Gateworks System Controller (GSC) Watchdog support"
> > +	depends on MFD_GATEWORKS_GSC
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Say Y here to include support for the GSC Watchdog.
> > +
> > +	  This driver can also be built as a module. If so the module
> > +	  will be called gsc_wdt.
> > +
> >  config MENF21BMC_WATCHDOG
> >  	tristate "MEN 14F021P00 BMC Watchdog"
> >  	depends on MFD_MENF21BMC || COMPILE_TEST
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 715a210..499327e 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -215,6 +215,7 @@ obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> >  obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
> >  obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
> >  obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
> > +obj-$(CONFIG_GSC_WATCHDOG)	+= gsc_wdt.o
> >  obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
> >  obj-$(CONFIG_WDAT_WDT) += wdat_wdt.o
> >  obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
> > diff --git a/drivers/watchdog/gsc_wdt.c b/drivers/watchdog/gsc_wdt.c
> > new file mode 100644
> > index 0000000..b43d083
> > --- /dev/null
> > +++ b/drivers/watchdog/gsc_wdt.c
> > @@ -0,0 +1,146 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (C) 2018 Gateworks Corporation
> > + *
> > + * This driver registers a Linux Watchdog for the GSC
> > + */
> > +#include <linux/mfd/gsc.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/watchdog.h>
> > +
> > +#define WDT_DEFAULT_TIMEOUT	60
> > +
> > +struct gsc_wdt {
> > +	struct watchdog_device wdt_dev;
> > +	struct gsc_dev *gsc;
> > +};
> > +
> > +static int gsc_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
> > +	unsigned int reg = (1 << GSC_CTRL_1_WDT_ENABLE);
> 
> Please use BIT().
> 
> > +	int ret;
> > +
> > +	dev_dbg(wdd->parent, "%s timeout=%d\n", __func__, wdd->timeout);
> 
> I don't think those debug messages add any value.
> 
> > +
> > +	/* clear first as regmap_update_bits will not write if no change */
> > +	ret = regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, 0);
> > +	if (ret)
> > +		return ret;
> > +	return regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, reg);
> > +}
> > +
> > +static int gsc_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
> > +	unsigned int reg = (1 << GSC_CTRL_1_WDT_ENABLE);
> > +
> 
> BIT(). You might as well drop the variable and just use
> BIT(GSC_CTRL_1_WDT_ENABLE) below.
> 
> > +	dev_dbg(wdd->parent, "%s\n", __func__);
> > +
> > +	return regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1, reg, 0);
> > +}
> > +
> > +static int gsc_wdt_set_timeout(struct watchdog_device *wdd,
> > +			       unsigned int timeout)
> > +{
> > +	struct gsc_wdt *wdt = watchdog_get_drvdata(wdd);
> > +	unsigned int long_sel = 0;
> > +
> > +	dev_dbg(wdd->parent, "%s: %d\n", __func__, timeout);
> > +
> > +	switch (timeout) {
> > +	case 60:
> > +		long_sel = (1 << GSC_CTRL_1_WDT_TIME);
> > +	case 30:
> > +		regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1,
> > +				   (1 << GSC_CTRL_1_WDT_TIME),
> 
> BIT()
> 
> > +				   (long_sel << GSC_CTRL_1_WDT_TIME));

This looks wrong. Are you sure that in case of 60 timeout you want to
actually write

	((1 << GSC_CTRL_1_WDT_TIME) << GSC_CTRL_1_WDT_TIME)

to the register?

Or you meant to write:

	long_sel = timeout > 30;
	regmap_update_bits(wdt->gsc->regmap, GSC_CTRL_1,
			   (long_sel << GSC_CTRL_1_WDT_TIME),

Thanks.

-- 
Dmitry
