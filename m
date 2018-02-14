Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030973AbeBNOpU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:45:20 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43563 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030822AbeBNOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:45:15 -0500
X-Google-Smtp-Source: AH8x225qvWZwczlyp05O7DgZUEQ85Cr77QsMpvKoLtu1OWWu+IY6sZXj5mu7Y6nGTBRRDNQrrPyZ/H2jRUCQUkBUJw8=
MIME-Version: 1.0
In-Reply-To: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 14 Feb 2018 15:45:14 +0100
Message-ID: <CAO-hwJKmrapd-VtbRgsM_zr6mHDvG8eyvdmo=56W_kmURjvX4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: add driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> There are two ways to connect the Steam Controller: directly to the USB
> or with the USB wireless adapter.  Both methods are similar, but the
> wireless adapter can connect up to 4 devices at the same time.
>
> The wired device will appear as 3 interfaces: a virtual mouse, a virtual
> keyboard and a custom HID device.
>
> The wireless device will appear as 5 interfaces: a virtual keyboard and
> 4 custom HID devices, that will remain silent until a device is actually
> connected.
>
> The custom HID device has a report descriptor with all vendor specific
> usages, so the hid-generic is not very useful. In a PC/SteamBox Valve
> Steam Client provices a software translation by using direct USB access
> and a creates a uinput virtual gamepad.

I think I had a look at this a while ago, and didn't want to interfere
with SteamOS regarding this. I think your patch should be fine in that
regard, but have you tried SteamOS on a kernel patched with your
series? Does it behave properly or will it break?

See more comments inlined.

