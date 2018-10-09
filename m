Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C5BECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j8zWq7Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233FE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJJCJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:09:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53214 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJJCJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539111088; x=1570647088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jYSy18F/N8laeC0OVGMn3FOciObDX877wWPhX25tco8=;
  b=j8zWq7Zu4eZMvO+FmV0lyRhGsasP8N1SxgtpJrcCBTL3kI3yVU5OcJjm
   KOA5HFvENxAlNppb9pXLIZ+2GPNgStasm3iglETPrieMDEGO/yjXY2v4k
   6OecdBCJuFwUfi6RHkj4Ze4dTwVfY9YiiYBMIsyEb1WoWXJ0vJ/1eXtlb
   rxptvel9HK+sUIe1Xz/vPNXyEgF9n3/HWNQaXWlk7B5YnZQ1C0u4YA9fD
   V//6b+YMJsIdBtSzaeFs6pF/VXdxefp1atjYMYEUeCjlbm5u+ELrpbIWg
   +MMDNQnC0a5CnDIoal1kBk30AzPr4Mp98SyPC686fhexXAomiieElPOQF
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,361,1534780800"; 
   d="scan'208";a="93263452"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 02:51:26 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Oct 2018 11:36:36 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2018 11:51:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org, atish.patra@wdc.com
Subject: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Date:   Tue,  9 Oct 2018 11:51:23 -0700
Message-Id: <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Various fixes and code cleanup]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sifive.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 drivers/pwm/pwm-sifive.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d2527..dd12144d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -378,6 +378,16 @@ config PWM_SAMSUNG
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
index 9c676a0d..30089ca6 100644
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
index 00000000..99580025
--- /dev/null
+++ b/drivers/pwm/pwm-sifive.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 SiFive
+ */
+#include <dt-bindings/pwm/pwm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#define MAX_PWM			4
+
+/* Register offsets */
+#define REG_PWMCFG		0x0
+#define REG_PWMCOUNT		0x8
+#define REG_PWMS		0x10
+#define	REG_PWMCMP0		0x20
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
+	struct pwm_chip		chip;
+	struct notifier_block	notifier;
+	struct clk		*clk;
+	void __iomem		*regs;
+	unsigned int		approx_period;
+	unsigned int		real_period;
+};
+
+static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_chip *c)
+{
+	return container_of(c, struct sifive_pwm_device, chip);
+}
+
+static int sifive_pwm_apply(struct pwm_chip *chip, struct pwm_device *dev,
+			    struct pwm_state *state)
+{
+	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
+	unsigned int duty_cycle;
+	u32 frac;
+
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		duty_cycle = state->period - duty_cycle;
+
+	frac = ((u64)duty_cycle << 16) / state->period;
+	frac = min(frac, 0xFFFFU);
+
+	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
+
+	if (state->enabled) {
+		state->period = pwm->real_period;
+		state->duty_cycle = ((u64)frac * pwm->real_period) >> 16;
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			state->duty_cycle = state->period - state->duty_cycle;
+	}
+
+	return 0;
+}
+
+static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_device *dev,
+				 struct pwm_state *state)
+{
+	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
+	unsigned long duty;
+
+	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
+
+	state->period     = pwm->real_period;
+	state->duty_cycle = ((u64)duty * pwm->real_period) >> 16;
+	state->polarity   = PWM_POLARITY_INVERSED;
+	state->enabled    = duty > 0;
+}
+
+static const struct pwm_ops sifive_pwm_ops = {
+	.get_state	= sifive_pwm_get_state,
+	.apply		= sifive_pwm_apply,
+	.owner		= THIS_MODULE,
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
+	dev->args.period   = pwm->real_period;
+	dev->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args[1] & PWM_POLARITY_INVERTED)
+		dev->args.polarity = PWM_POLARITY_INVERSED;
+
+	return dev;
+}
+
+static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
+				    unsigned long rate)
+{
+	/* (1 << (16+scale)) * 10^9/rate = real_period */
+	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;
+	int scale = ilog2(scalePow) - 16;
+
+	scale = clamp(scale, 0, 0xf);
+	iowrite32((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
+		  pwm->regs + REG_PWMCFG);
+
+	pwm->real_period = (1000000000ULL << (16 + scale)) / rate;
+}
+
+static int sifive_pwm_clock_notifier(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct sifive_pwm_device *pwm = container_of(nb,
+						     struct sifive_pwm_device,
+						     notifier);
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
+
+	ret = of_property_read_u32(node, "sifive,npwm", &chip->npwm);
+	if (ret < 0 || chip->npwm > MAX_PWM)
+		chip->npwm = MAX_PWM;
+
+	ret = of_property_read_u32(node, "sifive,approx-period",
+				   &pwm->approx_period);
+	if (ret < 0) {
+		dev_err(dev, "Unable to read sifive,approx-period from DTS\n");
+		return -ENOENT;
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
+		dev_err(dev, "Unable to find controller clock\n");
+		return PTR_ERR(pwm->clk);
+	}
+
+	/* Watch for changes to underlying clock frequency */
+	pwm->notifier.notifier_call = sifive_pwm_clock_notifier;
+	clk_notifier_register(pwm->clk, &pwm->notifier);
+
+	/* Initialize PWM config */
+	sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
+
+	/* No interrupt handler needed yet */
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		clk_notifier_unregister(pwm->clk, &pwm->notifier);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+	dev_info(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
+
+	return 0;
+}
+
+static int sifive_pwm_remove(struct platform_device *dev)
+{
+	struct sifive_pwm_device *pwm = platform_get_drvdata(dev);
+	struct pwm_chip *chip = &pwm->chip;
+
+	clk_notifier_unregister(pwm->clk, &pwm->notifier);
+	return pwmchip_remove(chip);
+}
+
+static const struct of_device_id sifive_pwm_of_match[] = {
+	{ .compatible = "sifive,pwm0" },
+	{ .compatible = "sifive,fu540-c000-pwm0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sifive_pwm_of_match);
+
+static struct platform_driver sifive_pwm_driver = {
+	.probe = sifive_pwm_probe,
+	.remove = sifive_pwm_remove,
+	.driver = {
+		.name = "pwm-sifivem",
+		.of_match_table = of_match_ptr(sifive_pwm_of_match),
+	},
+};
+module_platform_driver(sifive_pwm_driver);
+
+MODULE_DESCRIPTION("SiFive PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

