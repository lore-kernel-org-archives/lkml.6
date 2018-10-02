Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD9320878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD9320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJBPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:35:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43702 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeJBPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:35:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so1003093ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EuhD9Yc6xEmmfAvRqthGUEqkAHY4pf10lBaTsXY99g=;
        b=Jju3rbNdjLKcG772O6xNh+6HRF1CCWZ9vzfGSDf4G/o/mmvc3rXwqJGfs+uwWPzVZA
         H8XQwIkMg4W/7OH8rb8isiKArnEZ2+lj5Juwxub/ogfBiqZ2jystb1SLDDykjcGUcLsQ
         3/h90yx8vePPgH7Gy3mjjwEwqVgFQP7dgQB3VtmNk77U9+9CroCBlDAYca9EN5iK2iig
         hD4sMa9atiiFMEYNti9sJo22ZmfAfQAUPaVR2mU/WZz3SHg///lVg3IpNQUboDNCZ8SL
         iHQTfkXP9aSthBAcCTZfBrvbsPakCTpr/ZGRGIsKtBu3zm6UdYfN19R3EtjEaRl4yNS+
         yz6g==
X-Gm-Message-State: ABuFfohGccCrwfDTbufoPT+zX6xqx8PTwsUfCIUkt8dMA1zfGPmRhAIj
        nBhLdcQWFw0U+tlQhSylMY1gj6kuvGGBOAh+3pXpFQ==
X-Google-Smtp-Source: ACcGV617gpzL/79Ke8o+8FIpYiNNorYPvDBpJnksscnyjHl/bND7P7mSXxGye/72donpKmsXmKv5by/K7306ATLYM6c=
X-Received: by 2002:a2e:8981:: with SMTP id c1-v6mr3520938lji.124.1538470399196;
 Tue, 02 Oct 2018 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181001213937.8774-1-dtor@chromium.org> <20181001213937.8774-2-dtor@chromium.org>
In-Reply-To: <20181001213937.8774-2-dtor@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 2 Oct 2018 10:53:07 +0200
Message-ID: <CAO-hwJKASi3+aFac8OR5XqESCF8RgB_aWZySAiMf+GHNh-2b0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: google: add Whiskers driver to handle tablet
 mode properly
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>, lee.jones@linaro.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Oct 1, 2018 at 11:39 PM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> This adds dedicated "Whiskers" driver that hooks both into HID and EC to
> produce proper SW_TABLET_SWITCH event from base presence bit from EC and
> base state (folded/unfolded) coming from USB/HID.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---

I have a few comments, see below.

>  drivers/hid/Kconfig               |   6 +
>  drivers/hid/Makefile              |   1 +
>  drivers/hid/hid-google-hammer.c   |   7 +-
>  drivers/hid/hid-google-whiskers.c | 382 ++++++++++++++++++++++++++++++
>  4 files changed, 392 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/hid/hid-google-whiskers.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e5ec47705fa2..0607f1c7129e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -355,6 +355,12 @@ config HID_GOOGLE_HAMMER
>         ---help---
>         Say Y here if you have a Google Hammer device.
>
> +config HID_GOOGLE_WHISKERS
> +       tristate "Google Whiskers Keyboard"
> +       depends on HID_GOOGLE_HAMMER && MFD_CROS_EC
> +       ---help---
> +       Say Y here if you have a Google Whiskers device.
> +
>  config HID_GT683R
>         tristate "MSI GT68xR LED support"
>         depends on LEDS_CLASS && USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index bd7ac53b75c5..241e583b6913 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_HID_EZKEY)               += hid-ezkey.o
>  obj-$(CONFIG_HID_GEMBIRD)      += hid-gembird.o
>  obj-$(CONFIG_HID_GFRM)         += hid-gfrm.o
>  obj-$(CONFIG_HID_GOOGLE_HAMMER)        += hid-google-hammer.o
> +obj-$(CONFIG_HID_GOOGLE_WHISKERS)      += hid-google-whiskers.o
>  obj-$(CONFIG_HID_GT683R)       += hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)     += hid-gyration.o
>  obj-$(CONFIG_HID_HOLTEK)       += hid-holtek-kbd.o
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 6bf4da7ad63a..81ddf9773df9 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>
>  #include "hid-ids.h"
> +#include "hid-google-hammer.h"

hid-google-hammer.h doesn't seem to be part of the patch (or in my
local tree at least).