>
> This driver was reverse engineered to provide direct kernel support in
> case you cannot, or do not want to, use Valve Steam Client. It disables
> the virtual keyboard and mouse, as they are not so useful when you have
> a working gamepad.
>
> Working: buttons, axes, pads, wireless connect/disconnect.
>
> TO-DO: Battery, force-feedback, accelerometer/gyro, led, beeper...
>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
>  drivers/hid/Kconfig      |   8 +
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-ids.h    |   4 +
>  drivers/hid/hid-quirks.c |   4 +
>  drivers/hid/hid-steam.c  | 480 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 497 insertions(+)
>  create mode 100644 drivers/hid/hid-steam.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 19c499f5623d..6e80fbf04e03 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -823,6 +823,14 @@ config HID_SPEEDLINK
>         ---help---
>         Support for Speedlink Vicious and Divine Cezanne mouse.
>
> +config HID_STEAM
> +       tristate "Steam Controller support"
> +       depends on HID
> +       ---help---
> +       Say Y here if you have a Steam Controller if you want to use it
> +       without running the Steam Client. It supports both the wired and
> +       the wireless adaptor.
> +
>  config HID_STEELSERIES
>         tristate "Steelseries SRW-S1 steering wheel support"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index eb13b9e92d85..60a8abf84682 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_HID_SAMSUNG)     += hid-samsung.o
>  obj-$(CONFIG_HID_SMARTJOYPLUS) += hid-sjoy.o
>  obj-$(CONFIG_HID_SONY)         += hid-sony.o
>  obj-$(CONFIG_HID_SPEEDLINK)    += hid-speedlink.o
> +obj-$(CONFIG_HID_STEAM)                += hid-steam.o
>  obj-$(CONFIG_HID_STEELSERIES)  += hid-steelseries.o
>  obj-$(CONFIG_HID_SUNPLUS)      += hid-sunplus.o
>  obj-$(CONFIG_HID_GREENASIA)    += hid-gaff.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 43ddcdfbd0da..be31a3c20818 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -988,6 +988,10 @@
>  #define USB_VENDOR_ID_STANTUM_SITRONIX         0x1403
>  #define USB_DEVICE_ID_MTP_SITRONIX             0x5001
>
> +#define USB_VENDOR_ID_VALVE                    0x28de
> +#define USB_DEVICE_ID_STEAM_CONTROLLER         0x1102
> +#define USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS        0x1142
> +
>  #define USB_VENDOR_ID_STEELSERIES      0x1038
>  #define USB_DEVICE_ID_STEELSERIES_SRWS1        0x1410
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 5f6035a5ce36..72ac972dc00b 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -629,6 +629,10 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  #if IS_ENABLED(CONFIG_HID_SPEEDLINK)
>         { HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
>  #endif
> +#if IS_ENABLED(CONFIG_HID_STEAM)
> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALVE, USB_DEVICE_ID_STEAM_CONTROLLER) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALVE, USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS) },
> +#endif
>  #if IS_ENABLED(CONFIG_HID_STEELSERIES)
>         { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
>  #endif
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> new file mode 100644
> index 000000000000..03f912ab5484
> --- /dev/null
> +++ b/drivers/hid/hid-steam.c
> @@ -0,0 +1,480 @@
> +// SPDX-License-Identifier: GPL-2.0

Non standard header

> +/*
> + * HID driver for Valve Steam Controller
> + *
> + * Supports both the wired and wireless interfaces.
> + *
> + * Copyright (c) 2018 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
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
> +#include <linux/input.h>
> +#include <linux/usb.h>

Generally, this raises a red flag from my side. HID should be
transport agnostic and depending on usb.h kills this. The advantage of
not depending on USB is that we can replay the devices with uhid in a
way it still works.

> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/workqueue.h>
> +#include "hid-ids.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>");
> +
> +#define STEAM_QUIRK_WIRELESS           BIT(0)
> +
> +struct steam_device {
> +       spinlock_t lock;
> +       struct hid_device *hid_dev;
> +       struct input_dev *input_dev;
> +       unsigned long quirks;
> +       struct work_struct work_connect;
> +       bool connected;
> +};
> +
> +static int steam_register(struct steam_device *steam);
> +static void steam_unregister(struct steam_device *steam);
> +static void steam_do_connect_event(struct steam_device *steam, bool connected);
> +static void steam_do_input_event(struct steam_device *steam, u8 *data);

We tend to generally not do forward declaration of functions in the
kernel. Unless really necessary.

> +
> +static int steam_input_open(struct input_dev *dev)
> +{
> +       struct steam_device *steam = input_get_drvdata(dev);
> +
> +       return hid_hw_open(steam->hid_dev);
> +}
> +
> +static void steam_input_close(struct input_dev *dev)
> +{
> +       struct steam_device *steam = input_get_drvdata(dev);
> +
> +       hid_hw_close(steam->hid_dev);
> +}
> +
> +static void steam_work_connect_cb(struct work_struct *work)
> +{
> +       struct steam_device *steam = container_of(work, struct steam_device,
> +                                                       work_connect);
> +       unsigned long flags;
> +       bool connected;
> +       int ret;
> +
> +       dbg_hid("%s\n", __func__);

This is pure debugging, and should be stripped out of the code (you
can use ftrace to see if your code is called BTW).

> +
> +       spin_lock_irqsave(&steam->lock, flags);
> +       connected = steam->connected;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       if (connected) {
> +               if (steam->input_dev) {
> +                       dbg_hid("%s: already connected\n", __func__);
> +                       return;
> +               }
> +               ret = steam_register(steam);
> +               if (ret) {
> +                       hid_err(steam->hid_dev,
> +                               "%s:steam_register returned error %d\n",
> +                               __func__, ret);
> +                       return;
> +               }
> +       } else {
> +               steam_unregister(steam);
> +       }
> +}
> +
> +static int steam_probe(struct hid_device *hdev,
> +                        const struct hid_device_id *id)
> +{
> +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +       struct steam_device *steam;
> +       int ret;
> +
> +       dbg_hid("%s called for ifnum %d protocol %d\n", __func__,
> +               intf->cur_altsetting->desc.bInterfaceNumber,
> +               intf->cur_altsetting->desc.bInterfaceProtocol
> +               );
> +
> +       /*
> +        * The wired device creates 3 interfaces:
> +        *  0: emulated mouse.
> +        *  1: emulated keyboard.
> +        *  2: the real game pad.
> +        * The wireless device creates 5 interfaces:
> +        *  0: emulated keyboard.
> +        *  1-4: slots where up to 4 real game pads will be connected to.
> +        * Instead of the interface index we use the protocol, it is 0
> +        * for the real game pad.
> +        * Since we have a real game pad now, we can ignore the virtual
> +        * mouse and keyboard.
> +        */
> +       if (intf->cur_altsetting->desc.bInterfaceProtocol != 0) {
> +               dbg_hid("%s: interface ignored\n", __func__);
> +               return -ENODEV;

As mentioned above, I'd rather you to decide on whether ignoring or
not the interface based on the actual reports, not the place in the
USB device. Valve can also decide to change their USB stack design,
and you'll have to amend this.

If you check that the reports ID you are expecting are not in the HID
device, you should be fine (hopefully)

> +       }
> +
> +       steam = kzalloc(sizeof(struct steam_device), GFP_KERNEL);

Please use devres to not have to free the memory on fail or on
disconnect (look for devm_kzalloc in the hid tree for examples).

> +       if (!steam)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&steam->lock);
> +       steam->hid_dev = hdev;
> +       hid_set_drvdata(hdev, steam);
> +       steam->quirks = id->driver_data;
> +       INIT_WORK(&steam->work_connect, steam_work_connect_cb);
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev,
> +                       "%s:parse of hid interface failed\n", __func__);
> +               goto hid_parse_fail;
> +       }
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev,
> +                       "%s:hid_hw_start returned error\n", __func__);
> +               goto hid_hw_start_fail;
> +       }
> +
> +       if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> +               steam->input_dev = NULL;

