Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2328C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D2321770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D2321770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbeHGSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:55:47 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:49139 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389292AbeHGSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:55:47 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54004 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fn529-00049G-W4; Tue, 07 Aug 2018 18:40:33 +0200
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
To:     Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-2-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <634ea7d9-7cc1-f404-b072-0bafbc748fb7@tronnes.org>
Date:   Tue, 7 Aug 2018 18:40:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802194536.10820-2-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Den 02.08.2018 21.45, skrev Sam Ravnborg:
> The pardata supports implement a simple bus for devices
> that are connected using a parallel bus driven by GPIOs.
> The is often used in combination with simple displays
> that is often seen in older embedded designs.
> There is a demand for this support also in the linux
> kernel for HW designs that uses these kind of displays.
>
> The pardata bus uses a platfrom_driver that when probed
> creates devices for all child nodes in the DT,
> which are then supposed to be handled by pardata_drivers.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---

 From a quick look at this I have these comments:
1. There can only be one implementation of this bus, the gpio one.
    There are SOC's with parallel bus hardware so you need to allow for
    more implementations.
2. The client shouldn't do the bus signaling. This should be hidden
    behind read and write functions in pardata.
3. I would also suggest you add an address bus instead of the RS pin
4. I don't think reset belongs in the bus. It's a device thing.
5. You can use gpiod_set_array_value() in the gpio implementation.
    Some gpio drivers can set all gpios at once.

I made an attempt at implementing a bus like this a while back:
https://github.com/notro/fbdbi/tree/master/i80

Noralf.

