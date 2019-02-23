Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF94C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033B20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6ukx1OC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfBWNIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52488 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfBWNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so4274252wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZP0UsIfUr5CMc4uOaLIcITOIHDvPRz2+Lu8XUazvZE=;
        b=B6ukx1OCK475+MB6G0xqQT4oQ5FXN6pE4zp1GGULh86698lqOiUdTlNDOa1j5EmTqz
         egJAyGA3RocTLPxmr2cT1eWcNXmLJ14sH5r/+Id35D0QfqWl+NbQOnWShXpLw+bzCKqk
         CFnjTewFjfHp80UJvv3eaBh+sOa5dtcIBx6WAie4VXGScFua0oLC2SHUNxiX1cB0sY4B
         ZYKypqH3WBaxy3DrlHQKAXBtIUt0bxVTvQAyLh5HLTCEbGLcg88KSVWCWQgDXm6E3uVu
         v+kwpEgqyJXH/TZ2ht4t0i3YapFYe55Yg1Gm4Kukkhibg70Tk3UgfmBgjpKphOwyQD4E
         847A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZP0UsIfUr5CMc4uOaLIcITOIHDvPRz2+Lu8XUazvZE=;
        b=Nh6scriIisX/nJGx6akUwRjDwhT/FTsxkOsr2xTRQsRA2gFS/gXdOHyHD2bsNVZaE9
         T1a3thrJ+P6OmUdDTwK2jjiTyKlD2dRWmOX/izrS8n2oCvQQHEaNxSBTCYIMXdYQcs4Z
         PPWESqSSTZKrD2T+HJTNdQylKksNHfA/tiQz5JVlrtN/UAUKT0fy9OWLoUb76rPD8UCH
         1rno6fid1QxL/SfnSJeH017f/OOVIcg2eRpa61Hdf1BJYbz8k15ipFVAV4mRL09UtwV7
         6SpERd0DO9OvxCEATSKScI2tQLMrSX0UFNiGx3i2b4CYUen4mR+qgLI0ut29FAUqd5j0
         JAww==
X-Gm-Message-State: AHQUAuaSBEVga48VTgNtx/ICOLtxs39N95oanivjsyGa5/3YcxG5ghsh
        khh4B0UhfK1e8D5tKYEpHGNn/g==
X-Google-Smtp-Source: AHgI3Ib249E6vOcz9mVKCNhKI3xXxNASiNccOZSUXbOciVePxLlT9wKR6J0O6GdO6HK3hQphnz4IsA==
X-Received: by 2002:a1c:a797:: with SMTP id q145mr5647250wme.6.1550927312079;
        Sat, 23 Feb 2019 05:08:32 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Guo Ren <ren_guo@c-sky.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 17/18] clocksource/drivers/tegra: Add Tegra210 timer support
Date:   Sat, 23 Feb 2019 14:07:05 +0100
Message-Id: <20190223130707.16704-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Lo <josephl@nvidia.com>

Add support for the Tegra210 timer that runs at oscillator clock
(TMR10-TMR13). We need these timers to work as clock event device and to
replace the ARMv8 architected timer due to it can't survive across the
power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
source when CPU suspends in power down state.

Also convert the original driver to use timer-of API.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         |   3 +-
 drivers/clocksource/timer-tegra20.c | 370 +++++++++++++++++++---------
 include/linux/cpuhotplug.h          |   1 +
 3 files changed, 262 insertions(+), 112 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8dfd3bc448d0..5d93e580e5dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -131,7 +131,8 @@ config SUN5I_HSTIMER
 config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
-	depends on ARM
+	select TIMER_OF
+	depends on ARM || ARM64
 	help
 	  Enables support for the Tegra driver.
 
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 4293943f4e2b..fdb3d795a409 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -15,21 +15,24 @@
  *
  */
 
-#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/time.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/percpu.h>
 #include <linux/sched_clock.h>
-#include <linux/delay.h>
+#include <linux/time.h>
+
+#include "timer-of.h"
 
+#ifdef CONFIG_ARM
 #include <asm/mach/time.h>
+#endif
 
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
@@ -39,74 +42,161 @@
 #define TIMERUS_USEC_CFG 0x14
 #define TIMERUS_CNTR_FREEZE 0x4c
 
-#define TIMER1_BASE 0x0
-#define TIMER2_BASE 0x8
-#define TIMER3_BASE 0x50
-#define TIMER4_BASE 0x58
-
-#define TIMER_PTV 0x0
-#define TIMER_PCR 0x4
-
+#define TIMER_PTV		0x0
+#define TIMER_PTV_EN		BIT(31)
+#define TIMER_PTV_PER		BIT(30)
+#define TIMER_PCR		0x4
+#define TIMER_PCR_INTR_CLR	BIT(30)
+
+#ifdef CONFIG_ARM
+#define TIMER_CPU0		0x50 /* TIMER3 */
+#else
+#define TIMER_CPU0		0x90 /* TIMER10 */
+#define TIMER10_IRQ_IDX		10
+#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
+#endif
+#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
+
+static u32 usec_config;
 static void __iomem *timer_reg_base;
