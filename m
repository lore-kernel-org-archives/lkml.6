Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED9A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED9A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeGQI6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:58:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:20207 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeGQI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:58:41 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="16320157"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 01:27:15 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 01:27:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] ARM: at91: pm: Use ULP0 naming instead of slow clock
Date:   Tue, 17 Jul 2018 11:26:54 +0300
Message-ID: <1531816017-31986-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use ULP0 naming instead of slow clock naming for power modes, to
be as closed as possible to datasheet. This commit does the necessary
renaming and macro addition to be as close as possible to the namings
from [1].

[1] https://lore.kernel.org/lkml/1470650705-31418-3-git-send-email-wenyou.yang@atmel.com

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c         | 18 +++++++++---------
 arch/arm/mach-at91/pm.h         |  3 ++-
 arch/arm/mach-at91/pm_suspend.S | 12 ++++++------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 849014c01cf4..d43f00a715d7 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -40,15 +40,15 @@ extern void at91_pinctrl_gpio_resume(void);
 #endif
 
 static const match_table_t pm_modes __initconst = {
-	{ 0, "standby" },
-	{ AT91_PM_SLOW_CLOCK, "ulp0" },
+	{ AT91_PM_STANDBY, "standby" },
+	{ AT91_PM_ULP0, "ulp0" },
 	{ AT91_PM_BACKUP, "backup" },
 	{ -1, NULL },
 };
 
 static struct at91_pm_data pm_data = {
-	.standby_mode = 0,
-	.suspend_mode = AT91_PM_SLOW_CLOCK,
+	.standby_mode = AT91_PM_STANDBY,
+	.suspend_mode = AT91_PM_ULP0,
 };
 
 #define at91_ramc_read(id, field) \
@@ -145,7 +145,7 @@ static int at91_pm_verify_clocks(void)
  */
 int at91_suspend_entering_slow_clock(void)
 {
-	return (pm_data.mode >= AT91_PM_SLOW_CLOCK);
+	return (pm_data.mode >= AT91_PM_ULP0);
 }
 EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 
@@ -186,7 +186,7 @@ static void at91_pm_suspend(suspend_state_t state)
  * event sources; and reduces DRAM power.  But otherwise it's identical to
  * PM_SUSPEND_ON: cpu idle, and nothing fancy done with main or cpu clocks.
  *
- * AT91_PM_SLOW_CLOCK is like STANDBY plus slow clock mode, so drivers must
+ * AT91_PM_ULP0 is like STANDBY plus slow clock mode, so drivers must
  * suspend more deeply, the master clock switches to the clk32k and turns off
  * the main oscillator
  *
@@ -204,7 +204,7 @@ static int at91_pm_enter(suspend_state_t state)
 		/*
 		 * Ensure that clocks are in a valid state.
 		 */
-		if ((pm_data.mode >= AT91_PM_SLOW_CLOCK) &&
+		if (pm_data.mode >= AT91_PM_ULP0 &&
 		    !at91_pm_verify_clocks())
 			goto error;
 
@@ -546,9 +546,9 @@ static void __init at91_pm_backup_init(void)
 	pm_data.sfrbu = NULL;
 
 	if (pm_data.standby_mode == AT91_PM_BACKUP)
-		pm_data.standby_mode = AT91_PM_SLOW_CLOCK;
+		pm_data.standby_mode = AT91_PM_ULP0;
 	if (pm_data.suspend_mode == AT91_PM_BACKUP)
-		pm_data.suspend_mode = AT91_PM_SLOW_CLOCK;
+		pm_data.suspend_mode = AT91_PM_ULP0;
 }
 
 struct pmc_info {
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index f95d31496f08..c44eaf17db86 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -21,7 +21,8 @@
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
 
-#define	AT91_PM_SLOW_CLOCK	0x01
+#define	AT91_PM_STANDBY		0x00
+#define AT91_PM_ULP0		0x01
 #define	AT91_PM_BACKUP		0x02
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index daca91feea6a..821322d1a64d 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -112,8 +112,8 @@ ENTRY(at91_pm_suspend_in_sram)
 	bl	at91_sramc_self_refresh
 
 	ldr	r0, .pm_mode
-	cmp	r0, #AT91_PM_SLOW_CLOCK
-	beq	slow_clock
+	cmp	r0, #AT91_PM_ULP0
+	beq	ulp0_mode
 	cmp	r0, #AT91_PM_BACKUP
 	beq	backup_mode
 
@@ -122,8 +122,8 @@ ENTRY(at91_pm_suspend_in_sram)
 	at91_cpu_idle
 	b	exit_suspend
 
-slow_clock:
-	bl	at91_slowck_mode
+ulp0_mode:
+	bl	at91_ulp0_mode
 	b	exit_suspend
 backup_mode:
 	bl	at91_backup_mode
@@ -151,7 +151,7 @@ ENTRY(at91_backup_mode)
 	str	tmp1, [r0, #0]
 ENDPROC(at91_backup_mode)
 
-ENTRY(at91_slowck_mode)
+ENTRY(at91_ulp0_mode)
 	ldr	pmc, .pmc_base
 
 	/* Save Master clock setting */
@@ -212,7 +212,7 @@ ENTRY(at91_slowck_mode)
 	wait_mckrdy
 
 	mov	pc, lr
-ENDPROC(at91_slowck_mode)
+ENDPROC(at91_ulp0_mode)
 
 /*
  * void at91_sramc_self_refresh(unsigned int is_active)
-- 
2.7.4

