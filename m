Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCER0u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:26:50 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:38696 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeCER0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:26:46 -0500
X-Google-Smtp-Source: AG47ELub/ZTnD3IIbjr9WRodl0bGIIUxfEGhB/Q3unMnmQSk9eE+pL6v98azq/YXYRYoLuZ0DaZLYOZWHCj+QQINuM8=
MIME-Version: 1.0
In-Reply-To: <CAE7qMrpF4dGCUrtnXbxb4MLFPZ0Wf13mrQEPypwPbEHaB9e44A@mail.gmail.com>
References: <20180304170004.26553-1-contact@florentflament.com>
 <20180304221425.28611-1-contact@florentflament.com> <20180304221425.28611-2-contact@florentflament.com>
 <CAE7qMrpF4dGCUrtnXbxb4MLFPZ0Wf13mrQEPypwPbEHaB9e44A@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 5 Mar 2018 18:26:45 +0100
Message-ID: <CAO-hwJK=LVZXU5M1CxRvm43TzL7qVqNNepwT2qrriMnCS3akeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] HID: Logitech K290: Add driver for the Logitech
 K290 USB keyboard
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Florent Flament <contact@florentflament.com>,
        andy.shevchenko@gmail.com, Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florent,

On Mon, Mar 5, 2018 at 10:31 AM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> Hello Florent,
>
> In my view, this driver may not be a good idea. The default behaviour
> of K290 is 'send multimedia keycodes' with the user given the choice
> to change that behaviour via vendor commands. Putting a driver that
> will unconditionally change that behaviour without the user's consent
> might bother other users that prefer the multimedia keycodes by
> default.
>
> Besides, I'd argue that instead of a kernel module this would be best
> achieved from a user space application. Something in the lines of
> Solaar (github pwr/solaar) or libratbag (there's an issue open to
> support keyboards) or even a specific application built for the
> purpose. Anyways, please collect the input from Benjamin and Jiri as
> they as they best placed to advise than myself.

On top of what Nestor said, this type of functionality, if we want to
have them in the kernel should probably be integrated in
hid-logitech-hidpp, in order not having some magic reports to send.

Things like reconnect of the device would be handled far more easily
in hid-logitech-hidpp while you would be reinventing the wheel here.

One other thing I do not like in this submission of the driver is the
direct use of USB while we have a full transport agnostic layer called
HID.

Cheers,
Benjamin

