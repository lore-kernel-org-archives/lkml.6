Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFEBI6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:08:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeFEBI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:08:56 -0400
Date: Mon, 4 Jun 2018 18:08:53 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v4 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180605010853.GA47042@localhost.localdomain>
References: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 08:59:05AM +0000, Vadim Pasternak wrote:
> Introduce new Mellanox platform driver to allow access to Mellanox
> programmable device register space trough sysfs interface.
> The driver purpose is to provide sysfs interface for user space for the
> registers essential for system control and monitoring.
> The sets of registers for sysfs access are supposed to be defined per
> system type bases and include the registers related to system resets
> operation, system reset causes monitoring and some kinds of mux selection.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
> v1->v2:
>  Changed added by Vadim:
>  - Change ---help--- to help in Kconfig, according to new requirements;
> v2->v3:
>  Comments pointed out by Darren:
>  - Remove conditional assignment per attribute mode type, because mode
>    will guard against not permitted access.
>    Verified by Vadim.
> ---
>  drivers/platform/mellanox/Kconfig     |  11 ++
>  drivers/platform/mellanox/Makefile    |   1 +
>  drivers/platform/mellanox/mlxreg-io.c | 203 ++++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxreg-io.c
> 
> diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
> index 591bccd..ddfae9fc 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
>  	  This driver handles hot-plug events for the power suppliers, power
>  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
>  
> +config MLXREG_IO
> +	tristate "Mellanox platform register access driver support"
> +	depends on REGMAP
> +	depends on HWMON
> +	help
> +	  This driver allows access to Mellanox programmable device register
> +	  space trough sysfs interface. The sets of registers for sysfs access
> +	  are defined per system type bases and includes the registers related
> +	  to system resets operation, system reset causes monitoring and some
> +	  kinds of mux selection.
> +
>  endif # MELLANOX_PLATFORM
> diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
> index 7c8385e..57074d9c 100644
> --- a/drivers/platform/mellanox/Makefile
> +++ b/drivers/platform/mellanox/Makefile
> @@ -4,3 +4,4 @@
>  # Mellanox Platform-Specific Drivers
>  #
>  obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
> +obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
> diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
> new file mode 100644
> index 0000000..b85452f
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxreg-io.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Mellanox register access driver
> + *
> + * Copyright (C) 2018 Mellanox Technologies
> + * Copyright (C) 2018 Vadim Pasternak <vadimp@mellanox.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_data/mlxreg.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/* Attribute parameters. */
> +#define MLXREG_IO_ATT_SIZE	10
> +#define MLXREG_IO_ATT_NUM	48
> +
> +/**
> + * struct mlxreg_io_priv_data - driver's private data:
> + *
> + * @pdev: platform device;
> + * @pdata: platform data;
> + * @hwmon: hwmon device;
> + * @mlxreg_io_attr: sysfs attributes array;
> + * @mlxreg_io_dev_attr: sysfs sensor device attribute array;
> + * @group: sysfs attribute group;
> + * @groups: list of sysfs attribute group for hwmon registration;
> + */
> +struct mlxreg_io_priv_data {
> +	struct platform_device *pdev;
> +	struct mlxreg_core_platform_data *pdata;
> +	struct device *hwmon;
> +	struct attribute *mlxreg_io_attr[MLXREG_IO_ATT_NUM + 1];
> +	struct sensor_device_attribute mlxreg_io_dev_attr[MLXREG_IO_ATT_NUM];
> +	struct attribute_group group;
> +	const struct attribute_group *groups[2];
> +};
> +
> +static ssize_t
> +mlxreg_io_attr_show(struct device *dev, struct device_attribute *attr,
> +		    char *buf)
> +{
> +	struct mlxreg_io_priv_data *priv = dev_get_drvdata(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
> +	struct mlxreg_core_data *data = priv->pdata->data + index;
> +	u32 regval = 0;
> +	int ret;
> +
> +	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
> +	if (ret)
> +		goto access_error;
> +
> +	if (!data->bit)

I'm finding this difficult to review without any comments regarding what this
and similar conditions are checking for. The struct definition isn't much help
either:

bit: attribute effective bit

I don't know what that means either. What I see is:

If the data->bit is not set...

> +		regval = !!(regval & ~data->mask);

then I will interpret regval as a boolean.

Is that right? Why do we do that?

...
> +static ssize_t
> +mlxreg_io_attr_store(struct device *dev, struct device_attribute *attr,
> +		     const char *buf, size_t len)
> +{
...
> +	ret = kstrtou32(buf, MLXREG_IO_ATT_SIZE, &val);

Do we need to verify len is at least as long as MLXREG_IO_ATT_SIZE?
(seems like we do)

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
> +	if (ret)
> +		goto access_error;
> +
> +	regval &= data->mask;
> +
> +	val = !!val;

>From what I see, this isn't really necessary, but being explicit is
necessarily bad. This isn't a fast path.

> +	if (val)

What does val represent here? Kernel variable naming policy encourages
descriptive names, and val appears to only be used for this one thing -
so what does it mean?

> +		regval |= ~data->mask;
> +	else
> +		regval &= data->mask;
> +
...
> +static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv)
...
> +	for (i = 0; i < priv->pdata->counter; i++) {
> +		priv->mlxreg_io_attr[i] =
> +				&priv->mlxreg_io_dev_attr[i].dev_attr.attr;
> +		memcpy(&priv->mlxreg_io_dev_attr[i].dev_attr,
> +		       &mlxreg_io_devattr_rw, sizeof(struct device_attribute));
> +
> +		/* Set attribute name as a label. */

:-) OK, so this comment is rather obvious from the code.... but where
things are really opaque in the processing above, there are no comments.
Let's focus the comments where the code is non-obvious.


-- 
Darren Hart
VMware Open Source Technology Center
