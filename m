Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA79C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746CE2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746CE2400A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeGFNgH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:36:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48756 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeGFNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:36:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BC87427DAF8
Date:   Fri, 6 Jul 2018 15:36:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v4 4/5] power: supply: ds2760_battery: merge ds2760
 supply driver with its w1 slave companion
Message-ID: <20180706133601.rohj53vumqdjzn5j@earth.universe>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-5-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iyxm7yyvzhhmfcw"
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-5-daniel@zonque.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2iyxm7yyvzhhmfcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 06, 2018 at 07:35:51AM +0200, Daniel Mack wrote:
> This patch removes the w1 slave driver that used to register the w1 family
> and instanciate a platform device at runtime. The code now lives in the
> supply driver instead to avoid that level of indirection.
>=20
> The old device name "ds2760-battery.0" is preserved, so userspace
> applications can access the same virtual device nodes as before.
>=20
> Note that because the w1 core does not currently have a framework for
> suspend/resume, the driver now registers a PM notifier callback.
>=20
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---

Acked-for-power-supply: Sebastian Reichel <sebastian.reichel@collabora.co.u=
k>

-- Sebastian

>  drivers/power/supply/Kconfig          |   2 +-
>  drivers/power/supply/ds2760_battery.c | 321 ++++++++++++++++++--------
>  drivers/w1/slaves/Kconfig             |  12 -
>  drivers/w1/slaves/Makefile            |   1 -
>  drivers/w1/slaves/w1_ds2760.c         | 175 --------------
>  drivers/w1/slaves/w1_ds2760.h         |  59 -----
>  6 files changed, 232 insertions(+), 338 deletions(-)
>  delete mode 100644 drivers/w1/slaves/w1_ds2760.c
>  delete mode 100644 drivers/w1/slaves/w1_ds2760.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..518a88c4adfa 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -92,7 +92,7 @@ config BATTERY_CPCAP
> =20
>  config BATTERY_DS2760
>  	tristate "DS2760 battery driver (HP iPAQ & others)"
> -	depends on W1 && W1_SLAVE_DS2760
> +	depends on W1
>  	help
>  	  Say Y here to enable support for batteries with ds2760 chip.
> =20
> diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply=
/ds2760_battery.c
> index ae180dc929c9..aa406a7c65a1 100644
> --- a/drivers/power/supply/ds2760_battery.c
> +++ b/drivers/power/supply/ds2760_battery.c
> @@ -27,9 +27,63 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> -
> +#include <linux/suspend.h>
>  #include <linux/w1.h>
> -#include "../../w1/slaves/w1_ds2760.h"
> +
> +static unsigned int cache_time =3D 1000;
> +module_param(cache_time, uint, 0644);
> +MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> +
> +static bool pmod_enabled;
> +module_param(pmod_enabled, bool, 0644);
> +MODULE_PARM_DESC(pmod_enabled, "PMOD enable bit");
> +
> +static unsigned int rated_capacity;
> +module_param(rated_capacity, uint, 0644);
> +MODULE_PARM_DESC(rated_capacity, "rated battery capacity, 10*mAh or inde=
x");
> +
> +static unsigned int current_accum;
> +module_param(current_accum, uint, 0644);
> +MODULE_PARM_DESC(current_accum, "current accumulator value");
> +
> +#define W1_FAMILY_DS2760		0x30
> +
> +/* Known commands to the DS2760 chip */
> +#define W1_DS2760_SWAP			0xAA
> +#define W1_DS2760_READ_DATA		0x69
> +#define W1_DS2760_WRITE_DATA		0x6C
> +#define W1_DS2760_COPY_DATA		0x48
> +#define W1_DS2760_RECALL_DATA		0xB8
> +#define W1_DS2760_LOCK			0x6A
> +
> +/* Number of valid register addresses */
> +#define DS2760_DATA_SIZE		0x40
> +
> +#define DS2760_PROTECTION_REG		0x00
> +
> +#define DS2760_STATUS_REG		0x01
> +#define DS2760_STATUS_IE		(1 << 2)
> +#define DS2760_STATUS_SWEN		(1 << 3)
> +#define DS2760_STATUS_RNAOP		(1 << 4)
> +#define DS2760_STATUS_PMOD		(1 << 5)
> +
> +#define DS2760_EEPROM_REG		0x07
> +#define DS2760_SPECIAL_FEATURE_REG	0x08
> +#define DS2760_VOLTAGE_MSB		0x0c
> +#define DS2760_VOLTAGE_LSB		0x0d
> +#define DS2760_CURRENT_MSB		0x0e
> +#define DS2760_CURRENT_LSB		0x0f
> +#define DS2760_CURRENT_ACCUM_MSB	0x10
> +#define DS2760_CURRENT_ACCUM_LSB	0x11
> +#define DS2760_TEMP_MSB			0x18
> +#define DS2760_TEMP_LSB			0x19
> +#define DS2760_EEPROM_BLOCK0		0x20
> +#define DS2760_ACTIVE_FULL		0x20
> +#define DS2760_EEPROM_BLOCK1		0x30
> +#define DS2760_STATUS_WRITE_REG		0x31
> +#define DS2760_RATED_CAPACITY		0x32
> +#define DS2760_CURRENT_OFFSET_BIAS	0x33
> +#define DS2760_ACTIVE_EMPTY		0x3b
> =20
>  struct ds2760_device_info {
>  	struct device *dev;
> @@ -55,28 +109,113 @@ struct ds2760_device_info {
>  	int full_counter;
>  	struct power_supply *bat;
>  	struct power_supply_desc bat_desc;
> -	struct device *w1_dev;
>  	struct workqueue_struct *monitor_wqueue;
>  	struct delayed_work monitor_work;
>  	struct delayed_work set_charged_work;
> +	struct notifier_block pm_notifier;
>  };
> =20
> -static unsigned int cache_time =3D 1000;
> -module_param(cache_time, uint, 0644);
> -MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> +static int w1_ds2760_io(struct device *dev, char *buf, int addr, size_t =
count,
> +			int io)
> +{
> +	struct w1_slave *sl =3D container_of(dev, struct w1_slave, dev);
> =20
> -static bool pmod_enabled;
> -module_param(pmod_enabled, bool, 0644);
> -MODULE_PARM_DESC(pmod_enabled, "PMOD enable bit");
> +	if (!dev)
> +		return 0;
> =20
> -static unsigned int rated_capacity;
> -module_param(rated_capacity, uint, 0644);
> -MODULE_PARM_DESC(rated_capacity, "rated battery capacity, 10*mAh or inde=
x");
> +	mutex_lock(&sl->master->bus_mutex);
> =20
> -static unsigned int current_accum;
> -module_param(current_accum, uint, 0644);
> -MODULE_PARM_DESC(current_accum, "current accumulator value");
> +	if (addr > DS2760_DATA_SIZE || addr < 0) {
> +		count =3D 0;
> +		goto out;
> +	}
> +	if (addr + count > DS2760_DATA_SIZE)
> +		count =3D DS2760_DATA_SIZE - addr;
> +
> +	if (!w1_reset_select_slave(sl)) {
> +		if (!io) {
> +			w1_write_8(sl->master, W1_DS2760_READ_DATA);
> +			w1_write_8(sl->master, addr);
> +			count =3D w1_read_block(sl->master, buf, count);
> +		} else {
> +			w1_write_8(sl->master, W1_DS2760_WRITE_DATA);
> +			w1_write_8(sl->master, addr);
> +			w1_write_block(sl->master, buf, count);
> +			/* XXX w1_write_block returns void, not n_written */
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&sl->master->bus_mutex);
> +
> +	return count;
> +}
> +
> +static int w1_ds2760_read(struct device *dev,
> +			  char *buf, int addr,
> +			  size_t count)
> +{
> +	return w1_ds2760_io(dev, buf, addr, count, 0);
> +}
> +
> +static int w1_ds2760_write(struct device *dev,
> +			   char *buf,
> +			   int addr, size_t count)
> +{
> +	return w1_ds2760_io(dev, buf, addr, count, 1);
> +}
> =20
> +static int w1_ds2760_eeprom_cmd(struct device *dev, int addr, int cmd)
> +{
> +	struct w1_slave *sl =3D container_of(dev, struct w1_slave, dev);
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&sl->master->bus_mutex);
> +
> +	if (w1_reset_select_slave(sl) =3D=3D 0) {
> +		w1_write_8(sl->master, cmd);
> +		w1_write_8(sl->master, addr);
> +	}
> +
> +	mutex_unlock(&sl->master->bus_mutex);
> +	return 0;
> +}
> +
> +static int w1_ds2760_store_eeprom(struct device *dev, int addr)
> +{
> +	return w1_ds2760_eeprom_cmd(dev, addr, W1_DS2760_COPY_DATA);
> +}
> +
> +static int w1_ds2760_recall_eeprom(struct device *dev, int addr)
> +{
> +	return w1_ds2760_eeprom_cmd(dev, addr, W1_DS2760_RECALL_DATA);
> +}
> +
> +static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
> +			     struct bin_attribute *bin_attr, char *buf,
> +			     loff_t off, size_t count)
> +{
> +	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	return w1_ds2760_read(dev, buf, off, count);
> +}
> +
> +static BIN_ATTR_RO(w1_slave, DS2760_DATA_SIZE);
> +
> +static struct bin_attribute *w1_ds2760_bin_attrs[] =3D {
> +	&bin_attr_w1_slave,
> +	NULL,
> +};
> +
> +static const struct attribute_group w1_ds2760_group =3D {
> +	.bin_attrs =3D w1_ds2760_bin_attrs,
> +};
> +
> +static const struct attribute_group *w1_ds2760_groups[] =3D {
> +	&w1_ds2760_group,
> +	NULL,
> +};
>  /* Some batteries have their rated capacity stored a N * 10 mAh, while
>   * others use an index into this table. */
>  static int rated_capacities[] =3D {
> @@ -138,10 +277,10 @@ static int ds2760_battery_read_status(struct ds2760=
_device_info *di)
>  		count =3D DS2760_TEMP_LSB - start + 1;
>  	}
> =20
> -	ret =3D w1_ds2760_read(di->w1_dev, di->raw + start, start, count);
> +	ret =3D w1_ds2760_read(di->dev, di->raw + start, start, count);
>  	if (ret !=3D count) {
>  		dev_warn(di->dev, "call to w1_ds2760_read failed (0x%p)\n",
> -			 di->w1_dev);
> +			 di->dev);
>  		return 1;
>  	}
> =20
> @@ -242,7 +381,7 @@ static void ds2760_battery_set_current_accum(struct d=
s2760_device_info *di,
>  	acr[0] =3D acr_val >> 8;
>  	acr[1] =3D acr_val & 0xff;
> =20
> -	if (w1_ds2760_write(di->w1_dev, acr, DS2760_CURRENT_ACCUM_MSB, 2) < 2)
> +	if (w1_ds2760_write(di->dev, acr, DS2760_CURRENT_ACCUM_MSB, 2) < 2)
>  		dev_warn(di->dev, "ACR write failed\n");
>  }
> =20
> @@ -297,9 +436,9 @@ static void ds2760_battery_write_status(struct ds2760=
_device_info *di,
>  	if (status =3D=3D di->raw[DS2760_STATUS_REG])
>  		return;
> =20
> -	w1_ds2760_write(di->w1_dev, &status, DS2760_STATUS_WRITE_REG, 1);
> -	w1_ds2760_store_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> -	w1_ds2760_recall_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_write(di->dev, &status, DS2760_STATUS_WRITE_REG, 1);
> +	w1_ds2760_store_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_recall_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
>  }
> =20
>  static void ds2760_battery_write_rated_capacity(struct ds2760_device_inf=
o *di,
> @@ -308,9 +447,9 @@ static void ds2760_battery_write_rated_capacity(struc=
t ds2760_device_info *di,
>  	if (rated_capacity =3D=3D di->raw[DS2760_RATED_CAPACITY])
>  		return;
> =20
> -	w1_ds2760_write(di->w1_dev, &rated_capacity, DS2760_RATED_CAPACITY, 1);
> -	w1_ds2760_store_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> -	w1_ds2760_recall_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_write(di->dev, &rated_capacity, DS2760_RATED_CAPACITY, 1);
> +	w1_ds2760_store_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_recall_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
>  }
> =20
>  static void ds2760_battery_write_active_full(struct ds2760_device_info *=
di,
> @@ -325,9 +464,9 @@ static void ds2760_battery_write_active_full(struct d=
s2760_device_info *di,
>  	    tmp[1] =3D=3D di->raw[DS2760_ACTIVE_FULL + 1])
>  		return;
> =20
> -	w1_ds2760_write(di->w1_dev, tmp, DS2760_ACTIVE_FULL, sizeof(tmp));
> -	w1_ds2760_store_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK0);
> -	w1_ds2760_recall_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK0);
> +	w1_ds2760_write(di->dev, tmp, DS2760_ACTIVE_FULL, sizeof(tmp));
> +	w1_ds2760_store_eeprom(di->dev, DS2760_EEPROM_BLOCK0);
> +	w1_ds2760_recall_eeprom(di->dev, DS2760_EEPROM_BLOCK0);
> =20
>  	/* Write to the di->raw[] buffer directly - the DS2760_ACTIVE_FULL
>  	 * values won't be read back by ds2760_battery_read_status() */
> @@ -383,9 +522,9 @@ static void ds2760_battery_set_charged_work(struct wo=
rk_struct *work)
> =20
>  	dev_dbg(di->dev, "%s: bias =3D %d\n", __func__, bias);
> =20
> -	w1_ds2760_write(di->w1_dev, &bias, DS2760_CURRENT_OFFSET_BIAS, 1);
> -	w1_ds2760_store_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> -	w1_ds2760_recall_eeprom(di->w1_dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_write(di->dev, &bias, DS2760_CURRENT_OFFSET_BIAS, 1);
> +	w1_ds2760_store_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
> +	w1_ds2760_recall_eeprom(di->dev, DS2760_EEPROM_BLOCK1);
> =20
>  	/* Write to the di->raw[] buffer directly - the CURRENT_OFFSET_BIAS
>  	 * value won't be read back by ds2760_battery_read_status() */
> @@ -504,24 +643,55 @@ static enum power_supply_property ds2760_battery_pr=
ops[] =3D {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  };
> =20
> -static int ds2760_battery_probe(struct platform_device *pdev)
> +static int ds2760_pm_notifier(struct notifier_block *notifier,
> +			      unsigned long pm_event,
> +			      void *unused)
> +{
> +	struct ds2760_device_info *di =3D
> +		container_of(notifier, struct ds2760_device_info, pm_notifier);
> +
> +	switch (pm_event) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		break;
> +
> +	case PM_POST_RESTORE:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_SUSPEND:
> +		di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		power_supply_changed(di->bat);
> +		mod_delayed_work(di->monitor_wqueue, &di->monitor_work, HZ);
> +
> +		break;
> +
> +	case PM_RESTORE_PREPARE:
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int w1_ds2760_add_slave(struct w1_slave *sl)
>  {
>  	struct power_supply_config psy_cfg =3D {};
> -	char status;
> -	int retval =3D 0;
>  	struct ds2760_device_info *di;
> +	struct device *dev =3D &sl->dev;
> +	int retval =3D 0;
> +	char name[32];
> +	char status;
> =20
> -	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> +	di =3D devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
>  	if (!di) {
>  		retval =3D -ENOMEM;
>  		goto di_alloc_failed;
>  	}
> =20
> -	platform_set_drvdata(pdev, di);
> +	snprintf(name, sizeof(name), "ds2760-battery.%d", dev->id);
> =20
> -	di->dev				=3D &pdev->dev;
> -	di->w1_dev			=3D pdev->dev.parent;
> -	di->bat_desc.name		=3D dev_name(&pdev->dev);
> +	di->dev				=3D dev;
> +	di->bat_desc.name		=3D name;
>  	di->bat_desc.type		=3D POWER_SUPPLY_TYPE_BATTERY;
>  	di->bat_desc.properties		=3D ds2760_battery_props;
>  	di->bat_desc.num_properties	=3D ARRAY_SIZE(ds2760_battery_props);
> @@ -533,10 +703,12 @@ static int ds2760_battery_probe(struct platform_dev=
ice *pdev)
>  	di->bat_desc.external_power_changed =3D
>  				  ds2760_battery_external_power_changed;
> =20
> -	psy_cfg.drv_data		=3D di;
> +	psy_cfg.drv_data =3D di;
> =20
>  	di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> =20
> +	sl->family_data =3D di;
> +
>  	/* enable sleep mode feature */
>  	ds2760_battery_read_status(di);
>  	status =3D di->raw[DS2760_STATUS_REG];
> @@ -556,7 +728,7 @@ static int ds2760_battery_probe(struct platform_devic=
e *pdev)
>  	if (current_accum)
>  		ds2760_battery_set_current_accum(di, current_accum);
> =20
> -	di->bat =3D power_supply_register(&pdev->dev, &di->bat_desc, &psy_cfg);
> +	di->bat =3D power_supply_register(dev, &di->bat_desc, &psy_cfg);
>  	if (IS_ERR(di->bat)) {
>  		dev_err(di->dev, "failed to register battery\n");
>  		retval =3D PTR_ERR(di->bat);
> @@ -566,14 +738,16 @@ static int ds2760_battery_probe(struct platform_dev=
ice *pdev)
>  	INIT_DELAYED_WORK(&di->monitor_work, ds2760_battery_work);
>  	INIT_DELAYED_WORK(&di->set_charged_work,
>  			  ds2760_battery_set_charged_work);
> -	di->monitor_wqueue =3D alloc_ordered_workqueue(dev_name(&pdev->dev),
> -						     WQ_MEM_RECLAIM);
> +	di->monitor_wqueue =3D alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
>  	if (!di->monitor_wqueue) {
>  		retval =3D -ESRCH;
>  		goto workqueue_failed;
>  	}
>  	queue_delayed_work(di->monitor_wqueue, &di->monitor_work, HZ * 1);
> =20
> +	di->pm_notifier.notifier_call =3D ds2760_pm_notifier;
> +	register_pm_notifier(&di->pm_notifier);
> +
>  	goto success;
> =20
>  workqueue_failed:
> @@ -584,65 +758,32 @@ static int ds2760_battery_probe(struct platform_dev=
ice *pdev)
>  	return retval;
>  }
> =20
> -static int ds2760_battery_remove(struct platform_device *pdev)
> +static void w1_ds2760_remove_slave(struct w1_slave *sl)
>  {
> -	struct ds2760_device_info *di =3D platform_get_drvdata(pdev);
> +	struct ds2760_device_info *di =3D sl->family_data;
> =20
> +	unregister_pm_notifier(&di->pm_notifier);
>  	cancel_delayed_work_sync(&di->monitor_work);
>  	cancel_delayed_work_sync(&di->set_charged_work);
>  	destroy_workqueue(di->monitor_wqueue);
>  	power_supply_unregister(di->bat);
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM
> -
> -static int ds2760_battery_suspend(struct platform_device *pdev,
> -				  pm_message_t state)
> -{
> -	struct ds2760_device_info *di =3D platform_get_drvdata(pdev);
> -
> -	di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> -
> -	return 0;
> -}
> -
> -static int ds2760_battery_resume(struct platform_device *pdev)
> -{
> -	struct ds2760_device_info *di =3D platform_get_drvdata(pdev);
> -
> -	di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> -	power_supply_changed(di->bat);
> -
> -	mod_delayed_work(di->monitor_wqueue, &di->monitor_work, HZ);
> -
> -	return 0;
>  }
> =20
> -#else
> -
> -#define ds2760_battery_suspend NULL
> -#define ds2760_battery_resume NULL
> -
> -#endif /* CONFIG_PM */
> -
> -MODULE_ALIAS("platform:ds2760-battery");
> -
> -static struct platform_driver ds2760_battery_driver =3D {
> -	.driver =3D {
> -		.name =3D "ds2760-battery",
> -	},
> -	.probe	  =3D ds2760_battery_probe,
> -	.remove   =3D ds2760_battery_remove,
> -	.suspend  =3D ds2760_battery_suspend,
> -	.resume	  =3D ds2760_battery_resume,
> +static struct w1_family_ops w1_ds2760_fops =3D {
> +	.add_slave	=3D w1_ds2760_add_slave,
> +	.remove_slave	=3D w1_ds2760_remove_slave,
> +	.groups		=3D w1_ds2760_groups,
>  };
> =20
> -module_platform_driver(ds2760_battery_driver);
> +static struct w1_family w1_ds2760_family =3D {
> +	.fid		=3D W1_FAMILY_DS2760,
> +	.fops		=3D &w1_ds2760_fops,
> +};
> +module_w1_family(w1_ds2760_family);
> =20
> -MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>, "
>  	      "Matt Reimer <mreimer@vpop.net>, "
>  	      "Anton Vorontsov <cbou@mail.ru>");
> -MODULE_DESCRIPTION("ds2760 battery driver");
> +MODULE_DESCRIPTION("1-wire Driver Dallas 2760 battery monitor chip");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_DS2760));
> diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
> index 7931231d8e80..e22fdeddada1 100644
> --- a/drivers/w1/slaves/Kconfig
> +++ b/drivers/w1/slaves/Kconfig
> @@ -100,18 +100,6 @@ config W1_SLAVE_DS2438
>  	  Say Y here if you want to use a 1-wire
>  	  DS2438 Smart Battery Monitor device support
> =20
> -config W1_SLAVE_DS2760
> -	tristate "Dallas 2760 battery monitor chip (HP iPAQ & others)"
> -	help
> -	  If you enable this you will have the DS2760 battery monitor
> -	  chip support.
> -
> -	  The battery monitor chip is used in many batteries/devices
> -	  as the one who is responsible for charging/discharging/monitoring
> -	  Li+ batteries.
> -
> -	  If you are unsure, say N.
> -
>  config W1_SLAVE_DS2780
>  	tristate "Dallas 2780 battery monitor chip"
>  	help
> diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
> index d5f4f4d5b9e5..eab29f151413 100644
> --- a/drivers/w1/slaves/Makefile
> +++ b/drivers/w1/slaves/Makefile
> @@ -14,7 +14,6 @@ obj-$(CONFIG_W1_SLAVE_DS2431)	+=3D w1_ds2431.o
>  obj-$(CONFIG_W1_SLAVE_DS2805)	+=3D w1_ds2805.o
>  obj-$(CONFIG_W1_SLAVE_DS2433)	+=3D w1_ds2433.o
>  obj-$(CONFIG_W1_SLAVE_DS2438)	+=3D w1_ds2438.o
> -obj-$(CONFIG_W1_SLAVE_DS2760)	+=3D w1_ds2760.o
>  obj-$(CONFIG_W1_SLAVE_DS2780)	+=3D w1_ds2780.o
>  obj-$(CONFIG_W1_SLAVE_DS2781)	+=3D w1_ds2781.o
>  obj-$(CONFIG_W1_SLAVE_DS28E04)	+=3D w1_ds28e04.o
> diff --git a/drivers/w1/slaves/w1_ds2760.c b/drivers/w1/slaves/w1_ds2760.c
> deleted file mode 100644
> index 26168abfb8b8..000000000000
> --- a/drivers/w1/slaves/w1_ds2760.c
> +++ /dev/null
> @@ -1,175 +0,0 @@
> -/*
> - * 1-Wire implementation for the ds2760 chip
> - *
> - * Copyright =A9 2004-2005, Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
> - *
> - * Use consistent with the GNU GPL is permitted,
> - * provided that this copyright notice is
> - * preserved in its entirety in all copies and derived works.
> - *
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/types.h>
> -#include <linux/platform_device.h>
> -#include <linux/mutex.h>
> -#include <linux/idr.h>
> -#include <linux/gfp.h>
> -
> -#include <linux/w1.h>
> -
> -#include "w1_ds2760.h"
> -
> -#define W1_FAMILY_DS2760	0x30
> -
> -static int w1_ds2760_io(struct device *dev, char *buf, int addr, size_t =
count,
> -			int io)
> -{
> -	struct w1_slave *sl =3D container_of(dev, struct w1_slave, dev);
> -
> -	if (!dev)
> -		return 0;
> -
> -	mutex_lock(&sl->master->bus_mutex);
> -
> -	if (addr > DS2760_DATA_SIZE || addr < 0) {
> -		count =3D 0;
> -		goto out;
> -	}
> -	if (addr + count > DS2760_DATA_SIZE)
> -		count =3D DS2760_DATA_SIZE - addr;
> -
> -	if (!w1_reset_select_slave(sl)) {
> -		if (!io) {
> -			w1_write_8(sl->master, W1_DS2760_READ_DATA);
> -			w1_write_8(sl->master, addr);
> -			count =3D w1_read_block(sl->master, buf, count);
> -		} else {
> -			w1_write_8(sl->master, W1_DS2760_WRITE_DATA);
> -			w1_write_8(sl->master, addr);
> -			w1_write_block(sl->master, buf, count);
> -			/* XXX w1_write_block returns void, not n_written */
> -		}
> -	}
> -
> -out:
> -	mutex_unlock(&sl->master->bus_mutex);
> -
> -	return count;
> -}
> -
> -int w1_ds2760_read(struct device *dev, char *buf, int addr, size_t count)
> -{
> -	return w1_ds2760_io(dev, buf, addr, count, 0);
> -}
> -EXPORT_SYMBOL(w1_ds2760_read);
> -
> -int w1_ds2760_write(struct device *dev, char *buf, int addr, size_t coun=
t)
> -{
> -	return w1_ds2760_io(dev, buf, addr, count, 1);
> -}
> -EXPORT_SYMBOL(w1_ds2760_write);
> -
> -static int w1_ds2760_eeprom_cmd(struct device *dev, int addr, int cmd)
> -{
> -	struct w1_slave *sl =3D container_of(dev, struct w1_slave, dev);
> -
> -	if (!dev)
> -		return -EINVAL;
> -
> -	mutex_lock(&sl->master->bus_mutex);
> -
> -	if (w1_reset_select_slave(sl) =3D=3D 0) {
> -		w1_write_8(sl->master, cmd);
> -		w1_write_8(sl->master, addr);
> -	}
> -
> -	mutex_unlock(&sl->master->bus_mutex);
> -	return 0;
> -}
> -
> -int w1_ds2760_store_eeprom(struct device *dev, int addr)
> -{
> -	return w1_ds2760_eeprom_cmd(dev, addr, W1_DS2760_COPY_DATA);
> -}
> -EXPORT_SYMBOL(w1_ds2760_store_eeprom);
> -
> -int w1_ds2760_recall_eeprom(struct device *dev, int addr)
> -{
> -	return w1_ds2760_eeprom_cmd(dev, addr, W1_DS2760_RECALL_DATA);
> -}
> -EXPORT_SYMBOL(w1_ds2760_recall_eeprom);
> -
> -static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
> -			     struct bin_attribute *bin_attr, char *buf,
> -			     loff_t off, size_t count)
> -{
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> -	return w1_ds2760_read(dev, buf, off, count);
> -}
> -
> -static BIN_ATTR_RO(w1_slave, DS2760_DATA_SIZE);
> -
> -static struct bin_attribute *w1_ds2760_bin_attrs[] =3D {
> -	&bin_attr_w1_slave,
> -	NULL,
> -};
> -
> -static const struct attribute_group w1_ds2760_group =3D {
> -	.bin_attrs =3D w1_ds2760_bin_attrs,
> -};
> -
> -static const struct attribute_group *w1_ds2760_groups[] =3D {
> -	&w1_ds2760_group,
> -	NULL,
> -};
> -
> -static int w1_ds2760_add_slave(struct w1_slave *sl)
> -{
> -	int ret;
> -	struct platform_device *pdev;
> -
> -	pdev =3D platform_device_alloc("ds2760-battery", PLATFORM_DEVID_AUTO);
> -	if (!pdev)
> -		return -ENOMEM;
> -	pdev->dev.parent =3D &sl->dev;
> -
> -	ret =3D platform_device_add(pdev);
> -	if (ret)
> -		goto pdev_add_failed;
> -
> -	dev_set_drvdata(&sl->dev, pdev);
> -
> -	return 0;
> -
> -pdev_add_failed:
> -	platform_device_put(pdev);
> -
> -	return ret;
> -}
> -
> -static void w1_ds2760_remove_slave(struct w1_slave *sl)
> -{
> -	struct platform_device *pdev =3D dev_get_drvdata(&sl->dev);
> -
> -	platform_device_unregister(pdev);
> -}
> -
> -static struct w1_family_ops w1_ds2760_fops =3D {
> -	.add_slave    =3D w1_ds2760_add_slave,
> -	.remove_slave =3D w1_ds2760_remove_slave,
> -	.groups       =3D w1_ds2760_groups,
> -};
> -
> -static struct w1_family w1_ds2760_family =3D {
> -	.fid =3D W1_FAMILY_DS2760,
> -	.fops =3D &w1_ds2760_fops,
> -};
> -module_w1_family(w1_ds2760_family);
> -
> -MODULE_AUTHOR("Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>");
> -MODULE_DESCRIPTION("1-wire Driver Dallas 2760 battery monitor chip");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_DS2760));
> diff --git a/drivers/w1/slaves/w1_ds2760.h b/drivers/w1/slaves/w1_ds2760.h
> deleted file mode 100644
> index 24168c94eeae..000000000000
> --- a/drivers/w1/slaves/w1_ds2760.h
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -/*
> - * 1-Wire implementation for the ds2760 chip
> - *
> - * Copyright =A9 2004-2005, Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
> - *
> - * Use consistent with the GNU GPL is permitted,
> - * provided that this copyright notice is
> - * preserved in its entirety in all copies and derived works.
> - *
> - */
> -
> -#ifndef __w1_ds2760_h__
> -#define __w1_ds2760_h__
> -
> -/* Known commands to the DS2760 chip */
> -#define W1_DS2760_SWAP			0xAA
> -#define W1_DS2760_READ_DATA		0x69
> -#define W1_DS2760_WRITE_DATA		0x6C
> -#define W1_DS2760_COPY_DATA		0x48
> -#define W1_DS2760_RECALL_DATA		0xB8
> -#define W1_DS2760_LOCK			0x6A
> -
> -/* Number of valid register addresses */
> -#define DS2760_DATA_SIZE		0x40
> -
> -#define DS2760_PROTECTION_REG		0x00
> -
> -#define DS2760_STATUS_REG		0x01
> -#define DS2760_STATUS_IE		(1 << 2)
> -#define DS2760_STATUS_SWEN		(1 << 3)
> -#define DS2760_STATUS_RNAOP		(1 << 4)
> -#define DS2760_STATUS_PMOD		(1 << 5)
> -
> -#define DS2760_EEPROM_REG		0x07
> -#define DS2760_SPECIAL_FEATURE_REG	0x08
> -#define DS2760_VOLTAGE_MSB		0x0c
> -#define DS2760_VOLTAGE_LSB		0x0d
> -#define DS2760_CURRENT_MSB		0x0e
> -#define DS2760_CURRENT_LSB		0x0f
> -#define DS2760_CURRENT_ACCUM_MSB	0x10
> -#define DS2760_CURRENT_ACCUM_LSB	0x11
> -#define DS2760_TEMP_MSB			0x18
> -#define DS2760_TEMP_LSB			0x19
> -#define DS2760_EEPROM_BLOCK0		0x20
> -#define DS2760_ACTIVE_FULL		0x20
> -#define DS2760_EEPROM_BLOCK1		0x30
> -#define DS2760_STATUS_WRITE_REG		0x31
> -#define DS2760_RATED_CAPACITY		0x32
> -#define DS2760_CURRENT_OFFSET_BIAS	0x33
> -#define DS2760_ACTIVE_EMPTY		0x3b
> -
> -extern int w1_ds2760_read(struct device *dev, char *buf, int addr,
> -			  size_t count);
> -extern int w1_ds2760_write(struct device *dev, char *buf, int addr,
> -			   size_t count);
> -extern int w1_ds2760_store_eeprom(struct device *dev, int addr);
> -extern int w1_ds2760_recall_eeprom(struct device *dev, int addr);
> -
> -#endif /* !__w1_ds2760_h__ */
> --=20
> 2.17.1
>=20