This seems superfluous

> +               ret = hid_hw_open(hdev);
> +               if (ret) {
> +                       hid_err(hdev,
> +                               "%s:hid_hw_open for wireless\n",
> +                               __func__);
> +                       goto hid_hw_open_fail;
> +               }
> +               hid_info(hdev, "Steam wireless receiver connected");
> +       } else {
> +               ret = steam_register(steam);
> +               if (ret) {
> +                       hid_err(hdev,
> +                               "%s:steam_register returned error\n",
> +                               __func__);
> +                       goto input_register_fail;
> +               }
> +       }
> +
> +       return 0;
> +
> +input_register_fail:
> +hid_hw_open_fail:
> +       hid_hw_stop(hdev);
> +hid_hw_start_fail:
> +hid_parse_fail:
> +       cancel_work_sync(&steam->work_connect);
> +       kfree(steam);
> +       hid_set_drvdata(hdev, NULL);
> +       return ret;
> +}
> +
> +static void steam_remove(struct hid_device *hdev)
> +{
> +       struct steam_device *steam = hid_get_drvdata(hdev);
> +
> +       dbg_hid("%s\n", __func__);

please remove

> +
> +       if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> +               hid_info(hdev, "Steam wireless receiver disconnected");
> +               hid_hw_close(hdev);
> +       }
> +       hid_hw_stop(hdev);
> +       steam_unregister(steam);

