Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeETPn7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbeETPnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:43:53 -0400
Date: Sun, 20 May 2018 16:06:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/9] counter: Introduce the Generic Counter interface
Message-ID: <20180520160652.1896f5a1@archlinux>
In-Reply-To: <6e0c93ccc771033f0a8bc08bd92b453a1dacbd1b.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
        <6e0c93ccc771033f0a8bc08bd92b453a1dacbd1b.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 13:50:43 -0400
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

A few minor comments inline.  I do somewhat wonder if we can cut
back on the huge amount of 'similar' code in here, but there tend to
be just enough small differences to make that really tricky...

Nothing major enough in here that I really plan on reading it again
(though you never know if you change lots ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS                       |    7 +
>  drivers/Kconfig                   |    2 +
>  drivers/Makefile                  |    1 +
>  drivers/counter/Kconfig           |   18 +
>  drivers/counter/Makefile          |    8 +
>  drivers/counter/generic-counter.c | 1541 +++++++++++++++++++++++++++++
>  include/linux/counter.h           |  554 +++++++++++
>  7 files changed, 2131 insertions(+)
>  create mode 100644 drivers/counter/Kconfig
>  create mode 100644 drivers/counter/Makefile
>  create mode 100644 drivers/counter/generic-counter.c
>  create mode 100644 include/linux/counter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225d443a..2a016d73ab72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3669,6 +3669,13 @@ W:	http://www.fi.muni.cz/~kas/cosa/
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
> index 95b9ccc08165..70b3cc88dc0b 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -165,6 +165,8 @@ source "drivers/memory/Kconfig"
>  
>  source "drivers/iio/Kconfig"
>  
> +source "drivers/counter/Kconfig"
> +
Same comment as below.

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

I can see your logic in putting this here, but I think the convention
is to go at the end rather than grouping.

>  obj-$(CONFIG_VME_BUS)		+= vme/
>  obj-$(CONFIG_IPACK_BUS)		+= ipack/
>  obj-$(CONFIG_NTB)		+= ntb/
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> new file mode 100644
> index 000000000000..65fa92abd5a4
> --- /dev/null
> +++ b/drivers/counter/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Counter devices
> +#
> +# When adding new entries keep the list in alphabetical order
> +
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
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> new file mode 100644
> index 000000000000..ad1ba7109cdc
> --- /dev/null
> +++ b/drivers/counter/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for Counter devices
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +
> +obj-$(CONFIG_COUNTER) += counter.o
> +counter-y := generic-counter.o
> diff --git a/drivers/counter/generic-counter.c b/drivers/counter/generic-counter.c
> new file mode 100644
> index 000000000000..0d83b862453f
> --- /dev/null
> +++ b/drivers/counter/generic-counter.c
> @@ -0,0 +1,1541 @@
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

As below, SPDX and license seems silly.  Unless you are feeling paranoid
just drop the license text.

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
> +const char *const count_direction_str[2] = {
> +	[COUNT_DIRECTION_FORWARD] = "forward",
> +	[COUNT_DIRECTION_BACKWARD] = "backward"
> +};
> +EXPORT_SYMBOL(count_direction_str);
> +
> +const char *const count_mode_str[4] = {
> +	[COUNT_MODE_NORMAL] = "normal",
> +	[COUNT_MODE_RANGE_LIMIT] = "range limit",
> +	[COUNT_MODE_NON_RECYCLE] = "non-recycle",
> +	[COUNT_MODE_MODULO_N] = "modulo-n"
> +};
> +EXPORT_SYMBOL(count_mode_str);
> +
> +ssize_t counter_signal_enum_read(struct counter_device *counter,
> +				 struct counter_signal *signal, void *priv,
> +				 char *buf)
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
> +				  struct counter_signal *signal, void *priv,
> +				  const char *buf, size_t len)
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
> +					   struct counter_signal *signal,
> +					   void *priv, char *buf)
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
> +				struct counter_count *count, void *priv,
> +				char *buf)
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
> +				 struct counter_count *count, void *priv,
> +				 const char *buf, size_t len)
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
> +					  struct counter_count *count,
> +					  void *priv, char *buf)
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
> +				 char *buf)
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
> +				  const char *buf, size_t len)
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
> +					   void *priv, char *buf)
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
> +			   const enum signal_value_type type, void *const data)
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
> +			  const enum count_value_type type, void *const data)
> +{
> +	switch (type) {
> +	case COUNT_POSITION_UNSIGNED:
> +		val->len = scnprintf(val->buf, PAGE_SIZE, "%lu\n",
> +				     *(unsigned long *)data);
> +		break;
> +	case COUNT_POSITION_SIGNED:
> +		val->len = scnprintf(val->buf, PAGE_SIZE, "%ld\n",
> +				     *(long *)data);
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
> +int get_count_write_value(void *const data, const enum count_value_type type,
> +			  const struct count_write_value *const val)
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
> +			char *buf),
> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t len),
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
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_comp_t *const component = devattr->component;
> +	struct counter_signal *const signal = component->signal;
> +	int err;
> +	struct signal_read_value val = { .buf = buf };
> +
> +	err = counter->ops->signal_read(counter, signal, &val);
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
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	const struct name_comp_t *const comp = to_counter_attr(attr)->component;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", comp->name);
> +}
> +
> +static int counter_name_attribute_create(
> +	struct counter_device_attr_group *const group,
> +	const char *const name)
> +{
> +	struct name_comp_t *name_comp;
> +	int err;
> +
> +	/* Skip if no name */
> +	if (!name)
> +		return 0;
> +
> +	/* Allocate name attribute component */
> +	name_comp = kmalloc(sizeof(*name_comp), GFP_KERNEL);
> +	if (!name_comp)
> +		return -ENOMEM;
> +	name_comp->name = name;
> +
> +	/* Allocate Signal name attribute */
> +	err = counter_attribute_create(group, "", "name",
> +				       counter_device_attr_name_show, NULL,
> +				       name_comp);
> +	if (err)
> +		goto err_free_name_comp;
> +
> +	return 0;
> +
> +err_free_name_comp:
> +	kfree(name_comp);
> +	return err;
> +}
> +
> +struct signal_ext_comp_t {
> +	struct counter_signal		*signal;
> +	const struct counter_signal_ext	*ext;
> +};
> +
> +static ssize_t counter_signal_ext_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_ext_comp_t *const comp = devattr->component;
> +	const struct counter_signal_ext *const ext = comp->ext;
> +
> +	return ext->read(dev_get_drvdata(dev), comp->signal, ext->priv, buf);
> +}
> +
> +static ssize_t counter_signal_ext_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct signal_ext_comp_t *const comp = devattr->component;
> +	const struct counter_signal_ext *const ext = comp->ext;
> +
> +	return ext->write(dev_get_drvdata(dev), comp->signal, ext->priv, buf,
> +		len);
> +}
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
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = signal->ext + i;
> +
> +		/* Allocate signal_ext attribute component */
> +		signal_ext_comp = kmalloc(sizeof(*signal_ext_comp), GFP_KERNEL);
> +		if (!signal_ext_comp) {
> +			err = -ENOMEM;
> +			goto err_free_attr_list;
> +		}
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
> +			goto err_free_attr_list;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +static int counter_signal_attributes_create(
> +	struct counter_device_attr_group *const group,
> +	const struct counter_device *const counter,
> +	struct counter_signal *const signal)
> +{
> +	struct signal_comp_t *signal_comp;
> +	int err;
> +
> +	/* Allocate Signal attribute component */
> +	signal_comp = kmalloc(sizeof(*signal_comp), GFP_KERNEL);
> +	if (!signal_comp)
> +		return -ENOMEM;
> +	signal_comp->signal = signal;
> +
> +	/* Create main Signal attribute */
> +	err = counter_attribute_create(group, "", "signal",
> +		(counter->ops->signal_read) ? counter_signal_show : NULL, NULL,
> +		signal_comp);
> +	if (err) {
> +		kfree(signal_comp);
> +		return err;
> +	}
> +
> +	/* Create Signal name attribute */
> +	err = counter_name_attribute_create(group, signal->name);
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	/* Register Signal extension attributes */
> +	err = counter_signal_ext_register(group, signal);
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +static int counter_signals_register(
> +	struct counter_device_attr_group *const groups_list,
> +	const struct counter_device *const counter)
> +{
> +	const size_t num_signals = counter->num_signals;
> +	size_t i;
> +	struct counter_signal *signal;
> +	const char *name;
> +	int err;
> +
> +	/* Register each Signal */
> +	for (i = 0; i < num_signals; i++) {
> +		signal = counter->signals + i;
> +
> +		/* Generate Signal attribute directory name */
> +		name = kasprintf(GFP_KERNEL, "signal%d", signal->id);
> +		if (!name) {
> +			err = -ENOMEM;
> +			goto err_free_attr_groups;
> +		}
> +		groups_list[i].attr_group.name = name;
> +
> +		/* Create all attributes associated with Signal */
> +		err = counter_signal_attributes_create(groups_list + i, counter,
> +						       signal);
> +		if (err)
> +			goto err_free_attr_groups;
> +	}
> +
> +	return 0;
> +
> +err_free_attr_groups:
> +	do {
> +		kfree(groups_list[i].attr_group.name);
> +		free_counter_device_attr_list(&groups_list[i].attr_list);
> +	} while (i--);
> +	return err;
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
> +				   struct device_attribute *attr, char *buf)
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
> +	err = counter->ops->action_get(counter, count, synapse, &action_index);
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
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
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
> +	err = counter->ops->action_set(counter, count, synapse, action_index);
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

I'm not sure this local variable helps much either...

> +	const size_t num_actions = component->num_actions;

Local variable adds nothing as far as I can see..  Just use it inline.


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

Local variable doesn't add anything. Only used once.

> +	size_t i;
> +	struct counter_synapse *synapse;
> +	const char *prefix;
> +	struct action_comp_t *action_comp;
> +	int err;
> +	struct action_avail_comp_t *avail_comp;
> +
> +	/* Register each Synapse */
> +	for (i = 0; i < num_synapses; i++) {
> +		synapse = count->synapses + i;
> +
> +		/* Generate attribute prefix */
> +		prefix = kasprintf(GFP_KERNEL, "signal%d_",
> +				   synapse->signal->id);
> +		if (!prefix) {
> +			err = -ENOMEM;
> +			goto err_free_attr_list;
> +		}
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
> +			(counter->ops->action_get) ? counter_action_show : NULL,
> +			(counter->ops->action_set) ? counter_action_store : NULL,
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
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +struct count_comp_t {
> +	struct counter_count	*count;
> +};
> +
> +static ssize_t counter_count_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	int err;
> +	struct count_read_value val = { .buf = buf };
> +
> +	err = counter->ops->count_read(counter, count, &val);
> +	if (err)
> +		return err;
> +
> +	return val.len;
> +}
> +
> +static ssize_t counter_count_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	int err;
> +	struct count_write_value val = { .buf = buf };
> +
> +	err = counter->ops->count_write(counter, count, &val);
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
> +	[COUNT_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
> +	[COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
> +	[COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
> +	[COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
> +	[COUNT_FUNCTION_QUADRATURE_X2_RISING] = "quadrature x2 rising",
> +	[COUNT_FUNCTION_QUADRATURE_X2_FALLING] = "quadrature x2 falling",
> +	[COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
> +};
> +
> +static ssize_t counter_function_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	int err;
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_comp_t *const component = devattr->component;
> +	struct counter_count *const count = component->count;
> +	size_t func_index;
> +	enum count_function function;
> +
> +	err = counter->ops->function_get(counter, count, &func_index);
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
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
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
> +	err = counter->ops->function_set(counter, count, func_index);
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
> +				      struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_ext_comp_t *const comp = devattr->component;
> +	const struct counter_count_ext *const ext = comp->ext;
> +
> +	return ext->read(dev_get_drvdata(dev), comp->count, ext->priv, buf);
> +}
> +
> +static ssize_t counter_count_ext_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct count_ext_comp_t *const comp = devattr->component;
> +	const struct counter_count_ext *const ext = comp->ext;
> +
> +	return ext->write(dev_get_drvdata(dev), comp->count, ext->priv, buf,
> +		len);
> +}
> +
> +static int counter_count_ext_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_count *const count)
> +{
> +	const size_t num_ext = count->num_ext;

Used in one place, just put it inline?

> +	size_t i;
> +	const struct counter_count_ext *ext;
> +	struct count_ext_comp_t *count_ext_comp;
> +	int err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = count->ext + i;
> +
> +		/* Allocate count_ext attribute component */
> +		count_ext_comp = kmalloc(sizeof(*count_ext_comp), GFP_KERNEL);
> +		if (!count_ext_comp) {
> +			err = -ENOMEM;
> +			goto err_free_attr_list;
> +		}
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
> +			goto err_free_attr_list;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
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
> +
> +	/* Allocate count attribute component */
> +	count_comp = kmalloc(sizeof(*count_comp), GFP_KERNEL);
> +	if (!count_comp)
> +		return -ENOMEM;
> +	count_comp->count = count;
> +
> +	/* Create main Count attribute */
> +	err = counter_attribute_create(group, "", "count",
> +		(counter->ops->count_read) ? counter_count_show : NULL,
> +		(counter->ops->count_write) ? counter_count_store : NULL,
> +		count_comp);
> +	if (err) {
> +		kfree(count_comp);
> +		return err;
> +	}
> +
> +	/* Allocate function attribute component */
> +	func_comp = kmalloc(sizeof(*func_comp), GFP_KERNEL);
> +	if (!func_comp) {
> +		err = -ENOMEM;
> +		goto err_free_attr_list;
> +	}
> +	func_comp->count = count;
> +
> +	/* Create Count function attribute */
> +	err = counter_attribute_create(group, "", "function",
> +		(counter->ops->function_get) ? counter_function_show : NULL,
> +		(counter->ops->function_set) ? counter_function_store : NULL,
> +		func_comp);
> +	if (err) {
> +		kfree(func_comp);
> +		goto err_free_attr_list;
> +	}
> +
> +	/* Allocate function available attribute component */
> +	avail_comp = kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> +	if (!avail_comp) {
> +		err = -ENOMEM;
> +		goto err_free_attr_list;
> +	}
> +	avail_comp->functions_list = count->functions_list;
> +	avail_comp->num_functions = count->num_functions;
> +
> +	/* Create Count function_available attribute */
> +	err = counter_attribute_create(group, "", "function_available",
> +				       counter_count_function_available_show,
> +				       NULL, avail_comp);
> +	if (err) {
> +		kfree(avail_comp);
> +		goto err_free_attr_list;
> +	}
> +
> +	/* Create Count name attribute */
> +	err = counter_name_attribute_create(group, count->name);
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	/* Register Count extension attributes */
> +	err = counter_count_ext_register(group, count);
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +static int counter_counts_register(
> +	struct counter_device_attr_group *const groups_list,
> +	const struct counter_device *const counter)
> +{
> +	const size_t num_counts = counter->num_counts;

I think this is only used on one place.  Not sure having
a local variable is worthwhile.

> +	size_t i;
> +	struct counter_count *count;
> +	const char *name;
> +	int err;
> +
> +	/* Register each Count */
> +	for (i = 0; i < num_counts; i++) {
> +		count = counter->counts + i;
> +
> +		/* Generate Count attribute directory name */
> +		name = kasprintf(GFP_KERNEL, "count%d", count->id);
> +		if (!name) {
> +			err = -ENOMEM;
> +			goto err_free_attr_groups;
> +		}
> +		groups_list[i].attr_group.name = name;
> +
> +		/* Register the Synapses associated with each Count */
> +		err = counter_synapses_register(groups_list + i, counter, count,
> +						name);
> +		if (err)
> +			goto err_free_attr_groups;
> +
> +		/* Create all attributes associated with Count */
> +		err = counter_count_attributes_create(groups_list + i, counter,
> +						      count);
> +		if (err)
> +			goto err_free_attr_groups;
> +	}
> +
> +	return 0;
> +
> +err_free_attr_groups:
> +	do {
> +		kfree(groups_list[i].attr_group.name);
> +		free_counter_device_attr_list(&groups_list[i].attr_list);
> +	} while (i--);
> +	return err;
> +}
> +
> +struct size_comp_t {
> +	size_t size;
> +};
> +
> +static ssize_t counter_device_attr_size_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	const struct size_comp_t *const comp = to_counter_attr(attr)->component;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%zu\n", comp->size);
> +}
> +
> +static int counter_size_attribute_create(
> +	struct counter_device_attr_group *const group,
> +	const size_t size, const char *const name)
> +{
> +	struct size_comp_t *size_comp;
> +	int err;
> +
> +	/* Allocate size attribute component */
> +	size_comp = kmalloc(sizeof(*size_comp), GFP_KERNEL);
> +	if (!size_comp)
> +		return -ENOMEM;
> +	size_comp->size = size;
> +
> +	err = counter_attribute_create(group, "", name,
> +				       counter_device_attr_size_show, NULL,
> +				       size_comp);
> +	if (err)
> +		goto err_free_size_comp;
> +
> +	return 0;
> +
> +err_free_size_comp:
> +	kfree(size_comp);
> +	return err;
> +}
> +
> +struct ext_comp_t {
> +	const struct counter_device_ext	*ext;
> +};
> +
> +static ssize_t counter_device_ext_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct ext_comp_t *const component = devattr->component;
> +	const struct counter_device_ext *const ext = component->ext;
> +
> +	return ext->read(dev_get_drvdata(dev), ext->priv, buf);
> +}
> +
> +static ssize_t counter_device_ext_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
> +	const struct ext_comp_t *const component = devattr->component;
> +	const struct counter_device_ext *const ext = component->ext;
> +
> +	return ext->write(dev_get_drvdata(dev), ext->priv, buf, len);
> +}
> +
> +static int counter_device_ext_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_device *const counter)
> +{
> +	const size_t num_ext = counter->num_ext;

num_ext only used in one place so if anything the local variable
is hurting readability.

> +	struct ext_comp_t *ext_comp;
> +	size_t i;
> +	const struct counter_device_ext *ext;
> +	int err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0 ; i < num_ext; i++) {
> +		ext = counter->ext + i;

This local variable isn't gaining us much that I can see. Just
use the value directly.

> +
> +		/* Allocate extension attribute component */
> +		ext_comp = kmalloc(sizeof(*ext_comp), GFP_KERNEL);
> +		if (!ext_comp) {
> +			err = -ENOMEM;
> +			goto err_free_attr_list;
> +		}
> +
> +		ext_comp->ext = ext;
> +
> +		/* Allocate extension attribute */
> +		err = counter_attribute_create(group, "", ext->name,
> +			(ext->read) ? counter_device_ext_show : NULL,
> +			(ext->write) ? counter_device_ext_store : NULL,
> +			ext_comp);
> +		if (err) {
> +			kfree(ext_comp);
> +			goto err_free_attr_list;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +static int counter_global_attr_register(
> +	struct counter_device_attr_group *const group,
> +	struct counter_device *const counter)
> +{
> +	int err;
> +
> +	/* Create name attribute */
> +	err = counter_name_attribute_create(group, counter->name);
> +	if (err)
> +		return err;
> +
> +	/* Create num_counts attribute */
> +	err = counter_size_attribute_create(group, counter->num_counts,
> +					    "num_counts");
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	/* Create num_signals attribute */
> +	err = counter_size_attribute_create(group, counter->num_signals,
> +					    "num_signals");
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	/* Register Counter device extension attributes */
> +	err = counter_device_ext_register(group, counter);
> +	if (err)
> +		goto err_free_attr_list;
> +
> +	return 0;
> +
> +err_free_attr_list:
> +	free_counter_device_attr_list(&group->attr_list);
> +	return err;
> +}
> +
> +static void free_counter_device_groups_list(
> +	struct counter_device_attr_group *const groups_list,
> +	const size_t num_groups)
> +{
> +	struct counter_device_attr_group *group;
> +	size_t i;
> +
> +	for (i = 0; i < num_groups; i++) {
> +		group = groups_list + i;
> +

I'd like to see a comment somewhere here on the fact this cleans up both
the registered per counter stuff and the global attributes (that took
a bit of chasing to check it did...)

> +		kfree(group->attr_group.name);
> +		kfree(group->attr_group.attrs);
> +		free_counter_device_attr_list(&group->attr_list);
> +	}
> +
> +	kfree(groups_list);
> +}
> +
> +static int prepare_counter_device_groups_list(
> +	struct counter_device *const counter)
> +{
> +	const size_t total_num_groups =
> +		counter->num_signals + counter->num_counts + 1;
> +	struct counter_device_attr_group *groups_list;
> +	size_t i;
> +	int err;
> +	size_t num_groups = 0;
> +
> +	/* Allocate space for attribute groups (signals. counts, and ext) */
> +	groups_list = kcalloc(total_num_groups, sizeof(*groups_list),
> +			      GFP_KERNEL);
> +	if (!groups_list)
> +		return -ENOMEM;
> +
> +	/* Initialize attribute lists */
> +	for (i = 0; i < total_num_groups; i++)
> +		INIT_LIST_HEAD(&groups_list[i].attr_list);
> +
> +	/* Register Signals */
> +	err = counter_signals_register(groups_list, counter);
> +	if (err)
> +		goto err_free_groups_list;
> +	num_groups += counter->num_signals;
> +
> +	/* Register Counts and respective Synapses */
> +	err = counter_counts_register(groups_list + num_groups, counter);
> +	if (err)
> +		goto err_free_groups_list;
> +	num_groups += counter->num_counts;
> +
> +	/* Register Counter global attributes */
> +	err = counter_global_attr_register(groups_list + num_groups, counter);
> +	if (err)
> +		goto err_free_groups_list;
> +	num_groups++;
> +
> +	/* Store groups_list in device_state */
> +	counter->device_state->groups_list = groups_list;
> +	counter->device_state->num_groups = num_groups;
> +
> +	return 0;
> +
> +err_free_groups_list:
> +	free_counter_device_groups_list(groups_list, num_groups);

Consistent naming would be good.

counter_device_groups_list_free.

I would tidy this up throughout.  I know from experience that
you'll probably end up doing so eventually and it is easier whilst
there isn't too much code.

> +	return err;
> +}
> +
> +static int prepare_counter_device_groups(
> +	struct counter_device_state *const device_state)
> +{
> +	size_t i;
> +	struct counter_device_attr_group *group;
> +	int err;
> +	size_t j;

Tidy this up a little,
size_t i, j;

> +	struct counter_device_attr *p;
> +
> +	/* Allocate attribute groups for association with device */
> +	device_state->groups = kcalloc(device_state->num_groups + 1,
> +				       sizeof(*device_state->groups),
> +				       GFP_KERNEL);
> +	if (!device_state->groups)
> +		return -ENOMEM;
> +
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
> +	return 0;
> +
> +err_free_groups:

I'm not convinced this is cleaning up properly.  What about
the kcalloc of group->attr_group.attrs for previous loops?

> +	kfree(device_state->groups);
> +	return err;
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
> +	free_counter_device_groups_list(device_state->groups_list,
> +					device_state->num_groups);
> +	ida_simple_remove(&counter_ida, device_state->id);
> +	kfree(device_state);
> +}
> +
> +static struct device_type counter_device_type = {
> +	.name = "counter_device",
> +	.release = counter_device_release
> +};
> +
> +static struct bus_type counter_bus_type = {
> +	.name = "counter"
> +};
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
> +	/* Prepare device attributes */
> +	err = prepare_counter_device_groups_list(counter);
> +	if (err)
> +		goto err_free_id;
> +
> +	/* Organize device attributes to groups and match to device */
> +	err = prepare_counter_device_groups(device_state);
> +	if (err)
> +		goto err_free_groups_list;
> +
> +	/* Add device to system */
> +	err = device_add(&device_state->dev);
> +	if (err)
> +		goto err_free_groups;
> +
> +	return 0;
> +
> +err_free_groups:
> +	kfree(device_state->groups);
> +err_free_groups_list:
> +	free_counter_device_groups_list(device_state->groups_list,
> +					device_state->num_groups);
> +err_free_id:
> +	ida_simple_remove(&counter_ida, device_state->id);
> +err_free_device_state:
> +	kfree(device_state);
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
> +			  struct counter_device *const counter)
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
> +	} else {
> +		devres_free(ptr);
> +	}
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
> +			     struct counter_device *const counter)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_counter_unreg, devm_counter_match,
> +			    counter);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL(devm_counter_unregister);
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
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> new file mode 100644
> index 000000000000..a0b0349d098a
> --- /dev/null
> +++ b/include/linux/counter.h
> @@ -0,0 +1,554 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
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

