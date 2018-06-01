Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeFAQbB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:31:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46243 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFAQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:30:58 -0400
X-Google-Smtp-Source: ADUXVKLyYHBaaMfoySG61f8vkU0WjmPRfR8OXzPXQE6cwtRLMajUW/8spqVVgvpicOHqj3lEryDlIv2vZoWL5Tlp4iw=
MIME-Version: 1.0
In-Reply-To: <20180530031704.18597-4-fparent@baylibre.com>
References: <20180530031704.18597-1-fparent@baylibre.com> <20180530031704.18597-4-fparent@baylibre.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 1 Jun 2018 18:30:57 +0200
Message-ID: <CAFqH_52541jTrMdBeNyq6Qhv4_GcF+YDHsGoXDXRTkUn0_tOYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: supply: cros: add property to detect connected ports
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, gpain@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Many thanks for the patch.

2018-05-30 5:17 GMT+02:00 Fabien Parent <fparent@baylibre.com>:
> When a port is connected but acting as a source, its 'online' and
> 'status' properties are identical to a port that is not connected. This
> makes it tedious for userspace to know for sure whether a port is
> connected or not.
>
> This commit adds a new property 'present' to reflect whether a port
> is connected or not.
>

Actually, there is an attempt to align the usage of the different
properties between drivers [1]. According to current documentation,
the present property is used to report whether a battery is present or
not in the system. So, I am not sure if using the present property is
the proper way to do it. Maybe Sebastian can give us some clues or
preferences?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/Documentation/ABI/testing/sysfs-class-power?h=for-next&id=91dabc54073324006d5eaba483679c47b6eb93a8#n159

Best regards,
  Enric

> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 808688a6586c..d44ab35670ab 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -32,6 +32,7 @@ struct port_data {
>         struct power_supply_desc psy_desc;
>         int psy_usb_type;
>         int psy_online;
> +       int psy_present;
>         int psy_status;
>         int psy_current_max;
>         int psy_voltage_max_design;
> @@ -54,6 +55,7 @@ struct charger_data {
>
>  static enum power_supply_property cros_usbpd_charger_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_CURRENT_MAX,
>         POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> @@ -65,6 +67,7 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
>
>  static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> @@ -205,18 +208,22 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
>         case USB_PD_PORT_POWER_DISCONNECTED:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 0;
> +               port->psy_present = 0;
>                 break;
>         case USB_PD_PORT_POWER_SOURCE:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 0;
> +               port->psy_present = 1;
>                 break;
>         case USB_PD_PORT_POWER_SINK:
>                 port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
>                 port->psy_online = 1;
> +               port->psy_present = 1;
>                 break;
>         case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 1;
> +               port->psy_present = 1;
>                 break;
>         default:
>                 dev_err(dev, "Unknown role %d\n", resp.role);
> @@ -362,6 +369,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>                  */
>                 if (ec_device->mkbp_event_supported || port->psy_online)
>                         break;
> +       case POWER_SUPPLY_PROP_PRESENT:
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
>         case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -380,6 +388,9 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_ONLINE:
>                 val->intval = port->psy_online;
>                 break;
> +       case POWER_SUPPLY_PROP_PRESENT:
> +               val->intval = port->psy_present;
> +               break;
>         case POWER_SUPPLY_PROP_STATUS:
>                 val->intval = port->psy_status;
>                 break;
> --
> 2.17.0
>