--2iyxm7yyvzhhmfcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/cDcACgkQ2O7X88g7
+pqPmRAAia26WpokiAD5WB2LxPrWbRKFqnU0pHAI3G8qxBERUnixF/aQNIW+5Df7
6nBuAEQugSV8WwtJN1nPO+2H298prJ3oPqRF5EW/TnQu71AS0YhtSFPW9HddaILB
Pug+ShgcvjaYqo+0xPQHF5UThPqE+ZHGQK/dW4XAK6dsOWSmRXd2Sx2+3HJk92va
IbRnijJNzlMhoQBc0EQP5vqGRzQJ8JX36EeQGCW+LkCrhuPXc44CW9WpPL355Yny
hTTuajcYjIvw/vt69UUVUw9dBq33nt3kEBWeeiSt3l+KUuKaDO15vNZL3PhN0svV
iaIt4KB/fXKPosblzxBOysPPCSCuem9I2+w5LOh4cH/DBaA9pwGttegbwREH5cRh
y3JrBmYdfT2n7edxmBpnNVyLtlj7PBKCY1Dvi3QzCtpBbwsbfsQ3k5QoRZM3Azek
Vv+WM5Hnm8PWHPIlcmeI+ZYYfC9x/JSApnKfqlosdnSm5iBQrMXPCYnAeGNfpJgx
RmnfaNN9fLnC4aD/wH+hy60vrAYmv2GdedL7FKijMjlG9jvyGpZ+8vFA1au6o7Dy
JYeaK6u0M65l0nST/yp9TM1OoktEYjeysUjbMwPRcVXEgiCX6+AnIgx+czBRdGAG
Kl9JxylX6cxU6rXU5fF6iZ0xzDvZ91DH5q3fGv75wrKRXKxuUOE=
=g/ii
-----END PGP SIGNATURE-----

--2iyxm7yyvzhhmfcw--
