Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52530C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758D2239C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGYveT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E758D2239C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeFUVIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:08:30 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39082 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeFUVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:08:28 -0400
Received: by mail-yb0-f195.google.com with SMTP id i2-v6so1760727ybg.6;
        Thu, 21 Jun 2018 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwEKfr6PZk1LuLIc9Pg2jrzSCLudaYe0LUASZzCBMos=;
        b=UMGYveT88ds9Kq01J6nsUMJzaUfPdN9xY45+K7RC3CMvf4pvsmVSL652z9wDOZpzll
         8ykr39sNk5FXGP4DZWW5HJog8WLN/uervGXcAGKF64obAU0T9JKSpWLDsFpxf1O/X2ff
         I4jJ65QPTcVNk/ai2T7tWTYw8xH9m/k3oxk8OchNi0wVYrs7uti14nZoePbdcvQ/d5sq
         DOIGJohsgBPOw+jbRxWI2x6tNtvfJzWXBTIORmLzp4/4UzYY5nVCheaT4Hw7yDEto3n9
         lM/3j7jFoi7nXJppdAFapy8e2OGxeMonMIjntIMHaLlvl1FuTKrucmxlF4W1BX8pK6O7
         fpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwEKfr6PZk1LuLIc9Pg2jrzSCLudaYe0LUASZzCBMos=;
        b=BaGKW1IQmpXASks9H7eYcIf0Gs0VZoMXgGkBGVSo1QT8fFWRond6DaEFwW9/WfFf3t
         EAyKGD5n3q65pPXo98zol7xk/z5HdC9j9wgBhK8AtiVU8QzoNzY8Oox0afIfQmAj94kP
         VlsGHVUFLcpOlU1lYfy69cG5KdRg7oPPmNsH0UJiB59P7hZS+dO0hNqwjRX6LGKW2Dn+
         TIOioqSmLYNFsP/cn79ZO3UrURpG/PZpROusotzt5Gi5uJkKO1FQcTGjy4g0efnb6nbG
         ZLEo+vUdOZAoTc1pjLXSg3eor27o6H7QKZjA6Ow+uDYftTtvIX7CAPjpy4t6lenlTDVy
         TtFQ==
X-Gm-Message-State: APt69E0S6ELf45VBtMz16DKxfkXhkFfewrIlmUbCUlSttqN8L+SH+nsf
        fVoCif9/0pJNcLn/725oWVQ=
X-Google-Smtp-Source: ADUXVKID5Wf/gKjTFoGM0YzlLyl0Y7cZGlR/vOCsqOHzUiiO2dQWbP59L62Sv9g8/nti4IscJBR2hA==
X-Received: by 2002:a25:ae5a:: with SMTP id g26-v6mr8069957ybe.351.1529615307164;
        Thu, 21 Jun 2018 14:08:27 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id m206-v6sm2063837ywb.97.2018.06.21.14.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:08:26 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 06/10] counter: Add STM32 Timer quadrature encoder
Date:   Thu, 21 Jun 2018 17:08:20 -0400
Message-Id: <3bcbc5d2c4dd644f81e3ab35a836c7648bfd0454.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Implement counter part of the STM32 timer hardware block by using
counter API. Hardware only supports X2 and X4 quadrature modes. A
ceiling value can be set to define the maximum value reachable by the
counter.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Co-authored-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Kconfig           |  10 +
 drivers/counter/Makefile          |   1 +
 drivers/counter/stm32-timer-cnt.c | 390 ++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 drivers/counter/stm32-timer-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 7646f5df76f3..fcfbaa935122 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -36,4 +36,14 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config STM32_TIMER_CNT
+	tristate "STM32 Timer encoder counter driver"
+	depends on MFD_STM32_TIMERS || COMPILE_TEST
+	help
+	  Select this option to enable STM32 Timer quadrature encoder
+	  and counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-timer-cnt.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 23a4f6263e45..ff024259fb46 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_COUNTER) += counter.o
 counter-y := generic-counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
