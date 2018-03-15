Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCOBWY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:22:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37044 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCOBWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:22:22 -0400
X-Google-Smtp-Source: AG47ELuJ/wVq5kXEQ2eevYuh63FYqkmIa5HEg5zeDUAAYGQXT5iBgxuLF/7iVvmC6Duj7XYO0MHV6Pbg0HlF8UlkMrY=
MIME-Version: 1.0
In-Reply-To: <CAE_wzQ_Bw3bh-e_KX-y+4PODeCo7PAGHih9zsWZFNAcA5c0F1Q@mail.gmail.com>
References: <20180314052219.224622-1-drinkcat@chromium.org>
 <CAO-hwJ+MqTubu6+QMOV6QkxR1_ph7OBx2hnBkPr9MfCs9YSPhQ@mail.gmail.com> <CAE_wzQ_Bw3bh-e_KX-y+4PODeCo7PAGHih9zsWZFNAcA5c0F1Q@mail.gmail.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 15 Mar 2018 09:22:20 +0800
Message-ID: <CANMq1KCOJnLJHKh3E5VMtJMjY-buWTeFvoBK2nDf1UA6mdzkOg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: google: add google hammer HID driver
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 2:05 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> On Wed, Mar 14, 2018 at 9:16 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>>
>> Hi Nicolas,
>>
>> On Wed, Mar 14, 2018 at 6:22 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
>> > From: Wei-Ning Huang <wnhuang@chromium.org>
>> >
>> > Add Google hammer HID driver. This driver allow us to control hammer
>> > keyboard backlight and support future features.
>> >
>> > We add a new HID quirk, that allows us to have the keyboard interface
>> > to bind to google-hammer driver, while the touchpad interface can
>> > bind to the multitouch driver.
>> >
>> > Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
>> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>> > ---
>> >
>> > Changes since v3:
>> >  - Rebase on latest linux-next/master, which moved the quirk list from
>> >    hid-core.c to hid-quirks.c. Also, completely rework the logic to make
>> >    it possible to bind google-hammer driver to keyboard interface, and
>> >    generic multitouch driver to touchpad interface, as it is much simpler
>> >    to do now that quirks are read early in hid_add_device.
>>
>> Ouch, this logic seems too convoluted for me.
>>
>> Just to be sure:
>> - some of your devices export 2 USB interfaces on the same device (so
>> same VID/PID)
>> - one of this interface should be handled by hid-multitouch
>> - the other should be handled by hid-google-hammer
>> - the purpose of the new quirk and HID class are to allow
>> hid-google-hammer to only bind on the non multitouch interface
>>
>> Am I correct?
>>
>> If I am, given that we now don't need to blacklist the drivers for
>> hid-generic since e04a0442d33b8cf183bba38646447b891bb02123, I do not
>> understand why simply declaring  "{ HID_DEVICE(BUS_USB,
>> HID_GROUP_GENERIC,  USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER)
>> }," (same for the 2 others) is not enough to have hid-google-hammer
>> binding only on the non-multitouch interface.
>>
>> Could you please give a shot at it?
>>
>
> Ah, cool, if we now forcibly try to rebind devices from generic HID to
> specialized driver when it appears, then we indeed to not have to do
> this dance with "overrides".

Nice, that works, thanks Benjamin. v5 coming up in a few minutes.

