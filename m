Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeBSU4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:56:40 -0500
Received: from vern.gendns.com ([206.190.152.46]:59819 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbeBSU4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:56:38 -0500
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
Subject: [PATCH v7 31/42] ARM: davinci: switch to common clock framework
Date: Mon, 19 Feb 2018 14:21:52 -0600
Message-Id: <1519071723-31790-32-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
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
index 7e3d535..563fade 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -608,13 +608,16 @@ config ARCH_S3C24XX
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
index 4e81780..8725d8b 100644
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
index d7894d5..2d05856 100644
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
index a200977..a227f80 100644
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
index 8af9f09..b58707c 100644
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
2.7.4
