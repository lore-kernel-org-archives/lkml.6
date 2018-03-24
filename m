Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeCXRa6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbeCXRa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:30:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84CE2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:30:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] Counter: Add STM32 Timer quadrature encoder
Message-ID: <20180324173051.2c39d619@archlinux>
In-Reply-To: <09612a4089226bbe564bfab9053a0293cdfb5f0c.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <09612a4089226bbe564bfab9053a0293cdfb5f0c.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:43:55 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Implement counter part of the STM32 timer hardware block
> by using counter API.
> Hardware only support X2 and X4 quadrature modes.
> A Preset value can to set to define the maximum value
> reachable by the counter.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Looks good to me.
The only changes I would make are around things I've suggested for the core.

Nice little driver :)

Jonathan

> ---
>  drivers/counter/Kconfig           |  10 ++
>  drivers/counter/Makefile          |   1 +
>  drivers/counter/stm32-timer-cnt.c | 356 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 367 insertions(+)
>  create mode 100644 drivers/counter/stm32-timer-cnt.c
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 0b28d3ff524b..d758279081ac 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -35,6 +35,16 @@ config 104_QUAD_8
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
>  
> +config STM32_TIMER_CNT
> +	tristate "STM32 Timer encoder counter driver"
> +	depends on MFD_STM32_TIMERS || COMPILE_TEST
> +	help
> +	  Select this option to enable STM32 Timer quadrature encoder
> +	  and counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stm32-timer-cnt.
> +
>  config STM32_LPTIMER_CNT
>  	tristate "STM32 LP Timer encoder counter driver"
>  	depends on (MFD_STM32_LPTIMER || COMPILE_TEST) && IIO
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index d721a40aa4a2..9c037d7d1ed6 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_COUNTER) += counter.o
>  counter-y := generic-counter.o
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> +obj-$(CONFIG_STM32_TIMER_CNT) += stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> new file mode 100644
> index 000000000000..14085615e880
> --- /dev/null
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STM32 Timer Encoder and Counter driver
> + *
> + * Copyright (C) STMicroelectronics 2018
> + *
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> + *
> + */
> +#include <linux/counter.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/mfd/stm32-timers.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
> +#define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
> +			 TIM_CCMR_IC1F | TIM_CCMR_IC2F)
> +#define TIM_CCER_MASK	(TIM_CCER_CC1P | TIM_CCER_CC1NP | \
> +			 TIM_CCER_CC2P | TIM_CCER_CC2NP)
> +
> +struct stm32_timer_cnt {
> +	struct counter_device counter;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	u32 preset;
> +};
> +
> +enum stm32_count_function {
> +	STM32_COUNT_FUNCTION_QUADRATURE_X2,
> +	STM32_COUNT_FUNCTION_QUADRATURE_X4,
> +};
> +
> +static enum count_function stm32_count_functions[] = {
> +	[STM32_COUNT_FUNCTION_QUADRATURE_X2] = COUNT_FUNCTION_QUADRATURE_X2,
> +	[STM32_COUNT_FUNCTION_QUADRATURE_X4] = COUNT_FUNCTION_QUADRATURE_X4
> +};
> +
> +static int stm32_count_read(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct count_read_value *val)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 cnt;
> +
> +	regmap_read(priv->regmap, TIM_CNT, &cnt);
> +	set_count_read_value(val, COUNT_POSITION_UNSIGNED, &cnt);
> +
> +	return 0;
> +}
> +
> +static int stm32_count_write(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     struct count_write_value *val)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 cnt;
> +	int err;
> +
> +	err = get_count_write_value(&cnt, COUNT_POSITION_UNSIGNED, val);
> +	if (err)
> +		return err;
> +
> +	if (cnt > priv->preset)
> +		return -EINVAL;
> +
> +	return regmap_write(priv->regmap, TIM_CNT, cnt);
> +}
> +
> +static int stm32_count_function_get(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    size_t *function)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +
> +	switch (smcr & TIM_SMCR_SMS) {
> +	case 1:
> +		*function = STM32_COUNT_FUNCTION_QUADRATURE_X2;
> +		return 0;
> +	case 3:
> +		*function = STM32_COUNT_FUNCTION_QUADRATURE_X4;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stm32_count_function_set(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    size_t function)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 cr1, sms;
> +
> +	switch (function) {
> +	case STM32_COUNT_FUNCTION_QUADRATURE_X2:
> +		sms = 1;
> +		break;
> +	case STM32_COUNT_FUNCTION_QUADRATURE_X4:
> +		sms = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Store enable status */
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +
> +	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> +	regmap_write(priv->regmap, TIM_ARR, priv->preset);
> +
> +	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
> +
> +	/* Make sure that registers are updated */
> +	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> +
> +	/* Restore the enable status */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, cr1);
> +
> +	return 0;
> +}
> +
> +static ssize_t stm32_count_direction_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      void *private, char *buf)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	const char *direction;
> +	u32 cr1;
> +
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	direction = (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
> +}
> +
> +static ssize_t stm32_count_preset_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       void *private, char *buf)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 arr;
> +
> +	regmap_read(priv->regmap, TIM_ARR, &arr);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +}
> +
> +static ssize_t stm32_count_preset_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					void *private,
> +					const char *buf, size_t len)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	unsigned int preset;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &preset);
> +	if (ret)
> +		return ret;
> +
> +	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> +	regmap_write(priv->regmap, TIM_ARR, preset);
> +
> +	priv->preset = preset;
> +	return len;
> +}
> +
> +static ssize_t stm32_count_enable_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       void *private, char *buf)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 cr1;
> +
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN));
> +}
> +
> +static ssize_t stm32_count_enable_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					void *private,
> +					const char *buf, size_t len)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	int err;
> +	u32 cr1;
> +	bool enable;
> +
> +	err = kstrtobool(buf, &enable);
> +	if (err)
> +		return err;
> +
> +	if (enable) {
> +		regmap_read(priv->regmap, TIM_CR1, &cr1);
> +			if (!(cr1 & TIM_CR1_CEN))
> +				clk_enable(priv->clk);
> +
> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
> +				   TIM_CR1_CEN);
> +	} else {
> +		regmap_read(priv->regmap, TIM_CR1, &cr1);
> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +		if (cr1 & TIM_CR1_CEN)
> +			clk_disable(priv->clk);
> +	}
> +
> +	return len;
> +}
> +
> +static const struct counter_count_ext stm32_count_ext[] = {
> +	{
> +		.name = "direction",
> +		.read = stm32_count_direction_read,
> +	},
> +	{
> +		.name = "enable",
> +		.read = stm32_count_enable_read,
> +		.write = stm32_count_enable_write
> +	},
> +	{
> +		.name = "preset",
> +		.read = stm32_count_preset_read,
> +		.write = stm32_count_preset_write
> +	},
> +};
> +
> +enum stm32_synapse_action {
> +	STM32_SYNAPSE_ACTION_RISING_EDGE = 0,
> +	STM32_SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static enum synapse_action stm32_synapse_actions[] = {
> +	[STM32_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE,
> +	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static int stm32_action_get(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    size_t *action)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +
> +	switch (smcr & TIM_SMCR_SMS) {
> +	case 1:
> +		*action = STM32_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;
> +	case 3:
> +		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static struct counter_signal stm32_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 1 Quadrature A"
> +	},
> +	{
> +		.id = 1,
> +		.name = "Channel 1 Quadrature B"
> +	}
> +};
> +
> +static struct counter_synapse stm32_count_synapses[] = {
> +	{
> +		.actions_list = stm32_synapse_actions,
> +		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
> +		.signal = &stm32_signals[0]
> +	},
> +	{
> +		.actions_list = stm32_synapse_actions,
> +		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
> +		.signal = &stm32_signals[1]
> +	}
> +};
> +
> +static struct counter_count stm32_counts = {
> +	.id = 0,
> +	.name = "Channel 1 Count",
> +	.functions_list = stm32_count_functions,
> +	.num_functions = ARRAY_SIZE(stm32_count_functions),
> +	.synapses = stm32_count_synapses,
> +	.num_synapses = ARRAY_SIZE(stm32_count_synapses),
> +	.ext = stm32_count_ext,
> +	.num_ext = ARRAY_SIZE(stm32_count_ext)
> +};
> +
> +static int stm32_timer_cnt_probe(struct platform_device *pdev)
> +{
> +	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct stm32_timer_cnt *priv;
> +
> +	if (IS_ERR_OR_NULL(ddata))
> +		return -EINVAL;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = ddata->regmap;
> +	priv->clk = ddata->clk;
> +	priv->preset = ddata->max_arr;
> +
> +	priv->counter.name = dev_name(dev);
> +	priv->counter.parent = dev;
> +	priv->counter.count_read = stm32_count_read;
> +	priv->counter.count_write = stm32_count_write;
> +	priv->counter.function_get = stm32_count_function_get;
> +	priv->counter.function_set = stm32_count_function_set;
> +	priv->counter.action_get = stm32_action_get;
> +	priv->counter.counts = &stm32_counts;
> +	priv->counter.num_counts = 1;
> +	priv->counter.signals = stm32_signals;
> +	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
> +	priv->counter.priv = priv;
> +
> +	/* Register Counter device */
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
> +static const struct of_device_id stm32_timer_cnt_of_match[] = {
> +	{ .compatible = "st,stm32-timer-counter", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_timer_cnt_of_match);
> +
> +static struct platform_driver stm32_timer_cnt_driver = {
> +	.probe = stm32_timer_cnt_probe,
> +	.driver = {
> +		.name = "stm32-timer-counter",
> +		.of_match_table = stm32_timer_cnt_of_match,
> +	},
> +};
> +module_platform_driver(stm32_timer_cnt_driver);
> +
> +MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
> +MODULE_ALIAS("platform:stm32-timer-counter");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 TIMER counter driver");
> +MODULE_LICENSE("GPL v2");
