Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965145AbeEIPqs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:46:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37247 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965087AbeEIPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:46:45 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Date: Wed, 9 May 2018 17:46:10 +0200
Message-ID: <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for stm32mp1 RTC.
Some common registers with previous RTC version have a different offset.
It is the case for Control Register (CR) and ALaRMA Register (ALRMAR).
There are also new registers regarding event flags: now, Alarm event flag
is in Status Register (SR) and write 1 in Status Clear Register (SCR) is
required to clear the event.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 88 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 52ee027..45e0175 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 
@@ -39,7 +40,7 @@
 #define STM32_RTC_CR_ALRAE		BIT(8)
 #define STM32_RTC_CR_ALRAIE		BIT(12)
 
-/* STM32_RTC_ISR bit fields */
+/* STM32_RTC_ISR/STM32_RTC_ICSR bit fields */
 #define STM32_RTC_ISR_ALRAWF		BIT(0)
 #define STM32_RTC_ISR_INITS		BIT(4)
 #define STM32_RTC_ISR_RSF		BIT(5)
@@ -71,11 +72,22 @@
 #define STM32_RTC_ALRMXR_WDAY		GENMASK(27, 24)
 #define STM32_RTC_ALRMXR_DATE_MASK	BIT(31)
 
+/* STM32_RTC_SR/_SCR bit fields */
+#define STM32_RTC_SR_ALRA		BIT(0)
+
+/* STM32_RTC_VERR bit fields */
+#define STM32_RTC_VERR_MINREV_SHIFT	0
+#define STM32_RTC_VERR_MINREV		GENMASK(3, 0)
+#define STM32_RTC_VERR_MAJREV_SHIFT	4
+#define STM32_RTC_VERR_MAJREV		GENMASK(7, 4)
+
 /* STM32_RTC_WPR key constants */
 #define RTC_WPR_1ST_KEY			0xCA
 #define RTC_WPR_2ND_KEY			0x53
 #define RTC_WPR_WRONG_KEY		0xFF
 
