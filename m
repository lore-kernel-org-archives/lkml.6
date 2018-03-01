Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032834AbeCAQFh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:05:37 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42400 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032132AbeCAQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:05:34 -0500
X-Google-Smtp-Source: AG47ELuxBWgvwGTlfsKDIK6a1fvHYJlHI19wNz8VyqwQxrtBQIKS8FIUuHax1uXliYm4etrKQIctif7sjSZ5ogg8u6w=
MIME-Version: 1.0
In-Reply-To: <20180228045935.GB151045@dtor-ws>
References: <20180226154130.25774-1-andrew.smirnov@gmail.com> <20180228045935.GB151045@dtor-ws>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 1 Mar 2018 08:05:32 -0800
Message-ID: <CAHQ1cqHT+kY34XS0oJJvc_61XXcuQE_3L451gWJTT16p7VUpZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: Add RAVE SP Powerbutton driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 8:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Andrey,
>
> On Mon, Feb 26, 2018 at 07:41:29AM -0800, Andrey Smirnov wrote:
>> Add driver that properly handles input event emitted by RAVE SP
>> devices.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: linux-input@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Chris Healy <cphealy@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  drivers/input/misc/Kconfig             |  9 ++++
>>  drivers/input/misc/Makefile            |  1 +
>>  drivers/input/misc/rave-sp-pwrbutton.c | 92 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 102 insertions(+)
>>  create mode 100644 drivers/input/misc/rave-sp-pwrbutton.c
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 62a1312a7387..6a3c753b093b 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -841,4 +841,13 @@ config INPUT_HISI_POWERKEY
>>         To compile this driver as a module, choose M here: the
>>         module will be called hisi_powerkey.
>>
>> +config INPUT_RAVE_SP_PWRBUTTON
>> +     tristate "RAVE SP Power button Driver"
>> +     depends on RAVE_SP_CORE
>> +     help
>> +       Say Y here if you want to enable power key reporting from RAVE SP
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called rave-sp-pwrbutton.
>> +
>>  endif
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index a8f61af865aa..6ebeec1f4dd0 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -80,3 +80,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)               += wm831x-on.o
>>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)      += xen-kbdfront.o
>>  obj-$(CONFIG_INPUT_YEALINK)          += yealink.o
>>  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR) += ideapad_slidebar.o
>> +obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)        += rave-sp-pwrbutton.o
>
> Please put it in [somewhat] alphabetical order (even though ideapad is
> out of order).
>

OK, will do in v2.

>
>> diff --git a/drivers/input/misc/rave-sp-pwrbutton.c b/drivers/input/misc/rave-sp-pwrbutton.c
>> new file mode 100644
>> index 000000000000..7511062c724b
>> --- /dev/null
>> +++ b/drivers/input/misc/rave-sp-pwrbutton.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +/*
>> + * Power Button driver for RAVE SP
>> + *
>> + * Copyright (C) 2017 Zodiac Inflight Innovations
>> + *
>> + */
>
> Let's keep SPDX and copyright in the same // comment block.
>

This goes against kernel coding style, but sure.

>> +
>> +#include <linux/input.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/rave-sp.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define RAVE_SP_EVNT_BUTTON_PRESS    (RAVE_SP_EVNT_BASE + 0x00)
>> +
>> +struct rave_sp_power_button {
>> +     struct input_dev *idev;
>> +     struct notifier_block nb;
>> +};
>> +
>> +static int rave_sp_power_button_event(struct notifier_block *nb,
>> +                                   unsigned long action, void *data)
>> +{
>> +     struct rave_sp_power_button *pb =
>> +             container_of(nb, struct rave_sp_power_button, nb);
>> +     const u8 event = rave_sp_action_unpack_event(action);
>> +     const u8 value = rave_sp_action_unpack_value(action);
>> +     struct input_dev *idev = pb->idev;
>> +
>> +     if (event == RAVE_SP_EVNT_BUTTON_PRESS) {
>> +             input_report_key(idev, KEY_POWER, value);
>> +             input_sync(idev);
>> +
>> +             return NOTIFY_STOP;
>> +     }
>> +
>> +     return NOTIFY_DONE;
>> +}
>> +
>> +static int rave_sp_pwrbutton_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct rave_sp_power_button *pb;
>> +     struct input_dev *idev;
>> +     int ret;
>> +
>> +     pb = devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
>> +     if (!pb)
>> +             return -ENOMEM;
>> +
>> +     idev = devm_input_allocate_device(dev);
>> +     if (!idev)
>> +             return -ENOMEM;
>> +
>> +     idev->name = pdev->name;
>> +     idev->dev.parent = dev;
>
> Not needed - done by devm_input_allocate_device().
>

Good point, will remove.

>> +
>> +     input_set_capability(idev, EV_KEY, KEY_POWER);
>> +
>> +     ret = input_register_device(idev);
>> +     if (ret)
>> +             return ret;
>
> Please call this "error".

Sure, will do.

>
>> +
>> +     pb->idev = idev;
>> +     pb->nb.notifier_call = rave_sp_power_button_event;
>> +     pb->nb.priority = 128;
>> +
>> +     return devm_rave_sp_register_event_notifier(dev, &pb->nb);
>
> Prefer
>
>         error = devm_rave...();
>         if (error)
>                 return error;
>
>         return 0;
>

OK, will do in v2.

Thanks,
Andrey Smirnov
