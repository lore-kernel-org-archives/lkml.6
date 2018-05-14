Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288221; cv=none;
        d=google.com; s=arc-20160816;
        b=KZUV8SLj3sKh7xVigvzEQ02MSxsJEZFoTBZwqcOdLFKdRSZQhzsVnvIPX4NLQIp3wF
         uBfCeb095OFbpEva6PgTSONMUI2KEjNeQk5AEaodwm1jZHmJvLermma83BK7NCOeAJ7/
         9qEOkibVo97WRzVpZ+OOoRAFn+vDvNytktCIwyCjy2bM2fb9cE38gQymd8EbfhSh8N5y
         mvFcYPd7QGtTfQWJYzF+Kow0fEmyDP9zTxllXDfugUM2AJISUMa1GS/TPSTAPWgt7Z9L
         x2Ok7RmZd9YEvapKzkli2FRc/bbNKewtSVZ2hcM2QUy+2h8zp65nbDZgQjHDk9+49/a3
         gNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JFxtoPTIwMJxvyCd3hwanD0Gfpl/C9hHnauJqDpF+Pw=;
        b=ahJ5j6Lw4nFZQm5G2Q378iBR/wkppMRZKA0+CUIh5l6NRdLW0Wp5442u+w2BXpMWbE
         ZFVJxaKxFe11qKh/9T/X6tkJCIbjWqPpwXKPMFLTbAk3hT4ChUnp9U3ImL318SpMuUd2
         swfxu0HcnFoDrzWQOvO6O2Q7GiBkmbQPzLMAT/LvLNkhkujDmG1K9qnWfWN8m6erVyLl
         Z7DRCHhVadDBlHaA+JvcQ8jnTIueev0x4ty9imlaFaxuTff2Lkc9dxpa7deeXbOVwf/9
         pmWlz2r3lAEnLJrz1CNadCaFrhKXH+vmDZfs1Q2bRv3XmFah764K6f8CBfndlYo6fINE
         YhYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lks8eZND;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lks8eZND;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqJqrkpqUjChhz+cXXKxmxgAaOH1itX8BY6d+zuE+pHfRQUCNQWxrJ6eLWAz63O4iru9mMMTA==
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
Subject: [RFC PATCH 06/10] clocksource: arm_arch_timer: Register the persistent clock
Date: Mon, 14 May 2018 16:55:32 +0800
Message-Id: <f7f053cc1ffbef881642bc8755f0d73b370b0d36.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429198447922047?=
X-GMAIL-MSGID: =?utf-8?q?1600429198447922047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Register the persistent clock to compensate the suspend time for OS time,
if the ARM counter clocksource will not be stopped in suspend state.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/arm_arch_timer.c |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d7dddcc..884719c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -308,6 +308,7 @@ config ARC_TIMERS_64BIT
 
 config ARM_ARCH_TIMER
 	bool
+	select PERSISTENT_CLOCK
 	select TIMER_OF if OF
 	select TIMER_ACPI if ACPI
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f0..671be63 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,7 @@
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
+#include <linux/persistent_clock.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "arch_timer: " fmt
@@ -950,6 +951,15 @@ static void __init arch_counter_register(unsigned type)
 
 	/* 56 bits minimum, so we assume worst case rollover */
 	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+
+	/*
+	 * Register the persistent clock if the clocksource will not be stopped
+	 * in suspend state.
+	 */
+	if (!arch_counter_suspend_stop)
+		persistent_clock_init_and_register(arch_timer_read_counter,
+						   CLOCKSOURCE_MASK(56),
+						   arch_timer_rate, 0);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
-- 
1.7.9.5
