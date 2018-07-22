Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365DB20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBKPAsUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365DB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeGVXuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:50:10 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43862 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGVXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:50:10 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so6590059ybl.10;
        Sun, 22 Jul 2018 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ps8UkEdp+xS8fWqxthftQKvTO2Z0IHP5Yvkv4JrQLU0=;
        b=QBKPAsUJlwHLTi7gHoUdceCKbj6U2T6Orudb0Cxx61A5o/74wZ23el+7s0dV99N/C8
         qHC2Ukxke1Pj5OGuFSf+qsB8oBBDSVVCat7P0FJY07/cCBXoFxdjyvTWo3gKMKWCYtZB
         PrP6wsizAi4LJgTujHrvnu004rUV+gnqNmL9KXMDrT88gpjSKp7wKtuM4dARQqz/R1Td
         FChGibuHvv3bFg++smLL7vby1CXQcYJpGRaVSHY4L0mY7XrEjQ/qOfeU26My8YbC+LJ8
         dxw1X2X6k2EmtEnvWKjYGCSOigCs0X8eYCPU8T/IsGFAaiqOCGkOeMUXC+9HHmIbOotJ
         5W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ps8UkEdp+xS8fWqxthftQKvTO2Z0IHP5Yvkv4JrQLU0=;
        b=s6NwaLQaE0xpBWXfO7KY/SuMwBfJ7PrSaAy1vWmbtQEtr33eR/jzl0KdHzZ3+E6m9e
         XIMjseeb/llUL3S/gLKtr0BfSne2CAb5IxYuvP+Etfol6mSl9M26mWg89inzpDiii0zS
         LwifG67c289FRtoVi5sRrmRR3S2xIxaOGZ0xzDvRl7OZHZBLlhs7c7puAXM7d5za4Loy
         kaEYxAqOjfcE1KtlA8lnS+pMgF9QREGx4qQ86uo1AA/qvrGnPEuqTBZNNh9koyDfDmJm
         M+RQtXZwP5NTdwiaDoU6KLkwv6w9tGOpgNA7fCYrOd+6HZgWzCvJc206heVpvEsDXVJ1
         2nbg==
X-Gm-Message-State: AOUpUlHCJEingiT+XPEU+yx6b6++3fO36DlAgRQzKMBrFI2gbdPecMte
        fbUnLh8HKcgsntzwkQJtPGs=
X-Google-Smtp-Source: AAOMgpd0cW+TJQenr5puZhZUcef+CCoZbolGgP2Q2eDuoj/0jH7TXVuckEI3jtRTKi9tfvx5MiqKJA==
X-Received: by 2002:a25:9086:: with SMTP id t6-v6mr5863313ybl.393.1532299910690;
        Sun, 22 Jul 2018 15:51:50 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id 203-v6sm3818824ywv.34.2018.07.22.15.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:51:50 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 09/11] counter: stm32-lptimer: add counter device
Date:   Sun, 22 Jul 2018 18:51:45 -0400
Message-Id: <b4b566a2ea3d01b12a6c1f52c1efaf555416471e.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add support for new counter device to stm32-lptimer.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |   1 +
 drivers/{iio => }/counter/stm32-lptimer-cnt.c | 361 ++++++++++++++++--
 drivers/iio/Kconfig                           |   1 -
 drivers/iio/Makefile                          |   1 -
 drivers/iio/counter/Kconfig                   |  17 -
 drivers/iio/counter/Makefile                  |   7 -
 7 files changed, 350 insertions(+), 48 deletions(-)
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
 delete mode 100644 drivers/iio/counter/Kconfig
 delete mode 100644 drivers/iio/counter/Makefile

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 0bb2340d6087..87c491a19c63 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -38,4 +38,14 @@ config STM32_TIMER_CNT
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
index 6b4a5be21b00..5589976d37f8 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_COUNTER) += counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
+obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
similarity index 48%
rename from drivers/iio/counter/stm32-lptimer-cnt.c
rename to drivers/counter/stm32-lptimer-cnt.c
index 42fb8ba67090..95816296f625 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -11,16 +11,18 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/counter.h>
 #include <linux/iio/iio.h>
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
 struct stm32_lptim_cnt {
+	struct counter_device counter;
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
-	u32 preset;
+	u32 ceiling;
 	u32 polarity;
 	u32 quadrature_mode;
 };
@@ -54,7 +56,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 	}
 
 	/* LP timer must be enabled before writing CMP & ARR */
-	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->preset);
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->ceiling);
 	if (ret)
 		return ret;
 
@@ -247,44 +249,57 @@ static const struct iio_enum stm32_lptim_cnt_polarity_en = {
 	.set = stm32_lptim_cnt_set_polarity,
 };
 
