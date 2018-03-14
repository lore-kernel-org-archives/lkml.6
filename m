Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCNSFq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:05:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36348 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeCNSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:05:45 -0400
X-Google-Smtp-Source: AG47ELtysbUa2ct7tCkVSjZx8oNpn+IvKW1ls6Kla8dnCAEiBWcweL+L3JABHCVLMih+D8e0goEY1w==
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+MqTubu6+QMOV6QkxR1_ph7OBx2hnBkPr9MfCs9YSPhQ@mail.gmail.com>
References: <20180314052219.224622-1-drinkcat@chromium.org> <CAO-hwJ+MqTubu6+QMOV6QkxR1_ph7OBx2hnBkPr9MfCs9YSPhQ@mail.gmail.com>
From: Dmitry Torokhov <dtor@chromium.org>
Date: Wed, 14 Mar 2018 11:05:39 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ_Bw3bh-e_KX-y+4PODeCo7PAGHih9zsWZFNAcA5c0F1Q@mail.gmail.com>
Message-ID: <CAE_wzQ_Bw3bh-e_KX-y+4PODeCo7PAGHih9zsWZFNAcA5c0F1Q@mail.gmail.com>
Subject: Re: [PATCH v4] HID: google: add google hammer HID driver
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:16 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Nicolas,
>
> On Wed, Mar 14, 2018 at 6:22 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> > From: Wei-Ning Huang <wnhuang@chromium.org>
> >
> > Add Google hammer HID driver. This driver allow us to control hammer
> > keyboard backlight and support future features.
> >
> > We add a new HID quirk, that allows us to have the keyboard interface
> > to bind to google-hammer driver, while the touchpad interface can
> > bind to the multitouch driver.
> >
> > Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > Changes since v3:
> >  - Rebase on latest linux-next/master, which moved the quirk list from
> >    hid-core.c to hid-quirks.c. Also, completely rework the logic to make
> >    it possible to bind google-hammer driver to keyboard interface, and
> >    generic multitouch driver to touchpad interface, as it is much simpler
> >    to do now that quirks are read early in hid_add_device.
>
> Ouch, this logic seems too convoluted for me.
>
> Just to be sure:
> - some of your devices export 2 USB interfaces on the same device (so
> same VID/PID)
> - one of this interface should be handled by hid-multitouch
> - the other should be handled by hid-google-hammer
> - the purpose of the new quirk and HID class are to allow
> hid-google-hammer to only bind on the non multitouch interface
>
> Am I correct?
>
> If I am, given that we now don't need to blacklist the drivers for
> hid-generic since e04a0442d33b8cf183bba38646447b891bb02123, I do not
> understand why simply declaring  "{ HID_DEVICE(BUS_USB,
> HID_GROUP_GENERIC,  USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER)
> }," (same for the 2 others) is not enough to have hid-google-hammer
> binding only on the non-multitouch interface.
>
> Could you please give a shot at it?
>

Ah, cool, if we now forcibly try to rebind devices from generic HID to
specialized driver when it appears, then we indeed to not have to do
this dance with "overrides".

