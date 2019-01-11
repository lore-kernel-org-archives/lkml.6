Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623F52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HCjYH0E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfAKIXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:23:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42472 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfAKIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:23:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so6618902pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aUvpG6n9TjP6tya9JgTQ9MYcu5Ui/xdKtxpJsxUg8g=;
        b=HCjYH0E0CtR96Ikw3OrV6Gpe0rpqWrVpH97YfesNtf0hQGrkXXpRZV9o8xPW2XfCk9
         YYGduzvAc+s3i8v/+EDe+vSdkMLpyCUhssdSGvTcIzlSexS5XlHCDzqOwOUNiop7fUbC
         ONJ6wy90b8y/VJQ4aHdSqWMtqw6WtLrwl9iwp1YMWe9hk9DuC1WhyghsWCBSaW1g+WQ3
         fJ9Y7kDWV775ugVEgoRnjqglba7UgS1IoltXK7dDb/9Sf0YKnNQtTGPCdEFBkvhAr117
         rAH9+eK/Ms4mfJ83W9oyQ3ZJK8308Xz2Cufe20vJWHTzrfHrko9Bc/JcKOCy7RRQvnLC
         YrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9aUvpG6n9TjP6tya9JgTQ9MYcu5Ui/xdKtxpJsxUg8g=;
        b=WP/uJ49RuC5CK854xewISkMD+jJho/p6mZcCdYvNpWZxKa8xQuWML96Um5lZod0jwH
         DbLdapnq+0iUrxlq/zU1QaERa/R/AdJCGh2GFIraZJBJ3ILr8L/JlHPwb5BK7fdFrxfU
         GMhqKrnPLO+XCf7LyVS7rHcP0yaDTjxO+bbs9KdZN66vHvd6K4Cl3MTwKY2phPLs8u0Q
         cZEtWX8mJIYzpX4yHjt1o8/NbUCDS33sI1vcY83Pnpa9iIEMrQplsF96MHc3pgabO85b
         pk7I2d+K/Nzk9+a4P7jnyE+nRvIz4Qr5LR+IdHgBkYEN6Yl98y2anmuY31RGp0iHn3H8
         GUCw==
X-Gm-Message-State: AJcUukdMopuzyqzK4CnGr16GaR0TaEZQdp6mOH/AkB93DrCao8NfldcD
        a3peBn1PD9BDR7fGcQZvJ+qmRg==
X-Google-Smtp-Source: ALg8bN53HnJQn6VEgBpCvlqWtm6b9nPzJh7O8KAL1iIGXyxJtTNtOqLFRpNj4NfUkyjGDWhya3fXmw==
X-Received: by 2002:a63:7418:: with SMTP id p24mr2432727pgc.196.1547194989900;
        Fri, 11 Jan 2019 00:23:09 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t87sm248422324pfk.122.2019.01.11.00.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 00:23:09 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date:   Fri, 11 Jan 2019 13:52:44 +0530
Message-Id: <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Various fixes and code cleanup]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/pwm/pwm-sifive.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..3bcaf6a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -380,6 +380,16 @@ config PWM_SAMSUNG
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-samsung.
 
