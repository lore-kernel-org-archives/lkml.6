Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288185; cv=none;
        d=google.com; s=arc-20160816;
        b=UUCVH6Ui+3rpt+sj+5H6xj20POnJvKgCVErivwQhBWTQUG+zX+7agm+FeuRkKebgPO
         hcdfwi0dx2H48I7zLMv+KtLpkYXiMpsm8Ndon2af8O5RxeRTdl9YX2l77OSnwcRAR+uG
         88sQGYW+Cz4s6dikGabaY/j6bSM5D5kskkWnQrB3sMJSFGZU4cRh3PNo+ckcxzZoAMtZ
         WIFIrN5WR2CA8uVVscwob8bhsFQtvxUl85nZJCIBbYUYMfRUg2iGZUi09nlFjhpFxeSI
         Ri29OS6n4syRazHLTSAgkWmdWCIcrokRY9MQzlL9ohNuSHNN9XSltfLuI/BIPN+A1ejx
         Sysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=otXnHrArHRqD0yr3/v6hok4GHpBR10tlTjRkrESI19A=;
        b=qmLZ2Q9EGswBwZr8gq1noL7mNMr2F4UZUgKtKIUQSJA0VRButoNUnv0J5/2TtIxMA2
         cAfW22jPxtgAwQXNLMNcqi9ohHnrk5Ck3hnT5atBLJz9KWoPqkdlQf2oRNcA24sSBmvY
         66wpdj89X9y0kGAXmItjohF/Hp0GR2KbnKqUQ2gE4Gso99oEC8dFu8UeR4CuNgX2MyQa
         jJ3NSfyh7VCtvSyAQAnl8kEsffhMLQ6QFI+vLuGbzczfkkqIjIIu0MCQ3HPf/bfD4N0m
         s+uKvo3iAi72a28809yRo6ese8oxeKGOSi7qOf7X+tB3UHl8FYWL2gq1ymRdoNssFdhh
         IJbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=a56a65JF;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=a56a65JF;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrNBLVMB6bvW1TE564WDye+cQF5N9CwsJWuicQiIaCGPNuJFeOzURlr1BZicQ8VHNB1gdTLMg==
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de,
	john.stultz@linaro.org,
	daniel.lezcano@linaro.org,
	arnd@arndb.de,
	tony@atomide.com,
	aaro.koskinen@iki.fi,
	linux@armlinux.org.uk,
	mark.rutland@arm.com,
	marc.zyngier@arm.com
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	paulmck@linux.vnet.ibm.com,
	mlichvar@redhat.com,
	rdunlap@infradead.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	heiko@sntech.de,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	mingo@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	douly.fnst@cn.fujitsu.com,
	len.brown@intel.com,
	rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [RFC PATCH 02/10] clocksource: sprd: Add one persistent timer for Spreadtrum platform
Date: Mon, 14 May 2018 16:55:28 +0800
Message-Id: <d96b50111a419b920b1b8fe183f538b2d6268af0.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429160095072934?=
X-GMAIL-MSGID: =?utf-8?q?1600429160095072934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Spreadtrum SC9860 platform, we need one persistent timer to calculate
the suspend time to compensate the OS time.

This patch registers one Spreadtrum AON timer as persistent timer, which
runs at 32bit and periodic mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig      |    1 +
 drivers/clocksource/timer-sprd.c |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8e8a097..d7dddcc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -453,6 +453,7 @@ config SPRD_TIMER
 	bool "Spreadtrum timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables support for the Spreadtrum timer driver.
 
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..c6f657a 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -3,8 +3,11 @@
  * Copyright (C) 2017 Spreadtrum Communications Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 #include "timer-of.h"
 
@@ -157,3 +160,80 @@ static int __init sprd_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+
+void __iomem *pbase;
+
+static u64 sprd_persistent_timer_read(void)
+{
+	return ~(u64)readl_relaxed(pbase + TIMER_VALUE_SHDW_LO) &
+		CLOCKSOURCE_MASK(32);
+}
+
+static void sprd_persistent_timer_disable(void)
+{
+	sprd_timer_disable(pbase);
+}
+
+static void sprd_persistent_timer_enable(void)
+{
+	sprd_timer_disable(pbase);
+	sprd_timer_update_counter(pbase, TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(pbase, TIMER_CTL_PERIOD_MODE);
+}
+
+static int __init sprd_persistent_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	u32 freq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock for %pOF\n", np);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to enable clock for %pOF\n", np);
+		clk_put(clk);
+		return ret;
+	}
+
+	freq = clk_get_rate(clk);
+	if (!freq) {
+		pr_err("Failed to get clock rate for %pOF\n", np);
+		ret = -EINVAL;
+		goto clk_rate_err;
+	}
+
+	pbase = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(pbase)) {
+		pr_err("Can't map timer registers for %pOF\n", np);
+		ret = PTR_ERR(pbase);
+		goto clk_rate_err;
+	}
+
+	sprd_persistent_timer_enable();
+
+	ret = persistent_clock_init_and_register(sprd_persistent_timer_read,
+						 CLOCKSOURCE_MASK(32), freq, 0);
+	if (ret) {
+		pr_err("Failed to register persistent clock for %pOF\n", np);
+		goto persist_err;
+	}
+
+	return 0;
+
+persist_err:
+	sprd_persistent_timer_disable();
+	iounmap(pbase);
+clk_rate_err:
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-persistent-timer",
+		 sprd_persistent_timer_init);
-- 
1.7.9.5