>   Documentation/driver-api/index.rst   |   1 +
>   Documentation/driver-api/pardata.rst |  60 ++++++++
>   MAINTAINERS                          |   9 ++
>   drivers/Kconfig                      |   2 +
>   drivers/Makefile                     |   1 +
>   drivers/pardata/Kconfig              |  17 +++
>   drivers/pardata/Makefile             |   5 +
>   drivers/pardata/pardata.c            | 282 +++++++++++++++++++++++++++++++++++
>   include/linux/pardata.h              | 138 +++++++++++++++++
>   9 files changed, 515 insertions(+)
>   create mode 100644 Documentation/driver-api/pardata.rst
>   create mode 100644 drivers/pardata/Kconfig
>   create mode 100644 drivers/pardata/Makefile
>   create mode 100644 drivers/pardata/pardata.c
>   create mode 100644 include/linux/pardata.h
>
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 6d9f2f9fe20e..1808fca406ae 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -41,6 +41,7 @@ available subsections can be seen below.
>      miscellaneous
>      w1
>      rapidio
> +   pardata
>      s390-drivers
>      vme
>      80211/index
> diff --git a/Documentation/driver-api/pardata.rst b/Documentation/driver-api/pardata.rst
> new file mode 100644
> index 000000000000..a811f024a0fe
> --- /dev/null
> +++ b/Documentation/driver-api/pardata.rst
> @@ -0,0 +1,60 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +Parallel Data Bus/Drivers
> +=========================
> +
> +Displays may be connected using a simple parallel bus.
> +This is often seen in embedded systems with a simple MCU, but is also
> +used in Linux based systems to a small extent.
> +
> +The bus looks like this:
> +
> +.. code-block:: none
> +
> +       ----+
> +           |  DB0-DB7 or DB4-DB7      +----
> +           ===/========================
> +           |  E - enable              |  D
> +           ----------------------------  I
> +        C  |  Reset                   |  S
> +        P  ----------------------------  P
> +        U  |  Read/Write (one or two) |  L
> +           ----------------------------  A
> +           |  RS - instruction/data   |  Y
> +           ----------------------------
> +           |                          +----
> +       ----+
> +
> +There may be several devices connected to the bus with individual
> +reset and read/write signals.
> +Two types of interfaces are supported. 8800 with a single read/write signal,
> +and 6800 with individual read/write signals.
> +
> +Display supported by the parallel data bus: `<https://www.sparkfun.com/products/710>`_
> +
> +The overall code structure is
> +
> +.. code-block:: none
> +
> +  platform_device [pardata bus]   <--- pardatabus [driver]
> +       |
> +       +-> device
> +             |
> +             +-> pardata_bus_data
> +
> +  pardata_device
> +      |
> +      +-> device
> +            |
> +            +->
> +
> +  pardatabus_bus
> +
> +
> +API documentation
> +=================
> +.. kernel-doc:: include/linux/pardata.h
> +   :internal:
> +.. kernel-doc:: drivers/pardata/pardata.c
> +   :internal:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96e98e206b0d..4ba7ff7c3e46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10727,6 +10727,15 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	drivers/platform/x86/panasonic-laptop.c
>   
> +PARALLEL DATA SUBSYSTEM
> +M:	Sam Ravnborg <sam@ravnborg.org>
> +S:	Maintained
> +F:	drivers/pardata/
> +F:	include/linux/pardata.h
> +F:	drivers/gpu/drm/tinydrm/pardata-dbi.c
> +F:	include/drm/pardata-dbi.h
> +F:	Documentation/driver-api/pardata.rst
> +
>   PARALLEL LCD/KEYPAD PANEL DRIVER
>   M:	Willy Tarreau <willy@haproxy.com>
>   M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 95b9ccc08165..b51b25aae9a5 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -217,4 +217,6 @@ source "drivers/siox/Kconfig"
>   
>   source "drivers/slimbus/Kconfig"
>   
> +source "drivers/pardata/Kconfig"
> +
>   endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..cfe7945f2f6b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_CONNECTOR)		+= connector/
>   obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
>   obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
>   
> +obj-$(CONFIG_PARDATA)		+= pardata/
>   obj-$(CONFIG_PARPORT)		+= parport/
>   obj-$(CONFIG_NVM)		+= lightnvm/
>   obj-y				+= base/ block/ misc/ mfd/ nfc/
> diff --git a/drivers/pardata/Kconfig b/drivers/pardata/Kconfig
> new file mode 100644
> index 000000000000..5a4280a3f85a
> --- /dev/null
> +++ b/drivers/pardata/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Parallel Data Bus framework
> +#
> +menuconfig PARDATA
> +	tristate "Parallel Data support"
> +	help
> +	  The parallel data framework is used for devices communicating
> +	  with a simple parallel interface.
> +	  The interface include 8 data pins, one register select,
> +	  one enable pin, a chip select and a reset pin.
> +	  The read/write may be 8080 style (one r/w pin) or 6800 style
> +	  with separate read and write pins.
> +	  The parallel data bus is often used for displays in embedded
> +	  systems.
> +
> +	  If unsure, choose N.
> diff --git a/drivers/pardata/Makefile b/drivers/pardata/Makefile
> new file mode 100644
> index 000000000000..0e48bd648879
> --- /dev/null
> +++ b/drivers/pardata/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for kernel Parallel Data subsystem
> +#
> +obj-$(CONFIG_PARDATA) += pardata.o
> diff --git a/drivers/pardata/pardata.c b/drivers/pardata/pardata.c
> new file mode 100644
> index 000000000000..985d692c116a
> --- /dev/null
> +++ b/drivers/pardata/pardata.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Sam Ravnborg
> + *
> + * Author: Sam Ravnborg <sam@ravnborg.org>
> + */
> +
> +/**
> + * DOC: Bus driver for parallel data bus
> + *
> + * The parallel data bus is often used for displays
> + * in embedded designs and is sometimes also used
> + * in designs supporting Linux.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/pardata.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +
> +static struct pardata_device *
> +pardata_device_create(struct pardatabus_data *pdbus)
> +{
> +	struct pardata_device *pddev;
> +
> +	/* We allocate the device, and initialize the default values */
> +	pddev = kzalloc(sizeof(*pddev), GFP_KERNEL);
> +	if (!pddev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pddev->dev.parent = pdbus->dev;
> +	pddev->dev.bus = &pardata_bus;
> +
> +	dev_set_name(&pddev->dev, "pardata");
> +
> +	device_initialize(&pddev->dev);
> +
> +	return pddev;
> +}
> +
> +static void pardata_device_release(struct pardata_device *ppdev)
> +{
> +	kfree(ppdev);
> +}
> +
> +int pardata_device_register(struct pardata_device *pddev)
> +{
> +	return device_add(&pddev->dev);
> +}
> +
> +static int of_pdbus_register_device(struct pardatabus_data *pdbus,
> +				    struct device_node *np)
> +{
> +	struct pardata_device *pddev;
> +	int ret;
> +	u32 id;
> +
> +	pddev = pardata_device_create(pdbus);
> +	if (IS_ERR(pddev))
> +		return PTR_ERR(pddev);
> +
> +	/* The reg property is used as id */
> +	ret = of_property_read_u32(np, "reg", &id);
> +	if (ret) {
> +		dev_err(pdbus->dev, "Failed to read the 'reg' property");
> +		pardata_device_release(pddev);
> +		return ret;
> +	}
> +	pddev->id = id;
> +
> +	/*
> +	 *  Associate the OF node with the device structure so it
> +	 * can be looked up later.
> +	 */
> +	of_node_get(np);
> +	pddev->dev.of_node = np;
> +
> +	/* All data is now stored in the pardata_device struct; register it. */
> +	ret = pardata_device_register(pddev);
> +	if (ret) {
> +		pardata_device_release(pddev);
> +		of_node_put(np);
> +		return ret;
> +	}
> +
> +	dev_dbg(&pddev->dev, "registered pardata device %s with id %i\n",
> +		np->name, id);
> +	return 0;
> +}
> +
> +static void pdbus_unregister(void)
> +{
> +	bus_unregister(&pardata_bus);
> +}
> +
> +/**
> + * of_pardata_register - Register pardatabus and create devices from DT
> + *
> + * @pdbus: pointer to pardatabus_data structure
> + *
> + * This function registers the pardatabus_data structure and registers
> + * a pardata_device for each child node of @np.
> + */
> +int of_pardata_register(struct pardatabus_data *pdbus)
> +{
> +	struct device_node *child;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = pdbus->dev->of_node;
> +
> +	/* Do not continue if the node is not available or disabled */
> +	if (!np || !of_device_is_available(np))
> +		return -ENODEV;
> +
> +	/* Register the parallel data bus */
> +	ret = bus_register(&pardata_bus);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Loop over the child nodes and register a
> +	 * pardata_device for each node
> +	 */
> +	for_each_available_child_of_node(np, child) {
> +		ret = of_pdbus_register_device(pdbus, child);
> +
> +		if (ret == -ENODEV)
> +			dev_err(pdbus->dev, "pardata device missing.\n");
> +		else if (ret)
> +			goto unregister;
> +	}
> +	return 0;
> +
> +unregister:
> +	pdbus_unregister();
> +	return ret;
> +}
> +
> +static int pardata_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	/* OF style match */
> +	if (of_match_device(drv->of_match_table, dev) != NULL)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int pardata_device_probe(struct device *dev)
> +{
> +	struct pardata_device *pddev;
> +	struct pardata_driver *pddrv;
> +
> +	pddev = to_pardata_device(dev);
> +	pddrv = to_pardata_driver(dev->driver);
> +
> +	return pddrv->probe(pddev);
> +}
> +
> +struct bus_type pardata_bus = {
> +	.name		= "pardata",
> +	.match		= pardata_device_match,
> +	.probe		= pardata_device_probe,
> +};
> +EXPORT_SYMBOL_GPL(pardata_bus);
> +
> +/*
> + * __pardata_driver_register() - Client driver registration
> + *
> + * @drv:Client driver to be associated with client-device.
> + * @owner: owning module/driver
> + *
> + * Do not call this direct, use pardata_driver_register()
> + */
> +int __pardata_driver_register(struct pardata_driver *drv, struct module *owner)
> +{
> +	/* probe is mandatory */
> +	if (!drv->probe)
> +		return -EINVAL;
> +
> +	drv->driver.bus = &pardata_bus;
> +	drv->driver.owner = owner;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__pardata_driver_register);
> +
> +/*
> + * Use a simple pardatabus driver to create the pardata
> + * devices from child nodes in DT.
> + *
> + * The pardatabus driver parses the properties in the
> + * device tree that will be used by the pardata drivers.
> + */
> +static int pardatabus_probe(struct platform_device *pdev)
> +{
> +	struct pardatabus_data *pdbus;
> +	struct gpio_descs *pins;
> +	struct gpio_desc *pin;
> +	struct device *dev;
> +
> +	dev = &pdev->dev;
> +
> +	pdbus = devm_kzalloc(dev, sizeof(*pdbus), GFP_KERNEL);
> +	if (!pdbus)
> +		return -ENOMEM;
> +
> +	pdbus->dev = &pdev->dev;
> +	dev_set_drvdata(dev, pdbus);
> +
> +	/* Get the mandatory bus details from DT */
> +	pins = devm_gpiod_get_array(dev, "data-gpios", GPIOD_OUT_LOW);
> +	if (IS_ERR(pins)) {
> +		dev_err(dev, "Failed to get gpio 'data-gpios'");
> +		return PTR_ERR(pins);
> +	}
> +	if (pins->ndescs != 4 && pins->ndescs != 8) {
> +		dev_err(dev, "Invalid number of data-gpios %d - expected 4 or 8\n",
> +			    pins->ndescs);
> +		return -EINVAL;
> +	}
> +	pdbus->data_pins = pins;
> +
> +	pin = devm_gpiod_get(dev, "enable-gpios", GPIOD_OUT_LOW);
> +	if (IS_ERR(pin)) {
> +		dev_err(dev, "Failed to get gpio 'enable-gpios'\n");
> +		return PTR_ERR(pin);
> +	}
> +	pdbus->pin_enable = pin;
> +
> +	pin = devm_gpiod_get(dev, "rs-gpios", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pin)) {
> +		dev_err(dev, "Failed to get gpio 'rs-gpios'\n");
> +		return PTR_ERR(pin);
> +	}
> +	pdbus->pin_rs = pin;
> +
> +	pin = devm_gpiod_get(dev, "rw-gpios", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pin)) {
> +		dev_err(dev, "Failed to get gpio 'rw-gpios'\n");
> +		return PTR_ERR(pin);
> +	}
> +	pdbus->pin_readwrite = pin;
> +
> +	pin = devm_gpiod_get(dev, "read-gpios", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pin)) {
> +		dev_err(dev, "Failed to get gpio 'read-gpios'\n");
> +		return PTR_ERR(pin);
> +	}
> +	pdbus->pin_read = pin;
> +
> +	pin = devm_gpiod_get(dev, "write-gpios", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pin)) {
> +		dev_err(dev, "Failed to get gpio 'write-gpios'\n");
> +		return PTR_ERR(pin);
> +	}
> +	pdbus->pin_write = pin;
> +
> +	return of_pardata_register(pdbus);
> +}
> +
> +static const struct of_device_id pardata_bus_dt_ids[] = {
> +	{ .compatible = "parallel-data-bus", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver pardatabus_driver = {
> +	.driver	 = {
> +		.name   = "pardatabus",
> +		.of_match_table = pardata_bus_dt_ids,
> +	},
> +	.probe = pardatabus_probe,
> +};
> +module_platform_driver(pardatabus_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Parallel Data Bus");
> diff --git a/include/linux/pardata.h b/include/linux/pardata.h
> new file mode 100644
> index 000000000000..888a1c88176e
> --- /dev/null
> +++ b/include/linux/pardata.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 Sam Ravnborg
> + */
> +
> +#ifndef _LINUX_PARDATA_H
> +#define _LINUX_PARDATA_H
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +extern struct bus_type pardata_bus;
> +
> +/**
> + * struct pardatabus_data - private data for the pardata bus
> + *
> + * Drivers uses these data when usung the pins that are part of
> + * the bus.
> + */
> +struct pardatabus_data {
> +	/**
> +	 * @dev: device node that represent the DT node of the bus
> +	 */
> +	struct device *dev;
> +
> +	/**
> +	 * @data_pins: The 8 or 4 GPIOs used for data
> +	 */
> +	struct gpio_descs *data_pins;
> +
> +	/**
> +	 * @pin_enable: The enable pin (mandatory)
> +	 */
> +	struct gpio_desc *pin_enable;
> +
> +	/**
> +	 * @pin_rs: register select (0: instruction 1: data)
> +	 */
> +	struct gpio_desc *pin_rs;
> +
> +	/**
> +	 * @pin_readwrite: readwrite pin for 8080 style interface
> +	 */
> +	struct gpio_desc *pin_readwrite;
> +
> +	/**
> +	 * @pin_read: read pin for 6800 style interface
> +	 */
> +	struct gpio_desc *pin_read;
> +
> +	/**
> +	 * @pin_write: write pin for 6800 style interface
> +	 */
> +	struct gpio_desc *pin_write;
> +};
> +
> +static inline struct pardatabus_data *to_pardatabus_data(struct device *d)
> +{
> +	return container_of(d, struct pardatabus_data, dev);
> +}
> +
> +/**
> + * struct pardata_device - pardata device handle.
> + * @dev: Driver model representation of the device.
> + *
> + * This is the device handle returned when a pardata
> + * device is registered.
> + * The id comes from the DT
> + *
> + * @dev: The device
> + * @id: Id of the device (from DT)
> + */
> +struct pardata_device {
> +	struct device dev;
> +	u32	   id;
> +};
> +
> +static inline struct pardata_device *to_pardata_device(struct device *d)
> +{
> +	return container_of(d, struct pardata_device, dev);
> +}
> +
> +static inline void *pardata_dev_get_drvdata(const struct pardata_device *pdd)
> +{
> +	return dev_get_drvdata(&pdd->dev);
> +}
> +
> +static inline void pardata_dev_set_drvdata(struct pardata_device *pdd,
> +					    void *data)
> +{
> +	dev_set_drvdata(&pdd->dev, data);
> +}
> +
> +/**
> + * struct pardata_driver - pardata 'generic device'
> + *			(similar to 'spi_device' on SPI)
> + *
> + * @driver: generic device driver
> + *	  pardata drivers must initialize name, owner and of_match_table
> + *	  of this structure
> + * @probe: Binds this driver to a pardata bus.
> + * @shutdown: Standard shutdown callback used during powerdown/halt.
> + */
> +struct pardata_driver {
> +	struct device_driver driver;
> +	int   (*probe)(struct pardata_device *pdd);
> +	void  (*shutdown)(struct pardata_device *pdd);
> +};
> +
> +static inline struct pardata_driver *to_pardata_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct pardata_driver, driver);
> +}
> +
> +/* Use macro for driver registering to get simple access to THIS_MODULE */
> +#define pardata_driver_register(drv) \
> +	__pardata_driver_register(drv, THIS_MODULE)
> +int __pardata_driver_register(struct pardata_driver *drv, struct module *owner);
> +
> +static inline void pardata_driver_unregister(struct pardata_driver *drv)
> +{
> +	return driver_unregister(&drv->driver);
> +}
> +
> +/**
> + * module_pardata_driver() - Helper macro for registering a parallel data driver
> + * @__pardata_driver: pardatabus_driver struct
> + *
> + * Helper macro for parallel data drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module may
> + * only use this macro once, and calling it replaces module_init() and
> + * module_exit()
> + */
> +#define module_pardata_driver(__pardata_driver) \
> +	module_driver(__pardata_driver, pardata_driver_register, \
> +			pardata_driver_unregister)
> +
> +#endif /* _LINUX_PARDATA_H */

