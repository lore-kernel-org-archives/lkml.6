Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeEPRvh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:51:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42022 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEPRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:51:33 -0400
X-Google-Smtp-Source: AB8JxZpO0V8PXi+6lebHurotTvA8sHcuS5LEaUtv3N/epgcHKM76YNT59cnXXgqGG9HEX0W4Xo5iXg==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 4/9] counter: 104-quad-8: Add Generic Counter interface support
Date: Wed, 16 May 2018 13:51:25 -0400
Message-Id: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Generic Counter interface to the
104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
be affected by this patch; all changes are intended as supplemental
additions as perceived by the user.

Generic Counter Counts are created for the eight quadrature channel
counts, as well as their respective quadrature A and B Signals (which
are associated via respective Synapse structures) and respective index
Signals.

The new Generic Counter interface sysfs attributes are intended to
expose the same functionality and data available via the existing
104-QUAD-8 IIO device interface; the Generic Counter interface serves
to provide the respective functionality and data in a standard way
expected of counter devices.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                      |    4 +-
 drivers/counter/104-quad-8.c     | 1335 ++++++++++++++++++++++++++++++
 drivers/counter/Kconfig          |   21 +
 drivers/counter/Makefile         |    2 +
 drivers/iio/counter/104-quad-8.c |  596 -------------
 drivers/iio/counter/Kconfig      |   17 -
 drivers/iio/counter/Makefile     |    1 -
 7 files changed, 1360 insertions(+), 616 deletions(-)
 create mode 100644 drivers/counter/104-quad-8.c
 delete mode 100644 drivers/iio/counter/104-quad-8.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a01aa63fb33..f11bf7885aeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -266,12 +266,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
 
