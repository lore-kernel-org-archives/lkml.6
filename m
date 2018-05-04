Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeEDTHM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:07:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43040 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeEDTHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:07:10 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v9 12/12] ARM: shmobile: Convert file to use cntvoff
Date: Fri,  4 May 2018 21:05:45 +0200
Message-Id: <20180504190545.5114-13-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a common function is available for CNTVOFF's
initialization, let's convert shmobile-apmu code to use
this function.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h          |  1 -
 arch/arm/mach-shmobile/headsmp-apmu.S    | 22 +---------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  3 ++-
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 43c1ac696274..2109f123bdfb 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -2,7 +2,6 @@
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
-extern void shmobile_init_cntvoff(void);
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
index 5672b5849401..d49ab194766a 100644
--- a/arch/arm/mach-shmobile/headsmp-apmu.S
+++ b/arch/arm/mach-shmobile/headsmp-apmu.S
@@ -11,29 +11,9 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-ENTRY(shmobile_init_cntvoff)
-	/*
-	 * CNTVOFF has to be initialized either from non-secure Hypervisor
-	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
-	 * then it should be handled by the secure code
-	 */
-	cps	#MON_MODE
-	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
-	orr	r0, r1, #1
-	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
-	instr_sync
-	mov	r0, #0
-	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
-	instr_sync
-	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
-	instr_sync
-	cps	#SVC_MODE
-	ret	lr
-ENDPROC(shmobile_init_cntvoff)
-
 #ifdef CONFIG_SMP
 ENTRY(shmobile_boot_apmu)
-	bl	shmobile_init_cntvoff
+	bl	secure_cntvoff_init
 	b	secondary_startup
 ENDPROC(shmobile_boot_apmu)
 #endif
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 5561dbed7a33..4a881026d740 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -26,6 +26,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
+#include <asm/secure_cntvoff.h>
 #include "common.h"
 #include "rcar-gen2.h"
 
@@ -70,7 +71,7 @@ void __init rcar_gen2_timer_init(void)
 	void __iomem *base;
 	u32 freq;
 
-	shmobile_init_cntvoff();
+	secure_cntvoff_init();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
 	    of_machine_is_compatible("renesas,r8a7792") ||
-- 
2.11.0
