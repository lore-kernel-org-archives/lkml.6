Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeFASyi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:54:38 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:33734 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeFASye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:54:34 -0400
Date: Fri, 1 Jun 2018 11:54:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Stef van Os <stef.van.os@prodrive-technologies.com>
Subject: Re: [PATCH linux-next v5 12/13] drivers/hwmon: Add PECI dimmtemp
 driver
Message-ID: <20180601185432.GC27795@roeck-us.net>
References: <20180601182303.24117-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601182303.24117-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:23:03AM -0700, Jae Hyun Yoo wrote:
> This commit adds PECI dimmtemp hwmon driver.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/Kconfig         |  14 ++
>  drivers/hwmon/Makefile        |   1 +
>  drivers/hwmon/peci-dimmtemp.c | 295 ++++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/hwmon/peci-dimmtemp.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e5d2d0b44c14..6a376054d43c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1270,6 +1270,20 @@ config SENSORS_PECI_CPUTEMP
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called peci-cputemp.
>  
> +config SENSORS_PECI_DIMMTEMP
> +	tristate "PECI DIMM temperature monitoring support"
> +	depends on PECI
> +	select MFD_PECI_CLIENT
> +	help
> +	  If you say yes here you get support for the generic Intel PECI hwmon
> +	  driver which provides Digital Thermal Sensor (DTS) thermal readings of
> +	  DIMM components that are accessible using the PECI Client Command
> +	  Suite via the processor PECI client.
> +	  Check Documentation/hwmon/peci-dimmtemp for details.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called peci-dimmtemp.
> +
>  config SENSORS_NSA320
>  	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
>  	depends on GPIOLIB && OF
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3cd603cd66a7..48d9598fcd3a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>  obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
>  obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>  obj-$(CONFIG_SENSORS_PECI_CPUTEMP)	+= peci-cputemp.o
> +obj-$(CONFIG_SENSORS_PECI_DIMMTEMP)	+= peci-dimmtemp.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> diff --git a/drivers/hwmon/peci-dimmtemp.c b/drivers/hwmon/peci-dimmtemp.c
> new file mode 100644
> index 000000000000..44f258249f14
> --- /dev/null
> +++ b/drivers/hwmon/peci-dimmtemp.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/hwmon.h>
> +#include <linux/jiffies.h>
> +#include <linux/mfd/peci-client.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +
> +#define DIMM_MASK_CHECK_DELAY_JIFFIES msecs_to_jiffies(5000)
> +#define DIMM_MASK_CHECK_RETRY_MAX     60 /* 60 x 5 secs = 5 minutes */
> +
> +struct peci_dimmtemp {
> +	struct peci_mfd *mfd;
> +	struct device *dev;
> +	char name[PECI_NAME_SIZE];
> +	u8 addr;
> +	const struct cpu_gen_info *gen_info;
> +	struct workqueue_struct *work_queue;
> +	struct delayed_work work_handler;
> +	struct temp_data temp[DIMM_NUMS_MAX];
> +	u32 dimm_mask;
> +	int retry_count;
> +	u32 temp_config[DIMM_NUMS_MAX + 1];
> +	struct hwmon_channel_info temp_info;
> +	const struct hwmon_channel_info *info[2];
> +	struct hwmon_chip_info chip;
> +};
> +
> +static const char *dimmtemp_label[CHAN_RANK_MAX][DIMM_IDX_MAX] = {
> +	{ "DIMM A0", "DIMM A1", "DIMM A2" },
> +	{ "DIMM B0", "DIMM B1", "DIMM B2" },
> +	{ "DIMM C0", "DIMM C1", "DIMM C2" },
> +	{ "DIMM D0", "DIMM D1", "DIMM D2" },
> +	{ "DIMM E0", "DIMM E1", "DIMM E2" },
> +	{ "DIMM F0", "DIMM F1", "DIMM F2" },
> +	{ "DIMM G0", "DIMM G1", "DIMM G2" },
> +	{ "DIMM H0", "DIMM H1", "DIMM H2" },
> +};
> +
> +static int get_dimm_temp(struct peci_dimmtemp *priv, int dimm_no)
> +{
> +	int dimm_order = dimm_no % priv->gen_info->dimm_idx_max;
> +	int chan_rank = dimm_no / priv->gen_info->dimm_idx_max;
> +	u8  cfg_data[4];
> +	int rc;
> +
> +	if (!peci_temp_need_update(&priv->temp[dimm_no]))
> +		return 0;
> +
> +	rc = peci_client_rd_pkg_cfg_cmd(priv->mfd, MBX_INDEX_DDR_DIMM_TEMP,
> +					chan_rank, cfg_data);
> +	if (rc)
> +		return rc;
> +
> +	priv->temp[dimm_no].value = cfg_data[dimm_order] * 1000;
> +
> +	peci_temp_mark_updated(&priv->temp[dimm_no]);
> +
> +	return 0;
> +}
> +
> +static int dimmtemp_read_string(struct device *dev,
> +				enum hwmon_sensor_types type,
> +				u32 attr, int channel, const char **str)
> +{
> +	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
> +	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
> +	int chan_rank, dimm_idx;
> +
> +	if (attr != hwmon_temp_label)
> +		return -EOPNOTSUPP;
> +
> +	chan_rank = channel / dimm_idx_max;
> +	dimm_idx = channel % dimm_idx_max;
> +	*str = dimmtemp_label[chan_rank][dimm_idx];
> +	return 0;
> +}
> +
> +static int dimmtemp_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
> +	int rc;
> +
> +	if (attr != hwmon_temp_input)
> +		return -EOPNOTSUPP;
> +
> +	rc = get_dimm_temp(priv, channel);
> +	if (rc)
> +		return rc;
> +
> +	*val = priv->temp[channel].value;
> +	return 0;
> +}
> +
> +static umode_t dimmtemp_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	const struct peci_dimmtemp *priv = data;
> +
> +	if (priv->temp_config[channel] & BIT(attr) &&
> +	    priv->dimm_mask & BIT(channel))
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops dimmtemp_ops = {
> +	.is_visible = dimmtemp_is_visible,
> +	.read_string = dimmtemp_read_string,
> +	.read = dimmtemp_read,
> +};
> +
> +static int check_populated_dimms(struct peci_dimmtemp *priv)
> +{
> +	u32 chan_rank_max = priv->gen_info->chan_rank_max;
> +	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
> +	int chan_rank, dimm_idx, rc;
> +	u8  cfg_data[4];
> +
> +	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
> +		rc = peci_client_rd_pkg_cfg_cmd(priv->mfd,
> +						MBX_INDEX_DDR_DIMM_TEMP,
> +						chan_rank, cfg_data);
> +		if (rc) {
> +			priv->dimm_mask = 0;
> +			return rc;
> +		}
> +
> +		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
> +			if (cfg_data[dimm_idx])
> +				priv->dimm_mask |= BIT(chan_rank *
> +						       chan_rank_max +
> +						       dimm_idx);
> +	}
> +
> +	if (!priv->dimm_mask)
> +		return -EAGAIN;
> +
> +	dev_dbg(priv->dev, "Scanned populated DIMMs: 0x%x\n", priv->dimm_mask);
> +	return 0;
> +}
> +
> +static int create_dimm_temp_info(struct peci_dimmtemp *priv)
> +{
> +	int rc, i, config_idx, channels;
> +	struct device *hwmon_dev;
> +
> +	rc = check_populated_dimms(priv);
> +	if (rc) {
> +		if (rc == -EAGAIN) {
> +			if (priv->retry_count < DIMM_MASK_CHECK_RETRY_MAX) {
> +				queue_delayed_work(priv->work_queue,
> +						   &priv->work_handler,
> +						 DIMM_MASK_CHECK_DELAY_JIFFIES);
> +				priv->retry_count++;
> +				dev_dbg(priv->dev,
> +					"Deferred DIMM temp info creation\n");
> +			} else {
> +				dev_err(priv->dev,
> +					"Timeout DIMM temp info creation\n");
> +				rc = -ETIMEDOUT;
> +			}
> +		}
> +
> +		return rc;
> +	}
> +
> +	channels = priv->gen_info->chan_rank_max *
> +		   priv->gen_info->dimm_idx_max;
> +	for (i = 0, config_idx = 0; i < channels; i++)
> +		if (priv->dimm_mask & BIT(i))
> +			while (i >= config_idx)
> +				priv->temp_config[config_idx++] =
> +					HWMON_T_LABEL | HWMON_T_INPUT;
> +
> +	priv->chip.ops = &dimmtemp_ops;
> +	priv->chip.info = priv->info;
> +
> +	priv->info[0] = &priv->temp_info;
> +
> +	priv->temp_info.type = hwmon_temp;
> +	priv->temp_info.config = priv->temp_config;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(priv->dev,
> +							 priv->name,
> +							 priv,
> +							 &priv->chip,
> +							 NULL);
> +	rc = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (!rc)
> +		dev_dbg(priv->dev, "%s: sensor '%s'\n",
> +			dev_name(hwmon_dev), priv->name);
> +
> +	return rc;
> +}
> +
> +static void create_dimm_temp_info_delayed(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct peci_dimmtemp *priv = container_of(dwork, struct peci_dimmtemp,
> +						  work_handler);
> +	int rc;
> +
> +	rc = create_dimm_temp_info(priv);
> +	if (rc && rc != -EAGAIN)
> +		dev_dbg(priv->dev, "Failed to create DIMM temp info\n");
> +}
> +
> +static int peci_dimmtemp_probe(struct platform_device *pdev)
> +{
> +	struct peci_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct peci_dimmtemp *priv;
> +	int rc;
> +
> +	if ((mfd->adapter->cmd_mask &
> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG)))
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +	priv->mfd = mfd;
> +	priv->dev = dev;
> +	priv->addr = mfd->addr;
> +	priv->gen_info = mfd->gen_info;
> +
> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_dimmtemp.cpu%d",
> +		 priv->mfd->cpu_no);
> +
> +	priv->work_queue = alloc_ordered_workqueue(priv->name, 0);
> +	if (!priv->work_queue)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&priv->work_handler, create_dimm_temp_info_delayed);
> +
> +	rc = create_dimm_temp_info(priv);
> +	if (rc && rc != -EAGAIN) {
> +		dev_err(dev, "Failed to create DIMM temp info\n");
> +		goto err_free_wq;
> +	}
> +
> +	return 0;
> +
> +err_free_wq:
> +	destroy_workqueue(priv->work_queue);
> +	return rc;
> +}
> +
> +static int peci_dimmtemp_remove(struct platform_device *pdev)
> +{
> +	struct peci_dimmtemp *priv = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_delayed_work_sync(&priv->work_handler);
> +	destroy_workqueue(priv->work_queue);
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id peci_dimmtemp_of_table[] = {
> +	{ .compatible = "intel,peci-dimmtemp" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, peci_dimmtemp_of_table);
> +#endif
> +
> +static const struct platform_device_id peci_dimmtemp_ids[] = {
> +	{ .name = "peci-dimmtemp", .driver_data = 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, peci_dimmtemp_ids);
> +
> +static struct platform_driver peci_dimmtemp_driver = {
> +	.probe    = peci_dimmtemp_probe,
> +	.remove   = peci_dimmtemp_remove,
> +	.id_table = peci_dimmtemp_ids,
> +	.driver   = {
> +			.name           = "peci-dimmtemp",
> +			.of_match_table = of_match_ptr(peci_dimmtemp_of_table),
> +	},
> +};
> +module_platform_driver(peci_dimmtemp_driver);
> +
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("PECI dimmtemp driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.0
> 
