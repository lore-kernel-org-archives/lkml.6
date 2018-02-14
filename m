Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031024AbeBNOy5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:54:57 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33945 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:54:55 -0500
X-Google-Smtp-Source: AH8x226Q7v61myyE1S4ZkM25qyxCJcQJA+vYemxrL3JXtkZYHjEGuR9V+JBCPH+U2NBVlq4P1Ns8NXoEB5c0a6svdtI=
MIME-Version: 1.0
In-Reply-To: <20180213120308.23879-3-rodrigorivascosta@gmail.com>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com> <20180213120308.23879-3-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 14 Feb 2018 15:54:53 +0100
Message-ID: <CAO-hwJLsUBsYux2qnDMWg+2fS0ypF2O-DQAN3uVAG50RB0FfVw@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: steam: add battery device.
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> The wireless Steam Controller is battery operated, so add the battery
> device and power information.
>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
>  drivers/hid/hid-steam.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index f269a986e2be..eb2424688092 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -20,6 +20,7 @@
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/workqueue.h>
> +#include <linux/power_supply.h>
>  #include "hid-ids.h"
>
>  MODULE_LICENSE("GPL");
> @@ -35,6 +36,10 @@ struct steam_device {
>         struct work_struct work_connect;
>         bool connected;
>         char serial_no[11];
> +       struct power_supply_desc battery_desc;
> +       struct power_supply *battery;
> +       u8 battery_charge;
> +       u16 voltage;
>  };
>
>  static int steam_register(struct steam_device *steam);
> @@ -45,6 +50,8 @@ static int steam_send_report(struct steam_device *steam,
>                 u8 *cmd, int size);
>  static int steam_recv_report(struct steam_device *steam,
>                 u8 *data, int size);
> +static int steam_battery_register(struct steam_device *steam);
> +static void steam_do_battery_event(struct steam_device *steam, u8 *data);
>
>  static int steam_input_open(struct input_dev *dev)
>  {
> @@ -311,7 +318,8 @@ static int steam_raw_event(struct hid_device *hdev,
>                 }
>                 break;
>         case 0x04:
> -               /* TODO battery status */
> +               if (steam->quirks & STEAM_QUIRK_WIRELESS)
> +                       steam_do_battery_event(steam, data);
>                 break;
>         }
>         return 0;
> @@ -517,6 +525,10 @@ static int steam_register(struct steam_device *steam)
>
>         steam->input_dev = input;
>
> +       /* ignore battery errors, we can live without it */
> +       if (steam->quirks & STEAM_QUIRK_WIRELESS)
> +               steam_battery_register(steam);
> +
>         return 0;
>
>  input_register_fail:
> @@ -528,6 +540,12 @@ static void steam_unregister(struct steam_device *steam)
>  {
>         dbg_hid("%s\n", __func__);
>
> +       if (steam->battery) {
> +               power_supply_unregister(steam->battery);
> +               steam->battery = NULL;
> +               kfree(steam->battery_desc.name);
> +               steam->battery_desc.name = NULL;
> +       }
>         if (steam->input_dev) {
>                 hid_info(steam->hid_dev, "Steam Controller SN: '%s' disconnected",
>                         steam->serial_no);
> @@ -536,6 +554,125 @@ static void steam_unregister(struct steam_device *steam)
>         }
>  }
>
> +/* The size for this message payload is 11.
> + * The known values are:
> + *  Offset| Type  | Meaning
> + * -------+-------+---------------------------
> + *  4-7   | u32   | sequence number
> + *  8-11  | --    | always 0
> + *  12-13 | u16   | voltage (mV)
> + *  14    | u8    | battery percent
> + */
> +static void steam_do_battery_event(struct steam_device *steam, u8 *data)
> +{
> +       unsigned long flags;
> +       s16 volts = le16_to_cpup((__le16 *)(data + 12));
> +       u8 batt = data[14];
> +
> +       dbg_hid("%s: %d %d\n", __func__, volts, batt);
> +
> +       if (unlikely(!steam->battery)) {
> +               dbg_hid("%s: battery data without connect event\n", __func__);
> +               steam_do_connect_event(steam, true);
> +               return;
> +       }
> +
> +       spin_lock_irqsave(&steam->lock, flags);
> +       steam->voltage = volts;
> +       steam->battery_charge = batt;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       power_supply_changed(steam->battery);
> +}
> +
> +static enum power_supply_property steam_battery_props[] = {
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_SCOPE,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +       POWER_SUPPLY_PROP_CAPACITY,
> +};
> +
> +static int steam_battery_get_property(struct power_supply *psy,
> +                                    enum power_supply_property psp,
> +                                    union power_supply_propval *val)
> +{
> +       struct steam_device *steam = power_supply_get_drvdata(psy);
> +       unsigned long flags;
> +       s16 volts;
> +       u8 batt;
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&steam->lock, flags);
> +       volts = steam->voltage;
> +       batt = steam->battery_charge;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PRESENT:
> +               val->intval = 1;
> +               break;
> +       case POWER_SUPPLY_PROP_SCOPE:
> +               val->intval = POWER_SUPPLY_SCOPE_DEVICE;
> +               break;
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               val->intval = volts * 1000; /* mV -> uV */
> +               break;
> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               val->intval = batt;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +static int steam_battery_register(struct steam_device *steam)
> +{
> +       struct power_supply *battery;
> +       struct power_supply_config battery_cfg = { .drv_data = steam, };
> +       unsigned long flags;
> +       int ret;
> +
> +       dbg_hid("%s\n", __func__);
> +
> +       steam->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +       steam->battery_desc.properties = steam_battery_props;
> +       steam->battery_desc.num_properties = ARRAY_SIZE(steam_battery_props);
> +       steam->battery_desc.get_property = steam_battery_get_property;
> +       steam->battery_desc.name = kasprintf(GFP_KERNEL,
> +                       "steam-controller-%s-battery", steam->serial_no);

Please devm_kasprintf() so you don't have to free the memory later.

Cheers,
Benjamin

> +       if (!steam->battery_desc.name) {
> +               ret = -ENOMEM;
> +               goto print_name_fail;
> +       }
> +
> +       /* avoid the warning of 0% battery while waiting for the first info */
> +       spin_lock_irqsave(&steam->lock, flags);
> +       steam->voltage = 3000;
> +       steam->battery_charge = 100;
> +       spin_unlock_irqrestore(&steam->lock, flags);
> +
> +       battery = power_supply_register(&steam->hid_dev->dev,
> +                       &steam->battery_desc, &battery_cfg);
> +       if (IS_ERR(battery)) {
> +               ret = PTR_ERR(battery);
> +               hid_err(steam->hid_dev,
> +                               "%s:power_supply_register returned error %d\n",
> +                               __func__, ret);
> +               goto power_supply_reg_fail;
> +       }
> +       steam->battery = battery;
> +       power_supply_powers(steam->battery, &steam->hid_dev->dev);
> +       return 0;
> +
> +power_supply_reg_fail:
> +       kfree(steam->battery_desc.name);
> +       steam->battery_desc.name = NULL;
> +print_name_fail:
> +       return ret;
> +}
> +
>  static const struct hid_device_id steam_controllers[] = {
>         { /* Wired Steam Controller */
>           HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
> --
> 2.16.1
>
