Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeDCNB7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:01:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35683 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeDCNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:01:55 -0400
X-Google-Smtp-Source: AIpwx48Hg2AskbW6bntwvQTUzG9wGuANYjRv+5o9oihGDbL7AOoxMKWjfCUTxQaX2PT9JLBY+kXwOw==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 6/6] clocksource/drivers/imx-tpm: Add different counter width support
Date: Tue,  3 Apr 2018 15:00:30 +0200
Message-Id: <1522760432-32048-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
 <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Different TPM modules have different width counters which is 16-bit or 32-bit,
the counter width can be read from TPM_PARAM register bit[23:16], this patch
adds dynamic check for counter width to support both 16-bit and 32-bit TPM
modules.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 7403e49..05d97a6 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -17,9 +17,13 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#define TPM_PARAM			0x4
+#define TPM_PARAM_WIDTH_SHIFT		16
+#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_SC_CMOD_DIV_MAX		0x7
 #define TPM_SC_TOF_MASK			(0x1 << 7)
 #define TPM_CNT				0x14
 #define TPM_MOD				0x18
@@ -33,6 +37,8 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
+static int counter_width;
+static int rating;
 static void __iomem *timer_base;
 static struct clock_event_device clockevent_tpm;
 
@@ -85,10 +91,11 @@ static int __init tpm_clocksource_init(unsigned long rate)
 	tpm_delay_timer.freq = rate;
 	register_current_timer_delay(&tpm_delay_timer);
 
-	sched_clock_register(tpm_read_sched_clock, 32, rate);
+	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
 
 	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, 200, 32, clocksource_mmio_readl_up);
+				     rate, rating, counter_width,
+				     clocksource_mmio_readl_up);
 }
 
 static int tpm_set_next_event(unsigned long delta,
@@ -141,7 +148,6 @@ static struct clock_event_device clockevent_tpm = {
 	.set_state_oneshot	= tpm_set_state_oneshot,
 	.set_next_event		= tpm_set_next_event,
 	.set_state_shutdown	= tpm_set_state_shutdown,
-	.rating			= 200,
 };
 
 static int __init tpm_clockevent_init(unsigned long rate, int irq)
@@ -151,10 +157,11 @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
 	ret = request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			  "i.MX7ULP TPM Timer", &clockevent_tpm);
 
+	clockevent_tpm.rating = rating;
 	clockevent_tpm.cpumask = cpumask_of(0);
 	clockevent_tpm.irq = irq;
-	clockevents_config_and_register(&clockevent_tpm,
-					rate, 300, 0xfffffffe);
+	clockevents_config_and_register(&clockevent_tpm, rate, 300,
+					GENMASK(counter_width - 1, 1));
 
 	return ret;
 }
@@ -199,6 +206,11 @@ static int __init tpm_timer_init(struct device_node *np)
 		goto err_per_clk_enable;
 	}
 
+	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
+		>> TPM_PARAM_WIDTH_SHIFT;
+	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
+	rating = counter_width == 0x20 ? 200 : 150;
+
 	/*
 	 * Initialize tpm module to a known state
 	 * 1) Counter disabled
@@ -215,12 +227,17 @@ static int __init tpm_timer_init(struct device_node *np)
 	/* CHF is W1C */
 	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
 
-	/* increase per cnt, div 8 by default */
-	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
+	/*
+	 * increase per cnt,
+	 * div 8 for 32-bit counter and div 128 for 16-bit counter
+	 */
+	writel(TPM_SC_CMOD_INC_PER_CNT |
+		(counter_width == 0x20 ?
+		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
 		     timer_base + TPM_SC);
 
 	/* set MOD register to maximum for free running mode */
-	writel(0xffffffff, timer_base + TPM_MOD);
+	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
 
 	rate = clk_get_rate(per) >> 3;
 	ret = tpm_clocksource_init(rate);
-- 
2.7.4
