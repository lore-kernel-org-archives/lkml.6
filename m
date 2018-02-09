Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBIL5w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:57:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeBIL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:57:49 -0500
Date: Fri, 9 Feb 2018 12:57:43 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH 2/3] power: supply: add cros-ec USB PD charger driver.
Message-ID: <20180209115743.piqtxzf6ovuwbtfz@earth.universe>
References: <20180117175932.20636-1-enric.balletbo@collabora.com>
 <20180117175932.20636-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ku6fjcjnwkton5no"
Content-Disposition: inline
In-Reply-To: <20180117175932.20636-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ku6fjcjnwkton5no
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Wed, Jan 17, 2018 at 06:59:31PM +0100, Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
>=20
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
>=20
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/power/supply/Kconfig              |  11 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/cros_usbpd-charger.c | 953 ++++++++++++++++++++++++=
++++++
>  include/linux/mfd/cros_ec.h               |   3 +
>  4 files changed, 968 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c

Documentation for custom sysfs files is missing.

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..641503c1d40a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -624,4 +624,15 @@ config CHARGER_RT9455
>  	help
>  	  Say Y to enable support for Richtek RT9455 battery charger.
> =20
> +config CHARGER_CROS_USB_PD
> +	tristate "Chrome OS EC based USB PD charger"
> +	depends on MFD_CROS_EC
> +	select RTC_LIB
> +	default n
> +	help
> +	  Say Y here to enable Chrome OS EC based USB PD charger
> +	  driver. This driver gets various bits of information about
> +	  what is connected to USB PD ports from the EC and converts
> +	  that into power_supply properties.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index e83aa843bcc6..c412fe8b562d 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -83,3 +83,4 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_CHARGER_CROS_USB_PD)	+=3D cros_usbpd-charger.o
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> new file mode 100644
> index 000000000000..1c48185f8163
> --- /dev/null
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -0,0 +1,953 @@

Please add SPDX header.

