Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeCXReH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeCXReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:34:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182ED2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:33:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
Message-ID: <20180324173358.571e2fd8@archlinux>
In-Reply-To: <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
 <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:42:23 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the Generic Counter interface for supporting
> counter devices.
> 
> In the context of the Generic Counter interface, a counter is defined as
> a device that reports one or more "counts" based on the state changes of
> one or more "signals" as evaluated by a defined "count function."
> 
> Driver callbacks should be provided to communicate with the device: to
> read and write various Signals and Counts, and to set and get the
> "action mode" and "count function" for various Synapses and Counts
> respectively.
> 
> To support a counter device, a driver must first allocate the available
> Counter Signals via counter_signal structures. These Signals should
> be stored as an array and set to the signals array member of an
> allocated counter_device structure before the Counter is registered to
> the system.
> 
> Counter Counts may be allocated via counter_count structures, and
> respective Counter Signal associations (Synapses) made via
> counter_synapse structures. Associated counter_synapse structures are
> stored as an array and set to the the synapses array member of the
> respective counter_count structure. These counter_count structures are
> set to the counts array member of an allocated counter_device structure
> before the Counter is registered to the system.
> 
> A counter device is registered to the system by passing the respective
> initialized counter_device structure to the counter_register function;
> similarly, the counter_unregister function unregisters the respective
> Counter. The devm_counter_register and devm_counter_unregister functions
> serve as device memory-managed versions of the counter_register and
> counter_unregister functions respectively.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,

I would leave the existing drivers where they are until you are ready
to convert them.  I.e. Do the moves as separate patches from this one
as it just adds noise here and they aren't ready immediately.

The externs in the header add code for no benefit and make it hard
to align the parameters nicely. I would drop them all.

Few other minor bits and bobs inline.  There is a lot of 'automatic'
cleanup in here, but I think you have missed a few cases where the
attribute element hasn't 'yet' been added to the list. (I may be
missing something)

Fundamentally looks good though.

Jonathan

