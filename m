Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbeEaRdh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:33:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39399 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755719AbeEaRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:33:34 -0400
X-Google-Smtp-Source: ADUXVKL1vGv0TraQ8IPbMM5rmLGG81WmXEy/6SnHb5XDCIr+xD4nBj8fXsk5BDoJ1V/LxT87uji2iQ==
Date: Thu, 31 May 2018 10:33:31 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 11/11] misc/throttler: Add Chrome OS EC throttler
Message-ID: <20180531173331.GA88063@google.com>
References: <20180525203043.249193-1-mka@chromium.org>
 <20180525203043.249193-12-mka@chromium.org>
 <CAFqH_53iMhvq+6NXoXu50sD=PuXBf-2_D3K1Mf+iggLeGSu_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqH_53iMhvq+6NXoXu50sD=PuXBf-2_D3K1Mf+iggLeGSu_mg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

thanks for the review!

I'll address your comments in the next revision.

On Thu, May 31, 2018 at 11:05:09AM +0200, Enric Balletbo Serra wrote:
> Hi Matthias,
> 
> The patch looks good to me, just three minor comments to be more
> coherent with other cros-ec drivers.
> 
> 2018-05-25 22:30 GMT+02:00 Matthias Kaehlcke <mka@chromium.org>:
> > The driver subscribes to throttling events from the Chrome OS
> > embedded controller and enables/disables system throttling based
> > on these events.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/misc/throttler/Kconfig             |  15 +++
> >  drivers/misc/throttler/Makefile            |   1 +
> >  drivers/misc/throttler/cros_ec_throttler.c | 122 +++++++++++++++++++++
> >  3 files changed, 138 insertions(+)
> >  create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
> >
> > diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> > index ef8388f6bc0a..652b6817b75c 100644
> > --- a/drivers/misc/throttler/Kconfig
> > +++ b/drivers/misc/throttler/Kconfig
> > @@ -11,3 +11,18 @@ menuconfig THROTTLER
> >           Note that you also need a event monitor module usually called
> >           *_throttler.
> >
> > +if THROTTLER
> > +
> > +config CROS_EC_THROTTLER
> > +       tristate "Throttler event monitor for the Chrome OS Embedded Controller"
> 
> s/Chrome OS/ChromeOS/ This is how other cros-ec drivers refer to the
> embedded controller, so will be good if you could maintain this
> denomination.
> 
> > +       default n
> > +       depends on MFD_CROS_EC
> > +       ---help---
> > +         This driver adds support to throttle the system in reaction to
> > +         Chrome OS EC events.
> > +
> 
> ditto
> 
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called cros_ec_throttler.
> > +
> > +endif # THROTTLER
> > +
> > diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> > index c8d920cee315..d9b2a77dabc9 100644
> > --- a/drivers/misc/throttler/Makefile
> > +++ b/drivers/misc/throttler/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_THROTTLER)                += core.o
> > +obj-$(CONFIG_CROS_EC_THROTTLER)        += cros_ec_throttler.o
> > diff --git a/drivers/misc/throttler/cros_ec_throttler.c b/drivers/misc/throttler/cros_ec_throttler.c
> > new file mode 100644
> > index 000000000000..ea6bc002d49c
> > --- /dev/null
> > +++ b/drivers/misc/throttler/cros_ec_throttler.c
> > @@ -0,0 +1,122 @@
> > +/*
> > + * Driver for throttling triggered by EC events.
> > + *
> > + * Copyright (C) 2018 Google, Inc.
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> 
> Replace this for the SPDX header format
> 
> // SPDX-License-Identifier: GPL-2.0+
> // Driver for throttling triggered by EC events.
> //
> // Copyright (C) 2018 Google, Inc.
> // Author: Matthias Kaehlcke <mka@chromium.org>
> 
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/throttler.h>
> > +
> > +struct cros_ec_throttler {
> > +       struct cros_ec_device *ec;
> > +       struct throttler *throttler;
> > +       struct notifier_block nb;
> > +};
> > +
> > +static int cros_ec_throttler_event(struct notifier_block *nb,
> > +       unsigned long queued_during_suspend, void *_notify)
> > +{
> > +       struct cros_ec_throttler *cte =
> > +               container_of(nb, struct cros_ec_throttler, nb);
> 
> nit: Better add a define here instead of split the line like this ?
> 
> > +       u32 host_event;
> > +
> > +       host_event = cros_ec_get_host_event(cte->ec);
> > +       if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_START)) {
> > +               throttler_set_level(cte->throttler, 1);
> > +
> > +               return NOTIFY_OK;
> > +       } else if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_STOP)) {
> > +               throttler_set_level(cte->throttler, 0);
> > +
> > +               return NOTIFY_OK;
> > +       }
> > +
> > +       return NOTIFY_DONE;
> > +}
> > +
> > +static int cros_ec_throttler_probe(struct platform_device *pdev)
> > +{
> > +       struct cros_ec_throttler *cte;
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *np = pdev->dev.of_node;
> > +       int ret;
> > +
> > +       if (!np) {
> > +               /* should never happen */
> > +               return -EINVAL;
> > +       }
> > +
> > +       cte = devm_kzalloc(dev, sizeof(*cte), GFP_KERNEL);
> > +       if (!cte)
> > +               return -ENOMEM;
> > +
> > +       cte->ec = dev_get_drvdata(pdev->dev.parent);
> > +
> > +       cte->throttler = throttler_setup(dev);
> > +       if (IS_ERR(cte->throttler))
> > +               return PTR_ERR(cte->throttler);
> > +
> > +       dev_set_drvdata(dev, cte);
> > +
> > +       cte->nb.notifier_call = cros_ec_throttler_event;
> > +       ret = blocking_notifier_chain_register(&cte->ec->event_notifier,
> > +                                              &cte->nb);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to register notifier\n");
> > +               throttler_teardown(cte->throttler);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_throttler_remove(struct platform_device *pdev)
> > +{
> > +       struct cros_ec_throttler *cte = platform_get_drvdata(pdev);
> > +
> > +       blocking_notifier_chain_unregister(&cte->ec->event_notifier,
> > +                                          &cte->nb);
> > +
> > +       throttler_teardown(cte->throttler);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cros_ec_throttler_of_match[] = {
> > +        { .compatible = "google,cros-ec-throttler" },
> > +        { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_throttler_of_match);
> > +#endif /* CONFIG_OF */
> > +
> > +static struct platform_driver cros_ec_throttler_driver = {
> > +       .driver = {
> > +               .name = "cros-ec-throttler",
> > +               .of_match_table = of_match_ptr(cros_ec_throttler_of_match),
> > +       },
> > +       .probe          = cros_ec_throttler_probe,
> > +       .remove         = cros_ec_throttler_remove,
> > +};
> > +
> > +module_platform_driver(cros_ec_throttler_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> > +MODULE_DESCRIPTION("Chrome OS EC Throttler");
> 
> s/Chrome OS/ChromeOS/
> 
> >
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Thanks,
>   Enric
