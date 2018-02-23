Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBWRQW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:16:22 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:59947 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeBWRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:16:20 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 4/6] ARM: at91: Implement clocksource selection
Date: Fri, 23 Feb 2018 18:15:56 +0100
Message-Id: <20180223171558.7037-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow selecting and unselecting the PIT clocksource driver so it doesn't
have to be compile when unused.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 6d870421a7a6..2d8ca72f9ecf 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -106,6 +106,31 @@ config SOC_AT91SAM9
 	    AT91SAM9X35
 	    AT91SAM9XE
 
+comment "Clocksource driver selection"
+
+config ATMEL_CLOCKSOURCE_PIT
+	bool "Periodic Interval Timer (PIT) support"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_PIT
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+
+config ATMEL_CLOCKSOURCE_TCB
+	bool "Timer Counter Blocks (TCB) support"
+	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5 || COMPILE_TEST
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	depends on !ATMEL_TCLIB
+	select ATMEL_ARM_TCB_CLKSRC
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.16.1
