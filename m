Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DEC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6611F21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyE3GtEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6611F21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeIXKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:24:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39675 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeIXKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:24:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so18182379wrw.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kRR6EQP8teVCrCw04i47gKnBJhGKQme1xiroeYrD6A=;
        b=fyE3GtEsGhHQUzT10k1FIiFXSgP44B6H8VH9EJQkCZtChOlPhbKsHBnk8O1j++UmL1
         Mo+GkMA4ywdxghtydpj+YiUe3xArwRiTfuCinQZQuN4t6mxjuSwYH0YXbyl/NDEnqobx
         5uo1L0pgmE/WZa3ieHuf/370Thflo3ZOk251o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kRR6EQP8teVCrCw04i47gKnBJhGKQme1xiroeYrD6A=;
        b=mRCYPt91z12vfgXzutrOIsHACxS3ZNudurbVpHdWJBJWpBBG6k1tWM/a8al/hTIS+W
         nd6NYf9vchGwaw8AMlSIywVqR9hTA7pQbHHNMymGWe5XIRmU6pItoI/KIgpKlS6yn2Pc
         lrw/M8mPCUN7dE0fEKrF8iymQorVZ+/YMLEMly9mg/wN8+aTdrh5C6n9FNt1IYvF6+4D
         XFk1gez5/KMNHLwkYVk+y66Olym+mnZexnncA4dFNTZgHpsisaej7e6ZrQmQ5aCGdz4L
         3iqF+zgD4B8aGeE/hhzIHC2U5nLkj6FsatvAZ11ZrOKFtpuT09UcX/2E3j7FQu/bmB2Z
         Z6iA==
X-Gm-Message-State: ABuFfoi7iAmiNQUd1rieTCs32uRMg+YUPrHShjPi7EYR3qMiPI3AzJSp
        IyC0Q7Ey/lKpOPAjrmy7U8xQxg==
X-Google-Smtp-Source: ACcGV607G06jleh8IuF4Z2r6IJsbQSz3DadpaDxAw/TUO6ufQcpKEiq1ZiUQcUHMK7ligDxKf1y7Rg==
X-Received: by 2002:a5d:4912:: with SMTP id x18-v6mr6423901wrq.114.1537763037274;
        Sun, 23 Sep 2018 21:23:57 -0700 (PDT)
Received: from localhost.localdomain (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.gmail.com with ESMTPSA id j2-v6sm10269435wmj.5.2018.09.23.21.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 21:23:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI
        ARCHITECTURE)
Subject: [PATCH 1/2] clocksource/drivers: Unify the names to timer-* format
Date:   Mon, 24 Sep 2018 06:15:17 +0200
Message-Id: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make some housekeeping in the directory, this patch renames
drivers to the timer-* format in order to unify their names.

There is no functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                               |  10 +-
 drivers/clocksource/Makefile              |  26 +-
 drivers/clocksource/cadence_ttc_timer.c   | 543 ------------------------------
 drivers/clocksource/fsl_ftm_timer.c       | 376 ---------------------
 drivers/clocksource/owl-timer.c           | 173 ----------
 drivers/clocksource/qcom-timer.c          | 258 --------------
 drivers/clocksource/time-armada-370-xp.c  | 416 -----------------------
 drivers/clocksource/time-efm32.c          | 287 ----------------
 drivers/clocksource/time-lpc32xx.c        | 314 -----------------
 drivers/clocksource/time-orion.c          | 192 -----------
 drivers/clocksource/time-pistachio.c      | 218 ------------
 drivers/clocksource/timer-armada-370-xp.c | 416 +++++++++++++++++++++++
 drivers/clocksource/timer-cadence-ttc.c   | 543 ++++++++++++++++++++++++++++++
 drivers/clocksource/timer-efm32.c         | 287 ++++++++++++++++
 drivers/clocksource/timer-fsl-ftm.c       | 376 +++++++++++++++++++++
 drivers/clocksource/timer-lpc32xx.c       | 314 +++++++++++++++++
 drivers/clocksource/timer-orion.c         | 192 +++++++++++
 drivers/clocksource/timer-owl.c           | 173 ++++++++++
 drivers/clocksource/timer-pistachio.c     | 218 ++++++++++++
 drivers/clocksource/timer-qcom.c          | 258 ++++++++++++++
 drivers/clocksource/timer-versatile.c     |  44 +++
 drivers/clocksource/timer-vf-pit.c        | 204 +++++++++++
 drivers/clocksource/timer-vt8500.c        | 168 +++++++++
 drivers/clocksource/timer-zevio.c         | 218 ++++++++++++
 drivers/clocksource/versatile.c           |  44 ---
 drivers/clocksource/vf_pit_timer.c        | 204 -----------
 drivers/clocksource/vt8500_timer.c        | 168 ---------
 drivers/clocksource/zevio-timer.c         | 218 ------------
 28 files changed, 3429 insertions(+), 3429 deletions(-)
 delete mode 100644 drivers/clocksource/cadence_ttc_timer.c
 delete mode 100644 drivers/clocksource/fsl_ftm_timer.c
 delete mode 100644 drivers/clocksource/owl-timer.c
 delete mode 100644 drivers/clocksource/qcom-timer.c
 delete mode 100644 drivers/clocksource/time-armada-370-xp.c
 delete mode 100644 drivers/clocksource/time-efm32.c
 delete mode 100644 drivers/clocksource/time-lpc32xx.c
 delete mode 100644 drivers/clocksource/time-orion.c
 delete mode 100644 drivers/clocksource/time-pistachio.c
 create mode 100644 drivers/clocksource/timer-armada-370-xp.c
 create mode 100644 drivers/clocksource/timer-cadence-ttc.c
 create mode 100644 drivers/clocksource/timer-efm32.c
 create mode 100644 drivers/clocksource/timer-fsl-ftm.c
 create mode 100644 drivers/clocksource/timer-lpc32xx.c
 create mode 100644 drivers/clocksource/timer-orion.c
 create mode 100644 drivers/clocksource/timer-owl.c
 create mode 100644 drivers/clocksource/timer-pistachio.c
 create mode 100644 drivers/clocksource/timer-qcom.c
 create mode 100644 drivers/clocksource/timer-versatile.c
 create mode 100644 drivers/clocksource/timer-vf-pit.c
 create mode 100644 drivers/clocksource/timer-vt8500.c
 create mode 100644 drivers/clocksource/timer-zevio.c
 delete mode 100644 drivers/clocksource/versatile.c
 delete mode 100644 drivers/clocksource/vf_pit_timer.c
 delete mode 100644 drivers/clocksource/vt8500_timer.c
 delete mode 100644 drivers/clocksource/zevio-timer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b..67e877c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,7 +1181,7 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
-F:	drivers/clocksource/owl-*
+F:	drivers/clocksource/timer-owl*
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1604,7 +1604,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/time-lpc32xx.c
+F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
@@ -2220,7 +2220,7 @@ F:	arch/arm/mach-vexpress/
 F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
-F:	drivers/clocksource/versatile.c
+F:	drivers/clocksource/timer-versatile.c
 N:	mps2
 
 ARM/VFP SUPPORT
@@ -2242,7 +2242,7 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
-F:	drivers/clocksource/vt8500_timer.c
+F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-wmt.c
 F:	drivers/mmc/host/wmt-sdmmc.c
 F:	drivers/pwm/pwm-vt8500.c
