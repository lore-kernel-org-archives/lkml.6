Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6BBC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DEA22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1yrWTXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DEA22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbeKMTtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:49:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34465 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731875AbeKMTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:49:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so12526915wre.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f89cMj1x0peUIdYx+E2neeLwZox9dXEqOpz/Qk6Yxrs=;
        b=Y1yrWTXU3aK87bQqSob3sCL3iXKmCV/3pSwU9EFEf4UyY7kOoeEqkWVLx9nHGB9BU1
         jis8vuUd0wNokc+WbCVee9OxhTa5mMJGyaHWNaZCWgg3821BilpYdpx2wDze1COPLdfA
         0KibfLTi5padJ2UzBXtVPT/gmRH/DerQxI6Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f89cMj1x0peUIdYx+E2neeLwZox9dXEqOpz/Qk6Yxrs=;
        b=j1S8yFG2xW1Y7Nlwj2Lpi0xUh00On00H4Xc4Jz621qzZ/5BkYNND0yxZIcSgEop5Tn
         +LZbLyVH+aTOgCm4QM9VLk4BOVRG2inJS2ylBOv94SB2HgUzIHFmI9dzrOo2yUL4n3kn
         63TuYeSjsJc65Y6ZnkDQkXQiIYpdlngjCbcYbI0UpIajZjUaR8kFjNmj5halNOyK77t1
         T8pDyNpZzgZ8ukm7HxYT/qmxv2ZRBkJuFmfbGXpWfUXW2zVYYHo2DNUjjmS9RvRBeNnH
         c6FiDnH/yyRT6Jkx8DmQ6EX0nq+QUt26eu/UwFzoCbKTREb7GqonneViO7GJqCz7I3Xf
         P6Og==
X-Gm-Message-State: AGRZ1gJDZT/XYMtWPiqkyMremMac1mGP+51JGSDvscznYmx8zdcq1Kq8
        5TIUaEZy4i6BdawW5Y1+nrwAJg==
X-Google-Smtp-Source: AJdET5cWqDM+asTq8sRWRxTpVsbFQgyMzq9hYTZXJfGZC7gVM6gjJoctEFJ6VMjza1lF6fRBgX8Rig==
X-Received: by 2002:adf:e7c6:: with SMTP id e6-v6mr4151190wrn.49.1542102719379;
        Tue, 13 Nov 2018 01:51:59 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id d4sm6044279wrp.89.2018.11.13.01.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:51:58 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/3] pinctrl: stm32: protect configuration registers with a hwspinlock
Date:   Tue, 13 Nov 2018 10:51:41 +0100
Message-Id: <20181113095142.32015-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113095142.32015-1-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a hwspinlock if defined in device tree use it to protect
configuration registers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 71 ++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a9bec6e6fdd1..dce9dabaf4d5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -8,6 +8,7 @@
  */
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
+#include <linux/hwspinlock.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
@@ -51,6 +52,8 @@
 #define gpio_range_to_bank(chip) \
 		container_of(chip, struct stm32_gpio_bank, range)
 
+#define HWSPINLOCK_TIMEOUT	5 /* msec */
+
 static const char * const stm32_gpio_functions[] = {
 	"gpio", "af0", "af1",
 	"af2", "af3", "af4",
@@ -91,6 +94,7 @@ struct stm32_pinctrl {
 	struct irq_domain	*domain;
 	struct regmap		*regmap;
 	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
+	struct hwspinlock *hwlock;
 };
 
 static inline int stm32_gpio_pin(int gpio)
@@ -576,14 +580,24 @@ static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 		int pin, u32 mode, u32 alt)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	u32 val;
 	int alt_shift = (pin % 8) * 4;
 	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
 	unsigned long flags;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + alt_offset);
 	val &= ~GENMASK(alt_shift + 3, alt_shift);
 	val |= (alt << alt_shift);
@@ -594,6 +608,10 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 	val |= mode << (pin * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_MODER);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -683,17 +701,31 @@ static const struct pinmux_ops stm32_pmx_ops = {
 static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 drive)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
 	val &= ~BIT(offset);
 	val |= drive << offset;
 	writel_relaxed(val, bank->base + STM32_GPIO_TYPER);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -719,17 +751,31 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
 static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 speed)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
 	val &= ~GENMASK(offset * 2 + 1, offset * 2);
 	val |= speed << (offset * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_SPEEDR);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -755,17 +801,31 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
 static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 bias)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
 	val &= ~GENMASK(offset * 2 + 1, offset * 2);
 	val |= bias << (offset * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_PUPDR);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -1140,7 +1200,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_pinctrl *pctl;
 	struct pinctrl_pin_desc *pins;
-	int i, ret, banks = 0;
+	int i, ret, hwlock_id, banks = 0;
 
 	if (!np)
 		return -EINVAL;
@@ -1160,6 +1220,15 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pctl);
 
+	/* hwspinlock is optional */
+	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
+	if (hwlock_id < 0) {
+		if (hwlock_id == -EPROBE_DEFER)
+			return hwlock_id;
+	} else {
+		pctl->hwlock = hwspin_lock_request_specific(hwlock_id);
+	}
+
 	pctl->dev = dev;
 	pctl->match_data = match->data;
 	ret = stm32_pctrl_build_state(pdev);
-- 
2.15.0

