Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965914AbeEIR1l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:27:41 -0400
Received: from vern.gendns.com ([206.190.152.46]:51934 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935555AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 15/27] ARM: davinci: switch to common clock framework
Date: Wed,  9 May 2018 12:25:54 -0500
Message-Id: <20180509172606.29387-16-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches ARCH_DAVINCI to use the common clock framework. The legacy
clock code in arch/arm/mach-davinci/ is no longer used. New drivers in
drivers/clk/davinci/ are used instead.

A few macros had to be moved to prevent compilation errors.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- s/compile/compilation and space instead of tab
- add PM_GENERIC_DOMAINS dependencies

v6 changes:
- clean up indent on Common objects section


 arch/arm/Kconfig                | 5 ++++-
 arch/arm/mach-davinci/Makefile  | 4 ++--
 arch/arm/mach-davinci/clock.h   | 4 ----
 arch/arm/mach-davinci/davinci.h | 4 ++++
 arch/arm/mach-davinci/psc.h     | 2 --
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..a57ad13810c8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -609,13 +609,16 @@ config ARCH_S3C24XX
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select HAVE_IDE
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RESET_CONTROLLER
 	select USE_OF
 	select ZONE_DMA
 	help
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 4e8178050027..8725d8bea567 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,8 +5,8 @@
 #
 
 # Common objects
-obj-y 			:= time.o clock.o serial.o psc.o \
-			   usb.o common.o sram.o aemif.o
+obj-y 					:= time.o serial.o usb.o \
+					   common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index d7894d5aaa25..2d058568e004 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -12,10 +12,6 @@
 #ifndef __ARCH_ARM_DAVINCI_CLOCK_H
 #define __ARCH_ARM_DAVINCI_CLOCK_H
 
-#define DAVINCI_PLL1_BASE 0x01c40800
-#define DAVINCI_PLL2_BASE 0x01c40c00
-#define MAX_PLL 2
-
 /* PLL/Reset register offsets */
 #define PLLCTL          0x100
 #define PLLCTL_PLLEN    BIT(0)
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index fa99197d36f9..db4c95ef4d5c 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -35,6 +35,10 @@
 #include <media/davinci/vpbe.h>
 #include <media/davinci/vpbe_osd.h>
 
+#define DAVINCI_PLL1_BASE		0x01c40800
+#define DAVINCI_PLL2_BASE		0x01c40c00
+#define DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01c41000
+
 #define DAVINCI_SYSTEM_MODULE_BASE	0x01c40000
 #define SYSMOD_VDAC_CONFIG		0x2c
 #define SYSMOD_VIDCLKCTL		0x38
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index 8af9f09fc10c..b58707cf7033 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -27,8 +27,6 @@
 #ifndef __ASM_ARCH_PSC_H
 #define __ASM_ARCH_PSC_H
 
-#define	DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01C41000
-
 /* Power and Sleep Controller (PSC) Domains */
 #define DAVINCI_GPSC_ARMDOMAIN		0
 #define DAVINCI_GPSC_DSPDOMAIN		1
-- 
2.17.0
