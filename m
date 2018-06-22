Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C69C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC20A24653
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC20A24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeFVREB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:04:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48627 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751445AbeFVRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:03:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E6B5EB4AB742;
        Sat, 23 Jun 2018 01:03:54 +0800 (CST)
Received: from localhost (10.47.144.153) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Sat, 23 Jun 2018
 01:03:48 +0800
Date:   Fri, 22 Jun 2018 18:03:33 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jic23@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>
Subject: Re: [PATCH v7 06/10] counter: Add STM32 Timer quadrature encoder
Message-ID: <20180622180333.00007ab8@huawei.com>
In-Reply-To: <3bcbc5d2c4dd644f81e3ab35a836c7648bfd0454.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <3bcbc5d2c4dd644f81e3ab35a836c7648bfd0454.1529607879.git.vilhelm.gray@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.144.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 17:08:20 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Implement counter part of the STM32 timer hardware block by using
> counter API. Hardware only supports X2 and X4 quadrature modes. A
> ceiling value can be set to define the maximum value reachable by the
> counter.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Co-authored-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/Kconfig           |  10 +
>  drivers/counter/Makefile          |   1 +
>  drivers/counter/stm32-timer-cnt.c | 390 ++++++++++++++++++++++++++++++
>  3 files changed, 401 insertions(+)
>  create mode 100644 drivers/counter/stm32-timer-cnt.c
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 7646f5df76f3..fcfbaa935122 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -36,4 +36,14 @@ config 104_QUAD_8
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
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 23a4f6263e45..ff024259fb46 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_COUNTER) += counter.o
>  counter-y := generic-counter.o
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> +obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> new file mode 100644
> index 000000000000..0b15e729798b
> --- /dev/null
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STM32 Timer Encoder and Counter driver
> + *
> + * Copyright (C) STMicroelectronics 2018
> + *
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> + *

If I was being really really fussy - this blank line doesn't add
anything ;)

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
> +	u32 ceiling;
> +};
> +
> +/**
> + * stm32_count_function - enumerates stm32 timer counter encoder modes
> + * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
> + * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
> + * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
> + * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
> + */
> +enum stm32_count_function {
> +	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
> +	STM32_COUNT_ENCODER_MODE_1,
> +	STM32_COUNT_ENCODER_MODE_2,
> +	STM32_COUNT_ENCODER_MODE_3,
> +};
> +
> +static enum count_function stm32_count_functions[] = {
> +	[STM32_COUNT_ENCODER_MODE_1] = COUNT_FUNCTION_QUADRATURE_X2_A,
> +	[STM32_COUNT_ENCODER_MODE_2] = COUNT_FUNCTION_QUADRATURE_X2_B,
> +	[STM32_COUNT_ENCODER_MODE_3] = COUNT_FUNCTION_QUADRATURE_X4,
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
> +	count_read_value_set(val, COUNT_POSITION, &cnt);
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
> +	err = count_write_value_get(&cnt, COUNT_POSITION, val);
> +	if (err)
> +		return err;
> +
> +	if (cnt > priv->ceiling)
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
> +		*function = STM32_COUNT_ENCODER_MODE_1;
> +		return 0;
> +	case 2:
> +		*function = STM32_COUNT_ENCODER_MODE_2;
> +		return 0;
> +	case 3:
> +		*function = STM32_COUNT_ENCODER_MODE_3;
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
> +	case STM32_COUNT_ENCODER_MODE_1:
> +		sms = 1;
> +		break;
> +	case STM32_COUNT_ENCODER_MODE_2:
> +		sms = 2;
> +		break;
> +	case STM32_COUNT_ENCODER_MODE_3:
> +		sms = 3;
> +		break;
> +	default:
> +		sms = 0;
> +		break;
> +	}
> +
> +	/* Store enable status */
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +
> +	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> +	regmap_write(priv->regmap, TIM_ARR, priv->ceiling);
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
> +static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					void *private, char *buf)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	u32 arr;
> +
> +	regmap_read(priv->regmap, TIM_ARR, &arr);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +}
> +
> +static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 void *private,
> +					 const char *buf, size_t len)
> +{
> +	struct stm32_timer_cnt *const priv = counter->priv;
> +	unsigned int ceiling;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &ceiling);
> +	if (ret)
> +		return ret;
> +
> +	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> +	regmap_write(priv->regmap, TIM_ARR, ceiling);
> +
> +	priv->ceiling = ceiling;
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
> +		.name = "ceiling",
> +		.read = stm32_count_ceiling_read,
> +		.write = stm32_count_ceiling_write
> +	},
> +};
> +
> +enum stm32_synapse_action {
> +	STM32_SYNAPSE_ACTION_NONE,
> +	STM32_SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static enum synapse_action stm32_synapse_actions[] = {
> +	[STM32_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
> +	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES
> +};
> +
> +static int stm32_action_get(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    size_t *action)
> +{
> +	size_t function;
> +	int err;
> +
> +	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
> +	*action = STM32_SYNAPSE_ACTION_NONE;
> +
> +	err = stm32_count_function_get(counter, count, &function);
> +	if (err)
> +		return 0;
> +
> +	switch (function) {
> +	case STM32_COUNT_ENCODER_MODE_1:
> +		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
> +		if (synapse->signal->id == count->synapses[0].signal->id)
> +			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case STM32_COUNT_ENCODER_MODE_2:
> +		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
> +		if (synapse->signal->id == count->synapses[1].signal->id)
> +			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case STM32_COUNT_ENCODER_MODE_3:
> +		/* counts up/down on both TI1FP1 and TI2FP2 edges */
> +		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops stm32_timer_cnt_ops = {
> +	.count_read = stm32_count_read,
> +	.count_write = stm32_count_write,
> +	.function_get = stm32_count_function_get,
> +	.function_set = stm32_count_function_set,
> +	.action_get = stm32_action_get,
> +};
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
> +	priv->ceiling = ddata->max_arr;
> +
> +	priv->counter.name = dev_name(dev);
> +	priv->counter.parent = dev;
> +	priv->counter.ops = &stm32_timer_cnt_ops;
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