> ---
>  MAINTAINERS                                   |    7 +
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    1 +
>  drivers/{iio => }/counter/104-quad-8.c        |    0
>  drivers/{iio => }/counter/Kconfig             |   23 +-
>  drivers/{iio => }/counter/Makefile            |    5 +-
>  drivers/counter/generic-counter.c             | 1416 +++++++++++++++++++++++++
>  drivers/{iio => }/counter/stm32-lptimer-cnt.c |    0
>  drivers/iio/Kconfig                           |    1 -
>  drivers/iio/Makefile                          |    1 -
>  include/linux/counter.h                       |  524 +++++++++
>  11 files changed, 1973 insertions(+), 7 deletions(-)
>  rename drivers/{iio => }/counter/104-quad-8.c (100%)
>  rename drivers/{iio => }/counter/Kconfig (56%)
>  rename drivers/{iio => }/counter/Makefile (62%)
>  create mode 100644 drivers/counter/generic-counter.c
>  rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (100%)
>  create mode 100644 include/linux/counter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 885d20072d97..2be01a95b7a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3668,6 +3668,13 @@ W:	http://www.fi.muni.cz/~kas/cosa/
>  S:	Maintained
>  F:	drivers/net/wan/cosa*
>  
> +COUNTER SUBSYSTEM
> +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/counter/
> +F:	include/linux/counter.h
> +
>  CPMAC ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 879dc0604cba..21a67f49c17b 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -165,6 +165,8 @@ source "drivers/memory/Kconfig"
>  
>  source "drivers/iio/Kconfig"
>  
> +source "drivers/counter/Kconfig"
> +
>  source "drivers/ntb/Kconfig"
>  
>  source "drivers/vme/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..5914c78688c3 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -165,6 +165,7 @@ obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
>  obj-$(CONFIG_EXTCON)		+= extcon/
>  obj-$(CONFIG_MEMORY)		+= memory/
>  obj-$(CONFIG_IIO)		+= iio/
> +obj-$(CONFIG_COUNTER)		+= counter/
>  obj-$(CONFIG_VME_BUS)		+= vme/
>  obj-$(CONFIG_IPACK_BUS)		+= ipack/
>  obj-$(CONFIG_NTB)		+= ntb/
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> similarity index 100%
> rename from drivers/iio/counter/104-quad-8.c
> rename to drivers/counter/104-quad-8.c
> diff --git a/drivers/iio/counter/Kconfig b/drivers/counter/Kconfig
> similarity index 56%
> rename from drivers/iio/counter/Kconfig
> rename to drivers/counter/Kconfig
> index 474e1ac4e7c0..0b28d3ff524b 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -3,11 +3,25 @@
>  #
>  # When adding new entries keep the list in alphabetical order
>  
> -menu "Counters"
> +menuconfig COUNTER
> +	tristate "Counter support"
> +	help
> +	  Provides Generic Counter interface support for counter devices.
> +
> +	  Counter devices are prevalent within a diverse spectrum of industries.
> +	  The ubiquitous presence of these devices necessitates a common
> +	  interface and standard of interaction and exposure. This driver API
> +	  attempts to resolve the issue of duplicate code found among existing
> +	  counter device drivers by providing a generic counter interface for
> +	  consumption. The Generic Counter interface enables drivers to support
> +	  and expose a common set of components and functionality present in
> +	  counter devices.
> +
> +if COUNTER
>  
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> -	depends on PC104 && X86 && ISA_BUS_API
> +	depends on PC104 && X86 && ISA_BUS_API && IIO
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
>  	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
> @@ -23,11 +37,12 @@ config 104_QUAD_8
>  
>  config STM32_LPTIMER_CNT
>  	tristate "STM32 LP Timer encoder counter driver"
> -	depends on MFD_STM32_LPTIMER || COMPILE_TEST
> +	depends on (MFD_STM32_LPTIMER || COMPILE_TEST) && IIO
>  	help
>  	  Select this option to enable STM32 Low-Power Timer quadrature encoder
>  	  and counter driver.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer-cnt.
> -endmenu
> +
> +endif # COUNTER
> diff --git a/drivers/iio/counter/Makefile b/drivers/counter/Makefile
> similarity index 62%
> rename from drivers/iio/counter/Makefile
> rename to drivers/counter/Makefile
> index 1b9a896eb488..d721a40aa4a2 100644
> --- a/drivers/iio/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -1,8 +1,11 @@
>  #
> -# Makefile for IIO counter devices
> +# Makefile for Counter devices
>  #
>  
>  # When adding new entries keep the list in alphabetical order
>  
> +obj-$(CONFIG_COUNTER) += counter.o
> +counter-y := generic-counter.o
> +
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> diff --git a/drivers/counter/generic-counter.c b/drivers/counter/generic-counter.c
> new file mode 100644
> index 000000000000..03803356aac8
> --- /dev/null
> +++ b/drivers/counter/generic-counter.c
> @@ -0,0 +1,1416 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic Counter interface
> + * Copyright (C) 2017 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/counter.h>
> +
> +ssize_t counter_signal_enum_read(struct counter_device *counter,
> +	struct counter_signal *signal, void *priv, char *buf)
> +{
> +	const struct counter_signal_enum_ext *const e = priv;
> +	int err;
> +	size_t index;
> +
> +	if (!e->get)
> +		return -EINVAL;
> +
> +	err = e->get(counter, signal, &index);
> +	if (err)
> +		return err;
> +
> +	if (index >= e->num_items)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", e->items[index]);
> +}
> +EXPORT_SYMBOL(counter_signal_enum_read);
> +
> +ssize_t counter_signal_enum_write(struct counter_device *counter,
> +	struct counter_signal *signal, void *priv, const char *buf, size_t len)
> +{
> +	const struct counter_signal_enum_ext *const e = priv;
> +	ssize_t index;
> +	int err;
> +
> +	if (!e->set)
> +		return -EINVAL;
> +
> +	index = __sysfs_match_string(e->items, e->num_items, buf);
> +	if (index < 0)
> +		return index;
> +
> +	err = e->set(counter, signal, index);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_signal_enum_write);
> +
> +ssize_t counter_signal_enum_available_read(struct counter_device *counter,
> +	struct counter_signal *signal, void *priv, char *buf)
> +{
> +	const struct counter_signal_enum_ext *const e = priv;
> +	size_t i;
> +	size_t len = 0;
> +
> +	if (!e->num_items)
> +		return 0;
> +
> +	for (i = 0; i < e->num_items; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +			e->items[i]);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_signal_enum_available_read);
> +
> +ssize_t counter_count_enum_read(struct counter_device *counter,
> +	struct counter_count *count, void *priv, char *buf)
> +{
> +	const struct counter_count_enum_ext *const e = priv;
> +	int err;
> +	size_t index;
> +
> +	if (!e->get)
> +		return -EINVAL;
> +
> +	err = e->get(counter, count, &index);
> +	if (err)
> +		return err;
> +
> +	if (index >= e->num_items)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", e->items[index]);
> +}
> +EXPORT_SYMBOL(counter_count_enum_read);
> +
> +ssize_t counter_count_enum_write(struct counter_device *counter,
> +	struct counter_count *count, void *priv, const char *buf, size_t len)
> +{
> +	const struct counter_count_enum_ext *const e = priv;
> +	ssize_t index;
> +	int err;
> +
> +	if (!e->set)
> +		return -EINVAL;
> +
> +	index = __sysfs_match_string(e->items, e->num_items, buf);
> +	if (index < 0)
> +		return index;
> +
> +	err = e->set(counter, count, index);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_count_enum_write);
> +
> +ssize_t counter_count_enum_available_read(struct counter_device *counter,
> +	struct counter_count *count, void *priv, char *buf)
> +{
> +	const struct counter_count_enum_ext *const e = priv;
> +	size_t i;
> +	size_t len = 0;
> +
> +	if (!e->num_items)
> +		return 0;
> +
> +	for (i = 0; i < e->num_items; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +			e->items[i]);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_count_enum_available_read);
> +
> +ssize_t counter_device_enum_read(struct counter_device *counter, void *priv,
> +	char *buf)
> +{
> +	const struct counter_device_enum_ext *const e = priv;
> +	int err;
> +	size_t index;
> +
> +	if (!e->get)
> +		return -EINVAL;
> +
> +	err = e->get(counter, &index);
> +	if (err)
> +		return err;
> +
> +	if (index >= e->num_items)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", e->items[index]);
> +}
> +EXPORT_SYMBOL(counter_device_enum_read);
> +
> +ssize_t counter_device_enum_write(struct counter_device *counter, void *priv,
> +	const char *buf, size_t len)
> +{
> +	const struct counter_device_enum_ext *const e = priv;
> +	ssize_t index;
> +	int err;
> +
> +	if (!e->set)
> +		return -EINVAL;
> +
> +	index = __sysfs_match_string(e->items, e->num_items, buf);
> +	if (index < 0)
> +		return index;
> +
> +	err = e->set(counter, index);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_device_enum_write);
> +
> +ssize_t counter_device_enum_available_read(struct counter_device *counter,
> +	void *priv, char *buf)
> +{
> +	const struct counter_device_enum_ext *const e = priv;
> +	size_t i;
> +	size_t len = 0;
> +
> +	if (!e->num_items)
> +		return 0;
> +
> +	for (i = 0; i < e->num_items; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +			e->items[i]);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(counter_device_enum_available_read);
> +
> +static const char *const signal_level_str[] = {
> +	[SIGNAL_LEVEL_LOW] = "low",
> +	[SIGNAL_LEVEL_HIGH] = "high"
> +};
> +
> +/**
> + * set_signal_read_value - set signal_read_value data
> + * @val:	signal_read_value structure to set
> + * @type:	property Signal data represents
> + * @data:	Signal data
> + *
> + * This function sets an opaque signal_read_value structure with the provided
> + * Signal data.
> + */
> +void set_signal_read_value(struct signal_read_value *const val,
> +	const enum signal_value_type type, void *const data)
> +{
> +	if (type == SIGNAL_LEVEL)
> +		val->len = scnprintf(val->buf, PAGE_SIZE, "%s\n",
> +			signal_level_str[*(enum signal_level *)data]);
> +	else
> +		val->len = 0;
> +}
> +EXPORT_SYMBOL(set_signal_read_value);
> +
> +/**
> + * set_count_read_value - set count_read_value data
> + * @val:	count_read_value structure to set
> + * @type:	property Count data represents
> + * @data:	Count data
> + *
> + * This function sets an opaque count_read_value structure with the provided
> + * Count data.
> + */
> +void set_count_read_value(struct count_read_value *const val,
> +	const enum count_value_type type, void *const data)
> +{
> +	switch (type) {
> +	case COUNT_POSITION_UNSIGNED:
> +		val->len = scnprintf(val->buf, PAGE_SIZE, "%lu\n",
> +			*(unsigned long *)data);
> +		break;
> +	case COUNT_POSITION_SIGNED:
> +		val->len = scnprintf(val->buf, PAGE_SIZE, "%ld\n",
> +			*(long *)data);
> +		break;
> +	default:
> +		val->len = 0;
> +	}
> +}
> +EXPORT_SYMBOL(set_count_read_value);
> +
> +/**
> + * get_count_write_value - get count_write_value data
> + * @data:	Count data
> + * @type:	property Count data represents
> + * @val:	count_write_value structure containing data
> + *
> + * This function extracts Count data from the provided opaque count_write_value
> + * structure and stores it at the address provided by @data.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int get_count_write_value(void *const data,
> +	const enum count_value_type type,
> +	const struct count_write_value *const val)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case COUNT_POSITION_UNSIGNED:
> +		err = kstrtoul(val->buf, 0, data);
> +		if (err)
> +			return err;
> +		break;
> +	case COUNT_POSITION_SIGNED:
> +		err = kstrtol(val->buf, 0, data);
> +		if (err)
> +			return err;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(get_count_write_value);
> +
> +struct counter_device_attr {
> +	struct device_attribute		dev_attr;
> +	struct list_head		l;
> +	void				*component;
> +};
> +
> +static int counter_attribute_create(
> +	struct counter_device_attr_group *const group,
> +	const char *const prefix,
> +	const char *const name,
> +	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
> +		char *buf),
> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t len),
> +	void *const component)
> +{
> +	struct counter_device_attr *counter_attr;
> +	struct device_attribute *dev_attr;
> +	int err;
> +	struct list_head *const attr_list = &group->attr_list;
> +
> +	/* Allocate a Counter device attribute */
> +	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> +	if (!counter_attr)
> +		return -ENOMEM;
> +	dev_attr = &counter_attr->dev_attr;
> +
> +	sysfs_attr_init(&dev_attr->attr);
> +
> +	/* Configure device attribute */
> +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, name);
> +	if (!dev_attr->attr.name) {
> +		err = -ENOMEM;
> +		goto err_free_counter_attr;
> +	}
> +	if (show) {
> +		dev_attr->attr.mode |= 0444;
> +		dev_attr->show = show;
> +	}
> +	if (store) {
> +		dev_attr->attr.mode |= 0200;
> +		dev_attr->store = store;
> +	}
> +
> +	/* Store associated Counter component with attribute */
> +	counter_attr->component = component;
> +
> +	/* Keep track of the attribute for later cleanup */
> +	list_add(&counter_attr->l, attr_list);
> +	group->num_attr++;
> +
> +	return 0;
> +
> +err_free_counter_attr:
> +	kfree(counter_attr);
> +	return err;
> +}
> +
> +#define to_counter_attr(_dev_attr) \
> +	container_of(_dev_attr, struct counter_device_attr, dev_attr)
> +
> +struct signal_comp_t {
> +	struct counter_signal	*signal;
> +};
> +
> +static ssize_t counter_signal_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_comp_t *const component = devattr->component;
> +	struct counter_signal *const signal = component->signal;
> +	int err;
> +	struct signal_read_value val = { .buf = buf };
> +
> +	err = counter->signal_read(counter, signal, &val);
> +	if (err)
> +		return err;
> +
> +	return val.len;
> +}
> +
> +struct name_comp_t {
> +	const char	*name;
> +};
> +
> +static ssize_t counter_device_attr_name_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct name_comp_t *const comp = to_counter_attr(attr)->component;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", comp->name);
> +}
> +
> +struct signal_ext_comp_t {
> +	struct counter_signal		*signal;
> +	const struct counter_signal_ext	*ext;
> +};
> +
> +static ssize_t counter_signal_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_ext_comp_t *const component = devattr->component;
> +	const struct counter_signal_ext *const ext = component->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = component->signal;
> +
> +	return ext->read(counter, signal, ext->priv, buf);
> +}
> +
> +static ssize_t counter_signal_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_ext_comp_t *const component = devattr->component;
> +	const struct counter_signal_ext *const ext = component->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_signal *const signal = component->signal;
> +
> +	return ext->write(counter, signal, ext->priv, buf, len);
> +}
> +
> +static int counter_signal_ext_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_signal *const signal)
> +{
> +	const size_t num_ext = signal->num_ext;
> +	size_t i;
> +	const struct counter_signal_ext *ext;
> +	struct signal_ext_comp_t *signal_ext_comp;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!signal->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = signal->ext + i;
> +
> +		/* Allocate signal_ext attribute component */
> +		signal_ext_comp = kmalloc(sizeof(*signal_ext_comp), GFP_KERNEL);
> +		if (!signal_ext_comp)
> +			return -ENOMEM;
> +		signal_ext_comp->signal = signal;
> +		signal_ext_comp->ext = ext;
> +
> +		/* Allocate a Counter device attribute */
> +		err = counter_attribute_create(group, "", ext->name,
> +			(ext->read) ? counter_signal_ext_show : NULL,
> +			(ext->write) ? counter_signal_ext_store : NULL,
> +			signal_ext_comp);
> +		if (err) {
> +			kfree(signal_ext_comp);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_signal_attributes_create(
> +	struct counter_device_attr_group *const group,
> +	const struct counter_device *const counter,
> +	struct counter_signal *const signal)
> +{
> +	struct signal_comp_t *signal_comp;
> +	int err;
> +	struct name_comp_t *name_comp;
> +
> +	/* Allocate Signal attribute component */
> +	signal_comp = kmalloc(sizeof(*signal_comp), GFP_KERNEL);
> +	if (!signal_comp)
> +		return -ENOMEM;
> +	signal_comp->signal = signal;
> +
> +	/* Create main Signal attribute */
> +	err = counter_attribute_create(group, "", "signal",
> +		(counter->signal_read) ? counter_signal_show : NULL, NULL,
> +		signal_comp);
> +	if (err) {
> +		kfree(signal_comp);
> +		return err;
> +	}
> +
> +	/* Create Signal name attribute */
> +	if (signal->name) {
> +		/* Allocate name attribute component */
> +		name_comp = kmalloc(sizeof(*name_comp), GFP_KERNEL);
> +		if (!name_comp)
> +			return -ENOMEM;
> +		name_comp->name = signal->name;
> +
> +		/* Allocate Signal name attribute */
> +		err = counter_attribute_create(group, "", "name",
> +			counter_device_attr_name_show, NULL, name_comp);
> +		if (err) {
> +			kfree(name_comp);
> +			return err;
> +		}
> +	}
> +
> +	/* Register Signal extension attributes */
> +	return counter_signal_ext_register(group, signal);
> +}
> +
> +static int counter_signals_register(
> +	struct counter_device_attr_group *const groups_list,
> +	const struct counter_device *const counter)
> +{
> +	const size_t num_signals = counter->num_signals;
> +	struct counter_device_state *const device_state = counter->device_state;
> +	struct device *const dev = &device_state->dev;
> +	size_t i;
> +	struct counter_signal *signal;
> +	const char *name;
> +	int err;
> +
> +	/* At least one Signal must be defined */
> +	if (!counter->signals || !num_signals) {
> +		dev_err(dev, "Signals undefined\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Signal */
> +	for (i = 0; i < num_signals; i++) {
> +		signal = counter->signals + i;
> +
> +		/* Generate Signal attribute directory name */
> +		name = kasprintf(GFP_KERNEL, "signal%d", signal->id);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		groups_list[i].attr_group.name = name;
> +
> +		/* Create all attributes associated with Signal */
> +		err = counter_signal_attributes_create(groups_list + i, counter,
> +			signal);
> +		if (err)
> +			return err;
free name on error.  The attr hasn't been added to the list yet so I don't think
it will be automatically freed.
> +	}
> +
> +	return 0;
> +}
> +
> +static const char *const synapse_action_str[] = {
> +	[SYNAPSE_ACTION_NONE] = "none",
> +	[SYNAPSE_ACTION_RISING_EDGE] = "rising edge",
> +	[SYNAPSE_ACTION_FALLING_EDGE] = "falling edge",
> +	[SYNAPSE_ACTION_BOTH_EDGES] = "both edges"
> +};
> +
> +struct action_comp_t {
> +	struct counter_synapse	*synapse;
> +	struct counter_count	*count;
> +};
> +
> +static ssize_t counter_action_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct action_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	struct counter_synapse *const synapse = component->synapse;
> +	size_t action_index;
> +	enum synapse_action action;
> +
> +	err = counter->action_get(counter, count, synapse, &action_index);
> +	if (err)
> +		return err;
> +
> +	synapse->action = action_index;
> +
> +	action = synapse->actions_list[action_index];
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", synapse_action_str[action]);
> +}
> +
> +static ssize_t counter_action_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct action_comp_t *const component = devattr->component;
> +	struct counter_synapse *const synapse = component->synapse;
> +	size_t action_index;
> +	const size_t num_actions = synapse->num_actions;
> +	enum synapse_action action;
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = component->count;
> +
> +	/* Find requested action mode */
> +	for (action_index = 0; action_index < num_actions; action_index++) {
> +		action = synapse->actions_list[action_index];
> +		if (sysfs_streq(buf, synapse_action_str[action]))
> +			break;
> +	}
> +	/* If requested action mode not found */
> +	if (action_index >= num_actions)
> +		return -EINVAL;
> +
> +	err = counter->action_set(counter, count, synapse, action_index);
> +	if (err)
> +		return err;
> +
> +	synapse->action = action_index;
> +
> +	return len;
> +}
> +
> +struct action_avail_comp_t {
> +	const enum synapse_action	*actions_list;
> +	size_t				num_actions;
> +};
> +
> +static ssize_t counter_synapse_action_available_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct action_avail_comp_t *const component = devattr->component;
> +	const enum synapse_action *const actions_list = component->actions_list;
> +	const size_t num_actions = component->num_actions;
> +	size_t i;
> +	enum synapse_action action;
> +	ssize_t len = 0;
> +
> +	for (i = 0; i < num_actions; i++) {
> +		action = actions_list[i];
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +			synapse_action_str[action]);
> +	}
> +
> +	return len;
> +}
> +
> +static int counter_synapses_register(
> +	struct counter_device_attr_group *const group,
> +	const struct counter_device *const counter,
> +	struct counter_count *const count, const char *const count_attr_name)
> +{
> +	const size_t num_synapses = count->num_synapses;
> +	struct device *const dev = &counter->device_state->dev;
> +	size_t i;
> +	struct counter_synapse *synapse;
> +	const char *prefix;
> +	struct action_comp_t *action_comp;
> +	int err;
> +	struct action_avail_comp_t *avail_comp;
> +
> +	/* At least one Synapse must be defined */
> +	if (!count->synapses || !num_synapses) {
> +		dev_err(dev, "Count '%d' Synapses undefined\n",	count->id);
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Synapse */
> +	for (i = 0; i < num_synapses; i++) {
> +		synapse = count->synapses + i;
> +
> +		/* Ensure all Synapses have a defined Signal */
> +		if (!synapse->signal) {
> +			dev_err(dev,
> +				"Count '%d' Synapse '%zu' Signal undefined\n",
> +				count->id, i);
> +			return -EINVAL;
> +		}
> +
> +		/* At least one action mode must be defined for each Synapse */
> +		if (!synapse->actions_list || !synapse->num_actions) {
> +			dev_err(dev,
> +				"Count '%d' Signal '%d' action modes undefined\n",
> +				count->id, synapse->signal->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Generate attribute prefix */
> +		prefix = kasprintf(GFP_KERNEL, "signal%d_",
> +			synapse->signal->id);
> +		if (!prefix)
> +			return -ENOMEM;
> +
> +		/* Allocate action attribute component */
> +		action_comp = kmalloc(sizeof(*action_comp), GFP_KERNEL);
> +		if (!action_comp) {
> +			err = -ENOMEM;
> +			goto err_free_prefix;
> +		}
> +		action_comp->synapse = synapse;
> +		action_comp->count = count;
> +
> +		/* Create action attribute */
> +		err = counter_attribute_create(group, prefix, "action",
> +			(counter->action_get) ? counter_action_show : NULL,
> +			(counter->action_set) ? counter_action_store : NULL,
> +			action_comp);
> +		if (err) {
> +			kfree(action_comp);
> +			goto err_free_prefix;
> +		}
> +
> +		/* Allocate action available attribute component */
> +		avail_comp = kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> +		if (!avail_comp) {
> +			err = -ENOMEM;
> +			goto err_free_prefix;
> +		}
> +		avail_comp->actions_list = synapse->actions_list;
> +		avail_comp->num_actions = synapse->num_actions;
> +
> +		/* Create action_available attribute */
> +		err = counter_attribute_create(group, prefix,
> +			"action_available",
> +			counter_synapse_action_available_show, NULL,
> +			avail_comp);
> +		if (err) {
> +			kfree(avail_comp);
> +			goto err_free_prefix;
> +		}
> +
> +		kfree(prefix);
> +	}
> +
> +	return 0;
> +
> +err_free_prefix:
> +	kfree(prefix);
> +	return err;
> +}
> +
> +struct count_comp_t {
> +	struct counter_count	*count;
> +};
> +
> +static ssize_t counter_count_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	int err;
> +	struct count_read_value val = { .buf = buf };
> +
> +	err = counter->count_read(counter, count, &val);
> +	if (err)
> +		return err;
> +
> +	return val.len;
> +}
> +
> +static ssize_t counter_count_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	int err;
> +	struct count_write_value val = { .buf = buf };
> +
> +	err = counter->count_write(counter, count, &val);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +
> +static const char *const count_function_str[] = {
> +	[COUNT_FUNCTION_INCREASE] = "increase",
> +	[COUNT_FUNCTION_DECREASE] = "decrease",
> +	[COUNT_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
> +	[COUNT_FUNCTION_QUADRATURE_X1] = "quadrature x1",
> +	[COUNT_FUNCTION_QUADRATURE_X2] = "quadrature x2",
> +	[COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
> +};
> +
> +static ssize_t counter_function_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	size_t func_index;
> +	enum count_function function;
> +
> +	err = counter->function_get(counter, count, &func_index);
> +	if (err)
> +		return err;
> +
> +	count->function = func_index;
> +
> +	function = count->functions_list[func_index];
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", count_function_str[function]);
> +}
> +
> +static ssize_t counter_function_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	const size_t num_functions = count->num_functions;
> +	size_t func_index;
> +	enum count_function function;
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	/* Find requested Count function mode */
> +	for (func_index = 0; func_index < num_functions; func_index++) {
> +		function = count->functions_list[func_index];
> +		if (sysfs_streq(buf, count_function_str[function]))
> +			break;
> +	}
> +	/* Return error if requested Count function mode not found */
> +	if (func_index >= num_functions)
> +		return -EINVAL;
> +
> +	err = counter->function_set(counter, count, func_index);
> +	if (err)
> +		return err;
> +
> +	count->function = func_index;
> +
> +	return len;
> +}
> +
> +struct count_ext_comp_t {
> +	struct counter_count		*count;
> +	const struct counter_count_ext	*ext;
> +};
> +
> +static ssize_t counter_count_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_ext_comp_t *const comp = devattr->component;
> +	const struct counter_count_ext *const ext = comp->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = comp->count;
> +
> +	return ext->read(counter, count, ext->priv, buf);
Use comp->count directly and drop the local variable.

> +}
> +
> +static ssize_t counter_count_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_ext_comp_t *const comp = devattr->component;
> +	const struct counter_count_ext *const ext = comp->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = comp->count;
> +
> +	return ext->write(counter, count, ext->priv, buf, len);
> +}
> +
> +static int counter_count_ext_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_count *const count)
> +{
> +	const size_t num_ext = count->num_ext;
> +	size_t i;
> +	const struct counter_count_ext *ext;
> +	struct count_ext_comp_t *count_ext_comp;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!count->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = count->ext + i;
> +
> +		/* Allocate count_ext attribute component */
> +		count_ext_comp = kmalloc(sizeof(*count_ext_comp), GFP_KERNEL);
> +		if (!count_ext_comp)
> +			return -ENOMEM;
> +		count_ext_comp->count = count;
> +		count_ext_comp->ext = ext;
> +
> +		/* Allocate count_ext attribute */
> +		err = counter_attribute_create(group, "", ext->name,
> +			(ext->read) ? counter_count_ext_show : NULL,
> +			(ext->write) ? counter_count_ext_store : NULL,
> +			count_ext_comp);
> +		if (err) {
> +			kfree(count_ext_comp);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct func_avail_comp_t {
> +	const enum count_function	*functions_list;
> +	size_t				num_functions;
> +};
> +
> +static ssize_t counter_count_function_available_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct func_avail_comp_t *const component = devattr->component;
> +	const enum count_function *const func_list = component->functions_list;
> +	const size_t num_functions = component->num_functions;
> +	size_t i;
> +	enum count_function function;
> +	ssize_t len = 0;
> +
> +	for (i = 0; i < num_functions; i++) {
> +		function = func_list[i];
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
> +			count_function_str[function]);
> +	}
> +
> +	return len;
> +}
> +
> +static int counter_count_attributes_create(
> +	struct counter_device_attr_group *const group,
> +	const struct counter_device *const counter,
> +	struct counter_count *const count)
> +{
> +	struct count_comp_t *count_comp;
> +	int err;
> +	struct count_comp_t *func_comp;
> +	struct func_avail_comp_t *avail_comp;
> +	struct name_comp_t *name_comp;
> +
> +	/* Allocate count attribute component */
> +	count_comp = kmalloc(sizeof(*count_comp), GFP_KERNEL);
> +	if (!count_comp)
> +		return -ENOMEM;
> +	count_comp->count = count;
> +
> +	/* Create main Count attribute */
> +	err = counter_attribute_create(group, "", "count",
> +		(counter->count_read) ? counter_count_show : NULL,
> +		(counter->count_write) ? counter_count_store : NULL,
> +		count_comp);
> +	if (err) {
> +		kfree(count_comp);
> +		return err;
> +	}
> +
> +	/* Allocate function attribute component */
> +	func_comp = kmalloc(sizeof(*func_comp), GFP_KERNEL);
> +	if (!func_comp)
> +		return -ENOMEM;
> +	func_comp->count = count;
> +
> +	/* Create Count function attribute */
> +	err = counter_attribute_create(group, "", "function",
> +		(counter->function_get) ? counter_function_show : NULL,
> +		(counter->function_set) ? counter_function_store : NULL,
> +		func_comp);
> +	if (err) {
> +		kfree(func_comp);
> +		return err;
> +	}
> +
> +	/* Allocate function available attribute component */
> +	avail_comp = kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> +	if (!avail_comp)
> +		return -ENOMEM;
> +	avail_comp->functions_list = count->functions_list;
> +	avail_comp->num_functions = count->num_functions;
> +
> +	/* Create Count function_available attribute */
> +	err = counter_attribute_create(group, "", "function_available",
> +		counter_count_function_available_show, NULL, avail_comp);
> +	if (err) {
> +		kfree(avail_comp);
> +		return err;
> +	}
> +
> +	/* Create Count name attribute */
> +	if (count->name) {
> +		/* Allocate name attribute component */
> +		name_comp = kmalloc(sizeof(*name_comp), GFP_KERNEL);
> +		if (!name_comp)
> +			return -ENOMEM;
> +		name_comp->name = count->name;
> +
> +		err = counter_attribute_create(group, "", "name",
> +			counter_device_attr_name_show,	NULL, name_comp);
> +		if (err) {
> +			kfree(name_comp);
> +			return err;
> +		}
> +	}
> +
> +	/* Register Count extension attributes */
> +	return counter_count_ext_register(group, count);
> +}
> +
> +static int counter_counts_register(
> +	struct counter_device_attr_group *const groups_list,
> +	const struct counter_device *const counter)
> +{
> +	const size_t num_counts = counter->num_counts;
> +	struct device *const dev = &counter->device_state->dev;
> +	size_t i;
> +	struct counter_count *count;
> +	const char *name;
> +	int err;
> +
> +	/* At least one Count must be defined */
> +	if (!counter->counts || !num_counts) {
> +		dev_err(dev, "Counts undefined\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register each Count */
> +	for (i = 0; i < num_counts; i++) {
> +		count = counter->counts + i;
Is counter->counts ever set anywhere?

> +
> +		/* At least one function mode must be defined for each Count */
> +		if (!count->functions_list || !count->num_functions) {
> +			dev_err(dev, "Count '%d' function modes undefined\n",
> +				count->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Generate Count attribute directory name */
> +		name = kasprintf(GFP_KERNEL, "count%d", count->id);
> +		if (!name)
> +			return -ENOMEM;
> +		groups_list[i].attr_group.name = name;
> +
> +		/* Register the Synapses associated with each Count */
> +		err = counter_synapses_register(groups_list + i, counter, count,
> +			name);
> +		if (err)
Handling, would expect errors to cause a direct unwind of antying this
function has done that isn't automatically handled elsewhere. So far we
have set the name to some memory allocated but nothing else. I think
that needs freeing as we haven't added it to the list yet?
> +			return err;
> +
> +		/* Create all attributes associated with Count */
> +		err = counter_count_attributes_create(groups_list + i, counter,
> +			count);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct bus_type counter_bus_type = {
> +	.name = "counter"
> +};
> +
> +static int __init counter_init(void)
> +{
> +	return bus_register(&counter_bus_type);
> +}
> +
> +static void __exit counter_exit(void)
> +{
> +	bus_unregister(&counter_bus_type);
> +}
I would expect these to be found next to the init and exit function
usage in subsystem_initcall and friends.

> +
> +static void free_counter_device_attr_list(struct list_head *attr_list)
> +{
> +	struct counter_device_attr *p, *n;
> +
> +	list_for_each_entry_safe(p, n, attr_list, l) {
> +		kfree(p->dev_attr.attr.name);
> +		kfree(p->component);
> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +}
> +
> +static void free_counter_device_groups_list(
> +	struct counter_device_state *const device_state)
> +{
> +	struct counter_device_attr_group *group;
> +	size_t i;
> +
> +	for (i = 0; i < device_state->num_groups; i++) {
> +		group = device_state->groups_list + i;
> +
> +		kfree(group->attr_group.name);
> +		kfree(group->attr_group.attrs);
> +		free_counter_device_attr_list(&group->attr_list);
> +	}
> +
> +	kfree(device_state->groups_list);
> +}
> +
> +/* Provides a unique ID for each counter device */
> +static DEFINE_IDA(counter_ida);
> +
> +static void counter_device_release(struct device *dev)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_device_state *const device_state = counter->device_state;
> +
> +	kfree(device_state->groups);
> +	free_counter_device_groups_list(device_state);
> +	ida_simple_remove(&counter_ida, device_state->id);
> +	kfree(device_state);
> +}
> +
> +static struct device_type counter_device_type = {
> +	.name = "counter_device",
> +	.release = counter_device_release
> +};
> +
> +struct ext_comp_t {
> +	const struct counter_device_ext	*ext;
> +};
> +
> +static ssize_t counter_device_ext_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct ext_comp_t *const component = devattr->component;
> +	const struct counter_device_ext *const ext = component->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	return ext->read(counter, ext->priv, buf);
Can thin down some of the local variables.

return ext->read(dev_get_drvdata(dev), ext->priv, buf);

> +}
> +
> +static ssize_t counter_device_ext_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct ext_comp_t *const component = devattr->component;
> +	const struct counter_device_ext *const ext = component->ext;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	return ext->write(counter, ext->priv, buf, len);
> +}
> +
> +static int counter_device_ext_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_device *const counter)
> +{
> +	const size_t num_ext = counter->num_ext;
> +	struct ext_comp_t *ext_comp;
> +	size_t i;
> +	const struct counter_device_ext *ext;
> +	int err;
> +
> +	/* Return early if no extensions */
> +	if (!counter->ext || !num_ext)
> +		return 0;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = counter->ext + i;
> +
> +		/* Allocate extension attribute component */
> +		ext_comp = kmalloc(sizeof(*ext_comp), GFP_KERNEL);
> +		if (!ext_comp)
> +			return -ENOMEM;
> +		ext_comp->ext = ext;
> +
> +		/* Allocate extension attribute */
> +		err = counter_attribute_create(group, "", ext->name,
> +			(ext->read) ? counter_device_ext_show : NULL,
> +			(ext->write) ? counter_device_ext_store : NULL,
> +			ext_comp);
> +		if (err) {
> +			kfree(ext_comp);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * counter_register - register Counter to the system
> + * @counter:	pointer to Counter to register
> + *
> + * This function registers a Counter to the system. A sysfs "counter" directory
> + * will be created and populated with sysfs attributes correlating with the
> + * Counter Signals, Synapses, and Counts respectively.
> + */
> +int counter_register(struct counter_device *const counter)
> +{
> +	struct counter_device_state *device_state;
> +	int err;
> +	size_t i = 0;
> +	size_t groups_offset = 0;
> +	struct name_comp_t *name_comp;
> +	struct counter_device_attr_group *group;
> +	size_t j;
> +	struct counter_device_attr *p;
> +
> +	if (!counter)
> +		return -EINVAL;
This one seems a little crazy to handle in here.  I really hope we know
that before we try registering it!

> +
> +	/* Allocate internal state container for Counter device */
> +	device_state = kzalloc(sizeof(*device_state), GFP_KERNEL);
> +	if (!device_state)
> +		return -ENOMEM;
> +	counter->device_state = device_state;
> +
> +	/* Acquire unique ID */
> +	device_state->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> +	if (device_state->id < 0) {
> +		err = device_state->id;
> +		goto err_free_device_state;
> +	}
> +
> +	/* Configure device structure for Counter */
> +	device_state->dev.type = &counter_device_type;
> +	device_state->dev.bus = &counter_bus_type;
> +	if (counter->parent) {
> +		device_state->dev.parent = counter->parent;
> +		device_state->dev.of_node = counter->parent->of_node;
> +	}
> +	dev_set_name(&device_state->dev, "counter%d", device_state->id);
> +	device_initialize(&device_state->dev);
> +	dev_set_drvdata(&device_state->dev, counter);
> +
> +	/* Allocate space for attribute groups (signals. counts, and ext) */
> +	device_state->num_groups =
> +		counter->num_signals + counter->num_counts + 1;
> +	device_state->groups_list = kcalloc(device_state->num_groups,
> +		sizeof(*device_state->groups_list), GFP_KERNEL);
If you want to use a unified function to 'undo' this block
free_counter_device_groups_list then I would expect to see this
block as a separate function to which that one is matched.

The flow here is rather complex vs the remove.  Not sure there is an
easy way to clean it up though.

> +	if (!device_state->groups_list) {
> +		err = -ENOMEM;
> +		goto err_free_id;
> +	}
> +
> +	/* Initialize attribute lists */
> +	for (i = 0; i < device_state->num_groups; i++)
> +		INIT_LIST_HEAD(&device_state->groups_list[i].attr_list);
> +
> +	/* Verify Signals are valid and register */
> +	err = counter_signals_register(device_state->groups_list, counter);
> +	if (err)
> +		goto err_free_groups_list;
> +	groups_offset += counter->num_signals;
> +
> +	/* Verify Counts and respective Synapses are valid and register */
> +	err = counter_counts_register(device_state->groups_list + groups_offset,
> +		counter);
> +	if (err)
> +		goto err_free_groups_list;
> +	groups_offset += counter->num_counts;
> +
> +	/* Register Counter device extension attributes */
> +	err = counter_device_ext_register(
> +		device_state->groups_list + groups_offset, counter);
> +	if (err)
> +		goto err_free_groups_list;
> +
> +	/* Account for name attribute */
> +	if (counter->name) {
> +		/* Allocate name attribute component */
> +		name_comp = kmalloc(sizeof(*name_comp), GFP_KERNEL);
> +		if (!name_comp) {
> +			err = -ENOMEM;
> +			goto err_free_groups_list;
> +		}
> +		name_comp->name = counter->name;
> +
> +		err = counter_attribute_create(
> +			device_state->groups_list + groups_offset, "", "name",
> +			counter_device_attr_name_show,	NULL, name_comp);
> +		if (err) {
> +			kfree(name_comp);
> +			goto err_free_groups_list;
> +		}
> +	}
> +
> +	/* Allocate attribute groups for association with device */
> +	device_state->groups = kcalloc(device_state->num_groups + 1,
> +		sizeof(*device_state->groups), GFP_KERNEL);
> +	if (!device_state->groups) {
> +		err = -ENOMEM;
> +		goto err_free_groups_list;
> +	}
> +	/* Prepare each group of attributes for association */
> +	for (i = 0; i < device_state->num_groups; i++) {
> +		group = device_state->groups_list + i;
> +
> +		/* Allocate space for attribute pointers in attribute group */
> +		group->attr_group.attrs = kcalloc(group->num_attr + 1,
> +			sizeof(*group->attr_group.attrs), GFP_KERNEL);
> +		if (!group->attr_group.attrs) {
> +			err = -ENOMEM;
> +			goto err_free_groups;
> +		}
> +
> +		/* Add attribute pointers to attribute group */
> +		j = 0;
> +		list_for_each_entry(p, &group->attr_list, l)
> +			group->attr_group.attrs[j++] = &p->dev_attr.attr;
> +
> +		/* Group attributes in attribute group */
> +		device_state->groups[i] = &group->attr_group;
> +	}
> +	/* Associate attributes with device */
> +	device_state->dev.groups = device_state->groups;
> +
> +	/* Add device to system */
> +	err = device_add(&device_state->dev);
> +	if (err)
> +		goto err_free_groups;
> +
> +	return 0;
> +
Given release is responsible for the normal cleanup, it would have
been easier to review if we had release as the next function after
this one.

> +err_free_groups:
> +	kfree(counter->device_state->groups);

I think you are always fine with device_state->* using local variable.

> +err_free_groups_list:
> +	free_counter_device_groups_list(counter->device_state);
> +err_free_id:
> +	ida_simple_remove(&counter_ida, counter->device_state->id);
> +err_free_device_state:
> +	kfree(counter->device_state);
> +	return err;
> +}
> +EXPORT_SYMBOL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter:	pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system; all allocated memory is freed.
> + */
> +void counter_unregister(struct counter_device *const counter)
> +{
> +	if (counter)
> +		device_del(&counter->device_state->dev);
> +}
> +EXPORT_SYMBOL(counter_unregister);
> +
> +static void devm_counter_unreg(struct device *dev, void *res)
> +{
> +	counter_unregister(*(struct counter_device **)res);
> +}
> +
> +/**
> + * devm_counter_register - Resource-managed counter_register
> + * @dev:	device to allocate counter_device for
> + * @counter:	pointer to Counter to register
> + *
> + * Managed counter_register. The Counter registered with this function is
> + * automatically unregistered on driver detach. This function calls
> + * counter_register internally. Refer to that function for more information.
> + *
> + * If an Counter registered with this function needs to be unregistered
> + * separately, devm_counter_unregister must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_counter_register(struct device *dev,
> +	struct counter_device *const counter)
Where possible align with the opening bracket.
checkpatch.pl --strict (but take into account some of the warnings will
be silly so don't fix them all).

> +{
> +	struct counter_device **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = counter_register(counter);
> +	if (!ret) {
> +		*ptr = counter;
> +		devres_add(dev, ptr);
> +	} else
> +		devres_free(ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_counter_register);
> +
> +static int devm_counter_match(struct device *dev, void *res, void *data)
> +{
> +	struct counter_device **r = res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}
> +
> +	return *r == data;
> +}
> +
> +/**
> + * devm_counter_unregister - Resource-managed counter_unregister
> + * @dev:	device this counter_device belongs to
> + * @counter:	pointer to Counter associated with the device
> + *
> + * Unregister Counter registered with devm_counter_register.
> + */
> +void devm_counter_unregister(struct device *dev,
> +	struct counter_device *const counter)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_counter_unreg,
> +		devm_counter_match, counter);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL(devm_counter_unregister);
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> similarity index 100%
> rename from drivers/iio/counter/stm32-lptimer-cnt.c
> rename to drivers/counter/stm32-lptimer-cnt.c
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b3c8c6ef0dff..423d86e368ea 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -73,7 +73,6 @@ source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
> -source "drivers/iio/counter/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/dummy/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index b16b2e9ddc40..6a80ebddb54c 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -19,7 +19,6 @@ obj-y += amplifiers/
>  obj-y += buffer/
>  obj-y += chemical/
>  obj-y += common/
> -obj-y += counter/
Hmm. I would do this later after you have everything up to move the drivers
over.
Just adds noise to this complex patch.

>  obj-y += dac/
>  obj-y += dummy/
>  obj-y += gyro/
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> new file mode 100644
> index 000000000000..aefca382624e
> --- /dev/null
> +++ b/include/linux/counter.h
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Counter interface
> + * Copyright (C) 2017 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#ifndef _COUNTER_H_
> +#define _COUNTER_H_
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +struct counter_device;
> +struct counter_signal;
> +
> +/**
> + * struct counter_signal_ext - Counter Signal extensions
> + * @name:	attribute name
> + * @read:	read callback for this attribute; may be NULL
> + * @write:	write callback for this attribute; may be NULL
> + * @priv:	data private to the driver
> + */
> +struct counter_signal_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter,
> +				struct counter_signal *signal, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter,
> +				struct counter_signal *signal, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +/**
> + * struct counter_signal - Counter Signal node
> + * @id:		unique ID used to identify signal
> + * @name:	device-specific Signal name; ideally, this should match the name
> + *		as it appears in the datasheet documentation
> + * @ext:	optional array of Counter Signal extensions
> + * @num_ext:	number of Counter Signal extensions specified in @ext
> + * @priv:	optional private data supplied by driver
> + */
> +struct counter_signal {
> +	int		id;
> +	const char	*name;
> +
> +	const struct counter_signal_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +/**
> + * struct counter_signal_enum_ext - Signal enum extension attribute
> + * @items:	Array of strings
> + * @num_items:	Number of items specified in @items
> + * @set:	Set callback function; may be NULL
> + * @get:	Get callback function; may be NULL
> + *
> + * The counter_signal_enum_ext structure can be used to implement enum style
> + * Signal extension attributes. Enum style attributes are those which have a set
> + * of strings that map to unsigned integer values. The Generic Counter Signal
> + * enum extension helper code takes care of mapping between value and string, as
> + * well as generating a "_available" file which contains a list of all available
> + * items. The get callback is used to query the currently active item; the index
> + * of the item within the respective items array is returned via the 'item'
> + * parameter. The set callback is called when the attribute is updated; the
> + * 'item' parameter contains the index of the newly activated item within the
> + * respective items array.
> + */
> +struct counter_signal_enum_ext {
> +	const char * const	*items;
> +	size_t			num_items;
> +	int			(*get)(struct counter_device *counter,
> +					struct counter_signal *signal,
> +					size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +					struct counter_signal *signal,
> +					size_t item);
> +};
> +
> +extern ssize_t counter_signal_enum_read(struct counter_device *counter,
> +	struct counter_signal *signal, void *priv, char *buf);
> +extern ssize_t counter_signal_enum_write(struct counter_device *counter,
> +	struct counter_signal *signal, void *priv, const char *buf, size_t len);
> +
> +/**
> + * COUNTER_SIGNAL_ENUM() - Initialize Signal enum extension
> + * @_name:	Attribute name
> + * @_e:		Pointer to a counter_count_enum structure
> + *
> + * This should usually be used together with COUNTER_SIGNAL_ENUM_AVAILABLE()
> + */
> +#define COUNTER_SIGNAL_ENUM(_name, _e) \
> +{ \
> +	.name = (_name), \
> +	.read = counter_signal_enum_read, \
> +	.write = counter_signal_enum_write, \
> +	.priv = (_e) \
> +}
> +
> +extern ssize_t counter_signal_enum_available_read(
> +	struct counter_device *counter, struct counter_signal *signal,
> +	void *priv, char *buf);
> +
> +/**
> + * COUNTER_SIGNAL_ENUM_AVAILABLE() - Initialize Signal enum available extension
> + * @_name:	Attribute name ("_available" will be appended to the name)
> + * @_e:		Pointer to a counter_signal_enum structure
> + *
> + * Creates a read only attribute that lists all the available enum items in a
> + * newline separated list. This should usually be used together with
> + * COUNTER_SIGNAL_ENUM()
> + */
> +#define COUNTER_SIGNAL_ENUM_AVAILABLE(_name, _e) \
> +{ \
> +	.name = (_name "_available"), \
> +	.read = counter_signal_enum_available_read, \
> +	.priv = (_e) \
> +}
> +
> +enum synapse_action {
> +	SYNAPSE_ACTION_NONE = 0,
> +	SYNAPSE_ACTION_RISING_EDGE,
> +	SYNAPSE_ACTION_FALLING_EDGE,
> +	SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +/**
> + * struct counter_synapse - Counter Synapse node
> + * @action:		index of current action mode
> + * @actions_list:	array of available action modes
> + * @num_actions:	number of action modes specified in @actions_list
> + * @signal:		pointer to associated signal
> + */
> +struct counter_synapse {
> +	size_t					action;
> +	const enum synapse_action		*actions_list;
> +	size_t					num_actions;
> +
> +	struct counter_signal			*signal;
> +};
> +
> +struct counter_count;
> +
> +/**
> + * struct counter_count_ext - Counter Count extension
> + * @name:	attribute name
> + * @read:	read callback for this attribute; may be NULL
> + * @write:	write callback for this attribute; may be NULL
> + * @priv:	data private to the driver
> + */
> +struct counter_count_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter,
> +				struct counter_count *count, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter,
> +				struct counter_count *count, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +enum count_function {
> +	COUNT_FUNCTION_INCREASE = 0,
> +	COUNT_FUNCTION_DECREASE,
> +	COUNT_FUNCTION_PULSE_DIRECTION,
> +	COUNT_FUNCTION_QUADRATURE_X1,
> +	COUNT_FUNCTION_QUADRATURE_X2,
> +	COUNT_FUNCTION_QUADRATURE_X4
> +};
> +
> +/**
> + * struct counter_count - Counter Count node
> + * @id:			unique ID used to identify Count
> + * @name:		device-specific Count name; ideally, this should match
> + *			the name as it appears in the datasheet documentation
> + * @function:		index of current function mode
> + * @functions_list:	array available function modes
> + * @num_functions:	number of function modes specified in @functions_list
> + * @synapses:		array of synapses for initialization
> + * @num_synapses:	number of synapses specified in @synapses
> + * @ext:		optional array of Counter Count extensions
> + * @num_ext:		number of Counter Count extensions specified in @ext
> + * @priv:		optional private data supplied by driver
> + */
> +struct counter_count {
> +	int			id;
> +	const char		*name;
> +
> +	size_t					function;
> +	const enum count_function		*functions_list;
> +	size_t					num_functions;
> +
> +	struct counter_synapse	*synapses;
> +	size_t			num_synapses;
> +
> +	const struct counter_count_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +/**
> + * struct counter_count_enum_ext - Count enum extension attribute
> + * @items:	Array of strings
> + * @num_items:	Number of items specified in @items
> + * @set:	Set callback function; may be NULL
> + * @get:	Get callback function; may be NULL
> + *
> + * The counter_count_enum_ext structure can be used to implement enum style
> + * Count extension attributes. Enum style attributes are those which have a set
> + * of strings that map to unsigned integer values. The Generic Counter Count
> + * enum extension helper code takes care of mapping between value and string, as
> + * well as generating a "_available" file which contains a list of all available
> + * items. The get callback is used to query the currently active item; the index
> + * of the item within the respective items array is returned via the 'item'
> + * parameter. The set callback is called when the attribute is updated; the
> + * 'item' parameter contains the index of the newly activated item within the
> + * respective items array.
> + */
> +struct counter_count_enum_ext {
> +	const char * const	*items;
> +	size_t			num_items;
> +	int			(*get)(struct counter_device *counter,
> +					struct counter_count *count,
> +					size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +					struct counter_count *count,
> +					size_t item);
> +};
> +
> +extern ssize_t counter_count_enum_read(struct counter_device *counter,
> +	struct counter_count *count, void *priv, char *buf);
> +extern ssize_t counter_count_enum_write(struct counter_device *counter,
> +	struct counter_count *count, void *priv, const char *buf, size_t len);
> +
> +/**
> + * COUNTER_COUNT_ENUM() - Initialize Count enum extension
> + * @_name:	Attribute name
> + * @_e:		Pointer to a counter_count_enum structure
> + *
> + * This should usually be used together with COUNTER_COUNT_ENUM_AVAILABLE()
> + */
> +#define COUNTER_COUNT_ENUM(_name, _e) \
> +{ \
> +	.name = (_name), \
> +	.read = counter_count_enum_read, \
> +	.write = counter_count_enum_write, \
> +	.priv = (_e) \
> +}
> +
> +extern ssize_t counter_count_enum_available_read(struct counter_device *counter,
> +	struct counter_count *count, void *priv, char *buf);
> +
> +/**
> + * COUNTER_COUNT_ENUM_AVAILABLE() - Initialize Count enum available extension
> + * @_name:	Attribute name ("_available" will be appended to the name)
> + * @_e:		Pointer to a counter_count_enum structure
> + *
> + * Creates a read only attribute that lists all the available enum items in a
> + * newline separated list. This should usually be used together with
> + * COUNTER_COUNT_ENUM()
> + */
> +#define COUNTER_COUNT_ENUM_AVAILABLE(_name, _e) \
> +{ \
> +	.name = (_name "_available"), \
> +	.read = counter_count_enum_available_read, \
> +	.priv = (_e) \
> +}
> +
> +/**
> + * struct counter_device_attr_group - internal container for attribute group
> + * @attr_group:	Counter sysfs attributes group
> + * @attr_list:	list to keep track of created Counter sysfs attributes
> + * @num_attr:	number of Counter sysfs attributes
> + */
> +struct counter_device_attr_group {
> +	struct attribute_group	attr_group;
> +	struct list_head	attr_list;
> +	size_t			num_attr;
> +};
> +
> +/**
> + * struct counter_device_state - internal state container for a Counter device
> + * @id:		unique ID used to identify the Counter
> + * @dev:	internal device structure
> + * @groups_list	attribute groups list (groups for Signals, Counts, and ext)
> + * @num_groups	number of attribute groups containers
> + * @groups:	Counter sysfs attribute groups (used to populate @dev.groups)
> + */
> +struct counter_device_state {
> +	int					id;
> +	struct device				dev;
> +	struct counter_device_attr_group	*groups_list;
> +	size_t					num_groups;
> +	const struct attribute_group		**groups;
> +};
> +
> +/**
> + * struct signal_read_value - Opaque Signal read value
> + * @buf:	string representation of Signal read value
> + * @len:	length of string in @buf
> + */
> +struct signal_read_value {
> +	char	*buf;
> +	size_t	len;
> +};
> +
> +/**
> + * struct count_read_value - Opaque Count read value
> + * @buf:	string representation of Count read value
> + * @len:	length of string in @buf
I wonder if you are ever going to want to have in kernel consumers.
Using strings this early level would make that hard.

I'm also unclear on why it makes sense to do so given count
is always an integer - Potentially things could get interesting
when you are either signed or unsigned and matching the number of
bits (s16, u16 or similar).

Given this is in kernel interface though, nothing stops you modifying
it later if you change your mind about this.

> + */
> +struct count_read_value {
> +	char	*buf;
> +	size_t	len;
> +};
> +
> +/**
> + * struct count_write_value - Opaque Count write value
> + * @buf:	string representation of Count write value
> + */
> +struct count_write_value {
> +	const char	*buf;
> +};
> +
> +/**
> + * struct counter_device_ext - Counter device extension
> + * @name:	attribute name
> + * @read:	read callback for this attribute; may be NULL
> + * @write:	write callback for this attribute; may be NULL
> + * @priv:	data private to the driver
> + */
> +struct counter_device_ext {
> +	const char	*name;
> +	ssize_t		(*read)(struct counter_device *counter, void *priv,
> +				char *buf);
> +	ssize_t		(*write)(struct counter_device *counter, void *priv,
> +				const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +/**
> + * struct counter_device_enum_ext - Counter enum extension attribute
> + * @items:	Array of strings
> + * @num_items:	Number of items specified in @items
> + * @set:	Set callback function; may be NULL
> + * @get:	Get callback function; may be NULL
> + *
> + * The counter_device_enum_ext structure can be used to implement enum style
> + * Counter extension attributes. Enum style attributes are those which have a
> + * set of strings that map to unsigned integer values. The Generic Counter enum
> + * extension helper code takes care of mapping between value and string, as well
> + * as generating a "_available" file which contains a list of all available
> + * items. The get callback is used to query the currently active item; the index
> + * of the item within the respective items array is returned via the 'item'
> + * parameter. The set callback is called when the attribute is updated; the
> + * 'item' parameter contains the index of the newly activated item within the
> + * respective items array.
> + */
> +struct counter_device_enum_ext {
> +	const char * const	*items;
> +	size_t			num_items;
> +	int			(*get)(struct counter_device *counter,
> +					size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +					size_t item);
> +};
> +
> +extern ssize_t counter_device_enum_read(struct counter_device *counter,
> +	void *priv, char *buf);
> +extern ssize_t counter_device_enum_write(struct counter_device *counter,
> +	void *priv, const char *buf, size_t len);
> +
> +/**
> + * COUNTER_DEVICE_ENUM() - Initialize Counter enum extension
> + * @_name:	Attribute name
> + * @_e:		Pointer to a counter_device_enum structure
> + *
> + * This should usually be used together with COUNTER_DEVICE_ENUM_AVAILABLE()
> + */
> +#define COUNTER_DEVICE_ENUM(_name, _e) \
> +{ \
> +	.name = (_name), \
> +	.read = counter_device_enum_read, \
> +	.write = counter_device_enum_write, \
> +	.priv = (_e) \
> +}
> +
> +extern ssize_t counter_device_enum_available_read(
> +	struct counter_device *counter, void *priv, char *buf);
> +
> +/**
> + * COUNTER_DEVICE_ENUM_AVAILABLE() - Initialize Counter enum available extension
> + * @_name:	Attribute name ("_available" will be appended to the name)
> + * @_e:		Pointer to a counter_device_enum structure
> + *
> + * Creates a read only attribute that lists all the available enum items in a
> + * newline separated list. This should usually be used together with
> + * COUNTER_DEVICE_ENUM()
> + */
> +#define COUNTER_DEVICE_ENUM_AVAILABLE(_name, _e) \
> +{ \
> +	.name = (_name "_available"), \
> +	.read = counter_device_enum_available_read, \
> +	.priv = (_e) \
> +}
> +
> +/**
> + * struct counter_device - Counter data structure
> + * @name:		name of the device as it appears in the datasheet
> + * @parent:		optional parent device providing the counters
> + * @device_state:	internal device state container
> + * @signal_read:	optional read callback for Signal attribute. The read
> + *			value of the respective Signal should be passed back via
> + *			the val parameter. val points to an opaque type which
> + *			should be set only via the set_signal_read_value
> + *			function.
> + * @count_read:		optional read callback for Count attribute. The read
> + *			value of the respective Count should be passed back via
> + *			the val parameter. val points to an opaque type which
> + *			should be set only via the set_count_read_value
> + *			function.
> + * @count_write:	optional write callback for Count attribute. The write
> + *			value for the respective Count is passed in via the val
> + *			parameter. val points to an opaque type which should be
> + *			access only via the get_count_write_value function.
> + * @function_get:	function to get the current count function mode. Returns
> + *			0 on success and negative error code on error. The index
> + *			of the respective Count's returned function mode should
> + *			be passed back via the function parameter.
> + * @function_set:	function to set the count function mode. function is the
> + *			index of the requested function mode from the respective
> + *			Count's functions_list array.
> + * @action_get:		function to get the current action mode. Returns 0 on
> + *			success and negative error code on error. The index of
> + *			the respective Signal's returned action mode should be
> + *			passed back via the action parameter.
> + * @action_set:		function to set the action mode. action is the index of
> + *			the requested action mode from the respective Synapse's
> + *			actions_list array.
> + * @signals:		array of Signals
> + * @num_signals:	number of Signals specified in @signals
> + * @counts:		array of Counts
> + * @num_counts:		number of Counts specified in @counts
> + * @ext:		optional array of Counter device extensions
> + * @num_ext:		number of Counter device extensions specified in @ext
> + * @priv:		optional private data supplied by driver
> + */
> +struct counter_device {
> +	const char			*name;
> +	struct device			*parent;
> +	struct counter_device_state	*device_state;
> +
Ah, this email was still in my outbox! (see later comment that says
I missed this).  I would pull all these function pointers out to an
ops structure.  They will tend to be fixed for a given device
so there are lots of advantages in code simplicity and also being
able to make function pointers constant is always good for security.

> +	int	(*signal_read)(struct counter_device *counter,
> +			struct counter_signal *signal,
> +			struct signal_read_value *val);
> +	int	(*count_read)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct count_read_value *val);
> +	int	(*count_write)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct count_write_value *val);
> +	int	(*function_get)(struct counter_device *counter,
> +			struct counter_count *count, size_t *function);
> +	int	(*function_set)(struct counter_device *counter,
> +			struct counter_count *count, size_t function);
> +	int	(*action_get)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct counter_synapse *synapse, size_t *action);
> +	int	(*action_set)(struct counter_device *counter,
> +			struct counter_count *count,
> +			struct counter_synapse *synapse, size_t action);
> +
> +	struct counter_signal	*signals;
> +	size_t			num_signals;
> +	struct counter_count	*counts;
> +	size_t			num_counts;
> +
> +	const struct counter_device_ext	*ext;
> +	size_t				num_ext;
> +
> +	void	*priv;
> +};
> +
> +enum signal_level {
> +	SIGNAL_LEVEL_LOW = 0,
> +	SIGNAL_LEVEL_HIGH
> +};
> +
> +enum signal_value_type {
> +	SIGNAL_LEVEL = 0
This one surprised me.  Only one option?
> +};
> +
> +enum count_value_type {
> +	COUNT_POSITION_UNSIGNED = 0,
> +	COUNT_POSITION_SIGNED
> +};
> +
> +extern void set_signal_read_value(struct signal_read_value *const val,
> +	const enum signal_value_type type, void *const data);
Why extern?
Also, where possible align parameters with the opening bracket.


> +extern void set_count_read_value(struct count_read_value *const val,
> +	const enum count_value_type type, void *const data);
> +extern int get_count_write_value(void *const data,
> +	const enum count_value_type type,
> +	const struct count_write_value *const val);
> +
> +extern int counter_register(struct counter_device *const counter);
> +extern void counter_unregister(struct counter_device *const counter);
> +extern int devm_counter_register(struct device *dev,
> +	struct counter_device *const counter);
> +extern void devm_counter_unregister(struct device *dev,
> +	struct counter_device *const counter);
> +
> +#endif /* _COUNTER_H_ */