+#ifdef CONFIG_ARM
 static void __iomem *rtc_base;
-
 static struct timespec64 persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
-
 static struct delay_timer tegra_delay_timer;
-
-#define timer_writel(value, reg) \
-	writel_relaxed(value, timer_reg_base + (reg))
-#define timer_readl(reg) \
-	readl_relaxed(timer_reg_base + (reg))
+#endif
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	u32 reg;
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
-	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+	writel(TIMER_PTV_EN |
+	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+	       reg_base + TIMER_PTV);
 
 	return 0;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
-	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(0, reg_base + TIMER_PTV);
+
+	return 0;
 }
 
-static int tegra_timer_shutdown(struct clock_event_device *evt)
+static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PTV_EN | TIMER_PTV_PER |
+	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	       reg_base + TIMER_PTV);
+
 	return 0;
 }
 
-static int tegra_timer_set_periodic(struct clock_event_device *evt)
+static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void tegra_timer_suspend(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+}
+
+static void tegra_timer_resume(struct clock_event_device *evt)
+{
+	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+}
+
+#ifdef CONFIG_ARM64
+static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "tegra_timer",
+		.rating = 460,
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_next_event = tegra_timer_set_next_event,
+		.set_state_shutdown = tegra_timer_shutdown,
+		.set_state_periodic = tegra_timer_set_periodic,
+		.set_state_oneshot = tegra_timer_shutdown,
+		.tick_resume = tegra_timer_shutdown,
+		.suspend = tegra_timer_suspend,
+		.resume = tegra_timer_resume,
+	},
+};
+
+static int tegra_timer_setup(unsigned int cpu)
 {
-	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
+	enable_irq(to->clkevt.irq);
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					1, /* min */
+					0x1fffffff); /* 29 bits */
 
-	timer_shutdown(evt);
-	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
 	return 0;
 }
 