It's a bit controversial, but most people consider SPDX headers equivalent
of the license statement.  As such you normally don't have both and just
go for the SPDK header.

I thought we were also standardising on 
// SPDX-...


> + */
> +#ifndef _COUNTER_H_
> +#define _COUNTER_H_
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +enum count_direction {
> +	COUNT_DIRECTION_FORWARD = 0,
> +	COUNT_DIRECTION_BACKWARD
> +};
> +extern const char *const count_direction_str[2];
> +
> +enum count_mode {
> +	COUNT_MODE_NORMAL = 0,
> +	COUNT_MODE_RANGE_LIMIT,
> +	COUNT_MODE_NON_RECYCLE,
> +	COUNT_MODE_MODULO_N
> +};
> +extern const char *const count_mode_str[4];
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
> +				 struct counter_signal *signal, void *priv,
> +				 const char *buf, size_t len);
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
> +				       struct counter_signal *signal,
> +				       size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +				       struct counter_signal *signal,
> +				       size_t item);
> +};
> +
> +ssize_t counter_signal_enum_read(struct counter_device *counter,
> +				 struct counter_signal *signal, void *priv,
> +				 char *buf);
> +ssize_t counter_signal_enum_write(struct counter_device *counter,
> +				  struct counter_signal *signal, void *priv,
> +				  const char *buf, size_t len);
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
> +ssize_t counter_signal_enum_available_read(struct counter_device *counter,
> +					   struct counter_signal *signal,
> +					   void *priv, char *buf);
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
> +				 struct counter_count *count, void *priv,
> +				 const char *buf, size_t len);
> +	void		*priv;
> +};
> +
> +enum count_function {
> +	COUNT_FUNCTION_INCREASE = 0,
> +	COUNT_FUNCTION_DECREASE,
> +	COUNT_FUNCTION_PULSE_DIRECTION,
> +	COUNT_FUNCTION_QUADRATURE_X1_A,
> +	COUNT_FUNCTION_QUADRATURE_X1_B,
> +	COUNT_FUNCTION_QUADRATURE_X2_A,
> +	COUNT_FUNCTION_QUADRATURE_X2_B,
> +	COUNT_FUNCTION_QUADRATURE_X2_RISING,
> +	COUNT_FUNCTION_QUADRATURE_X2_FALLING,
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

There is a very good illustration here of the issues with using
tabs to pretty print structure elements.  I would drop them entirely as
personally I'm not sure they help readability and you will forever be having
more noise in patches because of the need to change the number of tabs
due to name changes etc.

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
> +				       struct counter_count *count,
> +				       size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       size_t item);
> +};
> +
> +ssize_t counter_count_enum_read(struct counter_device *counter,
> +				struct counter_count *count, void *priv,
> +				char *buf);
> +ssize_t counter_count_enum_write(struct counter_device *counter,
> +				 struct counter_count *count, void *priv,
> +				 const char *buf, size_t len);
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
> +ssize_t counter_count_enum_available_read(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  void *priv, char *buf);
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

