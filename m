Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965181AbeEIPqw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:46:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54772 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965129AbeEIPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:46:48 -0400
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
Subject: [PATCH v2 1/3] rtc: stm32: rework register management to prepare other version of RTC
Date: Wed, 9 May 2018 17:46:08 +0200
Message-ID: <1525880770-22263-2-git-send-email-amelie.delaunay@st.com>
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

This patch reworks register/bits management because next version of RTC
uses the same way of working but with different register's offset or bits
moved in new registers.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 188 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 129 insertions(+), 59 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index de49b5b..52ee027 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -16,15 +16,6 @@
 
 #define DRIVER_NAME "stm32_rtc"
 
-/* STM32 RTC registers */
-#define STM32_RTC_TR		0x00
-#define STM32_RTC_DR		0x04
-#define STM32_RTC_CR		0x08
-#define STM32_RTC_ISR		0x0C
-#define STM32_RTC_PRER		0x10
-#define STM32_RTC_ALRMAR	0x1C
-#define STM32_RTC_WPR		0x24
-
 /* STM32_RTC_TR bit fields  */
 #define STM32_RTC_TR_SEC_SHIFT		0
 #define STM32_RTC_TR_SEC		GENMASK(6, 0)
@@ -85,7 +76,26 @@
 #define RTC_WPR_2ND_KEY			0x53
 #define RTC_WPR_WRONG_KEY		0xFF
 
+struct stm32_rtc;
+
+struct stm32_rtc_registers {
+	u8 tr;
+	u8 dr;
+	u8 cr;
+	u8 isr;
+	u8 prer;
+	u8 alrmar;
+	u8 wpr;
+};
+
+struct stm32_rtc_events {
+	u32 alra;
+};
+
 struct stm32_rtc_data {
+	const struct stm32_rtc_registers regs;
+	const struct stm32_rtc_events events;
+	void (*clear_events)(struct stm32_rtc *rtc, unsigned int flags);
 	bool has_pclk;
 	bool need_dbp;
 };