-static struct clock_event_device tegra_clockevent = {
-	.name			= "timer0",
-	.rating			= 300,
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_DYNIRQ,
-	.set_next_event		= tegra_timer_set_next_event,
-	.set_state_shutdown	= tegra_timer_shutdown,
-	.set_state_periodic	= tegra_timer_set_periodic,
-	.set_state_oneshot	= tegra_timer_shutdown,
-	.tick_resume		= tegra_timer_shutdown,
+static int tegra_timer_stop(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	to->clkevt.set_state_shutdown(&to->clkevt);
+	disable_irq_nosync(to->clkevt.irq);
+
+	return 0;
+}
+#else /* CONFIG_ARM */
+static struct timer_of tegra_to = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
+
+	.clkevt = {
+		.name = "tegra_timer",
+		.rating	= 300,
+		.features = CLOCK_EVT_FEAT_ONESHOT |
+			    CLOCK_EVT_FEAT_PERIODIC |
+			    CLOCK_EVT_FEAT_DYNIRQ,
+		.set_next_event	= tegra_timer_set_next_event,
+		.set_state_shutdown = tegra_timer_shutdown,
+		.set_state_periodic = tegra_timer_set_periodic,
+		.set_state_oneshot = tegra_timer_shutdown,
+		.tick_resume = tegra_timer_shutdown,
+		.suspend = tegra_timer_suspend,
+		.resume = tegra_timer_resume,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.index = 2,
+		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
+		.handler = tegra_timer_isr,
+	},
 };
 
 static u64 notrace tegra_read_sched_clock(void)
 {
-	return timer_readl(TIMERUS_CNTR_1US);
+	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+}
+
+static unsigned long tegra_delay_timer_read_counter_long(void)
+{
+	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 /*
@@ -143,100 +233,155 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
 	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
 	*ts = persistent_ts;
 }
+#endif
 
-static unsigned long tegra_delay_timer_read_counter_long(void)
-{
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
-}
-
-static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static struct irqaction tegra_timer_irq = {
-	.name		= "timer0",
-	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
-	.handler	= tegra_timer_interrupt,
-	.dev_id		= &tegra_clockevent,
-};
-
-static int __init tegra20_init_timer(struct device_node *np)
+static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
 {
-	struct clk *clk;
-	unsigned long rate;
-	int ret;
-
-	timer_reg_base = of_iomap(np, 0);
-	if (!timer_reg_base) {
-		pr_err("Can't map timer registers\n");
-		return -ENXIO;
-	}
+	int ret = 0;
 
-	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
-	if (tegra_timer_irq.irq <= 0) {
-		pr_err("Failed to map timer IRQ\n");
-		return -EINVAL;
-	}
+	ret = timer_of_init(np, to);
+	if (ret < 0)
+		goto out;
 
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
-		rate = 12000000;
-	} else {
-		clk_prepare_enable(clk);
-		rate = clk_get_rate(clk);
-	}
+	timer_reg_base = timer_of_base(to);
 
-	switch (rate) {
+	/*
+	 * Configure microsecond timers to have 1MHz clock
+	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
+	 * Uses n+1 scheme
+	 */
+	switch (timer_of_rate(to)) {
 	case 12000000:
-		timer_writel(0x000b, TIMERUS_USEC_CFG);
+		usec_config = 0x000b; /* (11+1)/(0+1) */
+		break;
+	case 12800000:
+		usec_config = 0x043f; /* (63+1)/(4+1) */
 		break;
 	case 13000000:
-		timer_writel(0x000c, TIMERUS_USEC_CFG);
+		usec_config = 0x000c; /* (12+1)/(0+1) */
+		break;
+	case 16800000:
+		usec_config = 0x0453; /* (83+1)/(4+1) */
 		break;
 	case 19200000:
-		timer_writel(0x045f, TIMERUS_USEC_CFG);
+		usec_config = 0x045f; /* (95+1)/(4+1) */
 		break;
 	case 26000000:
-		timer_writel(0x0019, TIMERUS_USEC_CFG);
+		usec_config = 0x0019; /* (25+1)/(0+1) */
+		break;
+	case 38400000:
+		usec_config = 0x04bf; /* (191+1)/(4+1) */
+		break;
+	case 48000000:
+		usec_config = 0x002f; /* (47+1)/(0+1) */
 		break;
 	default:
-		WARN(1, "Unknown clock rate");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
+
+out:
+	return ret;
+}
+
+#ifdef CONFIG_ARM64
+static int __init tegra_init_timer(struct device_node *np)
+{
+	int cpu, ret = 0;
+	struct timer_of *to;
+
+	to = this_cpu_ptr(&tegra_to);
+	ret = tegra_timer_common_init(np, to);
+	if (ret < 0)
+		goto out;
+
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
+		cpu_to->of_clk.rate = timer_of_rate(to);
+		cpu_to->clkevt.cpumask = cpumask_of(cpu);
+		cpu_to->clkevt.irq =
+			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
+		if (!cpu_to->clkevt.irq) {
+			pr_err("%s: can't map IRQ for CPU%d\n",
+			       __func__, cpu);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
+		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
+				  IRQF_TIMER | IRQF_NOBALANCING,
+				  cpu_to->clkevt.name, &cpu_to->clkevt);
+		if (ret) {
+			pr_err("%s: cannot setup irq %d for CPU%d\n",
+				__func__, cpu_to->clkevt.irq, cpu);
+			ret = -EINVAL;
+			goto out_irq;
+		}
+	}
+
+	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
+			  tegra_timer_stop);
+
+	return ret;
+out_irq:
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		if (cpu_to->clkevt.irq) {
+			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+		}
 	}
+out:
+	timer_of_cleanup(to);
+	return ret;
+}
+#else /* CONFIG_ARM */
+static int __init tegra_init_timer(struct device_node *np)
+{
+	int ret = 0;
+
+	ret = tegra_timer_common_init(np, &tegra_to);
+	if (ret < 0)
+		goto out;
 
-	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
+	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
 
+	sched_clock_register(tegra_read_sched_clock, 32,
+			     timer_of_rate(&tegra_to));
 	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", 1000000, 300, 32,
-				    clocksource_mmio_readl_up);
+				    "timer_us", timer_of_rate(&tegra_to),
+				    300, 32, clocksource_mmio_readl_up);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto out;
 	}
 
 	tegra_delay_timer.read_current_timer =
 			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = 1000000;
+	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
 	register_current_timer_delay(&tegra_delay_timer);
 
-	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
-	if (ret) {
-		pr_err("Failed to register timer IRQ: %d\n", ret);
-		return ret;
-	}
+	clockevents_config_and_register(&tegra_to.clkevt,
+					timer_of_rate(&tegra_to),
+					0x1,
+					0x1fffffff);
 
-	tegra_clockevent.cpumask = cpu_possible_mask;
-	tegra_clockevent.irq = tegra_timer_irq.irq;
-	clockevents_config_and_register(&tegra_clockevent, 1000000,
-					0x1, 0x1fffffff);
+	return ret;
+out:
+	timer_of_cleanup(&tegra_to);
 
-	return 0;
+	return ret;
 }
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
@@ -261,3 +406,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+#endif
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..e78281d07b70 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -121,6 +121,7 @@ enum cpuhp_state {
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
+	CPUHP_AP_TEGRA_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
-- 
2.17.1

