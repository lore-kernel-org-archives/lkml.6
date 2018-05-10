Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEJSsv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:48:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57242 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEJSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:48 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 8/8] MIPS: jz4740: Drop old platform reset code
Date: Thu, 10 May 2018 20:47:51 +0200
Message-Id: <20180510184751.13416-8-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work is now performed by the watchdog driver directly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: James Hogan <jhogan@kernel.org>
---
 arch/mips/jz4740/reset.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

 v2: No change
 v3: No change

diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 67780c4b6573..5bf0cf44b55f 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,18 +12,9 @@
  *
  */
 
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/pm.h>
-
 #include <asm/reboot.h>
 
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/timer.h>
-
 #include "reset.h"
-#include "clock.h"
 
 static void jz4740_halt(void)
 {
@@ -36,29 +27,7 @@ static void jz4740_halt(void)
 	}
 }
 
-#define JZ_REG_WDT_DATA 0x00
-#define JZ_REG_WDT_COUNTER_ENABLE 0x04
-#define JZ_REG_WDT_COUNTER 0x08
-#define JZ_REG_WDT_CTRL 0x0c
-
-static void jz4740_restart(char *command)
-{
-	void __iomem *wdt_base = ioremap(JZ4740_WDT_BASE_ADDR, 0x0f);
-
-	jz4740_timer_enable_watchdog();
-
-	writeb(0, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-
-	writew(0, wdt_base + JZ_REG_WDT_COUNTER);
-	writew(0, wdt_base + JZ_REG_WDT_DATA);
-	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
-
-	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_halt();
-}
-
 void jz4740_reset_init(void)
 {
-	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
 }
-- 
2.11.0
