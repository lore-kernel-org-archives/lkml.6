Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9096ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0A20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C0A20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeGQI6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:58:46 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:50124 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbeGQI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:58:46 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="14237668"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 01:27:19 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 01:27:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] ARM: at91: pm: Add ULP1 mode support
Date:   Tue, 17 Jul 2018 11:26:55 +0300
Message-ID: <1531816017-31986-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenyou Yang <wenyou.yang@atmel.com>

In the ULP1 mode, in order to achieve the lowest power consumption
with the system in retention mode and be able to resume on the wake
up events, all the clocks are shut off, inclusive the embedded 12MHz
RC oscillator, and the number of wake up sources is limited as well.
When the wake up event is asserted, the embedded 12MHz RC oscillator
restarts automatically.

The ULP1 (Ultra Low-power mode 1) is introduced by SAMA5D2.

The previous size of pm_suspend.o was 2148 bytes. With the addition of
ULP1 mode the new size of pm_suspend.o raised at 2456 bytes.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
[claudiu.beznea@microchip.com: aligned with 4.18-rc1]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c         |   1 +
 arch/arm/mach-at91/pm.h         |   3 +-
 arch/arm/mach-at91/pm_suspend.S | 142 ++++++++++++++++++++++++++++++++++------
 include/linux/clk/at91_pmc.h    |   2 +
 4 files changed, 127 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d43f00a715d7..099d8094018c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -42,6 +42,7 @@ extern void at91_pinctrl_gpio_resume(void);
 static const match_table_t pm_modes __initconst = {
 	{ AT91_PM_STANDBY, "standby" },
 	{ AT91_PM_ULP0, "ulp0" },
+	{ AT91_PM_ULP1, "ulp1" },
 	{ AT91_PM_BACKUP, "backup" },
 	{ -1, NULL },
 };
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index c44eaf17db86..9bd4e6ca672a 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -23,7 +23,8 @@
 
 #define	AT91_PM_STANDBY		0x00
 #define AT91_PM_ULP0		0x01
-#define	AT91_PM_BACKUP		0x02
+#define AT91_PM_ULP1		0x02
+#define	AT91_PM_BACKUP		0x03
 
 #ifndef __ASSEMBLY__
 struct at91_pm_data {
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 821322d1a64d..a7c6ae13c945 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -42,6 +42,15 @@ tmp2	.req	r5
 	.endm
 
 /*
+ * Wait for main oscillator selection is done
+ */
+	.macro wait_moscsels
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCSELS
+	beq	1b
+	.endm
+
+/*
  * Wait until PLLA has locked.
  */
 	.macro wait_pllalock
@@ -112,19 +121,20 @@ ENTRY(at91_pm_suspend_in_sram)
 	bl	at91_sramc_self_refresh
 
 	ldr	r0, .pm_mode
-	cmp	r0, #AT91_PM_ULP0
-	beq	ulp0_mode
+	cmp	r0, #AT91_PM_STANDBY
+	beq	standby
 	cmp	r0, #AT91_PM_BACKUP
 	beq	backup_mode
 
+	bl	at91_ulp_mode
+	b	exit_suspend
+
+standby:
 	/* Wait for interrupt */
 	ldr	pmc, .pmc_base
 	at91_cpu_idle
 	b	exit_suspend
 
-ulp0_mode:
-	bl	at91_ulp0_mode
-	b	exit_suspend
 backup_mode:
 	bl	at91_backup_mode
 	b	exit_suspend
@@ -151,7 +161,102 @@ ENTRY(at91_backup_mode)
 	str	tmp1, [r0, #0]
 ENDPROC(at91_backup_mode)
 
-ENTRY(at91_ulp0_mode)
+.macro at91_pm_ulp0_mode
+	ldr	pmc, .pmc_base
+
+	/* Turn off the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait for interrupt */
+	at91_cpu_idle
+
+	/* Turn on the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscrdy
+.endm
+
+/**
+ * Note: This procedure only applies on the platform which uses
+ * the external crystal oscillator as a main clock source.
+ */
+.macro at91_pm_ulp1_mode
+	ldr	pmc, .pmc_base
+
+	/* Switch the main clock source to 12-MHz RC oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Disable the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Switch the master clock source to main clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Enter the ULP1 mode by set WAITMODE bit in CKGR_MOR */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_WAITMODE
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_mckrdy
+
+	/* Enable the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscrdy
+
+	/* Switch the master clock source to slow clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Switch main clock source to crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Switch the master clock source to main clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+.endm
+
+ENTRY(at91_ulp_mode)
 	ldr	pmc, .pmc_base
 
 	/* Save Master clock setting */
@@ -174,22 +279,19 @@ ENTRY(at91_ulp0_mode)
 	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
 	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
 
-	/* Turn off the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
+	ldr	r0, .pm_mode
+	cmp	r0, #AT91_PM_ULP1
+	beq	ulp1_mode
 
-	/* Wait for interrupt */
-	at91_cpu_idle
+	at91_pm_ulp0_mode
+	b	ulp_exit
 
-	/* Turn on the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
+ulp1_mode:
+	at91_pm_ulp1_mode
+	b	ulp_exit
 
-	wait_moscrdy
+ulp_exit:
+	ldr	pmc, .pmc_base
 
 	/* Restore PLLA setting */
 	ldr	tmp1, .saved_pllar
@@ -212,7 +314,7 @@ ENTRY(at91_ulp0_mode)
 	wait_mckrdy
 
 	mov	pc, lr
-ENDPROC(at91_ulp0_mode)
+ENDPROC(at91_ulp_mode)
 
 /*
  * void at91_sramc_self_refresh(unsigned int is_active)
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 6aca5ce8a99a..4ea2cbf9b50d 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -47,8 +47,10 @@
 #define	AT91_CKGR_MOR		0x20			/* Main Oscillator Register [not on SAM9RL] */
 #define		AT91_PMC_MOSCEN		(1    <<  0)		/* Main Oscillator Enable */
 #define		AT91_PMC_OSCBYPASS	(1    <<  1)		/* Oscillator Bypass */
+#define		AT91_PMC_WAITMODE	(1    <<  2)		/* Wait Mode Command */
 #define		AT91_PMC_MOSCRCEN	(1    <<  3)		/* Main On-Chip RC Oscillator Enable [some SAM9] */
 #define		AT91_PMC_OSCOUNT	(0xff <<  8)		/* Main Oscillator Start-up Time */
+#define		AT91_PMC_KEY_MASK	(0xff << 16)
 #define		AT91_PMC_KEY		(0x37 << 16)		/* MOR Writing Key */
 #define		AT91_PMC_MOSCSEL	(1    << 24)		/* Main Oscillator Selection [some SAM9] */
 #define		AT91_PMC_CFDEN		(1    << 25)		/* Clock Failure Detector Enable [some SAM9] */
-- 
2.7.4