+#define UNDEF_REG ~0
+
 struct stm32_rtc;
 
 struct stm32_rtc_registers {
@@ -86,6 +98,9 @@ struct stm32_rtc_registers {
 	u8 prer;
 	u8 alrmar;
 	u8 wpr;
+	u8 sr;
+	u8 scr;
+	u16 verr;
 };
 
 struct stm32_rtc_events {
@@ -98,6 +113,7 @@ struct stm32_rtc_data {
 	void (*clear_events)(struct stm32_rtc *rtc, unsigned int flags);
 	bool has_pclk;
 	bool need_dbp;
+	bool has_wakeirq;
 };
 
 struct stm32_rtc {
@@ -110,6 +126,7 @@ struct stm32_rtc {
 	struct clk *rtc_ck;
 	const struct stm32_rtc_data *data;
 	int irq_alarm;
+	int wakeirq_alarm;
 };
 
 static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
@@ -193,7 +210,7 @@ static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
 
 	mutex_lock(&rtc->rtc_dev->ops_lock);
 
-	status = readl_relaxed(rtc->base + regs.isr);
+	status = readl_relaxed(rtc->base + regs.sr);
 	cr = readl_relaxed(rtc->base + regs.cr);
 
 	if ((status & evts.alra) &&
@@ -325,7 +342,7 @@ static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrmar = readl_relaxed(rtc->base + regs.alrmar);
 	cr = readl_relaxed(rtc->base + regs.cr);
-	status = readl_relaxed(rtc->base + regs.isr);
+	status = readl_relaxed(rtc->base + regs.sr);
 
 	if (alrmar & STM32_RTC_ALRMXR_DATE_MASK) {
 		/*
@@ -533,6 +550,7 @@ static void stm32_rtc_clear_events(struct stm32_rtc *rtc,
 static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
 	.need_dbp = true,
+	.has_wakeirq = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -541,6 +559,9 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 		.prer = 0x10,
 		.alrmar = 0x1C,
 		.wpr = 0x24,
+		.sr = 0x0C, /* set to ISR offset to ease alarm management */
+		.scr = UNDEF_REG,
+		.verr = UNDEF_REG,
 	},
 	.events = {
 		.alra = STM32_RTC_ISR_ALRAF,
@@ -551,6 +572,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
 static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
 	.need_dbp = true,
+	.has_wakeirq = false,
 	.regs = {
 		.tr = 0x00,
 		.dr = 0x04,
@@ -559,6 +581,9 @@ static const struct stm32_rtc_data stm32h7_rtc_data = {
 		.prer = 0x10,
 		.alrmar = 0x1C,
 		.wpr = 0x24,
+		.sr = 0x0C, /* set to ISR offset to ease alarm management */
+		.scr = UNDEF_REG,
+		.verr = UNDEF_REG,
 	},
 	.events = {
 		.alra = STM32_RTC_ISR_ALRAF,
@@ -566,9 +591,41 @@ static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.clear_events = stm32_rtc_clear_events,
 };
 
+static void stm32mp1_rtc_clear_events(struct stm32_rtc *rtc,
+				      unsigned int flags)
+{
+	struct stm32_rtc_registers regs = rtc->data->regs;
+
+	/* Flags are cleared by writing 1 in RTC_SCR */
+	writel_relaxed(flags, rtc->base + regs.scr);
+}
+
+static const struct stm32_rtc_data stm32mp1_data = {
+	.has_pclk = true,
+	.need_dbp = false,
+	.has_wakeirq = true,
+	.regs = {
+		.tr = 0x00,
+		.dr = 0x04,
+		.cr = 0x18,
+		.isr = 0x0C, /* named RTC_ICSR on stm32mp1 */
+		.prer = 0x10,
+		.alrmar = 0x40,
+		.wpr = 0x24,
+		.sr = 0x50,
+		.scr = 0x5C,
+		.verr = 0x3F4,
+	},
+	.events = {
+		.alra = STM32_RTC_SR_ALRA,
+	},
+	.clear_events = stm32mp1_rtc_clear_events,
+};
+
 static const struct of_device_id stm32_rtc_of_match[] = {
 	{ .compatible = "st,stm32-rtc", .data = &stm32_rtc_data },
 	{ .compatible = "st,stm32h7-rtc", .data = &stm32h7_rtc_data },
+	{ .compatible = "st,stm32mp1-rtc", .data = &stm32mp1_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
@@ -727,12 +784,19 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	platform_set_drvdata(pdev, rtc);
-
 	ret = device_init_wakeup(&pdev->dev, true);
+	if (rtc->data->has_wakeirq) {
+		rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
+		if (rtc->wakeirq_alarm <= 0)
+			ret = rtc->wakeirq_alarm;
+		else
+			ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
+							    rtc->wakeirq_alarm);
+	}
 	if (ret)
-		dev_warn(&pdev->dev,
-			 "alarm won't be able to wake up the system");
+		dev_warn(&pdev->dev, "alarm can't wake up the system: %d", ret);
+
+	platform_set_drvdata(pdev, rtc);
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
 						&stm32_rtc_ops, THIS_MODULE);
@@ -760,6 +824,14 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (!(readl_relaxed(rtc->base + regs.isr) & STM32_RTC_ISR_INITS))
 		dev_warn(&pdev->dev, "Date/Time must be initialized\n");
 
+	if (regs.verr != UNDEF_REG) {
+		u32 ver = readl_relaxed(rtc->base + regs.verr);
+
+		dev_info(&pdev->dev, "registered rev:%d.%d\n",
+			 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
+			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
+	}
+
 	return 0;
 err:
 	if (rtc->data->has_pclk)
@@ -769,6 +841,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 
 	return ret;
@@ -795,6 +868,7 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 
 	return 0;
-- 
2.7.4