+config PWM_SIFIVE
+	tristate "SiFive PWM support"
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for SiFive SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sifive.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0..30089ca 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
new file mode 100644
index 0000000..7fee809
--- /dev/null
+++ b/drivers/pwm/pwm-sifive.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2018 SiFive
+ * For SiFive's PWM IP block documentation please refer Chapter 14 of
+ * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+/* Register offsets */
+#define REG_PWMCFG		0x0
+#define REG_PWMCOUNT		0x8
+#define REG_PWMS		0x10
+#define REG_PWMCMP0		0x20
+
+/* PWMCFG fields */
+#define BIT_PWM_SCALE		0
+#define BIT_PWM_STICKY		8
+#define BIT_PWM_ZERO_ZMP	9
+#define BIT_PWM_DEGLITCH	10
+#define BIT_PWM_EN_ALWAYS	12
+#define BIT_PWM_EN_ONCE		13
+#define BIT_PWM0_CENTER		16
+#define BIT_PWM0_GANG		24
+#define BIT_PWM0_IP		28
+
+#define SIZE_PWMCMP		4
+#define MASK_PWM_SCALE		0xf
+
+struct sifive_pwm_device {
+	struct pwm_chip	chip;
+	struct notifier_block notifier;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int approx_period;
+	unsigned int real_period;
+};
+
+static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_chip *c)
+{
+	return container_of(c, struct sifive_pwm_device, chip);
+}
+
+static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_device *dev,
+				 struct pwm_state *state)
+{
+	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
+	u32 duty;
+
+	duty = readl(pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
+
+	state->period = pwm->real_period;
+	state->duty_cycle = ((u64)duty * pwm->real_period) >> 16;
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = duty > 0;
+}
+
+static int sifive_pwm_apply(struct pwm_chip *chip, struct pwm_device *dev,
+			    struct pwm_state *state)
+{
+	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
+	unsigned int duty_cycle;
+	u32 frac;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+
+	frac = div_u64((u64)duty_cycle << 16, state->period);
+	frac = min(frac, 0xFFFFU);
+
+	writel(frac, pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
+
+	if (state->enabled)
+		sifive_pwm_get_state(chip, dev, state);
+
+	return 0;
+}
+
+static const struct pwm_ops sifive_pwm_ops = {
+	.get_state = sifive_pwm_get_state,
+	.apply = sifive_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static struct pwm_device *sifive_pwm_xlate(struct pwm_chip *chip,
+					   const struct of_phandle_args *args)
+{
+	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
+	struct pwm_device *dev;
+
+	if (args->args[0] >= chip->npwm)
+		return ERR_PTR(-EINVAL);
+
+	dev = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(dev))
+		return dev;
+
+	/* The period cannot be changed on a per-PWM basis */
+	dev->args.period = pwm->real_period;
+	dev->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args[1] & PWM_POLARITY_INVERSED)
+		dev->args.polarity = PWM_POLARITY_INVERSED;
+
+	return dev;
+}
+
+static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
+				    unsigned long rate)
+{
+	/* (1 << (16+scale)) * 10^9/rate = real_period */
+	unsigned long scale_pow = (pwm->approx_period * (u64)rate) / 1000000000;
+	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);
+
+	writel((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
+	       pwm->regs + REG_PWMCFG);
+
+	/* As scale <= 15 the shift operation cannot overflow. */
+	pwm->real_period = div64_ul(1000000000ULL << (16 + scale), rate);
+	dev_dbg(pwm->chip.dev, "New real_period = %u ns\n", pwm->real_period);
+}
+
+static int sifive_pwm_clock_notifier(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct sifive_pwm_device *pwm =
+		container_of(nb, struct sifive_pwm_device, notifier);
+
+	if (event == POST_RATE_CHANGE)
+		sifive_pwm_update_clock(pwm, ndata->new_rate);
+
+	return NOTIFY_OK;
+}
+
+static int sifive_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct sifive_pwm_device *pwm;
+	struct pwm_chip *chip;
+	struct resource *res;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	chip = &pwm->chip;
+	chip->dev = dev;
+	chip->ops = &sifive_pwm_ops;
+	chip->of_xlate = sifive_pwm_xlate;
+	chip->of_pwm_n_cells = 2;
+	chip->base = -1;
+	chip->npwm = 4;
+
+	ret = of_property_read_u32(node, "sifive,approx-period-ns",
+				   &pwm->approx_period);
+	if (ret < 0) {
+		dev_err(dev, "Unable to read sifive,approx-period from DTS\n");
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pwm->regs)) {
+		dev_err(dev, "Unable to map IO resources\n");
+		return PTR_ERR(pwm->regs);
+	}
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk)) {
+		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Unable to find controller clock\n");
+		return PTR_ERR(pwm->clk);
+	}
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
+		return ret;
+	}
+
+	/* Watch for changes to underlying clock frequency */
+	pwm->notifier.notifier_call = sifive_pwm_clock_notifier;
+	ret = clk_notifier_register(pwm->clk, &pwm->notifier);
+	if (ret) {
+		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	/* Initialize PWM config */
+	sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		clk_notifier_unregister(pwm->clk, &pwm->notifier);
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
+
+	return 0;
+}
+
+static int sifive_pwm_remove(struct platform_device *dev)
+{
+	struct sifive_pwm_device *pwm = platform_get_drvdata(dev);
+	int ret;
+
+	ret = pwmchip_remove(&pwm->chip);
+	clk_notifier_unregister(pwm->clk, &pwm->notifier);
+	clk_disable_unprepare(pwm->clk);
+	return ret;
+}
+
+static const struct of_device_id sifive_pwm_of_match[] = {
+	{ .compatible = "sifive,pwm0" },
+	{ .compatible = "sifive,fu540-c000-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sifive_pwm_of_match);
+
+static struct platform_driver sifive_pwm_driver = {
+	.probe = sifive_pwm_probe,
+	.remove = sifive_pwm_remove,
+	.driver = {
+		.name = "pwm-sifive",
+		.of_match_table = sifive_pwm_of_match,
+	},
+};
+module_platform_driver(sifive_pwm_driver);
+
+MODULE_DESCRIPTION("SiFive PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

