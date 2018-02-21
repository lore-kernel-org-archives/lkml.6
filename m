Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937453AbeBUON7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:13:59 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34813 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935305AbeBUONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:13:54 -0500
X-Google-Smtp-Source: AH8x226AoSgtV2rUdichevY9vU1esmze5RP2k9Rx7uUv4llzJPBv9rMbH5B1c8FQBtCncTWKItchbZv/3BRDxqBEQPQ=
MIME-Version: 1.0
In-Reply-To: <20180220193306.28748-2-rodrigorivascosta@gmail.com>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com> <20180220193306.28748-2-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 21 Feb 2018 15:13:53 +0100
Message-ID: <CAO-hwJJ8mhTCJ3xnEO3Vi6FeY-5=uHG9yN+BYbWe0sa2VD1siw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] HID: add driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 8:33 PM, Rodrigo Rivas Costa
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
>  drivers/hid/hid-steam.c  | 478 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 495 insertions(+)
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

In addition to the discussion in 0/3, I wonder if you should not
remove this hunk. Unless having hid-generic binding the device before
your hid-steam driver, it would be better not force the Steam boxes to
use your driver.

I'll sneak in the discussion in 0/3.

Cheers,
Benjamin

>  #if IS_ENABLED(CONFIG_HID_STEELSERIES)
>         { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
>  #endif
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> new file mode 100644
> index 000000000000..7b2f16b7bb49
> --- /dev/null
> +++ b/drivers/hid/hid-steam.c
> @@ -0,0 +1,478 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for Valve Steam Controller
> + *
> + * Supports both the wired and wireless interfaces.
> + *
> + * Copyright (c) 2018 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
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
> +/* Touch pads are 40 mm in diameter and 65535 units */
> +#define STEAM_PAD_RESOLUTION 1638
> +/* Trigger runs are about 5 mm and 256 units */
> +#define STEAM_TRIGGER_RESOLUTION 51
> +
> +struct steam_device {
> +       spinlock_t lock;
> +       struct hid_device *hdev;
> +       struct input_dev *input;
> +       unsigned long quirks;
> +       struct work_struct work_connect;
> +       bool connected;
> +};
> +
> +static int steam_input_open(struct input_dev *dev)
> +{
> +       struct steam_device *steam = input_get_drvdata(dev);
> +
> +       return hid_hw_open(steam->hdev);
> +}
> +
> +static void steam_input_close(struct input_dev *dev)
> +{
> +       struct steam_device *steam = input_get_drvdata(dev);
> +
> +       hid_hw_close(steam->hdev);
> +}
> +
> +static int steam_register(struct steam_device *steam)
> +{
> +       struct hid_device *hdev = steam->hdev;
> +       struct input_dev *input;
> +       int ret;
> +
> +       hid_info(hdev, "Steam Controller connected");
> +
> +       input = input_allocate_device();
> +       if (!input)
> +               return -ENOMEM;
> +
> +       input_set_drvdata(input, steam);
> +       input->dev.parent = &hdev->dev;
> +       input->open = steam_input_open;
> +       input->close = steam_input_close;
> +
> +       input->name = (steam->quirks & STEAM_QUIRK_WIRELESS) ?
> +               "Wireless Steam Controller" :
> +               "Steam Controller";
> +       input->phys = hdev->phys;
> +       input->uniq = hdev->uniq;
> +       input->id.bustype = hdev->bus;
> +       input->id.vendor = hdev->vendor;
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
> +       input_set_abs_params(input, ABS_RX, -32767, 32767, 0, 0);
> +       input_set_abs_params(input, ABS_RY, -32767, 32767, 0, 0);
> +       input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
> +       input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
> +       input_abs_set_res(input, ABS_X, STEAM_PAD_RESOLUTION);
> +       input_abs_set_res(input, ABS_Y, STEAM_PAD_RESOLUTION);
> +       input_abs_set_res(input, ABS_RX, STEAM_PAD_RESOLUTION);
> +       input_abs_set_res(input, ABS_RY, STEAM_PAD_RESOLUTION);
> +       input_abs_set_res(input, ABS_Z, STEAM_TRIGGER_RESOLUTION);
> +       input_abs_set_res(input, ABS_RZ, STEAM_TRIGGER_RESOLUTION);
> +
> +       ret = input_register_device(input);
> +       if (ret)
> +               goto input_register_fail;
> +
> +       steam->input = input;
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
> +       if (steam->input) {
> +               hid_info(steam->hdev, "Steam Controller disconnected");
> +               input_unregister_device(steam->input);
> +               steam->input = NULL;
> +       }
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
> +       spin_lock_irqsave(&steam->lock, flags);
> +       connected = steam->connected;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       if (connected) {
> +               if (steam->input) {
> +                       dbg_hid("%s: already connected\n", __func__);
> +                       return;
> +               }
> +               ret = steam_register(steam);
> +               if (ret) {
> +                       hid_err(steam->hdev,
> +                               "%s:steam_register failed with error %d\n",
> +                               __func__, ret);
> +                       return;
> +               }
> +       } else {
> +               steam_unregister(steam);
> +       }
> +}
> +
> +static bool steam_is_valve_interface(struct hid_device *hdev)
> +{
> +       struct hid_report_enum *rep_enum;
> +       struct hid_report *hreport;
> +
> +       /*
> +        * The wired device creates 3 interfaces:
> +        *  0: emulated mouse.
> +        *  1: emulated keyboard.
> +        *  2: the real game pad.
> +        * The wireless device creates 5 interfaces:
> +        *  0: emulated keyboard.
> +        *  1-4: slots where up to 4 real game pads will be connected to.
> +        * We know which one is the real gamepad interface because they are the
> +        * only ones with a feature report.
> +        */
> +       rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
> +       list_for_each_entry(hreport, &rep_enum->report_list, list) {
> +               /* should we check hreport->id == 0? */
> +               return true;
> +       }
> +       return false;
> +}
> +
> +static int steam_probe(struct hid_device *hdev,
> +                               const struct hid_device_id *id)
> +{
> +       struct steam_device *steam;
> +       int ret;
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev,
> +                       "%s:parse of hid interface failed\n", __func__);
> +               return ret;
> +       }
> +
> +       /*
> +        * Since we have a proper gamepad now, we can ignore the virtual
> +        * mouse and keyboard.
> +        */
> +       if (!steam_is_valve_interface(hdev))
> +               return -ENODEV;
> +
> +       steam = devm_kzalloc(&hdev->dev,
> +                       sizeof(struct steam_device), GFP_KERNEL);
> +       if (!steam)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&steam->lock);
> +       steam->hdev = hdev;
> +       hid_set_drvdata(hdev, steam);
> +       steam->quirks = id->driver_data;
> +       INIT_WORK(&steam->work_connect, steam_work_connect_cb);
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev,
> +                       "%s:hid_hw_start failed with error %d\n",
> +                       __func__, ret);
> +               goto hid_hw_start_fail;
> +       }
> +
> +       if (steam->quirks & STEAM_QUIRK_WIRELESS) {
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
> +                               "%s:steam_register failed with error %d\n",
> +                               __func__, ret);
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
> +       cancel_work_sync(&steam->work_connect);
> +       hid_set_drvdata(hdev, NULL);
> +       return ret;
> +}
> +
> +static void steam_remove(struct hid_device *hdev)
> +{
> +       struct steam_device *steam = hid_get_drvdata(hdev);
> +
> +       if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> +               hid_info(hdev, "Steam wireless receiver disconnected");
> +               hid_hw_close(hdev);
> +       }
> +       hid_hw_stop(hdev);
> +       cancel_work_sync(&steam->work_connect);
> +       steam_unregister(steam);
> +       hid_set_drvdata(hdev, NULL);
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
> +/*
> + * The size for this message payload is 60.
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
> +       struct input_dev *input = steam->input;
> +
> +       /* 24 bits of buttons */
> +       u8 b8, b9, b10;
> +
> +       /*
> +        * If we get input events from the wireless without a 'connected'
> +        * event, just connect it now.
> +        * This can happen if we bind the HID device with the controller
> +        * already paired.
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
> +                       !!(b9 & 0x02) - !!(b9 & 0x04));
> +       input_report_abs(input, ABS_HAT0Y,
> +                       !!(b9 & 0x08) - !!(b9 & 0x01));
> +
> +       input_sync(input);
> +}
> +
> +static int steam_raw_event(struct hid_device *hdev,
> +                       struct hid_report *report, u8 *data,
> +                       int size)
> +{
> +       struct steam_device *steam = hid_get_drvdata(hdev);
> +
> +       /*
> +        * All messages are size=64, all values little-endian.
> +        * The format is:
> +        *  Offset| Meaning
> +        * -------+--------------------------------------------
> +        *  0-1   | always 0x01, 0x00, maybe protocol version?
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
> --
> 2.16.1
>
