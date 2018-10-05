Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50552208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVejPYlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50552208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJEVfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55772 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbeJEVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so2091699wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oEYYRTGl97aVrSRSe9qBL/xkxCMGDRbGRcC+nSH3b8=;
        b=iVejPYlVH5o/1gG4W2ko9F78q+C2Zo3vpDPEEo3cmSMK9Jx+unXxGcUEJsvXblwPzr
         UlJ1M5PTQ9Zh0EGnCxxTUj6EOzpVwlL8Okvd/scyo6lIWehIp1e0T9Ve7ffKZvtW0im+
         TDJN7K2yqt8eSXCVP28TeiZPYzT6irAOg7B60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oEYYRTGl97aVrSRSe9qBL/xkxCMGDRbGRcC+nSH3b8=;
        b=SwWZ90x37e2YjKllBs+jQ4tf7TteW+X+cMn3XqEVO7Y8K5mlUbbLvdWr9UIIOvoAIh
         ZiMiDCGtFSPVB65JTGcXsqCBZRLo2a6eIN0L8JgTLG3inUptgb3FBpr9s/t9wzMNd0wp
         wWZtbYgsMS62iFygUDd7U3oqnvBvdgvNNuJ7KewvIo0ZQ/M1lrc067IlUYWqtTdEO+Ey
         39n0QCra4NG202ZvLazH19FEFzTS99UIybM0HSvkOxilSnq0wEwCpJqrnLSnp9dOSSAp
         eWKSaLsuhBLqk6bNP6kfx06+mFRlJvtFJnSpcV158dMBlJKY3JLLeMPIf73R454mS3Nk
         rgZg==
X-Gm-Message-State: ABuFfogeKOSunTjgJuptb0wyooIbmehkbz3kUxY3y7ZU1cTMVKpYmfAi
        WtPTcUWCbndm1GTqbeny/pg7zw==
X-Google-Smtp-Source: ACcGV62fvxPqIm3v+RlAF03P1/ylo0qeQZs8bGeWjCHog0CtitWkj1+rV/LV++g9FiW7eXhTc7gUig==
X-Received: by 2002:a1c:b20d:: with SMTP id b13-v6mr7940192wmf.141.1538750197964;
        Fri, 05 Oct 2018 07:36:37 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/13] clocksource/drivers: Unify the names to timer-* format
Date:   Fri,  5 Oct 2018 16:35:40 +0200
Message-Id: <1538750143-4282-11-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
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

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                                        | 10 ++++-----
 drivers/clocksource/Makefile                       | 26 +++++++++++-----------
 ...{time-armada-370-xp.c => timer-armada-370-xp.c} |  0
 .../{cadence_ttc_timer.c => timer-cadence-ttc.c}   |  0
 .../clocksource/{time-efm32.c => timer-efm32.c}    |  0
 .../{fsl_ftm_timer.c => timer-fsl-ftm.c}           |  0
 .../{time-lpc32xx.c => timer-lpc32xx.c}            |  0
 .../clocksource/{time-orion.c => timer-orion.c}    |  0
 drivers/clocksource/{owl-timer.c => timer-owl.c}   |  0
 .../{time-pistachio.c => timer-pistachio.c}        |  0
 drivers/clocksource/{qcom-timer.c => timer-qcom.c} |  0
 .../clocksource/{versatile.c => timer-versatile.c} |  0
 .../clocksource/{vf_pit_timer.c => timer-vf-pit.c} |  0
 .../clocksource/{vt8500_timer.c => timer-vt8500.c} |  0
 .../clocksource/{zevio-timer.c => timer-zevio.c}   |  0
 15 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/clocksource/{time-armada-370-xp.c => timer-armada-370-xp.c} (100%)
 rename drivers/clocksource/{cadence_ttc_timer.c => timer-cadence-ttc.c} (100%)
 rename drivers/clocksource/{time-efm32.c => timer-efm32.c} (100%)
 rename drivers/clocksource/{fsl_ftm_timer.c => timer-fsl-ftm.c} (100%)
 rename drivers/clocksource/{time-lpc32xx.c => timer-lpc32xx.c} (100%)
 rename drivers/clocksource/{time-orion.c => timer-orion.c} (100%)
 rename drivers/clocksource/{owl-timer.c => timer-owl.c} (100%)
 rename drivers/clocksource/{time-pistachio.c => timer-pistachio.c} (100%)
 rename drivers/clocksource/{qcom-timer.c => timer-qcom.c} (100%)
 rename drivers/clocksource/{versatile.c => timer-versatile.c} (100%)
 rename drivers/clocksource/{vf_pit_timer.c => timer-vf-pit.c} (100%)
 rename drivers/clocksource/{vt8500_timer.c => timer-vt8500.c} (100%)
 rename drivers/clocksource/{zevio-timer.c => timer-zevio.c} (100%)

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
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
similarity index 100%
rename from drivers/clocksource/time-armada-370-xp.c
rename to drivers/clocksource/timer-armada-370-xp.c
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/timer-cadence-ttc.c
similarity index 100%
rename from drivers/clocksource/cadence_ttc_timer.c
rename to drivers/clocksource/timer-cadence-ttc.c
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/timer-efm32.c
similarity index 100%
rename from drivers/clocksource/time-efm32.c
rename to drivers/clocksource/timer-efm32.c
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/timer-fsl-ftm.c
similarity index 100%
rename from drivers/clocksource/fsl_ftm_timer.c
rename to drivers/clocksource/timer-fsl-ftm.c
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
similarity index 100%
rename from drivers/clocksource/time-lpc32xx.c
rename to drivers/clocksource/timer-lpc32xx.c
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/timer-orion.c
similarity index 100%
rename from drivers/clocksource/time-orion.c
rename to drivers/clocksource/timer-orion.c
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/timer-owl.c
similarity index 100%
rename from drivers/clocksource/owl-timer.c
rename to drivers/clocksource/timer-owl.c
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/timer-pistachio.c
similarity index 100%
rename from drivers/clocksource/time-pistachio.c
rename to drivers/clocksource/timer-pistachio.c
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/timer-qcom.c
similarity index 100%
rename from drivers/clocksource/qcom-timer.c
rename to drivers/clocksource/timer-qcom.c
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/timer-versatile.c
similarity index 100%
rename from drivers/clocksource/versatile.c
rename to drivers/clocksource/timer-versatile.c
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/timer-vf-pit.c
similarity index 100%
rename from drivers/clocksource/vf_pit_timer.c
rename to drivers/clocksource/timer-vf-pit.c
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/timer-vt8500.c
similarity index 100%
rename from drivers/clocksource/vt8500_timer.c
rename to drivers/clocksource/timer-vt8500.c
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/timer-zevio.c
similarity index 100%
rename from drivers/clocksource/zevio-timer.c
rename to drivers/clocksource/timer-zevio.c
-- 
2.7.4