-ACCES 104-QUAD-8 IIO DRIVER
+ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
-F:	drivers/iio/counter/104-quad-8.c
+F:	drivers/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
new file mode 100644
index 000000000000..7c72fb72d660
--- /dev/null
+++ b/drivers/counter/104-quad-8.c
@@ -0,0 +1,1335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for the ACCES 104-QUAD-8
+ * Copyright (C) 2016 William Breathitt Gray
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
+ */
+#include <linux/bitops.h>
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/isa.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+
+#define QUAD8_EXTENT 32
+
+static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
+static unsigned int num_quad8;
+module_param_array(base, uint, &num_quad8, 0);
+MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
+
+#define QUAD8_NUM_COUNTERS 8
+
+/**
+ * struct quad8_iio - IIO device private data structure
+ * @counter:		instance of the counter_device
+ * @preset:		array of preset values
+ * @count_mode:		array of count mode configurations
+ * @quadrature_mode:	array of quadrature mode configurations
+ * @quadrature_scale:	array of quadrature mode scale configurations
+ * @ab_enable:		array of A and B inputs enable configurations
+ * @preset_enable:	array of set_to_preset_on_index attribute configurations
+ * @synchronous_mode:	array of index function synchronous mode configurations
+ * @index_polarity:	array of index function polarity configurations
+ * @base:		base port address of the IIO device
+ */
+struct quad8_iio {
+	struct counter_device counter;
+	unsigned int preset[QUAD8_NUM_COUNTERS];
+	unsigned int count_mode[QUAD8_NUM_COUNTERS];
+	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
+	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
+	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
+	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
+	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
+	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
+	unsigned int base;
+};
+
+static int quad8_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	unsigned int flags;
+	unsigned int borrow;
+	unsigned int carry;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_INDEX) {
+			*val = !!(inb(priv->base + 0x16) & BIT(chan->channel));
+			return IIO_VAL_INT;
+		}
+
+		flags = inb(base_offset + 1);
+		borrow = flags & BIT(0);
+		carry = !!(flags & BIT(1));
+
+		/* Borrow XOR Carry effectively doubles count range */
+		*val = (borrow ^ carry) << 24;
+
+		/* Reset Byte Pointer; transfer Counter to Output Latch */
+		outb(0x11, base_offset + 1);
+
+		for (i = 0; i < 3; i++)
+			*val |= (unsigned int)inb(base_offset) << (8 * i);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = priv->ab_enable[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = priv->quadrature_scale[chan->channel];
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static int quad8_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	int i;
+	unsigned int ior_cfg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_INDEX)
+			return -EINVAL;
+
+		/* Only 24-bit values are supported */
+		if ((unsigned int)val > 0xFFFFFF)
+			return -EINVAL;
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Counter can only be set via Preset Register */
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		/* Transfer Preset Register to Counter */
+		outb(0x08, base_offset + 1);
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register back to original value */
+		val = priv->preset[chan->channel];
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x02, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+
+		return 0;
+	case IIO_CHAN_INFO_ENABLE:
+		/* only boolean values accepted */
+		if (val < 0 || val > 1)
+			return -EINVAL;
+
+		priv->ab_enable[chan->channel] = val;
+
+		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
+
+		/* Load I/O control configuration */
+		outb(0x40 | ior_cfg, base_offset + 1);
+
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		/* Quadrature scaling only available in quadrature mode */
+		if (!priv->quadrature_mode[chan->channel] && (val2 || val != 1))
+			return -EINVAL;
+
+		/* Only three gain states (1, 0.5, 0.25) */
+		if (val == 1 && !val2)
+			priv->quadrature_scale[chan->channel] = 0;
+		else if (!val)
+			switch (val2) {
+			case 500000:
+				priv->quadrature_scale[chan->channel] = 1;
+				break;
+			case 250000:
+				priv->quadrature_scale[chan->channel] = 2;
+				break;
+			default:
+				return -EINVAL;
+			}
+		else
+			return -EINVAL;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info quad8_info = {
+	.read_raw = quad8_read_raw,
+	.write_raw = quad8_write_raw
+};
+
+static ssize_t quad8_read_preset(struct iio_dev *indio_dev, uintptr_t private,
+	const struct iio_chan_spec *chan, char *buf)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset[chan->channel]);
+}
+
+static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
+	const struct iio_chan_spec *chan, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	unsigned int preset;
+	int ret;
+	int i;
+
+	ret = kstrtouint(buf, 0, &preset);
+	if (ret)
+		return ret;
+
+	/* Only 24-bit values are supported */
+	if (preset > 0xFFFFFF)
+		return -EINVAL;
+
+	priv->preset[chan->channel] = preset;
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Set Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(preset >> (8 * i), base_offset);
+
+	return len;
+}
+
+static ssize_t quad8_read_set_to_preset_on_index(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+		!priv->preset_enable[chan->channel]);
+}
+
+static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
+	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	size_t len)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+	bool preset_enable;
+	int ret;
+	unsigned int ior_cfg;
+
+	ret = kstrtobool(buf, &preset_enable);
+	if (ret)
+		return ret;
+
+	/* Preset enable is active low in Input/Output Control register */
+	preset_enable = !preset_enable;
+
+	priv->preset_enable[chan->channel] = preset_enable;
+
+	ior_cfg = priv->ab_enable[chan->channel] |
+		(unsigned int)preset_enable << 1;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(0x40 | ior_cfg, base_offset);
+
+	return len;
+}
+
+static const char *const quad8_noise_error_states[] = {
+	"No excessive noise is present at the count inputs",
+	"Excessive noise is present at the count inputs"
+};
+
+static int quad8_get_noise_error(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	return !!(inb(base_offset) & BIT(4));
+}
+
+static const struct iio_enum quad8_noise_error_enum = {
+	.items = quad8_noise_error_states,
+	.num_items = ARRAY_SIZE(quad8_noise_error_states),
+	.get = quad8_get_noise_error
+};
+
+static const char *const quad8_count_direction_states[] = {
+	"down",
+	"up"
+};
+
+static int quad8_get_count_direction(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	return !!(inb(base_offset) & BIT(5));
+}
+
+static const struct iio_enum quad8_count_direction_enum = {
+	.items = quad8_count_direction_states,
+	.num_items = ARRAY_SIZE(quad8_count_direction_states),
+	.get = quad8_get_count_direction
+};
+
+static const char *const quad8_count_modes[] = {
+	"normal",
+	"range limit",
+	"non-recycle",
+	"modulo-n"
+};
+
+static int quad8_set_count_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int cnt_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned int mode_cfg = cnt_mode << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->count_mode[chan->channel] = cnt_mode;
+
+	/* Add quadrature mode configuration */
+	if (priv->quadrature_mode[chan->channel])
+		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_count_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->count_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_count_mode_enum = {
+	.items = quad8_count_modes,
+	.num_items = ARRAY_SIZE(quad8_count_modes),
+	.set = quad8_set_count_mode,
+	.get = quad8_get_count_mode
+};
+
+static const char *const quad8_synchronous_modes[] = {
+	"non-synchronous",
+	"synchronous"
+};
+
+static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int idr_cfg = synchronous_mode |
+		priv->index_polarity[chan->channel] << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	/* Index function must be non-synchronous in non-quadrature mode */
+	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
+		return -EINVAL;
+
+	priv->synchronous_mode[chan->channel] = synchronous_mode;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x60 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_synchronous_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->synchronous_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_synchronous_mode_enum = {
+	.items = quad8_synchronous_modes,
+	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
+	.set = quad8_set_synchronous_mode,
+	.get = quad8_get_synchronous_mode
+};
+
+static const char *const quad8_quadrature_modes[] = {
+	"non-quadrature",
+	"quadrature"
+};
+
+static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned int mode_cfg = priv->count_mode[chan->channel] << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	if (quadrature_mode)
+		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
+	else {
+		/* Quadrature scaling only available in quadrature mode */
+		priv->quadrature_scale[chan->channel] = 0;
+
+		/* Synchronous function not supported in non-quadrature mode */
+		if (priv->synchronous_mode[chan->channel])
+			quad8_set_synchronous_mode(indio_dev, chan, 0);
+	}
+
+	priv->quadrature_mode[chan->channel] = quadrature_mode;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_quadrature_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->quadrature_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_quadrature_mode_enum = {
+	.items = quad8_quadrature_modes,
+	.num_items = ARRAY_SIZE(quad8_quadrature_modes),
+	.set = quad8_set_quadrature_mode,
+	.get = quad8_get_quadrature_mode
+};
+
+static const char *const quad8_index_polarity_modes[] = {
+	"negative",
+	"positive"
+};
+
+static int quad8_set_index_polarity(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int index_polarity)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int idr_cfg = priv->synchronous_mode[chan->channel] |
+		index_polarity << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->index_polarity[chan->channel] = index_polarity;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x60 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_index_polarity(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->index_polarity[chan->channel];
+}
+
+static const struct iio_enum quad8_index_polarity_enum = {
+	.items = quad8_index_polarity_modes,
+	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
+	.set = quad8_set_index_polarity,
+	.get = quad8_get_index_polarity
+};
+
+static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
+	{
+		.name = "preset",
+		.shared = IIO_SEPARATE,
+		.read = quad8_read_preset,
+		.write = quad8_write_preset
+	},
+	{
+		.name = "set_to_preset_on_index",
+		.shared = IIO_SEPARATE,
+		.read = quad8_read_set_to_preset_on_index,
+		.write = quad8_write_set_to_preset_on_index
+	},
+	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
+	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
+	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
+	IIO_ENUM_AVAILABLE("count_direction", &quad8_count_direction_enum),
+	IIO_ENUM("count_mode", IIO_SEPARATE, &quad8_count_mode_enum),
+	IIO_ENUM_AVAILABLE("count_mode", &quad8_count_mode_enum),
+	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &quad8_quadrature_mode_enum),
+	IIO_ENUM_AVAILABLE("quadrature_mode", &quad8_quadrature_mode_enum),
+	{}
+};
+
+static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
+	IIO_ENUM("synchronous_mode", IIO_SEPARATE,
+		&quad8_synchronous_mode_enum),
+	IIO_ENUM_AVAILABLE("synchronous_mode", &quad8_synchronous_mode_enum),
+	IIO_ENUM("index_polarity", IIO_SEPARATE, &quad8_index_polarity_enum),
+	IIO_ENUM_AVAILABLE("index_polarity", &quad8_index_polarity_enum),
+	{}
+};
+
+#define QUAD8_COUNT_CHAN(_chan) {					\
+	.type = IIO_COUNT,						\
+	.channel = (_chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = quad8_count_ext_info,				\
+	.indexed = 1							\
+}
+
+#define QUAD8_INDEX_CHAN(_chan) {			\
+	.type = IIO_INDEX,				\
+	.channel = (_chan),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.ext_info = quad8_index_ext_info,		\
+	.indexed = 1					\
+}
+
+static const struct iio_chan_spec quad8_channels[] = {
+	QUAD8_COUNT_CHAN(0), QUAD8_INDEX_CHAN(0),
+	QUAD8_COUNT_CHAN(1), QUAD8_INDEX_CHAN(1),
+	QUAD8_COUNT_CHAN(2), QUAD8_INDEX_CHAN(2),
+	QUAD8_COUNT_CHAN(3), QUAD8_INDEX_CHAN(3),
+	QUAD8_COUNT_CHAN(4), QUAD8_INDEX_CHAN(4),
+	QUAD8_COUNT_CHAN(5), QUAD8_INDEX_CHAN(5),
+	QUAD8_COUNT_CHAN(6), QUAD8_INDEX_CHAN(6),
+	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
+};
+
+static int quad8_signal_read(struct counter_device *counter,
+	struct counter_signal *signal, struct signal_read_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int state;
+	enum signal_level level;
+
+	/* Only Index signal levels can be read */
+	if (signal->id < 16)
+		return -EINVAL;
+
+	state = inb(priv->base + 0x16) & BIT(signal->id - 16);
+
+	level = (state) ? SIGNAL_LEVEL_HIGH : SIGNAL_LEVEL_LOW;
+
+	set_signal_read_value(val, SIGNAL_LEVEL, &level);
+
+	return 0;
+}
+
+static int quad8_count_read(struct counter_device *counter,
+	struct counter_count *count, struct count_read_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int flags;
+	unsigned int borrow;
+	unsigned int carry;
+	unsigned long position;
+	int i;
+
+	flags = inb(base_offset + 1);
+	borrow = flags & BIT(0);
+	carry = !!(flags & BIT(1));
+
+	/* Borrow XOR Carry effectively doubles count range */
+	position = (unsigned long)(borrow ^ carry) << 24;
+
+	/* Reset Byte Pointer; transfer Counter to Output Latch */
+	outb(0x11, base_offset + 1);
+
+	for (i = 0; i < 3; i++)
+		position |= (unsigned long)inb(base_offset) << (8 * i);
+
+	set_count_read_value(val, COUNT_POSITION_UNSIGNED, &position);
+
+	return 0;
+}
+
+static int quad8_count_write(struct counter_device *counter,
+	struct counter_count *count, struct count_write_value *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	int err;
+	unsigned long position;
+	int i;
+
+	err = get_count_write_value(&position, COUNT_POSITION_UNSIGNED, val);
+	if (err)
+		return err;
+
+	/* Only 24-bit values are supported */
+	if (position > 0xFFFFFF)
+		return -EINVAL;
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Counter can only be set via Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(position >> (8 * i), base_offset);
+
+	/* Transfer Preset Register to Counter */
+	outb(0x08, base_offset + 1);
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Set Preset Register back to original value */
+	position = priv->preset[count->id];
+	for (i = 0; i < 3; i++)
+		outb(position >> (8 * i), base_offset);
+
+	/* Reset Borrow, Carry, Compare, and Sign flags */
+	outb(0x02, base_offset + 1);
+	/* Reset Error flag */
+	outb(0x06, base_offset + 1);
+
+	return 0;
+}
+
+enum quad8_count_function {
+	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
+	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static enum count_function quad8_count_functions_list[] = {
+	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNT_FUNCTION_PULSE_DIRECTION,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNT_FUNCTION_QUADRATURE_X1_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNT_FUNCTION_QUADRATURE_X2_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static int quad8_function_get(struct counter_device *counter,
+	struct counter_count *count, size_t *function)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	const unsigned int quadrature_mode = priv->quadrature_mode[id];
+	const unsigned int scale = priv->quadrature_scale[id];
+
+	if (quadrature_mode)
+		switch (scale) {
+		case 0:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
+			break;
+		case 1:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
+			break;
+		case 2:
+			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
+			break;
+		}
+	else
+		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
+
+	return 0;
+}
+
+static int quad8_function_set(struct counter_device *counter,
+	struct counter_count *count, size_t function)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
+	unsigned int *const scale = priv->quadrature_scale + id;
+	unsigned int mode_cfg = priv->count_mode[id] << 1;
+	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
+	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
+	const int base_offset = priv->base + 2 * id + 1;
+
+	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
+		*quadrature_mode = 0;
+
+		/* Quadrature scaling only available in quadrature mode */
+		*scale = 0;
+
+		/* Synchronous function not supported in non-quadrature mode */
+		if (*synchronous_mode) {
+			*synchronous_mode = 0;
+			/* Disable synchronous function mode */
+			outb(0x60 | idr_cfg, base_offset);
+		}
+	} else {
+		*quadrature_mode = 1;
+
+		switch (function) {
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+			*scale = 0;
+			mode_cfg |= 0x8;
+			break;
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+			*scale = 1;
+			mode_cfg |= 0x10;
+			break;
+		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+			*scale = 2;
+			mode_cfg |= 0x18;
+			break;
+		}
+	}
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static void quad8_direction_get(struct counter_device *counter,
+	struct counter_count *count, enum count_direction *direction)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int ud_flag;
+	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
+
+	/* U/D flag: nonzero = up, zero = down */
+	ud_flag = inb(flag_addr) & BIT(5);
+
+	*direction = (ud_flag) ? COUNT_DIRECTION_FORWARD :
+		COUNT_DIRECTION_BACKWARD;
+}
+
+enum quad8_synapse_action {
+	QUAD8_SYNAPSE_ACTION_NONE = 0,
+	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
+	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
+	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static enum synapse_action quad8_index_actions_list[] = {
+	[QUAD8_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
+	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE
+};
+
+static enum synapse_action quad8_synapse_actions_list[] = {
+	[QUAD8_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
+	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE,
+	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = SYNAPSE_ACTION_FALLING_EDGE,
+	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static int quad8_action_get(struct counter_device *counter,
+	struct counter_count *count, struct counter_synapse *synapse,
+	size_t *action)
+{
+	struct quad8_iio *const priv = counter->priv;
+	int err;
+	size_t function = 0;
+	const size_t signal_a_id = count->synapses[0].signal->id;
+	enum count_direction direction;
+
+	/* Handle Index signals */
+	if (synapse->signal->id >= 16) {
+		if (priv->preset_enable[count->id])
+			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+		else
+			*action = QUAD8_SYNAPSE_ACTION_NONE;
+
+		return 0;
+	}
+
+	err = quad8_function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	/* Default action mode */
+	*action = QUAD8_SYNAPSE_ACTION_NONE;
+
+	/* Determine action mode based on current count function mode */
+	switch (function) {
+	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
+		if (synapse->signal->id == signal_a_id)
+			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+		if (synapse->signal->id == signal_a_id) {
+			quad8_direction_get(counter, count, &direction);
+
+			if (direction == COUNT_DIRECTION_FORWARD)
+				*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+			else
+				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
+		}
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+		if (synapse->signal->id == signal_a_id)
+			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	}
+
+	return 0;
+}
+
+const struct counter_ops quad8_ops = {
+	.signal_read = quad8_signal_read,
+	.count_read = quad8_count_read,
+	.count_write = quad8_count_write,
+	.function_get = quad8_function_get,
+	.function_set = quad8_function_set,
+	.action_get = quad8_action_get
+};
+
+static int quad8_index_polarity_get(struct counter_device *counter,
+	struct counter_signal *signal, size_t *index_polarity)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+
+	*index_polarity = priv->index_polarity[channel_id];
+
+	return 0;
+}
+
+static int quad8_index_polarity_set(struct counter_device *counter,
+	struct counter_signal *signal, size_t index_polarity)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+	const unsigned int idr_cfg = priv->synchronous_mode[channel_id] |
+		index_polarity << 1;
+	const int base_offset = priv->base + 2 * channel_id + 1;
+
+	priv->index_polarity[channel_id] = index_polarity;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x60 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_signal_enum_ext quad8_index_pol_enum = {
+	.items = quad8_index_polarity_modes,
+	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
+	.get = quad8_index_polarity_get,
+	.set = quad8_index_polarity_set
+};
+
+static int quad8_synchronous_mode_get(struct counter_device *counter,
+	struct counter_signal *signal, size_t *synchronous_mode)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+
+	*synchronous_mode = priv->synchronous_mode[channel_id];
+
+	return 0;
+}
+
+static int quad8_synchronous_mode_set(struct counter_device *counter,
+	struct counter_signal *signal, size_t synchronous_mode)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id - 16;
+	const unsigned int idr_cfg = synchronous_mode |
+		priv->index_polarity[channel_id] << 1;
+	const int base_offset = priv->base + 2 * channel_id + 1;
+
+	/* Index function must be non-synchronous in non-quadrature mode */
+	if (synchronous_mode && !priv->quadrature_mode[channel_id])
+		return -EINVAL;
+
+	priv->synchronous_mode[channel_id] = synchronous_mode;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x60 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_signal_enum_ext quad8_syn_mode_enum = {
+	.items = quad8_synchronous_modes,
+	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
+	.get = quad8_synchronous_mode_get,
+	.set = quad8_synchronous_mode_set
+};
+
+static ssize_t quad8_count_floor_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	/* Only a floor of 0 is supported */
+	return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
+static int quad8_count_mode_get(struct counter_device *counter,
+	struct counter_count *count, size_t *cnt_mode)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
+	switch (priv->count_mode[count->id]) {
+	case 0:
+		*cnt_mode = COUNT_MODE_NORMAL;
+		break;
+	case 1:
+		*cnt_mode = COUNT_MODE_RANGE_LIMIT;
+		break;
+	case 2:
+		*cnt_mode = COUNT_MODE_NON_RECYCLE;
+		break;
+	case 3:
+		*cnt_mode = COUNT_MODE_MODULO_N;
+		break;
+	}
+
+	return 0;
+}
+
+static int quad8_count_mode_set(struct counter_device *counter,
+	struct counter_count *count, size_t cnt_mode)
+{
+	struct quad8_iio *const priv = counter->priv;
+	unsigned int mode_cfg;
+	const int base_offset = priv->base + 2 * count->id + 1;
+
+	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
+	switch (cnt_mode) {
+	case COUNT_MODE_NORMAL:
+		cnt_mode = 0;
+		break;
+	case COUNT_MODE_RANGE_LIMIT:
+		cnt_mode = 1;
+		break;
+	case COUNT_MODE_NON_RECYCLE:
+		cnt_mode = 2;
+		break;
+	case COUNT_MODE_MODULO_N:
+		cnt_mode = 3;
+		break;
+	}
+
+	priv->count_mode[count->id] = cnt_mode;
+
+	/* Set count mode configuration value */
+	mode_cfg = cnt_mode << 1;
+
+	/* Add quadrature mode configuration */
+	if (priv->quadrature_mode[count->id])
+		mode_cfg |= (priv->quadrature_scale[count->id] + 1) << 3;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static struct counter_count_enum_ext quad8_cnt_mode_enum = {
+	.items = count_mode_str,
+	.num_items = ARRAY_SIZE(count_mode_str),
+	.get = quad8_count_mode_get,
+	.set = quad8_count_mode_set
+};
+
+static ssize_t quad8_count_direction_read(struct counter_device *counter,
+	struct counter_count *count, void *priv, char *buf)
+{
+	enum count_direction dir;
+
+	quad8_direction_get(counter, count, &dir);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", count_direction_str[dir]);
+}
+
+static ssize_t quad8_count_enable_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", priv->ab_enable[count->id]);
+}
+
+static ssize_t quad8_count_enable_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	int err;
+	bool ab_enable;
+	unsigned int ior_cfg;
+
+	err = kstrtobool(buf, &ab_enable);
+	if (err)
+		return err;
+
+	priv->ab_enable[count->id] = ab_enable;
+
+	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
+
+	/* Load I/O control configuration */
+	outb(0x40 | ior_cfg, base_offset + 1);
+
+	return len;
+}
+
+static int quad8_error_noise_get(struct counter_device *counter,
+	struct counter_count *count, size_t *noise_error)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id + 1;
+
+	*noise_error = !!(inb(base_offset) & BIT(4));
+
+	return 0;
+}
+
+static struct counter_count_enum_ext quad8_error_noise_enum = {
+	.items = quad8_noise_error_states,
+	.num_items = ARRAY_SIZE(quad8_noise_error_states),
+	.get = quad8_error_noise_get
+};
+
+static ssize_t quad8_count_preset_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset[count->id]);
+}
+
+static ssize_t quad8_count_preset_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int preset;
+	int ret;
+	int i;
+
+	ret = kstrtouint(buf, 0, &preset);
+	if (ret)
+		return ret;
+
+	/* Only 24-bit values are supported */
+	if (preset > 0xFFFFFF)
+		return -EINVAL;
+
+	priv->preset[count->id] = preset;
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Set Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(preset >> (8 * i), base_offset);
+
+	return len;
+}
+
+static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	/* Range Limit and Modulo-N count modes use preset value as ceiling */
+	switch (priv->count_mode[count->id]) {
+	case 1:
+	case 3:
+		return quad8_count_preset_read(counter, count, private, buf);
+	}
+
+	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
+	return snprintf(buf, PAGE_SIZE, "33554431\n");
+}
+
+static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+
+	/* Range Limit and Modulo-N count modes use preset value as ceiling */
+	switch (priv->count_mode[count->id]) {
+	case 1:
+	case 3:
+		return quad8_count_preset_write(counter, count, private, buf,
+						len);
+	}
+
+	return len;
+}
+
+static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
+	struct counter_count *count, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+		!priv->preset_enable[count->id]);
+}
+
+static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
+	struct counter_count *count, void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id + 1;
+	bool preset_enable;
+	int ret;
+	unsigned int ior_cfg;
+
+	ret = kstrtobool(buf, &preset_enable);
+	if (ret)
+		return ret;
+
+	/* Preset enable is active low in Input/Output Control register */
+	preset_enable = !preset_enable;
+
+	priv->preset_enable[count->id] = preset_enable;
+
+	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(0x40 | ior_cfg, base_offset);
+
+	return len;
+}
+
+static const struct counter_signal_ext quad8_index_ext[] = {
+	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
+	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
+	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
+	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
+};
+
+#define	QUAD8_QUAD_SIGNAL(_id, _name) {	\
+	.id = (_id),			\
+	.name = (_name)			\
+}
+
+#define	QUAD8_INDEX_SIGNAL(_id, _name) {	\
+	.id = (_id),				\
+	.name = (_name),			\
+	.ext = quad8_index_ext,			\
+	.num_ext = ARRAY_SIZE(quad8_index_ext)	\
+}
+
+static struct counter_signal quad8_signals[] = {
+	QUAD8_QUAD_SIGNAL(0, "Channel 1 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(1, "Channel 1 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(2, "Channel 2 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(3, "Channel 2 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(4, "Channel 3 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(5, "Channel 3 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(6, "Channel 4 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(7, "Channel 4 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(8, "Channel 5 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(9, "Channel 5 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(10, "Channel 6 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(11, "Channel 6 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(12, "Channel 7 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(13, "Channel 7 Quadrature B"),
+	QUAD8_QUAD_SIGNAL(14, "Channel 8 Quadrature A"),
+	QUAD8_QUAD_SIGNAL(15, "Channel 8 Quadrature B"),
+	QUAD8_INDEX_SIGNAL(16, "Channel 1 Index"),
+	QUAD8_INDEX_SIGNAL(17, "Channel 2 Index"),
+	QUAD8_INDEX_SIGNAL(18, "Channel 3 Index"),
+	QUAD8_INDEX_SIGNAL(19, "Channel 4 Index"),
+	QUAD8_INDEX_SIGNAL(20, "Channel 5 Index"),
+	QUAD8_INDEX_SIGNAL(21, "Channel 6 Index"),
+	QUAD8_INDEX_SIGNAL(22, "Channel 7 Index"),
+	QUAD8_INDEX_SIGNAL(23, "Channel 8 Index")
+};
+
+#define QUAD8_COUNT_SYNAPSES(_id) {					\
+	{								\
+		.actions_list = quad8_synapse_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
+		.signal = quad8_signals + 2 * (_id)			\
+	},								\
+	{								\
+		.actions_list = quad8_synapse_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
+		.signal = quad8_signals + 2 * (_id) + 1			\
+	},								\
+	{								\
+		.actions_list = quad8_index_actions_list,		\
+		.num_actions = ARRAY_SIZE(quad8_index_actions_list),	\
+		.signal = quad8_signals + 2 * (_id) + 16		\
+	}								\
+}
+
+static struct counter_synapse quad8_count_synapses[][3] = {
+	QUAD8_COUNT_SYNAPSES(0), QUAD8_COUNT_SYNAPSES(1),
+	QUAD8_COUNT_SYNAPSES(2), QUAD8_COUNT_SYNAPSES(3),
+	QUAD8_COUNT_SYNAPSES(4), QUAD8_COUNT_SYNAPSES(5),
+	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
+};
+
+static const struct counter_count_ext quad8_count_ext[] = {
+	{
+		.name = "ceiling",
+		.read = quad8_count_ceiling_read,
+		.write = quad8_count_ceiling_write
+	},
+	{
+		.name = "floor",
+		.read = quad8_count_floor_read
+	},
+	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
+	{
+		.name = "direction",
+		.read = quad8_count_direction_read
+	},
+	{
+		.name = "enable",
+		.read = quad8_count_enable_read,
+		.write = quad8_count_enable_write
+	},
+	COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_enum),
+	{
+		.name = "preset",
+		.read = quad8_count_preset_read,
+		.write = quad8_count_preset_write
+	},
+	{
+		.name = "preset_enable",
+		.read = quad8_count_preset_enable_read,
+		.write = quad8_count_preset_enable_write
+	}
+};
+
+#define QUAD8_COUNT(_id, _cntname) {					\
+	.id = (_id),							\
+	.name = (_cntname),						\
+	.functions_list = quad8_count_functions_list,			\
+	.num_functions = ARRAY_SIZE(quad8_count_functions_list),	\
+	.synapses = quad8_count_synapses[(_id)],			\
+	.num_synapses =	2,						\
+	.ext = quad8_count_ext,						\
+	.num_ext = ARRAY_SIZE(quad8_count_ext)				\
+}
+
+static struct counter_count quad8_counts[] = {
+	QUAD8_COUNT(0, "Channel 1 Count"),
+	QUAD8_COUNT(1, "Channel 2 Count"),
+	QUAD8_COUNT(2, "Channel 3 Count"),
+	QUAD8_COUNT(3, "Channel 4 Count"),
+	QUAD8_COUNT(4, "Channel 5 Count"),
+	QUAD8_COUNT(5, "Channel 6 Count"),
+	QUAD8_COUNT(6, "Channel 7 Count"),
+	QUAD8_COUNT(7, "Channel 8 Count")
+};
+
+static int quad8_probe(struct device *dev, unsigned int id)
+{
+	struct iio_dev *indio_dev;
+	struct quad8_iio *quad8iio;
+	int i, j;
+	unsigned int base_offset;
+	int err;
+
+	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			base[id], base[id] + QUAD8_EXTENT);
+		return -EBUSY;
+	}
+
+	/* Allocate IIO device; this also allocates driver data structure */
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* Initialize IIO device */
+	indio_dev->info = &quad8_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
+	indio_dev->channels = quad8_channels;
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+
+	/* Initialize Counter device and driver data */
+	quad8iio = iio_priv(indio_dev);
+	quad8iio->counter.name = dev_name(dev);
+	quad8iio->counter.parent = dev;
+	quad8iio->counter.ops = &quad8_ops;
+	quad8iio->counter.counts = quad8_counts;
+	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
+	quad8iio->counter.signals = quad8_signals;
+	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
+	quad8iio->counter.priv = quad8iio;
+	quad8iio->base = base[id];
+
+	/* Reset all counters and disable interrupt function */
+	outb(0x01, base[id] + 0x11);
+	/* Set initial configuration for all counters */
+	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
+		base_offset = base[id] + 2 * i;
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+		/* Reset Preset Register */
+		for (j = 0; j < 3; j++)
+			outb(0x00, base_offset);
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x04, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+		/* Binary encoding; Normal count; non-quadrature mode */
+		outb(0x20, base_offset + 1);
+		/* Disable A and B inputs; preset on index; FLG1 as Carry */
+		outb(0x40, base_offset + 1);
+		/* Disable index function; negative index polarity */
+		outb(0x60, base_offset + 1);
+	}
+	/* Enable all counters */
+	outb(0x00, base[id] + 0x11);
+
+	/* Register IIO device */
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err)
+		return err;
+
+	/* Register Counter device */
+	return devm_counter_register(dev, &quad8iio->counter);
+}
+
+static struct isa_driver quad8_driver = {
+	.probe = quad8_probe,
+	.driver = {
+		.name = "104-quad-8"
+	}
+};
+
+module_isa_driver(quad8_driver, num_quad8);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 65fa92abd5a4..73f03372484f 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -16,3 +16,24 @@ menuconfig COUNTER
 	  consumption. The Generic Counter interface enables drivers to support
 	  and expose a common set of components and functionality present in
 	  counter devices.
