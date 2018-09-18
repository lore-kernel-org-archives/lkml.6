Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40728C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8759214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8759214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeIRVJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:09:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:22174 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeIRVJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 08:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="258284682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Sep 2018 08:36:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 693321AA; Tue, 18 Sep 2018 18:36:21 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rajat Jain <rajatja@google.com>, casey.g.bowman@intel.com,
        matthew.s.atwood@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: intel: Do pin translation in other GPIO operations as well
Date:   Tue, 18 Sep 2018 18:36:21 +0300
Message-Id: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I thought GPIOLIB handles translation from GPIO ranges
to pinctrl pins but it turns out not to be the case. This means that
when GPIOs operations are performed for a pin controller having a custom
GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
used internally.

Fix this in the same way we did for lock/unlock IRQ operations and
translate the GPIO number to pin before using it.

Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
Reported-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 111 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 62b009b27eda..ec8dafc94694 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -747,13 +747,63 @@ static const struct pinctrl_desc intel_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+/**
+ * intel_gpio_to_pin() - Translate from GPIO offset to pin number
+ * @pctrl: Pinctrl structure
+ * @offset: GPIO offset from gpiolib
+ * @commmunity: Community is filled here if not %NULL
+ * @padgrp: Pad group is filled here if not %NULL
+ *
+ * When coming through gpiolib irqchip, the GPIO offset is not
+ * automatically translated to pinctrl pin number. This function can be
+ * used to find out the corresponding pinctrl pin.
+ */
+static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
+			     const struct intel_community **community,
+			     const struct intel_padgroup **padgrp)
+{
+	int i;
+
+	for (i = 0; i < pctrl->ncommunities; i++) {
+		const struct intel_community *comm = &pctrl->communities[i];
+		int j;
+
+		for (j = 0; j < comm->ngpps; j++) {
+			const struct intel_padgroup *pgrp = &comm->gpps[j];
+
+			if (pgrp->gpio_base < 0)
+				continue;
+
+			if (offset >= pgrp->gpio_base &&
+			    offset < pgrp->gpio_base + pgrp->size) {
+				int pin;
+
+				pin = pgrp->base + offset - pgrp->gpio_base;
+				if (community)
+					*community = comm;
+				if (padgrp)
+					*padgrp = pgrp;
+
+				return pin;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int intel_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	void __iomem *reg;
 	u32 padcfg0;
+	int pin;
+
+	pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
+	if (pin < 0)
+		return -EINVAL;
 
-	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
+	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
 	if (!reg)
 		return -EINVAL;
 
@@ -770,8 +820,13 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 	void __iomem *reg;
 	u32 padcfg0;
+	int pin;
+
+	pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
+	if (pin < 0)
+		return;
 
-	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
+	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
 	if (!reg)
 		return;
 
@@ -790,8 +845,13 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	void __iomem *reg;
 	u32 padcfg0;
+	int pin;
 
-	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
+	pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
+	if (pin < 0)
+		return -EINVAL;
+
+	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
 	if (!reg)
 		return -EINVAL;
 
@@ -827,51 +887,6 @@ static const struct gpio_chip intel_gpio_chip = {
 	.set_config = gpiochip_generic_config,
 };
 
-/**
- * intel_gpio_to_pin() - Translate from GPIO offset to pin number
- * @pctrl: Pinctrl structure
- * @offset: GPIO offset from gpiolib
- * @commmunity: Community is filled here if not %NULL
- * @padgrp: Pad group is filled here if not %NULL
- *
- * When coming through gpiolib irqchip, the GPIO offset is not
- * automatically translated to pinctrl pin number. This function can be
- * used to find out the corresponding pinctrl pin.
- */
-static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
-			     const struct intel_community **community,
-			     const struct intel_padgroup **padgrp)
-{
-	int i;
-
-	for (i = 0; i < pctrl->ncommunities; i++) {
-		const struct intel_community *comm = &pctrl->communities[i];
-		int j;
-
-		for (j = 0; j < comm->ngpps; j++) {
-			const struct intel_padgroup *pgrp = &comm->gpps[j];
-
-			if (pgrp->gpio_base < 0)
-				continue;
-
-			if (offset >= pgrp->gpio_base &&
-			    offset < pgrp->gpio_base + pgrp->size) {
-				int pin;
-
-				pin = pgrp->base + offset - pgrp->gpio_base;
-				if (community)
-					*community = comm;
-				if (padgrp)
-					*padgrp = pgrp;
-
-				return pin;
-			}
-		}
-	}
-
-	return -EINVAL;
-}
-
 static int intel_gpio_irq_reqres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-- 
2.18.0