-static ssize_t stm32_lptim_cnt_get_preset(struct iio_dev *indio_dev,
-					  uintptr_t private,
-					  const struct iio_chan_spec *chan,
-					  char *buf)
+static ssize_t stm32_lptim_cnt_get_ceiling(struct stm32_lptim_cnt *priv,
+					   char *buf)
 {
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset);
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
 }
 
-static ssize_t stm32_lptim_cnt_set_preset(struct iio_dev *indio_dev,
-					  uintptr_t private,
-					  const struct iio_chan_spec *chan,
-					  const char *buf, size_t len)
+static ssize_t stm32_lptim_cnt_set_ceiling(struct stm32_lptim_cnt *priv,
+					   const char *buf, size_t len)
 {
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
 	int ret;
 
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
 
-	ret = kstrtouint(buf, 0, &priv->preset);
+	ret = kstrtouint(buf, 0, &priv->ceiling);
 	if (ret)
 		return ret;
 
-	if (priv->preset > STM32_LPTIM_MAX_ARR)
+	if (priv->ceiling > STM32_LPTIM_MAX_ARR)
 		return -EINVAL;
 
 	return len;
 }
 
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
 /* LP timer with encoder */
 static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
 	{
 		.name = "preset",
 		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset,
-		.write = stm32_lptim_cnt_set_preset,
+		.read = stm32_lptim_cnt_get_preset_iio,
+		.write = stm32_lptim_cnt_set_preset_iio,
 	},
 	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
 	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
@@ -309,8 +324,8 @@ static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
 	{
 		.name = "preset",
 		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset,
-		.write = stm32_lptim_cnt_set_preset,
+		.read = stm32_lptim_cnt_get_preset_iio,
+		.write = stm32_lptim_cnt_set_preset_iio,
 	},
 	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
 	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
@@ -327,11 +342,293 @@ static const struct iio_chan_spec stm32_lptim_cnt_channels = {
 	.indexed = 1,
 };
 
+/**
+ * stm32_lptim_cnt_function - enumerates stm32 LPTimer counter & encoder modes
+ * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
+ * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
+ */
+enum stm32_lptim_cnt_function {
+	STM32_LPTIM_COUNTER_INCREASE,
+	STM32_LPTIM_ENCODER_BOTH_EDGE,
+};
+
+static enum counter_count_function stm32_lptim_cnt_functions[] = {
+	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
+	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+};
+
+enum stm32_lptim_synapse_action {
+	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
+	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
+	STM32_LPTIM_SYNAPSE_ACTION_NONE,
+};
+
+static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
+	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
+	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static int stm32_lptim_cnt_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_count_read_value *val)
+{
+	struct stm32_lptim_cnt *const priv = counter->priv;
+	u32 cnt;
+	int ret;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &cnt);
+	if (ret)
+		return ret;
+
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
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
+	if (priv->polarity == STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES) {
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
 static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_lptim_cnt *priv;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
@@ -344,8 +641,9 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->preset = STM32_LPTIM_MAX_ARR;
+	priv->ceiling = STM32_LPTIM_MAX_ARR;
 
+	/* Initialize IIO device */
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->dev.of_node = pdev->dev.of_node;
@@ -356,9 +654,28 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 		indio_dev->channels = &stm32_lptim_cnt_channels;
 	indio_dev->num_channels = 1;
 
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
 	platform_set_drvdata(pdev, priv);
 
-	return devm_iio_device_register(&pdev->dev, indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_counter_register(&pdev->dev, &priv->counter);
 }
 
 static const struct of_device_id stm32_lptim_cnt_of_match[] = {
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb41cd07..ac764840483a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -74,7 +74,6 @@ source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
-source "drivers/iio/counter/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/frequency/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb5993251381..bff682ad1cfb 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -20,7 +20,6 @@ obj-y += amplifiers/
 obj-y += buffer/
 obj-y += chemical/
 obj-y += common/
-obj-y += counter/
 obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
deleted file mode 100644
index eeb358122cbe..000000000000
--- a/drivers/iio/counter/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Counter devices
-#
-# When adding new entries keep the list in alphabetical order
-
-menu "Counters"
-
-config STM32_LPTIMER_CNT
-	tristate "STM32 LP Timer encoder counter driver"
-	depends on MFD_STM32_LPTIMER || COMPILE_TEST
-	help
-	  Select this option to enable STM32 Low-Power Timer quadrature encoder
-	  and counter driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called stm32-lptimer-cnt.
-endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
deleted file mode 100644
index 93933ba49280..000000000000
--- a/drivers/iio/counter/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for IIO counter devices
-#
-
-# When adding new entries keep the list in alphabetical order
-
-obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
-- 
2.18.0