Run kernel-doc script over these files.  You are missing some :s and it would
have told you that.

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
> + * struct counter_ops - Callbacks from driver
> + * @signal_read:	optional read callback for Signal attribute. The read
> + *			value of the respective Signal should be passed back via
> + *			the val parameter. val points to an opaque type which
> + *			should be set only via the set_signal_read_value
> + *			function.

This last part had me a little confused.  I would make it clear that this
set_signal_read_value function should be called to set the value within this
signal_read callback rather than elsewhere...  

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
> + */
> +struct counter_ops {
> +	int	(*signal_read)(struct counter_device *counter,
> +			       struct counter_signal *signal,
> +			       struct signal_read_value *val);
> +	int	(*count_read)(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      struct count_read_value *val);
> +	int	(*count_write)(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       struct count_write_value *val);
> +	int	(*function_get)(struct counter_device *counter,
> +				struct counter_count *count, size_t *function);
> +	int	(*function_set)(struct counter_device *counter,
> +				struct counter_count *count, size_t function);
> +	int	(*action_get)(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      struct counter_synapse *synapse, size_t *action);
> +	int	(*action_set)(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      struct counter_synapse *synapse, size_t action);
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
> +				 const char *buf, size_t len);
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
> +				       size_t *item);
> +	int			(*set)(struct counter_device *counter,
> +				       size_t item);
> +};
> +
> +ssize_t counter_device_enum_read(struct counter_device *counter, void *priv,
> +				 char *buf);
> +ssize_t counter_device_enum_write(struct counter_device *counter, void *priv,
> +				  const char *buf, size_t len);
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
> +ssize_t counter_device_enum_available_read(struct counter_device *counter,
> +					   void *priv, char *buf);
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
> + * @ops:		callbacks from driver
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
> +	const struct counter_ops	*ops;
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
> +};
> +
> +enum count_value_type {
> +	COUNT_POSITION_UNSIGNED = 0,
> +	COUNT_POSITION_SIGNED
> +};
> +
> +void set_signal_read_value(struct signal_read_value *const val,
> +			   const enum signal_value_type type, void *const data);
> +void set_count_read_value(struct count_read_value *const val,
> +			  const enum count_value_type type, void *const data);
> +int get_count_write_value(void *const data, const enum count_value_type type,
> +			  const struct count_write_value *const val);

I wonder if naming wise, we would be better sticking to the
noun_verb naming format.

signal_read_value_set
count_read_value_set
count_write_value_get

for example?

> +
> +int counter_register(struct counter_device *const counter);
> +void counter_unregister(struct counter_device *const counter);
> +int devm_counter_register(struct device *dev,
> +			  struct counter_device *const counter);
> +void devm_counter_unregister(struct device *dev,
> +			     struct counter_device *const counter);
> +
> +#endif /* _COUNTER_H_ */