>
> >  - Add dynamic backlight detection support (only such devices have an
> >    output HID descriptor).
> >  - Add support for wand (one more USB product ID).
> >  - Add SPDX-License-Identifier, fix one minor formatting issue.
> >
> >  drivers/hid/Kconfig             |   6 ++
> >  drivers/hid/Makefile            |   1 +
> >  drivers/hid/hid-core.c          |   4 ++
> >  drivers/hid/hid-google-hammer.c | 116 ++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-ids.h           |   3 +
> >  drivers/hid/hid-quirks.c        |   5 ++
> >  include/linux/hid.h             |   2 +
> >  7 files changed, 137 insertions(+)
> >  create mode 100644 drivers/hid/hid-google-hammer.c
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 1fce4c94e5ac..60252fd796f6 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -339,6 +339,12 @@ config HOLTEK_FF
> >           Say Y here if you have a Holtek On Line Grip based game controller
> >           and want to have force feedback support for it.
> >
> > +config HID_GOOGLE_HAMMER
> > +       tristate "Google Hammer Keyboard"
> > +       depends on USB_HID && LEDS_CLASS
> > +       ---help---
> > +       Say Y here if you have a Google Hammer device.
> > +
> >  config HID_GT683R
> >         tristate "MSI GT68xR LED support"
> >         depends on LEDS_CLASS && USB_HID
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 713601c7bfa6..17a8bd97da9d 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_HID_ELO)         += hid-elo.o
> >  obj-$(CONFIG_HID_EZKEY)                += hid-ezkey.o
> >  obj-$(CONFIG_HID_GEMBIRD)      += hid-gembird.o
> >  obj-$(CONFIG_HID_GFRM)         += hid-gfrm.o
> > +obj-$(CONFIG_HID_GOOGLE_HAMMER)        += hid-google-hammer.o
> >  obj-$(CONFIG_HID_GT683R)       += hid-gt683r.o
> >  obj-$(CONFIG_HID_GYRATION)     += hid-gyration.o
> >  obj-$(CONFIG_HID_HOLTEK)       += hid-holtek-kbd.o
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 36af26c2565b..61c7d135d680 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2116,6 +2116,10 @@ int hid_add_device(struct hid_device *hdev)
> >                 ret = hid_scan_report(hdev);
> >                 if (ret)
> >                         hid_warn(hdev, "bad device descriptor (%d)\n", ret);
> > +
> > +               if (hdev->quirks & HID_QUIRK_NO_GENERIC &&
> > +                               hdev->group == HID_GROUP_GENERIC)
> > +                       hdev->group = HID_GROUP_GENERIC_OVERRIDE;
> >         }
> >
> >         /* XXX hack, any other cleaner solution after the driver core
> > diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> > new file mode 100644
> > index 000000000000..e7ad042a8464
> > --- /dev/null
> > +++ b/drivers/hid/hid-google-hammer.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + *  HID driver for Google Hammer device.
> > + *
> > + *  Copyright (c) 2017 Google Inc.
> > + *  Author: Wei-Ning Huang <wnhuang@google.com>
> > + */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or (at your option)
> > + * any later version.
> > + */
> > +
> > +#include <linux/hid.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/usb.h>
>
> Generally that's a no from me to include usb.h. I'd rather have you
> decide on which interface to create the LEDs based on the report
> descriptors, so we can replay the device with uhid without crashing
> the kernel.
>
> > +
> > +#include "hid-ids.h"
> > +
> > +#define MAX_BRIGHTNESS 100
> > +
> > +struct hammer_kbd_leds {
> > +       struct led_classdev cdev;
> > +       struct hid_device *hdev;
> > +       u8 buf[2] ____cacheline_aligned;
> > +};
> > +
> > +static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
> > +               enum led_brightness br)
> > +{
> > +       struct hammer_kbd_leds *led = container_of(cdev,
> > +                                                  struct hammer_kbd_leds,
> > +                                                  cdev);
> > +       int ret;
> > +
> > +       led->buf[0] = 0;
> > +       led->buf[1] = br;
> > +
> > +       ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
> > +       if (ret == -ENOSYS)
> > +               ret = hid_hw_raw_request(led->hdev, 0, led->buf,
> > +                                        sizeof(led->buf),
> > +                                        HID_OUTPUT_REPORT,
> > +                                        HID_REQ_SET_REPORT);
> > +       if (ret < 0)
> > +               hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
> > +                       ret);
> > +       return ret;
> > +}
> > +
> > +static int hammer_register_leds(struct hid_device *hdev)
> > +{
> > +       struct hammer_kbd_leds *kbd_backlight;
> > +
> > +       kbd_backlight = devm_kzalloc(&hdev->dev,
> > +                                    sizeof(*kbd_backlight),
> > +                                    GFP_KERNEL);
> > +       if (!kbd_backlight)
> > +               return -ENOMEM;
> > +
> > +       kbd_backlight->hdev = hdev;
> > +       kbd_backlight->cdev.name = "hammer::kbd_backlight";
> > +       kbd_backlight->cdev.max_brightness = MAX_BRIGHTNESS;
> > +       kbd_backlight->cdev.brightness_set_blocking =
> > +               hammer_kbd_brightness_set_blocking;
> > +       kbd_backlight->cdev.flags = LED_HW_PLUGGABLE;
> > +
> > +       /* Set backlight to 0% initially. */
> > +       hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
> > +
> > +       return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
> > +}
> > +
> > +static int hammer_input_configured(struct hid_device *hdev,
> > +                                  struct hid_input *hi)
> > +{
> > +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > +
> > +       struct list_head *report_list =
> > +               &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> > +
> > +       if (intf->cur_altsetting->desc.bInterfaceProtocol ==
> > +           USB_INTERFACE_PROTOCOL_KEYBOARD && !list_empty(report_list)) {
>
> See above. I am pretty sure you can find something in the report
> descriptor to discriminate the LED capable device from the others.
>
> Cheers,
> Benjamin
>
> > +               int err = hammer_register_leds(hdev);
> > +
> > +               if (err)
> > +                       hid_warn(hdev,
> > +                                "Failed to register keyboard backlight: %d\n",
> > +                                err);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct hid_device_id hammer_devices[] = {
> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(hid, hammer_devices);
> > +
> > +static struct hid_driver hammer_driver = {
> > +       .name = "hammer",
> > +       .id_table = hammer_devices,
> > +       .input_configured = hammer_input_configured,
> > +};
> > +module_hid_driver(hammer_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 41f227a841fb..5a3a7ead3012 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -448,7 +448,10 @@
> >  #define USB_DEVICE_ID_GOODTOUCH_000f   0x000f
> >
> >  #define USB_VENDOR_ID_GOOGLE           0x18d1
> > +#define USB_DEVICE_ID_GOOGLE_HAMMER    0x5022
> >  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE        0x5028
> > +#define USB_DEVICE_ID_GOOGLE_STAFF     0x502b
> > +#define USB_DEVICE_ID_GOOGLE_WAND      0x502d
> >
> >  #define USB_VENDOR_ID_GOTOP            0x08f2
> >  #define USB_DEVICE_ID_SUPER_Q2         0x007f
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > index 587e2681a53f..d112a14da200 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -84,6 +84,11 @@ static const struct hid_device_id hid_quirks[] = {
> >         { HID_USB_DEVICE(USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28), HID_QUIRK_NOGET },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY), HID_QUIRK_NO_INIT_REPORTS },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD), HID_QUIRK_MULTI_INPUT },
> > +#if IS_ENABLED(CONFIG_HID_GOOGLE_HAMMER)
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER), HID_QUIRK_NO_GENERIC },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF), HID_QUIRK_NO_GENERIC },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND), HID_QUIRK_NO_GENERIC },
> > +#endif
> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index dfea5a656a1a..f2655265f8b5 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -340,6 +340,7 @@ struct hid_item {
> >  #define HID_QUIRK_NO_EMPTY_INPUT               0x00000100
> >  /* 0x00000200 reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
> >  #define HID_QUIRK_ALWAYS_POLL                  0x00000400
> > +#define HID_QUIRK_NO_GENERIC                   0x00000800
> >  #define HID_QUIRK_SKIP_OUTPUT_REPORTS          0x00010000
> >  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID                0x00020000
> >  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP 0x00040000
> > @@ -359,6 +360,7 @@ struct hid_item {
> >  #define HID_GROUP_MULTITOUCH                   0x0002
> >  #define HID_GROUP_SENSOR_HUB                   0x0003
> >  #define HID_GROUP_MULTITOUCH_WIN_8             0x0004
> > +#define HID_GROUP_GENERIC_OVERRIDE             0x0005
> >
> >  /*
> >   * Vendor specific HID device groups
> > --
> > 2.16.2.804.g6dcf76e118-goog
> >
