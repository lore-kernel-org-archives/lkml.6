Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeDPNgV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:36:21 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33609 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeDPNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:36:19 -0400
X-Google-Smtp-Source: AIpwx488BO9Fq0THnJFmwT5q6WVXZ6I2FePMwn6yEFMlDFy3tsU8/3FAvOuQRkP1ytYFB6VZ1fCPsemnT48/CRIeDQw=
MIME-Version: 1.0
In-Reply-To: <149a44d0456b2f0b48be13ba51aeaccc33651073.camel@apache.org>
References: <20180411094953.12053-1-rombert@apache.org> <CAO-hwJKbYyZdtq=zg_ZeJOiL=5cTbD4oKuWmpF-P_7TgBkqVYA@mail.gmail.com>
 <149a44d0456b2f0b48be13ba51aeaccc33651073.camel@apache.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 16 Apr 2018 15:36:18 +0200
Message-ID: <CAO-hwJKF-=5jXN__csRJRTLBHt3cbwHWM+eTm4i8UXknuZzfHA@mail.gmail.com>
Subject: Re: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
To: Robert Munteanu <rombert@apache.org>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:14 PM, Robert Munteanu <rombert@apache.org> wrote:
> Hi Benjamin and Jiri,
>
> On Mon, 2018-04-16 at 12:02 +0200, Benjamin Tissoires wrote:
>> Hi Robert,
>>
>> On Wed, Apr 11, 2018 at 11:49 AM, Robert Munteanu <rombert@apache.org
>> > wrote:
>> > Changelog:
>> >
>> > - v2: modifier keys work, some combinations are still troublesome
>> > - v3: style cleanup, rebase on top of 4.14
>> > - v4: remove most debugging calls, make init info useful for user,
>> >   rebased on top of 4.15
>> > - v5: fix the HID descriptor as suggested by Benjamin Tissoires,
>> >   use existing USB vendor id, update comment style, add SPDX
>> >   license identifier, rename to hid-redragon, stop registering
>> >   two input devices, rebased on top of 4.16
>>
>> As Jiri said, please provide a correct commit message.
>
> Will do.
>
>>
>> I have a few nitpicks in the driver, v6 should be fine:
>>
>> >
>> > Signed-off-by: Robert Munteanu <rombert@apache.org>
>> > ---
>> >  drivers/hid/Kconfig        |  7 ++++
>> >  drivers/hid/Makefile       |  1 +
>> >  drivers/hid/hid-ids.h      |  1 +
>> >  drivers/hid/hid-quirks.c   |  3 ++
>> >  drivers/hid/hid-redragon.c | 89
>> > ++++++++++++++++++++++++++++++++++++++++++++++
>> >  5 files changed, 101 insertions(+)
>> >  create mode 100644 drivers/hid/hid-redragon.c
>> >
>> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> > index 19c499f5623d..1125e4813716 100644
>> > --- a/drivers/hid/Kconfig
>> > +++ b/drivers/hid/Kconfig
>> > @@ -560,6 +560,13 @@ config HID_MAYFLASH
>> >         Say Y here if you have HJZ Mayflash PS3 game controller
>> > adapters
>> >         and want to enable force feedback support.
>> >
>> > +config HID_REDRAGON
>> > +       tristate "Redragon keyboards"
>> > +       depends on HID
>> > +       default !EXPERT
>> > +       ---help---
>> > +    Support for Redragon keyboards that need fix-ups to work
>> > properly.
>> > +
>> >  config HID_MICROSOFT
>> >         tristate "Microsoft non-fully HID-compliant devices"
>> >         depends on HID
>> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> > index eb13b9e92d85..a36f3f40ba63 100644
>> > --- a/drivers/hid/Makefile
>> > +++ b/drivers/hid/Makefile
>> > @@ -84,6 +84,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)                +=
>> > hid-picolcd_debugfs.o
>> >
>> >  obj-$(CONFIG_HID_PLANTRONICS)  += hid-plantronics.o
>> >  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
>> > +obj-$(CONFIG_HID_REDRAGON)     += hid-redragon.o
>> >  obj-$(CONFIG_HID_RETRODE)      += hid-retrode.o
>> >  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o
>> > \
>> >         hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
>> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> > index 9454ac134ce2..41a64d0e91f9 100644
>> > --- a/drivers/hid/hid-ids.h
>> > +++ b/drivers/hid/hid-ids.h
>> > @@ -599,6 +599,7 @@
>> >  #define USB_VENDOR_ID_JESS             0x0c45
>> >  #define USB_DEVICE_ID_JESS_YUREX       0x1010
>> >  #define USB_DEVICE_ID_ASUS_MD_5112     0x5112
>> > +#define USB_DEVICE_ID_REDRAGON_ASURA   0x760b
>> >
>> >  #define USB_VENDOR_ID_JESS2            0x0f30
>> >  #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
>> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> > index e92b77fa574a..5f1253f1739a 100644
>> > --- a/drivers/hid/hid-quirks.c
>> > +++ b/drivers/hid/hid-quirks.c
>> > @@ -557,6 +557,9 @@ static const struct hid_device_id
>> > hid_have_special_driver[] = {
>> >  #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS,
>> > USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
>> >  #endif
>> > +#if IS_ENABLED(CONFIG_HID_REDRAGON)
>> > +       {
>> > HID_USB_DEVICE(USB_VENDOR_ID_JESS,  USB_DEVICE_ID_REDRAGON_ASURA)
>> > },
>> > +#endif
>>
>> Please drop this hunk. v4.16 should work without changing
>> hid_have_special_driver. This way, you will be sure that an initramfs
>> that doesn't include hid-redragon.ko will allo people to type their
>> LUKS password.
>
> I recall testing without this change resulted in the driver not being
> picked up. I will retest ( running 4.16.0 here, can update to 4.16.1
> soon ). In case the driver is not picked up, where should I start
> looking?
>
>>
>> >  #if IS_ENABLED(CONFIG_HID_RETRODE)
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
>> > USB_DEVICE_ID_RETRODE2) },
>> >  #endif
>> > diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-
>> > redragon.c
>> > new file mode 100644
>> > index 000000000000..ff98a5dbb8e2
>> > --- /dev/null
>> > +++ b/drivers/hid/hid-redragon.c
>> > @@ -0,0 +1,89 @@
>> > +/*
>> > + *  HID driver for Redragon keyboards
>> > + *
>> > + *  Copyright (c) 2017 Robert Munteanu
>> > + *  SPDX-License-Identifier: GPL-2.0
>> > + */
>> > +
>> > +/*
>> > + * This program is free software; you can redistribute it and/or
>> > modify it
>> > + * under the terms of the GNU General Public License as published
>> > by the Free
>> > + * Software Foundation; either version 2 of the License, or (at
>> > your option)
>> > + * any later version.
>> > + */
>> > +
>> > +#include <linux/device.h>
>> > +#include <linux/input.h>
>>
>> you probably don't need input.h
>>
>> > +#include <linux/hid.h>
>> > +#include <linux/module.h>
>> > +#include <linux/log2.h>
>>
>> log2.h? I am not sure you need it either
>>
>> > +#include <linux/input-event-codes.h>
>>
>> probably drop this one too.
>
> I'll drop the missing imports, those are leftovers from my initial
> work.
>
>>
>> > +
>> > +#include "hid-ids.h"
>> > +
>> > +
>> > +/*
>> > + * The Redragon Asura keyboard sends an incorrect HID descriptor.
>> > + * At byte 100 it contains
>> > + *
>> > + *   0x81, 0x00
>> > + *
>> > + * which is Input (Data, Arr, Abs), but it should be
>> > + *
>> > + *   0x81, 0x02
>> > + *
>> > + * which is Input (Data, Var, Abs), which is consistent with the
>> > way
>> > + * key codes are generated.
>> > + */
>> > +
>> > +static __u8 *redragon_report_fixup(struct hid_device *hdev, __u8
>> > *rdesc,
>> > +       unsigned int *rsize)
>> > +{
>> > +       if (*rsize >= 102 && rdesc[100] == 0x81 && rdesc[101] ==
>> > 0x00) {
>> > +               dev_info(&hdev->dev, "Fixing Redragon ASURA report
>> > descriptor.\n");
>> > +               rdesc[101] = 0x02;
>> > +       }
>> > +
>> > +       return rdesc;
>> > +}
>> > +
>> > +static int redragon_probe(struct hid_device *dev,
>> > +       const struct hid_device_id *id)
>> > +{
>> > +       int ret;
>> > +
>> > +       ret = hid_parse(dev);
>> > +       if (ret) {
>> > +               hid_err(dev, "parse failed\n");
>> > +               return ret;
>> > +       }
>> > +
>> > +       /* do not register unused input device */
>> > +       if (dev->maxapplication == 1)
>> > +               return 0;
>> > +
>> > +       ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
>> > +       if (ret) {
>> > +               hid_err(dev, "hw start failed\n");
>> > +               return ret;
>> > +       }
>> > +
>> > +       return 0;
>> > +}
>> > +static const struct hid_device_id redragon_devices[] = {
>> > +       {HID_USB_DEVICE(USB_VENDOR_ID_JESS,
>> > USB_DEVICE_ID_REDRAGON_ASURA)},
>> > +       {}
>> > +};
>> > +
>> > +MODULE_DEVICE_TABLE(hid, redragon_devices);
>> > +
>> > +static struct hid_driver redragon_driver = {
>> > +       .name = "redragon",
>> > +       .id_table = redragon_devices,
>> > +       .report_fixup = redragon_report_fixup,
>> > +       .probe = redragon_probe
>> > +};
>> > +
>> > +module_hid_driver(redragon_driver);
>> > +
>> > +MODULE_LICENSE("GPL");
>>
>> The SPDX header says GPL-v2. And IIRC if there is the SPDX header you
>> can drop the MODULE_LICENSE (not entirely sure though).
>
> Ack, will adjust and re-test.

Actually, you might be correct. I just read Mauro's blog:
https://blogs.s-osg.org/linux-kernel-license-practices-revisited-spdx/
and it says "Types of licenses for MODULE_LICENSE() macro -> 'GPL' ->
GNU Public License v2 or later" (in the second table).

Cheers,
Benjamin

>
> Thanks for the review,
>
> Robert
