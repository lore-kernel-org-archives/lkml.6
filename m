Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936018AbeCHRaB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:30:01 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40749 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeCHR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:29:59 -0500
X-Google-Smtp-Source: AG47ELtuQloCkjBLdA8CKiTYdOS8nqfOT9UeDt/esEVW8gjWVWNLIlrpZrC7SIEAYIwn17e0wgnu3YZcXaxerHMsRfE=
MIME-Version: 1.0
In-Reply-To: <e90aba60-9126-17c2-7c70-66b5cab32d93@linaro.org>
References: <20180307024011.25033-1-andrew.smirnov@gmail.com> <e90aba60-9126-17c2-7c70-66b5cab32d93@linaro.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Mar 2018 09:29:58 -0800
Message-ID: <CAHQ1cqEv1uEAaNj8bdjEO6cWiwp7a1jRUCPFyQQkh9Ao+ch11w@mail.gmail.com>
Subject: Re: [PATCH 1/2] backlight: Add RAVE SP backlight driver
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 8:58 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On 07/03/18 02:40, Andrey Smirnov wrote:
>>
>> This driver provides access to RAVE SP backlight control
>> functionality.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Chris Healy <cphealy@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Aleksander Morgado <aleksander@aleksander.es>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>   drivers/video/backlight/Kconfig             |  6 +++
>>   drivers/video/backlight/Makefile            |  1 +
>>   drivers/video/backlight/rave-sp-backlight.c | 82
>> +++++++++++++++++++++++++++++
>>   include/linux/mfd/rave-sp.h                 |  1 +
>>   4 files changed, 90 insertions(+)
>>   create mode 100644 drivers/video/backlight/rave-sp-backlight.c
>>
>> diff --git a/drivers/video/backlight/Kconfig
>> b/drivers/video/backlight/Kconfig
>> index 4e1d2ad50ba1..5d2d0d7e8100 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -467,6 +467,12 @@ config BACKLIGHT_ARCXCNN
>>           If you have an ARCxCnnnn family backlight say Y to enable
>>           the backlight driver.
>>   +config BACKLIGHT_RAVE_SP
>> +       tristate "RAVE SP Backlight driver"
>> +       depends on RAVE_SP_CORE
>> +       help
>> +         Support for backlight control on RAVE SP device.
>> +
>>   endif # BACKLIGHT_CLASS_DEVICE
>>     endif # BACKLIGHT_LCD_SUPPORT
>> diff --git a/drivers/video/backlight/Makefile
>> b/drivers/video/backlight/Makefile
>> index 5e28f01c8391..19da71d518bf 100644
>> --- a/drivers/video/backlight/Makefile
>> +++ b/drivers/video/backlight/Makefile
>> @@ -57,3 +57,4 @@ obj-$(CONFIG_BACKLIGHT_TOSA)          += tosa_bl.o
>>   obj-$(CONFIG_BACKLIGHT_TPS65217)      += tps65217_bl.o
>>   obj-$(CONFIG_BACKLIGHT_WM831X)                += wm831x_bl.o
>>   obj-$(CONFIG_BACKLIGHT_ARCXCNN)       += arcxcnn_bl.o
>> +obj-$(CONFIG_BACKLIGHT_RAVE_SP)                += rave-sp-backlight.o
>> diff --git a/drivers/video/backlight/rave-sp-backlight.c
>> b/drivers/video/backlight/rave-sp-backlight.c
>> new file mode 100644
>> index 000000000000..62836ba561db
>> --- /dev/null
>> +++ b/drivers/video/backlight/rave-sp-backlight.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +/*
>> + * LCD Backlight driver for RAVE SP
>> + *
>> + * Copyright (C) 2018 Zodiac Inflight Innovations
>> + *
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/rave-sp.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define        RAVE_SP_BACKLIGHT_LCD_EN        BIT(7)
>> +
>> +static int rave_sp_backlight_update_status(struct backlight_device *bd)
>> +{
>> +       const struct backlight_properties *p = &bd->props;
>> +       const u8 intensity =
>> +               (p->power == FB_BLANK_UNBLANK) ? p->brightness : 0;
>> +       struct rave_sp *sp = dev_get_drvdata(&bd->dev);
>> +       u8 cmd[] = {
>> +               [0] = RAVE_SP_CMD_SET_BACKLIGHT,
>> +               [1] = 0,
>> +               [2] = intensity ? RAVE_SP_BACKLIGHT_LCD_EN | intensity :
>> 0,
>> +               [3] = 0,
>> +               [4] = 0,
>> +       };
>> +
>> +       return rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
>> +}
>> +
>> +static const struct backlight_ops rave_sp_backlight_ops = {
>> +       .options        = BL_CORE_SUSPENDRESUME,
>> +       .update_status  = rave_sp_backlight_update_status,
>> +};
>> +
>> +static struct backlight_properties rave_sp_backlight_props = {
>> +       .type           = BACKLIGHT_FIRMWARE,
>
>
> I would have thought BACKLIGHT_PLATFORM would be more suitable here.
> BACKLIGHT_FIRMWARE is used for things like the ACPI backlight driver.
>
> Why did you select this one?
>

Good point and I don't think I have any justification to choose
FIRMWARE over PLATFORM, will fix in v2.

Thanks,
Andrey Smirnov