>
> Cheers,
> -nestor
>
> On Sun, Mar 4, 2018 at 11:14 PM, Florent Flament
> <contact@florentflament.com> wrote:
>> With the generic HID driver, K290 keyboards' F1 to F12 keys send
>> multimedia events by default, and standard keycodes when the function
>> key is pressed. This driver allows to configure K290 keyboards, so
>> that F1 to F12 have a standard behavior and send multimedia events
>> when the function key is pressed. The keyboard mode is set through the
>> fn_mode module parameter: when set to 1 (default setting) the keyboard
>> behaves as with the generic HID driver, when set to 0 the keyboard is
>> configured to work as standard keyboards.
>>
>> Signed-off-by: Florent Flament <contact@florentflament.com>
>> ---
>>  drivers/hid/Kconfig             |  18 ++++++++
>>  drivers/hid/Makefile            |   1 +
>>  drivers/hid/hid-ids.h           |   1 +
>>  drivers/hid/hid-logitech-k290.c | 100 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 120 insertions(+)
>>  create mode 100644 drivers/hid/hid-logitech-k290.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 19c499f5623d..6686da8daac6 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -488,6 +488,24 @@ config HID_LOGITECH_HIDPP
>>         T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
>>         Keyboard).
>>
>> +config HID_LOGITECH_K290
>> +       tristate "Logitech K290 Keyboard support"
>> +       depends on USB_HID
>> +       ---help---
>> +       This enhances support of Logitech K290 keyboards.
>> +
>> +       With the generic HID driver, K290 keyboards' F1 to F12 keys
>> +       send multimedia events by default, and standard keycodes when
>> +       the function key is pressed. This driver allows to configure
>> +       K290 keyboards, so that F1 to F12 have a standard behavior and
>> +       send multimedia events when the function key is pressed. The
>> +       keyboard mode is set through the fn_mode module parameter:
>> +       when set to 1 (default setting) the keyboard behaves as with
>> +       the generic HID driver, when set to 0 the keyboard is
>> +       configured to work as standard keyboards.
>> +
>> +       Say Y if you have a Logitech K290 keyboard.
>> +
>>  config LOGITECH_FF
>>         bool "Logitech force feedback support"
>>         depends on HID_LOGITECH
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index eb13b9e92d85..78079d3a5d58 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -61,6 +61,7 @@ obj-$(CONFIG_HID_LENOVO)      += hid-lenovo.o
>>  obj-$(CONFIG_HID_LOGITECH)     += hid-logitech.o
>>  obj-$(CONFIG_HID_LOGITECH_DJ)  += hid-logitech-dj.o
>>  obj-$(CONFIG_HID_LOGITECH_HIDPP)       += hid-logitech-hidpp.o
>> +obj-$(CONFIG_HID_LOGITECH_K290)        += hid-logitech-k290.o
>>  obj-$(CONFIG_HID_MAGICMOUSE)   += hid-magicmouse.o
>>  obj-$(CONFIG_HID_MAYFLASH)     += hid-mf.o
>>  obj-$(CONFIG_HID_MICROSOFT)    += hid-microsoft.o
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 9454ac134ce2..68caba7e666c 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -693,6 +693,7 @@
>>  #define USB_DEVICE_ID_LOGITECH_HARMONY_LAST 0xc14f
>>  #define USB_DEVICE_ID_LOGITECH_HARMONY_PS3 0x0306
>>  #define USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS 0xc24d
>> +#define USB_DEVICE_ID_LOGITECH_KEYBOARD_K290   0xc31f
>>  #define USB_DEVICE_ID_LOGITECH_MOUSE_C01A      0xc01a
>>  #define USB_DEVICE_ID_LOGITECH_MOUSE_C05A      0xc05a
>>  #define USB_DEVICE_ID_LOGITECH_MOUSE_C06A      0xc06a
>> diff --git a/drivers/hid/hid-logitech-k290.c b/drivers/hid/hid-logitech-k290.c
>> new file mode 100644
>> index 000000000000..36fdb5838842
>> --- /dev/null
>> +++ b/drivers/hid/hid-logitech-k290.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HID driver for Logitech K290 keyboard
>> + *
>> + * Copyright (c) 2018 Florent Flament
>> + *
>> + * This drivers allows to configure the K290 keyboard's function key
>> + * behaviour (whether function mode is activated or not by default).
>> + *
>> + * Logitech custom commands taken from Marcus Ilgner k290-fnkeyctl
>> + * (https://github.com/milgner/k290-fnkeyctl):
>> + * K290_SET_FUNCTION_CMD
>> + * K290_SET_FUNCTION_VAL
>> + * K290_SET_FUNCTION_OFF
>> + * K290_SET_FUNCTION_ON
>> + *
>> + * Based on hid-accutouch.c and hid-elo.c
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/hid.h>
>> +#include <linux/module.h>
>> +#include <linux/stat.h>
>> +#include <linux/types.h>
>> +#include <linux/usb.h>
>> +
>> +#include "hid-ids.h"
>> +#include "usbhid/usbhid.h"
>> +
>> +// Logitech K290 custom USB command and value to setup function key
>> +#define K290_SET_FUNCTION_CMD 0x02
>> +#define K290_SET_FUNCTION_VAL 0x001a
>> +
>> +// Have function mode turned off (as with standard keyboards)
>> +#define K290_SET_FUNCTION_OFF 0x0001
>> +// Have function mode turned on (default k290 behavior)
>> +#define K290_SET_FUNCTION_ON  0x0000
>> +
>> +// Function key default mode is set at module load time for every K290
>> +// keyboards plugged on the machine. By default fn_mode = 1, i.e
>> +// sending K290_SET_FUNCTION_ON (default K290 behavior).
>> +static bool fn_mode = 1;
>> +module_param(fn_mode, bool, 0444);
>> +MODULE_PARM_DESC(fn_mode, "Logitech K290 function key mode (default = 1)");
>> +
>> +static void k290_set_function(struct usb_device *dev, uint16_t function_mode)
>> +{
>> +       int ret;
>> +
>> +       ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>> +                             K290_SET_FUNCTION_CMD,
>> +                             USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>> +                             K290_SET_FUNCTION_VAL,
>> +                             function_mode, 0, 0, USB_CTRL_SET_TIMEOUT);
>> +
>> +       if (ret < 0)
>> +               dev_err(&dev->dev,
>> +                       "Failed to setup K290 function key, error %d\n", ret);
>> +}
>> +
>> +static int k290_set_function_hid_device(struct hid_device *hid)
>> +{
>> +       struct usb_device *usb_dev = hid_to_usb_dev(hid);
>> +
>> +       k290_set_function(usb_dev,
>> +                       fn_mode ? K290_SET_FUNCTION_ON : K290_SET_FUNCTION_OFF);
>> +       return 0;
>> +}
>> +
>> +static int k290_input_configured(struct hid_device *hid,
>> +                                struct hid_input *hidinput)
>> +{
>> +       return k290_set_function_hid_device(hid);
>> +}
>> +
>> +static int k290_resume(struct hid_device *hid)
>> +{
>> +       return k290_set_function_hid_device(hid);
>> +}
>> +
>> +static const struct hid_device_id k290_devices[] = {
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>> +                        USB_DEVICE_ID_LOGITECH_KEYBOARD_K290) },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(hid, k290_devices);
>> +
>> +static struct hid_driver k290_driver = {
>> +       .name = "hid-logitech-k290",
>> +       .id_table = k290_devices,
>> +       .input_configured = k290_input_configured,
>> +       .resume = k290_resume,
>> +       .reset_resume = k290_resume,
>> +};
>> +
>> +module_hid_driver(k290_driver);
>> +
>> +MODULE_AUTHOR("Florent Flament <contact@florentflament.com>");
>> +MODULE_DESCRIPTION("Logitech K290 keyboard driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.14.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
