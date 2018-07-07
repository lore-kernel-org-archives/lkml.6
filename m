Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C9C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB952089F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB952089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeGGPQ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:16:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeGGPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:16:26 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8303DBE;
        Sat,  7 Jul 2018 15:16:24 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:16:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180707151622.GB410@kroah.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:07:08PM -0400, William Breathitt Gray wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                       |    7 +
>  drivers/Kconfig                   |    2 +
>  drivers/Makefile                  |    1 +
>  drivers/counter/Kconfig           |   18 +
>  drivers/counter/Makefile          |    8 +
>  drivers/counter/generic-counter.c | 1519 +++++++++++++++++++++++++++++
>  include/linux/counter.h           |  534 ++++++++++
>  7 files changed, 2089 insertions(+)
>  create mode 100644 drivers/counter/Kconfig
>  create mode 100644 drivers/counter/Makefile
>  create mode 100644 drivers/counter/generic-counter.c
>  create mode 100644 include/linux/counter.h

First cut of review, does counter.h really have to be that big?  It
feels like some of the "internal" functions and structures could be
local to drivers/counter/ right?


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

No need to explain an "API" in a Kconfig help text, which is for a user
of the kernel, not for someone writing kernel code.  Odds are individual
drivers will need to select this, or are you going to depend on this
option?


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

Why does it matter?  :)

> +
> +obj-$(CONFIG_COUNTER) += counter.o
> +counter-y := generic-counter.o

Why not just call your .c file, "counter.c" to keep this simple?

> diff --git a/drivers/counter/generic-counter.c b/drivers/counter/generic-counter.c
> new file mode 100644
> index 000000000000..483826c8ce01
> --- /dev/null
> +++ b/drivers/counter/generic-counter.c
> @@ -0,0 +1,1519 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Please use the normal SPDX identifiers we are using, as described in the
kernel documentation.  We aren't ready to use the "new" ones just yet.

> +/*
> + * Generic Counter interface
> + * Copyright (C) 2017 William Breathitt Gray

It's 2018 now :)

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

Why a blank line?

> +
> +const char *const count_direction_str[2] = {
> +	[COUNT_DIRECTION_FORWARD] = "forward",
> +	[COUNT_DIRECTION_BACKWARD] = "backward"
> +};
> +EXPORT_SYMBOL(count_direction_str);

I have to ask, for all of these, why not EXPORT_SYMBOL_GPL()?


> +
> +const char *const count_mode_str[4] = {
> +	[COUNT_MODE_NORMAL] = "normal",
> +	[COUNT_MODE_RANGE_LIMIT] = "range limit",
> +	[COUNT_MODE_NON_RECYCLE] = "non-recycle",
> +	[COUNT_MODE_MODULO_N] = "modulo-n"
> +};
> +EXPORT_SYMBOL(count_mode_str);

And why do you need to export strings?



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

How can e->get not be set?  Shouldn't you just not have called into this
if so?

> +
> +	err = e->get(counter, signal, &index);
> +	if (err)
> +		return err;
> +
> +	if (index >= e->num_items)
> +		return -EINVAL;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", e->items[index]);

No need to do the scnprintf() crud, it's a sysfs file, a simple
sprintf() works just fine.  Yeah, it makes people nervous, and it should :)


> +}
> +EXPORT_SYMBOL(counter_signal_enum_read);

sysfs attribute files really should be EXPORT_SYMBOL_GPL() please.

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

Again, how can this be true?


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

a list of items?  In sysfs?  Are you _SURE_ you want to do that?

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


Same comment everywhere for this...

let's skip lower in the files...

> +static int counter_attribute_create(
> +	struct counter_device_attr_group *const group,
> +	const char *const prefix,
> +	const char *const name,
> +	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
> +			char *buf),
> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t len),

Typedefs for these function pointers are good to have.

> +	void *const component)

That's a crazy list of parameters...


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

So you are dynamically creating sysfs attributes?  Why not just have one
big group and only enable them if needed?  That would make things a lot
simpler, right?

> +struct signal_comp_t {

"_t"???

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

"_t"???

Same for the rest of this file...

> diff --git a/include/linux/counter.h b/include/linux/counter.h
> new file mode 100644
> index 000000000000..88fc82ee30a7
> --- /dev/null
> +++ b/include/linux/counter.h
> @@ -0,0 +1,534 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Same identifier issue.

> +/*
> + * Counter interface
> + * Copyright (C) 2017 William Breathitt Gray

2018!

And again, it looks like this file can be a lot smaller, but I don't see
a user of it just yet, so I don't really know...

thanks,

greg k-h
