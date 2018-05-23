Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeEWST6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:19:58 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48466 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeEWST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:19:56 -0400
Date: Wed, 23 May 2018 11:19:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] platform: chrome: Add Tablet Switch ACPI driver
Message-ID: <20180523181954.GA28326@roeck-us.net>
References: <20170130234722.9692-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130234722.9692-1-gwendal@chromium.org>
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

What happened with this driver ? It is not upstream, yet the comments
on patchwork seem to suggest that it was accepted.

Guenter

On Mon, Jan 30, 2017 at 03:47:22PM -0800, Gwendal Grignou wrote:
> Add a kernel driver for GOOG0006, an ACPI driver reporting an event when
> the tablet switch status changes.
> 
> On an ACPI based convertible chromebook check evtest display tablet mode
> switch changes:
> Available devices:
> ..
> /dev/input/event3:      Tablet Mode Switch
> ..
> Testing ... (interrupt to exit)
> Event: time 1484879712.604360, type 5 (EV_SW), code 1 (SW_TABLET_MODE),
> value 1
> Event: time 1484879712.604360, -------------- SYN_REPORT ------------
> Event: time 1484879715.132228, type 5 (EV_SW), code 1 (SW_TABLET_MODE),
> value 0
> Event: time 1484879715.132228, -------------- SYN_REPORT ------------
> ...
> Check state is updated at resume time when different from suspend time.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Acked-by: Benson Leung <bleung@chromium.org>
> ---
> Changes since v2:
>  Rebase on top of linux/master, remove Change-Id
> Changes since v1:
>  Leave tab/space changes in Kconfig to another CL
>  Add resume entry point.
> 
>  drivers/platform/chrome/Kconfig         |  10 +++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/chromeos_tbmc.c | 128 ++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/platform/chrome/chromeos_tbmc.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 76bdae1a93bb..a442828e2093 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -38,6 +38,16 @@ config CHROMEOS_PSTORE
>  	  If you have a supported Chromebook, choose Y or M here.
>  	  The module will be called chromeos_pstore.
>  
> +config CHROMEOS_TBMC
> +	tristate "ChromeOS Tablet Switch Controller"
> +	depends on ACPI
> +	---help---
> +	  This option adds a driver for the tablet switch on
> +	  select Chrome OS systems.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called chromeos_tbmc.
> +
>  config CROS_EC_CHARDEV
>          tristate "Chrome OS Embedded Controller userspace device interface"
>          depends on MFD_CROS_EC
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 4f3462783a3c..d72a15d66f6b 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -1,6 +1,7 @@
>  
>  obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
> +obj-$(CONFIG_CHROMEOS_TBMC)			+= chromeos_tbmc.o
>  cros_ec_devs-objs			:= cros_ec_dev.o cros_ec_sysfs.o \
>  					   cros_ec_lightbar.o cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_devs.o
> diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
> new file mode 100644
> index 000000000000..c87e53319dae
> --- /dev/null
> +++ b/drivers/platform/chrome/chromeos_tbmc.c
> @@ -0,0 +1,128 @@
> +/*
> + * chromeos_tbmc - Driver to detect Tablet Mode for ChromeOS convertible.
> + *
> + * Copyright 2017 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * On Chromebook using ACPI, this device listens for notification
> + * from GOOG0006 and issue method TBMC to retrieve the status.
> + *
> + * GOOG0006 issues the notification when it receives EC_HOST_EVENT_MODE_CHANGE
> + * from the EC.
> + * Method TBMC reads EC_ACPI_MEM_DEVICE_ORIENTATION byte from the shared
> + * memory region.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +#define DRV_NAME "chromeos_tbmc"
> +#define ACPI_DRV_NAME "GOOG0006"
> +
> +static int chromeos_tbmc_query_switch(struct acpi_device *adev,
> +				     struct input_dev *idev)
> +{
> +	unsigned long long state;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(adev->handle, "TBMC", NULL, &state);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	/* input layer checks if event is redundant */
> +	input_report_switch(idev, SW_TABLET_MODE, state);
> +	input_sync(idev);
> +
> +	return 0;
> +}
> +
> +static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +
> +	return chromeos_tbmc_query_switch(adev, adev->driver_data);
> +}
> +
> +static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
> +{
> +	switch (event) {
> +	case 0x80:
> +		chromeos_tbmc_query_switch(adev, adev->driver_data);
> +		break;
> +	default:
> +		dev_err(&adev->dev, "Unexpected event: 0x%08X\n", event);
> +	}
> +}
> +
> +static int chromeos_tbmc_open(struct input_dev *idev)
> +{
> +	struct acpi_device *adev = input_get_drvdata(idev);
> +
> +	return chromeos_tbmc_query_switch(adev, idev);
> +}
> +
> +static int chromeos_tbmc_add(struct acpi_device *adev)
> +{
> +	struct input_dev *idev;
> +	struct device *dev = &adev->dev;
> +	int ret;
> +
> +	idev = devm_input_allocate_device(dev);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->name = "Tablet Mode Switch";
> +	idev->phys = acpi_device_hid(adev);
> +
> +	idev->id.bustype = BUS_HOST;
> +	idev->id.version = 1;
> +	idev->id.product = 0;
> +	idev->open = chromeos_tbmc_open;
> +
> +	input_set_drvdata(idev, adev);
> +	adev->driver_data = idev;
> +
> +	input_set_capability(idev, EV_SW, SW_TABLET_MODE);
> +	ret = input_register_device(idev);
> +	if (ret) {
> +		dev_err(dev, "cannot register input device\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
> +	{ ACPI_DRV_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
> +
> +static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
> +		chromeos_tbmc_resume);
> +
> +static struct acpi_driver chromeos_tbmc_driver = {
> +	.name = DRV_NAME,
> +	.class = DRV_NAME,
> +	.ids = chromeos_tbmc_acpi_device_ids,
> +	.ops = {
> +		.add = chromeos_tbmc_add,
> +		.notify = chromeos_tbmc_notify,
> +	},
> +	.drv.pm = &chromeos_tbmc_pm_ops,
> +};
> +
> +module_acpi_driver(chromeos_tbmc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS ACPI tablet switch driver");
