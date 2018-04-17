Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDQIvN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:51:13 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37179 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeDQIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:50:52 -0400
X-Google-Smtp-Source: AIpwx49Bd0+sqk5NpOQuzK6k0xkFImnopkKi6FVuPTdGJBPWz5NLE3mLQpEUglKI0JVEfDd9WecgsSCz0IBihpHeRL0=
MIME-Version: 1.0
In-Reply-To: <20180416213824.14688-1-rombert@apache.org>
References: <20180416213824.14688-1-rombert@apache.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 17 Apr 2018 10:50:50 +0200
Message-ID: <CAO-hwJKAizQMMPT2=jSK+LTr_pdX_04BzPkgZK98rFHmXG7+0Q@mail.gmail.com>
Subject: Re: [PATCH v6] Fix modifier keys for Redragon Asura Keyboard
To: Robert Munteanu <rombert@apache.org>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 11:38 PM, Robert Munteanu <rombert@apache.org> wrote:
> This adds a new driver for the Redragon Asura keyboard. The Asura
> keyboard contains an error in the HID descriptor which causes all
> modifier keys to be mapped to left shift. Additionally, we suppress
> the creation of a second, not working, keyboard device.
>
> Signed-off-by: Robert Munteanu <rombert@apache.org>
> ---

Looks good to me now:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Robert for respinning the series!

Cheers,
Benjamin

>  drivers/hid/Kconfig        |  7 ++++
>  drivers/hid/Makefile       |  1 +
>  drivers/hid/hid-ids.h      |  1 +
>  drivers/hid/hid-redragon.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+)
>  create mode 100644 drivers/hid/hid-redragon.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 19c499f5623d..1125e4813716 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -560,6 +560,13 @@ config HID_MAYFLASH
>         Say Y here if you have HJZ Mayflash PS3 game controller adapters
>         and want to enable force feedback support.
>
> +config HID_REDRAGON
> +       tristate "Redragon keyboards"
> +       depends on HID
> +       default !EXPERT
> +       ---help---
> +    Support for Redragon keyboards that need fix-ups to work properly.
> +
>  config HID_MICROSOFT
>         tristate "Microsoft non-fully HID-compliant devices"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index eb13b9e92d85..a36f3f40ba63 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -84,6 +84,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)                += hid-picolcd_debugfs.o
>
>  obj-$(CONFIG_HID_PLANTRONICS)  += hid-plantronics.o
>  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
> +obj-$(CONFIG_HID_REDRAGON)     += hid-redragon.o
>  obj-$(CONFIG_HID_RETRODE)      += hid-retrode.o
>  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o \
>         hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 9454ac134ce2..41a64d0e91f9 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -599,6 +599,7 @@
>  #define USB_VENDOR_ID_JESS             0x0c45
>  #define USB_DEVICE_ID_JESS_YUREX       0x1010
>  #define USB_DEVICE_ID_ASUS_MD_5112     0x5112
> +#define USB_DEVICE_ID_REDRAGON_ASURA   0x760b
>
>  #define USB_VENDOR_ID_JESS2            0x0f30
>  #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
> diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
> new file mode 100644
> index 000000000000..daf59578bf93
> --- /dev/null
> +++ b/drivers/hid/hid-redragon.c
> @@ -0,0 +1,86 @@
> +/*
> + *  HID driver for Redragon keyboards
> + *
> + *  Copyright (c) 2017 Robert Munteanu
> + *  SPDX-License-Identifier: GPL-2.0+
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +
> +/*
> + * The Redragon Asura keyboard sends an incorrect HID descriptor.
> + * At byte 100 it contains
> + *
> + *   0x81, 0x00
> + *
> + * which is Input (Data, Arr, Abs), but it should be
> + *
> + *   0x81, 0x02
> + *
> + * which is Input (Data, Var, Abs), which is consistent with the way
> + * key codes are generated.
> + */
> +
> +static __u8 *redragon_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +       unsigned int *rsize)
> +{
> +       if (*rsize >= 102 && rdesc[100] == 0x81 && rdesc[101] == 0x00) {
> +               dev_info(&hdev->dev, "Fixing Redragon ASURA report descriptor.\n");
> +               rdesc[101] = 0x02;
> +       }
> +
> +       return rdesc;
> +}
> +
> +static int redragon_probe(struct hid_device *dev,
> +       const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       ret = hid_parse(dev);
> +       if (ret) {
> +               hid_err(dev, "parse failed\n");
> +               return ret;
> +       }
> +
> +       /* do not register unused input device */
> +       if (dev->maxapplication == 1)
> +               return 0;
> +
> +       ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(dev, "hw start failed\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +static const struct hid_device_id redragon_devices[] = {
> +       {HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_REDRAGON_ASURA)},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(hid, redragon_devices);
> +
> +static struct hid_driver redragon_driver = {
> +       .name = "redragon",
> +       .id_table = redragon_devices,
> +       .report_fixup = redragon_report_fixup,
> +       .probe = redragon_probe
> +};
> +
> +module_hid_driver(redragon_driver);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.16.3
>
