Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82FA205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82FA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeH3U4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:20167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeH3U4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="84732163"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2018 09:52:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14EEE19E; Thu, 30 Aug 2018 19:52:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] mfd: intel_soc_pmic_bxtwc: Chain power button IRQs as well
Date:   Thu, 30 Aug 2018 19:52:52 +0300
Message-Id: <20180830165255.43114-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power button IRQ actually has a second level of interrupts to
distinguish between UI and POWER buttons. Moreover, current
implementation looks awkward in approach to handle second level IRQs by
first level related IRQ chip.

To address above issues, split power button IRQ to be chained as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 41 ++++++++++++++++++++++--------
 include/linux/mfd/intel_soc_pmic.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 15bc052704a6..9ca1f8c015de 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -31,8 +31,8 @@
 
 /* Interrupt Status Registers */
 #define BXTWC_IRQLVL1		0x4E02
-#define BXTWC_PWRBTNIRQ		0x4E03
 
+#define BXTWC_PWRBTNIRQ		0x4E03
 #define BXTWC_THRM0IRQ		0x4E04
 #define BXTWC_THRM1IRQ		0x4E05
 #define BXTWC_THRM2IRQ		0x4E06
@@ -47,10 +47,9 @@
 
 /* Interrupt MASK Registers */
 #define BXTWC_MIRQLVL1		0x4E0E
-#define BXTWC_MPWRTNIRQ		0x4E0F
-
 #define BXTWC_MIRQLVL1_MCHGR	BIT(5)
 
+#define BXTWC_MPWRBTNIRQ	0x4E0F
 #define BXTWC_MTHRM0IRQ		0x4E12
 #define BXTWC_MTHRM1IRQ		0x4E13
 #define BXTWC_MTHRM2IRQ		0x4E14
@@ -66,9 +65,7 @@
 /* Whiskey Cove PMIC share same ACPI ID between different platforms */
 #define BROXTON_PMIC_WC_HRV	4
 
-/* Manage in two IRQ chips since mask registers are not consecutive */
 enum bxtwc_irqs {
-	/* Level 1 */
 	BXTWC_PWRBTN_LVL1_IRQ = 0,
 	BXTWC_TMU_LVL1_IRQ,
 	BXTWC_THRM_LVL1_IRQ,
@@ -77,9 +74,11 @@ enum bxtwc_irqs {
 	BXTWC_CHGR_LVL1_IRQ,
 	BXTWC_GPIO_LVL1_IRQ,
 	BXTWC_CRIT_LVL1_IRQ,
+};
 
-	/* Level 2 */
-	BXTWC_PWRBTN_IRQ,
+enum bxtwc_irqs_pwrbtn {
+	BXTWC_PWRBTN_IRQ = 0,
+	BXTWC_UIBTN_IRQ,
 };
 
 enum bxtwc_irqs_bcu {
@@ -113,7 +112,10 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
 	REGMAP_IRQ_REG(BXTWC_CHGR_LVL1_IRQ, 0, BIT(5)),
 	REGMAP_IRQ_REG(BXTWC_GPIO_LVL1_IRQ, 0, BIT(6)),
 	REGMAP_IRQ_REG(BXTWC_CRIT_LVL1_IRQ, 0, BIT(7)),
-	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 1, 0x03),
+};
+
+static const struct regmap_irq bxtwc_regmap_irqs_pwrbtn[] = {
+	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 0, 0x01),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_bcu[] = {
@@ -125,7 +127,7 @@ static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
-	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, BIT(5)),
+	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, 0x20),
 	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
 	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
 };
@@ -144,7 +146,16 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
 	.mask_base = BXTWC_MIRQLVL1,
 	.irqs = bxtwc_regmap_irqs,
 	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs),
-	.num_regs = 2,
+	.num_regs = 1,
+};
+
+static struct regmap_irq_chip bxtwc_regmap_irq_chip_pwrbtn = {
+	.name = "bxtwc_irq_chip_pwrbtn",
+	.status_base = BXTWC_PWRBTNIRQ,
+	.mask_base = BXTWC_MPWRBTNIRQ,
+	.irqs = bxtwc_regmap_irqs_pwrbtn,
+	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_pwrbtn),
+	.num_regs = 1,
 };
 
 static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
@@ -472,6 +483,16 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_PWRBTN_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_pwrbtn,
+					 &pmic->irq_chip_data_pwrbtn);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add PWRBTN IRQ chip\n");
+		return ret;
+	}
+
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_TMU_LVL1_IRQ,
 					 IRQF_ONESHOT,
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 5aacdb017a9f..806a4f095312 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -25,6 +25,7 @@ struct intel_soc_pmic {
 	int irq;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *irq_chip_data;
+	struct regmap_irq_chip_data *irq_chip_data_pwrbtn;
 	struct regmap_irq_chip_data *irq_chip_data_tmu;
 	struct regmap_irq_chip_data *irq_chip_data_bcu;
 	struct regmap_irq_chip_data *irq_chip_data_adc;
-- 
2.18.0

