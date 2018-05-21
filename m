Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeEUNvd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:51:33 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34692 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeEUNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:51:30 -0400
X-Google-Smtp-Source: AB8JxZoZsUdyOfyIhK40kellqXdzYikmvWRGCY48pr7l5hYyaP1ipKOLdugbZFv0n0MnbKbdCQY87A==
Date: Mon, 21 May 2018 09:51:27 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/9] counter: 104-quad-8: Add Generic Counter
 interface support
Message-ID: <20180521135127.GC5723@sophia>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
 <20180520164253.5432d2a4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180520164253.5432d2a4@archlinux>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 04:42:53PM +0100, Jonathan Cameron wrote:
>On Wed, 16 May 2018 13:51:25 -0400
>William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch adds support for the Generic Counter interface to the
>> 104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
>> be affected by this patch; all changes are intended as supplemental
>> additions as perceived by the user.
>> 
>> Generic Counter Counts are created for the eight quadrature channel
>> counts, as well as their respective quadrature A and B Signals (which
>> are associated via respective Synapse structures) and respective index
>> Signals.
>> 
>> The new Generic Counter interface sysfs attributes are intended to
>> expose the same functionality and data available via the existing
>> 104-QUAD-8 IIO device interface; the Generic Counter interface serves
>> to provide the respective functionality and data in a standard way
>> expected of counter devices.
>> 
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>A few general comments that applied just as well to the original driver
>as they do to the modified version.
>
>I wonder if this would be easier to review as two patches.
>Move the driver then add the counter interfaces?
>
>Right now people kind of have to review the old IIO driver and
>all the new stuff which is a big job..
>
>Jonathan

This looks like more simple cleanup, so I expect to incorporate your
suggestions without problem here as well. I'll also try to make the code
easier to read by writing some defines for the magic numbers throughout.

William Breathitt Gray

