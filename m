Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B77FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F79D20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9TzMsvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeKZDOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:14:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45500 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeKZDOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:14:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4994396pgc.12;
        Sun, 25 Nov 2018 08:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l5cyqGj3FK1HXmO4T0ciMbIqltxYRJ3GO4Qb3G/D5NA=;
        b=s9TzMsvzKX4wXUJ9KjmBxi2+wonhTcbTfdtkJ3x8Piuk2hZrDR/vjJXWZzZRQgwSYM
         fjW3fCTCIO3BnAbb7zX8PCkmEKG3RbqPHYotgYJUfjiLy0jnwFvfraji0oSbfXU+Jprw
         +sSjgqkwukFh1LeUA1nF07BU0D04nnWFOnR5daCUl5nrip4S5VS1Tp2bTiJNkvSgLKaZ
         fDEjAK4s+sOlevOV/lr2dtupHnXnWekZ7HN5AwbHoEyCkvXNNHA3A43jI9cn4ImY4kWf
         9zIu77+dOQAK8xuBg7H8r7INhZ8LmziWfMzmJsInWYdoR3WhbQ0zMrK8Y92sFoybrZuI
         KvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l5cyqGj3FK1HXmO4T0ciMbIqltxYRJ3GO4Qb3G/D5NA=;
        b=YV+iUQc0oZS4i8e4pqXX3LqyjT+3lRGgUTWDpwYMfTIVa36ojQKH7/6AhNZH9uAq7a
         hhQ0PoSLhyxf2t4qC9vqOvmwiyxusZl2QVES163g8VoQEoSPOReKeYHKiXAylb9Z/o75
         D/J7MhuDeW1tuFxEAoBl2M6++iDbR4dzvsgwZvxSVZRHypT8lzEXXaGEcY/Q8Hdtgo1U
         SdtBxofqXx4bwFtzCQkS8vYS8bQxG5SHHdH7YuCNsQfTohtSoZcDLN/lgkOUxoTOKcO9
         f8sBBQ8TvK9FZecKbmusEBA217eHFtRLE8ROSIvlRFxuOo5JvxxHWtAEk+scNu46V1Hk
         Ilig==
X-Gm-Message-State: AA+aEWZnScNbfO0JvO7i7qsStPvU0J1/I/65tdqtcnO1ZeEHRdoecX93
        QpOook9e1md5nUlStWQOQRw=
X-Google-Smtp-Source: AFSGD/UrQbQzdy6FVMawuvQfX7Ymm6IW6ELYdTt7I4USIidy36aUP84eZFHyKXIENd6SiWkmI4hcHA==
X-Received: by 2002:a63:8441:: with SMTP id k62mr21287276pgd.392.1543163006087;
        Sun, 25 Nov 2018 08:23:26 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id y12sm14444309pfk.70.2018.11.25.08.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:23:25 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:23:19 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM support.
Message-ID: <20181125162319.GA5422@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
each PWM pair built-in 1 clock module, 2 timer logic module and 1
programmable dead-time generator, it also support waveform capture.
It has 2 clock sources OSC24M and APB1, it is different with the
sun4i-pwm driver, Therefore add a new driver for it.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/pwm/Kconfig     |  12 +-
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-sun8i.c | 418 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-sun8i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252..6105ac8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -426,7 +426,7 @@ config PWM_STMPE
 	  expanders.
 
 config PWM_SUN4I
-	tristate "Allwinner PWM support"
+	tristate "Allwinner SUN4I PWM support"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on HAS_IOMEM && COMMON_CLK
 	help
