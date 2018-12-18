Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72630214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cdJ7rkZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLRHfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:34 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18476 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeLRHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a33c0001>; Mon, 17 Dec 2018 23:35:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:29 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:29 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:29 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a33f0000>; Mon, 17 Dec 2018 23:35:28 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 09/12] thermal: tegra: add support for EDP IRQ
Date:   Tue, 18 Dec 2018 15:34:41 +0800
Message-ID: <1545118484-23641-11-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118524; bh=XuGq+VSop6GVe7DHStbnD8ib61eXC9U/4ApWs4kzwK0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cdJ7rkZG25MSjgwjYOU7oDqLeZYLOXphJBAda2gAZZnWX1kJgdhtj1TmipkS9y3uB
         BItblZxCGauPPpOlS15DX2YA4PdSbySvvJb8EeDHxBMZ2lNNHOQ3n/b+BjG3TD2sFF
         BIehOvLEtBSLhQjEEqXkIttrUH+dpDfUcEQC5KEfbdCLbd/+ttZ9K/E0RGF5EMT2bF
         oQ9+o6xG9z9VRN1PDQLXM7rwbcZGNc3gt/z8OTbqZi+whDB6GNR4vFLJUcz9kPJXQY
         xARg20Eiz+1Sl3GEy4JUMQB950d0e8J1q3XM3Pir9+P/Aq2MVzZAWkLuug0X5LR6YK
         BuFNVdVbeT4zQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to generate OC (over-current) interrupts to
indicate the OC event and print out alarm messages.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 420 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 420 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index eefbb29b3b7d..37108f2290f9 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -23,6 +23,8 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -104,6 +106,16 @@
 #define STATS_CTL_CLR_UP			0x2
 #define STATS_CTL_EN_UP				0x1
 
+#define OC_INTR_STATUS				0x39c
+#define OC_INTR_ENABLE				0x3a0
+#define OC_INTR_DISABLE				0x3a4
+
+#define OC_INTR_OC1_MASK			BIT(0)
+#define OC_INTR_OC2_MASK			BIT(1)
+#define OC_INTR_OC3_MASK			BIT(2)
+#define OC_INTR_OC4_MASK			BIT(3)
+#define OC_INTR_OC5_MASK			BIT(4)
+
 #define THROT_GLOBAL_CFG			0x400
 #define THROT_GLOBAL_ENB_MASK			BIT(0)
 
@@ -212,9 +224,23 @@ static const int max_high_temp = 127000;
 enum soctherm_throttle_id {
 	THROTTLE_LIGHT = 0,
 	THROTTLE_HEAVY,
+	THROTTLE_OC1,
+	THROTTLE_OC2,
+	THROTTLE_OC3,
+	THROTTLE_OC4,
+	THROTTLE_OC5, /* OC5 is reserved */
 	THROTTLE_SIZE,
 };
 