shouldn't you unregister the input nodes *after* cancelling the work
that might use it (haven't fully read the code, so it might be fine)

> +       cancel_work_sync(&steam->work_connect);
> +       kfree(steam);
> +       hid_set_drvdata(hdev, NULL);
> +}
> +
> +static int steam_raw_event(struct hid_device *hdev,
> +                            struct hid_report *report, u8 *data,
> +                            int size)
> +{
> +       struct steam_device *steam = hid_get_drvdata(hdev);
> +
> +       /*
> +        * All messages are size=64, all values little-endian.
> +        * The format is:
> +        *  Offset| Meaning
> +        * -------+--------------------------------------------
> +        *  0-1   | always 0x01, 0x00, maybe protocol version?

Offset 0 is usually the report ID.

> +        *  2     | type of message
> +        *  3     | length of the real payload (not checked)
> +        *  4-n   | payload data, depends on the type
> +        *
> +        * There are these known types of message:
> +        *  0x01: input data (60 bytes)
> +        *  0x03: wireless connect/disconnect (1 byte)
> +        *  0x04: battery status (11 bytes)
> +        */
> +
> +       if (size != 64 || data[0] != 1 || data[1] != 0)
> +               return 0;
> +
> +       switch (data[2]) {
> +       case 0x01:
> +               steam_do_input_event(steam, data);
> +               break;
> +       case 0x03:
> +               /*
> +                * The payload of this event is a single byte:
> +                *  0x01: disconnected.
> +                *  0x02: connected.
> +                */
> +               switch (data[4]) {
> +               case 0x01:
> +                       steam_do_connect_event(steam, false);
> +                       break;
> +               case 0x02:
> +                       steam_do_connect_event(steam, true);
> +                       break;
> +               }
> +               break;
> +       case 0x04:
> +               /* TODO battery status */
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static void steam_do_connect_event(struct steam_device *steam, bool connected)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&steam->lock, flags);
> +       steam->connected = connected;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       if (schedule_work(&steam->work_connect) == 0)
> +               dbg_hid("%s: connected=%d event already queued\n",
> +                               __func__, connected);
> +}
> +
> +/* The size for this message payload is 60.

The beginning of the comment should be on its own line:
/*
 * The size ...

> + * The known values are:
> + *  (* values are not sent through wireless)
> + *  (* accelerator/gyro is disabled by default)
> + *  Offset| Type  | Mapped to |Meaning
> + * -------+-------+-----------+--------------------------
> + *  4-7   | u32   | --        | sequence number
> + *  8-10  | 24bit | see below | buttons
> + *  11    | u8    | ABS_Z     | left trigger
> + *  12    | u8    | ABS_RZ    | right trigger
> + *  13-15 | --    | --        | always 0
> + *  16-17 | s16   | ABS_X     | X value
> + *  18-19 | s16   | ABS_Y     | Y value
> + *  20-21 | s16   | ABS_RX    | right-pad X value
> + *  22-23 | s16   | ABS_RY    | right-pad Y value
> + *  24-25 | s16   | --        | * left trigger
> + *  26-27 | s16   | --        | * right trigger
> + *  28-29 | s16   | --        | * accelerometer X value
> + *  30-31 | s16   | --        | * accelerometer Y value
> + *  32-33 | s16   | --        | * accelerometer Z value
> + *  34-35 | s16   | --        | gyro X value
> + *  36-36 | s16   | --        | gyro Y value
> + *  38-39 | s16   | --        | gyro Z value
> + *  40-41 | s16   | --        | quaternion W value
> + *  42-43 | s16   | --        | quaternion X value
> + *  44-45 | s16   | --        | quaternion Y value
> + *  46-47 | s16   | --        | quaternion Z value
> + *  48-49 | --    | --        | always 0
> + *  50-51 | s16   | --        | * left trigger (uncalibrated)
> + *  52-53 | s16   | --        | * right trigger (uncalibrated)
> + *  54-55 | s16   | --        | * joystick X value (uncalibrated)
> + *  56-57 | s16   | --        | * joystick Y value (uncalibrated)
> + *  58-59 | s16   | --        | * left-pad X value
> + *  60-61 | s16   | --        | * left-pad Y value
> + *  62-63 | u16   | --        | * battery voltage
> + *
> + * The buttons are:
> + *  Bit  | Mapped to  | Description
> + * ------+------------+--------------------------------
> + *  8.0  | BTN_TR2    | right trigger fully pressed
> + *  8.1  | BTN_TL2    | left trigger fully pressed
> + *  8.2  | BTN_TR     | right shoulder
> + *  8.3  | BTN_TL     | left shoulder
> + *  8.4  | BTN_Y      | button Y
> + *  8.5  | BTN_B      | button B
> + *  8.6  | BTN_X      | button X
> + *  8.7  | BTN_A      | button A
> + *  9.0  | -ABS_HAT0Y | lef-pad up
> + *  9.1  | +ABS_HAT0X | lef-pad right
> + *  9.2  | -ABS_HAT0X | lef-pad left
> + *  9.3  | +ABS_HAT0Y | lef-pad down
> + *  9.4  | BTN_SELECT | menu left
> + *  9.5  | BTN_MODE   | steam logo
> + *  9.6  | BTN_START  | menu right
> + *  9.7  | BTN_GEAR_DOWN | left back lever
> + * 10.0  | BTN_GEAR_UP   | right back lever
> + * 10.1  | --         | left-pad clicked
> + * 10.2  | BTN_THUMBR | right-pad clicked
> + * 10.3  | --         | left-pad touched
> + * 10.4  | --         | right-pad touched
> + * 10.5  | --         | unknown
> + * 10.6  | BTN_THUMBL | joystick clicked
> + * 10.7  | --         | lpad_and_joy
> + */
> +
> +static void steam_do_input_event(struct steam_device *steam, u8 *data)
> +{
> +       struct input_dev *input = steam->input_dev;
> +
> +       /* 24 bits of buttons */
> +       u8 b8, b9, b10;
> +
> +       /*
> +        * If we get input events from the wireless without a 'connected'
> +        * event, just connect it now.
> +        * This can happen, for example, if we bind the HID device with
> +        * the controller already paired.
> +        */
> +       if (unlikely(!input)) {
> +               dbg_hid("%s: input data without connect event\n", __func__);
> +               steam_do_connect_event(steam, true);
> +               return;
> +       }
> +
> +       input_report_abs(input, ABS_Z, data[11]);
> +       input_report_abs(input, ABS_RZ, data[12]);
> +
> +       input_report_abs(input, ABS_X,
> +                       (s16) le16_to_cpup((__le16 *)(data + 16)));
> +       input_report_abs(input, ABS_Y,
> +                       -(s16) le16_to_cpup((__le16 *)(data + 18)));
> +       input_report_abs(input, ABS_RX,
> +                       (s16) le16_to_cpup((__le16 *)(data + 20)));
> +       input_report_abs(input, ABS_RY,
> +                       -(s16) le16_to_cpup((__le16 *)(data + 22)));
> +
> +       b8 = data[8];
> +       b9 = data[9];
> +       b10 = data[10];
> +
> +       input_event(input, EV_KEY, BTN_TR2, !!(b8 & 0x01));
> +       input_event(input, EV_KEY, BTN_TL2, !!(b8 & 0x02));
> +       input_event(input, EV_KEY, BTN_TR, !!(b8 & 0x04));
> +       input_event(input, EV_KEY, BTN_TL, !!(b8 & 0x08));
> +       input_event(input, EV_KEY, BTN_Y, !!(b8 & 0x10));
> +       input_event(input, EV_KEY, BTN_B, !!(b8 & 0x20));
> +       input_event(input, EV_KEY, BTN_X, !!(b8 & 0x40));
> +       input_event(input, EV_KEY, BTN_A, !!(b8 & 0x80));
> +       input_event(input, EV_KEY, BTN_SELECT, !!(b9 & 0x10));
> +       input_event(input, EV_KEY, BTN_MODE, !!(b9 & 0x20));
> +       input_event(input, EV_KEY, BTN_START, !!(b9 & 0x40));
> +       input_event(input, EV_KEY, BTN_GEAR_DOWN, !!(b9 & 0x80));
> +       input_event(input, EV_KEY, BTN_GEAR_UP, !!(b10 & 0x01));
> +       input_event(input, EV_KEY, BTN_THUMBR, !!(b10 & 0x04));
> +       input_event(input, EV_KEY, BTN_THUMBL, !!(b10 & 0x40));
> +
> +       input_report_abs(input, ABS_HAT0X,
> +                !!(b9 & 0x02) - !!(b9 & 0x04));
> +       input_report_abs(input, ABS_HAT0Y,
> +                !!(b9 & 0x08) - !!(b9 & 0x01));
> +
> +       input_sync(input);
> +}
> +
> +static int steam_register(struct steam_device *steam)
> +{
> +       struct hid_device *hdev = steam->hid_dev;
> +       struct input_dev *input;
> +       int ret;
> +
> +       dbg_hid("%s\n", __func__);

please remove

> +
> +       hid_info(hdev, "Steam Controller connected");
> +
> +       input = input_allocate_device();

Don't you need one input node per wireless gamepad too?

> +       if (!input)
> +               return -ENOMEM;
> +
> +       input_set_drvdata(input, steam);
> +       input->dev.parent = &hdev->dev;
> +       input->open = steam_input_open;
> +       input->close = steam_input_close;
> +
> +       input->name = "Steam Controller";

In case of the wireless controllers, you might want to personalize this a bit.

> +       input->phys = hdev->phys;
> +       input->uniq = hdev->uniq;
> +       input->id.bustype = hdev->bus;
> +       input->id.vendor  = hdev->vendor;
> +       input->id.product = hdev->product;
> +       input->id.version = hdev->version;
> +
> +       input_set_capability(input, EV_KEY, BTN_TR2);
> +       input_set_capability(input, EV_KEY, BTN_TL2);
> +       input_set_capability(input, EV_KEY, BTN_TR);
> +       input_set_capability(input, EV_KEY, BTN_TL);
> +       input_set_capability(input, EV_KEY, BTN_Y);
> +       input_set_capability(input, EV_KEY, BTN_B);
> +       input_set_capability(input, EV_KEY, BTN_X);
> +       input_set_capability(input, EV_KEY, BTN_A);
> +       input_set_capability(input, EV_KEY, BTN_SELECT);
> +       input_set_capability(input, EV_KEY, BTN_MODE);
> +       input_set_capability(input, EV_KEY, BTN_START);
> +       input_set_capability(input, EV_KEY, BTN_GEAR_DOWN);
> +       input_set_capability(input, EV_KEY, BTN_GEAR_UP);
> +       input_set_capability(input, EV_KEY, BTN_THUMBR);
> +       input_set_capability(input, EV_KEY, BTN_THUMBL);
> +
> +       input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
> +       input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
> +       input_set_abs_params(input, ABS_X, -32767, 32767, 0, 0);
> +       input_set_abs_params(input, ABS_Y, -32767, 32767, 0, 0);

You are also probably missing the resolution bits. We need to
accurately report the physical dimensions to the user space (thanks to
the resolution)

> +       input_set_abs_params(input, ABS_RX, -32767, 32767, 0, 0);
> +       input_set_abs_params(input, ABS_RY, -32767, 32767, 0, 0);

What do RX/RY correspond to?

> +       input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
> +       input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
> +
> +       ret = input_register_device(input);
> +       if (ret)
> +               goto input_register_fail;
> +
> +       steam->input_dev = input;
> +
> +       return 0;
> +
> +input_register_fail:
> +       input_free_device(input);
> +       return ret;
> +}
> +
> +static void steam_unregister(struct steam_device *steam)
> +{
> +       dbg_hid("%s\n", __func__);

please remove

> +
> +       if (steam->input_dev) {
> +               hid_info(steam->hid_dev, "Steam Controller disconnected");
> +               input_unregister_device(steam->input_dev);
> +               steam->input_dev = NULL;
> +       }
> +}
> +
> +static const struct hid_device_id steam_controllers[] = {
> +       { /* Wired Steam Controller */
> +         HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
> +               USB_DEVICE_ID_STEAM_CONTROLLER)
> +       },
> +       { /* Wireless Steam Controller */
> +         HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
> +               USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS),
> +         .driver_data = STEAM_QUIRK_WIRELESS
> +       },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(hid, steam_controllers);
> +
> +static struct hid_driver steam_controller_driver = {
> +       .name = "hid-steam",
> +       .id_table = steam_controllers,
> +       .probe = steam_probe,
> +       .remove = steam_remove,
> +       .raw_event = steam_raw_event,
> +};
> +
> +module_hid_driver(steam_controller_driver);
> +/* vi: set softtabstop=8 shiftwidth=8 noexpandtab tabstop=8: */

Non standard comment, useful, but we strip out these in upstream

Anyway. Thanks for the driver, there are a few bits to fix, nothing
scary though.

Cheers,
Benjamin

> --
> 2.16.1
>