>> ---
>>  MAINTAINERS                      |    4 +-
>>  drivers/counter/104-quad-8.c     | 1335 ++++++++++++++++++++++++++++++
>>  drivers/counter/Kconfig          |   21 +
>>  drivers/counter/Makefile         |    2 +
>>  drivers/iio/counter/104-quad-8.c |  596 -------------
>>  drivers/iio/counter/Kconfig      |   17 -
>>  drivers/iio/counter/Makefile     |    1 -
>>  7 files changed, 1360 insertions(+), 616 deletions(-)
>>  create mode 100644 drivers/counter/104-quad-8.c
>>  delete mode 100644 drivers/iio/counter/104-quad-8.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7a01aa63fb33..f11bf7885aeb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -266,12 +266,12 @@ L:	linux-gpio@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/gpio/gpio-104-idio-16.c
>>  
>> -ACCES 104-QUAD-8 IIO DRIVER
>> +ACCES 104-QUAD-8 DRIVER
>>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>> -F:	drivers/iio/counter/104-quad-8.c
>> +F:	drivers/counter/104-quad-8.c
>>  
>>  ACCES PCI-IDIO-16 GPIO DRIVER
>>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
>> new file mode 100644
>> index 000000000000..7c72fb72d660
>> --- /dev/null
>> +++ b/drivers/counter/104-quad-8.c
>> @@ -0,0 +1,1335 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>
>If you are happy with SPDX drop the GPL text below to keep things
>short.
>
>> +/*
>> + * IIO driver for the ACCES 104-QUAD-8
>> + * Copyright (C) 2016 William Breathitt Gray
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
>> + */
>> +#include <linux/bitops.h>
>...
>> +static int quad8_probe(struct device *dev, unsigned int id)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct quad8_iio *quad8iio;
>> +	int i, j;
>> +	unsigned int base_offset;
>> +	int err;
>> +
>> +	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
>> +		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
>> +			base[id], base[id] + QUAD8_EXTENT);
>> +		return -EBUSY;
>> +	}
>> +
>> +	/* Allocate IIO device; this also allocates driver data structure */
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	/* Initialize IIO device */
>> +	indio_dev->info = &quad8_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
>> +	indio_dev->channels = quad8_channels;
>> +	indio_dev->name = dev_name(dev);
>> +	indio_dev->dev.parent = dev;
>> +
>> +	/* Initialize Counter device and driver data */
>> +	quad8iio = iio_priv(indio_dev);
>> +	quad8iio->counter.name = dev_name(dev);
>> +	quad8iio->counter.parent = dev;
>> +	quad8iio->counter.ops = &quad8_ops;
>> +	quad8iio->counter.counts = quad8_counts;
>> +	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
>> +	quad8iio->counter.signals = quad8_signals;
>> +	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
>> +	quad8iio->counter.priv = quad8iio;
>> +	quad8iio->base = base[id];
>> +
>> +	/* Reset all counters and disable interrupt function */
>> +	outb(0x01, base[id] + 0x11);
>> +	/* Set initial configuration for all counters */
>> +	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
>> +		base_offset = base[id] + 2 * i;
>> +		/* Reset Byte Pointer */
>> +		outb(0x01, base_offset + 1);
>
>I'm going to be fussy.  There are lots of values
>in here that look like register bits and you could exchange much of
>this documentation for a some good defines...
>
>Taking base_offset + 1 bits 5 and 6 look to select the actual register
>and the rest of them do the control.
>
>Anyhow, not critical but the readability of this code could be improved
>somewhat.
>
>> +		/* Reset Preset Register */
>> +		for (j = 0; j < 3; j++)
>> +			outb(0x00, base_offset);
>> +		/* Reset Borrow, Carry, Compare, and Sign flags */
>> +		outb(0x04, base_offset + 1);
>> +		/* Reset Error flag */
>> +		outb(0x06, base_offset + 1);
>> +		/* Binary encoding; Normal count; non-quadrature mode */
>> +		outb(0x20, base_offset + 1);
>> +		/* Disable A and B inputs; preset on index; FLG1 as Carry */
>> +		outb(0x40, base_offset + 1);
>> +		/* Disable index function; negative index polarity */
>> +		outb(0x60, base_offset + 1);
>> +	}
>> +	/* Enable all counters */
>> +	outb(0x00, base[id] + 0x11);
>> +
>> +	/* Register IIO device */
>> +	err = devm_iio_device_register(dev, indio_dev);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Register Counter device */
>> +	return devm_counter_register(dev, &quad8iio->counter);
>> +}
>> +
>> +static struct isa_driver quad8_driver = {
>> +	.probe = quad8_probe,
>> +	.driver = {
>> +		.name = "104-quad-8"
>> +	}
>> +};
>> +
>> +module_isa_driver(quad8_driver, num_quad8);
>> +
>> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
>> +MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
>> index 65fa92abd5a4..73f03372484f 100644
>> --- a/drivers/counter/Kconfig
>> +++ b/drivers/counter/Kconfig
>> @@ -16,3 +16,24 @@ menuconfig COUNTER
>>  	  consumption. The Generic Counter interface enables drivers to support
>>  	  and expose a common set of components and functionality present in
>>  	  counter devices.
>> +
>> +if COUNTER
>> +
>> +config 104_QUAD_8
>> +	tristate "ACCES 104-QUAD-8 driver"
>> +	depends on PC104 && X86 && IIO
>> +	select ISA_BUS_API
>> +	help
>> +	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
>> +	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
>> +
>> +	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
>> +	  also clears the counter's respective error flag. Although the counters
>> +	  have a 25-bit range, only the lower 24 bits may be set, either directly
>> +	  or via a counter's preset attribute. Interrupts are not supported by
>> +	  this driver.
>
>This text probably wants to be updated to reflect the new counter subsystem support..
>
>> +
>> +	  The base port addresses for the devices may be configured via the base
>> +	  array module parameter.
>> +
>> +endif # COUNTER
>> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
>> index ad1ba7109cdc..23a4f6263e45 100644
>> --- a/drivers/counter/Makefile
>> +++ b/drivers/counter/Makefile
>> @@ -6,3 +6,5 @@
>>  
>>  obj-$(CONFIG_COUNTER) += counter.o
>>  counter-y := generic-counter.o
>> +
>> +obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
>...