+enum soctherm_oc_irq_id {
+	TEGRA_SOC_OC_IRQ_1,
+	TEGRA_SOC_OC_IRQ_2,
+	TEGRA_SOC_OC_IRQ_3,
+	TEGRA_SOC_OC_IRQ_4,
+	TEGRA_SOC_OC_IRQ_5,
+	TEGRA_SOC_OC_IRQ_MAX,
+};
+
 enum soctherm_throttle_dev_id {
 	THROTTLE_DEV_CPU = 0,
 	THROTTLE_DEV_GPU,
@@ -224,6 +250,11 @@ enum soctherm_throttle_dev_id {
 static const char *const throt_names[] = {
 	[THROTTLE_LIGHT] = "light",
 	[THROTTLE_HEAVY] = "heavy",
+	[THROTTLE_OC1]   = "oc1",
+	[THROTTLE_OC2]   = "oc2",
+	[THROTTLE_OC3]   = "oc3",
+	[THROTTLE_OC4]   = "oc4",
+	[THROTTLE_OC5]   = "oc5",
 };
 
 struct tegra_soctherm;
@@ -255,6 +286,7 @@ struct tegra_soctherm {
 	void __iomem *ccroc_regs;
 
 	int thermal_irq;
+	int edp_irq;
 
 	u32 *calib;
 	struct thermal_zone_device **thermctl_tzs;
@@ -267,6 +299,15 @@ struct tegra_soctherm {
 	struct mutex thermctl_lock;
 };
 
+struct soctherm_oc_irq_chip_data {
+	struct mutex		irq_lock; /* serialize OC IRQs */
+	struct irq_chip		irq_chip;
+	struct irq_domain	*domain;
+	int			irq_enable;
+};
+
+static struct soctherm_oc_irq_chip_data soc_irq_cdata;
+
 /**
  * ccroc_writel() - writes a value to a CCROC register
  * @ts: pointer to a struct tegra_soctherm
@@ -807,6 +848,360 @@ static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * soctherm_oc_intr_enable() - Enables the soctherm over-current interrupt
+ * @alarm:		The soctherm throttle id
+ * @enable:		Flag indicating enable the soctherm over-current
+ *			interrupt or disable it
+ *
+ * Enables a specific over-current pins @alarm to raise an interrupt if the flag
+ * is set and the alarm corresponds to OC1, OC2, OC3, or OC4.
+ */
+static void soctherm_oc_intr_enable(struct tegra_soctherm *ts,
+				    enum soctherm_throttle_id alarm,
+				    bool enable)
+{
+	u32 r;
+
+	if (!enable)
+		return;
+
+	r = readl(ts->regs + OC_INTR_ENABLE);
+	switch (alarm) {
+	case THROTTLE_OC1:
+		r = REG_SET_MASK(r, OC_INTR_OC1_MASK, 1);
+		break;
+	case THROTTLE_OC2:
+		r = REG_SET_MASK(r, OC_INTR_OC2_MASK, 1);
+		break;
+	case THROTTLE_OC3:
+		r = REG_SET_MASK(r, OC_INTR_OC3_MASK, 1);
+		break;
+	case THROTTLE_OC4:
+		r = REG_SET_MASK(r, OC_INTR_OC4_MASK, 1);
+		break;
+	default:
+		r = 0;
+		break;
+	}
+	writel(r, ts->regs + OC_INTR_ENABLE);
+}
+
+/**
+ * soctherm_handle_alarm() - Handles soctherm alarms
+ * @alarm:		The soctherm throttle id
+ *
+ * "Handles" over-current alarms (OC1, OC2, OC3, and OC4) by printing
+ * a warning or informative message.
+ *
+ * Return: -EINVAL for @alarm = THROTTLE_OC3, otherwise 0 (success).
+ */
+static int soctherm_handle_alarm(enum soctherm_throttle_id alarm)
+{
+	int rv = -EINVAL;
+
+	switch (alarm) {
+	case THROTTLE_OC1:
+		pr_debug("soctherm: Successfully handled OC1 alarm\n");
+		rv = 0;
+		break;
+
+	case THROTTLE_OC2:
+		pr_debug("soctherm: Successfully handled OC2 alarm\n");
+		rv = 0;
+		break;
+
+	case THROTTLE_OC3:
+		pr_debug("soctherm: Successfully handled OC3 alarm\n");
+		rv = 0;
+		break;
+
+	case THROTTLE_OC4:
+		pr_debug("soctherm: Successfully handled OC4 alarm\n");
+		rv = 0;
+		break;
+
+	default:
+		break;
+	}
+
+	if (rv)
+		pr_err("soctherm: ERROR in handling %s alarm\n",
+		       throt_names[alarm]);
+
+	return rv;
+}
+
+/**
+ * soctherm_edp_isr_thread() - log an over-current interrupt request
+ * @irq:	OC irq number. Currently not being used. See description
+ * @arg:	a void pointer for callback, currently not being used
+ *
+ * Over-current events are handled in hardware. This function is called to log
+ * and handle any OC events that happened. Additionally, it checks every
+ * over-current interrupt registers for registers are set but
+ * was not expected (i.e. any discrepancy in interrupt status) by the function,
+ * the discrepancy will logged.
+ *
+ * Return: %IRQ_HANDLED
+ */
+static irqreturn_t soctherm_edp_isr_thread(int irq, void *arg)
+{
+	struct tegra_soctherm *ts = arg;
+	u32 st, ex, oc1, oc2, oc3, oc4;
+
+	st = readl(ts->regs + OC_INTR_STATUS);
+
+	/* deliberately clear expected interrupts handled in SW */
+	oc1 = st & OC_INTR_OC1_MASK;
+	oc2 = st & OC_INTR_OC2_MASK;
+	oc3 = st & OC_INTR_OC3_MASK;
+	oc4 = st & OC_INTR_OC4_MASK;
+	ex = oc1 | oc2 | oc3 | oc4;
+
+	pr_err("soctherm: OC ALARM 0x%08x\n", ex);
+	if (ex) {
+		writel(st, ts->regs + OC_INTR_STATUS);
+		st &= ~ex;
+
+		if (oc1 && !soctherm_handle_alarm(THROTTLE_OC1))
+			soctherm_oc_intr_enable(ts, THROTTLE_OC1, true);
+
+		if (oc2 && !soctherm_handle_alarm(THROTTLE_OC2))
+			soctherm_oc_intr_enable(ts, THROTTLE_OC2, true);
+
+		if (oc3 && !soctherm_handle_alarm(THROTTLE_OC3))
+			soctherm_oc_intr_enable(ts, THROTTLE_OC3, true);
+
+		if (oc4 && !soctherm_handle_alarm(THROTTLE_OC4))
+			soctherm_oc_intr_enable(ts, THROTTLE_OC4, true);
+
+		if (oc1 && soc_irq_cdata.irq_enable & BIT(0))
+			handle_nested_irq(
+				irq_find_mapping(soc_irq_cdata.domain, 0));
+
+		if (oc2 && soc_irq_cdata.irq_enable & BIT(1))
+			handle_nested_irq(
+				irq_find_mapping(soc_irq_cdata.domain, 1));
+
+		if (oc3 && soc_irq_cdata.irq_enable & BIT(2))
+			handle_nested_irq(
+				irq_find_mapping(soc_irq_cdata.domain, 2));
+
+		if (oc4 && soc_irq_cdata.irq_enable & BIT(3))
+			handle_nested_irq(
+				irq_find_mapping(soc_irq_cdata.domain, 3));
+	}
+
+	if (st) {
+		pr_err("soctherm: Ignored unexpected OC ALARM 0x%08x\n", st);
+		writel(st, ts->regs + OC_INTR_STATUS);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * soctherm_edp_isr() - Disables any active interrupts
+ * @irq:	The interrupt request number
+ * @arg:	Opaque pointer to an argument
+ *
+ * Writes to the OC_INTR_DISABLE register the over current interrupt status,
+ * masking any asserted interrupts. Doing this prevents the same interrupts
+ * from triggering this isr repeatedly. The thread woken by this isr will
+ * handle asserted interrupts and subsequently unmask/re-enable them.
+ *
+ * The OC_INTR_DISABLE register indicates which OC interrupts
+ * have been disabled.
+ *
+ * Return: %IRQ_WAKE_THREAD, handler requests to wake the handler thread
+ */
+static irqreturn_t soctherm_edp_isr(int irq, void *arg)
+{
+	struct tegra_soctherm *ts = arg;
+	u32 r;
+
+	if (!ts)
+		return IRQ_NONE;
+
+	r = readl(ts->regs + OC_INTR_STATUS);
+	writel(r, ts->regs + OC_INTR_DISABLE);
+
+	return IRQ_WAKE_THREAD;
+}
+
+/**
+ * soctherm_oc_irq_lock() - locks the over-current interrupt request
+ * @data:	Interrupt request data
+ *
+ * Looks up the chip data from @data and locks the mutex associated with
+ * a particular over-current interrupt request.
+ */
+static void soctherm_oc_irq_lock(struct irq_data *data)
+{
+	struct soctherm_oc_irq_chip_data *d = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&d->irq_lock);
+}
+
+/**
+ * soctherm_oc_irq_sync_unlock() - Unlocks the OC interrupt request
+ * @data:		Interrupt request data
+ *
+ * Looks up the interrupt request data @data and unlocks the mutex associated
+ * with a particular over-current interrupt request.
+ */
+static void soctherm_oc_irq_sync_unlock(struct irq_data *data)
+{
+	struct soctherm_oc_irq_chip_data *d = irq_data_get_irq_chip_data(data);
+
+	mutex_unlock(&d->irq_lock);
+}
+
+/**
+ * soctherm_oc_irq_enable() - Enables the SOC_THERM over-current interrupt queue
+ * @data:       irq_data structure of the chip
+ *
+ * Sets the irq_enable bit of SOC_THERM allowing SOC_THERM
+ * to respond to over-current interrupts.
+ *
+ */
+static void soctherm_oc_irq_enable(struct irq_data *data)
+{
+	struct soctherm_oc_irq_chip_data *d = irq_data_get_irq_chip_data(data);
+
+	d->irq_enable |= BIT(data->hwirq);
+}
+
+/**
+ * soctherm_oc_irq_disable() - Disables overcurrent interrupt requests
+ * @irq_data:	The interrupt request information
+ *
+ * Clears the interrupt request enable bit of the overcurrent
+ * interrupt request chip data.
+ *
+ * Return: Nothing is returned (void)
+ */
+static void soctherm_oc_irq_disable(struct irq_data *data)
+{
+	struct soctherm_oc_irq_chip_data *d = irq_data_get_irq_chip_data(data);
+
+	d->irq_enable &= ~BIT(data->hwirq);
+}
+
+static int soctherm_oc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	return 0;
+}
+
+/**
+ * soctherm_oc_irq_map() - SOC_THERM interrupt request domain mapper
+ * @h:		Interrupt request domain
+ * @virq:	Virtual interrupt request number
+ * @hw:		Hardware interrupt request number
+ *
+ * Mapping callback function for SOC_THERM's irq_domain. When a SOC_THERM
+ * interrupt request is called, the irq_domain takes the request's virtual
+ * request number (much like a virtual memory address) and maps it to a
+ * physical hardware request number.
+ *
+ * When a mapping doesn't already exist for a virtual request number, the
+ * irq_domain calls this function to associate the virtual request number with
+ * a hardware request number.
+ *
+ * Return: 0
+ */
+static int soctherm_oc_irq_map(struct irq_domain *h, unsigned int virq,
+		irq_hw_number_t hw)
+{
+	struct soctherm_oc_irq_chip_data *data = h->host_data;
+
+	irq_set_chip_data(virq, data);
+	irq_set_chip(virq, &data->irq_chip);
+	irq_set_nested_thread(virq, 1);
+	return 0;
+}
+
+/**
+ * soctherm_irq_domain_xlate_twocell() - xlate for soctherm interrupts
+ * @d:      Interrupt request domain
+ * @intspec:    Array of u32s from DTs "interrupt" property
+ * @intsize:    Number of values inside the intspec array
+ * @out_hwirq:  HW IRQ value associated with this interrupt
+ * @out_type:   The IRQ SENSE type for this interrupt.
+ *
+ * This Device Tree IRQ specifier translation function will translate a
+ * specific "interrupt" as defined by 2 DT values where the cell values map
+ * the hwirq number + 1 and linux irq flags. Since the output is the hwirq
+ * number, this function will subtract 1 from the value listed in DT.
+ *
+ * Return: 0
+ */
+static int soctherm_irq_domain_xlate_twocell(struct irq_domain *d,
+	struct device_node *ctrlr, const u32 *intspec, unsigned int intsize,
+	irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	if (WARN_ON(intsize < 2))
+		return -EINVAL;
+
+	/*
+	 * The HW value is 1 index less than the DT IRQ values.
+	 * i.e. OC4 goes to HW index 3.
+	 */
+	*out_hwirq = intspec[0] - 1;
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+
+static const struct irq_domain_ops soctherm_oc_domain_ops = {
+	.map	= soctherm_oc_irq_map,
+	.xlate	= soctherm_irq_domain_xlate_twocell,
+};
+
+/**
+ * soctherm_oc_int_init() - Initial enabling of the over
+ * current interrupts
+ * @np:	The devicetree node for soctherm
+ * @num_irqs:	The number of new interrupt requests
+ *
+ * Sets the over current interrupt request chip data
+ *
+ * Return: 0 on success or if overcurrent interrupts are not enabled,
+ * -ENOMEM (out of memory), or irq_base if the function failed to
+ * allocate the irqs
+ */
+static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
+{
+	if (!num_irqs) {
+		pr_info("%s(): OC interrupts are not enabled\n", __func__);
+		return 0;
+	}
+
+	mutex_init(&soc_irq_cdata.irq_lock);
+	soc_irq_cdata.irq_enable = 0;
+
+	soc_irq_cdata.irq_chip.name = "soc_therm_oc";
+	soc_irq_cdata.irq_chip.irq_bus_lock = soctherm_oc_irq_lock;
+	soc_irq_cdata.irq_chip.irq_bus_sync_unlock =
+		soctherm_oc_irq_sync_unlock;
+	soc_irq_cdata.irq_chip.irq_disable = soctherm_oc_irq_disable;
+	soc_irq_cdata.irq_chip.irq_enable = soctherm_oc_irq_enable;
+	soc_irq_cdata.irq_chip.irq_set_type = soctherm_oc_irq_set_type;
+	soc_irq_cdata.irq_chip.irq_set_wake = NULL;
+
+	soc_irq_cdata.domain = irq_domain_add_linear(np, num_irqs,
+						     &soctherm_oc_domain_ops,
+						     &soc_irq_cdata);
+
+	if (!soc_irq_cdata.domain) {
+		pr_err("%s: Failed to create IRQ domain\n", __func__);
+		return -ENOMEM;
+	}
+
+	pr_debug("%s(): OC interrupts enabled successful\n", __func__);
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int regs_show(struct seq_file *s, void *data)
 {
@@ -1482,14 +1877,27 @@ static void tegra_soctherm_throttle(struct device *dev)
 static int soctherm_interrupts_init(struct platform_device *pdev,
 				    struct tegra_soctherm *tegra)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	ret = soctherm_oc_int_init(np, TEGRA_SOC_OC_IRQ_MAX);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "soctherm_oc_int_init failed\n");
+		return ret;
+	}
+
 	tegra->thermal_irq = platform_get_irq(pdev, 0);
 	if (tegra->thermal_irq < 0) {
 		dev_dbg(&pdev->dev, "get 'thermal_irq' failed.\n");
 		return 0;
 	}
 
+	tegra->edp_irq = platform_get_irq(pdev, 1);
+	if (tegra->edp_irq < 0) {
+		dev_dbg(&pdev->dev, "get 'edp_irq' failed.\n");
+		return 0;
+	}
+
 	ret = devm_request_threaded_irq(&pdev->dev,
 					tegra->thermal_irq,
 					soctherm_thermal_isr,
@@ -1502,6 +1910,18 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 		return ret;
 	}
 
+	ret = devm_request_threaded_irq(&pdev->dev,
+					tegra->edp_irq,
+					soctherm_edp_isr,
+					soctherm_edp_isr_thread,
+					IRQF_ONESHOT,
+					"soctherm_edp",
+					tegra);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

