Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeEPRwh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:52:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46884 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeEPRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:52:35 -0400
X-Google-Smtp-Source: AB8JxZreoGdDIqPZVZ3idfHt25EOIgG2nWmpDUroI0StJAl6cR885wwzrKHcr9fqUHEkLufKP3C1Rw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 8/9] counter: stm32-lptimer: add counter device
Date: Wed, 16 May 2018 13:52:27 -0400
Message-Id: <726de278f09aa4438b97b147cd26a03009522997.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add support for new counter device to stm32-lptimer.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |   0
 .../devicetree/bindings/mfd/stm32-lptimer.txt |   2 +-
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/stm32-lptimer-cnt.c           | 722 ++++++++++++++++++
 drivers/iio/counter/Kconfig                   |   9 -
 drivers/iio/counter/Makefile                  |   2 -
 drivers/iio/counter/stm32-lptimer-cnt.c       | 382 ---------
 8 files changed, 734 insertions(+), 394 deletions(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 drivers/counter/stm32-lptimer-cnt.c
 delete mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 90b698aa52cf..196d210d4e19 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -46,4 +46,14 @@ config STM32_TIMER_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-timer-cnt.
 
+config STM32_LPTIMER_CNT
+	tristate "STM32 LP Timer encoder counter driver"
+	depends on (MFD_STM32_LPTIMER || COMPILE_TEST) && IIO
+	help
+	  Select this option to enable STM32 Low-Power Timer quadrature encoder
+	  and counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-lptimer-cnt.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index ff024259fb46..8ff19b32022b 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -9,3 +9,4 @@ counter-y := generic-counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
+obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
new file mode 100644
index 000000000000..c2c0b19320cf
--- /dev/null
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32 Low-Power Timer Encoder and Counter driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
+ *
+ * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/counter.h>
+#include <linux/iio/iio.h>
+#include <linux/mfd/stm32-lptimer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct stm32_lptim_cnt {
+	struct counter_device counter;
+	struct device *dev;
+	struct regmap *regmap;
+	struct clk *clk;
+	u32 ceiling;
+	u32 polarity;
+	u32 quadrature_mode;
+};
+
+static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(STM32_LPTIM_ENABLE, val);
+}
+
+static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
+					int enable)
+{
+	int ret;
+	u32 val;
+
+	val = FIELD_PREP(STM32_LPTIM_ENABLE, enable);
+	ret = regmap_write(priv->regmap, STM32_LPTIM_CR, val);
+	if (ret)
+		return ret;
+
+	if (!enable) {
+		clk_disable(priv->clk);
+		return 0;
+	}
+
+	/* LP timer must be enabled before writing CMP & ARR */
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->ceiling);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
+	if (ret)
+		return ret;
+
+	/* ensure CMP & ARR registers are properly written */
+	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
+				       (val & STM32_LPTIM_CMPOK_ARROK),
+				       100, 1000);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
+			   STM32_LPTIM_CMPOKCF_ARROKCF);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+		return ret;
+	}
+
+	/* Start LP timer in continuous mode */
+	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
+				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
+}
+
+static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
+{
+	u32 mask = STM32_LPTIM_ENC | STM32_LPTIM_COUNTMODE |
+		   STM32_LPTIM_CKPOL | STM32_LPTIM_PRESC;
+	u32 val;
+
+	/* Setup LP timer encoder/counter and polarity, without prescaler */
+	if (priv->quadrature_mode)
+		val = enable ? STM32_LPTIM_ENC : 0;
+	else
+		val = enable ? STM32_LPTIM_COUNTMODE : 0;
+	val |= FIELD_PREP(STM32_LPTIM_CKPOL, enable ? priv->polarity : 0);
+
+	return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
+}
+
+static int stm32_lptim_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+
+		/* Check nobody uses the timer, or already disabled/enabled */
+		ret = stm32_lptim_is_enabled(priv);
+		if ((ret < 0) || (!ret && !val))
+			return ret;
+		if (val && ret)
+			return -EBUSY;
+
+		ret = stm32_lptim_setup(priv, val);
+		if (ret)
+			return ret;
+		return stm32_lptim_set_enable_state(priv, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+	u32 dat;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &dat);
+		if (ret)
+			return ret;
+		*val = dat;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_ENABLE:
+		ret = stm32_lptim_is_enabled(priv);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Non-quadrature mode: scale = 1 */
+		*val = 1;
+		*val2 = 0;
+		if (priv->quadrature_mode) {
+			/*
+			 * Quadrature encoder mode:
+			 * - both edges, quarter cycle, scale is 0.25
+			 * - either rising/falling edge scale is 0.5
+			 */
+			if (priv->polarity > 1)
+				*val2 = 2;
+			else
+				*val2 = 1;
+		}
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info stm32_lptim_cnt_iio_info = {
+	.read_raw = stm32_lptim_read_raw,
+	.write_raw = stm32_lptim_write_raw,
+};
+
+static const char *const stm32_lptim_quadrature_modes[] = {
+	"non-quadrature",
+	"quadrature",
+};
+
+static int stm32_lptim_get_quadrature_mode(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return priv->quadrature_mode;
+}
+
+static int stm32_lptim_set_quadrature_mode(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   unsigned int type)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	priv->quadrature_mode = type;
+
+	return 0;
+}
+
+static const struct iio_enum stm32_lptim_quadrature_mode_en = {
+	.items = stm32_lptim_quadrature_modes,
+	.num_items = ARRAY_SIZE(stm32_lptim_quadrature_modes),
+	.get = stm32_lptim_get_quadrature_mode,
+	.set = stm32_lptim_set_quadrature_mode,
+};
+
+static const char * const stm32_lptim_cnt_polarity[] = {
+	"rising-edge", "falling-edge", "both-edges",
+};
+
+static int stm32_lptim_cnt_get_polarity(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return priv->polarity;
+}
+
+static int stm32_lptim_cnt_set_polarity(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					unsigned int type)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	priv->polarity = type;
+
+	return 0;
+}
+
+static const struct iio_enum stm32_lptim_cnt_polarity_en = {
+	.items = stm32_lptim_cnt_polarity,
+	.num_items = ARRAY_SIZE(stm32_lptim_cnt_polarity),
+	.get = stm32_lptim_cnt_get_polarity,
+	.set = stm32_lptim_cnt_set_polarity,
+};
+
+static ssize_t stm32_lptim_cnt_get_ceiling(struct stm32_lptim_cnt *priv,
+					   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
+}
+
+static ssize_t stm32_lptim_cnt_set_ceiling(struct stm32_lptim_cnt *priv,
+					   const char *buf, size_t len)
+{
+	int ret;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	ret = kstrtouint(buf, 0, &priv->ceiling);
+	if (ret)
+		return ret;
+
+	if (priv->ceiling > STM32_LPTIM_MAX_ARR)
+		return -EINVAL;
+
+	return len;
+}
+
+static ssize_t stm32_lptim_cnt_get_preset_iio(struct iio_dev *indio_dev,
+					      uintptr_t private,
+					      const struct iio_chan_spec *chan,
+					      char *buf)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return stm32_lptim_cnt_get_ceiling(priv, buf);
+}
+
+static ssize_t stm32_lptim_cnt_set_preset_iio(struct iio_dev *indio_dev,
+					      uintptr_t private,
+					      const struct iio_chan_spec *chan,
+					      const char *buf, size_t len)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
+}
+
+/* LP timer with encoder */
+static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
+	{
+		.name = "preset",
+		.shared = IIO_SEPARATE,
+		.read = stm32_lptim_cnt_get_preset_iio,
+		.write = stm32_lptim_cnt_set_preset_iio,
+	},
+	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM("quadrature_mode", IIO_SEPARATE,
+		 &stm32_lptim_quadrature_mode_en),
+	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_lptim_quadrature_mode_en),
+	{}
+};
+
+static const struct iio_chan_spec stm32_lptim_enc_channels = {
+	.type = IIO_COUNT,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_ENABLE) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = stm32_lptim_enc_ext_info,
+	.indexed = 1,
+};
+
+/* LP timer without encoder (counter only) */
+static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
+	{
+		.name = "preset",
+		.shared = IIO_SEPARATE,
+		.read = stm32_lptim_cnt_get_preset_iio,
+		.write = stm32_lptim_cnt_set_preset_iio,
+	},
+	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
+	{}
+};
+
+static const struct iio_chan_spec stm32_lptim_cnt_channels = {
+	.type = IIO_COUNT,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_ENABLE) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = stm32_lptim_cnt_ext_info,
+	.indexed = 1,
+};
+
+/**
+ * stm32_lptim_cnt_function - enumerates stm32 LPTimer counter & encoder modes
+ * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
+ * @STM32_LPTIM_ENCODER_RISING: count on rising edge (IN1 & IN2 quadrature)
+ * @STM32_LPTIM_ENCODER_FALLING: count on falling edge (IN1 & IN2 quadrature)
+ * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
+ */
+enum stm32_lptim_cnt_function {
+	STM32_LPTIM_COUNTER_INCREASE,
+	STM32_LPTIM_ENCODER_RISING,
+	STM32_LPTIM_ENCODER_FALLING,
+	STM32_LPTIM_ENCODER_BOTH_EDGE,
+};
+
+static enum count_function stm32_lptim_cnt_functions[] = {
+	[STM32_LPTIM_COUNTER_INCREASE] = COUNT_FUNCTION_INCREASE,
+	[STM32_LPTIM_ENCODER_RISING] = COUNT_FUNCTION_QUADRATURE_X2_RISING,
+	[STM32_LPTIM_ENCODER_FALLING] = COUNT_FUNCTION_QUADRATURE_X2_FALLING,
+	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNT_FUNCTION_QUADRATURE_X4,
+};
+
+enum stm32_lptim_synapse_action {
+	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
+	STM32_LPTIM_SYNAPSE_ACTION_NONE,
+};
+
+static enum synapse_action stm32_lptim_cnt_synapse_actions[] = {
+	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
+	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = SYNAPSE_ACTION_RISING_EDGE,
+	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = SYNAPSE_ACTION_FALLING_EDGE,
+	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = SYNAPSE_ACTION_BOTH_EDGES,
+	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = SYNAPSE_ACTION_NONE,
+};
+
+static int stm32_lptim_cnt_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct count_read_value *val)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	u32 cnt;
+	int ret;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &cnt);
+	if (ret)
+		return ret;
+
+	set_count_read_value(val, COUNT_POSITION_UNSIGNED, &cnt);
+
+	return 0;
+}
+
+static int stm32_lptim_cnt_function_get(struct counter_device *counter,
+					struct counter_count *count,
+					size_t *function)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+
+	if (!priv->quadrature_mode) {
+		*function = STM32_LPTIM_COUNTER_INCREASE;
+		return 0;
+	}
+
+	switch (priv->polarity) {
+	case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
+		*function = STM32_LPTIM_ENCODER_RISING;
+		return 0;
+	case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
+		*function = STM32_LPTIM_ENCODER_FALLING;
+		return 0;
+	case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
+		*function = STM32_LPTIM_ENCODER_BOTH_EDGE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_lptim_cnt_function_set(struct counter_device *counter,
+					struct counter_count *count,
+					size_t function)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	switch (function) {
+	case STM32_LPTIM_COUNTER_INCREASE:
+		priv->quadrature_mode = 0;
+		return 0;
+	case STM32_LPTIM_ENCODER_RISING:
+		priv->quadrature_mode = 1;
+		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
+	case STM32_LPTIM_ENCODER_FALLING:
+		priv->quadrature_mode = 1;
+		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE;
+		return 0;
+	case STM32_LPTIM_ENCODER_BOTH_EDGE:
+		priv->quadrature_mode = 1;
+		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
+					   struct counter_count *count,
+					   void *private, char *buf)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	int ret;
+
+	ret = stm32_lptim_is_enabled(priv);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
+}
+
+static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
+					    struct counter_count *count,
+					    void *private,
+					    const char *buf, size_t len)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	/* Check nobody uses the timer, or already disabled/enabled */
+	ret = stm32_lptim_is_enabled(priv);
+	if ((ret < 0) || (!ret && !enable))
+		return ret;
+	if (enable && ret)
+		return -EBUSY;
+
+	ret = stm32_lptim_setup(priv, enable);
+	if (ret)
+		return ret;
+
+	ret = stm32_lptim_set_enable_state(priv, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
+					    struct counter_count *count,
+					    void *private, char *buf)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+
+	return stm32_lptim_cnt_get_ceiling(priv, buf);
+}
+
+static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
+					     struct counter_count *count,
+					     void *private,
+					     const char *buf, size_t len)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+
+	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
+}
+
+static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
+	{
+		.name = "enable",
+		.read = stm32_lptim_cnt_enable_read,
+		.write = stm32_lptim_cnt_enable_write
+	},
+	{
+		.name = "ceiling",
+		.read = stm32_lptim_cnt_ceiling_read,
+		.write = stm32_lptim_cnt_ceiling_write
+	},
+};
+
+static int stm32_lptim_cnt_action_get(struct counter_device *counter,
+				      struct counter_count *count,
+				      struct counter_synapse *synapse,
+				      size_t *action)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	size_t function;
+	int err;
+
+	err = stm32_lptim_cnt_function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	switch (function) {
+	case STM32_LPTIM_COUNTER_INCREASE:
+		/* LP Timer acts as up-counter on input 1 */
+		if (synapse->signal->id == count->synapses[0].signal->id)
+			*action = priv->polarity;
+		else
+			*action = STM32_LPTIM_SYNAPSE_ACTION_NONE;
+		return 0;
+	case STM32_LPTIM_ENCODER_RISING:
+	case STM32_LPTIM_ENCODER_FALLING:
+	case STM32_LPTIM_ENCODER_BOTH_EDGE:
+		*action = priv->polarity;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_lptim_cnt_action_set(struct counter_device *counter,
+				      struct counter_count *count,
+				      struct counter_synapse *synapse,
+				      size_t action)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	size_t function;
+	int err;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	err = stm32_lptim_cnt_function_get(counter, count, &function);
+	if (err)
+		return err;
+
+	/* only set polarity when in counter mode (on input 1) */
+	if (function == STM32_LPTIM_COUNTER_INCREASE
+	    && synapse->signal->id == count->synapses[0].signal->id) {
+		switch (action) {
+		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
+		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
+		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
+			priv->polarity = action;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct counter_ops stm32_lptim_cnt_ops = {
+	.count_read = stm32_lptim_cnt_read,
+	.function_get = stm32_lptim_cnt_function_get,
+	.function_set = stm32_lptim_cnt_function_set,
+	.action_get = stm32_lptim_cnt_action_get,
+	.action_set = stm32_lptim_cnt_action_set,
+};
+
+static struct counter_signal stm32_lptim_cnt_signals[] = {
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
+static struct counter_synapse stm32_lptim_cnt_synapses[] = {
+	{
+		.actions_list = stm32_lptim_cnt_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_lptim_cnt_synapse_actions),
+		.signal = &stm32_lptim_cnt_signals[0]
+	},
+	{
+		.actions_list = stm32_lptim_cnt_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_lptim_cnt_synapse_actions),
+		.signal = &stm32_lptim_cnt_signals[1]
+	}
+};
+
+/* LP timer with encoder */
+static struct counter_count stm32_lptim_enc_counts = {
+	.id = 0,
+	.name = "LPTimer Count",
+	.functions_list = stm32_lptim_cnt_functions,
+	.num_functions = ARRAY_SIZE(stm32_lptim_cnt_functions),
+	.synapses = stm32_lptim_cnt_synapses,
+	.num_synapses = ARRAY_SIZE(stm32_lptim_cnt_synapses),
+	.ext = stm32_lptim_cnt_ext,
+	.num_ext = ARRAY_SIZE(stm32_lptim_cnt_ext)
+};
+
+/* LP timer without encoder (counter only) */
+static struct counter_count stm32_lptim_in1_counts = {
+	.id = 0,
+	.name = "LPTimer Count",
+	.functions_list = stm32_lptim_cnt_functions,
+	.num_functions = 1,
+	.synapses = stm32_lptim_cnt_synapses,
+	.num_synapses = 1,
+	.ext = stm32_lptim_cnt_ext,
+	.num_ext = ARRAY_SIZE(stm32_lptim_cnt_ext)
+};
+
+static int stm32_lptim_cnt_probe(struct platform_device *pdev)
+{
+	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct stm32_lptim_cnt *priv;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (IS_ERR_OR_NULL(ddata))
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = &pdev->dev;
+	priv->regmap = ddata->regmap;
+	priv->clk = ddata->clk;
+	priv->ceiling = STM32_LPTIM_MAX_ARR;
+
+	/* Initialize IIO device */
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &stm32_lptim_cnt_iio_info;
+	if (ddata->has_encoder)
+		indio_dev->channels = &stm32_lptim_enc_channels;
+	else
+		indio_dev->channels = &stm32_lptim_cnt_channels;
+	indio_dev->num_channels = 1;
+
+	/* Initialize Counter device */
+	priv->counter.name = dev_name(&pdev->dev);
+	priv->counter.parent = &pdev->dev;
+	priv->counter.ops = &stm32_lptim_cnt_ops;
+	if (ddata->has_encoder) {
+		priv->counter.counts = &stm32_lptim_enc_counts;
+		priv->counter.num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
+	} else {
+		priv->counter.counts = &stm32_lptim_in1_counts;
+		priv->counter.num_signals = 1;
+	}
+	priv->counter.num_counts = 1;
+	priv->counter.signals = stm32_lptim_cnt_signals;
+	priv->counter.priv = priv;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_counter_register(&pdev->dev, &priv->counter);
+}
+
+static const struct of_device_id stm32_lptim_cnt_of_match[] = {
+	{ .compatible = "st,stm32-lptimer-counter", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_lptim_cnt_of_match);
+
+static struct platform_driver stm32_lptim_cnt_driver = {
+	.probe = stm32_lptim_cnt_probe,
+	.driver = {
+		.name = "stm32-lptimer-counter",
+		.of_match_table = stm32_lptim_cnt_of_match,
+	},
+};
+module_platform_driver(stm32_lptim_cnt_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_ALIAS("platform:stm32-lptimer-counter");
+MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index eeb358122cbe..95a7a0df6cac 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -5,13 +5,4 @@
 
 menu "Counters"
 
-config STM32_LPTIMER_CNT
-	tristate "STM32 LP Timer encoder counter driver"
-	depends on MFD_STM32_LPTIMER || COMPILE_TEST
-	help
-	  Select this option to enable STM32 Low-Power Timer quadrature encoder
-	  and counter driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called stm32-lptimer-cnt.
 endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 93933ba49280..8fd3d954775a 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -3,5 +3,3 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-
-obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
deleted file mode 100644
index 42fb8ba67090..000000000000
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ /dev/null
@@ -1,382 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * STM32 Low-Power Timer Encoder and Counter driver
- *
- * Copyright (C) STMicroelectronics 2017
- *
- * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
- *
- * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
- *
- */
-
-#include <linux/bitfield.h>
-#include <linux/iio/iio.h>
-#include <linux/mfd/stm32-lptimer.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-struct stm32_lptim_cnt {
-	struct device *dev;
-	struct regmap *regmap;
-	struct clk *clk;
-	u32 preset;
-	u32 polarity;
-	u32 quadrature_mode;
-};
-
-static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
-{
-	u32 val;
-	int ret;
-
-	ret = regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
-	if (ret)
-		return ret;
-
-	return FIELD_GET(STM32_LPTIM_ENABLE, val);
-}
-
-static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
-					int enable)
-{
-	int ret;
-	u32 val;
-
-	val = FIELD_PREP(STM32_LPTIM_ENABLE, enable);
-	ret = regmap_write(priv->regmap, STM32_LPTIM_CR, val);
-	if (ret)
-		return ret;
-
-	if (!enable) {
-		clk_disable(priv->clk);
-		return 0;
-	}
-
-	/* LP timer must be enabled before writing CMP & ARR */
-	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->preset);
-	if (ret)
-		return ret;
-
-	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
-	if (ret)
-		return ret;
-
-	/* ensure CMP & ARR registers are properly written */
-	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
-				       (val & STM32_LPTIM_CMPOK_ARROK),
-				       100, 1000);
-	if (ret)
-		return ret;
-
-	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-			   STM32_LPTIM_CMPOKCF_ARROKCF);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(priv->clk);
-	if (ret) {
-		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
-		return ret;
-	}
-
-	/* Start LP timer in continuous mode */
-	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
-				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
-}
-
-static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
-{
-	u32 mask = STM32_LPTIM_ENC | STM32_LPTIM_COUNTMODE |
-		   STM32_LPTIM_CKPOL | STM32_LPTIM_PRESC;
-	u32 val;
-
-	/* Setup LP timer encoder/counter and polarity, without prescaler */
-	if (priv->quadrature_mode)
-		val = enable ? STM32_LPTIM_ENC : 0;
-	else
-		val = enable ? STM32_LPTIM_COUNTMODE : 0;
-	val |= FIELD_PREP(STM32_LPTIM_CKPOL, enable ? priv->polarity : 0);
-
-	return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
-}
-
-static int stm32_lptim_write_raw(struct iio_dev *indio_dev,
-				 struct iio_chan_spec const *chan,
-				 int val, int val2, long mask)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_ENABLE:
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		/* Check nobody uses the timer, or already disabled/enabled */
-		ret = stm32_lptim_is_enabled(priv);
-		if ((ret < 0) || (!ret && !val))
-			return ret;
-		if (val && ret)
-			return -EBUSY;
-
-		ret = stm32_lptim_setup(priv, val);
-		if (ret)
-			return ret;
-		return stm32_lptim_set_enable_state(priv, val);
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-	u32 dat;
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &dat);
-		if (ret)
-			return ret;
-		*val = dat;
-		return IIO_VAL_INT;
-
-	case IIO_CHAN_INFO_ENABLE:
-		ret = stm32_lptim_is_enabled(priv);
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return IIO_VAL_INT;
-
-	case IIO_CHAN_INFO_SCALE:
-		/* Non-quadrature mode: scale = 1 */
-		*val = 1;
-		*val2 = 0;
-		if (priv->quadrature_mode) {
-			/*
-			 * Quadrature encoder mode:
-			 * - both edges, quarter cycle, scale is 0.25
-			 * - either rising/falling edge scale is 0.5
-			 */
-			if (priv->polarity > 1)
-				*val2 = 2;
-			else
-				*val2 = 1;
-		}
-		return IIO_VAL_FRACTIONAL_LOG2;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_info stm32_lptim_cnt_iio_info = {
-	.read_raw = stm32_lptim_read_raw,
-	.write_raw = stm32_lptim_write_raw,
-};
-
-static const char *const stm32_lptim_quadrature_modes[] = {
-	"non-quadrature",
-	"quadrature",
-};
-
-static int stm32_lptim_get_quadrature_mode(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *chan)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return priv->quadrature_mode;
-}
-
-static int stm32_lptim_set_quadrature_mode(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *chan,
-					   unsigned int type)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	priv->quadrature_mode = type;
-
-	return 0;
-}
-
-static const struct iio_enum stm32_lptim_quadrature_mode_en = {
-	.items = stm32_lptim_quadrature_modes,
-	.num_items = ARRAY_SIZE(stm32_lptim_quadrature_modes),
-	.get = stm32_lptim_get_quadrature_mode,
-	.set = stm32_lptim_set_quadrature_mode,
-};
-
-static const char * const stm32_lptim_cnt_polarity[] = {
-	"rising-edge", "falling-edge", "both-edges",
-};
-
-static int stm32_lptim_cnt_get_polarity(struct iio_dev *indio_dev,
-					const struct iio_chan_spec *chan)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return priv->polarity;
-}
-
-static int stm32_lptim_cnt_set_polarity(struct iio_dev *indio_dev,
-					const struct iio_chan_spec *chan,
-					unsigned int type)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	priv->polarity = type;
-
-	return 0;
-}
-
-static const struct iio_enum stm32_lptim_cnt_polarity_en = {
-	.items = stm32_lptim_cnt_polarity,
-	.num_items = ARRAY_SIZE(stm32_lptim_cnt_polarity),
-	.get = stm32_lptim_cnt_get_polarity,
-	.set = stm32_lptim_cnt_set_polarity,
-};
-
-static ssize_t stm32_lptim_cnt_get_preset(struct iio_dev *indio_dev,
-					  uintptr_t private,
-					  const struct iio_chan_spec *chan,
-					  char *buf)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset);
-}
-
-static ssize_t stm32_lptim_cnt_set_preset(struct iio_dev *indio_dev,
-					  uintptr_t private,
-					  const struct iio_chan_spec *chan,
-					  const char *buf, size_t len)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-	int ret;
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	ret = kstrtouint(buf, 0, &priv->preset);
-	if (ret)
-		return ret;
-
-	if (priv->preset > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
-
-	return len;
-}
-
-/* LP timer with encoder */
-static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset,
-		.write = stm32_lptim_cnt_set_preset,
-	},
-	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM("quadrature_mode", IIO_SEPARATE,
-		 &stm32_lptim_quadrature_mode_en),
-	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_lptim_quadrature_mode_en),
-	{}
-};
-
-static const struct iio_chan_spec stm32_lptim_enc_channels = {
-	.type = IIO_COUNT,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_ENABLE) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.ext_info = stm32_lptim_enc_ext_info,
-	.indexed = 1,
-};
-
-/* LP timer without encoder (counter only) */
-static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset,
-		.write = stm32_lptim_cnt_set_preset,
-	},
-	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
-	{}
-};
-
-static const struct iio_chan_spec stm32_lptim_cnt_channels = {
-	.type = IIO_COUNT,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_ENABLE) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.ext_info = stm32_lptim_cnt_ext_info,
-	.indexed = 1,
-};
-
-static int stm32_lptim_cnt_probe(struct platform_device *pdev)
-{
-	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
-	struct stm32_lptim_cnt *priv;
-	struct iio_dev *indio_dev;
-
-	if (IS_ERR_OR_NULL(ddata))
-		return -EINVAL;
-
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	priv = iio_priv(indio_dev);
-	priv->dev = &pdev->dev;
-	priv->regmap = ddata->regmap;
-	priv->clk = ddata->clk;
-	priv->preset = STM32_LPTIM_MAX_ARR;
-
-	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = &pdev->dev;
-	indio_dev->dev.of_node = pdev->dev.of_node;
-	indio_dev->info = &stm32_lptim_cnt_iio_info;
-	if (ddata->has_encoder)
-		indio_dev->channels = &stm32_lptim_enc_channels;
-	else
-		indio_dev->channels = &stm32_lptim_cnt_channels;
-	indio_dev->num_channels = 1;
-
-	platform_set_drvdata(pdev, priv);
-
-	return devm_iio_device_register(&pdev->dev, indio_dev);
-}
-
-static const struct of_device_id stm32_lptim_cnt_of_match[] = {
-	{ .compatible = "st,stm32-lptimer-counter", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, stm32_lptim_cnt_of_match);
-
-static struct platform_driver stm32_lptim_cnt_driver = {
-	.probe = stm32_lptim_cnt_probe,
-	.driver = {
-		.name = "stm32-lptimer-counter",
-		.of_match_table = stm32_lptim_cnt_of_match,
-	},
-};
-module_platform_driver(stm32_lptim_cnt_driver);
-
-MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
-MODULE_ALIAS("platform:stm32-lptimer-counter");
-MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
-MODULE_LICENSE("GPL v2");
-- 
2.17.0