new file mode 100644
index 000000000000..0b15e729798b
--- /dev/null
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32 Timer Encoder and Counter driver
+ *
+ * Copyright (C) STMicroelectronics 2018
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
+ *
+ */
+#include <linux/counter.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/mfd/stm32-timers.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
+#define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
+			 TIM_CCMR_IC1F | TIM_CCMR_IC2F)
+#define TIM_CCER_MASK	(TIM_CCER_CC1P | TIM_CCER_CC1NP | \
+			 TIM_CCER_CC2P | TIM_CCER_CC2NP)
+
+struct stm32_timer_cnt {
+	struct counter_device counter;
+	struct regmap *regmap;
+	struct clk *clk;
+	u32 ceiling;
+};
+
+/**
+ * stm32_count_function - enumerates stm32 timer counter encoder modes
+ * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
+ * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
+ * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
+ * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
+ */
+enum stm32_count_function {
+	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
+	STM32_COUNT_ENCODER_MODE_1,
+	STM32_COUNT_ENCODER_MODE_2,
+	STM32_COUNT_ENCODER_MODE_3,
+};
+
+static enum count_function stm32_count_functions[] = {
+	[STM32_COUNT_ENCODER_MODE_1] = COUNT_FUNCTION_QUADRATURE_X2_A,
+	[STM32_COUNT_ENCODER_MODE_2] = COUNT_FUNCTION_QUADRATURE_X2_B,
+	[STM32_COUNT_ENCODER_MODE_3] = COUNT_FUNCTION_QUADRATURE_X4,
+};
+
+static int stm32_count_read(struct counter_device *counter,
+			    struct counter_count *count,
+			    struct count_read_value *val)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 cnt;
+
+	regmap_read(priv->regmap, TIM_CNT, &cnt);
+	count_read_value_set(val, COUNT_POSITION, &cnt);
+
+	return 0;
+}
+
+static int stm32_count_write(struct counter_device *counter,
+			     struct counter_count *count,
+			     struct count_write_value *val)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 cnt;
+	int err;
+
+	err = count_write_value_get(&cnt, COUNT_POSITION, val);
+	if (err)
+		return err;
+
+	if (cnt > priv->ceiling)
+		return -EINVAL;
+
+	return regmap_write(priv->regmap, TIM_CNT, cnt);
+}
+
+static int stm32_count_function_get(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t *function)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 smcr;
+
+	regmap_read(priv->regmap, TIM_SMCR, &smcr);
+
+	switch (smcr & TIM_SMCR_SMS) {
+	case 1:
+		*function = STM32_COUNT_ENCODER_MODE_1;
+		return 0;
+	case 2:
+		*function = STM32_COUNT_ENCODER_MODE_2;
+		return 0;
+	case 3:
+		*function = STM32_COUNT_ENCODER_MODE_3;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_count_function_set(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t function)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 cr1, sms;
+
+	switch (function) {
+	case STM32_COUNT_ENCODER_MODE_1:
+		sms = 1;
+		break;
+	case STM32_COUNT_ENCODER_MODE_2:
+		sms = 2;
+		break;
+	case STM32_COUNT_ENCODER_MODE_3:
+		sms = 3;
+		break;
+	default:
+		sms = 0;
+		break;
+	}
+
+	/* Store enable status */
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+
+	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
+	regmap_write(priv->regmap, TIM_ARR, priv->ceiling);
+
+	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
+
+	/* Make sure that registers are updated */
+	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	/* Restore the enable status */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, cr1);
+
+	return 0;
+}
+
+static ssize_t stm32_count_direction_read(struct counter_device *counter,
+				      struct counter_count *count,
+				      void *private, char *buf)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	const char *direction;
+	u32 cr1;
+
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	direction = (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
+}
+
+static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
+					struct counter_count *count,
+					void *private, char *buf)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 arr;
+
+	regmap_read(priv->regmap, TIM_ARR, &arr);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
+}
+
+static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
+					 struct counter_count *count,
+					 void *private,
+					 const char *buf, size_t len)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	unsigned int ceiling;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &ceiling);
+	if (ret)
+		return ret;
+
+	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
+	regmap_write(priv->regmap, TIM_ARR, ceiling);
+
+	priv->ceiling = ceiling;
+	return len;
+}
+
+static ssize_t stm32_count_enable_read(struct counter_device *counter,
+				       struct counter_count *count,
+				       void *private, char *buf)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	u32 cr1;
+
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN));
+}
+
+static ssize_t stm32_count_enable_write(struct counter_device *counter,
+					struct counter_count *count,
+					void *private,
+					const char *buf, size_t len)
+{
+	struct stm32_timer_cnt *const priv = counter->priv;
+	int err;
+	u32 cr1;
+	bool enable;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	if (enable) {
+		regmap_read(priv->regmap, TIM_CR1, &cr1);
+			if (!(cr1 & TIM_CR1_CEN))
+				clk_enable(priv->clk);
+
+		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
+				   TIM_CR1_CEN);
+	} else {
+		regmap_read(priv->regmap, TIM_CR1, &cr1);
+		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		if (cr1 & TIM_CR1_CEN)
+			clk_disable(priv->clk);
+	}
+
+	return len;
+}
+
+static const struct counter_count_ext stm32_count_ext[] = {
+	{
+		.name = "direction",
+		.read = stm32_count_direction_read,
+	},
+	{
+		.name = "enable",
+		.read = stm32_count_enable_read,
+		.write = stm32_count_enable_write
+	},
+	{
+		.name = "ceiling",
+		.read = stm32_count_ceiling_read,
+		.write = stm32_count_ceiling_write
+	},
+};
+
+enum stm32_synapse_action {
+	STM32_SYNAPSE_ACTION_NONE,
+	STM32_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static enum synapse_action stm32_synapse_actions[] = {
+	[STM32_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
+	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static int stm32_action_get(struct counter_device *counter,
+			    struct counter_count *count,
+			    struct counter_synapse *synapse,
+			    size_t *action)
+{
+	size_t function;
+	int err;
+
+	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
+	*action = STM32_SYNAPSE_ACTION_NONE;
+
+	err = stm32_count_function_get(counter, count, &function);
+	if (err)
+		return 0;
+
+	switch (function) {
+	case STM32_COUNT_ENCODER_MODE_1:
+		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
+		if (synapse->signal->id == count->synapses[0].signal->id)
+			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case STM32_COUNT_ENCODER_MODE_2:
+		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
+		if (synapse->signal->id == count->synapses[1].signal->id)
+			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case STM32_COUNT_ENCODER_MODE_3:
+		/* counts up/down on both TI1FP1 and TI2FP2 edges */
+		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	}
+
+	return 0;
+}
+
+static const struct counter_ops stm32_timer_cnt_ops = {
+	.count_read = stm32_count_read,
+	.count_write = stm32_count_write,
+	.function_get = stm32_count_function_get,
+	.function_set = stm32_count_function_set,
+	.action_get = stm32_action_get,
+};
+
+static struct counter_signal stm32_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Quadrature A"
+	},
+	{
+		.id = 1,
+		.name = "Channel 1 Quadrature B"
+	}
+};
+
+static struct counter_synapse stm32_count_synapses[] = {
+	{
+		.actions_list = stm32_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
+		.signal = &stm32_signals[0]
+	},
+	{
+		.actions_list = stm32_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
+		.signal = &stm32_signals[1]
+	}
+};
+
+static struct counter_count stm32_counts = {
+	.id = 0,
+	.name = "Channel 1 Count",
+	.functions_list = stm32_count_functions,
+	.num_functions = ARRAY_SIZE(stm32_count_functions),
+	.synapses = stm32_count_synapses,
+	.num_synapses = ARRAY_SIZE(stm32_count_synapses),
+	.ext = stm32_count_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_ext)
+};
+
+static int stm32_timer_cnt_probe(struct platform_device *pdev)
+{
+	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct stm32_timer_cnt *priv;
+
+	if (IS_ERR_OR_NULL(ddata))
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = ddata->regmap;
+	priv->clk = ddata->clk;
+	priv->ceiling = ddata->max_arr;
+
+	priv->counter.name = dev_name(dev);
+	priv->counter.parent = dev;
+	priv->counter.ops = &stm32_timer_cnt_ops;
+	priv->counter.counts = &stm32_counts;
+	priv->counter.num_counts = 1;
+	priv->counter.signals = stm32_signals;
+	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
+	priv->counter.priv = priv;
+
+	/* Register Counter device */
+	return devm_counter_register(dev, &priv->counter);
+}
+
+static const struct of_device_id stm32_timer_cnt_of_match[] = {
+	{ .compatible = "st,stm32-timer-counter", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_timer_cnt_of_match);
+
+static struct platform_driver stm32_timer_cnt_driver = {
+	.probe = stm32_timer_cnt_probe,
+	.driver = {
+		.name = "stm32-timer-counter",
+		.of_match_table = stm32_timer_cnt_of_match,
+	},
+};
+module_platform_driver(stm32_timer_cnt_driver);
+
+MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
+MODULE_ALIAS("platform:stm32-timer-counter");
+MODULE_DESCRIPTION("STMicroelectronics STM32 TIMER counter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

