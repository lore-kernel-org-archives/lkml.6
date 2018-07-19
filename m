Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9D20862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYrjsXye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeGSQpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeGSQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:34 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7714D20858;
        Thu, 19 Jul 2018 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016104;
        bh=VRSi07jrIg2lyvU+OFOnaL1qAX7XceK63njhxjy/oZk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iYrjsXyeVbYdtv0bqWZMG7o6kI3XrH/XPk3Uy0uqPPpj3RzhcqXotIjDFsv20MDsV
         ZSbpnPR5G0lxyEiyH8i+5wPYf7NPx6AfSjuXfyYaJI4vEIdpIVKbJYyFjvGdhCvYcP
         OzowL6ruAsDW61Hn5pITmSMwIrrjuw/HfLtqH97A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 06/10] pinctrl: samsung: Write external interrupt mask
Date:   Thu, 19 Jul 2018 18:00:46 +0200
Message-Id: <20180719160050.22566-7-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl driver defines IRQ chip handling external wakeup interrupts,
therefore from logical point of view, it is the owner of external
interrupt mask.  However the register controlling the mask belongs to
Power Management Unit address space.  Therefore reuse existing PMU
syscon regmap handle, passed via retention data.

The pinctrl driver will write external interrupt mask during late
suspend.

ARMv7 designs (S5Pv210 and Exynos)
==================================
This duplicates setting mask with machine code
arch/arm/mach-exynos/suspend.c and arch/arm/mach-s5pv210/pm.c but it is
not a problem - the wakeup mask register will be written twice.

The difference between implementation here and ARMv7 machine code
(arch/arm/mach-*) is the time of writing the mask.  The machine code is
writing the mask during system suspend path, after offlining secondary
CPUs and just before doing actual suspend.

The implementation in pinctrl driver uses late suspend ops, therefore it
will write the mask much earlier.  Hopefully after all drivers will
enable or disable its interrupt wakeup (enable_irq_wake() etc).

ARMv8 designs (Exynos5433 and Exynos7)
==================================
This was not done before thus it brings one step closer into suspend
support.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c    | 50 ++++++++++++++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h   |  3 ++
 include/linux/soc/samsung/exynos-regs-pmu.h |  2 ++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 29d86d704b0c..40ef14956876 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <dt-bindings/pinctrl/samsung.h>
 
@@ -37,6 +38,8 @@ struct exynos_irq_chip {
 	u32 eint_con;
 	u32 eint_mask;
 	u32 eint_pend;
+	u32 eint_wake_mask_value;
+	u32 eint_wake_mask_reg;
 };
 
 static inline struct exynos_irq_chip *to_exynos_irq_chip(struct irq_chip *chip)
@@ -215,6 +218,7 @@ static struct exynos_irq_chip exynos_gpio_irq_chip = {
 	.eint_con = EXYNOS_GPIO_ECON_OFFSET,
 	.eint_mask = EXYNOS_GPIO_EMASK_OFFSET,
 	.eint_pend = EXYNOS_GPIO_EPEND_OFFSET,
+	/* eint_wake_mask_value not used */
 };
 
 static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
@@ -330,6 +334,8 @@ u32 exynos_get_eint_wake_mask(void)
 
 static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long bit = 1UL << (2 * bank->eint_offset + irqd->hwirq);
 
@@ -339,6 +345,7 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 		exynos_eint_wake_mask |= bit;
 	else
 		exynos_eint_wake_mask &= ~bit;
+	our_chip->eint_wake_mask_value = exynos_eint_wake_mask;
 
 	return 0;
 }