>>
>> >  - Add dynamic backlight detection support (only such devices have an
>> >    output HID descriptor).
>> >  - Add support for wand (one more USB product ID).
>> >  - Add SPDX-License-Identifier, fix one minor formatting issue.
>> >
>> >  drivers/hid/Kconfig             |   6 ++
>> >  drivers/hid/Makefile            |   1 +
>> >  drivers/hid/hid-core.c          |   4 ++
>> >  drivers/hid/hid-google-hammer.c | 116 ++++++++++++++++++++++++++++++++
>> >  drivers/hid/hid-ids.h           |   3 +
>> >  drivers/hid/hid-quirks.c        |   5 ++
>> >  include/linux/hid.h             |   2 +
>> >  7 files changed, 137 insertions(+)
>> >  create mode 100644 drivers/hid/hid-google-hammer.c
>> >
>> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> > index 1fce4c94e5ac..60252fd796f6 100644
>> > --- a/drivers/hid/Kconfig
>> > +++ b/drivers/hid/Kconfig
>> > @@ -339,6 +339,12 @@ config HOLTEK_FF
>> >           Say Y here if you have a Holtek On Line Grip based game controller
>> >           and want to have force feedback support for it.
>> >
>> > +config HID_GOOGLE_HAMMER
>> > +       tristate "Google Hammer Keyboard"
>> > +       depends on USB_HID && LEDS_CLASS
>> > +       ---help---
>> > +       Say Y here if you have a Google Hammer device.
>> > +
>> >  config HID_GT683R
>> >         tristate "MSI GT68xR LED support"
>> >         depends on LEDS_CLASS && USB_HID
>> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> > index 713601c7bfa6..17a8bd97da9d 100644
>> > --- a/drivers/hid/Makefile
>> > +++ b/drivers/hid/Makefile
>> > @@ -45,6 +45,7 @@ obj-$(CONFIG_HID_ELO)         += hid-elo.o
>> >  obj-$(CONFIG_HID_EZKEY)                += hid-ezkey.o
>> >  obj-$(CONFIG_HID_GEMBIRD)      += hid-gembird.o
>> >  obj-$(CONFIG_HID_GFRM)         += hid-gfrm.o
>> > +obj-$(CONFIG_HID_GOOGLE_HAMMER)        += hid-google-hammer.o
>> >  obj-$(CONFIG_HID_GT683R)       += hid-gt683r.o
>> >  obj-$(CONFIG_HID_GYRATION)     += hid-gyration.o
>> >  obj-$(CONFIG_HID_HOLTEK)       += hid-holtek-kbd.o
>> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> > index 36af26c2565b..61c7d135d680 100644
>> > --- a/drivers/hid/hid-core.c
>> > +++ b/drivers/hid/hid-core.c
>> > @@ -2116,6 +2116,10 @@ int hid_add_device(struct hid_device *hdev)
>> >                 ret = hid_scan_report(hdev);
>> >                 if (ret)
>> >                         hid_warn(hdev, "bad device descriptor (%d)\n", ret);
>> > +
>> > +               if (hdev->quirks & HID_QUIRK_NO_GENERIC &&
>> > +                               hdev->group == HID_GROUP_GENERIC)
>> > +                       hdev->group = HID_GROUP_GENERIC_OVERRIDE;
>> >         }
>> >
>> >         /* XXX hack, any other cleaner solution after the driver core
>> > diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
>> > new file mode 100644
>> > index 000000000000..e7ad042a8464
>> > --- /dev/null
>> > +++ b/drivers/hid/hid-google-hammer.c
>> > @@ -0,0 +1,116 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + *  HID driver for Google Hammer device.
>> > + *
>> > + *  Copyright (c) 2017 Google Inc.
>> > + *  Author: Wei-Ning Huang <wnhuang@google.com>
>> > + */
>> > +
>> > +/*
>> > + * This program is free software; you can redistribute it and/or modify it
>> > + * under the terms of the GNU General Public License as published by the Free
>> > + * Software Foundation; either version 2 of the License, or (at your option)
>> > + * any later version.
>> > + */
>> > +
>> > +#include <linux/hid.h>
>> > +#include <linux/leds.h>
>> > +#include <linux/module.h>
>> > +#include <linux/usb.h>
>>
>> Generally that's a no from me to include usb.h. I'd rather have you
>> decide on which interface to create the LEDs based on the report
>> descriptors, so we can replay the device with uhid without crashing
>> the kernel.
>>
>> > +
>> > +#include "hid-ids.h"
>> > +
>> > +#define MAX_BRIGHTNESS 100
>> > +
>> > +struct hammer_kbd_leds {
>> > +       struct led_classdev cdev;
>> > +       struct hid_device *hdev;
>> > +       u8 buf[2] ____cacheline_aligned;
>> > +};
>> > +
>> > +static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
>> > +               enum led_brightness br)
>> > +{
>> > +       struct hammer_kbd_leds *led = container_of(cdev,
>> > +                                                  struct hammer_kbd_leds,
>> > +                                                  cdev);
>> > +       int ret;
>> > +
>> > +       led->buf[0] = 0;
>> > +       led->buf[1] = br;
>> > +
>> > +       ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
>> > +       if (ret == -ENOSYS)
>> > +               ret = hid_hw_raw_request(led->hdev, 0, led->buf,
>> > +                                        sizeof(led->buf),
>> > +                                        HID_OUTPUT_REPORT,
>> > +                                        HID_REQ_SET_REPORT);
>> > +       if (ret < 0)
>> > +               hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
>> > +                       ret);
>> > +       return ret;
>> > +}
>> > +
>> > +static int hammer_register_leds(struct hid_device *hdev)
>> > +{
>> > +       struct hammer_kbd_leds *kbd_backlight;
>> > +
>> > +       kbd_backlight = devm_kzalloc(&hdev->dev,
>> > +                                    sizeof(*kbd_backlight),
>> > +                                    GFP_KERNEL);
>> > +       if (!kbd_backlight)
>> > +               return -ENOMEM;
>> > +
>> > +       kbd_backlight->hdev = hdev;
>> > +       kbd_backlight->cdev.name = "hammer::kbd_backlight";
>> > +       kbd_backlight->cdev.max_brightness = MAX_BRIGHTNESS;
>> > +       kbd_backlight->cdev.brightness_set_blocking =
>> > +               hammer_kbd_brightness_set_blocking;
>> > +       kbd_backlight->cdev.flags = LED_HW_PLUGGABLE;
>> > +
>> > +       /* Set backlight to 0% initially. */
>> > +       hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
>> > +
>> > +       return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
>> > +}
>> > +
>> > +static int hammer_input_configured(struct hid_device *hdev,
>> > +                                  struct hid_input *hi)
>> > +{
>> > +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
>> > +
>> > +       struct list_head *report_list =
>> > +               &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
>> > +
>> > +       if (intf->cur_altsetting->desc.bInterfaceProtocol ==
>> > +           USB_INTERFACE_PROTOCOL_KEYBOARD && !list_empty(report_list)) {
>>
>> See above. I am pretty sure you can find something in the report
>> descriptor to discriminate the LED capable device from the others.
>>
>> Cheers,
>> Benjamin
>>
>> > +               int err = hammer_register_leds(hdev);
>> > +
>> > +               if (err)
>> > +                       hid_warn(hdev,
>> > +                                "Failed to register keyboard backlight: %d\n",
>> > +                                err);
>> > +       }
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static const struct hid_device_id hammer_devices[] = {
>> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
>> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
>> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
>> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
>> > +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC_OVERRIDE,
>> > +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
>> > +       { }
>> > +};
>> > +MODULE_DEVICE_TABLE(hid, hammer_devices);
>> > +
>> > +static struct hid_driver hammer_driver = {
>> > +       .name = "hammer",
>> > +       .id_table = hammer_devices,
>> > +       .input_configured = hammer_input_configured,
>> > +};
>> > +module_hid_driver(hammer_driver);
>> > +
>> > +MODULE_LICENSE("GPL");
>> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> > index 41f227a841fb..5a3a7ead3012 100644
>> > --- a/drivers/hid/hid-ids.h
>> > +++ b/drivers/hid/hid-ids.h
>> > @@ -448,7 +448,10 @@
>> >  #define USB_DEVICE_ID_GOODTOUCH_000f   0x000f
>> >
>> >  #define USB_VENDOR_ID_GOOGLE           0x18d1
>> > +#define USB_DEVICE_ID_GOOGLE_HAMMER    0x5022
>> >  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE        0x5028
>> > +#define USB_DEVICE_ID_GOOGLE_STAFF     0x502b
>> > +#define USB_DEVICE_ID_GOOGLE_WAND      0x502d
>> >
>> >  #define USB_VENDOR_ID_GOTOP            0x08f2
>> >  #define USB_DEVICE_ID_SUPER_Q2         0x007f
>> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> > index 587e2681a53f..d112a14da200 100644
>> > --- a/drivers/hid/hid-quirks.c
>> > +++ b/drivers/hid/hid-quirks.c
>> > @@ -84,6 +84,11 @@ static const struct hid_device_id hid_quirks[] = {
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28), HID_QUIRK_NOGET },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_FUTABA, USB_DEVICE_ID_LED_DISPLAY), HID_QUIRK_NO_INIT_REPORTS },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD), HID_QUIRK_MULTI_INPUT },
>> > +#if IS_ENABLED(CONFIG_HID_GOOGLE_HAMMER)
>> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER), HID_QUIRK_NO_GENERIC },
>> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF), HID_QUIRK_NO_GENERIC },
>> > +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND), HID_QUIRK_NO_GENERIC },
>> > +#endif
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>> > diff --git a/include/linux/hid.h b/include/linux/hid.h
>> > index dfea5a656a1a..f2655265f8b5 100644
>> > --- a/include/linux/hid.h
>> > +++ b/include/linux/hid.h
>> > @@ -340,6 +340,7 @@ struct hid_item {
>> >  #define HID_QUIRK_NO_EMPTY_INPUT               0x00000100
>> >  /* 0x00000200 reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
>> >  #define HID_QUIRK_ALWAYS_POLL                  0x00000400
>> > +#define HID_QUIRK_NO_GENERIC                   0x00000800
>> >  #define HID_QUIRK_SKIP_OUTPUT_REPORTS          0x00010000
>> >  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID                0x00020000
>> >  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP 0x00040000
>> > @@ -359,6 +360,7 @@ struct hid_item {
>> >  #define HID_GROUP_MULTITOUCH                   0x0002
>> >  #define HID_GROUP_SENSOR_HUB                   0x0003
>> >  #define HID_GROUP_MULTITOUCH_WIN_8             0x0004
>> > +#define HID_GROUP_GENERIC_OVERRIDE             0x0005
>> >
>> >  /*
>> >   * Vendor specific HID device groups
>> > --
>> > 2.16.2.804.g6dcf76e118-goog
>> >
<div class="gmail_extra"><br><div class="gmail_quote">On Thu, Mar 15,
2018 at 2:05 AM, Dmitry Torokhov <span dir="ltr">&lt;<a
href="mailto:dtor@chromium.org"
target="_blank">dtor@chromium.org</a>&gt;</span> wrote:<br><blockquote
class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc
solid;padding-left:1ex"><div class="HOEnZb"><div class="h5">On Wed,
Mar 14, 2018 at 9:16 AM, Benjamin Tissoires<br>
&lt;<a href="mailto:benjamin.tissoires@redhat.com">benjamin.tissoires@redhat.com</a><wbr>&gt;
wrote:<br>
&gt;<br>
&gt; Hi Nicolas,<br>
&gt;<br>
&gt; On Wed, Mar 14, 2018 at 6:22 AM, Nicolas Boichat &lt;<a
href="mailto:drinkcat@chromium.org">drinkcat@chromium.org</a>&gt;
wrote:<br>
&gt; &gt; From: Wei-Ning Huang &lt;<a
href="mailto:wnhuang@chromium.org">wnhuang@chromium.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Add Google hammer HID driver. This driver allow us to
control hammer<br>
&gt; &gt; keyboard backlight and support future features.<br>
&gt; &gt;<br>
&gt; &gt; We add a new HID quirk, that allows us to have the keyboard
interface<br>
&gt; &gt; to bind to google-hammer driver, while the touchpad interface can<br>
&gt; &gt; bind to the multitouch driver.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Wei-Ning Huang &lt;<a
href="mailto:wnhuang@google.com">wnhuang@google.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Nicolas Boichat &lt;<a
href="mailto:drinkcat@chromium.org">drinkcat@chromium.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;<br>
&gt; &gt; Changes since v3:<br>
&gt; &gt;&nbsp; - Rebase on latest linux-next/master, which moved the
quirk list from<br>
&gt; &gt;&nbsp; &nbsp; hid-core.c to hid-quirks.c. Also, completely
rework the logic to make<br>
&gt; &gt;&nbsp; &nbsp; it possible to bind google-hammer driver to
keyboard interface, and<br>
&gt; &gt;&nbsp; &nbsp; generic multitouch driver to touchpad
interface, as it is much simpler<br>
&gt; &gt;&nbsp; &nbsp; to do now that quirks are read early in
hid_add_device.<br>
&gt;<br>
&gt; Ouch, this logic seems too convoluted for me.<br>
&gt;<br>
&gt; Just to be sure:<br>
&gt; - some of your devices export 2 USB interfaces on the same device (so<br>
&gt; same VID/PID)<br>
&gt; - one of this interface should be handled by hid-multitouch<br>
&gt; - the other should be handled by hid-google-hammer<br>
&gt; - the purpose of the new quirk and HID class are to allow<br>
&gt; hid-google-hammer to only bind on the non multitouch interface<br>
&gt;<br>
&gt; Am I correct?<br>
&gt;<br>
&gt; If I am, given that we now don't need to blacklist the drivers for<br>
&gt; hid-generic since e04a0442d33b8cf183bba38646447b<wbr>891bb02123,
I do not<br>
&gt; understand why simply declaring&nbsp; "{ HID_DEVICE(BUS_USB,<br>
&gt; HID_GROUP_GENERIC,&nbsp; USB_VENDOR_ID_GOOGLE,
USB_DEVICE_ID_GOOGLE_HAMMER)<br>
&gt; }," (same for the 2 others) is not enough to have hid-google-hammer<br>
&gt; binding only on the non-multitouch interface.<br>
&gt;<br>
&gt; Could you please give a shot at it?<br>
&gt;<br>
<br>
</div></div>Ah, cool, if we now forcibly try to rebind devices from
generic HID to<br>
specialized driver when it appears, then we indeed to not have to do<br>
this dance with "overrides".<br>
<div class="HOEnZb"><div class="h5"><br>
&gt;<br>
&gt; &gt;&nbsp; - Add dynamic backlight detection support (only such
devices have an<br>
&gt; &gt;&nbsp; &nbsp; output HID descriptor).<br>
&gt; &gt;&nbsp; - Add support for wand (one more USB product ID).<br>
&gt; &gt;&nbsp; - Add SPDX-License-Identifier, fix one minor
formatting issue.<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; drivers/hid/Kconfig&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;|&nbsp; &nbsp;6 ++<br>
&gt; &gt;&nbsp; drivers/hid/Makefile&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; |&nbsp; &nbsp;1 +<br>
&gt; &gt;&nbsp; drivers/hid/hid-core.c&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; |&nbsp; &nbsp;4 ++<br>
&gt; &gt;&nbsp; drivers/hid/hid-google-hammer.<wbr>c | 116
++++++++++++++++++++++++++++++<wbr>++<br>
&gt; &gt;&nbsp; drivers/hid/hid-ids.h&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;|&nbsp; &nbsp;3 +<br>
&gt; &gt;&nbsp; drivers/hid/hid-quirks.c&nbsp; &nbsp; &nbsp; &nbsp;
|&nbsp; &nbsp;5 ++<br>
&gt; &gt;&nbsp; include/linux/hid.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;|&nbsp; &nbsp;2 +<br>
&gt; &gt;&nbsp; 7 files changed, 137 insertions(+)<br>
&gt; &gt;&nbsp; create mode 100644 drivers/hid/hid-google-hammer.<wbr>c<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig<br>
&gt; &gt; index 1fce4c94e5ac..60252fd796f6 100644<br>
&gt; &gt; --- a/drivers/hid/Kconfig<br>
&gt; &gt; +++ b/drivers/hid/Kconfig<br>
&gt; &gt; @@ -339,6 +339,12 @@ config HOLTEK_FF<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Say Y here if you
have a Holtek On Line Grip based game controller<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;and want to have
force feedback support for it.<br>
&gt; &gt;<br>
&gt; &gt; +config HID_GOOGLE_HAMMER<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;tristate "Google Hammer Keyboard"<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;depends on USB_HID &amp;&amp;
LEDS_CLASS<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;---help---<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;Say Y here if you have a Google
Hammer device.<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; config HID_GT683R<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tristate "MSI GT68xR LED support"<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;depends on LEDS_CLASS
&amp;&amp; USB_HID<br>
&gt; &gt; diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile<br>
&gt; &gt; index 713601c7bfa6..17a8bd97da9d 100644<br>
&gt; &gt; --- a/drivers/hid/Makefile<br>
&gt; &gt; +++ b/drivers/hid/Makefile<br>
&gt; &gt; @@ -45,6 +45,7 @@ obj-$(CONFIG_HID_ELO)&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;+= hid-elo.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_EZKEY)&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; += hid-ezkey.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_GEMBIRD)&nbsp; &nbsp; &nbsp; +=
hid-gembird.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_GFRM)&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;+= hid-gfrm.o<br>
&gt; &gt; +obj-$(CONFIG_HID_GOOGLE_<wbr>HAMMER)&nbsp; &nbsp; &nbsp;
&nbsp; += hid-google-hammer.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_GT683R)&nbsp; &nbsp; &nbsp; &nbsp;+=
hid-gt683r.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_GYRATION)&nbsp; &nbsp; &nbsp;+=
hid-gyration.o<br>
&gt; &gt;&nbsp; obj-$(CONFIG_HID_HOLTEK)&nbsp; &nbsp; &nbsp; &nbsp;+=
hid-holtek-kbd.o<br>
&gt; &gt; diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c<br>
&gt; &gt; index 36af26c2565b..61c7d135d680 100644<br>
&gt; &gt; --- a/drivers/hid/hid-core.c<br>
&gt; &gt; +++ b/drivers/hid/hid-core.c<br>
&gt; &gt; @@ -2116,6 +2116,10 @@ int hid_add_device(struct hid_device *hdev)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;ret = hid_scan_report(hdev);<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;if (ret)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hid_warn(hdev, "bad device
descriptor (%d)\n", ret);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(hdev-&gt;quirks &amp; HID_QUIRK_NO_GENERIC &amp;&amp;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hdev-&gt;group
== HID_GROUP_GENERIC)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;hdev-&gt;group =
HID_GROUP_GENERIC_OVERRIDE;<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* XXX hack, any other
cleaner solution after the driver core<br>
&gt; &gt; diff --git a/drivers/hid/hid-google-<wbr>hammer.c
b/drivers/hid/hid-google-<wbr>hammer.c<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 000000000000..e7ad042a8464<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/drivers/hid/hid-google-<wbr>hammer.c<br>
&gt; &gt; @@ -0,0 +1,116 @@<br>
&gt; &gt; +// SPDX-License-Identifier: GPL-2.0+<br>
&gt; &gt; +/*<br>
&gt; &gt; + *&nbsp; HID driver for Google Hammer device.<br>
&gt; &gt; + *<br>
&gt; &gt; + *&nbsp; Copyright (c) 2017 Google Inc.<br>
&gt; &gt; + *&nbsp; Author: Wei-Ning Huang &lt;<a
href="mailto:wnhuang@google.com">wnhuang@google.com</a>&gt;<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +/*<br>
&gt; &gt; + * This program is free software; you can redistribute it
and/or modify it<br>
&gt; &gt; + * under the terms of the GNU General Public License as
published by the Free<br>
&gt; &gt; + * Software Foundation; either version 2 of the License, or
(at your option)<br>
&gt; &gt; + * any later version.<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#include &lt;linux/hid.h&gt;<br>
&gt; &gt; +#include &lt;linux/leds.h&gt;<br>
&gt; &gt; +#include &lt;linux/module.h&gt;<br>
&gt; &gt; +#include &lt;linux/usb.h&gt;<br>
&gt;<br>
&gt; Generally that's a no from me to include usb.h. I'd rather have you<br>
&gt; decide on which interface to create the LEDs based on the report<br>
&gt; descriptors, so we can replay the device with uhid without crashing<br>
&gt; the kernel.<br>
&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +#include "hid-ids.h"<br>
&gt; &gt; +<br>
&gt; &gt; +#define MAX_BRIGHTNESS 100<br>
&gt; &gt; +<br>
&gt; &gt; +struct hammer_kbd_leds {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct led_classdev cdev;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct hid_device *hdev;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;u8 buf[2] ____cacheline_aligned;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static int hammer_kbd_brightness_set_<wbr>blocking(struct
led_classdev *cdev,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enum
led_brightness br)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct hammer_kbd_leds *led =
container_of(cdev,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
hammer_kbd_leds,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cdev);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;led-&gt;buf[0] = 0;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;led-&gt;buf[1] = br;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;ret =
hid_hw_output_report(led-&gt;<wbr>hdev, led-&gt;buf,
sizeof(led-&gt;buf));<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (ret == -ENOSYS)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret
= hid_hw_raw_request(led-&gt;hdev, 0, led-&gt;buf,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; sizeof(led-&gt;buf),<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; HID_OUTPUT_REPORT,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; HID_REQ_SET_REPORT);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;hid_err(led-&gt;hdev, "failed to set keyboard backlight:
%d\n",<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;ret);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static int hammer_register_leds(struct hid_device *hdev)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct hammer_kbd_leds *kbd_backlight;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;kbd_backlight =
devm_kzalloc(&amp;hdev-&gt;dev,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
sizeof(*kbd_backlight),<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
GFP_KERNEL);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (!kbd_backlight)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;return -ENOMEM;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;kbd_backlight-&gt;hdev = hdev;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;kbd_backlight-&gt;<a
href="http://cdev.name"
data-saferedirecturl="https://www.google.com/url?hl=en&amp;q=http://cdev.name&amp;source=gmail&amp;ust=1521158409163000&amp;usg=AFQjCNEh3tKanACY7TMM3ATXduCC0nKCtQ"
rel="noreferrer" target="_blank">cdev.name</a> =
"hammer::kbd_backlight";<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;
&nbsp;kbd_backlight-&gt;cdev.max_<wbr>brightness = MAX_BRIGHTNESS;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;
&nbsp;kbd_backlight-&gt;cdev.<wbr>brightness_set_blocking =<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;hammer_kbd_brightness_set_<wbr>blocking;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;kbd_backlight-&gt;cdev.flags =
LED_HW_PLUGGABLE;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;/* Set backlight to 0% initially. */<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;
&nbsp;hammer_kbd_brightness_set_<wbr>blocking(&amp;kbd_backlight-&gt;cdev,
0);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;return
devm_led_classdev_register(&amp;<wbr>hdev-&gt;dev,
&amp;kbd_backlight-&gt;cdev);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static int hammer_input_configured(struct hid_device *hdev,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
hid_input *hi)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct usb_interface *intf =
to_usb_interface(hdev-&gt;dev.<wbr>parent);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;struct list_head *report_list =<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;&amp;hdev-&gt;report_enum[HID_OUTPUT_<wbr>REPORT].report_list;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if
(intf-&gt;cur_altsetting-&gt;desc.<wbr>bInterfaceProtocol ==<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;USB_INTERFACE_PROTOCOL_<wbr>KEYBOARD &amp;&amp;
!list_empty(report_list)) {<br>
&gt;<br>
&gt; See above. I am pretty sure you can find something in the report<br>
&gt; descriptor to discriminate the LED capable device from the others.<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Benjamin<br>
&gt;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int
err = hammer_register_leds(hdev);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (err)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;hid_warn(hdev,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Failed to
register keyboard backlight: %d\n",<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static const struct hid_device_id hammer_devices[] = {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{ HID_DEVICE(BUS_USB,
HID_GROUP_GENERIC_OVERRIDE,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER)
},<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{ HID_DEVICE(BUS_USB,
HID_GROUP_GENERIC_OVERRIDE,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{ HID_DEVICE(BUS_USB,
HID_GROUP_GENERIC_OVERRIDE,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{ }<br>
&gt; &gt; +};<br>
&gt; &gt; +MODULE_DEVICE_TABLE(hid, hammer_devices);<br>
&gt; &gt; +<br>
&gt; &gt; +static struct hid_driver hammer_driver = {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;.name = "hammer",<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;.id_table = hammer_devices,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;.input_configured =
hammer_input_configured,<br>
&gt; &gt; +};<br>
&gt; &gt; +module_hid_driver(hammer_<wbr>driver);<br>
&gt; &gt; +<br>
&gt; &gt; +MODULE_LICENSE("GPL");<br>
&gt; &gt; diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h<br>
&gt; &gt; index 41f227a841fb..5a3a7ead3012 100644<br>
&gt; &gt; --- a/drivers/hid/hid-ids.h<br>
&gt; &gt; +++ b/drivers/hid/hid-ids.h<br>
&gt; &gt; @@ -448,7 +448,10 @@<br>
&gt; &gt;&nbsp; #define USB_DEVICE_ID_GOODTOUCH_000f&nbsp; &nbsp;0x000f<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; #define USB_VENDOR_ID_GOOGLE&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0x18d1<br>
&gt; &gt; +#define USB_DEVICE_ID_GOOGLE_HAMMER&nbsp; &nbsp; 0x5022<br>
&gt; &gt;&nbsp; #define USB_DEVICE_ID_GOOGLE_TOUCH_<wbr>ROSE&nbsp;
&nbsp; &nbsp; &nbsp; 0x5028<br>
&gt; &gt; +#define USB_DEVICE_ID_GOOGLE_STAFF&nbsp; &nbsp; &nbsp;0x502b<br>
&gt; &gt; +#define USB_DEVICE_ID_GOOGLE_WAND&nbsp; &nbsp; &nbsp; 0x502d<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; #define USB_VENDOR_ID_GOTOP&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; 0x08f2<br>
&gt; &gt;&nbsp; #define USB_DEVICE_ID_SUPER_Q2&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;0x007f<br>
&gt; &gt; diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c<br>
&gt; &gt; index 587e2681a53f..d112a14da200 100644<br>
&gt; &gt; --- a/drivers/hid/hid-quirks.c<br>
&gt; &gt; +++ b/drivers/hid/hid-quirks.c<br>
&gt; &gt; @@ -84,6 +84,11 @@ static const struct hid_device_id
hid_quirks[] = {<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>FREESCALE,
USB_DEVICE_ID_FREESCALE_MX28), HID_QUIRK_NOGET },<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>FUTABA, USB_DEVICE_ID_LED_DISPLAY),
HID_QUIRK_NO_INIT_REPORTS },<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>GREENASIA,
USB_DEVICE_ID_GREENASIA_DUAL_<wbr>USB_JOYPAD), HID_QUIRK_MULTI_INPUT
},<br>
&gt; &gt; +#if IS_ENABLED(CONFIG_HID_GOOGLE_<wbr>HAMMER)<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>GOOGLE,
USB_DEVICE_ID_GOOGLE_HAMMER), HID_QUIRK_NO_GENERIC },<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF),
HID_QUIRK_NO_GENERIC },<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>GOOGLE, USB_DEVICE_ID_GOOGLE_WAND),
HID_QUIRK_NO_GENERIC },<br>
&gt; &gt; +#endif<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>HAPP, USB_DEVICE_ID_UGCI_DRIVING),
HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>HAPP, USB_DEVICE_ID_UGCI_FIGHTING),
HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{
HID_USB_DEVICE(USB_VENDOR_ID_<wbr>HAPP, USB_DEVICE_ID_UGCI_FLYING),
HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },<br>
&gt; &gt; diff --git a/include/linux/hid.h b/include/linux/hid.h<br>
&gt; &gt; index dfea5a656a1a..f2655265f8b5 100644<br>
&gt; &gt; --- a/include/linux/hid.h<br>
&gt; &gt; +++ b/include/linux/hid.h<br>
&gt; &gt; @@ -340,6 +340,7 @@ struct hid_item {<br>
&gt; &gt;&nbsp; #define HID_QUIRK_NO_EMPTY_INPUT&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x00000100<br>
&gt; &gt;&nbsp; /* 0x00000200 reserved for backward compatibility, was
NO_INIT_INPUT_REPORTS */<br>
&gt; &gt;&nbsp; #define HID_QUIRK_ALWAYS_POLL&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x00000400<br>
&gt; &gt; +#define HID_QUIRK_NO_GENERIC&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x00000800<br>
&gt; &gt;&nbsp; #define HID_QUIRK_SKIP_OUTPUT_REPORTS&nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 0x00010000<br>
&gt; &gt;&nbsp; #define HID_QUIRK_SKIP_OUTPUT_REPORT_<wbr>ID&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x00020000<br>
&gt; &gt;&nbsp; #define HID_QUIRK_NO_OUTPUT_REPORTS_<wbr>ON_INTR_EP
0x00040000<br>
&gt; &gt; @@ -359,6 +360,7 @@ struct hid_item {<br>
&gt; &gt;&nbsp; #define HID_GROUP_MULTITOUCH&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0002<br>
&gt; &gt;&nbsp; #define HID_GROUP_SENSOR_HUB&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0003<br>
&gt; &gt;&nbsp; #define HID_GROUP_MULTITOUCH_WIN_8&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x0004<br>
&gt; &gt; +#define HID_GROUP_GENERIC_OVERRIDE&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x0005<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; /*<br>
&gt; &gt;&nbsp; &nbsp;* Vendor specific HID device groups<br>
&gt; &gt; --<br>
&gt; &gt; 2.16.2.804.g6dcf76e118-goog<br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div>
