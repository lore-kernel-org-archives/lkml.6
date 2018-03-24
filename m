Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCXROV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbeCXROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:14:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A7721770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:14:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] counter: 104-quad-8: Add Generic Counter
 interface support
Message-ID: <20180324171413.325fe469@archlinux>
In-Reply-To: <bb69bfe2733ab94a2273394bb3d9a0a28816deff.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <bb69bfe2733ab94a2273394bb3d9a0a28816deff.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:43:06 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds support for the Generic Counter interface to the
> 104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
> be affected by this patch; all changes are intended as supplemental
> additions as perceived by the user.
> 
> Generic Counter Counts are created for the eight quadrature channel
> counts, as well as their respective quadrature A and B Signals (which
> are associated via respective Synapse structures) and respective index
> Signals.
> 
> The new Generic Counter interface sysfs attributes are intended to
> expose the same functionality and data available via the existing
> 104-QUAD-8 IIO device interface; the Generic Counter interface serves
> to provide the respective functionality and data in a standard way
> expected of counter devices.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
We should definitely think about deprecating the existing IIO interface
as soon as we can (could be a few years though!)

One suggestion inline that you should add an ops structure for the
counter callback functions so you can take them static constant.
I missed that when reviewing the earlier patch.

Jonathan

> ---
>  MAINTAINERS                  |   4 +-
>  drivers/counter/104-quad-8.c | 685 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 677 insertions(+), 12 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a71dff6eae87..febe27a9962e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -266,12 +266,12 @@ L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-104-idio-16.c
>  
> -ACCES 104-QUAD-8 IIO DRIVER
> +ACCES 104-QUAD-8 DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> -F:	drivers/iio/counter/104-quad-8.c
> +F:	drivers/counter/104-quad-8.c
>  
>  ACCES PCI-IDIO-16 GPIO DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index b56985078d8c..5db314fcb08d 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * IIO driver for the ACCES 104-QUAD-8
>   * Copyright (C) 2016 William Breathitt Gray
> @@ -14,6 +15,7 @@
>   * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
>   */
>  #include <linux/bitops.h>
> +#include <linux/counter.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/iio/iio.h>
> @@ -37,6 +39,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
>  /**
>   * struct quad8_iio - IIO device private data structure
> + * @counter:		instance of the counter_device
>   * @preset:		array of preset values
>   * @count_mode:		array of count mode configurations
>   * @quadrature_mode:	array of quadrature mode configurations
> @@ -48,6 +51,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @base:		base port address of the IIO device
>   */
>  struct quad8_iio {
> +	struct counter_device counter;
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
>  	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
> @@ -527,24 +531,665 @@ static const struct iio_chan_spec quad8_channels[] = {
>  	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
>  };
>  
> +static int quad8_signal_read(struct counter_device *counter,
> +	struct counter_signal *signal, struct signal_read_value *val)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	unsigned int state;
> +	enum signal_level level;
> +
> +	/* Only Index signal levels can be read */
> +	if (signal->id < 16)
> +		return -EINVAL;
> +
> +	state = inb(priv->base + 0x16) & BIT(signal->id - 16);
> +
> +	level = (state) ? SIGNAL_LEVEL_HIGH : SIGNAL_LEVEL_LOW;
> +
> +	set_signal_read_value(val, SIGNAL_LEVEL, &level);
> +
> +	return 0;
> +}
> +
> +static int quad8_count_read(struct counter_device *counter,
> +	struct counter_count *count, struct count_read_value *val)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id;
> +	unsigned int flags;
> +	unsigned int borrow;
> +	unsigned int carry;
> +	unsigned long position;
> +	int i;
> +
> +	flags = inb(base_offset + 1);
> +	borrow = flags & BIT(0);
> +	carry = !!(flags & BIT(1));
> +
> +	/* Borrow XOR Carry effectively doubles count range */
> +	position = (unsigned long)(borrow ^ carry) << 24;
> +
> +	/* Reset Byte Pointer; transfer Counter to Output Latch */
> +	outb(0x11, base_offset + 1);
> +
> +	for (i = 0; i < 3; i++)
> +		position |= (unsigned long)inb(base_offset) << (8 * i);
> +
> +	set_count_read_value(val, COUNT_POSITION_UNSIGNED, &position);
> +
> +	return 0;
> +}
> +
> +static int quad8_count_write(struct counter_device *counter,
> +	struct counter_count *count, struct count_write_value *val)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id;
> +	int err;
> +	unsigned long position;
> +	int i;
> +
> +	err = get_count_write_value(&position, COUNT_POSITION_UNSIGNED, val);
> +	if (err)
> +		return err;
> +
> +	/* Only 24-bit values are supported */
> +	if (position > 0xFFFFFF)
> +		return -EINVAL;
> +
> +	/* Reset Byte Pointer */
> +	outb(0x01, base_offset + 1);
> +
> +	/* Counter can only be set via Preset Register */
> +	for (i = 0; i < 3; i++)
> +		outb(position >> (8 * i), base_offset);
> +
> +	/* Transfer Preset Register to Counter */
> +	outb(0x08, base_offset + 1);
> +
> +	/* Reset Byte Pointer */
> +	outb(0x01, base_offset + 1);
> +
> +	/* Set Preset Register back to original value */
> +	position = priv->preset[count->id];
> +	for (i = 0; i < 3; i++)
> +		outb(position >> (8 * i), base_offset);
> +
> +	/* Reset Borrow, Carry, Compare, and Sign flags */
> +	outb(0x02, base_offset + 1);
> +	/* Reset Error flag */
> +	outb(0x06, base_offset + 1);
> +
> +	return 0;
> +}
> +
> +enum quad8_count_function {
> +	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
> +	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
> +	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
> +	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
> +};
> +
> +static enum count_function quad8_count_functions_list[] = {
> +	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNT_FUNCTION_PULSE_DIRECTION,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNT_FUNCTION_QUADRATURE_X1,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNT_FUNCTION_QUADRATURE_X2,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNT_FUNCTION_QUADRATURE_X4
> +};
> +
> +static int quad8_function_get(struct counter_device *counter,
> +	struct counter_count *count, size_t *function)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const int id = count->id;
> +	const unsigned int quadrature_mode = priv->quadrature_mode[id];
> +	const unsigned int scale = priv->quadrature_scale[id];
> +
> +	if (quadrature_mode)
> +		switch (scale) {
> +		case 0:
> +			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> +			break;
> +		case 1:
> +			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
> +			break;
> +		case 2:
> +			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
> +			break;
> +		}
> +	else
> +		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> +
> +	return 0;
> +}
> +
> +static int quad8_function_set(struct counter_device *counter,
> +	struct counter_count *count, size_t function)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const int id = count->id;
> +	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
> +	unsigned int *const scale = priv->quadrature_scale + id;
> +	unsigned int mode_cfg = priv->count_mode[id] << 1;
> +	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
> +	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
> +	const int base_offset = priv->base + 2 * id + 1;
> +
> +	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> +		*quadrature_mode = 0;
> +
> +		/* Quadrature scaling only available in quadrature mode */
> +		*scale = 0;
> +
> +		/* Synchronous function not supported in non-quadrature mode */
> +		if (*synchronous_mode) {
> +			*synchronous_mode = 0;
> +			/* Disable synchronous function mode */
> +			outb(0x60 | idr_cfg, base_offset);
> +		}
> +	} else {
> +		*quadrature_mode = 1;
> +
> +		switch (function) {
> +		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +			*scale = 0;
> +			mode_cfg |= 0x8;
> +			break;
> +		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +			*scale = 1;
> +			mode_cfg |= 0x10;
> +			break;
> +		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> +			*scale = 2;
> +			mode_cfg |= 0x18;
> +			break;
> +		}
> +	}
> +
> +	/* Load mode configuration to Counter Mode Register */
> +	outb(0x20 | mode_cfg, base_offset);
> +
> +	return 0;
> +}
> +
> +enum count_direction {
> +	COUNT_DIRECTION_FORWARD = 0,
> +	COUNT_DIRECTION_BACKWARD
> +};
> +
> +static void quad8_direction_get(struct counter_device *counter,
> +	struct counter_count *count, enum count_direction *direction)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	unsigned int ud_flag;
> +	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
> +
> +	/* U/D flag: nonzero = up, zero = down */
> +	ud_flag = inb(flag_addr) & BIT(5);
> +
> +	*direction = (ud_flag) ? COUNT_DIRECTION_FORWARD :
> +		COUNT_DIRECTION_BACKWARD;
> +}
> +
> +enum quad8_synapse_action {
> +	QUAD8_SYNAPSE_ACTION_NONE = 0,
> +	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
> +	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
> +	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static enum synapse_action quad8_index_actions_list[] = {
> +	[QUAD8_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
> +	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE
> +};
> +
> +static enum synapse_action quad8_synapse_actions_list[] = {
> +	[QUAD8_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
> +	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE,
> +	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = SYNAPSE_ACTION_FALLING_EDGE,
> +	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static int quad8_action_get(struct counter_device *counter,
> +	struct counter_count *count, struct counter_synapse *synapse,
> +	size_t *action)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	int err;
> +	size_t function;
> +	const size_t signal_a_id = count->synapses[0].signal->id;
> +	enum count_direction direction;
> +
> +	/* Handle Index signals */
> +	if (synapse->signal->id >= 16) {
> +		if (priv->preset_enable[count->id])
> +			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +		else
> +			*action = QUAD8_SYNAPSE_ACTION_NONE;
> +
> +		return 0;
> +	}
> +
> +	err = counter->function_get(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	/* Default action mode */
> +	*action = QUAD8_SYNAPSE_ACTION_NONE;
> +
> +	/* Determine action mode based on current count function mode */
> +	switch (function) {
> +	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
> +		if (synapse->signal->id == signal_a_id)
> +			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +		break;
> +	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> +		if (synapse->signal->id == signal_a_id) {
> +			quad8_direction_get(counter, count, &direction);
> +
> +			if (direction == COUNT_DIRECTION_FORWARD)
> +				*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> +			else
> +				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
> +		}
> +		break;
> +	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> +		if (synapse->signal->id == signal_a_id)
> +			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> +		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int quad8_index_polarity_get(struct counter_device *counter,
> +	struct counter_signal *signal, size_t *index_polarity)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id - 16;
> +
> +	*index_polarity = priv->index_polarity[channel_id];
> +
> +	return 0;
> +}
> +
> +static int quad8_index_polarity_set(struct counter_device *counter,
> +	struct counter_signal *signal, size_t index_polarity)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id - 16;
> +	const unsigned int idr_cfg = priv->synchronous_mode[channel_id] |
> +		index_polarity << 1;
> +	const int base_offset = priv->base + 2 * channel_id + 1;
> +
> +	priv->index_polarity[channel_id] = index_polarity;
> +
> +	/* Load Index Control configuration to Index Control Register */
> +	outb(0x60 | idr_cfg, base_offset);
> +
> +	return 0;
> +}
> +
> +static struct counter_signal_enum_ext quad8_index_pol_enum = {
> +	.items = quad8_index_polarity_modes,
> +	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
> +	.get = quad8_index_polarity_get,
> +	.set = quad8_index_polarity_set
> +};
> +
> +static int quad8_synchronous_mode_get(struct counter_device *counter,
> +	struct counter_signal *signal, size_t *synchronous_mode)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id - 16;
> +
> +	*synchronous_mode = priv->synchronous_mode[channel_id];
> +
> +	return 0;
> +}
> +
> +static int quad8_synchronous_mode_set(struct counter_device *counter,
> +	struct counter_signal *signal, size_t synchronous_mode)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id - 16;
> +	const unsigned int idr_cfg = synchronous_mode |
> +		priv->index_polarity[channel_id] << 1;
> +	const int base_offset = priv->base + 2 * channel_id + 1;
> +
> +	/* Index function must be non-synchronous in non-quadrature mode */
> +	if (synchronous_mode && !priv->quadrature_mode[channel_id])
> +		return -EINVAL;
> +
> +	priv->synchronous_mode[channel_id] = synchronous_mode;
> +
> +	/* Load Index Control configuration to Index Control Register */
> +	outb(0x60 | idr_cfg, base_offset);
> +
> +	return 0;
> +}
> +
> +static struct counter_signal_enum_ext quad8_syn_mode_enum = {
> +	.items = quad8_synchronous_modes,
> +	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
> +	.get = quad8_synchronous_mode_get,
> +	.set = quad8_synchronous_mode_set
> +};
> +
> +static int quad8_count_mode_get(struct counter_device *counter,
> +	struct counter_count *count, size_t *count_mode)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +
> +	*count_mode = priv->count_mode[count->id];
> +
> +	return 0;
> +}
> +
> +static int quad8_count_mode_set(struct counter_device *counter,
> +	struct counter_count *count, size_t count_mode)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	unsigned int mode_cfg = count_mode << 1;
> +	const int base_offset = priv->base + 2 * count->id + 1;
> +
> +	priv->count_mode[count->id] = count_mode;
> +
> +	/* Add quadrature mode configuration */
> +	if (priv->quadrature_mode[count->id])
> +		mode_cfg |= (priv->quadrature_scale[count->id] + 1) << 3;
> +
> +	/* Load mode configuration to Counter Mode Register */
> +	outb(0x20 | mode_cfg, base_offset);
> +
> +	return 0;
> +}
> +
> +static struct counter_count_enum_ext quad8_cnt_mode_enum = {
> +	.items = quad8_count_modes,
> +	.num_items = ARRAY_SIZE(quad8_count_modes),
> +	.get = quad8_count_mode_get,
> +	.set = quad8_count_mode_set
> +};
> +
> +static const char *const quad8_count_direction_str[] = {
> +	[COUNT_DIRECTION_FORWARD] = "forward",
> +	[COUNT_DIRECTION_BACKWARD] = "backward"
> +};
> +
> +static ssize_t quad8_count_direction_read(struct counter_device *counter,
> +	struct counter_count *count, void *priv, char *buf)
> +{
> +	enum count_direction direction;
> +
> +	quad8_direction_get(counter, count, &direction);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +		quad8_count_direction_str[direction]);
> +}
> +
> +static ssize_t quad8_count_enable_read(struct counter_device *counter,
> +	struct counter_count *count, void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", priv->ab_enable[count->id]);
> +}
> +
> +static ssize_t quad8_count_enable_write(struct counter_device *counter,
> +	struct counter_count *count, void *private, const char *buf, size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id;
> +	int err;
> +	bool ab_enable;
> +	unsigned int ior_cfg;
> +
> +	err = kstrtobool(buf, &ab_enable);
> +	if (err)
> +		return err;
> +
> +	priv->ab_enable[count->id] = ab_enable;
> +
> +	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
> +
> +	/* Load I/O control configuration */
> +	outb(0x40 | ior_cfg, base_offset + 1);
> +
> +	return len;
> +}
> +
> +static int quad8_noise_error_get(struct counter_device *counter,
> +	struct counter_count *count, size_t *noise_error)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id + 1;
> +
> +	*noise_error = !!(inb(base_offset) & BIT(4));
> +
> +	return 0;
> +}
> +
> +static struct counter_count_enum_ext quad8_noise_err_enum = {
> +	.items = quad8_noise_error_states,
> +	.num_items = ARRAY_SIZE(quad8_noise_error_states),
> +	.get = quad8_noise_error_get
> +};
> +
> +static ssize_t quad8_count_preset_read(struct counter_device *counter,
> +	struct counter_count *count, void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset[count->id]);
> +}
> +
> +static ssize_t quad8_count_preset_write(struct counter_device *counter,
> +	struct counter_count *count, void *private, const char *buf, size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id;
> +	unsigned int preset;
> +	int ret;
> +	int i;
> +
> +	ret = kstrtouint(buf, 0, &preset);
> +	if (ret)
> +		return ret;
> +
> +	/* Only 24-bit values are supported */
> +	if (preset > 0xFFFFFF)
> +		return -EINVAL;
> +
> +	priv->preset[count->id] = preset;
> +
> +	/* Reset Byte Pointer */
> +	outb(0x01, base_offset + 1);
> +
> +	/* Set Preset Register */
> +	for (i = 0; i < 3; i++)
> +		outb(preset >> (8 * i), base_offset);
> +
> +	return len;
> +}
> +
> +static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
> +	struct counter_count *count, void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n",
> +		!priv->preset_enable[count->id]);
> +}
> +
> +static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
> +	struct counter_count *count, void *private, const char *buf, size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const int base_offset = priv->base + 2 * count->id + 1;
> +	bool preset_enable;
> +	int ret;
> +	unsigned int ior_cfg;
> +
> +	ret = kstrtobool(buf, &preset_enable);
> +	if (ret)
> +		return ret;
> +
> +	/* Preset enable is active low in Input/Output Control register */
> +	preset_enable = !preset_enable;
> +
> +	priv->preset_enable[count->id] = preset_enable;
> +
> +	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
> +
> +	/* Load I/O control configuration to Input / Output Control Register */
> +	outb(0x40 | ior_cfg, base_offset);
> +
> +	return len;
> +}
> +
> +static const struct counter_signal_ext quad8_index_ext[] = {
> +	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
> +	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
> +	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
> +	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
> +};
> +
> +#define	QUAD8_QUAD_SIGNAL(_id, _name) {	\
> +	.id = (_id),			\
> +	.name = (_name)			\
> +}
> +
> +#define	QUAD8_INDEX_SIGNAL(_id, _name) {	\
> +	.id = (_id),				\
> +	.name = (_name),			\
> +	.ext = quad8_index_ext,			\
> +	.num_ext = ARRAY_SIZE(quad8_index_ext)	\
> +}
> +
> +static struct counter_signal quad8_signals[] = {
> +	QUAD8_QUAD_SIGNAL(0, "Channel 1 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(1, "Channel 1 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(2, "Channel 2 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(3, "Channel 2 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(4, "Channel 3 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(5, "Channel 3 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(6, "Channel 4 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(7, "Channel 4 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(8, "Channel 5 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(9, "Channel 5 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(10, "Channel 6 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(11, "Channel 6 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(12, "Channel 7 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(13, "Channel 7 Quadrature B"),
> +	QUAD8_QUAD_SIGNAL(14, "Channel 8 Quadrature A"),
> +	QUAD8_QUAD_SIGNAL(15, "Channel 8 Quadrature B"),
> +	QUAD8_INDEX_SIGNAL(16, "Channel 1 Index"),
> +	QUAD8_INDEX_SIGNAL(17, "Channel 2 Index"),
> +	QUAD8_INDEX_SIGNAL(18, "Channel 3 Index"),
> +	QUAD8_INDEX_SIGNAL(19, "Channel 4 Index"),
> +	QUAD8_INDEX_SIGNAL(20, "Channel 5 Index"),
> +	QUAD8_INDEX_SIGNAL(21, "Channel 6 Index"),
> +	QUAD8_INDEX_SIGNAL(22, "Channel 7 Index"),
> +	QUAD8_INDEX_SIGNAL(23, "Channel 8 Index")
> +};
> +
> +#define QUAD8_COUNT_SYNAPSES(_id) {					\
> +	{								\
> +		.actions_list = quad8_synapse_actions_list,		\
> +		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
> +		.signal = quad8_signals + 2 * (_id)			\
> +	},								\
> +	{								\
> +		.actions_list = quad8_synapse_actions_list,		\
> +		.num_actions = ARRAY_SIZE(quad8_synapse_actions_list),	\
> +		.signal = quad8_signals + 2 * (_id) + 1			\
> +	},								\
> +	{								\
> +		.actions_list = quad8_index_actions_list,		\
> +		.num_actions = ARRAY_SIZE(quad8_index_actions_list),	\
> +		.signal = quad8_signals + 2 * (_id) + 16		\
> +	}								\
> +}
> +
> +static struct counter_synapse quad8_count_synapses[][3] = {
> +	QUAD8_COUNT_SYNAPSES(0), QUAD8_COUNT_SYNAPSES(1),
> +	QUAD8_COUNT_SYNAPSES(2), QUAD8_COUNT_SYNAPSES(3),
> +	QUAD8_COUNT_SYNAPSES(4), QUAD8_COUNT_SYNAPSES(5),
> +	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
> +};
> +
> +static const struct counter_count_ext quad8_count_ext[] = {
> +	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
> +	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
> +	{
> +		.name = "direction",
> +		.read = quad8_count_direction_read
> +	},
> +	{
> +		.name = "enable",
> +		.read = quad8_count_enable_read,
> +		.write = quad8_count_enable_write
> +	},
> +	COUNTER_COUNT_ENUM("noise_error", &quad8_noise_err_enum),
> +	COUNTER_COUNT_ENUM_AVAILABLE("noise_error", &quad8_noise_err_enum),
> +	{
> +		.name = "preset",
> +		.read = quad8_count_preset_read,
> +		.write = quad8_count_preset_write
> +	},
> +	{
> +		.name = "preset_enable",
> +		.read = quad8_count_preset_enable_read,
> +		.write = quad8_count_preset_enable_write
> +	}
> +};
> +
> +#define QUAD8_COUNT(_id, _cntname) {					\
> +	.id = (_id),							\
> +	.name = (_cntname),						\
> +	.functions_list = quad8_count_functions_list,			\
> +	.num_functions = ARRAY_SIZE(quad8_count_functions_list),	\
> +	.synapses = quad8_count_synapses[(_id)],			\
> +	.num_synapses =	2,						\
> +	.ext = quad8_count_ext,						\
> +	.num_ext = ARRAY_SIZE(quad8_count_ext)				\
> +}
> +
> +static struct counter_count quad8_counts[] = {
> +	QUAD8_COUNT(0, "Channel 1 Count"),
> +	QUAD8_COUNT(1, "Channel 2 Count"),
> +	QUAD8_COUNT(2, "Channel 3 Count"),
> +	QUAD8_COUNT(3, "Channel 4 Count"),
> +	QUAD8_COUNT(4, "Channel 5 Count"),
> +	QUAD8_COUNT(5, "Channel 6 Count"),
> +	QUAD8_COUNT(6, "Channel 7 Count"),
> +	QUAD8_COUNT(7, "Channel 8 Count")
> +};
> +
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct quad8_iio *priv;
> +	struct quad8_iio *quad8iio;
>  	int i, j;
>  	unsigned int base_offset;
> +	int err;
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
> -		dev_name(dev))) {
> +	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
>  			base[id], base[id] + QUAD8_EXTENT);
>  		return -EBUSY;
>  	}
>  
> +	/* Allocate IIO device; this also allocates driver data structure */
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	/* Initialize IIO device */
>  	indio_dev->info = &quad8_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
> @@ -552,8 +1197,22 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->dev.parent = dev;
>  
> -	priv = iio_priv(indio_dev);
> -	priv->base = base[id];
> +	/* Initialize Counter device and driver data */
> +	quad8iio = iio_priv(indio_dev);
> +	quad8iio->counter.name = dev_name(dev);
> +	quad8iio->counter.parent = dev;
> +	quad8iio->counter.signal_read = quad8_signal_read;
> +	quad8iio->counter.count_read = quad8_count_read;
> +	quad8iio->counter.count_write = quad8_count_write;
> +	quad8iio->counter.function_get = quad8_function_get;
> +	quad8iio->counter.function_set = quad8_function_set;
I missed this when looking at the earlier patch, but
it would be good to pull all of these function pointers out
into an ops structure.   The big advantages are that we can
then take them constant (a good thing to do for security).
Also becomes one assignment in here rather than lots.

> +	quad8iio->counter.action_get = quad8_action_get;
> +	quad8iio->counter.counts = quad8_counts;
> +	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
> +	quad8iio->counter.signals = quad8_signals;
> +	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
> +	quad8iio->counter.priv = quad8iio;
> +	quad8iio->base = base[id];
>  
>  	/* Reset all counters and disable interrupt function */
>  	outb(0x01, base[id] + 0x11);
> @@ -579,7 +1238,13 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	/* Enable all counters */
>  	outb(0x00, base[id] + 0x11);
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	/* Register IIO device */
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err)
> +		return err;
> +
> +	/* Register Counter device */
> +	return devm_counter_register(dev, &quad8iio->counter);
>  }
>  
>  static struct isa_driver quad8_driver = {