@@ -96,30 +106,35 @@ struct stm32_rtc {
 	struct regmap *dbp;
 	unsigned int dbp_reg;
 	unsigned int dbp_mask;
-	struct stm32_rtc_data *data;
 	struct clk *pclk;
 	struct clk *rtc_ck;
+	const struct stm32_rtc_data *data;
 	int irq_alarm;
 };
 
 static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
 {
-	writel_relaxed(RTC_WPR_1ST_KEY, rtc->base + STM32_RTC_WPR);
-	writel_relaxed(RTC_WPR_2ND_KEY, rtc->base + STM32_RTC_WPR);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+
+	writel_relaxed(RTC_WPR_1ST_KEY, rtc->base + regs.wpr);
+	writel_relaxed(RTC_WPR_2ND_KEY, rtc->base + regs.wpr);
 }
 
 static void stm32_rtc_wpr_lock(struct stm32_rtc *rtc)
 {
-	writel_relaxed(RTC_WPR_WRONG_KEY, rtc->base + STM32_RTC_WPR);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+
+	writel_relaxed(RTC_WPR_WRONG_KEY, rtc->base + regs.wpr);
 }
 
 static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 {
-	unsigned int isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int isr = readl_relaxed(rtc->base + regs.isr);
 
 	if (!(isr & STM32_RTC_ISR_INITF)) {
 		isr |= STM32_RTC_ISR_INIT;
-		writel_relaxed(isr, rtc->base + STM32_RTC_ISR);
+		writel_relaxed(isr, rtc->base + regs.isr);
 
 		/*
 		 * It takes around 2 rtc_ck clock cycles to enter in
@@ -128,7 +143,7 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 		 * 1MHz, we poll every 10 us with a timeout of 100ms.
 		 */
 		return readl_relaxed_poll_timeout_atomic(
-					rtc->base + STM32_RTC_ISR,
+					rtc->base + regs.isr,
 					isr, (isr & STM32_RTC_ISR_INITF),
 					10, 100000);
 	}
@@ -138,40 +153,50 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 
 static void stm32_rtc_exit_init_mode(struct stm32_rtc *rtc)
 {
-	unsigned int isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int isr = readl_relaxed(rtc->base + regs.isr);
 
 	isr &= ~STM32_RTC_ISR_INIT;
-	writel_relaxed(isr, rtc->base + STM32_RTC_ISR);
+	writel_relaxed(isr, rtc->base + regs.isr);
 }
 
 static int stm32_rtc_wait_sync(struct stm32_rtc *rtc)
 {
-	unsigned int isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	unsigned int isr = readl_relaxed(rtc->base + regs.isr);
 
 	isr &= ~STM32_RTC_ISR_RSF;
-	writel_relaxed(isr, rtc->base + STM32_RTC_ISR);
+	writel_relaxed(isr, rtc->base + regs.isr);
 
 	/*
 	 * Wait for RSF to be set to ensure the calendar registers are
 	 * synchronised, it takes around 2 rtc_ck clock cycles
 	 */
-	return readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
+	return readl_relaxed_poll_timeout_atomic(rtc->base + regs.isr,
 						 isr,
 						 (isr & STM32_RTC_ISR_RSF),
 						 10, 100000);
 }
 
+static void stm32_rtc_clear_event_flags(struct stm32_rtc *rtc,
+					unsigned int flags)
+{
+	rtc->data->clear_events(rtc, flags);
+}
+
 static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
 {
 	struct stm32_rtc *rtc = (struct stm32_rtc *)dev_id;
-	unsigned int isr, cr;
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	struct stm32_rtc_events evts = rtc->data->events;
+	unsigned int status, cr;
 
 	mutex_lock(&rtc->rtc_dev->ops_lock);
 
-	isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
+	status = readl_relaxed(rtc->base + regs.isr);
+	cr = readl_relaxed(rtc->base + regs.cr);
 
-	if ((isr & STM32_RTC_ISR_ALRAF) &&
+	if ((status & evts.alra) &&
 	    (cr & STM32_RTC_CR_ALRAIE)) {
 		/* Alarm A flag - Alarm interrupt */
 		dev_dbg(&rtc->rtc_dev->dev, "Alarm occurred\n");
@@ -179,9 +204,8 @@ static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
 		/* Pass event to the kernel */
 		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
 
-		/* Clear event flag, otherwise new events won't be received */
-		writel_relaxed(isr & ~STM32_RTC_ISR_ALRAF,
-			       rtc->base + STM32_RTC_ISR);
+		/* Clear event flags, otherwise new events won't be received */
+		stm32_rtc_clear_event_flags(rtc, evts.alra);
 	}
 
 	mutex_unlock(&rtc->rtc_dev->ops_lock);
@@ -228,11 +252,12 @@ static void bcd2tm(struct rtc_time *tm)
 static int stm32_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	unsigned int tr, dr;
 
 	/* Time and Date in BCD format */
-	tr = readl_relaxed(rtc->base + STM32_RTC_TR);
-	dr = readl_relaxed(rtc->base + STM32_RTC_DR);
+	tr = readl_relaxed(rtc->base + regs.tr);
+	dr = readl_relaxed(rtc->base + regs.dr);
 
 	tm->tm_sec = (tr & STM32_RTC_TR_SEC) >> STM32_RTC_TR_SEC_SHIFT;
 	tm->tm_min = (tr & STM32_RTC_TR_MIN) >> STM32_RTC_TR_MIN_SHIFT;
@@ -253,6 +278,7 @@ static int stm32_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int stm32_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	unsigned int tr, dr;
 	int ret = 0;
 
@@ -277,8 +303,8 @@ static int stm32_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		goto end;
 	}
 
-	writel_relaxed(tr, rtc->base + STM32_RTC_TR);
-	writel_relaxed(dr, rtc->base + STM32_RTC_DR);
+	writel_relaxed(tr, rtc->base + regs.tr);
+	writel_relaxed(dr, rtc->base + regs.dr);
 
 	stm32_rtc_exit_init_mode(rtc);
 
@@ -292,12 +318,14 @@ static int stm32_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	struct stm32_rtc_events evts = rtc->data->events;
 	struct rtc_time *tm = &alrm->time;
-	unsigned int alrmar, cr, isr;
+	unsigned int alrmar, cr, status;
 
-	alrmar = readl_relaxed(rtc->base + STM32_RTC_ALRMAR);
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
-	isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
+	alrmar = readl_relaxed(rtc->base + regs.alrmar);
+	cr = readl_relaxed(rtc->base + regs.cr);
+	status = readl_relaxed(rtc->base + regs.isr);
 
 	if (alrmar & STM32_RTC_ALRMXR_DATE_MASK) {
 		/*
@@ -350,7 +378,7 @@ static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	bcd2tm(tm);
 
 	alrm->enabled = (cr & STM32_RTC_CR_ALRAE) ? 1 : 0;
-	alrm->pending = (isr & STM32_RTC_ISR_ALRAF) ? 1 : 0;
+	alrm->pending = (status & evts.alra) ? 1 : 0;
 
 	return 0;
 }
@@ -358,9 +386,11 @@ static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
-	unsigned int isr, cr;
+	struct stm32_rtc_registers regs = rtc->data->regs;
+	struct stm32_rtc_events evts = rtc->data->events;
+	unsigned int cr;
 
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
+	cr = readl_relaxed(rtc->base + regs.cr);
 
 	stm32_rtc_wpr_unlock(rtc);
 
@@ -369,12 +399,10 @@ static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 		cr |= (STM32_RTC_CR_ALRAIE | STM32_RTC_CR_ALRAE);
 	else
 		cr &= ~(STM32_RTC_CR_ALRAIE | STM32_RTC_CR_ALRAE);
-	writel_relaxed(cr, rtc->base + STM32_RTC_CR);
+	writel_relaxed(cr, rtc->base + regs.cr);
 
-	/* Clear event flag, otherwise new events won't be received */
-	isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
-	isr &= ~STM32_RTC_ISR_ALRAF;
-	writel_relaxed(isr, rtc->base + STM32_RTC_ISR);
+	/* Clear event flags, otherwise new events won't be received */
+	stm32_rtc_clear_event_flags(rtc, evts.alra);
 
 	stm32_rtc_wpr_lock(rtc);
 
@@ -383,9 +411,10 @@ static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
 {
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
-	unsigned int dr = readl_relaxed(rtc->base + STM32_RTC_DR);
-	unsigned int tr = readl_relaxed(rtc->base + STM32_RTC_TR);
+	unsigned int dr = readl_relaxed(rtc->base + regs.dr);
+	unsigned int tr = readl_relaxed(rtc->base + regs.tr);
 
 	cur_day = (dr & STM32_RTC_DR_DATE) >> STM32_RTC_DR_DATE_SHIFT;
 	cur_mon = (dr & STM32_RTC_DR_MONTH) >> STM32_RTC_DR_MONTH_SHIFT;
@@ -419,6 +448,7 @@ static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
 static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	struct rtc_time *tm = &alrm->time;
 	unsigned int cr, isr, alrmar;
 	int ret = 0;
@@ -450,15 +480,15 @@ static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	stm32_rtc_wpr_unlock(rtc);
 
 	/* Disable Alarm */
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
+	cr = readl_relaxed(rtc->base + regs.cr);
 	cr &= ~STM32_RTC_CR_ALRAE;
-	writel_relaxed(cr, rtc->base + STM32_RTC_CR);
+	writel_relaxed(cr, rtc->base + regs.cr);
 
 	/*
 	 * Poll Alarm write flag to be sure that Alarm update is allowed: it
 	 * takes around 2 rtc_ck clock cycles
 	 */
-	ret = readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
+	ret = readl_relaxed_poll_timeout_atomic(rtc->base + regs.isr,
 						isr,
 						(isr & STM32_RTC_ISR_ALRAWF),
 						10, 100000);
@@ -469,7 +499,7 @@ static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	}
 
 	/* Write to Alarm register */
-	writel_relaxed(alrmar, rtc->base + STM32_RTC_ALRMAR);
+	writel_relaxed(alrmar, rtc->base + regs.alrmar);
 
 	if (alrm->enabled)
 		stm32_rtc_alarm_irq_enable(dev, 1);
@@ -490,14 +520,50 @@ static const struct rtc_class_ops stm32_rtc_ops = {
 	.alarm_irq_enable = stm32_rtc_alarm_irq_enable,
 };
 
+static void stm32_rtc_clear_events(struct stm32_rtc *rtc,
+				   unsigned int flags)
+{
+	struct stm32_rtc_registers regs = rtc->data->regs;
+
+	/* Flags are cleared by writing 0 in RTC_ISR */
+	writel_relaxed(readl_relaxed(rtc->base + regs.isr) & ~flags,
+		       rtc->base + regs.isr);
+}
+
 static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
 	.need_dbp = true,
+	.regs = {
+		.tr = 0x00,
+		.dr = 0x04,
+		.cr = 0x08,
+		.isr = 0x0C,
+		.prer = 0x10,
+		.alrmar = 0x1C,
+		.wpr = 0x24,
+	},
+	.events = {
+		.alra = STM32_RTC_ISR_ALRAF,
+	},
+	.clear_events = stm32_rtc_clear_events,
 };
 
 static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
 	.need_dbp = true,
+	.regs = {
+		.tr = 0x00,
+		.dr = 0x04,
+		.cr = 0x08,
+		.isr = 0x0C,
+		.prer = 0x10,
+		.alrmar = 0x1C,
+		.wpr = 0x24,
+	},
+	.events = {
+		.alra = STM32_RTC_ISR_ALRAF,
+	},
+	.clear_events = stm32_rtc_clear_events,
 };
 
 static const struct of_device_id stm32_rtc_of_match[] = {
@@ -510,6 +576,7 @@ MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
 static int stm32_rtc_init(struct platform_device *pdev,
 			  struct stm32_rtc *rtc)
 {
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	unsigned int prer, pred_a, pred_s, pred_a_max, pred_s_max, cr;
 	unsigned int rate;
 	int ret = 0;
@@ -550,14 +617,14 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	}
 
 	prer = (pred_s << STM32_RTC_PRER_PRED_S_SHIFT) & STM32_RTC_PRER_PRED_S;
-	writel_relaxed(prer, rtc->base + STM32_RTC_PRER);
+	writel_relaxed(prer, rtc->base + regs.prer);
 	prer |= (pred_a << STM32_RTC_PRER_PRED_A_SHIFT) & STM32_RTC_PRER_PRED_A;
-	writel_relaxed(prer, rtc->base + STM32_RTC_PRER);
+	writel_relaxed(prer, rtc->base + regs.prer);
 
 	/* Force 24h time format */
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
+	cr = readl_relaxed(rtc->base + regs.cr);
 	cr &= ~STM32_RTC_CR_FMT;
-	writel_relaxed(cr, rtc->base + STM32_RTC_CR);
+	writel_relaxed(cr, rtc->base + regs.cr);
 
 	stm32_rtc_exit_init_mode(rtc);
 
@@ -571,6 +638,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 static int stm32_rtc_probe(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc;
+	struct stm32_rtc_registers regs;
 	struct resource *res;
 	int ret;
 
@@ -585,6 +653,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	rtc->data = (struct stm32_rtc_data *)
 		    of_device_get_match_data(&pdev->dev);
+	regs = rtc->data->regs;
 
 	if (rtc->data->need_dbp) {
 		rtc->dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
@@ -641,7 +710,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	/*
 	 * After a system reset, RTC_ISR.INITS flag can be read to check if
-	 * the calendar has been initalized or not. INITS flag is reset by a
+	 * the calendar has been initialized or not. INITS flag is reset by a
 	 * power-on reset (no vbat, no power-supply). It is not reset if
 	 * rtc_ck parent clock has changed (so RTC prescalers need to be
 	 * changed). That's why we cannot rely on this flag to know if RTC
@@ -666,7 +735,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 			 "alarm won't be able to wake up the system");
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-			&stm32_rtc_ops, THIS_MODULE);
+						&stm32_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		ret = PTR_ERR(rtc->rtc_dev);
 		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
@@ -688,7 +757,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	 * If INITS flag is reset (calendar year field set to 0x00), calendar
 	 * must be initialized
 	 */
-	if (!(readl_relaxed(rtc->base + STM32_RTC_ISR) & STM32_RTC_ISR_INITS))
+	if (!(readl_relaxed(rtc->base + regs.isr) & STM32_RTC_ISR_INITS))
 		dev_warn(&pdev->dev, "Date/Time must be initialized\n");
 
 	return 0;
@@ -708,13 +777,14 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 static int stm32_rtc_remove(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	struct stm32_rtc_registers regs = rtc->data->regs;
 	unsigned int cr;
 
 	/* Disable interrupts */
 	stm32_rtc_wpr_unlock(rtc);
-	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
+	cr = readl_relaxed(rtc->base + regs.cr);
 	cr &= ~STM32_RTC_CR_ALRAIE;
-	writel_relaxed(cr, rtc->base + STM32_RTC_CR);
+	writel_relaxed(cr, rtc->base + regs.cr);
 	stm32_rtc_wpr_lock(rtc);
 
 	clk_disable_unprepare(rtc->rtc_ck);
-- 
2.7.4