>
>  #define MAX_BRIGHTNESS 100
>
> @@ -90,8 +91,7 @@ static int hammer_register_leds(struct hid_device *hdev)
>         return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
>  }
>
> -static int hammer_input_configured(struct hid_device *hdev,
> -                                  struct hid_input *hi)
> +int hammer_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  {
>         struct list_head *report_list =
>                 &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> @@ -116,6 +116,7 @@ static int hammer_input_configured(struct hid_device *hdev,
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(hammer_input_configured);

I am not sure there is a need to separate the driver in 2 for whiskers
if it still need the LED settings from hammer.

Given that the whiskers_ec struct will be populated independently,
having a common code path would not hurt hammer anyway.

>
>  static const struct hid_device_id hammer_devices[] = {
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> @@ -124,8 +125,6 @@ static const struct hid_device_id hammer_devices[] = {
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
> -       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> -                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, hammer_devices);
> diff --git a/drivers/hid/hid-google-whiskers.c b/drivers/hid/hid-google-whiskers.c
> new file mode 100644
> index 000000000000..ff3d2bfa1194
> --- /dev/null
> +++ b/drivers/hid/hid-google-whiskers.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// HID driver for Google Whiskers device.
> +//
> +// Copyright (c) 2018 Google Inc.
> +
> +#include <linux/acpi.h>
> +#include <linux/hid.h>
> +#include <linux/leds.h>

doesn't seem to be used

> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/usb.h>

This is usually not a good sign in HID drivers to rely on the low
level transport.
Basically, if you replay the device through uhid, this tends to break
heavily the kernel.

> +#include <asm/unaligned.h>
> +
> +#include "hid-ids.h"
> +#include "hid-google-hammer.h"
> +
> +#define HID_UP_GOOGLEVENDOR    0xffd10000
> +#define HID_VD_KBD_FOLDED      0x00000019
> +#define WHISKERS_KBD_FOLDED    (HID_UP_GOOGLEVENDOR | HID_VD_KBD_FOLDED)

Huh, this is weird there is no standard HID usage for this (not that
you can do anything about it).

> +
> +struct whiskers_ec {
> +       struct device *dev;     /* The platform device (EC) */
> +       struct input_dev *input;
> +       bool base_present;
> +       struct notifier_block notifier;
> +};
> +
> +static struct whiskers_ec whiskers_ec;
> +static DEFINE_SPINLOCK(whiskers_ec_lock);
> +static DEFINE_MUTEX(whiskers_ec_reglock);
> +
> +static bool whiskers_parse_base_state(const void *data)
> +{
> +       u32 switches = get_unaligned_le32(data);
> +
> +       return !!(switches & BIT(EC_MKBP_BASE_ATTACHED));
> +}
> +
> +static int whiskers_ec_query_base(struct cros_ec_device *ec_dev, bool get_state,
> +                                 bool *state)
> +{
> +       struct ec_params_mkbp_info *params;
> +       struct cros_ec_command *msg;
> +       int ret;
> +
> +       msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
> +                     GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       msg->command = EC_CMD_MKBP_INFO;
> +       msg->version = 1;
> +       msg->outsize = sizeof(*params);
> +       msg->insize = sizeof(u32);
> +       params = (struct ec_params_mkbp_info *)msg->data;
> +       params->info_type = get_state ?
> +               EC_MKBP_INFO_CURRENT : EC_MKBP_INFO_SUPPORTED;
> +       params->event_type = EC_MKBP_EVENT_SWITCH;
> +
> +       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +       if (ret >= 0) {
> +               if (ret != sizeof(u32)) {
> +                       dev_warn(ec_dev->dev, "wrong result size: %d != %zu\n",
> +                                ret, sizeof(u32));
> +                       ret = -EPROTO;
> +               } else {
> +                       *state = whiskers_parse_base_state(msg->data);
> +                       ret = 0;
> +               }
> +       }
> +
> +       kfree(msg);
> +
> +       return ret;
> +}
> +
> +static int whiskers_ec_notify(struct notifier_block *nb,
> +                             unsigned long queued_during_suspend,
> +                             void *_notify)
> +{
> +       struct cros_ec_device *ec = _notify;
> +       unsigned long flags;
> +       bool base_present;
> +
> +       if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
> +               base_present = whiskers_parse_base_state(
> +                                       &ec->event_data.data.switches);
> +               dev_dbg(whiskers_ec.dev,
> +                       "%s: base: %d\n", __func__, base_present);
> +
> +               if (device_may_wakeup(whiskers_ec.dev) ||
> +                   !queued_during_suspend) {
> +
> +                       pm_wakeup_event(whiskers_ec.dev, 0);
> +
> +                       spin_lock_irqsave(&whiskers_ec_lock, flags);
> +
> +                       /*
> +                        * While input layer dedupes the events, we do not want
> +                        * to disrupt the state reported by the base by
> +                        * overriding it with state reported by the LID. Only
> +                        * report changes, as we assume that on attach the base
> +                        * is not folded.
> +                        */
> +                       if (base_present != whiskers_ec.base_present) {
> +                               input_report_switch(whiskers_ec.input,
> +                                                   SW_TABLET_MODE,
> +                                                   !base_present);
> +                               input_sync(whiskers_ec.input);
> +                               whiskers_ec.base_present = base_present;
> +                       }
> +
> +                       spin_unlock_irqrestore(&whiskers_ec_lock, flags);
> +               }
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static __maybe_unused int whiskers_ec_resume(struct device *dev)
> +{
> +       struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
> +       bool base_present;
> +       int error;
> +
> +       error = whiskers_ec_query_base(ec, true, &base_present);
> +       if (error) {
> +               dev_warn(dev, "failed to fetch base state on resume: %d\n",
> +                        error);
> +       } else {
> +               spin_lock_irq(&whiskers_ec_lock);
> +
> +               whiskers_ec.base_present = base_present;
> +
> +               /*
> +                * Only report if base is disconnected. If base is connected,
> +                * it will resend its state on resume, and we'll update it
> +                * in whiskers_event().
> +                */
> +               if (!whiskers_ec.base_present) {
> +                       input_report_switch(whiskers_ec.input,
> +                                           SW_TABLET_MODE, 1);
> +                       input_sync(whiskers_ec.input);
> +               }
> +
> +               spin_unlock_irq(&whiskers_ec_lock);
> +       }
> +
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(whiskers_ec_pm_ops, NULL, whiskers_ec_resume);
> +
> +static void whiskers_ec_set_input(struct input_dev *input)
> +{
> +       /* Take the lock so whiskers_event does not race with us here */
> +       spin_lock_irq(&whiskers_ec_lock);
> +       whiskers_ec.input = input;
> +       spin_unlock_irq(&whiskers_ec_lock);
> +}
> +
> +static int __whiskers_ec_probe(struct platform_device *pdev)
> +{
> +       struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +       struct input_dev *input;
> +       bool base_supported;
> +       int error;
> +
> +       error = whiskers_ec_query_base(ec, false, &base_supported);
> +       if (error)
> +               return error;
> +
> +       if (!base_supported)
> +               return -ENXIO;
> +
> +       input = devm_input_allocate_device(&pdev->dev);
> +       if (!input)
> +               return -ENOMEM;
> +
> +       input->name = "Whiskers Tablet Mode Switch";
> +
> +       input->id.bustype = BUS_HOST;
> +       input->id.version = 1;
> +       input->id.product = 0;

I wonder if you should not set the vendor to USB_VENDOR_ID_GOOGLE and
the product to something better.

> +
> +       input_set_capability(input, EV_SW, SW_TABLET_MODE);
> +
> +       error = input_register_device(input);
> +       if (error) {
> +               dev_err(&pdev->dev, "cannot register input device: %d\n",
> +                       error);
> +               return error;
> +       }
> +
> +       /* Seed the state */
> +       error = whiskers_ec_query_base(ec, true, &whiskers_ec.base_present);
> +       if (error) {
> +               dev_err(&pdev->dev, "cannot query base state: %d\n", error);
> +               return error;
> +       }
> +
> +       input_report_switch(input, SW_TABLET_MODE, !whiskers_ec.base_present);
> +
> +       whiskers_ec_set_input(input);
> +
> +       whiskers_ec.dev = &pdev->dev;
> +       whiskers_ec.notifier.notifier_call = whiskers_ec_notify;
> +       error = blocking_notifier_chain_register(&ec->event_notifier,
> +                                                &whiskers_ec.notifier);
> +       if (error) {
> +               dev_err(&pdev->dev, "cannot register notifier: %d\n", error);
> +               whiskers_ec_set_input(NULL);
> +               return error;
> +       }
> +
> +       device_init_wakeup(&pdev->dev, true);
> +       return 0;
> +}
> +
> +static int whiskers_ec_probe(struct platform_device *pdev)
> +{
> +       int retval;
> +
> +       mutex_lock(&whiskers_ec_reglock);
> +
> +       if (whiskers_ec.input) {
> +               retval = -EBUSY;
> +               goto out;
> +       }
> +
> +       retval = __whiskers_ec_probe(pdev);
> +
> +out:
> +       mutex_unlock(&whiskers_ec_reglock);
> +       return retval;
> +}
> +
> +static int whiskers_ec_remove(struct platform_device *pdev)
> +{
> +       struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +
> +       mutex_lock(&whiskers_ec_reglock);
> +
> +       blocking_notifier_chain_unregister(&ec->event_notifier,
> +                                          &whiskers_ec.notifier);
> +       whiskers_ec_set_input(NULL);
> +
> +       mutex_unlock(&whiskers_ec_reglock);
> +       return 0;
> +}
> +
> +static const struct acpi_device_id whiskers_ec_acpi_ids[] = {
> +       { "GOOG000B", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, whiskers_ec_acpi_ids);
> +
> +static struct platform_driver whiskers_ec_driver = {
> +       .probe  = whiskers_ec_probe,
> +       .remove = whiskers_ec_remove,
> +       .driver = {
> +               .name                   = "whiskers_ec",
> +               .acpi_match_table       = ACPI_PTR(whiskers_ec_acpi_ids),
> +               .pm                     = &whiskers_ec_pm_ops,
> +       },
> +};
> +
> +static int whiskers_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> +                                 struct hid_field *field,
> +                                 struct hid_usage *usage,
> +                                 unsigned long **bit, int *max)
> +{
> +       if (usage->hid == WHISKERS_KBD_FOLDED) {
> +               /*
> +                * We do not want to have this usage mapped as it will get
> +                * mixed in with "base attached" signal and delivered over
> +                * separate input device for tablet switch mode.
> +                */
> +
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int whiskers_event(struct hid_device *hid, struct hid_field *field,
> +                         struct hid_usage *usage, __s32 value)
> +{
> +       unsigned long flags;
> +
> +       if (usage->hid == WHISKERS_KBD_FOLDED) {
> +               spin_lock_irqsave(&whiskers_ec_lock, flags);
> +
> +               hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
> +                       whiskers_ec.base_present, value);
> +
> +               /*
> +                * We should not get event if base is detached, but in case
> +                * we happen to service HID and EC notifications out of order
> +                * let's still check the "base present" flag.
> +                */
> +               if (whiskers_ec.input && whiskers_ec.base_present) {
> +                       input_report_switch(whiskers_ec.input,
> +                                           SW_TABLET_MODE, value);
> +                       input_sync(whiskers_ec.input);
> +               }
> +
> +               spin_unlock_irqrestore(&whiskers_ec_lock, flags);
> +               return 1; /* We handled this event */
> +       }
> +
> +       return 0;
> +}
> +
> +static int whiskers_probe(struct hid_device *hdev,
> +                         const struct hid_device_id *id)
> +{
> +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);

As mentioned earlier, this is prone to kernel oopses when using uhid.

> +       int ret;
> +
> +       /*
> +        * We always want to poll for, and handle tablet mode events, even when
> +        * nobody has opened the input device. This also prevents the hid core
> +        * from dropping early tablet mode events from the device.
> +        */
> +       if (intf->cur_altsetting->desc.bInterfaceProtocol ==
> +                       USB_INTERFACE_PROTOCOL_KEYBOARD)

Can't you rely on something embedded in the report descriptor instead?
This way you can drop the USB dependency.

> +               hdev->quirks |= HID_QUIRK_ALWAYS_POLL;
> +
> +       ret = hid_parse(hdev);
> +       if (!ret)
> +               ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +
> +       return ret;
> +}
> +
> +static const struct hid_device_id whiskers_hid_devices[] = {
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, whiskers_hid_devices);
> +
> +static struct hid_driver whiskers_hid_driver = {
> +       .name                   = "whiskers",
> +       .id_table               = whiskers_hid_devices,
> +       .probe                  = whiskers_probe,
> +       .input_configured       = hammer_input_configured,
> +       .input_mapping          = whiskers_input_mapping,
> +       .event                  = whiskers_event,
> +};
> +
> +static int __init whiskers_init(void)
> +{
> +       int error;
> +
> +       error = platform_driver_register(&whiskers_ec_driver);
> +       if (error)
> +               return error;
> +
> +       error = hid_register_driver(&whiskers_hid_driver);
> +       if (error) {
> +               platform_driver_unregister(&whiskers_ec_driver);
> +               return error;
> +       }
> +
> +       return 0;
> +}
> +module_init(whiskers_init);
> +
> +static void __exit whiskers_exit(void)
> +{
> +       hid_unregister_driver(&whiskers_hid_driver);
> +       platform_driver_unregister(&whiskers_ec_driver);
> +}
> +module_exit(whiskers_exit);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.19.0.605.g01d371f741-goog
>

Cheers,
Benjamin