@@ -2307,7 +2307,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
-F:	drivers/clocksource/cadence_ttc_timer.c
+F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b24..e33b21d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -23,8 +23,8 @@ obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
-obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
-obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
+obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
+obj-$(CONFIG_ORION_TIMER)	+= timer-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
@@ -36,25 +36,25 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
-obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
-obj-$(CONFIG_NSPIRE_TIMER)	+= zevio-timer.o
+obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
+obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
-obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
-obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
+obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
-obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
+obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
-obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
-obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
-obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
+obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
+obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
+obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
-obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
-obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
+obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 
@@ -66,7 +66,7 @@ obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
-obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
+obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
deleted file mode 100644
index b334029..0000000
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ /dev/null
@@ -1,543 +0,0 @@
-/*
- * This file contains driver for the Cadence Triple Timer Counter Rev 06
- *
- *  Copyright (C) 2011-2013 Xilinx
- *
- * based on arch/mips/kernel/time.c timer driver
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/slab.h>
-#include <linux/sched_clock.h>
-
-/*
- * This driver configures the 2 16/32-bit count-up timers as follows:
- *
- * T1: Timer 1, clocksource for generic timekeeping
- * T2: Timer 2, clockevent source for hrtimers
- * T3: Timer 3, <unused>
- *
- * The input frequency to the timer module for emulation is 2.5MHz which is
- * common to all the timer channels (T1, T2, and T3). With a pre-scaler of 32,
- * the timers are clocked at 78.125KHz (12.8 us resolution).
-
- * The input frequency to the timer module in silicon is configurable and
- * obtained from device tree. The pre-scaler of 32 is used.
- */
-
-/*
- * Timer Register Offset Definitions of Timer 1, Increment base address by 4
- * and use same offsets for Timer 2
- */
-#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
-#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
-#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
-#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
-#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
-#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
-
-#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
-
-#define TTC_CLK_CNTRL_CSRC_MASK		(1 << 5)	/* clock source */
-#define TTC_CLK_CNTRL_PSV_MASK		0x1e
-#define TTC_CLK_CNTRL_PSV_SHIFT		1
-
-/*
- * Setup the timers to use pre-scaling, using a fixed value for now that will
- * work across most input frequency, but it may need to be more dynamic
- */
-#define PRESCALE_EXPONENT	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
-#define PRESCALE		2048	/* The exponent must match this */
-#define CLK_CNTRL_PRESCALE	((PRESCALE_EXPONENT - 1) << 1)
-#define CLK_CNTRL_PRESCALE_EN	1
-#define CNT_CNTRL_RESET		(1 << 4)
-
-#define MAX_F_ERR 50
-
-/**
- * struct ttc_timer - This definition defines local timer structure
- *
- * @base_addr:	Base address of timer
- * @freq:	Timer input clock frequency
- * @clk:	Associated clock source
- * @clk_rate_change_nb	Notifier block for clock rate changes
- */
-struct ttc_timer {
-	void __iomem *base_addr;
-	unsigned long freq;
-	struct clk *clk;
-	struct notifier_block clk_rate_change_nb;
-};
-
-#define to_ttc_timer(x) \
-		container_of(x, struct ttc_timer, clk_rate_change_nb)
-
-struct ttc_timer_clocksource {
-	u32			scale_clk_ctrl_reg_old;
-	u32			scale_clk_ctrl_reg_new;
-	struct ttc_timer	ttc;
-	struct clocksource	cs;
-};
-
-#define to_ttc_timer_clksrc(x) \
-		container_of(x, struct ttc_timer_clocksource, cs)
-
-struct ttc_timer_clockevent {
-	struct ttc_timer		ttc;
-	struct clock_event_device	ce;
-};
-
-#define to_ttc_timer_clkevent(x) \
-		container_of(x, struct ttc_timer_clockevent, ce)
-
-static void __iomem *ttc_sched_clock_val_reg;
-
-/**
- * ttc_set_interval - Set the timer interval value
- *
- * @timer:	Pointer to the timer instance
- * @cycles:	Timer interval ticks
- **/
-static void ttc_set_interval(struct ttc_timer *timer,
-					unsigned long cycles)
-{
-	u32 ctrl_reg;
-
-	/* Disable the counter, set the counter value  and re-enable counter */
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-
-	writel_relaxed(cycles, timer->base_addr + TTC_INTR_VAL_OFFSET);
-
-	/*
-	 * Reset the counter (0x10) so that it starts from 0, one-shot
-	 * mode makes this needed for timing to be right.
-	 */
-	ctrl_reg |= CNT_CNTRL_RESET;
-	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-}
-
-/**
- * ttc_clock_event_interrupt - Clock event timer interrupt handler
- *
- * @irq:	IRQ number of the Timer
- * @dev_id:	void pointer to the ttc_timer instance
- *
- * returns: Always IRQ_HANDLED - success
- **/
-static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
-{
-	struct ttc_timer_clockevent *ttce = dev_id;
-	struct ttc_timer *timer = &ttce->ttc;
-
-	/* Acknowledge the interrupt and call event handler */
-	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
-
-	ttce->ce.event_handler(&ttce->ce);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * __ttc_clocksource_read - Reads the timer counter register
- *
- * returns: Current timer counter register value
- **/
-static u64 __ttc_clocksource_read(struct clocksource *cs)
-{
-	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
-
-	return (u64)readl_relaxed(timer->base_addr +
-				TTC_COUNT_VAL_OFFSET);
-}
-
-static u64 notrace ttc_sched_clock_read(void)
-{
-	return readl_relaxed(ttc_sched_clock_val_reg);
-}
-
-/**
- * ttc_set_next_event - Sets the time interval for next event
- *
- * @cycles:	Timer interval ticks
- * @evt:	Address of clock event instance
- *
- * returns: Always 0 - success
- **/
-static int ttc_set_next_event(unsigned long cycles,
-					struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-
-	ttc_set_interval(timer, cycles);
-	return 0;
-}
-
-/**
- * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
- *
- * @evt:	Address of clock event instance
- **/
-static int ttc_shutdown(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-	u32 ctrl_reg;
-
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	return 0;
-}
-
-static int ttc_set_periodic(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-
-	ttc_set_interval(timer,
-			 DIV_ROUND_CLOSEST(ttce->ttc.freq, PRESCALE * HZ));
-	return 0;
-}
-
-static int ttc_resume(struct clock_event_device *evt)
-{
-	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
-	struct ttc_timer *timer = &ttce->ttc;
-	u32 ctrl_reg;
-
-	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
-	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-	return 0;
-}
-
-static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
-		unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct ttc_timer *ttc = to_ttc_timer(nb);
-	struct ttc_timer_clocksource *ttccs = container_of(ttc,
-			struct ttc_timer_clocksource, ttc);
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-	{
-		u32 psv;
-		unsigned long factor, rate_low, rate_high;
-
-		if (ndata->new_rate > ndata->old_rate) {
-			factor = DIV_ROUND_CLOSEST(ndata->new_rate,
-					ndata->old_rate);
-			rate_low = ndata->old_rate;
-			rate_high = ndata->new_rate;
-		} else {
-			factor = DIV_ROUND_CLOSEST(ndata->old_rate,
-					ndata->new_rate);
-			rate_low = ndata->new_rate;
-			rate_high = ndata->old_rate;
-		}
-
-		if (!is_power_of_2(factor))
-				return NOTIFY_BAD;
-
-		if (abs(rate_high - (factor * rate_low)) > MAX_F_ERR)
-			return NOTIFY_BAD;
-
-		factor = __ilog2_u32(factor);
-
-		/*
-		 * store timer clock ctrl register so we can restore it in case
-		 * of an abort.
-		 */
-		ttccs->scale_clk_ctrl_reg_old =
-			readl_relaxed(ttccs->ttc.base_addr +
-			TTC_CLK_CNTRL_OFFSET);
-
-		psv = (ttccs->scale_clk_ctrl_reg_old &
-				TTC_CLK_CNTRL_PSV_MASK) >>
-				TTC_CLK_CNTRL_PSV_SHIFT;
-		if (ndata->new_rate < ndata->old_rate)
-			psv -= factor;
-		else
-			psv += factor;
-
-		/* prescaler within legal range? */
-		if (psv & ~(TTC_CLK_CNTRL_PSV_MASK >> TTC_CLK_CNTRL_PSV_SHIFT))
-			return NOTIFY_BAD;
-
-		ttccs->scale_clk_ctrl_reg_new = ttccs->scale_clk_ctrl_reg_old &
-			~TTC_CLK_CNTRL_PSV_MASK;
-		ttccs->scale_clk_ctrl_reg_new |= psv << TTC_CLK_CNTRL_PSV_SHIFT;
-
-
-		/* scale down: adjust divider in post-change notification */
-		if (ndata->new_rate < ndata->old_rate)
-			return NOTIFY_DONE;
-
-		/* scale up: adjust divider now - before frequency change */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		break;
-	}
-	case POST_RATE_CHANGE:
-		/* scale up: pre-change notification did the adjustment */
-		if (ndata->new_rate > ndata->old_rate)
-			return NOTIFY_OK;
-
-		/* scale down: adjust divider now - after frequency change */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		break;
-
-	case ABORT_RATE_CHANGE:
-		/* we have to undo the adjustment in case we scale up */
-		if (ndata->new_rate < ndata->old_rate)
-			return NOTIFY_OK;
-
-		/* restore original register value */
-		writel_relaxed(ttccs->scale_clk_ctrl_reg_old,
-			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-		/* fall through */
-	default:
-		return NOTIFY_DONE;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
-					 u32 timer_width)
-{
-	struct ttc_timer_clocksource *ttccs;
-	int err;
-
-	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
-	if (!ttccs)
-		return -ENOMEM;
-
-	ttccs->ttc.clk = clk;
-
-	err = clk_prepare_enable(ttccs->ttc.clk);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
-
-	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
-
-	ttccs->ttc.clk_rate_change_nb.notifier_call =
-		ttc_rate_change_clocksource_cb;
-	ttccs->ttc.clk_rate_change_nb.next = NULL;
-
-	err = clk_notifier_register(ttccs->ttc.clk,
-				    &ttccs->ttc.clk_rate_change_nb);
-	if (err)
-		pr_warn("Unable to register clock notifier.\n");
-
-	ttccs->ttc.base_addr = base;
-	ttccs->cs.name = "ttc_clocksource";
-	ttccs->cs.rating = 200;
-	ttccs->cs.read = __ttc_clocksource_read;
-	ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
-	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-
-	/*
-	 * Setup the clock source counter to be an incrementing counter
-	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
-	 * it by 32 also. Let it start running now.
-	 */
-	writel_relaxed(0x0,  ttccs->ttc.base_addr + TTC_IER_OFFSET);
-	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-	writel_relaxed(CNT_CNTRL_RESET,
-		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
-
-	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
-
-	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
-	sched_clock_register(ttc_sched_clock_read, timer_width,
-			     ttccs->ttc.freq / PRESCALE);
-
-	return 0;
-}
-
-static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
-		unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct ttc_timer *ttc = to_ttc_timer(nb);
-	struct ttc_timer_clockevent *ttcce = container_of(ttc,
-			struct ttc_timer_clockevent, ttc);
-
-	switch (event) {
-	case POST_RATE_CHANGE:
-		/* update cached frequency */
-		ttc->freq = ndata->new_rate;
-
-		clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
-
-		/* fall through */
-	case PRE_RATE_CHANGE:
-	case ABORT_RATE_CHANGE:
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static int __init ttc_setup_clockevent(struct clk *clk,
-				       void __iomem *base, u32 irq)
-{
-	struct ttc_timer_clockevent *ttcce;
-	int err;
-
-	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
-	if (!ttcce)
-		return -ENOMEM;
-
-	ttcce->ttc.clk = clk;
-
-	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
-
-	ttcce->ttc.clk_rate_change_nb.notifier_call =
-		ttc_rate_change_clockevent_cb;
-	ttcce->ttc.clk_rate_change_nb.next = NULL;
-
-	err = clk_notifier_register(ttcce->ttc.clk,
-				    &ttcce->ttc.clk_rate_change_nb);
-	if (err) {
-		pr_warn("Unable to register clock notifier.\n");
-		return err;
-	}
-
-	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
-
-	ttcce->ttc.base_addr = base;
-	ttcce->ce.name = "ttc_clockevent";
-	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	ttcce->ce.set_next_event = ttc_set_next_event;
-	ttcce->ce.set_state_shutdown = ttc_shutdown;
-	ttcce->ce.set_state_periodic = ttc_set_periodic;
-	ttcce->ce.set_state_oneshot = ttc_shutdown;
-	ttcce->ce.tick_resume = ttc_resume;
-	ttcce->ce.rating = 200;
-	ttcce->ce.irq = irq;
-	ttcce->ce.cpumask = cpu_possible_mask;
-
-	/*
-	 * Setup the clock event timer to be an interval timer which
-	 * is prescaled by 32 using the interval interrupt. Leave it
-	 * disabled for now.
-	 */
-	writel_relaxed(0x23, ttcce->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
-	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-		     ttcce->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
-	writel_relaxed(0x1,  ttcce->ttc.base_addr + TTC_IER_OFFSET);
-
-	err = request_irq(irq, ttc_clock_event_interrupt,
-			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
-
-	clockevents_config_and_register(&ttcce->ce,
-			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
-
-	return 0;
-}
-
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
-{
-	unsigned int irq;
-	void __iomem *timer_baseaddr;
-	struct clk *clk_cs, *clk_ce;
-	static int initialized;
-	int clksel, ret;
-	u32 timer_width = 16;
-
-	if (initialized)
-		return 0;
-
-	initialized = 1;
-
-	/*
-	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
-	 * and use it. Note that the event timer uses the interrupt and it's the
-	 * 2nd TTC hence the irq_of_parse_and_map(,1)
-	 */
-	timer_baseaddr = of_iomap(timer, 0);
-	if (!timer_baseaddr) {
-		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(timer, 1);
-	if (irq <= 0) {
-		pr_err("ERROR: invalid interrupt number\n");
-		return -EINVAL;
-	}
-
-	of_property_read_u32(timer, "timer-width", &timer_width);
-
-	clksel = readl_relaxed(timer_baseaddr + TTC_CLK_CNTRL_OFFSET);
-	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
-	clk_cs = of_clk_get(timer, clksel);
-	if (IS_ERR(clk_cs)) {
-		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_cs);
-	}
-
-	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
-	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
-	clk_ce = of_clk_get(timer, clksel);
-	if (IS_ERR(clk_ce)) {
-		pr_err("ERROR: timer input clock not found\n");
-		return PTR_ERR(clk_ce);
-	}
-
-	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
-	if (ret)
-		return ret;
-
-	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
-	if (ret)
-		return ret;
-
-	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
deleted file mode 100644
index 846d18d..0000000
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ /dev/null
@@ -1,376 +0,0 @@
-/*
- * Freescale FlexTimer Module (FTM) timer driver.
- *
- * Copyright 2014 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-#include <linux/slab.h>
-
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
-
-struct ftm_clock_device {
-	void __iomem *clksrc_base;
-	void __iomem *clkevt_base;
-	unsigned long periodic_cyc;
-	unsigned long ps;
-	bool big_endian;
-};
-
-static struct ftm_clock_device *priv;
-
-static inline u32 ftm_readl(void __iomem *addr)
-{
-	if (priv->big_endian)
-		return ioread32be(addr);
-	else
-		return ioread32(addr);
-}
-
-static inline void ftm_writel(u32 val, void __iomem *addr)
-{
-	if (priv->big_endian)
-		iowrite32be(val, addr);
-	else
-		iowrite32(val, addr);
-}
-
-static inline void ftm_counter_enable(void __iomem *base)
-{
-	u32 val;
-
-	/* select and enable counter clock source */
-	val = ftm_readl(base + FTM_SC);
-	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
-	val |= priv->ps | FTM_SC_CLK(1);
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_counter_disable(void __iomem *base)
-{
-	u32 val;
-
-	/* disable counter clock source */
-	val = ftm_readl(base + FTM_SC);
-	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_acknowledge(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val &= ~FTM_SC_TOF;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_enable(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val |= FTM_SC_TOIE;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_irq_disable(void __iomem *base)
-{
-	u32 val;
-
-	val = ftm_readl(base + FTM_SC);
-	val &= ~FTM_SC_TOIE;
-	ftm_writel(val, base + FTM_SC);
-}
-
-static inline void ftm_reset_counter(void __iomem *base)
-{
-	/*
-	 * The CNT register contains the FTM counter value.
-	 * Reset clears the CNT register. Writing any value to COUNT
-	 * updates the counter with its initial value, CNTIN.
-	 */
-	ftm_writel(0x00, base + FTM_CNT);
-}
-
-static u64 notrace ftm_read_sched_clock(void)
-{
-	return ftm_readl(priv->clksrc_base + FTM_CNT);
-}
-
-static int ftm_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
-{
-	/*
-	 * The CNNIN and MOD are all double buffer registers, writing
-	 * to the MOD register latches the value into a buffer. The MOD
-	 * register is updated with the value of its write buffer with
-	 * the following scenario:
-	 * a, the counter source clock is diabled.
-	 */
-	ftm_counter_disable(priv->clkevt_base);
-
-	/* Force the value of CNTIN to be loaded into the FTM counter */
-	ftm_reset_counter(priv->clkevt_base);
-
-	/*
-	 * The counter increments until the value of MOD is reached,
-	 * at which point the counter is reloaded with the value of CNTIN.
-	 * The TOF (the overflow flag) bit is set when the FTM counter
-	 * changes from MOD to CNTIN. So we should using the delta - 1.
-	 */
-	ftm_writel(delta - 1, priv->clkevt_base + FTM_MOD);
-
-	ftm_counter_enable(priv->clkevt_base);
-
-	ftm_irq_enable(priv->clkevt_base);
-
-	return 0;
-}
-
-static int ftm_set_oneshot(struct clock_event_device *evt)
-{
-	ftm_counter_disable(priv->clkevt_base);
-	return 0;
-}
-
-static int ftm_set_periodic(struct clock_event_device *evt)
-{
-	ftm_set_next_event(priv->periodic_cyc, evt);
-	return 0;
-}
-
-static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	ftm_irq_acknowledge(priv->clkevt_base);
-
-	if (likely(clockevent_state_oneshot(evt))) {
-		ftm_irq_disable(priv->clkevt_base);
-		ftm_counter_disable(priv->clkevt_base);
-	}
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct clock_event_device ftm_clockevent = {
-	.name			= "Freescale ftm timer",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_periodic	= ftm_set_periodic,
-	.set_state_oneshot	= ftm_set_oneshot,
-	.set_next_event		= ftm_set_next_event,
-	.rating			= 300,
-};
-
-static struct irqaction ftm_timer_irq = {
-	.name		= "Freescale ftm timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ftm_evt_interrupt,
-	.dev_id		= &ftm_clockevent,
-};
-
-static int __init ftm_clockevent_init(unsigned long freq, int irq)
-{
-	int err;
-
-	ftm_writel(0x00, priv->clkevt_base + FTM_CNTIN);
-	ftm_writel(~0u, priv->clkevt_base + FTM_MOD);
-
-	ftm_reset_counter(priv->clkevt_base);
-
-	err = setup_irq(irq, &ftm_timer_irq);
-	if (err) {
-		pr_err("ftm: setup irq failed: %d\n", err);
-		return err;
-	}
-
-	ftm_clockevent.cpumask = cpumask_of(0);
-	ftm_clockevent.irq = irq;
-
-	clockevents_config_and_register(&ftm_clockevent,
-					freq / (1 << priv->ps),
-					1, 0xffff);
-
-	ftm_counter_enable(priv->clkevt_base);
-
-	return 0;
-}
-
-static int __init ftm_clocksource_init(unsigned long freq)
-{
-	int err;
-
-	ftm_writel(0x00, priv->clksrc_base + FTM_CNTIN);
-	ftm_writel(~0u, priv->clksrc_base + FTM_MOD);
-
-	ftm_reset_counter(priv->clksrc_base);
-
-	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps));
-	err = clocksource_mmio_init(priv->clksrc_base + FTM_CNT, "fsl-ftm",
-				    freq / (1 << priv->ps), 300, 16,
-				    clocksource_mmio_readl_up);
-	if (err) {
-		pr_err("ftm: init clock source mmio failed: %d\n", err);
-		return err;
-	}
-
-	ftm_counter_enable(priv->clksrc_base);
-
-	return 0;
-}
-
-static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
-				 char *ftm_name)
-{
-	struct clk *clk;
-	int err;
-
-	clk = of_clk_get_by_name(np, cnt_name);
-	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", cnt_name, PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-	err = clk_prepare_enable(clk);
-	if (err) {
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			cnt_name, err);
-		return err;
-	}
-
-	clk = of_clk_get_by_name(np, ftm_name);
-	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-	err = clk_prepare_enable(clk);
-	if (err)
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			ftm_name, err);
-
-	return clk_get_rate(clk);
-}
-
-static unsigned long __init ftm_clk_init(struct device_node *np)
-{
-	long freq;
-
-	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
-	if (freq <= 0)
-		return 0;
-
-	freq = __ftm_clk_init(np, "ftm-src-counter-en", "ftm-src");
-	if (freq <= 0)
-		return 0;
-
-	return freq;
-}
-
-static int __init ftm_calc_closest_round_cyc(unsigned long freq)
-{
-	priv->ps = 0;
-
-	/* The counter register is only using the lower 16 bits, and
-	 * if the 'freq' value is to big here, then the periodic_cyc
-	 * may exceed 0xFFFF.
-	 */
-	do {
-		priv->periodic_cyc = DIV_ROUND_CLOSEST(freq,
-						HZ * (1 << priv->ps++));
-	} while (priv->periodic_cyc > 0xFFFF);
-
-	if (priv->ps > FTM_PS_MAX) {
-		pr_err("ftm: the prescaler is %lu > %d\n",
-				priv->ps, FTM_PS_MAX);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init ftm_timer_init(struct device_node *np)
-{
-	unsigned long freq;
-	int ret, irq;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	ret = -ENXIO;
-	priv->clkevt_base = of_iomap(np, 0);
-	if (!priv->clkevt_base) {
-		pr_err("ftm: unable to map event timer registers\n");
-		goto err_clkevt;
-	}
-
-	priv->clksrc_base = of_iomap(np, 1);
-	if (!priv->clksrc_base) {
-		pr_err("ftm: unable to map source timer registers\n");
-		goto err_clksrc;
-	}
-
-	ret = -EINVAL;
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
-		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
-		goto err;
-	}
-
-	priv->big_endian = of_property_read_bool(np, "big-endian");
-
-	freq = ftm_clk_init(np);
-	if (!freq)
-		goto err;
-
-	ret = ftm_calc_closest_round_cyc(freq);
-	if (ret)
-		goto err;
-
-	ret = ftm_clocksource_init(freq);
-	if (ret)
-		goto err;
-
-	ret = ftm_clockevent_init(freq, irq);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	iounmap(priv->clksrc_base);
-err_clksrc:
-	iounmap(priv->clkevt_base);
-err_clkevt:
-	kfree(priv);
-	return ret;
-}
-TIMER_OF_DECLARE(flextimer, "fsl,ftm-timer", ftm_timer_init);
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
deleted file mode 100644
index ea00a5e..0000000
--- a/drivers/clocksource/owl-timer.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Actions Semi Owl timer
- *
- * Copyright 2012 Actions Semi Inc.
- * Author: Actions Semi, Inc.
- *
- * Copyright (c) 2017 SUSE Linux GmbH
- * Author: Andreas Färber
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqreturn.h>
-#include <linux/sched_clock.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#define OWL_Tx_CTL		0x0
-#define OWL_Tx_CMP		0x4
-#define OWL_Tx_VAL		0x8
-
-#define OWL_Tx_CTL_PD		BIT(0)
-#define OWL_Tx_CTL_INTEN	BIT(1)
-#define OWL_Tx_CTL_EN		BIT(2)
-
-static void __iomem *owl_timer_base;
-static void __iomem *owl_clksrc_base;
-static void __iomem *owl_clkevt_base;
-
-static inline void owl_timer_reset(void __iomem *base)
-{
-	writel(0, base + OWL_Tx_CTL);
-	writel(0, base + OWL_Tx_VAL);
-	writel(0, base + OWL_Tx_CMP);
-}
-
-static inline void owl_timer_set_enabled(void __iomem *base, bool enabled)
-{
-	u32 ctl = readl(base + OWL_Tx_CTL);
-
-	/* PD bit is cleared when set */
-	ctl &= ~OWL_Tx_CTL_PD;
-
-	if (enabled)
-		ctl |= OWL_Tx_CTL_EN;
-	else
-		ctl &= ~OWL_Tx_CTL_EN;
-
-	writel(ctl, base + OWL_Tx_CTL);
-}
-
-static u64 notrace owl_timer_sched_read(void)
-{
-	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);
-}
-
-static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
-{
-	owl_timer_set_enabled(owl_clkevt_base, false);
-
-	return 0;
-}
-
-static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
-{
-	owl_timer_reset(owl_clkevt_base);
-
-	return 0;
-}
-
-static int owl_timer_tick_resume(struct clock_event_device *evt)
-{
-	return 0;
-}
-
-static int owl_timer_set_next_event(unsigned long evt,
-				    struct clock_event_device *ev)
-{
-	void __iomem *base = owl_clkevt_base;
-
-	owl_timer_set_enabled(base, false);
-	writel(OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
-	writel(0, base + OWL_Tx_VAL);
-	writel(evt, base + OWL_Tx_CMP);
-	owl_timer_set_enabled(base, true);
-
-	return 0;
-}
-
-static struct clock_event_device owl_clockevent = {
-	.name			= "owl_tick",
-	.rating			= 200,
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_DYNIRQ,
-	.set_state_shutdown	= owl_timer_set_state_shutdown,
-	.set_state_oneshot	= owl_timer_set_state_oneshot,
-	.tick_resume		= owl_timer_tick_resume,
-	.set_next_event		= owl_timer_set_next_event,
-};
-
-static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-
-	writel(OWL_Tx_CTL_PD, owl_clkevt_base + OWL_Tx_CTL);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static int __init owl_timer_init(struct device_node *node)
-{
-	struct clk *clk;
-	unsigned long rate;
-	int timer1_irq, ret;
-
-	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
-	if (IS_ERR(owl_timer_base)) {
-		pr_err("Can't map timer registers\n");
-		return PTR_ERR(owl_timer_base);
-	}
-
-	owl_clksrc_base = owl_timer_base + 0x08;
-	owl_clkevt_base = owl_timer_base + 0x14;
-
-	timer1_irq = of_irq_get_byname(node, "timer1");
-	if (timer1_irq <= 0) {
-		pr_err("Can't parse timer1 IRQ\n");
-		return -EINVAL;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	rate = clk_get_rate(clk);
-
-	owl_timer_reset(owl_clksrc_base);
-	owl_timer_set_enabled(owl_clksrc_base, true);
-
-	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
-
-	owl_timer_reset(owl_clkevt_base);
-
-	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
-			  "owl-timer", &owl_clockevent);
-	if (ret) {
-		pr_err("failed to request irq %d\n", timer1_irq);
-		return ret;
-	}
-
-	owl_clockevent.cpumask = cpumask_of(0);
-	owl_clockevent.irq = timer1_irq;
-
-	clockevents_config_and_register(&owl_clockevent, rate,
-					0xf, 0xffffffff);
-
-	return 0;
-}
-TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
-TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
-TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
deleted file mode 100644
index 89816f8..0000000
--- a/drivers/clocksource/qcom-timer.c
+++ /dev/null
@@ -1,258 +0,0 @@
-/*
- *
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/cpu.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-#include <asm/delay.h>
-
-#define TIMER_MATCH_VAL			0x0000
-#define TIMER_COUNT_VAL			0x0004
-#define TIMER_ENABLE			0x0008
-#define TIMER_ENABLE_CLR_ON_MATCH_EN	BIT(1)
-#define TIMER_ENABLE_EN			BIT(0)
-#define TIMER_CLEAR			0x000C
-#define DGT_CLK_CTL			0x10
-#define DGT_CLK_CTL_DIV_4		0x3
-#define TIMER_STS_GPT0_CLR_PEND		BIT(10)
-
-#define GPT_HZ 32768
-
-static void __iomem *event_base;
-static void __iomem *sts_base;
-
-static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	/* Stop the timer tick */
-	if (clockevent_state_oneshot(evt)) {
-		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-		ctrl &= ~TIMER_ENABLE_EN;
-		writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-	}
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static int msm_timer_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-
-	ctrl &= ~TIMER_ENABLE_EN;
-	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-
-	writel_relaxed(ctrl, event_base + TIMER_CLEAR);
-	writel_relaxed(cycles, event_base + TIMER_MATCH_VAL);
-
-	if (sts_base)
-		while (readl_relaxed(sts_base) & TIMER_STS_GPT0_CLR_PEND)
-			cpu_relax();
-
-	writel_relaxed(ctrl | TIMER_ENABLE_EN, event_base + TIMER_ENABLE);
-	return 0;
-}
-
-static int msm_timer_shutdown(struct clock_event_device *evt)
-{
-	u32 ctrl;
-
-	ctrl = readl_relaxed(event_base + TIMER_ENABLE);
-	ctrl &= ~(TIMER_ENABLE_EN | TIMER_ENABLE_CLR_ON_MATCH_EN);
-	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
-	return 0;
-}
-
-static struct clock_event_device __percpu *msm_evt;
-
-static void __iomem *source_base;
-
-static notrace u64 msm_read_timer_count(struct clocksource *cs)
-{
-	return readl_relaxed(source_base + TIMER_COUNT_VAL);
-}
-
-static struct clocksource msm_clocksource = {
-	.name	= "dg_timer",
-	.rating	= 300,
-	.read	= msm_read_timer_count,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int msm_timer_irq;
-static int msm_timer_has_ppi;
-
-static int msm_local_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
-	int err;
-
-	evt->irq = msm_timer_irq;
-	evt->name = "msm_timer";
-	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 200;
-	evt->set_state_shutdown = msm_timer_shutdown;
-	evt->set_state_oneshot = msm_timer_shutdown;
-	evt->tick_resume = msm_timer_shutdown;
-	evt->set_next_event = msm_timer_set_next_event;
-	evt->cpumask = cpumask_of(cpu);
-
-	clockevents_config_and_register(evt, GPT_HZ, 4, 0xffffffff);
-
-	if (msm_timer_has_ppi) {
-		enable_percpu_irq(evt->irq, IRQ_TYPE_EDGE_RISING);
-	} else {
-		err = request_irq(evt->irq, msm_timer_interrupt,
-				IRQF_TIMER | IRQF_NOBALANCING |
-				IRQF_TRIGGER_RISING, "gp_timer", evt);
-		if (err)
-			pr_err("request_irq failed\n");
-	}
-
-	return 0;
-}
-
-static int msm_local_timer_dying_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
-
-	evt->set_state_shutdown(evt);
-	disable_percpu_irq(evt->irq);
-	return 0;
-}
-
-static u64 notrace msm_sched_clock_read(void)
-{
-	return msm_clocksource.read(&msm_clocksource);
-}
-
-static unsigned long msm_read_current_timer(void)
-{
-	return msm_clocksource.read(&msm_clocksource);
-}
-
-static struct delay_timer msm_delay_timer = {
-	.read_current_timer = msm_read_current_timer,
-};
-
-static int __init msm_timer_init(u32 dgt_hz, int sched_bits, int irq,
-				  bool percpu)
-{
-	struct clocksource *cs = &msm_clocksource;
-	int res = 0;
-
-	msm_timer_irq = irq;
-	msm_timer_has_ppi = percpu;
-
-	msm_evt = alloc_percpu(struct clock_event_device);
-	if (!msm_evt) {
-		pr_err("memory allocation failed for clockevents\n");
-		goto err;
-	}
-
-	if (percpu)
-		res = request_percpu_irq(irq, msm_timer_interrupt,
-					 "gp_timer", msm_evt);
-
-	if (res) {
-		pr_err("request_percpu_irq failed\n");
-	} else {
-		/* Install and invoke hotplug callbacks */
-		res = cpuhp_setup_state(CPUHP_AP_QCOM_TIMER_STARTING,
-					"clockevents/qcom/timer:starting",
-					msm_local_timer_starting_cpu,
-					msm_local_timer_dying_cpu);
-		if (res) {
-			free_percpu_irq(irq, msm_evt);
-			goto err;
-		}
-	}
-
-err:
-	writel_relaxed(TIMER_ENABLE_EN, source_base + TIMER_ENABLE);
-	res = clocksource_register_hz(cs, dgt_hz);
-	if (res)
-		pr_err("clocksource_register failed\n");
-	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
-	msm_delay_timer.freq = dgt_hz;
-	register_current_timer_delay(&msm_delay_timer);
-
-	return res;
-}
-
-static int __init msm_dt_timer_init(struct device_node *np)
-{
-	u32 freq;
-	int irq, ret;
-	struct resource res;
-	u32 percpu_offset;
-	void __iomem *base;
-	void __iomem *cpu0_base;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("Failed to map event base\n");
-		return -ENXIO;
-	}
-
-	/* We use GPT0 for the clockevent */
-	irq = irq_of_parse_and_map(np, 1);
-	if (irq <= 0) {
-		pr_err("Can't get irq\n");
-		return -EINVAL;
-	}
-
-	/* We use CPU0's DGT for the clocksource */
-	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
-		percpu_offset = 0;
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		pr_err("Failed to parse DGT resource\n");
-		return ret;
-	}
-
-	cpu0_base = ioremap(res.start + percpu_offset, resource_size(&res));
-	if (!cpu0_base) {
-		pr_err("Failed to map source base\n");
-		return -EINVAL;
-	}
-
-	if (of_property_read_u32(np, "clock-frequency", &freq)) {
-		pr_err("Unknown frequency\n");
-		return -EINVAL;
-	}
-
-	event_base = base + 0x4;
-	sts_base = base + 0x88;
-	source_base = cpu0_base + 0x24;
-	freq /= 4;
-	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
-
-	return msm_timer_init(freq, 32, irq, !!percpu_offset);
-}
-TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
-TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
deleted file mode 100644
index edf1a46..0000000
--- a/drivers/clocksource/time-armada-370-xp.c
+++ /dev/null
@@ -1,416 +0,0 @@
-/*
- * Marvell Armada 370/XP SoC timer handling.
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * Timer 0 is used as free-running clocksource, while timer 1 is
- * used as clock_event_device.
- *
- * ---
- * Clocksource driver for Armada 370 and Armada XP SoC.
- * This driver implements one compatible string for each SoC, given
- * each has its own characteristics:
- *
- *   * Armada 370 has no 25 MHz fixed timer.
- *
- *   * Armada XP cannot work properly without such 25 MHz fixed timer as
- *     doing otherwise leads to using a clocksource whose frequency varies
- *     when doing cpufreq frequency changes.
- *
- * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/cpu.h>
-#include <linux/timer.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/sched_clock.h>
-#include <linux/percpu.h>
-#include <linux/syscore_ops.h>
-
-#include <asm/delay.h>
-
-/*
- * Timer block registers.
- */
-#define TIMER_CTRL_OFF		0x0000
-#define  TIMER0_EN		 BIT(0)
-#define  TIMER0_RELOAD_EN	 BIT(1)
-#define  TIMER0_25MHZ            BIT(11)
-#define  TIMER0_DIV(div)         ((div) << 19)
-#define  TIMER1_EN		 BIT(2)
-#define  TIMER1_RELOAD_EN	 BIT(3)
-#define  TIMER1_25MHZ            BIT(12)
-#define  TIMER1_DIV(div)         ((div) << 22)
-#define TIMER_EVENTS_STATUS	0x0004
-#define  TIMER0_CLR_MASK         (~0x1)
-#define  TIMER1_CLR_MASK         (~0x100)
-#define TIMER0_RELOAD_OFF	0x0010
-#define TIMER0_VAL_OFF		0x0014
-#define TIMER1_RELOAD_OFF	0x0018
-#define TIMER1_VAL_OFF		0x001c
-
-#define LCL_TIMER_EVENTS_STATUS	0x0028
-/* Global timers are connected to the coherency fabric clock, and the
-   below divider reduces their incrementing frequency. */
-#define TIMER_DIVIDER_SHIFT     5
-#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
-
-/*
- * SoC-specific data.
- */
-static void __iomem *timer_base, *local_base;
-static unsigned int timer_clk;
-static bool timer25Mhz = true;
-static u32 enable_mask;
-
-/*
- * Number of timer ticks per jiffy.
- */
-static u32 ticks_per_jiffy;
-
-static struct clock_event_device __percpu *armada_370_xp_evt;
-
-static void local_timer_ctrl_clrset(u32 clr, u32 set)
-{
-	writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
-		local_base + TIMER_CTRL_OFF);
-}
-
-static u64 notrace armada_370_xp_read_sched_clock(void)
-{
-	return ~readl(timer_base + TIMER0_VAL_OFF);
-}
-
-/*
- * Clockevent handling.
- */
-static int
-armada_370_xp_clkevt_next_event(unsigned long delta,
-				struct clock_event_device *dev)
-{
-	/*
-	 * Clear clockevent timer interrupt.
-	 */
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-
-	/*
-	 * Setup new clockevent timer value.
-	 */
-	writel(delta, local_base + TIMER0_VAL_OFF);
-
-	/*
-	 * Enable the timer.
-	 */
-	local_timer_ctrl_clrset(TIMER0_RELOAD_EN, enable_mask);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_shutdown(struct clock_event_device *evt)
-{
-	/*
-	 * Disable timer.
-	 */
-	local_timer_ctrl_clrset(TIMER0_EN, 0);
-
-	/*
-	 * ACK pending timer interrupt.
-	 */
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_set_periodic(struct clock_event_device *evt)
-{
-	/*
-	 * Setup timer to fire at 1/HZ intervals.
-	 */
-	writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
-	writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
-
-	/*
-	 * Enable timer.
-	 */
-	local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
-	return 0;
-}
-
-static int armada_370_xp_clkevt_irq;
-
-static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
-{
-	/*
-	 * ACK timer interrupt and call event handler.
-	 */
-	struct clock_event_device *evt = dev_id;
-
-	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Setup the local clock events for a CPU.
- */
-static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
-	u32 clr = 0, set = 0;
-
-	if (timer25Mhz)
-		set = TIMER0_25MHZ;
-	else
-		clr = TIMER0_25MHZ;
-	local_timer_ctrl_clrset(clr, set);
-
-	evt->name		= "armada_370_xp_per_cpu_tick",
-	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
-	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
-	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
-	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
-	evt->tick_resume	= armada_370_xp_clkevt_shutdown;
-	evt->irq		= armada_370_xp_clkevt_irq;
-	evt->cpumask		= cpumask_of(cpu);
-
-	clockevents_config_and_register(evt, timer_clk, 1, 0xfffffffe);
-	enable_percpu_irq(evt->irq, 0);
-
-	return 0;
-}
-
-static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
-
-	evt->set_state_shutdown(evt);
-	disable_percpu_irq(evt->irq);
-	return 0;
-}
-
-static u32 timer0_ctrl_reg, timer0_local_ctrl_reg;
-
-static int armada_370_xp_timer_suspend(void)
-{
-	timer0_ctrl_reg = readl(timer_base + TIMER_CTRL_OFF);
-	timer0_local_ctrl_reg = readl(local_base + TIMER_CTRL_OFF);
-	return 0;
-}
-
-static void armada_370_xp_timer_resume(void)
-{
-	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
-	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
-	writel(timer0_ctrl_reg, timer_base + TIMER_CTRL_OFF);
-	writel(timer0_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
-}
-
-static struct syscore_ops armada_370_xp_timer_syscore_ops = {
-	.suspend	= armada_370_xp_timer_suspend,
-	.resume		= armada_370_xp_timer_resume,
-};
-
-static unsigned long armada_370_delay_timer_read(void)
-{
-	return ~readl(timer_base + TIMER0_VAL_OFF);
-}
-
-static struct delay_timer armada_370_delay_timer = {
-	.read_current_timer = armada_370_delay_timer_read,
-};
-
-static int __init armada_370_xp_timer_common_init(struct device_node *np)
-{
-	u32 clr = 0, set = 0;
-	int res;
-
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	local_base = of_iomap(np, 1);
-	if (!local_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	if (timer25Mhz) {
-		set = TIMER0_25MHZ;		
-		enable_mask = TIMER0_EN;
-	} else {
-		clr = TIMER0_25MHZ;
-		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
-	}
-	atomic_io_modify(timer_base + TIMER_CTRL_OFF, clr | set, set);
-	local_timer_ctrl_clrset(clr, set);
-
-	/*
-	 * We use timer 0 as clocksource, and private(local) timer 0
-	 * for clockevents
-	 */
-	armada_370_xp_clkevt_irq = irq_of_parse_and_map(np, 4);
-
-	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
-
-	/*
-	 * Setup free-running clocksource timer (interrupts
-	 * disabled).
-	 */
-	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
-	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
-
-	atomic_io_modify(timer_base + TIMER_CTRL_OFF,
-		TIMER0_RELOAD_EN | enable_mask,
-		TIMER0_RELOAD_EN | enable_mask);
-
-	armada_370_delay_timer.freq = timer_clk;
-	register_current_timer_delay(&armada_370_delay_timer);
-
-	/*
-	 * Set scale and timer for sched_clock.
-	 */
-	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
-
-	res = clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
-				    "armada_370_xp_clocksource",
-				    timer_clk, 300, 32, clocksource_mmio_readl_down);
-	if (res) {
-		pr_err("Failed to initialize clocksource mmio\n");
-		return res;
-	}
-
-	armada_370_xp_evt = alloc_percpu(struct clock_event_device);
-	if (!armada_370_xp_evt)
-		return -ENOMEM;
-
-	/*
-	 * Setup clockevent timer (interrupt-driven).
-	 */
-	res = request_percpu_irq(armada_370_xp_clkevt_irq,
-				armada_370_xp_timer_interrupt,
-				"armada_370_xp_per_cpu_tick",
-				armada_370_xp_evt);
-	/* Immediately configure the timer on the boot CPU */
-	if (res) {
-		pr_err("Failed to request percpu irq\n");
-		return res;
-	}
-
-	res = cpuhp_setup_state(CPUHP_AP_ARMADA_TIMER_STARTING,
-				"clockevents/armada:starting",
-				armada_370_xp_timer_starting_cpu,
-				armada_370_xp_timer_dying_cpu);
-	if (res) {
-		pr_err("Failed to setup hotplug state and timer\n");
-		return res;
-	}
-
-	register_syscore_ops(&armada_370_xp_timer_syscore_ops);
-	
-	return 0;
-}
-
-static int __init armada_xp_timer_init(struct device_node *np)
-{
-	struct clk *clk = of_clk_get_by_name(np, "fixed");
-	int ret;
-
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	timer_clk = clk_get_rate(clk);
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
-		       armada_xp_timer_init);
-
-static int __init armada_375_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get_by_name(np, "fixed");
-	if (!IS_ERR(clk)) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-		timer_clk = clk_get_rate(clk);
-	} else {
-
-		/*
-		 * This fallback is required in order to retain proper
-		 * devicetree backwards compatibility.
-		 */
-		clk = of_clk_get(np, 0);
-
-		/* Must have at least a clock */
-		if (IS_ERR(clk)) {
-			pr_err("Failed to get clock\n");
-			return PTR_ERR(clk);
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-
-		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
-		timer25Mhz = false;
-	}
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_375, "marvell,armada-375-timer",
-		       armada_375_timer_init);
-
-static int __init armada_370_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
-	timer25Mhz = false;
-
-	return armada_370_xp_timer_common_init(np);
-}
-TIMER_OF_DECLARE(armada_370, "marvell,armada-370-timer",
-		       armada_370_timer_init);
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
deleted file mode 100644
index 257e810..0000000
--- a/drivers/clocksource/time-efm32.c
+++ /dev/null
@@ -1,287 +0,0 @@
-/*
- * Copyright (C) 2013 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-
-#define TIMERn_CTRL			0x00
-#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
-#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
-#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
-#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
-#define TIMERn_CTRL_OSMEN			0x00000010
-#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
-#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
-#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
-
-#define TIMERn_CMD			0x04
-#define TIMERn_CMD_START			0x00000001
-#define TIMERn_CMD_STOP				0x00000002
-
-#define TIMERn_IEN			0x0c
-#define TIMERn_IF			0x10
-#define TIMERn_IFS			0x14
-#define TIMERn_IFC			0x18
-#define TIMERn_IRQ_UF				0x00000002
-
-#define TIMERn_TOP			0x1c
-#define TIMERn_CNT			0x24
-
-struct efm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	unsigned periodic_top;
-};
-
-static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_OSMEN |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	return 0;
-}
-
-static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(evt, ddata->base + TIMERn_CNT);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-
-	return 0;
-}
-
-static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
-{
-	struct efm32_clock_event_ddata *ddata = dev_id;
-
-	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct efm32_clock_event_ddata clock_event_ddata = {
-	.evtdev = {
-		.name = "efm32 clockevent",
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_state_shutdown = efm32_clock_event_shutdown,
-		.set_state_periodic = efm32_clock_event_set_periodic,
-		.set_state_oneshot = efm32_clock_event_set_oneshot,
-		.set_next_event = efm32_clock_event_set_next_event,
-		.rating = 200,
-	},
-};
-
-static struct irqaction efm32_clock_event_irq = {
-	.name = "efm32 clockevent",
-	.flags = IRQF_TIMER,
-	.handler = efm32_clock_event_handler,
-	.dev_id = &clock_event_ddata,
-};
-
-static int __init efm32_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clocksource (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clocksource (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clocksource\n");
-		goto err_iomap;
-	}
-
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
-
-	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
-				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
-				    clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	return 0;
-
-err_clocksource_init:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-static int __init efm32_clockevent_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int irq;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -ENOENT;
-		pr_err("failed to get irq for clockevent\n");
-		goto err_get_irq;
-	}
-
-	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
-
-	clock_event_ddata.base = base;
-	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
-
-	clockevents_config_and_register(&clock_event_ddata.evtdev,
-					DIV_ROUND_CLOSEST(rate, 1024),
-					0xf, 0xffff);
-
-	ret = setup_irq(irq, &efm32_clock_event_irq);
-	if (ret) {
-		pr_err("Failed setup irq\n");
-		goto err_setup_irq;
-	}
-
-	return 0;
-
-err_setup_irq:
-err_get_irq:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init efm32_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret = 0;
-
-	if (!has_clocksource) {
-		ret = efm32_clocksource_init(np);
-		if (!ret) {
-			has_clocksource = 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret = efm32_clockevent_init(np);
-		if (!ret) {
-			has_clockevent = 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
-TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
deleted file mode 100644
index d51a62a..0000000
--- a/drivers/clocksource/time-lpc32xx.c
+++ /dev/null
@@ -1,314 +0,0 @@
-/*
- * Clocksource driver for NXP LPC32xx/18xx/43xx timer
- *
- * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- *
- * Based on:
- * time-efm32 Copyright (C) 2013 Pengutronix
- * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- */
-
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-#define LPC32XX_TIMER_IR		0x000
-#define  LPC32XX_TIMER_IR_MR0INT	BIT(0)
-#define LPC32XX_TIMER_TCR		0x004
-#define  LPC32XX_TIMER_TCR_CEN		BIT(0)
-#define  LPC32XX_TIMER_TCR_CRST		BIT(1)
-#define LPC32XX_TIMER_TC		0x008
-#define LPC32XX_TIMER_PR		0x00c
-#define LPC32XX_TIMER_MCR		0x014
-#define  LPC32XX_TIMER_MCR_MR0I		BIT(0)
-#define  LPC32XX_TIMER_MCR_MR0R		BIT(1)
-#define  LPC32XX_TIMER_MCR_MR0S		BIT(2)
-#define LPC32XX_TIMER_MR0		0x018
-#define LPC32XX_TIMER_CTCR		0x070
-
-struct lpc32xx_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	u32 ticks_per_jiffy;
-};
-
-/* Needed for the sched clock */
-static void __iomem *clocksource_timer_counter;
-
-static u64 notrace lpc32xx_read_sched_clock(void)
-{
-	return readl(clocksource_timer_counter);
-}
-
-static unsigned long lpc32xx_delay_timer_read(void)
-{
-	return readl(clocksource_timer_counter);
-}
-
-static struct delay_timer lpc32xx_delay_timer = {
-	.read_current_timer = lpc32xx_delay_timer_read,
-};
-
-static int lpc32xx_clkevt_next_event(unsigned long delta,
-				     struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/*
-	 * Place timer in reset and program the delta in the match
-	 * channel 0 (MR0). When the timer counter matches the value
-	 * in MR0 register the match will trigger an interrupt.
-	 * After setup the timer is released from reset and enabled.
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
-	writel_relaxed(delta, ddata->base + LPC32XX_TIMER_MR0);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/* Disable the timer */
-	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/*
-	 * When using oneshot, we must also disable the timer
-	 * to wait for the first call to set_next_event().
-	 */
-	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
-
-	/* Enable interrupt, reset on match and stop on match (MCR). */
-	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
-		       LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
-	return 0;
-}
-
-static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
-{
-	struct lpc32xx_clock_event_ddata *ddata =
-		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
-
-	/* Enable interrupt and reset on match. */
-	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
-		       ddata->base + LPC32XX_TIMER_MCR);
-
-	/*
-	 * Place timer in reset and program the delta in the match
-	 * channel 0 (MR0).
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
-	writel_relaxed(ddata->ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
-
-	return 0;
-}
-
-static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
-{
-	struct lpc32xx_clock_event_ddata *ddata = dev_id;
-
-	/* Clear match on channel 0 */
-	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, ddata->base + LPC32XX_TIMER_IR);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
-	.evtdev = {
-		.name			= "lpc3220 clockevent",
-		.features		= CLOCK_EVT_FEAT_ONESHOT |
-					  CLOCK_EVT_FEAT_PERIODIC,
-		.rating			= 300,
-		.set_next_event		= lpc32xx_clkevt_next_event,
-		.set_state_shutdown	= lpc32xx_clkevt_shutdown,
-		.set_state_oneshot	= lpc32xx_clkevt_oneshot,
-		.set_state_periodic	= lpc32xx_clkevt_periodic,
-	},
-};
-
-static int __init lpc32xx_clocksource_init(struct device_node *np)
-{
-	void __iomem *base;
-	unsigned long rate;
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get_by_name(np, "timerclk");
-	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
-		goto err_clk_enable;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("unable to map registers\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_iomap;
-	}
-
-	/*
-	 * Disable and reset timer then set it to free running timer
-	 * mode (CTCR) with no prescaler (PR) or match operations (MCR).
-	 * After setup the timer is released from reset and enabled.
-	 */
-	writel_relaxed(LPC32XX_TIMER_TCR_CRST, base + LPC32XX_TIMER_TCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_PR);
-	writel_relaxed(0, base + LPC32XX_TIMER_MCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
-	writel_relaxed(LPC32XX_TIMER_TCR_CEN, base + LPC32XX_TIMER_TCR);
-
-	rate = clk_get_rate(clk);
-	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3220 timer",
-				    rate, 300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
-	lpc32xx_delay_timer.freq = rate;
-	register_current_timer_delay(&lpc32xx_delay_timer);
-	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
-
-	return 0;
-
-err_clocksource_init:
-	iounmap(base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-	return ret;
-}
-
-static int __init lpc32xx_clockevent_init(struct device_node *np)
-{
-	void __iomem *base;
-	unsigned long rate;
-	struct clk *clk;
-	int ret, irq;
-
-	clk = of_clk_get_by_name(np, "timerclk");
-	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
-		goto err_clk_enable;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("unable to map registers\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		pr_err("get irq failed\n");
-		ret = -ENOENT;
-		goto err_irq;
-	}
-
-	/*
-	 * Disable timer and clear any pending interrupt (IR) on match
-	 * channel 0 (MR0). Clear the prescaler as it's not used.
-	 */
-	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
-	writel_relaxed(0, base + LPC32XX_TIMER_PR);
-	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
-	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
-
-	rate = clk_get_rate(clk);
-	lpc32xx_clk_event_ddata.base = base;
-	lpc32xx_clk_event_ddata.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
-	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
-					rate, 1, -1);
-
-	ret = request_irq(irq, lpc32xx_clock_event_handler,
-			  IRQF_TIMER | IRQF_IRQPOLL, "lpc3220 clockevent",
-			  &lpc32xx_clk_event_ddata);
-	if (ret) {
-		pr_err("request irq failed\n");
-		goto err_irq;
-	}
-
-	return 0;
-
-err_irq:
-	iounmap(base);
-err_iomap:
-	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init lpc32xx_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret = 0;
-
-	if (!has_clocksource) {
-		ret = lpc32xx_clocksource_init(np);
-		if (!ret) {
-			has_clocksource = 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret = lpc32xx_clockevent_init(np);
-		if (!ret) {
-			has_clockevent = 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
deleted file mode 100644
index 7d487107..0000000
--- a/drivers/clocksource/time-orion.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Marvell Orion SoC timer handling.
- *
- * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * Timer 0 is used as free-running clocksource, while timer 1 is
- * used as clock_event_device.
- */
-
-#include <linux/kernel.h>
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/spinlock.h>
-#include <linux/sched_clock.h>
-
-#define TIMER_CTRL		0x00
-#define  TIMER0_EN		BIT(0)
-#define  TIMER0_RELOAD_EN	BIT(1)
-#define  TIMER1_EN		BIT(2)
-#define  TIMER1_RELOAD_EN	BIT(3)
-#define TIMER0_RELOAD		0x10
-#define TIMER0_VAL		0x14
-#define TIMER1_RELOAD		0x18
-#define TIMER1_VAL		0x1c
-
-#define ORION_ONESHOT_MIN	1
-#define ORION_ONESHOT_MAX	0xfffffffe
-
-static void __iomem *timer_base;
-
-static unsigned long notrace orion_read_timer(void)
-{
-	return ~readl(timer_base + TIMER0_VAL);
-}
-
-static struct delay_timer orion_delay_timer = {
-	.read_current_timer = orion_read_timer,
-};
-
-static void orion_delay_timer_init(unsigned long rate)
-{
-	orion_delay_timer.freq = rate;
-	register_current_timer_delay(&orion_delay_timer);
-}
-
-/*
- * Free-running clocksource handling.
- */
-static u64 notrace orion_read_sched_clock(void)
-{
-	return ~readl(timer_base + TIMER0_VAL);
-}
-
-/*
- * Clockevent handling.
- */
-static u32 ticks_per_jiffy;
-
-static int orion_clkevt_next_event(unsigned long delta,
-				   struct clock_event_device *dev)
-{
-	/* setup and enable one-shot timer */
-	writel(delta, timer_base + TIMER1_VAL);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
-
-	return 0;
-}
-
-static int orion_clkevt_shutdown(struct clock_event_device *dev)
-{
-	/* disable timer */
-	atomic_io_modify(timer_base + TIMER_CTRL,
-			 TIMER1_RELOAD_EN | TIMER1_EN, 0);
-	return 0;
-}
-
-static int orion_clkevt_set_periodic(struct clock_event_device *dev)
-{
-	/* setup and enable periodic timer at 1/HZ intervals */
-	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
-	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-			 TIMER1_RELOAD_EN | TIMER1_EN,
-			 TIMER1_RELOAD_EN | TIMER1_EN);
-	return 0;
-}
-
-static struct clock_event_device orion_clkevt = {
-	.name			= "orion_event",
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC,
-	.shift			= 32,
-	.rating			= 300,
-	.set_next_event		= orion_clkevt_next_event,
-	.set_state_shutdown	= orion_clkevt_shutdown,
-	.set_state_periodic	= orion_clkevt_set_periodic,
-	.set_state_oneshot	= orion_clkevt_shutdown,
-	.tick_resume		= orion_clkevt_shutdown,
-};
-
-static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
-{
-	orion_clkevt.event_handler(&orion_clkevt);
-	return IRQ_HANDLED;
-}
-
-static struct irqaction orion_clkevt_irq = {
-	.name		= "orion_event",
-	.flags		= IRQF_TIMER,
-	.handler	= orion_clkevt_irq_handler,
-};
-
-static int __init orion_timer_init(struct device_node *np)
-{
-	unsigned long rate;
-	struct clk *clk;
-	int irq, ret;
-
-	/* timer registers are shared with watchdog timer */
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("%pOFn: unable to map resource\n", np);
-		return -ENXIO;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%pOFn: unable to get clk\n", np);
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Failed to prepare clock\n");
-		return ret;
-	}
-
-	/* we are only interested in timer1 irq */
-	irq = irq_of_parse_and_map(np, 1);
-	if (irq <= 0) {
-		pr_err("%pOFn: unable to parse timer1 irq\n", np);
-		return -EINVAL;
-	}
-
-	rate = clk_get_rate(clk);
-
-	/* setup timer0 as free-running clocksource */
-	writel(~0, timer_base + TIMER0_VAL);
-	writel(~0, timer_base + TIMER0_RELOAD);
-	atomic_io_modify(timer_base + TIMER_CTRL,
-		TIMER0_RELOAD_EN | TIMER0_EN,
-		TIMER0_RELOAD_EN | TIMER0_EN);
-
-	ret = clocksource_mmio_init(timer_base + TIMER0_VAL,
-				    "orion_clocksource", rate, 300, 32,
-				    clocksource_mmio_readl_down);
-	if (ret) {
-		pr_err("Failed to initialize mmio timer\n");
-		return ret;
-	}
-
-	sched_clock_register(orion_read_sched_clock, 32, rate);
-
-	/* setup timer1 as clockevent timer */
-	ret = setup_irq(irq, &orion_clkevt_irq);
-	if (ret) {
-		pr_err("%pOFn: unable to setup irq\n", np);
-		return ret;
-	}
-
-	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
-	orion_clkevt.cpumask = cpumask_of(0);
-	orion_clkevt.irq = irq;
-	clockevents_config_and_register(&orion_clkevt, rate,
-					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
-
-
-	orion_delay_timer_init(rate);
-
-	return 0;
-}
-TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
deleted file mode 100644
index a2dd85d..0000000
--- a/drivers/clocksource/time-pistachio.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Pistachio clocksource based on general-purpose timers
- *
- * Copyright (C) 2015 Imagination Technologies
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
-#include <linux/clk.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/sched_clock.h>
-#include <linux/time.h>
-
-/* Top level reg */
-#define CR_TIMER_CTRL_CFG		0x00
-#define TIMER_ME_GLOBAL			BIT(0)
-#define CR_TIMER_REV			0x10
-
-/* Timer specific registers */
-#define TIMER_CFG			0x20
-#define TIMER_ME_LOCAL			BIT(0)
-#define TIMER_RELOAD_VALUE		0x24
-#define TIMER_CURRENT_VALUE		0x28
-#define TIMER_CURRENT_OVERFLOW_VALUE	0x2C
-#define TIMER_IRQ_STATUS		0x30
-#define TIMER_IRQ_CLEAR			0x34
-#define TIMER_IRQ_MASK			0x38
-
-#define PERIP_TIMER_CONTROL		0x90
-
-/* Timer specific configuration Values */
-#define RELOAD_VALUE			0xffffffff
-
-struct pistachio_clocksource {
-	void __iomem *base;
-	raw_spinlock_t lock;
-	struct clocksource cs;
-};
-
-static struct pistachio_clocksource pcs_gpt;
-
-#define to_pistachio_clocksource(cs)	\
-	container_of(cs, struct pistachio_clocksource, cs)
-
-static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
-{
-	return readl(base + 0x20 * gpt_id + offset);
-}
-
-static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
-		u32 gpt_id)
-{
-	writel(value, base + 0x20 * gpt_id + offset);
-}
-
-static u64 notrace
-pistachio_clocksource_read_cycles(struct clocksource *cs)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflw;
-	unsigned long flags;
-
-	/*
-	 * The counter value is only refreshed after the overflow value is read.
-	 * And they must be read in strict order, hence raw spin lock added.
-	 */
-
-	raw_spin_lock_irqsave(&pcs->lock, flags);
-	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
-	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
-	raw_spin_unlock_irqrestore(&pcs->lock, flags);
-
-	return (u64)~counter;
-}
-
-static u64 notrace pistachio_read_sched_clock(void)
-{
-	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
-}
-
-static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
-			int enable)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 val;
-
-	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
-	if (enable)
-		val |= TIMER_ME_LOCAL;
-	else
-		val &= ~TIMER_ME_LOCAL;
-
-	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
-}
-
-static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
-{
-	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-
-	/* Disable GPT local before loading reload value */
-	pistachio_clksrc_set_mode(cs, timeridx, false);
-	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
-	pistachio_clksrc_set_mode(cs, timeridx, true);
-}
-
-static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
-{
-	/* Disable GPT local */
-	pistachio_clksrc_set_mode(cs, timeridx, false);
-}
-
-static int pistachio_clocksource_enable(struct clocksource *cs)
-{
-	pistachio_clksrc_enable(cs, 0);
-	return 0;
-}
-
-static void pistachio_clocksource_disable(struct clocksource *cs)
-{
-	pistachio_clksrc_disable(cs, 0);
-}
-
-/* Desirable clock source for pistachio platform */
-static struct pistachio_clocksource pcs_gpt = {
-	.cs =	{
-		.name		= "gptimer",
-		.rating		= 300,
-		.enable		= pistachio_clocksource_enable,
-		.disable	= pistachio_clocksource_disable,
-		.read		= pistachio_clocksource_read_cycles,
-		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_SUSPEND_NONSTOP,
-		},
-};
-
-static int __init pistachio_clksrc_of_init(struct device_node *node)
-{
-	struct clk *sys_clk, *fast_clk;
-	struct regmap *periph_regs;
-	unsigned long rate;
-	int ret;
-
-	pcs_gpt.base = of_iomap(node, 0);
-	if (!pcs_gpt.base) {
-		pr_err("cannot iomap\n");
-		return -ENXIO;
-	}
-
-	periph_regs = syscon_regmap_lookup_by_phandle(node, "img,cr-periph");
-	if (IS_ERR(periph_regs)) {
-		pr_err("cannot get peripheral regmap (%ld)\n",
-		       PTR_ERR(periph_regs));
-		return PTR_ERR(periph_regs);
-	}
-
-	/* Switch to using the fast counter clock */
-	ret = regmap_update_bits(periph_regs, PERIP_TIMER_CONTROL,
-				 0xf, 0x0);
-	if (ret)
-		return ret;
-
-	sys_clk = of_clk_get_by_name(node, "sys");
-	if (IS_ERR(sys_clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(sys_clk));
-		return PTR_ERR(sys_clk);
-	}
-
-	fast_clk = of_clk_get_by_name(node, "fast");
-	if (IS_ERR(fast_clk)) {
-		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
-		return PTR_ERR(fast_clk);
-	}
-
-	ret = clk_prepare_enable(sys_clk);
-	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(fast_clk);
-	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
-		clk_disable_unprepare(sys_clk);
-		return ret;
-	}
-
-	rate = clk_get_rate(fast_clk);
-
-	/* Disable irq's for clocksource usage */
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
-	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
-
-	/* Enable timer block */
-	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
-
-	raw_spin_lock_init(&pcs_gpt.lock);
-	sched_clock_register(pistachio_read_sched_clock, 32, rate);
-	return clocksource_register_hz(&pcs_gpt.cs, rate);
-}
-TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
-		       pistachio_clksrc_of_init);
diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
new file mode 100644
index 0000000..edf1a46
--- /dev/null
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -0,0 +1,416 @@
+/*
+ * Marvell Armada 370/XP SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ *
+ * ---
+ * Clocksource driver for Armada 370 and Armada XP SoC.
+ * This driver implements one compatible string for each SoC, given
+ * each has its own characteristics:
+ *
+ *   * Armada 370 has no 25 MHz fixed timer.
+ *
+ *   * Armada XP cannot work properly without such 25 MHz fixed timer as
+ *     doing otherwise leads to using a clocksource whose frequency varies
+ *     when doing cpufreq frequency changes.
+ *
+ * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/timer.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/sched_clock.h>
+#include <linux/percpu.h>
+#include <linux/syscore_ops.h>
+
+#include <asm/delay.h>
+
+/*
+ * Timer block registers.
+ */
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 BIT(0)
+#define  TIMER0_RELOAD_EN	 BIT(1)
+#define  TIMER0_25MHZ            BIT(11)
+#define  TIMER0_DIV(div)         ((div) << 19)
+#define  TIMER1_EN		 BIT(2)
+#define  TIMER1_RELOAD_EN	 BIT(3)
+#define  TIMER1_25MHZ            BIT(12)
+#define  TIMER1_DIV(div)         ((div) << 22)
+#define TIMER_EVENTS_STATUS	0x0004
+#define  TIMER0_CLR_MASK         (~0x1)
+#define  TIMER1_CLR_MASK         (~0x100)
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+#define LCL_TIMER_EVENTS_STATUS	0x0028
+/* Global timers are connected to the coherency fabric clock, and the
+   below divider reduces their incrementing frequency. */
+#define TIMER_DIVIDER_SHIFT     5
+#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *timer_base, *local_base;
+static unsigned int timer_clk;
+static bool timer25Mhz = true;
+static u32 enable_mask;
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
+
+static struct clock_event_device __percpu *armada_370_xp_evt;
+
+static void local_timer_ctrl_clrset(u32 clr, u32 set)
+{
+	writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
+		local_base + TIMER_CTRL_OFF);
+}
+
+static u64 notrace armada_370_xp_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+/*
+ * Clockevent handling.
+ */
+static int
+armada_370_xp_clkevt_next_event(unsigned long delta,
+				struct clock_event_device *dev)
+{
+	/*
+	 * Clear clockevent timer interrupt.
+	 */
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+
+	/*
+	 * Setup new clockevent timer value.
+	 */
+	writel(delta, local_base + TIMER0_VAL_OFF);
+
+	/*
+	 * Enable the timer.
+	 */
+	local_timer_ctrl_clrset(TIMER0_RELOAD_EN, enable_mask);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_shutdown(struct clock_event_device *evt)
+{
+	/*
+	 * Disable timer.
+	 */
+	local_timer_ctrl_clrset(TIMER0_EN, 0);
+
+	/*
+	 * ACK pending timer interrupt.
+	 */
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	/*
+	 * Setup timer to fire at 1/HZ intervals.
+	 */
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
+
+	/*
+	 * Enable timer.
+	 */
+	local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
+	return 0;
+}
+
+static int armada_370_xp_clkevt_irq;
+
+static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * ACK timer interrupt and call event handler.
+	 */
+	struct clock_event_device *evt = dev_id;
+
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
+	u32 clr = 0, set = 0;
+
+	if (timer25Mhz)
+		set = TIMER0_25MHZ;
+	else
+		clr = TIMER0_25MHZ;
+	local_timer_ctrl_clrset(clr, set);
+
+	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC;
+	evt->shift		= 32,
+	evt->rating		= 300,
+	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
+	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
+	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
+	evt->tick_resume	= armada_370_xp_clkevt_shutdown;
+	evt->irq		= armada_370_xp_clkevt_irq;
+	evt->cpumask		= cpumask_of(cpu);
+
+	clockevents_config_and_register(evt, timer_clk, 1, 0xfffffffe);
+	enable_percpu_irq(evt->irq, 0);
+
+	return 0;
+}
+
+static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
+
+	evt->set_state_shutdown(evt);
+	disable_percpu_irq(evt->irq);
+	return 0;
+}
+
+static u32 timer0_ctrl_reg, timer0_local_ctrl_reg;
+
+static int armada_370_xp_timer_suspend(void)
+{
+	timer0_ctrl_reg = readl(timer_base + TIMER_CTRL_OFF);
+	timer0_local_ctrl_reg = readl(local_base + TIMER_CTRL_OFF);
+	return 0;
+}
+
+static void armada_370_xp_timer_resume(void)
+{
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+	writel(timer0_ctrl_reg, timer_base + TIMER_CTRL_OFF);
+	writel(timer0_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
+}
+
+static struct syscore_ops armada_370_xp_timer_syscore_ops = {
+	.suspend	= armada_370_xp_timer_suspend,
+	.resume		= armada_370_xp_timer_resume,
+};
+
+static unsigned long armada_370_delay_timer_read(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+static struct delay_timer armada_370_delay_timer = {
+	.read_current_timer = armada_370_delay_timer_read,
+};
+
+static int __init armada_370_xp_timer_common_init(struct device_node *np)
+{
+	u32 clr = 0, set = 0;
+	int res;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	local_base = of_iomap(np, 1);
+	if (!local_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	if (timer25Mhz) {
+		set = TIMER0_25MHZ;		
+		enable_mask = TIMER0_EN;
+	} else {
+		clr = TIMER0_25MHZ;
+		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
+	}
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF, clr | set, set);
+	local_timer_ctrl_clrset(clr, set);
+
+	/*
+	 * We use timer 0 as clocksource, and private(local) timer 0
+	 * for clockevents
+	 */
+	armada_370_xp_clkevt_irq = irq_of_parse_and_map(np, 4);
+
+	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled).
+	 */
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF,
+		TIMER0_RELOAD_EN | enable_mask,
+		TIMER0_RELOAD_EN | enable_mask);
+
+	armada_370_delay_timer.freq = timer_clk;
+	register_current_timer_delay(&armada_370_delay_timer);
+
+	/*
+	 * Set scale and timer for sched_clock.
+	 */
+	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
+
+	res = clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
+				    "armada_370_xp_clocksource",
+				    timer_clk, 300, 32, clocksource_mmio_readl_down);
+	if (res) {
+		pr_err("Failed to initialize clocksource mmio\n");
+		return res;
+	}
+
+	armada_370_xp_evt = alloc_percpu(struct clock_event_device);
+	if (!armada_370_xp_evt)
+		return -ENOMEM;
+
+	/*
+	 * Setup clockevent timer (interrupt-driven).
+	 */
+	res = request_percpu_irq(armada_370_xp_clkevt_irq,
+				armada_370_xp_timer_interrupt,
+				"armada_370_xp_per_cpu_tick",
+				armada_370_xp_evt);
+	/* Immediately configure the timer on the boot CPU */
+	if (res) {
+		pr_err("Failed to request percpu irq\n");
+		return res;
+	}
+
+	res = cpuhp_setup_state(CPUHP_AP_ARMADA_TIMER_STARTING,
+				"clockevents/armada:starting",
+				armada_370_xp_timer_starting_cpu,
+				armada_370_xp_timer_dying_cpu);
+	if (res) {
+		pr_err("Failed to setup hotplug state and timer\n");
+		return res;
+	}
+
+	register_syscore_ops(&armada_370_xp_timer_syscore_ops);
+	
+	return 0;
+}
+
+static int __init armada_xp_timer_init(struct device_node *np)
+{
+	struct clk *clk = of_clk_get_by_name(np, "fixed");
+	int ret;
+
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	timer_clk = clk_get_rate(clk);
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
+		       armada_xp_timer_init);
+
+static int __init armada_375_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get_by_name(np, "fixed");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		timer_clk = clk_get_rate(clk);
+	} else {
+
+		/*
+		 * This fallback is required in order to retain proper
+		 * devicetree backwards compatibility.
+		 */
+		clk = of_clk_get(np, 0);
+
+		/* Must have at least a clock */
+		if (IS_ERR(clk)) {
+			pr_err("Failed to get clock\n");
+			return PTR_ERR(clk);
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+
+		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
+		timer25Mhz = false;
+	}
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_375, "marvell,armada-375-timer",
+		       armada_375_timer_init);
+
+static int __init armada_370_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
+	timer25Mhz = false;
+
+	return armada_370_xp_timer_common_init(np);
+}
+TIMER_OF_DECLARE(armada_370, "marvell,armada-370-timer",
+		       armada_370_timer_init);
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
new file mode 100644
index 0000000..b334029
--- /dev/null
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -0,0 +1,543 @@
+/*
+ * This file contains driver for the Cadence Triple Timer Counter Rev 06
+ *
+ *  Copyright (C) 2011-2013 Xilinx
+ *
+ * based on arch/mips/kernel/time.c timer driver
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/sched_clock.h>
+
+/*
+ * This driver configures the 2 16/32-bit count-up timers as follows:
+ *
+ * T1: Timer 1, clocksource for generic timekeeping
+ * T2: Timer 2, clockevent source for hrtimers
+ * T3: Timer 3, <unused>
+ *
+ * The input frequency to the timer module for emulation is 2.5MHz which is
+ * common to all the timer channels (T1, T2, and T3). With a pre-scaler of 32,
+ * the timers are clocked at 78.125KHz (12.8 us resolution).
+
+ * The input frequency to the timer module in silicon is configurable and
+ * obtained from device tree. The pre-scaler of 32 is used.
+ */
+
+/*
+ * Timer Register Offset Definitions of Timer 1, Increment base address by 4
+ * and use same offsets for Timer 2
+ */
+#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
+#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
+#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
+#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
+#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
+#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
+
+#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
+
+#define TTC_CLK_CNTRL_CSRC_MASK		(1 << 5)	/* clock source */
+#define TTC_CLK_CNTRL_PSV_MASK		0x1e
+#define TTC_CLK_CNTRL_PSV_SHIFT		1
+
+/*
+ * Setup the timers to use pre-scaling, using a fixed value for now that will
+ * work across most input frequency, but it may need to be more dynamic
+ */
+#define PRESCALE_EXPONENT	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
+#define PRESCALE		2048	/* The exponent must match this */
+#define CLK_CNTRL_PRESCALE	((PRESCALE_EXPONENT - 1) << 1)
+#define CLK_CNTRL_PRESCALE_EN	1
+#define CNT_CNTRL_RESET		(1 << 4)
+
+#define MAX_F_ERR 50
+
+/**
+ * struct ttc_timer - This definition defines local timer structure
+ *
+ * @base_addr:	Base address of timer
+ * @freq:	Timer input clock frequency
+ * @clk:	Associated clock source
+ * @clk_rate_change_nb	Notifier block for clock rate changes
+ */
+struct ttc_timer {
+	void __iomem *base_addr;
+	unsigned long freq;
+	struct clk *clk;
+	struct notifier_block clk_rate_change_nb;
+};
+
+#define to_ttc_timer(x) \
+		container_of(x, struct ttc_timer, clk_rate_change_nb)
+
+struct ttc_timer_clocksource {
+	u32			scale_clk_ctrl_reg_old;
+	u32			scale_clk_ctrl_reg_new;
+	struct ttc_timer	ttc;
+	struct clocksource	cs;
+};
+
+#define to_ttc_timer_clksrc(x) \
+		container_of(x, struct ttc_timer_clocksource, cs)
+
+struct ttc_timer_clockevent {
+	struct ttc_timer		ttc;
+	struct clock_event_device	ce;
+};
+
+#define to_ttc_timer_clkevent(x) \
+		container_of(x, struct ttc_timer_clockevent, ce)
+
+static void __iomem *ttc_sched_clock_val_reg;
+
+/**
+ * ttc_set_interval - Set the timer interval value
+ *
+ * @timer:	Pointer to the timer instance
+ * @cycles:	Timer interval ticks
+ **/
+static void ttc_set_interval(struct ttc_timer *timer,
+					unsigned long cycles)
+{
+	u32 ctrl_reg;
+
+	/* Disable the counter, set the counter value  and re-enable counter */
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+
+	writel_relaxed(cycles, timer->base_addr + TTC_INTR_VAL_OFFSET);
+
+	/*
+	 * Reset the counter (0x10) so that it starts from 0, one-shot
+	 * mode makes this needed for timing to be right.
+	 */
+	ctrl_reg |= CNT_CNTRL_RESET;
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+}
+
+/**
+ * ttc_clock_event_interrupt - Clock event timer interrupt handler
+ *
+ * @irq:	IRQ number of the Timer
+ * @dev_id:	void pointer to the ttc_timer instance
+ *
+ * returns: Always IRQ_HANDLED - success
+ **/
+static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
+{
+	struct ttc_timer_clockevent *ttce = dev_id;
+	struct ttc_timer *timer = &ttce->ttc;
+
+	/* Acknowledge the interrupt and call event handler */
+	readl_relaxed(timer->base_addr + TTC_ISR_OFFSET);
+
+	ttce->ce.event_handler(&ttce->ce);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * __ttc_clocksource_read - Reads the timer counter register
+ *
+ * returns: Current timer counter register value
+ **/
+static u64 __ttc_clocksource_read(struct clocksource *cs)
+{
+	struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
+
+	return (u64)readl_relaxed(timer->base_addr +
+				TTC_COUNT_VAL_OFFSET);
+}
+
+static u64 notrace ttc_sched_clock_read(void)
+{
+	return readl_relaxed(ttc_sched_clock_val_reg);
+}
+
+/**
+ * ttc_set_next_event - Sets the time interval for next event
+ *
+ * @cycles:	Timer interval ticks
+ * @evt:	Address of clock event instance
+ *
+ * returns: Always 0 - success
+ **/
+static int ttc_set_next_event(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+
+	ttc_set_interval(timer, cycles);
+	return 0;
+}
+
+/**
+ * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
+ *
+ * @evt:	Address of clock event instance
+ **/
+static int ttc_shutdown(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+	u32 ctrl_reg;
+
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
+}
+
+static int ttc_set_periodic(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+
+	ttc_set_interval(timer,
+			 DIV_ROUND_CLOSEST(ttce->ttc.freq, PRESCALE * HZ));
+	return 0;
+}
+
+static int ttc_resume(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+	u32 ctrl_reg;
+
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
+}
+
+static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clocksource *ttccs = container_of(ttc,
+			struct ttc_timer_clocksource, ttc);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+	{
+		u32 psv;
+		unsigned long factor, rate_low, rate_high;
+
+		if (ndata->new_rate > ndata->old_rate) {
+			factor = DIV_ROUND_CLOSEST(ndata->new_rate,
+					ndata->old_rate);
+			rate_low = ndata->old_rate;
+			rate_high = ndata->new_rate;
+		} else {
+			factor = DIV_ROUND_CLOSEST(ndata->old_rate,
+					ndata->new_rate);
+			rate_low = ndata->new_rate;
+			rate_high = ndata->old_rate;
+		}
+
+		if (!is_power_of_2(factor))
+				return NOTIFY_BAD;
+
+		if (abs(rate_high - (factor * rate_low)) > MAX_F_ERR)
+			return NOTIFY_BAD;
+
+		factor = __ilog2_u32(factor);
+
+		/*
+		 * store timer clock ctrl register so we can restore it in case
+		 * of an abort.
+		 */
+		ttccs->scale_clk_ctrl_reg_old =
+			readl_relaxed(ttccs->ttc.base_addr +
+			TTC_CLK_CNTRL_OFFSET);
+
+		psv = (ttccs->scale_clk_ctrl_reg_old &
+				TTC_CLK_CNTRL_PSV_MASK) >>
+				TTC_CLK_CNTRL_PSV_SHIFT;
+		if (ndata->new_rate < ndata->old_rate)
+			psv -= factor;
+		else
+			psv += factor;
+
+		/* prescaler within legal range? */
+		if (psv & ~(TTC_CLK_CNTRL_PSV_MASK >> TTC_CLK_CNTRL_PSV_SHIFT))
+			return NOTIFY_BAD;
+
+		ttccs->scale_clk_ctrl_reg_new = ttccs->scale_clk_ctrl_reg_old &
+			~TTC_CLK_CNTRL_PSV_MASK;
+		ttccs->scale_clk_ctrl_reg_new |= psv << TTC_CLK_CNTRL_PSV_SHIFT;
+
+
+		/* scale down: adjust divider in post-change notification */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_DONE;
+
+		/* scale up: adjust divider now - before frequency change */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		break;
+	}
+	case POST_RATE_CHANGE:
+		/* scale up: pre-change notification did the adjustment */
+		if (ndata->new_rate > ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* scale down: adjust divider now - after frequency change */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_new,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		/* we have to undo the adjustment in case we scale up */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* restore original register value */
+		writel_relaxed(ttccs->scale_clk_ctrl_reg_old,
+			       ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+		/* fall through */
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
+					 u32 timer_width)
+{
+	struct ttc_timer_clocksource *ttccs;
+	int err;
+
+	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
+	if (!ttccs)
+		return -ENOMEM;
+
+	ttccs->ttc.clk = clk;
+
+	err = clk_prepare_enable(ttccs->ttc.clk);
+	if (err) {
+		kfree(ttccs);
+		return err;
+	}
+
+	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
+
+	ttccs->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clocksource_cb;
+	ttccs->ttc.clk_rate_change_nb.next = NULL;
+
+	err = clk_notifier_register(ttccs->ttc.clk,
+				    &ttccs->ttc.clk_rate_change_nb);
+	if (err)
+		pr_warn("Unable to register clock notifier.\n");
+
+	ttccs->ttc.base_addr = base;
+	ttccs->cs.name = "ttc_clocksource";
+	ttccs->cs.rating = 200;
+	ttccs->cs.read = __ttc_clocksource_read;
+	ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
+	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	/*
+	 * Setup the clock source counter to be an incrementing counter
+	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
+	 * it by 32 also. Let it start running now.
+	 */
+	writel_relaxed(0x0,  ttccs->ttc.base_addr + TTC_IER_OFFSET);
+	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
+		     ttccs->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+	writel_relaxed(CNT_CNTRL_RESET,
+		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
+
+	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
+	if (err) {
+		kfree(ttccs);
+		return err;
+	}
+
+	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
+	sched_clock_register(ttc_sched_clock_read, timer_width,
+			     ttccs->ttc.freq / PRESCALE);
+
+	return 0;
+}
+
+static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct ttc_timer *ttc = to_ttc_timer(nb);
+	struct ttc_timer_clockevent *ttcce = container_of(ttc,
+			struct ttc_timer_clockevent, ttc);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+		/* update cached frequency */
+		ttc->freq = ndata->new_rate;
+
+		clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
+
+		/* fall through */
+	case PRE_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int __init ttc_setup_clockevent(struct clk *clk,
+				       void __iomem *base, u32 irq)
+{
+	struct ttc_timer_clockevent *ttcce;
+	int err;
+
+	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
+	if (!ttcce)
+		return -ENOMEM;
+
+	ttcce->ttc.clk = clk;
+
+	err = clk_prepare_enable(ttcce->ttc.clk);
+	if (err) {
+		kfree(ttcce);
+		return err;
+	}
+
+	ttcce->ttc.clk_rate_change_nb.notifier_call =
+		ttc_rate_change_clockevent_cb;
+	ttcce->ttc.clk_rate_change_nb.next = NULL;
+
+	err = clk_notifier_register(ttcce->ttc.clk,
+				    &ttcce->ttc.clk_rate_change_nb);
+	if (err) {
+		pr_warn("Unable to register clock notifier.\n");
+		return err;
+	}
+
+	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
+
+	ttcce->ttc.base_addr = base;
+	ttcce->ce.name = "ttc_clockevent";
+	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	ttcce->ce.set_next_event = ttc_set_next_event;
+	ttcce->ce.set_state_shutdown = ttc_shutdown;
+	ttcce->ce.set_state_periodic = ttc_set_periodic;
+	ttcce->ce.set_state_oneshot = ttc_shutdown;
+	ttcce->ce.tick_resume = ttc_resume;
+	ttcce->ce.rating = 200;
+	ttcce->ce.irq = irq;
+	ttcce->ce.cpumask = cpu_possible_mask;
+
+	/*
+	 * Setup the clock event timer to be an interval timer which
+	 * is prescaled by 32 using the interval interrupt. Leave it
+	 * disabled for now.
+	 */
+	writel_relaxed(0x23, ttcce->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
+	writel_relaxed(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
+		     ttcce->ttc.base_addr + TTC_CLK_CNTRL_OFFSET);
+	writel_relaxed(0x1,  ttcce->ttc.base_addr + TTC_IER_OFFSET);
+
+	err = request_irq(irq, ttc_clock_event_interrupt,
+			  IRQF_TIMER, ttcce->ce.name, ttcce);
+	if (err) {
+		kfree(ttcce);
+		return err;
+	}
+
+	clockevents_config_and_register(&ttcce->ce,
+			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
+
+	return 0;
+}
+
+/**
+ * ttc_timer_init - Initialize the timer
+ *
+ * Initializes the timer hardware and register the clock source and clock event
+ * timers with Linux kernal timer framework
+ */
+static int __init ttc_timer_init(struct device_node *timer)
+{
+	unsigned int irq;
+	void __iomem *timer_baseaddr;
+	struct clk *clk_cs, *clk_ce;
+	static int initialized;
+	int clksel, ret;
+	u32 timer_width = 16;
+
+	if (initialized)
+		return 0;
+
+	initialized = 1;
+
+	/*
+	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
+	 * and use it. Note that the event timer uses the interrupt and it's the
+	 * 2nd TTC hence the irq_of_parse_and_map(,1)
+	 */
+	timer_baseaddr = of_iomap(timer, 0);
+	if (!timer_baseaddr) {
+		pr_err("ERROR: invalid timer base address\n");
+		return -ENXIO;
+	}
+
+	irq = irq_of_parse_and_map(timer, 1);
+	if (irq <= 0) {
+		pr_err("ERROR: invalid interrupt number\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(timer, "timer-width", &timer_width);
+
+	clksel = readl_relaxed(timer_baseaddr + TTC_CLK_CNTRL_OFFSET);
+	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
+	clk_cs = of_clk_get(timer, clksel);
+	if (IS_ERR(clk_cs)) {
+		pr_err("ERROR: timer input clock not found\n");
+		return PTR_ERR(clk_cs);
+	}
+
+	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
+	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
+	clk_ce = of_clk_get(timer, clksel);
+	if (IS_ERR(clk_ce)) {
+		pr_err("ERROR: timer input clock not found\n");
+		return PTR_ERR(clk_ce);
+	}
+
+	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
+	if (ret)
+		return ret;
+
+	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
+	if (ret)
+		return ret;
+
+	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-efm32.c
new file mode 100644
index 0000000..257e810
--- /dev/null
+++ b/drivers/clocksource/timer-efm32.c
@@ -0,0 +1,287 @@
+/*
+ * Copyright (C) 2013 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+
+#define TIMERn_CTRL			0x00
+#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
+#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
+#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
+#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
+#define TIMERn_CTRL_OSMEN			0x00000010
+#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
+#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
+#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
+
+#define TIMERn_CMD			0x04
+#define TIMERn_CMD_START			0x00000001
+#define TIMERn_CMD_STOP				0x00000002
+
+#define TIMERn_IEN			0x0c
+#define TIMERn_IF			0x10
+#define TIMERn_IFS			0x14
+#define TIMERn_IFC			0x18
+#define TIMERn_IRQ_UF				0x00000002
+
+#define TIMERn_TOP			0x1c
+#define TIMERn_CNT			0x24
+
+struct efm32_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	unsigned periodic_top;
+};
+
+static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	return 0;
+}
+
+static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_OSMEN |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	return 0;
+}
+
+static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+	return 0;
+}
+
+static int efm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(evt, ddata->base + TIMERn_CNT);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+
+	return 0;
+}
+
+static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
+{
+	struct efm32_clock_event_ddata *ddata = dev_id;
+
+	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct efm32_clock_event_ddata clock_event_ddata = {
+	.evtdev = {
+		.name = "efm32 clockevent",
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_state_shutdown = efm32_clock_event_shutdown,
+		.set_state_periodic = efm32_clock_event_set_periodic,
+		.set_state_oneshot = efm32_clock_event_set_oneshot,
+		.set_next_event = efm32_clock_event_set_next_event,
+		.rating = 200,
+	},
+};
+
+static struct irqaction efm32_clock_event_irq = {
+	.name = "efm32 clockevent",
+	.flags = IRQF_TIMER,
+	.handler = efm32_clock_event_handler,
+	.dev_id = &clock_event_ddata,
+};
+
+static int __init efm32_clocksource_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("failed to get clock for clocksource (%d)\n", ret);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clocksource (%d)\n",
+		       ret);
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		ret = -EADDRNOTAVAIL;
+		pr_err("failed to map registers for clocksource\n");
+		goto err_iomap;
+	}
+
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
+
+	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
+				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
+				    clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto err_clocksource_init;
+	}
+
+	return 0;
+
+err_clocksource_init:
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+static int __init efm32_clockevent_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int irq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("failed to get clock for clockevent (%d)\n", ret);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clockevent (%d)\n",
+		       ret);
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		ret = -EADDRNOTAVAIL;
+		pr_err("failed to map registers for clockevent\n");
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		ret = -ENOENT;
+		pr_err("failed to get irq for clockevent\n");
+		goto err_get_irq;
+	}
+
+	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
+
+	clock_event_ddata.base = base;
+	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
+
+	clockevents_config_and_register(&clock_event_ddata.evtdev,
+					DIV_ROUND_CLOSEST(rate, 1024),
+					0xf, 0xffff);
+
+	ret = setup_irq(irq, &efm32_clock_event_irq);
+	if (ret) {
+		pr_err("Failed setup irq\n");
+		goto err_setup_irq;
+	}
+
+	return 0;
+
+err_setup_irq:
+err_get_irq:
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+/*
+ * This function asserts that we have exactly one clocksource and one
+ * clock_event_device in the end.
+ */
+static int __init efm32_timer_init(struct device_node *np)
+{
+	static int has_clocksource, has_clockevent;
+	int ret = 0;
+
+	if (!has_clocksource) {
+		ret = efm32_clocksource_init(np);
+		if (!ret) {
+			has_clocksource = 1;
+			return 0;
+		}
+	}
+
+	if (!has_clockevent) {
+		ret = efm32_clockevent_init(np);
+		if (!ret) {
+			has_clockevent = 1;
+			return 0;
+		}
+	}
+
+	return ret;
+}
+TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
+TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
new file mode 100644
index 0000000..846d18d
--- /dev/null
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -0,0 +1,376 @@
+/*
+ * Freescale FlexTimer Module (FTM) timer driver.
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define FTM_SC		0x00
+#define FTM_SC_CLK_SHIFT	3
+#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
+#define FTM_SC_PS_MASK	0x7
+#define FTM_SC_TOIE	BIT(6)
+#define FTM_SC_TOF	BIT(7)
+
+#define FTM_CNT		0x04
+#define FTM_MOD		0x08
+#define FTM_CNTIN	0x4C
+
+#define FTM_PS_MAX	7
+
+struct ftm_clock_device {
+	void __iomem *clksrc_base;
+	void __iomem *clkevt_base;
+	unsigned long periodic_cyc;
+	unsigned long ps;
+	bool big_endian;
+};
+
+static struct ftm_clock_device *priv;
+
+static inline u32 ftm_readl(void __iomem *addr)
+{
+	if (priv->big_endian)
+		return ioread32be(addr);
+	else
+		return ioread32(addr);
+}
+
+static inline void ftm_writel(u32 val, void __iomem *addr)
+{
+	if (priv->big_endian)
+		iowrite32be(val, addr);
+	else
+		iowrite32(val, addr);
+}
+
+static inline void ftm_counter_enable(void __iomem *base)
+{
+	u32 val;
+
+	/* select and enable counter clock source */
+	val = ftm_readl(base + FTM_SC);
+	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+	val |= priv->ps | FTM_SC_CLK(1);
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_counter_disable(void __iomem *base)
+{
+	u32 val;
+
+	/* disable counter clock source */
+	val = ftm_readl(base + FTM_SC);
+	val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_acknowledge(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val &= ~FTM_SC_TOF;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_enable(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val |= FTM_SC_TOIE;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_irq_disable(void __iomem *base)
+{
+	u32 val;
+
+	val = ftm_readl(base + FTM_SC);
+	val &= ~FTM_SC_TOIE;
+	ftm_writel(val, base + FTM_SC);
+}
+
+static inline void ftm_reset_counter(void __iomem *base)
+{
+	/*
+	 * The CNT register contains the FTM counter value.
+	 * Reset clears the CNT register. Writing any value to COUNT
+	 * updates the counter with its initial value, CNTIN.
+	 */
+	ftm_writel(0x00, base + FTM_CNT);
+}
+
+static u64 notrace ftm_read_sched_clock(void)
+{
+	return ftm_readl(priv->clksrc_base + FTM_CNT);
+}
+
+static int ftm_set_next_event(unsigned long delta,
+				struct clock_event_device *unused)
+{
+	/*
+	 * The CNNIN and MOD are all double buffer registers, writing
+	 * to the MOD register latches the value into a buffer. The MOD
+	 * register is updated with the value of its write buffer with
+	 * the following scenario:
+	 * a, the counter source clock is diabled.
+	 */
+	ftm_counter_disable(priv->clkevt_base);
+
+	/* Force the value of CNTIN to be loaded into the FTM counter */
+	ftm_reset_counter(priv->clkevt_base);
+
+	/*
+	 * The counter increments until the value of MOD is reached,
+	 * at which point the counter is reloaded with the value of CNTIN.
+	 * The TOF (the overflow flag) bit is set when the FTM counter
+	 * changes from MOD to CNTIN. So we should using the delta - 1.
+	 */
+	ftm_writel(delta - 1, priv->clkevt_base + FTM_MOD);
+
+	ftm_counter_enable(priv->clkevt_base);
+
+	ftm_irq_enable(priv->clkevt_base);
+
+	return 0;
+}
+
+static int ftm_set_oneshot(struct clock_event_device *evt)
+{
+	ftm_counter_disable(priv->clkevt_base);
+	return 0;
+}
+
+static int ftm_set_periodic(struct clock_event_device *evt)
+{
+	ftm_set_next_event(priv->periodic_cyc, evt);
+	return 0;
+}
+
+static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	ftm_irq_acknowledge(priv->clkevt_base);
+
+	if (likely(clockevent_state_oneshot(evt))) {
+		ftm_irq_disable(priv->clkevt_base);
+		ftm_counter_disable(priv->clkevt_base);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device ftm_clockevent = {
+	.name			= "Freescale ftm timer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_periodic	= ftm_set_periodic,
+	.set_state_oneshot	= ftm_set_oneshot,
+	.set_next_event		= ftm_set_next_event,
+	.rating			= 300,
+};
+
+static struct irqaction ftm_timer_irq = {
+	.name		= "Freescale ftm timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= ftm_evt_interrupt,
+	.dev_id		= &ftm_clockevent,
+};
+
+static int __init ftm_clockevent_init(unsigned long freq, int irq)
+{
+	int err;
+
+	ftm_writel(0x00, priv->clkevt_base + FTM_CNTIN);
+	ftm_writel(~0u, priv->clkevt_base + FTM_MOD);
+
+	ftm_reset_counter(priv->clkevt_base);
+
+	err = setup_irq(irq, &ftm_timer_irq);
+	if (err) {
+		pr_err("ftm: setup irq failed: %d\n", err);
+		return err;
+	}
+
+	ftm_clockevent.cpumask = cpumask_of(0);
+	ftm_clockevent.irq = irq;
+
+	clockevents_config_and_register(&ftm_clockevent,
+					freq / (1 << priv->ps),
+					1, 0xffff);
+
+	ftm_counter_enable(priv->clkevt_base);
+
+	return 0;
+}
+
+static int __init ftm_clocksource_init(unsigned long freq)
+{
+	int err;
+
+	ftm_writel(0x00, priv->clksrc_base + FTM_CNTIN);
+	ftm_writel(~0u, priv->clksrc_base + FTM_MOD);
+
+	ftm_reset_counter(priv->clksrc_base);
+
+	sched_clock_register(ftm_read_sched_clock, 16, freq / (1 << priv->ps));
+	err = clocksource_mmio_init(priv->clksrc_base + FTM_CNT, "fsl-ftm",
+				    freq / (1 << priv->ps), 300, 16,
+				    clocksource_mmio_readl_up);
+	if (err) {
+		pr_err("ftm: init clock source mmio failed: %d\n", err);
+		return err;
+	}
+
+	ftm_counter_enable(priv->clksrc_base);
+
+	return 0;
+}
+
+static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
+				 char *ftm_name)
+{
+	struct clk *clk;
+	int err;
+
+	clk = of_clk_get_by_name(np, cnt_name);
+	if (IS_ERR(clk)) {
+		pr_err("ftm: Cannot get \"%s\": %ld\n", cnt_name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+	err = clk_prepare_enable(clk);
+	if (err) {
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
+			cnt_name, err);
+		return err;
+	}
+
+	clk = of_clk_get_by_name(np, ftm_name);
+	if (IS_ERR(clk)) {
+		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+	err = clk_prepare_enable(clk);
+	if (err)
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
+			ftm_name, err);
+
+	return clk_get_rate(clk);
+}
+
+static unsigned long __init ftm_clk_init(struct device_node *np)
+{
+	long freq;
+
+	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
+	if (freq <= 0)
+		return 0;
+
+	freq = __ftm_clk_init(np, "ftm-src-counter-en", "ftm-src");
+	if (freq <= 0)
+		return 0;
+
+	return freq;
+}
+
+static int __init ftm_calc_closest_round_cyc(unsigned long freq)
+{
+	priv->ps = 0;
+
+	/* The counter register is only using the lower 16 bits, and
+	 * if the 'freq' value is to big here, then the periodic_cyc
+	 * may exceed 0xFFFF.
+	 */
+	do {
+		priv->periodic_cyc = DIV_ROUND_CLOSEST(freq,
+						HZ * (1 << priv->ps++));
+	} while (priv->periodic_cyc > 0xFFFF);
+
+	if (priv->ps > FTM_PS_MAX) {
+		pr_err("ftm: the prescaler is %lu > %d\n",
+				priv->ps, FTM_PS_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init ftm_timer_init(struct device_node *np)
+{
+	unsigned long freq;
+	int ret, irq;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = -ENXIO;
+	priv->clkevt_base = of_iomap(np, 0);
+	if (!priv->clkevt_base) {
+		pr_err("ftm: unable to map event timer registers\n");
+		goto err_clkevt;
+	}
+
+	priv->clksrc_base = of_iomap(np, 1);
+	if (!priv->clksrc_base) {
+		pr_err("ftm: unable to map source timer registers\n");
+		goto err_clksrc;
+	}
+
+	ret = -EINVAL;
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
+		goto err;
+	}
+
+	priv->big_endian = of_property_read_bool(np, "big-endian");
+
+	freq = ftm_clk_init(np);
+	if (!freq)
+		goto err;
+
+	ret = ftm_calc_closest_round_cyc(freq);
+	if (ret)
+		goto err;
+
+	ret = ftm_clocksource_init(freq);
+	if (ret)
+		goto err;
+
+	ret = ftm_clockevent_init(freq, irq);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	iounmap(priv->clksrc_base);
+err_clksrc:
+	iounmap(priv->clkevt_base);
+err_clkevt:
+	kfree(priv);
+	return ret;
+}
+TIMER_OF_DECLARE(flextimer, "fsl,ftm-timer", ftm_timer_init);
diff --git a/drivers/clocksource/timer-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
new file mode 100644
index 0000000..d51a62a
--- /dev/null
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -0,0 +1,314 @@
+/*
+ * Clocksource driver for NXP LPC32xx/18xx/43xx timer
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on:
+ * time-efm32 Copyright (C) 2013 Pengutronix
+ * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#define LPC32XX_TIMER_IR		0x000
+#define  LPC32XX_TIMER_IR_MR0INT	BIT(0)
+#define LPC32XX_TIMER_TCR		0x004
+#define  LPC32XX_TIMER_TCR_CEN		BIT(0)
+#define  LPC32XX_TIMER_TCR_CRST		BIT(1)
+#define LPC32XX_TIMER_TC		0x008
+#define LPC32XX_TIMER_PR		0x00c
+#define LPC32XX_TIMER_MCR		0x014
+#define  LPC32XX_TIMER_MCR_MR0I		BIT(0)
+#define  LPC32XX_TIMER_MCR_MR0R		BIT(1)
+#define  LPC32XX_TIMER_MCR_MR0S		BIT(2)
+#define LPC32XX_TIMER_MR0		0x018
+#define LPC32XX_TIMER_CTCR		0x070
+
+struct lpc32xx_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	u32 ticks_per_jiffy;
+};
+
+/* Needed for the sched clock */
+static void __iomem *clocksource_timer_counter;
+
+static u64 notrace lpc32xx_read_sched_clock(void)
+{
+	return readl(clocksource_timer_counter);
+}
+
+static unsigned long lpc32xx_delay_timer_read(void)
+{
+	return readl(clocksource_timer_counter);
+}
+
+static struct delay_timer lpc32xx_delay_timer = {
+	.read_current_timer = lpc32xx_delay_timer_read,
+};
+
+static int lpc32xx_clkevt_next_event(unsigned long delta,
+				     struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/*
+	 * Place timer in reset and program the delta in the match
+	 * channel 0 (MR0). When the timer counter matches the value
+	 * in MR0 register the match will trigger an interrupt.
+	 * After setup the timer is released from reset and enabled.
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(delta, ddata->base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/* Disable the timer */
+	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/*
+	 * When using oneshot, we must also disable the timer
+	 * to wait for the first call to set_next_event().
+	 */
+	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+
+	/* Enable interrupt, reset on match and stop on match (MCR). */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
+		       LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
+	return 0;
+}
+
+static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/* Enable interrupt and reset on match. */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
+		       ddata->base + LPC32XX_TIMER_MCR);
+
+	/*
+	 * Place timer in reset and program the delta in the match
+	 * channel 0 (MR0).
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(ddata->ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
+{
+	struct lpc32xx_clock_event_ddata *ddata = dev_id;
+
+	/* Clear match on channel 0 */
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, ddata->base + LPC32XX_TIMER_IR);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
+	.evtdev = {
+		.name			= "lpc3220 clockevent",
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+					  CLOCK_EVT_FEAT_PERIODIC,
+		.rating			= 300,
+		.set_next_event		= lpc32xx_clkevt_next_event,
+		.set_state_shutdown	= lpc32xx_clkevt_shutdown,
+		.set_state_oneshot	= lpc32xx_clkevt_oneshot,
+		.set_state_periodic	= lpc32xx_clkevt_periodic,
+	},
+};
+
+static int __init lpc32xx_clocksource_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get_by_name(np, "timerclk");
+	if (IS_ERR(clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("clock enable failed (%d)\n", ret);
+		goto err_clk_enable;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("unable to map registers\n");
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	/*
+	 * Disable and reset timer then set it to free running timer
+	 * mode (CTCR) with no prescaler (PR) or match operations (MCR).
+	 * After setup the timer is released from reset and enabled.
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_PR);
+	writel_relaxed(0, base + LPC32XX_TIMER_MCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, base + LPC32XX_TIMER_TCR);
+
+	rate = clk_get_rate(clk);
+	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3220 timer",
+				    rate, 300, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto err_clocksource_init;
+	}
+
+	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
+	lpc32xx_delay_timer.freq = rate;
+	register_current_timer_delay(&lpc32xx_delay_timer);
+	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
+
+	return 0;
+
+err_clocksource_init:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+static int __init lpc32xx_clockevent_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret, irq;
+
+	clk = of_clk_get_by_name(np, "timerclk");
+	if (IS_ERR(clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("clock enable failed (%d)\n", ret);
+		goto err_clk_enable;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("unable to map registers\n");
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("get irq failed\n");
+		ret = -ENOENT;
+		goto err_irq;
+	}
+
+	/*
+	 * Disable timer and clear any pending interrupt (IR) on match
+	 * channel 0 (MR0). Clear the prescaler as it's not used.
+	 */
+	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_PR);
+	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
+
+	rate = clk_get_rate(clk);
+	lpc32xx_clk_event_ddata.base = base;
+	lpc32xx_clk_event_ddata.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
+	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
+					rate, 1, -1);
+
+	ret = request_irq(irq, lpc32xx_clock_event_handler,
+			  IRQF_TIMER | IRQF_IRQPOLL, "lpc3220 clockevent",
+			  &lpc32xx_clk_event_ddata);
+	if (ret) {
+		pr_err("request irq failed\n");
+		goto err_irq;
+	}
+
+	return 0;
+
+err_irq:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+/*
+ * This function asserts that we have exactly one clocksource and one
+ * clock_event_device in the end.
+ */
+static int __init lpc32xx_timer_init(struct device_node *np)
+{
+	static int has_clocksource, has_clockevent;
+	int ret = 0;
+
+	if (!has_clocksource) {
+		ret = lpc32xx_clocksource_init(np);
+		if (!ret) {
+			has_clocksource = 1;
+			return 0;
+		}
+	}
+
+	if (!has_clockevent) {
+		ret = lpc32xx_clockevent_init(np);
+		if (!ret) {
+			has_clockevent = 1;
+			return 0;
+		}
+	}
+
+	return ret;
+}
+TIMER_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
new file mode 100644
index 0000000..7d487107
--- /dev/null
+++ b/drivers/clocksource/timer-orion.c
@@ -0,0 +1,192 @@
+/*
+ * Marvell Orion SoC timer handling.
+ *
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+#include <linux/sched_clock.h>
+
+#define TIMER_CTRL		0x00
+#define  TIMER0_EN		BIT(0)
+#define  TIMER0_RELOAD_EN	BIT(1)
+#define  TIMER1_EN		BIT(2)
+#define  TIMER1_RELOAD_EN	BIT(3)
+#define TIMER0_RELOAD		0x10
+#define TIMER0_VAL		0x14
+#define TIMER1_RELOAD		0x18
+#define TIMER1_VAL		0x1c
+
+#define ORION_ONESHOT_MIN	1
+#define ORION_ONESHOT_MAX	0xfffffffe
+
+static void __iomem *timer_base;
+
+static unsigned long notrace orion_read_timer(void)
+{
+	return ~readl(timer_base + TIMER0_VAL);
+}
+
+static struct delay_timer orion_delay_timer = {
+	.read_current_timer = orion_read_timer,
+};
+
+static void orion_delay_timer_init(unsigned long rate)
+{
+	orion_delay_timer.freq = rate;
+	register_current_timer_delay(&orion_delay_timer);
+}
+
+/*
+ * Free-running clocksource handling.
+ */
+static u64 notrace orion_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL);
+}
+
+/*
+ * Clockevent handling.
+ */
+static u32 ticks_per_jiffy;
+
+static int orion_clkevt_next_event(unsigned long delta,
+				   struct clock_event_device *dev)
+{
+	/* setup and enable one-shot timer */
+	writel(delta, timer_base + TIMER1_VAL);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
+
+	return 0;
+}
+
+static int orion_clkevt_shutdown(struct clock_event_device *dev)
+{
+	/* disable timer */
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN, 0);
+	return 0;
+}
+
+static int orion_clkevt_set_periodic(struct clock_event_device *dev)
+{
+	/* setup and enable periodic timer at 1/HZ intervals */
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN,
+			 TIMER1_RELOAD_EN | TIMER1_EN);
+	return 0;
+}
+
+static struct clock_event_device orion_clkevt = {
+	.name			= "orion_event",
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.shift			= 32,
+	.rating			= 300,
+	.set_next_event		= orion_clkevt_next_event,
+	.set_state_shutdown	= orion_clkevt_shutdown,
+	.set_state_periodic	= orion_clkevt_set_periodic,
+	.set_state_oneshot	= orion_clkevt_shutdown,
+	.tick_resume		= orion_clkevt_shutdown,
+};
+
+static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
+{
+	orion_clkevt.event_handler(&orion_clkevt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction orion_clkevt_irq = {
+	.name		= "orion_event",
+	.flags		= IRQF_TIMER,
+	.handler	= orion_clkevt_irq_handler,
+};
+
+static int __init orion_timer_init(struct device_node *np)
+{
+	unsigned long rate;
+	struct clk *clk;
+	int irq, ret;
+
+	/* timer registers are shared with watchdog timer */
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("%pOFn: unable to map resource\n", np);
+		return -ENXIO;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%pOFn: unable to get clk\n", np);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to prepare clock\n");
+		return ret;
+	}
+
+	/* we are only interested in timer1 irq */
+	irq = irq_of_parse_and_map(np, 1);
+	if (irq <= 0) {
+		pr_err("%pOFn: unable to parse timer1 irq\n", np);
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(clk);
+
+	/* setup timer0 as free-running clocksource */
+	writel(~0, timer_base + TIMER0_VAL);
+	writel(~0, timer_base + TIMER0_RELOAD);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER0_RELOAD_EN | TIMER0_EN,
+		TIMER0_RELOAD_EN | TIMER0_EN);
+
+	ret = clocksource_mmio_init(timer_base + TIMER0_VAL,
+				    "orion_clocksource", rate, 300, 32,
+				    clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("Failed to initialize mmio timer\n");
+		return ret;
+	}
+
+	sched_clock_register(orion_read_sched_clock, 32, rate);
+
+	/* setup timer1 as clockevent timer */
+	ret = setup_irq(irq, &orion_clkevt_irq);
+	if (ret) {
+		pr_err("%pOFn: unable to setup irq\n", np);
+		return ret;
+	}
+
+	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
+	orion_clkevt.cpumask = cpumask_of(0);
+	orion_clkevt.irq = irq;
+	clockevents_config_and_register(&orion_clkevt, rate,
+					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
+
+
+	orion_delay_timer_init(rate);
+
+	return 0;
+}
+TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
new file mode 100644
index 0000000..ea00a5e
--- /dev/null
+++ b/drivers/clocksource/timer-owl.c
@@ -0,0 +1,173 @@
+/*
+ * Actions Semi Owl timer
+ *
+ * Copyright 2012 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2017 SUSE Linux GmbH
+ * Author: Andreas Färber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define OWL_Tx_CTL		0x0
+#define OWL_Tx_CMP		0x4
+#define OWL_Tx_VAL		0x8
+
+#define OWL_Tx_CTL_PD		BIT(0)
+#define OWL_Tx_CTL_INTEN	BIT(1)
+#define OWL_Tx_CTL_EN		BIT(2)
+
+static void __iomem *owl_timer_base;
+static void __iomem *owl_clksrc_base;
+static void __iomem *owl_clkevt_base;
+
+static inline void owl_timer_reset(void __iomem *base)
+{
+	writel(0, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(0, base + OWL_Tx_CMP);
+}
+
+static inline void owl_timer_set_enabled(void __iomem *base, bool enabled)
+{
+	u32 ctl = readl(base + OWL_Tx_CTL);
+
+	/* PD bit is cleared when set */
+	ctl &= ~OWL_Tx_CTL_PD;
+
+	if (enabled)
+		ctl |= OWL_Tx_CTL_EN;
+	else
+		ctl &= ~OWL_Tx_CTL_EN;
+
+	writel(ctl, base + OWL_Tx_CTL);
+}
+
+static u64 notrace owl_timer_sched_read(void)
+{
+	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);
+}
+
+static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
+{
+	owl_timer_set_enabled(owl_clkevt_base, false);
+
+	return 0;
+}
+
+static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
+{
+	owl_timer_reset(owl_clkevt_base);
+
+	return 0;
+}
+
+static int owl_timer_tick_resume(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int owl_timer_set_next_event(unsigned long evt,
+				    struct clock_event_device *ev)
+{
+	void __iomem *base = owl_clkevt_base;
+
+	owl_timer_set_enabled(base, false);
+	writel(OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
+	writel(0, base + OWL_Tx_VAL);
+	writel(evt, base + OWL_Tx_CMP);
+	owl_timer_set_enabled(base, true);
+
+	return 0;
+}
+
+static struct clock_event_device owl_clockevent = {
+	.name			= "owl_tick",
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_shutdown	= owl_timer_set_state_shutdown,
+	.set_state_oneshot	= owl_timer_set_state_oneshot,
+	.tick_resume		= owl_timer_tick_resume,
+	.set_next_event		= owl_timer_set_next_event,
+};
+
+static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+
+	writel(OWL_Tx_CTL_PD, owl_clkevt_base + OWL_Tx_CTL);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init owl_timer_init(struct device_node *node)
+{
+	struct clk *clk;
+	unsigned long rate;
+	int timer1_irq, ret;
+
+	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
+	if (IS_ERR(owl_timer_base)) {
+		pr_err("Can't map timer registers\n");
+		return PTR_ERR(owl_timer_base);
+	}
+
+	owl_clksrc_base = owl_timer_base + 0x08;
+	owl_clkevt_base = owl_timer_base + 0x14;
+
+	timer1_irq = of_irq_get_byname(node, "timer1");
+	if (timer1_irq <= 0) {
+		pr_err("Can't parse timer1 IRQ\n");
+		return -EINVAL;
+	}
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rate = clk_get_rate(clk);
+
+	owl_timer_reset(owl_clksrc_base);
+	owl_timer_set_enabled(owl_clksrc_base, true);
+
+	sched_clock_register(owl_timer_sched_read, 32, rate);
+	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+			      rate, 200, 32, clocksource_mmio_readl_up);
+
+	owl_timer_reset(owl_clkevt_base);
+
+	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
+			  "owl-timer", &owl_clockevent);
+	if (ret) {
+		pr_err("failed to request irq %d\n", timer1_irq);
+		return ret;
+	}
+
+	owl_clockevent.cpumask = cpumask_of(0);
+	owl_clockevent.irq = timer1_irq;
+
+	clockevents_config_and_register(&owl_clockevent, rate,
+					0xf, 0xffffffff);
+
+	return 0;
+}
+TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
new file mode 100644
index 0000000..a2dd85d
--- /dev/null
+++ b/drivers/clocksource/timer-pistachio.c
@@ -0,0 +1,218 @@
+/*
+ * Pistachio clocksource based on general-purpose timers
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+#include <linux/time.h>
+
+/* Top level reg */
+#define CR_TIMER_CTRL_CFG		0x00
+#define TIMER_ME_GLOBAL			BIT(0)
+#define CR_TIMER_REV			0x10
+
+/* Timer specific registers */
+#define TIMER_CFG			0x20
+#define TIMER_ME_LOCAL			BIT(0)
+#define TIMER_RELOAD_VALUE		0x24
+#define TIMER_CURRENT_VALUE		0x28
+#define TIMER_CURRENT_OVERFLOW_VALUE	0x2C
+#define TIMER_IRQ_STATUS		0x30
+#define TIMER_IRQ_CLEAR			0x34
+#define TIMER_IRQ_MASK			0x38
+
+#define PERIP_TIMER_CONTROL		0x90
+
+/* Timer specific configuration Values */
+#define RELOAD_VALUE			0xffffffff
+
+struct pistachio_clocksource {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct clocksource cs;
+};
+
+static struct pistachio_clocksource pcs_gpt;
+
+#define to_pistachio_clocksource(cs)	\
+	container_of(cs, struct pistachio_clocksource, cs)
+
+static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
+{
+	return readl(base + 0x20 * gpt_id + offset);
+}
+
+static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
+		u32 gpt_id)
+{
+	writel(value, base + 0x20 * gpt_id + offset);
+}
+
+static u64 notrace
+pistachio_clocksource_read_cycles(struct clocksource *cs)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 counter, overflw;
+	unsigned long flags;
+
+	/*
+	 * The counter value is only refreshed after the overflow value is read.
+	 * And they must be read in strict order, hence raw spin lock added.
+	 */
+
+	raw_spin_lock_irqsave(&pcs->lock, flags);
+	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
+	raw_spin_unlock_irqrestore(&pcs->lock, flags);
+
+	return (u64)~counter;
+}
+
+static u64 notrace pistachio_read_sched_clock(void)
+{
+	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
+}
+
+static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
+			int enable)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 val;
+
+	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
+	if (enable)
+		val |= TIMER_ME_LOCAL;
+	else
+		val &= ~TIMER_ME_LOCAL;
+
+	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
+}
+
+static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+
+	/* Disable GPT local before loading reload value */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
+	pistachio_clksrc_set_mode(cs, timeridx, true);
+}
+
+static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
+{
+	/* Disable GPT local */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+}
+
+static int pistachio_clocksource_enable(struct clocksource *cs)
+{
+	pistachio_clksrc_enable(cs, 0);
+	return 0;
+}
+
+static void pistachio_clocksource_disable(struct clocksource *cs)
+{
+	pistachio_clksrc_disable(cs, 0);
+}
+
+/* Desirable clock source for pistachio platform */
+static struct pistachio_clocksource pcs_gpt = {
+	.cs =	{
+		.name		= "gptimer",
+		.rating		= 300,
+		.enable		= pistachio_clocksource_enable,
+		.disable	= pistachio_clocksource_disable,
+		.read		= pistachio_clocksource_read_cycles,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
+				  CLOCK_SOURCE_SUSPEND_NONSTOP,
+		},
+};
+
+static int __init pistachio_clksrc_of_init(struct device_node *node)
+{
+	struct clk *sys_clk, *fast_clk;
+	struct regmap *periph_regs;
+	unsigned long rate;
+	int ret;
+
+	pcs_gpt.base = of_iomap(node, 0);
+	if (!pcs_gpt.base) {
+		pr_err("cannot iomap\n");
+		return -ENXIO;
+	}
+
+	periph_regs = syscon_regmap_lookup_by_phandle(node, "img,cr-periph");
+	if (IS_ERR(periph_regs)) {
+		pr_err("cannot get peripheral regmap (%ld)\n",
+		       PTR_ERR(periph_regs));
+		return PTR_ERR(periph_regs);
+	}
+
+	/* Switch to using the fast counter clock */
+	ret = regmap_update_bits(periph_regs, PERIP_TIMER_CONTROL,
+				 0xf, 0x0);
+	if (ret)
+		return ret;
+
+	sys_clk = of_clk_get_by_name(node, "sys");
+	if (IS_ERR(sys_clk)) {
+		pr_err("clock get failed (%ld)\n", PTR_ERR(sys_clk));
+		return PTR_ERR(sys_clk);
+	}
+
+	fast_clk = of_clk_get_by_name(node, "fast");
+	if (IS_ERR(fast_clk)) {
+		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
+		return PTR_ERR(fast_clk);
+	}
+
+	ret = clk_prepare_enable(sys_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(fast_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		clk_disable_unprepare(sys_clk);
+		return ret;
+	}
+
+	rate = clk_get_rate(fast_clk);
+
+	/* Disable irq's for clocksource usage */
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
+	gpt_writel(pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
+
+	/* Enable timer block */
+	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
+
+	raw_spin_lock_init(&pcs_gpt.lock);
+	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	return clocksource_register_hz(&pcs_gpt.cs, rate);
+}
+TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
+		       pistachio_clksrc_of_init);
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
new file mode 100644
index 0000000..89816f8
--- /dev/null
+++ b/drivers/clocksource/timer-qcom.c
@@ -0,0 +1,258 @@
+/*
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <asm/delay.h>
+
+#define TIMER_MATCH_VAL			0x0000
+#define TIMER_COUNT_VAL			0x0004
+#define TIMER_ENABLE			0x0008
+#define TIMER_ENABLE_CLR_ON_MATCH_EN	BIT(1)
+#define TIMER_ENABLE_EN			BIT(0)
+#define TIMER_CLEAR			0x000C
+#define DGT_CLK_CTL			0x10
+#define DGT_CLK_CTL_DIV_4		0x3
+#define TIMER_STS_GPT0_CLR_PEND		BIT(10)
+
+#define GPT_HZ 32768
+
+static void __iomem *event_base;
+static void __iomem *sts_base;
+
+static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	/* Stop the timer tick */
+	if (clockevent_state_oneshot(evt)) {
+		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+		ctrl &= ~TIMER_ENABLE_EN;
+		writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+	}
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static int msm_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+
+	ctrl &= ~TIMER_ENABLE_EN;
+	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+
+	writel_relaxed(ctrl, event_base + TIMER_CLEAR);
+	writel_relaxed(cycles, event_base + TIMER_MATCH_VAL);
+
+	if (sts_base)
+		while (readl_relaxed(sts_base) & TIMER_STS_GPT0_CLR_PEND)
+			cpu_relax();
+
+	writel_relaxed(ctrl | TIMER_ENABLE_EN, event_base + TIMER_ENABLE);
+	return 0;
+}
+
+static int msm_timer_shutdown(struct clock_event_device *evt)
+{
+	u32 ctrl;
+
+	ctrl = readl_relaxed(event_base + TIMER_ENABLE);
+	ctrl &= ~(TIMER_ENABLE_EN | TIMER_ENABLE_CLR_ON_MATCH_EN);
+	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+	return 0;
+}
+
+static struct clock_event_device __percpu *msm_evt;
+
+static void __iomem *source_base;
+
+static notrace u64 msm_read_timer_count(struct clocksource *cs)
+{
+	return readl_relaxed(source_base + TIMER_COUNT_VAL);
+}
+
+static struct clocksource msm_clocksource = {
+	.name	= "dg_timer",
+	.rating	= 300,
+	.read	= msm_read_timer_count,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int msm_timer_irq;
+static int msm_timer_has_ppi;
+
+static int msm_local_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
+	int err;
+
+	evt->irq = msm_timer_irq;
+	evt->name = "msm_timer";
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	evt->rating = 200;
+	evt->set_state_shutdown = msm_timer_shutdown;
+	evt->set_state_oneshot = msm_timer_shutdown;
+	evt->tick_resume = msm_timer_shutdown;
+	evt->set_next_event = msm_timer_set_next_event;
+	evt->cpumask = cpumask_of(cpu);
+
+	clockevents_config_and_register(evt, GPT_HZ, 4, 0xffffffff);
+
+	if (msm_timer_has_ppi) {
+		enable_percpu_irq(evt->irq, IRQ_TYPE_EDGE_RISING);
+	} else {
+		err = request_irq(evt->irq, msm_timer_interrupt,
+				IRQF_TIMER | IRQF_NOBALANCING |
+				IRQF_TRIGGER_RISING, "gp_timer", evt);
+		if (err)
+			pr_err("request_irq failed\n");
+	}
+
+	return 0;
+}
+
+static int msm_local_timer_dying_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
+
+	evt->set_state_shutdown(evt);
+	disable_percpu_irq(evt->irq);
+	return 0;
+}
+
+static u64 notrace msm_sched_clock_read(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
+static unsigned long msm_read_current_timer(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
+static struct delay_timer msm_delay_timer = {
+	.read_current_timer = msm_read_current_timer,
+};
+
+static int __init msm_timer_init(u32 dgt_hz, int sched_bits, int irq,
+				  bool percpu)
+{
+	struct clocksource *cs = &msm_clocksource;
+	int res = 0;
+
+	msm_timer_irq = irq;
+	msm_timer_has_ppi = percpu;
+
+	msm_evt = alloc_percpu(struct clock_event_device);
+	if (!msm_evt) {
+		pr_err("memory allocation failed for clockevents\n");
+		goto err;
+	}
+
+	if (percpu)
+		res = request_percpu_irq(irq, msm_timer_interrupt,
+					 "gp_timer", msm_evt);
+
+	if (res) {
+		pr_err("request_percpu_irq failed\n");
+	} else {
+		/* Install and invoke hotplug callbacks */
+		res = cpuhp_setup_state(CPUHP_AP_QCOM_TIMER_STARTING,
+					"clockevents/qcom/timer:starting",
+					msm_local_timer_starting_cpu,
+					msm_local_timer_dying_cpu);
+		if (res) {
+			free_percpu_irq(irq, msm_evt);
+			goto err;
+		}
+	}
+
+err:
+	writel_relaxed(TIMER_ENABLE_EN, source_base + TIMER_ENABLE);
+	res = clocksource_register_hz(cs, dgt_hz);
+	if (res)
+		pr_err("clocksource_register failed\n");
+	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
+	msm_delay_timer.freq = dgt_hz;
+	register_current_timer_delay(&msm_delay_timer);
+
+	return res;
+}
+
+static int __init msm_dt_timer_init(struct device_node *np)
+{
+	u32 freq;
+	int irq, ret;
+	struct resource res;
+	u32 percpu_offset;
+	void __iomem *base;
+	void __iomem *cpu0_base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("Failed to map event base\n");
+		return -ENXIO;
+	}
+
+	/* We use GPT0 for the clockevent */
+	irq = irq_of_parse_and_map(np, 1);
+	if (irq <= 0) {
+		pr_err("Can't get irq\n");
+		return -EINVAL;
+	}
+
+	/* We use CPU0's DGT for the clocksource */
+	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
+		percpu_offset = 0;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		pr_err("Failed to parse DGT resource\n");
+		return ret;
+	}
+
+	cpu0_base = ioremap(res.start + percpu_offset, resource_size(&res));
+	if (!cpu0_base) {
+		pr_err("Failed to map source base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		pr_err("Unknown frequency\n");
+		return -EINVAL;
+	}
+
+	event_base = base + 0x4;
+	sts_base = base + 0x88;
+	source_base = cpu0_base + 0x24;
+	freq /= 4;
+	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
+
+	return msm_timer_init(freq, 32, irq, !!percpu_offset);
+}
+TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
+TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/clocksource/timer-versatile.c b/drivers/clocksource/timer-versatile.c
new file mode 100644
index 0000000..39725d3
--- /dev/null
+++ b/drivers/clocksource/timer-versatile.c
@@ -0,0 +1,44 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2014 ARM Limited
+ */
+
+#include <linux/clocksource.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+
+#define SYS_24MHZ 0x05c
+
+static void __iomem *versatile_sys_24mhz;
+
+static u64 notrace versatile_sys_24mhz_read(void)
+{
+	return readl(versatile_sys_24mhz);
+}
+
+static int __init versatile_sched_clock_init(struct device_node *node)
+{
+	void __iomem *base = of_iomap(node, 0);
+
+	if (!base)
+		return -ENXIO;
+
+	versatile_sys_24mhz = base + SYS_24MHZ;
+
+	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
+
+	return 0;
+}
+TIMER_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
+		       versatile_sched_clock_init);
+TIMER_OF_DECLARE(versatile, "arm,versatile-sysreg",
+		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
new file mode 100644
index 0000000..0f92089
--- /dev/null
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+/*
+ * Each pit takes 0x10 Bytes register space
+ */
+#define PITMCR		0x00
+#define PIT0_OFFSET	0x100
+#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
+#define PITLDVAL	0x00
+#define PITCVAL		0x04
+#define PITTCTRL	0x08
+#define PITTFLG		0x0c
+
+#define PITMCR_MDIS	(0x1 << 1)
+
+#define PITTCTRL_TEN	(0x1 << 0)
+#define PITTCTRL_TIE	(0x1 << 1)
+#define PITCTRL_CHN	(0x1 << 2)
+
+#define PITTFLG_TIF	0x1
+
+static void __iomem *clksrc_base;
+static void __iomem *clkevt_base;
+static unsigned long cycle_per_jiffy;
+
+static inline void pit_timer_enable(void)
+{
+	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_timer_disable(void)
+{
+	__raw_writel(0, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_acknowledge(void)
+{
+	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+}
+
+static u64 notrace pit_read_sched_clock(void)
+{
+	return ~__raw_readl(clksrc_base + PITCVAL);
+}
+
+static int __init pit_clocksource_init(unsigned long rate)
+{
+	/* set the max load value and start the clock source counter */
+	__raw_writel(0, clksrc_base + PITTCTRL);
+	__raw_writel(~0UL, clksrc_base + PITLDVAL);
+	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+
+	sched_clock_register(pit_read_sched_clock, 32, rate);
+	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
+			300, 32, clocksource_mmio_readl_down);
+}
+
+static int pit_set_next_event(unsigned long delta,
+				struct clock_event_device *unused)
+{
+	/*
+	 * set a new value to PITLDVAL register will not restart the timer,
+	 * to abort the current cycle and start a timer period with the new
+	 * value, the timer must be disabled and enabled again.
+	 * and the PITLAVAL should be set to delta minus one according to pit
+	 * hardware requirement.
+	 */
+	pit_timer_disable();
+	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
+	pit_timer_enable();
+
+	return 0;
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	pit_timer_disable();
+	return 0;
+}
+
+static int pit_set_periodic(struct clock_event_device *evt)
+{
+	pit_set_next_event(cycle_per_jiffy, evt);
+	return 0;
+}
+
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	pit_irq_acknowledge();
+
+	/*
+	 * pit hardware doesn't support oneshot, it will generate an interrupt
+	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
+	 * and start the counter again. So software need to disable the timer
+	 * to stop the counter loop in ONESHOT mode.
+	 */
+	if (likely(clockevent_state_oneshot(evt)))
+		pit_timer_disable();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device clockevent_pit = {
+	.name		= "VF pit timer",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown = pit_shutdown,
+	.set_state_periodic = pit_set_periodic,
+	.set_next_event	= pit_set_next_event,
+	.rating		= 300,
+};
+
+static struct irqaction pit_timer_irq = {
+	.name		= "VF pit timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pit_timer_interrupt,
+	.dev_id		= &clockevent_pit,
+};
+
+static int __init pit_clockevent_init(unsigned long rate, int irq)
+{
+	__raw_writel(0, clkevt_base + PITTCTRL);
+	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+
+	BUG_ON(setup_irq(irq, &pit_timer_irq));
+
+	clockevent_pit.cpumask = cpumask_of(0);
+	clockevent_pit.irq = irq;
+	/*
+	 * The value for the LDVAL register trigger is calculated as:
+	 * LDVAL trigger = (period / clock period) - 1
+	 * The pit is a 32-bit down count timer, when the conter value
+	 * reaches 0, it will generate an interrupt, thus the minimal
+	 * LDVAL trigger value is 1. And then the min_delta is
+	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
+	 */
+	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
+
+	return 0;
+}
+
+static int __init pit_timer_init(struct device_node *np)
+{
+	struct clk *pit_clk;
+	void __iomem *timer_base;
+	unsigned long clk_rate;
+	int irq, ret;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base) {
+		pr_err("Failed to iomap\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
+	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
+	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
+	 */
+	clksrc_base = timer_base + PITn_OFFSET(2);
+	clkevt_base = timer_base + PITn_OFFSET(3);
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0)
+		return -EINVAL;
+
+	pit_clk = of_clk_get(np, 0);
+	if (IS_ERR(pit_clk))
+		return PTR_ERR(pit_clk);
+
+	ret = clk_prepare_enable(pit_clk);
+	if (ret)
+		return ret;
+
+	clk_rate = clk_get_rate(pit_clk);
+	cycle_per_jiffy = clk_rate / (HZ);
+
+	/* enable the pit module */
+	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
+
+	ret = pit_clocksource_init(clk_rate);
+	if (ret)
+		return ret;
+
+	return pit_clockevent_init(clk_rate, irq);
+}
+TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
new file mode 100644
index 0000000..e0f7489
--- /dev/null
+++ b/drivers/clocksource/timer-vt8500.c
@@ -0,0 +1,168 @@
+/*
+ *  arch/arm/mach-vt8500/timer.c
+ *
+ *  Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This file is copied and modified from the original timer.c provided by
+ * Alexey Charkov. Minor changes have been made for Device Tree Support.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define VT8500_TIMER_OFFSET	0x0100
+#define VT8500_TIMER_HZ		3000000
+#define TIMER_MATCH_VAL		0x0000
+#define TIMER_COUNT_VAL		0x0010
+#define TIMER_STATUS_VAL	0x0014
+#define TIMER_IER_VAL		0x001c		/* interrupt enable */
+#define TIMER_CTRL_VAL		0x0020
+#define TIMER_AS_VAL		0x0024		/* access status */
+#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
+#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
+#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
+
+#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
+
+#define MIN_OSCR_DELTA		16
+
+static void __iomem *regbase;
+
+static u64 vt8500_timer_read(struct clocksource *cs)
+{
+	int loops = msecs_to_loops(10);
+	writel(3, regbase + TIMER_CTRL_VAL);
+	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
+						&& --loops)
+		cpu_relax();
+	return readl(regbase + TIMER_COUNT_VAL);
+}
+
+static struct clocksource clocksource = {
+	.name           = "vt8500_timer",
+	.rating         = 200,
+	.read           = vt8500_timer_read,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int vt8500_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	int loops = msecs_to_loops(10);
+	u64 alarm = clocksource.read(&clocksource) + cycles;
+	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
+						&& --loops)
+		cpu_relax();
+	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
+
+	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
+		return -ETIME;
+
+	writel(1, regbase + TIMER_IER_VAL);
+
+	return 0;
+}
+
+static int vt8500_shutdown(struct clock_event_device *evt)
+{
+	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
+	writel(0, regbase + TIMER_IER_VAL);
+	return 0;
+}
+
+static struct clock_event_device clockevent = {
+	.name			= "vt8500_timer",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= vt8500_timer_set_next_event,
+	.set_state_shutdown	= vt8500_shutdown,
+	.set_state_oneshot	= vt8500_shutdown,
+};
+
+static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq = {
+	.name    = "vt8500_timer",
+	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
+	.handler = vt8500_timer_interrupt,
+	.dev_id  = &clockevent,
+};
+
+static int __init vt8500_timer_init(struct device_node *np)
+{
+	int timer_irq, ret;
+
+	regbase = of_iomap(np, 0);
+	if (!regbase) {
+		pr_err("%s: Missing iobase description in Device Tree\n",
+								__func__);
+		return -ENXIO;
+	}
+
+	timer_irq = irq_of_parse_and_map(np, 0);
+	if (!timer_irq) {
+		pr_err("%s: Missing irq description in Device Tree\n",
+								__func__);
+		return -EINVAL;
+	}
+
+	writel(1, regbase + TIMER_CTRL_VAL);
+	writel(0xf, regbase + TIMER_STATUS_VAL);
+	writel(~0, regbase + TIMER_MATCH_VAL);
+
+	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
+	if (ret) {
+		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
+		       __func__, clocksource.name);
+		return ret;
+	}
+
+	clockevent.cpumask = cpumask_of(0);
+
+	ret = setup_irq(timer_irq, &irq);
+	if (ret) {
+		pr_err("%s: setup_irq failed for %s\n", __func__,
+							clockevent.name);
+		return ret;
+	}
+
+	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
+					MIN_OSCR_DELTA * 2, 0xf0000000);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/drivers/clocksource/timer-zevio.c b/drivers/clocksource/timer-zevio.c
new file mode 100644
index 0000000..6127e80
--- /dev/null
+++ b/drivers/clocksource/timer-zevio.c
@@ -0,0 +1,218 @@
+/*
+ *  linux/drivers/clocksource/zevio-timer.c
+ *
+ *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#define IO_CURRENT_VAL	0x00
+#define IO_DIVIDER	0x04
+#define IO_CONTROL	0x08
+
+#define IO_TIMER1	0x00
+#define IO_TIMER2	0x0C
+
+#define IO_MATCH_BEGIN	0x18
+#define IO_MATCH(x)	(IO_MATCH_BEGIN + ((x) << 2))
+
+#define IO_INTR_STS	0x00
+#define IO_INTR_ACK	0x00
+#define IO_INTR_MSK	0x04
+
+#define CNTL_STOP_TIMER	(1 << 4)
+#define CNTL_RUN_TIMER	(0 << 4)
+
+#define CNTL_INC	(1 << 3)
+#define CNTL_DEC	(0 << 3)
+
+#define CNTL_TOZERO	0
+#define CNTL_MATCH(x)	((x) + 1)
+#define CNTL_FOREVER	7
+
+/* There are 6 match registers but we only use one. */
+#define TIMER_MATCH	0
+
+#define TIMER_INTR_MSK	(1 << (TIMER_MATCH))
+#define TIMER_INTR_ALL	0x3F
+
+struct zevio_timer {
+	void __iomem *base;
+	void __iomem *timer1, *timer2;
+	void __iomem *interrupt_regs;
+
+	struct clk *clk;
+	struct clock_event_device clkevt;
+	struct irqaction clkevt_irq;
+
+	char clocksource_name[64];
+	char clockevent_name[64];
+};
+
+static int zevio_timer_set_event(unsigned long delta,
+				 struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	writel(delta, timer->timer1 + IO_CURRENT_VAL);
+	writel(CNTL_RUN_TIMER | CNTL_DEC | CNTL_MATCH(TIMER_MATCH),
+			timer->timer1 + IO_CONTROL);
+
+	return 0;
+}
+
+static int zevio_timer_shutdown(struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	/* Disable timer interrupts */
+	writel(0, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	/* Stop timer */
+	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+	return 0;
+}
+
+static int zevio_timer_set_oneshot(struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	/* Enable timer interrupts */
+	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	return 0;
+}
+
+static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
+{
+	struct zevio_timer *timer = dev_id;
+	u32 intr;
+
+	intr = readl(timer->interrupt_regs + IO_INTR_ACK);
+	if (!(intr & TIMER_INTR_MSK))
+		return IRQ_NONE;
+
+	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_ACK);
+	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+
+	if (timer->clkevt.event_handler)
+		timer->clkevt.event_handler(&timer->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init zevio_timer_add(struct device_node *node)
+{
+	struct zevio_timer *timer;
+	struct resource res;
+	int irqnr, ret;
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	timer->base = of_iomap(node, 0);
+	if (!timer->base) {
+		ret = -EINVAL;
+		goto error_free;
+	}
+	timer->timer1 = timer->base + IO_TIMER1;
+	timer->timer2 = timer->base + IO_TIMER2;
+
+	timer->clk = of_clk_get(node, 0);
+	if (IS_ERR(timer->clk)) {
+		ret = PTR_ERR(timer->clk);
+		pr_err("Timer clock not found! (error %d)\n", ret);
+		goto error_unmap;
+	}
+
+	timer->interrupt_regs = of_iomap(node, 1);
+	irqnr = irq_of_parse_and_map(node, 0);
+
+	of_address_to_resource(node, 0, &res);
+	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
+			"%llx.%pOFn_clocksource",
+			(unsigned long long)res.start, node);
+
+	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
+			"%llx.%pOFn_clockevent",
+			(unsigned long long)res.start, node);
+
+	if (timer->interrupt_regs && irqnr) {
+		timer->clkevt.name		= timer->clockevent_name;
+		timer->clkevt.set_next_event	= zevio_timer_set_event;
+		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
+		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
+		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
+		timer->clkevt.rating		= 200;
+		timer->clkevt.cpumask		= cpu_possible_mask;
+		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
+		timer->clkevt.irq		= irqnr;
+
+		writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+		writel(0, timer->timer1 + IO_DIVIDER);
+
+		/* Start with timer interrupts disabled */
+		writel(0, timer->interrupt_regs + IO_INTR_MSK);
+		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+
+		/* Interrupt to occur when timer value matches 0 */
+		writel(0, timer->base + IO_MATCH(TIMER_MATCH));
+
+		timer->clkevt_irq.name		= timer->clockevent_name;
+		timer->clkevt_irq.handler	= zevio_timer_interrupt;
+		timer->clkevt_irq.dev_id	= timer;
+		timer->clkevt_irq.flags		= IRQF_TIMER | IRQF_IRQPOLL;
+
+		setup_irq(irqnr, &timer->clkevt_irq);
+
+		clockevents_config_and_register(&timer->clkevt,
+				clk_get_rate(timer->clk), 0x0001, 0xffff);
+		pr_info("Added %s as clockevent\n", timer->clockevent_name);
+	}
+
+	writel(CNTL_STOP_TIMER, timer->timer2 + IO_CONTROL);
+	writel(0, timer->timer2 + IO_CURRENT_VAL);
+	writel(0, timer->timer2 + IO_DIVIDER);
+	writel(CNTL_RUN_TIMER | CNTL_FOREVER | CNTL_INC,
+			timer->timer2 + IO_CONTROL);
+
+	clocksource_mmio_init(timer->timer2 + IO_CURRENT_VAL,
+			timer->clocksource_name,
+			clk_get_rate(timer->clk),
+			200, 16,
+			clocksource_mmio_readw_up);
+
+	pr_info("Added %s as clocksource\n", timer->clocksource_name);
+
+	return 0;
+error_unmap:
+	iounmap(timer->base);
+error_free:
+	kfree(timer);
+	return ret;
+}
+
+static int __init zevio_timer_init(struct device_node *node)
+{
+	return zevio_timer_add(node);
+}
+
+TIMER_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
deleted file mode 100644
index 39725d3..0000000
--- a/drivers/clocksource/versatile.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2014 ARM Limited
- */
-
-#include <linux/clocksource.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/sched_clock.h>
-
-#define SYS_24MHZ 0x05c
-
-static void __iomem *versatile_sys_24mhz;
-
-static u64 notrace versatile_sys_24mhz_read(void)
-{
-	return readl(versatile_sys_24mhz);
-}
-
-static int __init versatile_sched_clock_init(struct device_node *node)
-{
-	void __iomem *base = of_iomap(node, 0);
-
-	if (!base)
-		return -ENXIO;
-
-	versatile_sys_24mhz = base + SYS_24MHZ;
-
-	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
-
-	return 0;
-}
-TIMER_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
-		       versatile_sched_clock_init);
-TIMER_OF_DECLARE(versatile, "arm,versatile-sysreg",
-		       versatile_sched_clock_init);
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
deleted file mode 100644
index 0f92089..0000000
--- a/drivers/clocksource/vf_pit_timer.c
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- * Copyright 2012-2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- */
-
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-/*
- * Each pit takes 0x10 Bytes register space
- */
-#define PITMCR		0x00
-#define PIT0_OFFSET	0x100
-#define PITn_OFFSET(n)	(PIT0_OFFSET + 0x10 * (n))
-#define PITLDVAL	0x00
-#define PITCVAL		0x04
-#define PITTCTRL	0x08
-#define PITTFLG		0x0c
-
-#define PITMCR_MDIS	(0x1 << 1)
-
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
-
-#define PITTFLG_TIF	0x1
-
-static void __iomem *clksrc_base;
-static void __iomem *clkevt_base;
-static unsigned long cycle_per_jiffy;
-
-static inline void pit_timer_enable(void)
-{
-	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_timer_disable(void)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-}
-
-static inline void pit_irq_acknowledge(void)
-{
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-}
-
-static u64 notrace pit_read_sched_clock(void)
-{
-	return ~__raw_readl(clksrc_base + PITCVAL);
-}
-
-static int __init pit_clocksource_init(unsigned long rate)
-{
-	/* set the max load value and start the clock source counter */
-	__raw_writel(0, clksrc_base + PITTCTRL);
-	__raw_writel(~0UL, clksrc_base + PITLDVAL);
-	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
-
-	sched_clock_register(pit_read_sched_clock, 32, rate);
-	return clocksource_mmio_init(clksrc_base + PITCVAL, "vf-pit", rate,
-			300, 32, clocksource_mmio_readl_down);
-}
-
-static int pit_set_next_event(unsigned long delta,
-				struct clock_event_device *unused)
-{
-	/*
-	 * set a new value to PITLDVAL register will not restart the timer,
-	 * to abort the current cycle and start a timer period with the new
-	 * value, the timer must be disabled and enabled again.
-	 * and the PITLAVAL should be set to delta minus one according to pit
-	 * hardware requirement.
-	 */
-	pit_timer_disable();
-	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
-	pit_timer_enable();
-
-	return 0;
-}
-
-static int pit_shutdown(struct clock_event_device *evt)
-{
-	pit_timer_disable();
-	return 0;
-}
-
-static int pit_set_periodic(struct clock_event_device *evt)
-{
-	pit_set_next_event(cycle_per_jiffy, evt);
-	return 0;
-}
-
-static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	pit_irq_acknowledge();
-
-	/*
-	 * pit hardware doesn't support oneshot, it will generate an interrupt
-	 * and reload the counter value from PITLDVAL when PITCVAL reach zero,
-	 * and start the counter again. So software need to disable the timer
-	 * to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(evt)))
-		pit_timer_disable();
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct clock_event_device clockevent_pit = {
-	.name		= "VF pit timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = pit_shutdown,
-	.set_state_periodic = pit_set_periodic,
-	.set_next_event	= pit_set_next_event,
-	.rating		= 300,
-};
-
-static struct irqaction pit_timer_irq = {
-	.name		= "VF pit timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= pit_timer_interrupt,
-	.dev_id		= &clockevent_pit,
-};
-
-static int __init pit_clockevent_init(unsigned long rate, int irq)
-{
-	__raw_writel(0, clkevt_base + PITTCTRL);
-	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
-
-	BUG_ON(setup_irq(irq, &pit_timer_irq));
-
-	clockevent_pit.cpumask = cpumask_of(0);
-	clockevent_pit.irq = irq;
-	/*
-	 * The value for the LDVAL register trigger is calculated as:
-	 * LDVAL trigger = (period / clock period) - 1
-	 * The pit is a 32-bit down count timer, when the conter value
-	 * reaches 0, it will generate an interrupt, thus the minimal
-	 * LDVAL trigger value is 1. And then the min_delta is
-	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
-	 */
-	clockevents_config_and_register(&clockevent_pit, rate, 2, 0xffffffff);
-
-	return 0;
-}
-
-static int __init pit_timer_init(struct device_node *np)
-{
-	struct clk *pit_clk;
-	void __iomem *timer_base;
-	unsigned long clk_rate;
-	int irq, ret;
-
-	timer_base = of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("Failed to iomap\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
-	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
-	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
-	 */
-	clksrc_base = timer_base + PITn_OFFSET(2);
-	clkevt_base = timer_base + PITn_OFFSET(3);
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0)
-		return -EINVAL;
-
-	pit_clk = of_clk_get(np, 0);
-	if (IS_ERR(pit_clk))
-		return PTR_ERR(pit_clk);
-
-	ret = clk_prepare_enable(pit_clk);
-	if (ret)
-		return ret;
-
-	clk_rate = clk_get_rate(pit_clk);
-	cycle_per_jiffy = clk_rate / (HZ);
-
-	/* enable the pit module */
-	__raw_writel(~PITMCR_MDIS, timer_base + PITMCR);
-
-	ret = pit_clocksource_init(clk_rate);
-	if (ret)
-		return ret;
-
-	return pit_clockevent_init(clk_rate, irq);
-}
-TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
deleted file mode 100644
index e0f7489..0000000
--- a/drivers/clocksource/vt8500_timer.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- *  arch/arm/mach-vt8500/timer.c
- *
- *  Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
- *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This file is copied and modified from the original timer.c provided by
- * Alexey Charkov. Minor changes have been made for Device Tree Support.
- */
-
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/delay.h>
-
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#define VT8500_TIMER_OFFSET	0x0100
-#define VT8500_TIMER_HZ		3000000
-#define TIMER_MATCH_VAL		0x0000
-#define TIMER_COUNT_VAL		0x0010
-#define TIMER_STATUS_VAL	0x0014
-#define TIMER_IER_VAL		0x001c		/* interrupt enable */
-#define TIMER_CTRL_VAL		0x0020
-#define TIMER_AS_VAL		0x0024		/* access status */
-#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
-#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
-#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
-
-#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-
-#define MIN_OSCR_DELTA		16
-
-static void __iomem *regbase;
-
-static u64 vt8500_timer_read(struct clocksource *cs)
-{
-	int loops = msecs_to_loops(10);
-	writel(3, regbase + TIMER_CTRL_VAL);
-	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
-						&& --loops)
-		cpu_relax();
-	return readl(regbase + TIMER_COUNT_VAL);
-}
-
-static struct clocksource clocksource = {
-	.name           = "vt8500_timer",
-	.rating         = 200,
-	.read           = vt8500_timer_read,
-	.mask           = CLOCKSOURCE_MASK(32),
-	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int vt8500_timer_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	int loops = msecs_to_loops(10);
-	u64 alarm = clocksource.read(&clocksource) + cycles;
-	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-						&& --loops)
-		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
-
-	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
-		return -ETIME;
-
-	writel(1, regbase + TIMER_IER_VAL);
-
-	return 0;
-}
-
-static int vt8500_shutdown(struct clock_event_device *evt)
-{
-	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
-	writel(0, regbase + TIMER_IER_VAL);
-	return 0;
-}
-
-static struct clock_event_device clockevent = {
-	.name			= "vt8500_timer",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 200,
-	.set_next_event		= vt8500_timer_set_next_event,
-	.set_state_shutdown	= vt8500_shutdown,
-	.set_state_oneshot	= vt8500_shutdown,
-};
-
-static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq = {
-	.name    = "vt8500_timer",
-	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = vt8500_timer_interrupt,
-	.dev_id  = &clockevent,
-};
-
-static int __init vt8500_timer_init(struct device_node *np)
-{
-	int timer_irq, ret;
-
-	regbase = of_iomap(np, 0);
-	if (!regbase) {
-		pr_err("%s: Missing iobase description in Device Tree\n",
-								__func__);
-		return -ENXIO;
-	}
-
-	timer_irq = irq_of_parse_and_map(np, 0);
-	if (!timer_irq) {
-		pr_err("%s: Missing irq description in Device Tree\n",
-								__func__);
-		return -EINVAL;
-	}
-
-	writel(1, regbase + TIMER_CTRL_VAL);
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	writel(~0, regbase + TIMER_MATCH_VAL);
-
-	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
-	if (ret) {
-		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
-		       __func__, clocksource.name);
-		return ret;
-	}
-
-	clockevent.cpumask = cpumask_of(0);
-
-	ret = setup_irq(timer_irq, &irq);
-	if (ret) {
-		pr_err("%s: setup_irq failed for %s\n", __func__,
-							clockevent.name);
-		return ret;
-	}
-
-	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
-					MIN_OSCR_DELTA * 2, 0xf0000000);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
deleted file mode 100644
index 6127e80..0000000
--- a/drivers/clocksource/zevio-timer.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- *  linux/drivers/clocksource/zevio-timer.c
- *
- *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#define IO_CURRENT_VAL	0x00
-#define IO_DIVIDER	0x04
-#define IO_CONTROL	0x08
-
-#define IO_TIMER1	0x00
-#define IO_TIMER2	0x0C
-
-#define IO_MATCH_BEGIN	0x18
-#define IO_MATCH(x)	(IO_MATCH_BEGIN + ((x) << 2))
-
-#define IO_INTR_STS	0x00
-#define IO_INTR_ACK	0x00
-#define IO_INTR_MSK	0x04
-
-#define CNTL_STOP_TIMER	(1 << 4)
-#define CNTL_RUN_TIMER	(0 << 4)
-
-#define CNTL_INC	(1 << 3)
-#define CNTL_DEC	(0 << 3)
-
-#define CNTL_TOZERO	0
-#define CNTL_MATCH(x)	((x) + 1)
-#define CNTL_FOREVER	7
-
-/* There are 6 match registers but we only use one. */
-#define TIMER_MATCH	0
-
-#define TIMER_INTR_MSK	(1 << (TIMER_MATCH))
-#define TIMER_INTR_ALL	0x3F
-
-struct zevio_timer {
-	void __iomem *base;
-	void __iomem *timer1, *timer2;
-	void __iomem *interrupt_regs;
-
-	struct clk *clk;
-	struct clock_event_device clkevt;
-	struct irqaction clkevt_irq;
-
-	char clocksource_name[64];
-	char clockevent_name[64];
-};
-
-static int zevio_timer_set_event(unsigned long delta,
-				 struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	writel(delta, timer->timer1 + IO_CURRENT_VAL);
-	writel(CNTL_RUN_TIMER | CNTL_DEC | CNTL_MATCH(TIMER_MATCH),
-			timer->timer1 + IO_CONTROL);
-
-	return 0;
-}
-
-static int zevio_timer_shutdown(struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	/* Disable timer interrupts */
-	writel(0, timer->interrupt_regs + IO_INTR_MSK);
-	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-	/* Stop timer */
-	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-	return 0;
-}
-
-static int zevio_timer_set_oneshot(struct clock_event_device *dev)
-{
-	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
-						 clkevt);
-
-	/* Enable timer interrupts */
-	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
-	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-	return 0;
-}
-
-static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
-{
-	struct zevio_timer *timer = dev_id;
-	u32 intr;
-
-	intr = readl(timer->interrupt_regs + IO_INTR_ACK);
-	if (!(intr & TIMER_INTR_MSK))
-		return IRQ_NONE;
-
-	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_ACK);
-	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-
-	if (timer->clkevt.event_handler)
-		timer->clkevt.event_handler(&timer->clkevt);
-
-	return IRQ_HANDLED;
-}
-
-static int __init zevio_timer_add(struct device_node *node)
-{
-	struct zevio_timer *timer;
-	struct resource res;
-	int irqnr, ret;
-
-	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
-	if (!timer)
-		return -ENOMEM;
-
-	timer->base = of_iomap(node, 0);
-	if (!timer->base) {
-		ret = -EINVAL;
-		goto error_free;
-	}
-	timer->timer1 = timer->base + IO_TIMER1;
-	timer->timer2 = timer->base + IO_TIMER2;
-
-	timer->clk = of_clk_get(node, 0);
-	if (IS_ERR(timer->clk)) {
-		ret = PTR_ERR(timer->clk);
-		pr_err("Timer clock not found! (error %d)\n", ret);
-		goto error_unmap;
-	}
-
-	timer->interrupt_regs = of_iomap(node, 1);
-	irqnr = irq_of_parse_and_map(node, 0);
-
-	of_address_to_resource(node, 0, &res);
-	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
-			"%llx.%pOFn_clocksource",
-			(unsigned long long)res.start, node);
-
-	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
-			"%llx.%pOFn_clockevent",
-			(unsigned long long)res.start, node);
-
-	if (timer->interrupt_regs && irqnr) {
-		timer->clkevt.name		= timer->clockevent_name;
-		timer->clkevt.set_next_event	= zevio_timer_set_event;
-		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
-		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
-		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
-		timer->clkevt.rating		= 200;
-		timer->clkevt.cpumask		= cpu_possible_mask;
-		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
-		timer->clkevt.irq		= irqnr;
-
-		writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-		writel(0, timer->timer1 + IO_DIVIDER);
-
-		/* Start with timer interrupts disabled */
-		writel(0, timer->interrupt_regs + IO_INTR_MSK);
-		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-
-		/* Interrupt to occur when timer value matches 0 */
-		writel(0, timer->base + IO_MATCH(TIMER_MATCH));
-
-		timer->clkevt_irq.name		= timer->clockevent_name;
-		timer->clkevt_irq.handler	= zevio_timer_interrupt;
-		timer->clkevt_irq.dev_id	= timer;
-		timer->clkevt_irq.flags		= IRQF_TIMER | IRQF_IRQPOLL;
-
-		setup_irq(irqnr, &timer->clkevt_irq);
-
-		clockevents_config_and_register(&timer->clkevt,
-				clk_get_rate(timer->clk), 0x0001, 0xffff);
-		pr_info("Added %s as clockevent\n", timer->clockevent_name);
-	}
-
-	writel(CNTL_STOP_TIMER, timer->timer2 + IO_CONTROL);
-	writel(0, timer->timer2 + IO_CURRENT_VAL);
-	writel(0, timer->timer2 + IO_DIVIDER);
-	writel(CNTL_RUN_TIMER | CNTL_FOREVER | CNTL_INC,
-			timer->timer2 + IO_CONTROL);
-
-	clocksource_mmio_init(timer->timer2 + IO_CURRENT_VAL,
-			timer->clocksource_name,
-			clk_get_rate(timer->clk),
-			200, 16,
-			clocksource_mmio_readw_up);
-
-	pr_info("Added %s as clocksource\n", timer->clocksource_name);
-
-	return 0;
-error_unmap:
-	iounmap(timer->base);
-error_free:
-	kfree(timer);
-	return ret;
-}
-
-static int __init zevio_timer_init(struct device_node *node)
-{
-	return zevio_timer_add(node);
-}
-
-TIMER_OF_DECLARE(zevio_timer, "lsi,zevio-timer", zevio_timer_init);
-- 
2.7.4

