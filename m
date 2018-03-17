Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeCQX3l (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:29:41 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35792 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeCQX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:29:35 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 3/8] doc: Add doc for the Ingenic TCU hardware
Date: Sun, 18 Mar 2018 00:28:56 +0100
Message-Id: <20180317232901.14129-4-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation file about the Timer/Counter Unit (TCU)
present in the Ingenic JZ47xx SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/mips/00-INDEX        |  3 +++
 Documentation/mips/ingenic-tcu.txt | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/mips/ingenic-tcu.txt

 v4: New patch in this series

diff --git a/Documentation/mips/00-INDEX b/Documentation/mips/00-INDEX
index 8ae9cffc2262..8ab8c3f83771 100644
--- a/Documentation/mips/00-INDEX
+++ b/Documentation/mips/00-INDEX
@@ -2,3 +2,6 @@
 	- this file.
 AU1xxx_IDE.README
 	- README for MIPS AU1XXX IDE driver.
+ingenic-tcu.txt
+	- Information file about the Timer/Counter Unit present
+	  in Ingenic JZ47xx SoCs.
diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
new file mode 100644
index 000000000000..2508e5793da8
--- /dev/null
+++ b/Documentation/mips/ingenic-tcu.txt
@@ -0,0 +1,50 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit hardware
+-----------------------------------------------
+
+The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
+hardware block. It features eight channels, that can be used as counters,
+timers, or PWM.
+
+- JZ4770 introduced a separate channel, called Operating System Timer (OST).
+  It is a 64-bit programmable timer.
+
+- Each one of the eight channels has its own clock, which can be reparented
+  to three different clocks (pclk, ext, rtc), gated, and reclocked, through
+  their TCSR register.
+  * The watchdog and OST hardware blocks also feature a TCSR register with
+	the same format in their register space.
+  * The TCU registers used to gate/ungate can also gate/ungate the watchdog
+	and OST clocks.
+
+- On SoCs >= JZ4770, there are two different modes:
+  * Channels 0, 3-7 operate in TCU1 mode: they cannot work in sleep mode,
+	but are easier to operate.
+  * Channels 1-2 operate in TCU2 mode: they can work in sleep mode, but
+	the operation is a bit more complicated than with TCU1 channels.
+
+- Each channel can generate an interrupt. Some channels share an interrupt
+  line, some don't, and this changes between SoC versions:
+  * on JZ4740, timer 0 and timer 1 have their own interrupt line; others share
+	one interrupt line.
+  * on JZ4770 and JZ4780, timer 5 has its own interrupt; timers 0-4 and 6-7 all
+	use one interrupt line; the OST uses the last interrupt.
+
+Implementation
+--------------
+
+The functionalities of the TCU hardware are spread across multiple drivers:
+- interrupts:   drivers/irqchip/irq-ingenic-tcu.c
+- clocks:       drivers/clk/ingenic/tcu.c
+- timer:        drivers/clocksource/timer-ingenic.c
+- PWM:          drivers/pwm/pwm-jz4740.c
+- watchdog:     drivers/watchdog/jz4740_wdt.c
+- OST:			(none yet)
+
+Because various functionalities of the TCU that belong to different drivers
+and frameworks can be controlled from the same registers, all of these drivers
+access their registers through the same regmap.
+
+In practice, the devicetree nodes for all of these drivers must be children
+of a "syscon" node that defines the register area.
+For more information regarding the devicetree bindings of the TCU drivers,
+have a look at Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
-- 
2.11.0