> +/*
> + * Power supply driver for ChromeOS EC based USB PD Charger.
> + *
> + * Copyright (c) 2014 - 2018 Google, Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +
> +#define CROS_USB_PD_MAX_LOG_ENTRIES	30
> +
> +#define CROS_USB_PD_LOG_UPDATE_DELAY msecs_to_jiffies(60000)
> +#define CROS_USB_PD_CACHE_UPDATE_DELAY msecs_to_jiffies(500)
> +
> +/* Buffer + macro for building PDLOG string */
> +#define BUF_SIZE 80
> +#define APPEND_STRING(buf, len, str, ...) ((len) +=3D \
> +	snprintf((buf) + (len), max(BUF_SIZE - (len), 0), (str), ##__VA_ARGS__))
> +
> +#define CHARGER_DIR_NAME		"CROS_USB_PD_CHARGER%d"
> +#define CHARGER_DIR_NAME_LENGTH		sizeof(CHARGER_DIR_NAME)
> +#define DRV_NAME "cros-usb-pd-charger"
> +
> +#define MANUFACTURER_MODEL_LENGTH	32
> +
> +struct port_data {
> +	int port_number;
> +	char name[CHARGER_DIR_NAME_LENGTH];
> +	char manufacturer[MANUFACTURER_MODEL_LENGTH];
> +	char model_name[MANUFACTURER_MODEL_LENGTH];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	int psy_type;
> +	int psy_online;
> +	int psy_status;
> +	int psy_current_max;
> +	int psy_voltage_max_design;
> +	int psy_voltage_now;
> +	int psy_power_max;
> +	struct charger_data *charger;
> +	unsigned long last_update;
> +};
> +
> +struct charger_data {
> +	struct device *dev;
> +	struct cros_ec_dev *ec_dev;
> +	struct cros_ec_device *ec_device;
> +	int num_charger_ports;
> +	int num_registered_psy;
> +	struct port_data *ports[EC_USB_PD_MAX_PORTS];
> +	struct delayed_work log_work;
> +	struct workqueue_struct *log_workqueue;
> +	struct notifier_block notifier;
> +	bool suspended;
> +};
> +
> +#define EC_MAX_IN_SIZE EC_PROTO2_MAX_REQUEST_SIZE
> +#define EC_MAX_OUT_SIZE EC_PROTO2_MAX_RESPONSE_SIZE
> +u8 ec_inbuf[EC_MAX_IN_SIZE];
> +u8 ec_outbuf[EC_MAX_OUT_SIZE];
> +
> +static enum power_supply_property cros_usb_pd_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +/* Current external voltage/current limit in mV/mA. Default to none. */
> +static u16 ext_voltage_lim =3D EC_POWER_LIMIT_NONE;
> +static u16 ext_current_lim =3D EC_POWER_LIMIT_NONE;
> +
> +static int ec_command(struct charger_data *charger, int version, int com=
mand,
> +		      u8 *outdata, int outsize, u8 *indata,
> +		      int insize)
> +{
> +	struct cros_ec_device *ec_device =3D charger->ec_device;
> +	struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D version;
> +	msg->command =3D ec_dev->cmd_offset + command;
> +	msg->outsize =3D outsize;
> +	msg->insize =3D insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret =3D cros_ec_cmd_xfer_status(ec_device, msg);
> +	if (ret > 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int set_ec_usb_pd_override_ports(struct charger_data *charger,
> +					int port_num)
> +{
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_charge_port_override req;
> +	int ret;
> +
> +	req.override_port =3D port_num;
> +
> +	ret =3D ec_command(charger, 0, EC_CMD_PD_CHARGE_PORT_OVERRIDE,
> +			 (u8 *)&req, sizeof(req),
> +			 NULL, 0);
> +	if (ret < 0) {
> +		dev_info(dev, "Port Override command returned 0x%x\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_ec_num_ports(struct charger_data *charger, int *num_ports)
> +{
> +	struct device *dev =3D charger->dev;
> +	struct ec_response_usb_pd_ports *resp =3D
> +	    (struct ec_response_usb_pd_ports *)ec_inbuf;
> +	int ret;
> +
> +	*num_ports =3D 0;
> +	ret =3D ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
> +			 NULL, 0, ec_inbuf, EC_MAX_IN_SIZE);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query PD ports (err:0x%x)\n", ret);
> +		return ret;
> +	}
> +	*num_ports =3D resp->num_ports;
> +	dev_dbg(dev, "Num ports =3D %d\n", *num_ports);
> +
> +	return 0;
> +}
> +
> +static int get_ec_usb_pd_discovery_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_usb_pd_info_request req;
> +	struct ec_params_usb_pd_discovery_entry resp;
> +	int ret;
> +
> +	req.port =3D port->port_number;
> +
> +	ret =3D ec_command(charger, 0, EC_CMD_USB_PD_DISCOVERY,
> +			 (u8 *)&req, sizeof(req),
> +			 (u8 *)&resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query Discovery info (err:0x%x)\n",
> +			ret);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Port %d: VID =3D 0x%x, PID=3D0x%x, PTYPE=3D0x%x\n",
> +		port->port_number, resp.vid, resp.pid, resp.ptype);
> +
> +	snprintf(port->manufacturer, MANUFACTURER_MODEL_LENGTH, "%x", resp.vid);
> +	snprintf(port->model_name, MANUFACTURER_MODEL_LENGTH, "%x", resp.pid);
> +
> +	return 0;
> +}
> +
> +static int get_ec_usb_pd_power_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_usb_pd_power_info req;
> +	struct ec_response_usb_pd_power_info resp;
> +	char role_str[80];

const char *role_str;

> +	int ret, last_psy_status, last_psy_type;
> +
> +	req.port =3D port->port_number;
> +	ret =3D ec_command(charger, 0, EC_CMD_USB_PD_POWER_INFO,
> +			 (u8 *)&req, sizeof(req),
> +			 (u8 *)&resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	last_psy_status =3D port->psy_status;
> +	last_psy_type =3D port->psy_type;
> +
> +	switch (resp.role) {
> +	case USB_PD_PORT_POWER_DISCONNECTED:
> +		snprintf(role_str, sizeof(role_str), "%s", "DISCONNECTED");

role_str =3D "DISCONNECTED";

> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SOURCE:
> +		snprintf(role_str, sizeof(role_str), "%s", "SOURCE");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SINK:
> +		snprintf(role_str, sizeof(role_str), "%s", "SINK");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
> +		snprintf(role_str, sizeof(role_str), "%s", "NOT CHARGING");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	default:
> +		snprintf(role_str, sizeof(role_str), "%s", "UNKNOWN");
> +		dev_err(dev, "Unknown role %d\n", resp.role);
> +		break;
> +	}
> +
> +	port->psy_voltage_max_design =3D resp.meas.voltage_max;
> +	port->psy_voltage_now =3D resp.meas.voltage_now;
> +	port->psy_current_max =3D resp.meas.current_max;
> +	port->psy_power_max =3D resp.max_power;
> +
> +	switch (resp.type) {
> +	case USB_CHG_TYPE_BC12_SDP:
> +	case USB_CHG_TYPE_VBUS:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +		break;
> +	case USB_CHG_TYPE_NONE:
> +		/*
> +		 * For dual-role devices when we are a source, the firmware
> +		 * reports the type as NONE. Report such chargers as type
> +		 * USB_PD_DRP.
> +		 */
> +		if (resp.role =3D=3D USB_PD_PORT_POWER_SOURCE && resp.dualrole)
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD_DRP;
> +		else
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +		break;
> +	case USB_CHG_TYPE_OTHER:
> +	case USB_CHG_TYPE_PROPRIETARY:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_APPLE_BRICK_ID;
> +		break;
> +	case USB_CHG_TYPE_C:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_TYPE_C;
> +		break;
> +	case USB_CHG_TYPE_BC12_DCP:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_DCP;
> +		break;
> +	case USB_CHG_TYPE_BC12_CDP:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_CDP;
> +		break;
> +	case USB_CHG_TYPE_PD:
> +		if (resp.dualrole)
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD_DRP;
> +		else
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD;
> +		break;
> +	case USB_CHG_TYPE_UNKNOWN:
> +		/*
> +		 * While the EC is trying to determine the type of charger that
> +		 * has been plugged in, it will report the charger type as
> +		 * unknown. Treat this case as a dedicated charger since we
> +		 * don't know any better just yet. Additionally since the power
> +		 * capabilities are unknown, report the max current and voltage
> +		 * as zero.
> +		 */
> +		port->psy_type =3D POWER_SUPPLY_TYPE_MAINS;
> +		port->psy_voltage_max_design =3D 0;
> +		port->psy_current_max =3D 0;
> +		break;
> +	default:
> +		dev_err(dev, "Port %d: default case!\n",
> +			port->port_number);
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +	}
> +
> +	port->psy_desc.type =3D port->psy_type;
> +
> +	dev_dbg(dev,
> +		"Port %d: %s type=3D%d=3Dvmax=3D%d vnow=3D%d cmax=3D%d clim=3D%d pmax=
=3D%d\n",
> +		port->port_number, role_str, resp.type,
> +		resp.meas.voltage_max, resp.meas.voltage_now,
> +		resp.meas.current_max, resp.meas.current_lim,
> +		resp.max_power);
> +
> +	/*
> +	 * If power supply type or status changed, explicitly call
> +	 * power_supply_changed. This results in udev event getting generated
> +	 * and allows user mode apps to react quicker instead of waiting for
> +	 * their next poll of power supply status.
> +	 */
> +	if (last_psy_type !=3D port->psy_type ||
> +	    last_psy_status !=3D port->psy_status) {
> +		dev_dbg(dev, "Port %d: Calling power_supply_changed\n",
> +			port->port_number);
> +		power_supply_changed(port->psy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_ec_port_status(struct port_data *port, bool ratelimit)
> +{
> +	int ret;
> +
> +	if (ratelimit &&
> +	    time_is_after_jiffies(port->last_update +
> +				  CROS_USB_PD_CACHE_UPDATE_DELAY))
> +		return 0;
> +
> +	ret =3D get_ec_usb_pd_power_info(port);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D get_ec_usb_pd_discovery_info(port);
> +	port->last_update =3D jiffies;
> +
> +	return ret;
> +}
> +
> +static void cros_usb_pd_charger_power_changed(struct power_supply *psy)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	int i;
> +
> +	for (i =3D 0; i < charger->num_registered_psy; i++)
> +		get_ec_port_status(charger->ports[i], false);
> +}
> +
> +static int cros_usb_pd_charger_get_prop(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	struct cros_ec_device *ec_device =3D charger->ec_device;
> +	int ret;
> +
> +
> +	/* Only refresh ec_port_status for dynamic properties */
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		/*
> +		 * If mkbp_event_supported, then we can be assured that
> +		 * the driver's state for the online property is consistent
> +		 * with the hardware. However, if we aren't event driven,
> +		 * the optimization before to skip an ec_port_status get
> +		 * and only returned cached values of the online property will
> +		 * cause a delay in detecting a cable attach until one of the
> +		 * other properties are read.
> +		 *
> +		 * Allow an ec_port_status refresh for online property check
> +		 * if we're not already online to check for plug events if
> +		 * not mkbp_event_supported.
> +		 */
> +		if (ec_device->mkbp_event_supported || port->psy_online)
> +			break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		ret =3D get_ec_port_status(port, true);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to get port status (err:0x%x)\n",
> +				ret);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D port->psy_online;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D port->psy_status;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D port->psy_current_max * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D port->psy_voltage_max_design * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		/* TODO: change this to voltage_now. */

I don't understand this TODO.

> +		val->intval =3D port->psy_voltage_now * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		/* TODO: send a TBD host command to the EC. */

So POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX is not implemented at
all?

> +		val->intval =3D 0;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D port->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D port->manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_set_prop(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    const union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	int port_number;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		/*
> +		 * A value of -1 implies switching to battery as the power
> +		 * source. Any other value implies using this port as the
> +		 * power source.
> +		 */
> +		port_number =3D val->intval;
> +		if (port_number !=3D -1)
> +			port_number =3D port->port_number;
> +		return set_ec_usb_pd_override_ports(charger, port_number);

This looks strange. Can you elaborate?

> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_is_writeable(struct power_supply *psy,
> +		enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		ret =3D 1;
> +		break;
> +	default:
> +		ret =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static void cros_usb_pd_print_log_entry(struct ec_response_pd_log *r,
> +					ktime_t tstamp)
> +{
> +	static const char * const fault_names[] =3D {
> +		"---", "OCP", "fast OCP", "OVP", "Discharge"
> +	};
> +	static const char * const role_names[] =3D {
> +		"Disconnected", "SRC", "SNK", "SNK (not charging)"
> +	};
> +	static const char * const chg_type_names[] =3D {
> +		"None", "PD", "Type-C", "Proprietary",
> +		"DCP", "CDP", "SDP", "Other", "VBUS"
> +	};
> +	int i;
> +	int role_idx, type_idx;
> +	const char *fault, *role, *chg_type;
> +	struct usb_chg_measures *meas;
> +	struct mcdp_info *minfo;
> +	struct rtc_time rt;
> +	u64 msecs;
> +	int len =3D 0;
> +	char buf[BUF_SIZE + 1];
> +
> +	/* the timestamp is the number of 1024th of seconds in the past */
> +	tstamp =3D ktime_sub_us(tstamp,
> +		 (u64)r->timestamp << PD_LOG_TIMESTAMP_SHIFT);
> +	rt =3D rtc_ktime_to_tm(tstamp);
> +
> +	switch (r->type) {
> +	case PD_EVENT_MCU_CHARGE:
> +		if (r->data & CHARGE_FLAGS_OVERRIDE)
> +			APPEND_STRING(buf, len, "override ");
> +		if (r->data & CHARGE_FLAGS_DELAYED_OVERRIDE)
> +			APPEND_STRING(buf, len, "pending_override ");
> +		role_idx =3D r->data & CHARGE_FLAGS_ROLE_MASK;
> +		role =3D role_idx < ARRAY_SIZE(role_names) ?
> +			role_names[role_idx] : "Unknown";
> +		type_idx =3D (r->data & CHARGE_FLAGS_TYPE_MASK)
> +			 >> CHARGE_FLAGS_TYPE_SHIFT;
> +		chg_type =3D type_idx < ARRAY_SIZE(chg_type_names) ?
> +			chg_type_names[type_idx] : "???";
> +		meas =3D (struct usb_chg_measures *)r->payload;
> +
> +		if ((role_idx =3D=3D USB_PD_PORT_POWER_DISCONNECTED) ||
> +		    (role_idx =3D=3D USB_PD_PORT_POWER_SOURCE)) {
> +			APPEND_STRING(buf, len, "%s", role);
> +
> +			if ((role_idx =3D=3D USB_PD_PORT_POWER_SOURCE) &&
> +			    (meas->current_max))
> +				APPEND_STRING(buf, len, " %dmA",
> +					      meas->current_max);
> +
> +			break;
> +		}
> +
> +		APPEND_STRING(buf, len, "%s %s %s %dmV max %dmV / %dmA", role,
> +			r->data & CHARGE_FLAGS_DUAL_ROLE ? "DRP" : "Charger",
> +			chg_type,
> +			meas->voltage_now,
> +			meas->voltage_max,
> +			meas->current_max);
> +		break;
> +	case PD_EVENT_ACC_RW_FAIL:
> +		APPEND_STRING(buf, len, "RW signature check failed");
> +		break;
> +	case PD_EVENT_PS_FAULT:
> +		fault =3D r->data < ARRAY_SIZE(fault_names) ? fault_names[r->data]
> +							  : "???";
> +		APPEND_STRING(buf, len, "Power supply fault: %s", fault);
> +		break;
> +	case PD_EVENT_VIDEO_DP_MODE:
> +		APPEND_STRING(buf, len, "DP mode %sabled",
> +			      (r->data =3D=3D 1) ? "en" : "dis");
> +		break;
> +	case PD_EVENT_VIDEO_CODEC:
> +		minfo =3D (struct mcdp_info *)r->payload;
> +		APPEND_STRING(buf, len,
> +			      "HDMI info: family:%04x chipid:%04x "
> +			      "irom:%d.%d.%d fw:%d.%d.%d",
> +			      MCDP_FAMILY(minfo->family),
> +			      MCDP_CHIPID(minfo->chipid),
> +			      minfo->irom.major, minfo->irom.minor,
> +			      minfo->irom.build, minfo->fw.major,
> +			      minfo->fw.minor, minfo->fw.build);
> +		break;

video codec?

> +	default:
> +		APPEND_STRING(buf, len,
> +			"Event %02x (%04x) [", r->type, r->data);
> +		for (i =3D 0; i < PD_LOG_SIZE(r->size_port); i++)
> +			APPEND_STRING(buf, len, "%02x ", r->payload[i]);
> +		APPEND_STRING(buf, len, "]");
> +		break;
> +	}
> +
> +	msecs =3D ktime_to_ms(tstamp);
> +	do_div(msecs, MSEC_PER_SEC);
> +	pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n",
> +		rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> +		rt.tm_hour, rt.tm_min, rt.tm_sec, msecs,
> +		PD_LOG_PORT(r->size_port), buf);
> +}
> +
> +static void cros_usb_pd_log_check(struct work_struct *work)
> +{
> +	struct charger_data *charger =3D container_of(to_delayed_work(work),
> +		struct charger_data, log_work);
> +	struct device *dev =3D charger->dev;
> +	union {
> +		struct ec_response_pd_log r;
> +		u32 words[8]; /* space for the payload */
> +	} u;
> +	int ret;
> +	int entries =3D 0;
> +	ktime_t now;
> +
> +	if (charger->suspended) {
> +		dev_dbg(dev, "Suspended...bailing out\n");
> +		return;
> +	}
> +
> +	while (entries++ < CROS_USB_PD_MAX_LOG_ENTRIES) {
> +		ret =3D ec_command(charger, 0, EC_CMD_PD_GET_LOG_ENTRY,
> +				 NULL, 0, (u8 *)&u, sizeof(u));
> +		now =3D ktime_get_real();
> +		if (ret < 0) {
> +			dev_dbg(dev, "Cannot get PD log %d\n", ret);
> +			break;
> +		}
> +		if (u.r.type =3D=3D PD_EVENT_NO_ENTRY)
> +			break;
> +
> +		cros_usb_pd_print_log_entry(&u.r, now);
> +	}
> +
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +}

Is there a good reason to have this log in dmesg? It looks more
suitable for debugfs.

> +static int cros_usb_pd_ec_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct charger_data *charger;
> +	struct device *dev;
> +	struct cros_ec_device *ec_device;
> +	u32 host_event;
> +
> +	charger =3D container_of(nb, struct charger_data, notifier);
> +	dev =3D charger->dev;
> +	ec_device =3D charger->ec_device;
> +
> +	host_event =3D cros_ec_get_host_event(ec_device);
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		cros_usb_pd_charger_power_changed(charger->ports[0]->psy);
> +		return NOTIFY_OK;
> +	} else {
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static char *charger_supplied_to[] =3D {"cros-usb_pd-charger"};

What are you trying to do here?

> +static int cros_usb_pd_charger_probe(struct platform_device *pd)
> +{
> +	struct device *dev =3D &pd->dev;
> +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(pd->dev.parent);
> +	struct cros_ec_device *ec_device;
> +	struct charger_data *charger;
> +	struct port_data *port;
> +	struct power_supply_desc *psy_desc;
> +	struct power_supply *psy;
> +	int i;
> +	int ret =3D -EINVAL;
> +
> +	if (!ec_dev) {
> +		dev_err(dev, "No EC dev found\n");
> +		return -EINVAL;
> +	}
> +
> +	ec_device =3D ec_dev->ec_dev;
> +	if (!ec_device) {
> +		dev_err(dev, "No EC device found.\n");
> +		return -EINVAL;
> +	}
> +
> +	charger =3D devm_kzalloc(dev, sizeof(struct charger_data),
> +				    GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev =3D dev;
> +	charger->ec_dev =3D ec_dev;
> +	charger->ec_device =3D ec_device;
> +
> +	platform_set_drvdata(pd, charger);
> +
> +	if ((get_ec_num_ports(charger, &charger->num_charger_ports) < 0) ||
> +	    !charger->num_charger_ports) {
> +		/*
> +		 * This can happen on a system that doesn't support USB PD.
> +		 * Log a message, but no need to warn.
> +		 */
> +		dev_info(dev, "No charging ports found\n");
> +		ret =3D -ENODEV;
> +		goto fail_nowarn;
> +	}
> +
> +	for (i =3D 0; i < charger->num_charger_ports; i++) {
> +		struct power_supply_config psy_cfg =3D {};
> +
> +		port =3D devm_kzalloc(dev, sizeof(struct port_data), GFP_KERNEL);
> +		if (!port) {
> +			ret =3D -ENOMEM;
> +			goto fail;
> +		}
> +
> +		port->charger =3D charger;
> +		port->port_number =3D i;
> +		sprintf(port->name, CHARGER_DIR_NAME, i);
> +
> +		psy_desc =3D &port->psy_desc;
> +		psy_desc->name =3D port->name;
> +		psy_desc->type =3D POWER_SUPPLY_TYPE_USB;
> +		psy_desc->get_property =3D cros_usb_pd_charger_get_prop;
> +		psy_desc->set_property =3D cros_usb_pd_charger_set_prop;
> +		psy_desc->property_is_writeable =3D
> +					cros_usb_pd_charger_is_writeable;
> +		psy_desc->external_power_changed =3D
> +					cros_usb_pd_charger_power_changed;
> +		psy_desc->properties =3D cros_usb_pd_charger_props;
> +		psy_desc->num_properties =3D
> +					ARRAY_SIZE(cros_usb_pd_charger_props);
> +
> +		psy_cfg.drv_data =3D port;
> +		psy_cfg.supplied_to =3D charger_supplied_to;
> +		psy_cfg.num_supplicants =3D ARRAY_SIZE(charger_supplied_to);
> +
> +		psy =3D power_supply_register_no_ws(dev, psy_desc, &psy_cfg);

Use devm_ variant.

> +		if (IS_ERR(psy)) {
> +			dev_err(dev, "Failed to register power supply\n");
> +			continue;
> +		}
> +		port->psy =3D psy;
> +
> +		charger->ports[charger->num_registered_psy++] =3D port;
> +		ec_device->charger =3D psy;
> +	}
> +
> +	if (!charger->num_registered_psy) {
> +		ret =3D -ENODEV;
> +		dev_err(dev, "No power supplies registered\n");
> +		goto fail;
> +	}
> +
> +	if (ec_device->mkbp_event_supported) {
> +		/* Get PD events from the EC */
> +		charger->notifier.notifier_call =3D cros_usb_pd_ec_event;
> +		ret =3D blocking_notifier_chain_register(
> +						&ec_device->event_notifier,
> +						&charger->notifier);
> +		if (ret < 0)
> +			dev_warn(dev, "failed to register notifier\n");
> +	}
> +
> +	/* Retrieve PD event logs periodically */
> +	INIT_DELAYED_WORK(&charger->log_work, cros_usb_pd_log_check);
> +	charger->log_workqueue =3D
> +		create_singlethread_workqueue("cros_usb_pd_log");
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +
> +	return 0;
> +
> +fail:
> +	WARN(1, "%s: Failing probe (err:0x%x)\n", dev_name(dev), ret);
> +
> +fail_nowarn:
> +	if (charger) {
> +		ec_device->charger =3D NULL;
> +		for (i =3D 0; i < charger->num_registered_psy; i++) {
> +			port =3D charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);
> +		}
> +		platform_set_drvdata(pd, NULL);
> +		devm_kfree(dev, charger);
> +	}

This can be removed (see comments to cros_usb_pd_charger_remove).

> +
> +	dev_info(dev, "Failing probe (err:0x%x)\n", ret);
> +	return ret;
> +}
> +
> +static int cros_usb_pd_charger_remove(struct platform_device *pd)
> +{
> +	struct charger_data *charger =3D platform_get_drvdata(pd);
> +	struct cros_ec_device *ec_device =3D charger->ec_device;
> +	struct device *dev =3D charger->dev;
> +	struct port_data *port;
> +	int i;
> +
> +	if (charger) {
> +		ec_device->charger =3D NULL;
> +		for (i =3D 0; i < charger->num_registered_psy; i++) {
> +			port =3D charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);
> +		}
> +		flush_delayed_work(&charger->log_work);
> +		platform_set_drvdata(pd, NULL);
> +		devm_kfree(dev, charger);
> +	}
> +	return 0;

The devm_kfree is not needed, unsetting platform driver data is not
needed and you can drop power_supply_unregister after using the
devm_ registration function. I think the entire function can be reduced
to a

cancel_delayed_work_sync()

call (flush looks wrong btw. I suspect this might crash your system
10 minutes after  module removal).

> +}

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_usb_pd_charger_resume(struct device *dev)
> +{
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +	int i;
> +
> +	if (!charger)
> +		return 0;
> +
> +	charger->suspended =3D false;
> +
> +	for (i =3D 0; i < charger->num_registered_psy; i++) {
> +		power_supply_changed(charger->ports[i]->psy);
> +		charger->ports[i]->last_update =3D
> +				jiffies - CROS_USB_PD_CACHE_UPDATE_DELAY;
> +	}
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_suspend(struct device *dev)
> +{
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +
> +	charger->suspended =3D true;
> +
> +	if (charger)
> +		flush_delayed_work(&charger->log_work);
> +	return 0;

I think it's cleaner to cancel the delayed work and requeue on
resume. with this you can just drop the charger-suspended variable.

> +}
> +#endif
> +
> +static int set_ec_ext_power_limit(struct cros_ec_dev *ec,
> +				  u16 current_lim, u16 voltage_lim)
> +{
> +	struct ec_params_external_power_limit_v1 *req;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kzalloc(sizeof(*msg) + sizeof(*req), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req =3D (struct ec_params_external_power_limit_v1 *)msg->data;
> +
> +	req->current_lim =3D current_lim;
> +	req->voltage_lim =3D voltage_lim;
> +
> +	msg->version =3D 1;
> +	msg->command =3D ec->cmd_offset + EC_CMD_EXTERNAL_POWER_LIMIT;
> +	msg->outsize =3D sizeof(*req);
> +
> +	ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +	if (ret < 0) {
> +		dev_warn(ec->dev,
> +			 "External power limit command returned 0x%x\n",
> +			 ret);
> +		ret =3D -EINVAL;
> +	} else {
> +		ret =3D 0;
> +	}
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static ssize_t get_ec_ext_current_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ext_current_lim);
> +}
> +
> +static ssize_t set_ec_ext_current_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	u16 tmp_val;
> +	struct cros_ec_dev *ec =3D container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret =3D set_ec_ext_power_limit(ec, tmp_val, ext_voltage_lim);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_current_lim =3D tmp_val;
> +	if (ext_current_lim =3D=3D EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External current limit removed\n");
> +	else
> +		dev_info(ec->dev, "External current limit set to %dmA\n",
> +			 ext_current_lim);
> +
> +	return count;
> +}
> +
> +static ssize_t get_ec_ext_voltage_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ext_voltage_lim);
> +}
> +
> +static ssize_t set_ec_ext_voltage_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	u16 tmp_val;
> +
> +	struct cros_ec_dev *ec =3D container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret =3D set_ec_ext_power_limit(ec, ext_current_lim, tmp_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_voltage_lim =3D tmp_val;
> +	if (ext_voltage_lim =3D=3D EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External voltage limit removed\n");
> +	else
> +		dev_info(ec->dev, "External voltage limit set to %dmV\n",
> +			 ext_voltage_lim);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(ext_current_lim, 0664, get_ec_ext_current_lim,
> +		   set_ec_ext_current_lim);
> +static DEVICE_ATTR(ext_voltage_lim, 0664, get_ec_ext_voltage_lim,
> +		   set_ec_ext_voltage_lim);
> +
> +static struct attribute *__ext_power_cmds_attrs[] =3D {
> +	&dev_attr_ext_current_lim.attr,
> +	&dev_attr_ext_voltage_lim.attr,
> +	NULL,
> +};

What do these files control? I suspect this is already covered
by a standard POWER_SUPPLY_PROP_* property.

> +struct attribute_group cros_usb_pd_charger_attr_group =3D {
> +	.name =3D "usb-pd-charger",
> +	.attrs =3D __ext_power_cmds_attrs,
> +};
> +EXPORT_SYMBOL(cros_usb_pd_charger_attr_group);
> +
> +static SIMPLE_DEV_PM_OPS(cros_usb_pd_charger_pm_ops,
> +	cros_usb_pd_charger_suspend, cros_usb_pd_charger_resume);
> +
> +static struct platform_driver cros_usb_pd_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.owner =3D THIS_MODULE,

Please drop .owner

> +		.pm =3D &cros_usb_pd_charger_pm_ops,
> +	},
> +	.probe =3D cros_usb_pd_charger_probe,
> +	.remove =3D cros_usb_pd_charger_remove,
> +};
> +
> +module_platform_driver(cros_usb_pd_charger_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Chrome USB PD charger");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index c61535979b8f..30eb9493b418 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -19,6 +19,7 @@
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/notifier.h>
> +#include <linux/power_supply.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/mutex.h>
> =20
> @@ -143,6 +144,7 @@ struct cros_ec_device {
>  			struct cros_ec_command *msg);
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
> +	struct power_supply *charger;
>  	struct mutex lock;
>  	bool mkbp_event_supported;
>  	struct blocking_notifier_head event_notifier;
> @@ -321,6 +323,7 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_=
dev);
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;
>  extern struct attribute_group cros_ec_vbc_attr_group;
> +extern struct attribute_group cros_usb_pd_charger_attr_group;
> =20
>  /* debugfs stuff */
>  int cros_ec_debugfs_init(struct cros_ec_dev *ec);

-- Sebastian

--ku6fjcjnwkton5no
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9jLQACgkQ2O7X88g7
+pp7QQ//bx89MU6gjXLgEMzTEKBxNVUmOGZLdIr817CHepjDg6YrxurgJSBv1hpR
jjZ165SKqobUXr3vBz1B4Cg6nFhlepstwXHvL8CA1Fnr8C8yKIe+9X5Q7yvTQOpY
+TSo9oMW0qd8L8KSY0sRMC8Urxq6DQ0PTJKfsUEdcYhxMyuVU06Gis8qY38nnfai
CNITDP+FQvoeRCWcaYuMe2+VfTr3oKfHYYkvf1SyQOLUIouKzoGRTYKC/yWRvez/
ApctrsGcU+3wlOgDQbDuMBiiafYLyvFGVZJirUExeGmkZKYaJq8qCuOS+ew/BnSj
q++kFCkb4f+6bxYtOp/m3sdJfrYoQsnPMbkwwWFb1fCDLTOBLq8V3H351e0s6qRN
hr+855mO8VEQWDj7Fw5o2aqCCQPD6uXkwvh/WGFkw0qK2ymg3lIOmGA9tGwo2q4I
5ty6Bo/eB0B+f/AM7TcUeI7eCXaa8s283oMRVHsYqspuqgSmDcLq7sEdY2wWXNmr
vftxD/ROwBvWl/LO3YbXDhJ948N8RqQZJs2aegqmiku1xJxpUFFp9/ddMxtXWBlF
hCL4AdYt7bmH+JEOfsn70Nju1ZWt+BKcpkX/SPGaFsBF84GUrO3+gyzbh2xFMXXY
n3g+l3s9KMsfLfcQyt9L8fY6dd6XovXDK/J+mQsXfLcMZQTY0PA=
=8Ele
-----END PGP SIGNATURE-----

--ku6fjcjnwkton5no--