@@ -435,6 +435,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN8I
+	tristate "Allwinner SUN8I (R40/V40/T3) PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner R40/V40/T3 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun8i.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0..32c8d2d 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN8I)		+= pwm-sun8i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
new file mode 100644
index 0000000..d8597e4
--- /dev/null
+++ b/drivers/pwm/pwm-sun8i.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/regmap.h>
+
+#define PWM_IRQ_ENABLE_REG	0x0000
+#define PCIE(ch)		BIT(ch)
+
+#define PWM_IRQ_STATUS_REG	0x0004
+#define PIS(ch)			BIT(ch)
+
+#define CAPTURE_IRQ_ENABLE_REG	0x0010
+#define CRIE(ch)		BIT((ch) * 2)
+#define CFIE(ch)		BIT((ch) * 2 + 1)
+
+#define CAPTURE_IRQ_STATUS_REG	0x0014
+#define CRIS(ch)		BIT((ch) * 2)
+#define CFIS(ch)		BIT((ch) * 2 + 1)
+
+#define CLK_CFG_REG(ch)		(0x0020 + ((ch) >> 1) * 4)
+#define CLK_SRC_SEL		GENMASK(8, 7)
+#define CLK_SRC_BYPASS_SEC	BIT(6)
+#define CLK_SRC_BYPASS_FIR	BIT(5)
+#define CLK_GATING		BIT(4)
+#define CLK_DIV_M		GENMASK(3, 0)
+
+#define PWM_DZ_CTR_REG(ch)	(0x0030 + ((ch) >> 1) * 4)
+#define PWM_DZ_INTV		GENMASK(15, 8)
+#define PWM_DZ_EN		BIT(0)
+
+#define PWM_ENABLE_REG		0x0040
+#define PWM_EN(ch)		BIT(ch)
+
+#define CAPTURE_ENABLE_REG	0x0044
+#define CAP_EN(ch)		BIT(ch)
+
+#define PWM_CTR_REG(ch)		(0x0060 + (ch) * 0x20)
+#define PWM_PERIOD_RDY		BIT(11)
+#define PWM_PUL_START		BIT(10)
+#define PWM_MODE		BIT(9)
+#define PWM_ACT_STA		BIT(8)
+#define PWM_PRESCAL_K		GENMASK(7, 0)
+
+#define PWM_PERIOD_REG(ch)	(0x0064 + (ch) * 0x20)
+#define PWM_ENTIRE_CYCLE	GENMASK(31, 16)
+#define PWM_ACT_CYCLE		GENMASK(15, 0)
+
+#define PWM_CNT_REG(ch)		(0x0068 + (ch) * 0x20)
+#define PWM_CNT_VAL		GENMASK(15, 0)
+
+#define CAPTURE_CTR_REG(ch)	(0x006c + (ch) * 0x20)
+#define CAPTURE_CRLF		BIT(2)
+#define CAPTURE_CFLF		BIT(1)
+#define CAPINV			BIT(0)
+
+#define CAPTURE_RISE_REG(ch)	(0x0070 + (ch) * 0x20)
+#define CAPTURE_CRLR		GENMASK(15, 0)
+
+#define CAPTURE_FALL_REG(ch)	(0x0074 + (ch) * 0x20)
+#define CAPTURE_CFLR		GENMASK(15, 0)
+
+struct sun8i_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	const struct sun8i_pwm_data *data;
+	struct regmap *regmap;
+};
+
+static struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun8i_pwm_chip, chip);
+}
+
+static u32 sun8i_pwm_read(struct sun8i_pwm_chip *sun8i_pwm,
+			  unsigned long offset)
+{
+	u32 val;
+
+	regmap_read(sun8i_pwm->regmap, offset, &val);
+	return val;
+}
+
+static void sun8i_pwm_set_bit(struct sun8i_pwm_chip *sun8i_pwm,
+			      unsigned long reg, u32 bit)
+{
+	regmap_update_bits(sun8i_pwm->regmap, reg, bit, bit);
+}
+
+static void sun8i_pwm_clear_bit(struct sun8i_pwm_chip *sun8i_pwm,
+				unsigned long reg, u32 bit)
+{
+	regmap_update_bits(sun8i_pwm->regmap, reg, bit, 0);
+}
+
+static void sun8i_pwm_set_value(struct sun8i_pwm_chip *sun8i_pwm,
+				unsigned long reg, u32 mask, u32 val)
+{
+	regmap_update_bits(sun8i_pwm->regmap, reg, mask, val);
+}
+
+static void sun8i_pwm_set_polarity(struct sun8i_pwm_chip *chip, u32 ch,
+				   enum pwm_polarity polarity)
+{
+	if (polarity == PWM_POLARITY_NORMAL)
+		sun8i_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
+	else
+		sun8i_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
+}
+
+static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
+			    struct pwm_state *state)
+{
+	u64 clk_rate, clk_div, val;
+	u16 prescaler = 0;
+	u16 div_id = 0;
+	struct clk *clk;
+	bool is_clk;
+	int ret;
+
+	clk_rate = clk_get_rate(sun8i_pwm->clk);
+
+	/* check period and select clock source */
+	val = state->period * clk_rate;
+	do_div(val, NSEC_PER_SEC);
+	is_clk = devm_clk_name_match(sun8i_pwm->clk, "mux-0");
+	if (val <= 1 && is_clk) {
+		clk = devm_clk_get(sun8i_pwm->chip.dev, "mux-1");
+		if (IS_ERR(clk)) {
+			dev_err(sun8i_pwm->chip.dev,
+				"Period expects a larger value\n");
+			return -EINVAL;
+		}
+
+		clk_rate = clk_get_rate(clk);
+		val = state->period * clk_rate;
+		do_div(val, NSEC_PER_SEC);
+		if (val <= 1) {
+			dev_err(sun8i_pwm->chip.dev,
+				"Period expects a larger value\n");
+			return -EINVAL;
+		}
+
+		/* change clock source to "mux-1" */
+		clk_disable_unprepare(sun8i_pwm->clk);
+		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
+		sun8i_pwm->clk = clk;
+
+		ret = clk_prepare_enable(sun8i_pwm->clk);
+		if (ret) {
+			dev_err(sun8i_pwm->chip.dev,
+				"Failed to enable PWM clock\n");
+			return ret;
+		}
+
+	} else {
+		dev_err(sun8i_pwm->chip.dev,
+			"Period expects a larger value\n");
+		return -EINVAL;
+	}
+
+	is_clk = devm_clk_name_match(sun8i_pwm->clk, "mux-0");
+	if (is_clk)
+		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
+				    CLK_SRC_SEL, 0 << 7);
+	else
+		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
+				    CLK_SRC_SEL, 1 << 7);
+
+	dev_info(sun8i_pwm->chip.dev, "clock source freq:%lldHz\n", clk_rate);
+
+	/* calculate and set prescaler, div table, PWM entire cycle */
+	clk_div = val;
+	while (clk_div > 65535) {
+		prescaler++;
+		clk_div = val;
+		do_div(clk_div, 1U << div_id);
+		do_div(clk_div, prescaler + 1);
+
+		if (prescaler == 255) {
+			prescaler = 0;
+			div_id++;
+			if (div_id == 9) {
+				dev_err(sun8i_pwm->chip.dev,
+					"unsupport period value\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
+			    PWM_ENTIRE_CYCLE, clk_div << 16);
+	sun8i_pwm_set_value(sun8i_pwm, PWM_CTR_REG(ch),
+			    PWM_PRESCAL_K, prescaler << 0);
+	sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
+			    CLK_DIV_M, div_id << 0);
+
+	/* set duty cycle */
+	val = state->period;
+	do_div(val, clk_div);
+	clk_div = state->duty_cycle;
+	do_div(clk_div, val);
+	if (clk_div > 65535)
+		clk_div = 65535;
+
+	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
+			    PWM_ACT_CYCLE, clk_div << 0);
+
+	return 0;
+}
+
+static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	int ret;
+	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
+	struct pwm_state cstate;
+
+	pwm_get_state(pwm, &cstate);
+	if (!cstate.enabled) {
+		ret = clk_prepare_enable(sun8i_pwm->clk);
+		if (ret) {
+			dev_err(chip->dev, "Failed to enable PWM clock\n");
+			return ret;
+		}
+	}
+
+	if ((cstate.period != state->period) ||
+	    (cstate.duty_cycle != state->duty_cycle)) {
+		ret = sun8i_pwm_config(sun8i_pwm, pwm->hwpwm, state);
+		if (ret) {
+			dev_err(chip->dev, "Failed to config PWM\n");
+			return ret;
+		}
+	}
+
+	if (state->polarity != cstate.polarity)
+		sun8i_pwm_set_polarity(sun8i_pwm, pwm->hwpwm, state->polarity);
+
+	if (state->enabled) {
+		sun8i_pwm_set_bit(sun8i_pwm,
+				  CLK_CFG_REG(pwm->hwpwm), CLK_GATING);
+
+		sun8i_pwm_set_bit(sun8i_pwm,
+				  PWM_ENABLE_REG, PWM_EN(pwm->hwpwm));
+	} else {
+		sun8i_pwm_clear_bit(sun8i_pwm,
+				    CLK_CFG_REG(pwm->hwpwm), CLK_GATING);
+
+		sun8i_pwm_clear_bit(sun8i_pwm,
+				    PWM_ENABLE_REG, PWM_EN(pwm->hwpwm));
+	}
+
+	return 0;
+}
+
+static void sun8i_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
+	u64 clk_rate, tmp;
+	u32 val;
+	u16 clk_div, act_cycle;
+	u8 prescal, div_id;
+	u8 chn = pwm->hwpwm;
+
+	clk_rate = clk_get_rate(sun8i_pwm->clk);
+
+	val = sun8i_pwm_read(sun8i_pwm, PWM_CTR_REG(chn));
+	if (PWM_ACT_STA & val)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	prescal = PWM_PRESCAL_K & val;
+
+	val = sun8i_pwm_read(sun8i_pwm, PWM_ENABLE_REG);
+	if (PWM_EN(chn) & val)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	val = sun8i_pwm_read(sun8i_pwm, PWM_PERIOD_REG(chn));
+	act_cycle = PWM_ACT_CYCLE & val;
+	clk_div = val >> 16;
+
+	val = sun8i_pwm_read(sun8i_pwm, CLK_CFG_REG(chn));
+	div_id = CLK_DIV_M & val;
+
+	tmp = act_cycle * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+	tmp = clk_div * prescal * (1U << div_id) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+}
+
+static const struct regmap_config sun8i_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = CAPTURE_FALL_REG(7),
+};
+
+static const struct pwm_ops sun8i_pwm_ops = {
+	.apply = sun8i_pwm_apply,
+	.get_state = sun8i_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id sun8i_pwm_dt_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-r40-pwm",
+		.data = NULL,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
+
+static int sun8i_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sun8i_pwm_chip *pwm;
+	struct resource *res;
+	int ret;
+	const struct of_device_id *match;
+
+	match = of_match_device(sun8i_pwm_dt_ids, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm->base))
+		return PTR_ERR(pwm->base);
+
+	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, pwm->base,
+					    &sun8i_pwm_regmap_config);
+	if (IS_ERR(pwm->regmap)) {
+		dev_err(&pdev->dev, "Failed to create regmap\n");
+		return PTR_ERR(pwm->regmap);
+	}
+
+	/* we use mux-0 as default clock source */
+	pwm->clk = devm_clk_get(&pdev->dev, "mux-0");
+	if (IS_ERR(pwm->clk)) {
+		pwm->clk = devm_clk_get(&pdev->dev, "mux-1");
+		if (IS_ERR(pwm->clk)) {
+			dev_err(&pdev->dev, "Failed to get PWM clock\n");
+			return PTR_ERR(pwm->clk);
+		}
+	}
+
+	ret = of_property_read_u32(np, "pwm-channels", &pwm->chip.npwm);
+	if (ret && !pwm->chip.npwm) {
+		dev_err(&pdev->dev, "Can't get pwm-channels\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "pwm-channels:%d\n", pwm->chip.npwm);
+	pwm->data = match->data;
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &sun8i_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int sun8i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun8i_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pwm->clk);
+	return pwmchip_remove(&pwm->chip);
+}
+
+static struct platform_driver sun8i_pwm_driver = {
+	.driver = {
+		.name = "sun8i-pwm",
+		.of_match_table = sun8i_pwm_dt_ids,
+	},
+	.probe = sun8i_pwm_probe,
+	.remove = sun8i_pwm_remove,
+};
+module_platform_driver(sun8i_pwm_driver);
+
+MODULE_ALIAS("platform: sun8i-pwm");
+MODULE_AUTHOR("Hao Zhang <hao5781286@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