+
+if COUNTER
+
+config 104_QUAD_8
+	tristate "ACCES 104-QUAD-8 driver"
+	depends on PC104 && X86 && IIO
+	select ISA_BUS_API
+	help
+	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
+	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
+
+	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
+	  also clears the counter's respective error flag. Although the counters
+	  have a 25-bit range, only the lower 24 bits may be set, either directly
+	  or via a counter's preset attribute. Interrupts are not supported by
+	  this driver.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
+endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index ad1ba7109cdc..23a4f6263e45 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,3 +6,5 @@
 
 obj-$(CONFIG_COUNTER) += counter.o
 counter-y := generic-counter.o
+
+obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
deleted file mode 100644
index b56985078d8c..000000000000
--- a/drivers/iio/counter/104-quad-8.c
+++ /dev/null
@@ -1,596 +0,0 @@
-/*
- * IIO driver for the ACCES 104-QUAD-8
- * Copyright (C) 2016 William Breathitt Gray
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
- */
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/isa.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-
-#define QUAD8_EXTENT 32
-
-static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
-static unsigned int num_quad8;
-module_param_array(base, uint, &num_quad8, 0);
-MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
-
-#define QUAD8_NUM_COUNTERS 8
-
-/**
- * struct quad8_iio - IIO device private data structure
- * @preset:		array of preset values
- * @count_mode:		array of count mode configurations
- * @quadrature_mode:	array of quadrature mode configurations
- * @quadrature_scale:	array of quadrature mode scale configurations
- * @ab_enable:		array of A and B inputs enable configurations
- * @preset_enable:	array of set_to_preset_on_index attribute configurations
- * @synchronous_mode:	array of index function synchronous mode configurations
- * @index_polarity:	array of index function polarity configurations
- * @base:		base port address of the IIO device
- */
-struct quad8_iio {
-	unsigned int preset[QUAD8_NUM_COUNTERS];
-	unsigned int count_mode[QUAD8_NUM_COUNTERS];
-	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
-	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
-	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
-	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
-	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
-	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
-	unsigned int base;
-};
-
-static int quad8_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
-	int i;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_INDEX) {
-			*val = !!(inb(priv->base + 0x16) & BIT(chan->channel));
-			return IIO_VAL_INT;
-		}
-
-		flags = inb(base_offset + 1);
-		borrow = flags & BIT(0);
-		carry = !!(flags & BIT(1));
-
-		/* Borrow XOR Carry effectively doubles count range */
-		*val = (borrow ^ carry) << 24;
-
-		/* Reset Byte Pointer; transfer Counter to Output Latch */
-		outb(0x11, base_offset + 1);
-
-		for (i = 0; i < 3; i++)
-			*val |= (unsigned int)inb(base_offset) << (8 * i);
-
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_ENABLE:
-		*val = priv->ab_enable[chan->channel];
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = 1;
-		*val2 = priv->quadrature_scale[chan->channel];
-		return IIO_VAL_FRACTIONAL_LOG2;
-	}
-
-	return -EINVAL;
-}
-
-static int quad8_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long mask)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	int i;
-	unsigned int ior_cfg;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_INDEX)
-			return -EINVAL;
-
-		/* Only 24-bit values are supported */
-		if ((unsigned int)val > 0xFFFFFF)
-			return -EINVAL;
-
-		/* Reset Byte Pointer */
-		outb(0x01, base_offset + 1);
-
-		/* Counter can only be set via Preset Register */
-		for (i = 0; i < 3; i++)
-			outb(val >> (8 * i), base_offset);
-
-		/* Transfer Preset Register to Counter */
-		outb(0x08, base_offset + 1);
-
-		/* Reset Byte Pointer */
-		outb(0x01, base_offset + 1);
-
-		/* Set Preset Register back to original value */
-		val = priv->preset[chan->channel];
-		for (i = 0; i < 3; i++)
-			outb(val >> (8 * i), base_offset);
-
-		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(0x02, base_offset + 1);
-		/* Reset Error flag */
-		outb(0x06, base_offset + 1);
-
-		return 0;
-	case IIO_CHAN_INFO_ENABLE:
-		/* only boolean values accepted */
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		priv->ab_enable[chan->channel] = val;
-
-		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
-
-		/* Load I/O control configuration */
-		outb(0x40 | ior_cfg, base_offset + 1);
-
-		return 0;
-	case IIO_CHAN_INFO_SCALE:
-		/* Quadrature scaling only available in quadrature mode */
-		if (!priv->quadrature_mode[chan->channel] && (val2 || val != 1))
-			return -EINVAL;
-
-		/* Only three gain states (1, 0.5, 0.25) */
-		if (val == 1 && !val2)
-			priv->quadrature_scale[chan->channel] = 0;
-		else if (!val)
-			switch (val2) {
-			case 500000:
-				priv->quadrature_scale[chan->channel] = 1;
-				break;
-			case 250000:
-				priv->quadrature_scale[chan->channel] = 2;
-				break;
-			default:
-				return -EINVAL;
-			}
-		else
-			return -EINVAL;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info quad8_info = {
-	.read_raw = quad8_read_raw,
-	.write_raw = quad8_write_raw
-};
-
-static ssize_t quad8_read_preset(struct iio_dev *indio_dev, uintptr_t private,
-	const struct iio_chan_spec *chan, char *buf)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset[chan->channel]);
-}
-
-static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
-	const struct iio_chan_spec *chan, const char *buf, size_t len)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int preset;
-	int ret;
-	int i;
-
-	ret = kstrtouint(buf, 0, &preset);
-	if (ret)
-		return ret;
-
-	/* Only 24-bit values are supported */
-	if (preset > 0xFFFFFF)
-		return -EINVAL;
-
-	priv->preset[chan->channel] = preset;
-
-	/* Reset Byte Pointer */
-	outb(0x01, base_offset + 1);
-
-	/* Set Preset Register */
-	for (i = 0; i < 3; i++)
-		outb(preset >> (8 * i), base_offset);
-
-	return len;
-}
-
-static ssize_t quad8_read_set_to_preset_on_index(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		!priv->preset_enable[chan->channel]);
-}
-
-static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	size_t len)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-	bool preset_enable;
-	int ret;
-	unsigned int ior_cfg;
-
-	ret = kstrtobool(buf, &preset_enable);
-	if (ret)
-		return ret;
-
-	/* Preset enable is active low in Input/Output Control register */
-	preset_enable = !preset_enable;
-
-	priv->preset_enable[chan->channel] = preset_enable;
-
-	ior_cfg = priv->ab_enable[chan->channel] |
-		(unsigned int)preset_enable << 1;
-
-	/* Load I/O control configuration to Input / Output Control Register */
-	outb(0x40 | ior_cfg, base_offset);
-
-	return len;
-}
-
-static const char *const quad8_noise_error_states[] = {
-	"No excessive noise is present at the count inputs",
-	"Excessive noise is present at the count inputs"
-};
-
-static int quad8_get_noise_error(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	return !!(inb(base_offset) & BIT(4));
-}
-
-static const struct iio_enum quad8_noise_error_enum = {
-	.items = quad8_noise_error_states,
-	.num_items = ARRAY_SIZE(quad8_noise_error_states),
-	.get = quad8_get_noise_error
-};
-
-static const char *const quad8_count_direction_states[] = {
-	"down",
-	"up"
-};
-
-static int quad8_get_count_direction(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	return !!(inb(base_offset) & BIT(5));
-}
-
-static const struct iio_enum quad8_count_direction_enum = {
-	.items = quad8_count_direction_states,
-	.num_items = ARRAY_SIZE(quad8_count_direction_states),
-	.get = quad8_get_count_direction
-};
-
-static const char *const quad8_count_modes[] = {
-	"normal",
-	"range limit",
-	"non-recycle",
-	"modulo-n"
-};
-
-static int quad8_set_count_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int count_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	unsigned int mode_cfg = count_mode << 1;
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	priv->count_mode[chan->channel] = count_mode;
-
-	/* Add quadrature mode configuration */
-	if (priv->quadrature_mode[chan->channel])
-		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
-
-	/* Load mode configuration to Counter Mode Register */
-	outb(0x20 | mode_cfg, base_offset);
-
-	return 0;
-}
-
-static int quad8_get_count_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->count_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_count_mode_enum = {
-	.items = quad8_count_modes,
-	.num_items = ARRAY_SIZE(quad8_count_modes),
-	.set = quad8_set_count_mode,
-	.get = quad8_get_count_mode
-};
-
-static const char *const quad8_synchronous_modes[] = {
-	"non-synchronous",
-	"synchronous"
-};
-
-static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const unsigned int idr_cfg = synchronous_mode |
-		priv->index_polarity[chan->channel] << 1;
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	/* Index function must be non-synchronous in non-quadrature mode */
-	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
-		return -EINVAL;
-
-	priv->synchronous_mode[chan->channel] = synchronous_mode;
-
-	/* Load Index Control configuration to Index Control Register */
-	outb(0x60 | idr_cfg, base_offset);
-
-	return 0;
-}
-
-static int quad8_get_synchronous_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->synchronous_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_synchronous_mode_enum = {
-	.items = quad8_synchronous_modes,
-	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
-	.set = quad8_set_synchronous_mode,
-	.get = quad8_get_synchronous_mode
-};
-
-static const char *const quad8_quadrature_modes[] = {
-	"non-quadrature",
-	"quadrature"
-};
-
-static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	unsigned int mode_cfg = priv->count_mode[chan->channel] << 1;
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	if (quadrature_mode)
-		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
-	else {
-		/* Quadrature scaling only available in quadrature mode */
-		priv->quadrature_scale[chan->channel] = 0;
-
-		/* Synchronous function not supported in non-quadrature mode */
-		if (priv->synchronous_mode[chan->channel])
-			quad8_set_synchronous_mode(indio_dev, chan, 0);
-	}
-
-	priv->quadrature_mode[chan->channel] = quadrature_mode;
-
-	/* Load mode configuration to Counter Mode Register */
-	outb(0x20 | mode_cfg, base_offset);
-
-	return 0;
-}
-
-static int quad8_get_quadrature_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->quadrature_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_quadrature_mode_enum = {
-	.items = quad8_quadrature_modes,
-	.num_items = ARRAY_SIZE(quad8_quadrature_modes),
-	.set = quad8_set_quadrature_mode,
-	.get = quad8_get_quadrature_mode
-};
-
-static const char *const quad8_index_polarity_modes[] = {
-	"negative",
-	"positive"
-};
-
-static int quad8_set_index_polarity(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int index_polarity)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const unsigned int idr_cfg = priv->synchronous_mode[chan->channel] |
-		index_polarity << 1;
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	priv->index_polarity[chan->channel] = index_polarity;
-
-	/* Load Index Control configuration to Index Control Register */
-	outb(0x60 | idr_cfg, base_offset);
-
-	return 0;
-}
-
-static int quad8_get_index_polarity(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->index_polarity[chan->channel];
-}
-
-static const struct iio_enum quad8_index_polarity_enum = {
-	.items = quad8_index_polarity_modes,
-	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
-	.set = quad8_set_index_polarity,
-	.get = quad8_get_index_polarity
-};
-
-static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = quad8_read_preset,
-		.write = quad8_write_preset
-	},
-	{
-		.name = "set_to_preset_on_index",
-		.shared = IIO_SEPARATE,
-		.read = quad8_read_set_to_preset_on_index,
-		.write = quad8_write_set_to_preset_on_index
-	},
-	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
-	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
-	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
-	IIO_ENUM_AVAILABLE("count_direction", &quad8_count_direction_enum),
-	IIO_ENUM("count_mode", IIO_SEPARATE, &quad8_count_mode_enum),
-	IIO_ENUM_AVAILABLE("count_mode", &quad8_count_mode_enum),
-	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &quad8_quadrature_mode_enum),
-	IIO_ENUM_AVAILABLE("quadrature_mode", &quad8_quadrature_mode_enum),
-	{}
-};
-
-static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
-	IIO_ENUM("synchronous_mode", IIO_SEPARATE,
-		&quad8_synchronous_mode_enum),
-	IIO_ENUM_AVAILABLE("synchronous_mode", &quad8_synchronous_mode_enum),
-	IIO_ENUM("index_polarity", IIO_SEPARATE, &quad8_index_polarity_enum),
-	IIO_ENUM_AVAILABLE("index_polarity", &quad8_index_polarity_enum),
-	{}
-};
-
-#define QUAD8_COUNT_CHAN(_chan) {					\
-	.type = IIO_COUNT,						\
-	.channel = (_chan),						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-		BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_SCALE),	\
-	.ext_info = quad8_count_ext_info,				\
-	.indexed = 1							\
-}
-
-#define QUAD8_INDEX_CHAN(_chan) {			\
-	.type = IIO_INDEX,				\
-	.channel = (_chan),				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.ext_info = quad8_index_ext_info,		\
-	.indexed = 1					\
-}
-
-static const struct iio_chan_spec quad8_channels[] = {
-	QUAD8_COUNT_CHAN(0), QUAD8_INDEX_CHAN(0),
-	QUAD8_COUNT_CHAN(1), QUAD8_INDEX_CHAN(1),
-	QUAD8_COUNT_CHAN(2), QUAD8_INDEX_CHAN(2),
-	QUAD8_COUNT_CHAN(3), QUAD8_INDEX_CHAN(3),
-	QUAD8_COUNT_CHAN(4), QUAD8_INDEX_CHAN(4),
-	QUAD8_COUNT_CHAN(5), QUAD8_INDEX_CHAN(5),
-	QUAD8_COUNT_CHAN(6), QUAD8_INDEX_CHAN(6),
-	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
-};
-
-static int quad8_probe(struct device *dev, unsigned int id)
-{
-	struct iio_dev *indio_dev;
-	struct quad8_iio *priv;
-	int i, j;
-	unsigned int base_offset;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
-		dev_name(dev))) {
-		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base[id], base[id] + QUAD8_EXTENT);
-		return -EBUSY;
-	}
-
-	indio_dev->info = &quad8_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
-	indio_dev->channels = quad8_channels;
-	indio_dev->name = dev_name(dev);
-	indio_dev->dev.parent = dev;
-
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
-
-	/* Reset all counters and disable interrupt function */
-	outb(0x01, base[id] + 0x11);
-	/* Set initial configuration for all counters */
-	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
-		base_offset = base[id] + 2 * i;
-		/* Reset Byte Pointer */
-		outb(0x01, base_offset + 1);
-		/* Reset Preset Register */
-		for (j = 0; j < 3; j++)
-			outb(0x00, base_offset);
-		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(0x04, base_offset + 1);
-		/* Reset Error flag */
-		outb(0x06, base_offset + 1);
-		/* Binary encoding; Normal count; non-quadrature mode */
-		outb(0x20, base_offset + 1);
-		/* Disable A and B inputs; preset on index; FLG1 as Carry */
-		outb(0x40, base_offset + 1);
-		/* Disable index function; negative index polarity */
-		outb(0x60, base_offset + 1);
-	}
-	/* Enable all counters */
-	outb(0x00, base[id] + 0x11);
-
-	return devm_iio_device_register(dev, indio_dev);
-}
-
-static struct isa_driver quad8_driver = {
-	.probe = quad8_probe,
-	.driver = {
-		.name = "104-quad-8"
-	}
-};
-
-module_isa_driver(quad8_driver, num_quad8);
-
-MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
-MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index bf1e559ad7cd..eeb358122cbe 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -5,23 +5,6 @@
 
 menu "Counters"
 
-config 104_QUAD_8
-	tristate "ACCES 104-QUAD-8 driver"
-	depends on PC104 && X86
-	select ISA_BUS_API
-	help
-	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
-	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
-
-	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
-	  also clears the counter's respective error flag. Although the counters
-	  have a 25-bit range, only the lower 24 bits may be set, either directly
-	  or via a counter's preset attribute. Interrupts are not supported by
-	  this driver.
-
-	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
-
 config STM32_LPTIMER_CNT
 	tristate "STM32 LP Timer encoder counter driver"
 	depends on MFD_STM32_LPTIMER || COMPILE_TEST
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 1b9a896eb488..93933ba49280 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -4,5 +4,4 @@
 
 # When adding new entries keep the list in alphabetical order
 
-obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
-- 
2.17.0