@@ -360,6 +367,9 @@ static const struct exynos_irq_chip s5pv210_wkup_irq_chip __initconst = {
 	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
 	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
 	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
+	.eint_wake_mask_value = EXYNOS_EINT_WAKEUP_MASK_DISABLED,
+	/* Only difference with exynos4210_wkup_irq_chip: */
+	.eint_wake_mask_reg = S5PV210_EINT_WAKEUP_MASK,
 };
 
 static const struct exynos_irq_chip exynos4210_wkup_irq_chip __initconst = {
@@ -376,6 +386,8 @@ static const struct exynos_irq_chip exynos4210_wkup_irq_chip __initconst = {
 	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
 	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
 	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
+	.eint_wake_mask_value = EXYNOS_EINT_WAKEUP_MASK_DISABLED,
+	.eint_wake_mask_reg = EXYNOS_EINT_WAKEUP_MASK,
 };
 
 static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
@@ -392,6 +404,8 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
 	.eint_con = EXYNOS7_WKUP_ECON_OFFSET,
 	.eint_mask = EXYNOS7_WKUP_EMASK_OFFSET,
 	.eint_pend = EXYNOS7_WKUP_EPEND_OFFSET,
+	.eint_wake_mask_value = EXYNOS_EINT_WAKEUP_MASK_DISABLED,
+	.eint_wake_mask_reg = EXYNOS5433_EINT_WAKEUP_MASK,
 };
 
 /* list of external wakeup controllers supported */
@@ -560,6 +574,27 @@ int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	return 0;
 }
 
+static void
+exynos_pinctrl_set_eint_wakeup_mask(struct samsung_pinctrl_drv_data *drvdata,
+				    struct exynos_irq_chip *irq_chip)
+{
+	struct regmap *pmu_regs;
+
+	if (!drvdata->retention_ctrl || !drvdata->retention_ctrl->priv) {
+		dev_warn(drvdata->dev,
+			 "No retention data configured bank with external wakeup interrupt. Wake-up mask will not be set.\n");
+		return;
+	}
+
+	pmu_regs = drvdata->retention_ctrl->priv;
+	dev_info(drvdata->dev,
+		 "Setting external wakeup interrupt wakeup mask: 0x%x\n",
+		 irq_chip->eint_wake_mask_value);
+
+	regmap_write(pmu_regs, irq_chip->eint_wake_mask_reg,
+		     irq_chip->eint_wake_mask_value);
+}
+
 static void exynos_pinctrl_suspend_bank(
 				struct samsung_pinctrl_drv_data *drvdata,
 				struct samsung_pin_bank *bank)
@@ -582,11 +617,24 @@ static void exynos_pinctrl_suspend_bank(
 void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
+	struct exynos_irq_chip *irq_chip = NULL;
 	int i;
 
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
+	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
 		if (bank->eint_type == EINT_TYPE_GPIO)
 			exynos_pinctrl_suspend_bank(drvdata, bank);
+		else if (bank->eint_type == EINT_TYPE_WKUP) {
+			if (!irq_chip) {
+				irq_chip = bank->irq_chip;
+				exynos_pinctrl_set_eint_wakeup_mask(drvdata,
+								    irq_chip);
+			} else if (bank->irq_chip != irq_chip) {
+				dev_warn(drvdata->dev,
+					 "More than one external wakeup interrupt chip configured (bank: %s). This is not supported by hardware nor by driver.\n",
+					 bank->name);
+			}
+		}
+	}
 }
 
 static void exynos_pinctrl_resume_bank(
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index aac16cc8362a..e571bbd7139b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -227,6 +227,9 @@ struct samsung_retention_data {
  *	device suspend, see samsung_pinctrl_suspend()
  * @resume: platform specific resume callback, executed during pin controller
  *	device suspend, see samsung_pinctrl_resume()
+ *
+ * External wakeup interrupts must define at least eint_wkup_init,
+ * retention_data and suspend in order for proper suspend/resume to work.
  */
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index eb0d240df7a7..5addaf5ccbce 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -42,6 +42,8 @@
 #define EXYNOS_SWRESET				0x0400
 
 #define S5P_WAKEUP_STAT				0x0600
+/* Value for EXYNOS_EINT_WAKEUP_MASK disabling all external wakeup interrupts */
+#define EXYNOS_EINT_WAKEUP_MASK_DISABLED	0xffffffff
 #define EXYNOS_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
-- 
2.14.1

