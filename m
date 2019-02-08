Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDBFC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691A121907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ZVTJZpKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBHCQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:16:55 -0500
Received: from onstation.org ([52.200.56.107]:34976 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfBHCQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:52 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D198F6ED;
        Fri,  8 Feb 2019 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592211;
        bh=UJRnmfVDKoPhCQUqC53AnGfYnYONeTkhtmimFAk3+is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVTJZpKhgTZ2M0rLa5jpUKt2RlGIX7cu3Dwklo/WszD+DpAUGy+V5jYM8ygSpmBFI
         8Icg4NVni16Vj81+L9HzN07AZGtiUxQXK4m7KPWPIU/rkc3FjxUYuzlPcMPfvKtXw2
         VJRlDUrxDwE1q0yrQImT0G8FxaLrHzGRi+3RaVWI=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/11] mfd: pm8xxx: convert to v2 irq interfaces to support hierarchical IRQ chips
Date:   Thu,  7 Feb 2019 21:16:24 -0500
Message-Id: <20190208021631.30252-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PM8XXX IRQ code to use the version 2 IRQ interface in order
to support hierarchical IRQ chips. This is necessary so that ssbi-gpio
can be setup as a hierarchical IRQ chip with PM8xxx as the parent. IRQ
chips in device tree should be usable from the start without having to
make an additional call to gpio[d]_to_irq() to get the proper IRQ on the
parent.

pm8821_irq_domain_ops and pm8821_irq_domain_map are removed by this
patch since the irq_chip is now contained in the pm_irq_data struct, and
that allows us to use a common IRQ mapping function.

This change was tested on an APQ8060 DragonBoard.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
- Put u8 config[0] at end along with a comment
- Hardcode the IRQ flow handler as handle_level_irq like the original
  code.
- Don't set IRQ handler in pm8xxx_irq_set_type() since this is already
  done in pm8xxx_irq_domain_map(). Linus: This is different than what
  you tested but this *should* be fine.

 drivers/mfd/qcom-pm8xxx.c | 75 ++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index e6e8d81c15fd..8eb2528793f9 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -70,22 +70,23 @@
 #define PM8XXX_NR_IRQS		256
 #define PM8821_NR_IRQS		112
 
+struct pm_irq_data {
+	int num_irqs;
+	struct irq_chip *irq_chip;
+	void (*irq_handler)(struct irq_desc *desc);
+};
+
 struct pm_irq_chip {
 	struct regmap		*regmap;
 	spinlock_t		pm_irq_lock;
 	struct irq_domain	*irqdomain;
-	unsigned int		num_irqs;
 	unsigned int		num_blocks;
 	unsigned int		num_masters;
+	const struct pm_irq_data *pm_irq_data;
+	/* MUST BE AT THE END OF THIS STRUCT */
 	u8			config[0];
 };
 
-struct pm_irq_data {
-	int num_irqs;
-	const struct irq_domain_ops  *irq_domain_ops;
-	void (*irq_handler)(struct irq_desc *desc);
-};
-
 static int pm8xxx_read_block_irq(struct pm_irq_chip *chip, unsigned int bp,
 				 unsigned int *ip)
 {
@@ -375,21 +376,38 @@ static struct irq_chip pm8xxx_irq_chip = {
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
-static int pm8xxx_irq_domain_map(struct irq_domain *d, unsigned int irq,
-				   irq_hw_number_t hwirq)
+static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
+				  struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq, unsigned int type)
 {
-	struct pm_irq_chip *chip = d->host_data;
-
-	irq_set_chip_and_handler(irq, &pm8xxx_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, chip);
+	irq_domain_set_info(domain, irq, hwirq, chip->pm_irq_data->irq_chip,
+			    chip, handle_level_irq, NULL, NULL);
 	irq_set_noprobe(irq);
+}
+
+static int pm8xxx_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *data)
+{
+	struct pm_irq_chip *chip = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		pm8xxx_irq_domain_map(chip, domain, virq + i, hwirq + i, type);
 
 	return 0;
 }
 
 static const struct irq_domain_ops pm8xxx_irq_domain_ops = {
-	.xlate = irq_domain_xlate_twocell,
-	.map = pm8xxx_irq_domain_map,
+	.alloc = pm8xxx_irq_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = irq_domain_translate_twocell,
 };
 
 static void pm8821_irq_mask_ack(struct irq_data *d)
@@ -473,23 +491,6 @@ static struct irq_chip pm8821_irq_chip = {
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
-static int pm8821_irq_domain_map(struct irq_domain *d, unsigned int irq,
-				   irq_hw_number_t hwirq)
-{
-	struct pm_irq_chip *chip = d->host_data;
-
-	irq_set_chip_and_handler(irq, &pm8821_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, chip);
-	irq_set_noprobe(irq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops pm8821_irq_domain_ops = {
-	.xlate = irq_domain_xlate_twocell,
-	.map = pm8821_irq_domain_map,
-};
-
 static const struct regmap_config ssbi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
@@ -501,13 +502,13 @@ static const struct regmap_config ssbi_regmap_config = {
 
 static const struct pm_irq_data pm8xxx_data = {
 	.num_irqs = PM8XXX_NR_IRQS,
-	.irq_domain_ops = &pm8xxx_irq_domain_ops,
+	.irq_chip = &pm8xxx_irq_chip,
 	.irq_handler = pm8xxx_irq_handler,
 };
 
 static const struct pm_irq_data pm8821_data = {
 	.num_irqs = PM8821_NR_IRQS,
-	.irq_domain_ops = &pm8821_irq_domain_ops,
+	.irq_chip = &pm8821_irq_chip,
 	.irq_handler = pm8821_irq_handler,
 };
 
@@ -571,14 +572,14 @@ static int pm8xxx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 	chip->regmap = regmap;
-	chip->num_irqs = data->num_irqs;
-	chip->num_blocks = DIV_ROUND_UP(chip->num_irqs, 8);
+	chip->num_blocks = DIV_ROUND_UP(data->num_irqs, 8);
 	chip->num_masters = DIV_ROUND_UP(chip->num_blocks, 8);
+	chip->pm_irq_data = data;
 	spin_lock_init(&chip->pm_irq_lock);
 
 	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
 						data->num_irqs,
-						data->irq_domain_ops,
+						&pm8xxx_irq_domain_ops,
 						chip);
 	if (!chip->irqdomain)
 		return -ENODEV;
-- 
2.17.2

