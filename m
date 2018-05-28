Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424494AbeE1Ll4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423833AbeE1LLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 171/272] watchdog: dw: RMW the control register
Date: Mon, 28 May 2018 12:03:24 +0200
Message-Id: <20180528100255.141945223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit a81abbb412341e9e3b2d42ed7d310cf71fbb84a8 ]

RK3399 has rst_pulse_length in CONTROL_REG[4:2], determining the length
of pulse to issue for system reset. We shouldn't clobber this value,
because that might make the system reset ineffective. On RK3399, we're
seeing that a value of 000b (meaning 2 cycles) yields an unreliable
(partial?) reset, and so we only fully reset after the watchdog fires a
second time. If we retain the system default (010b, or 8 clock cycles),
then the watchdog reset is much more reliable.

Read-modify-write retains the system value and improves reset
reliability.

It seems we were intentionally clobbering the response mode previously,
to ensure we performed a system reset (we don't support an interrupt
notification), so retain that explicitly.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/dw_wdt.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -34,6 +34,7 @@
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
 #define WDOG_CONTROL_REG_WDT_EN_MASK	    0x01
+#define WDOG_CONTROL_REG_RESP_MODE_MASK	    0x02
 #define WDOG_TIMEOUT_RANGE_REG_OFFSET	    0x04
 #define WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT    4
 #define WDOG_CURRENT_COUNT_REG_OFFSET	    0x08
@@ -121,14 +122,23 @@ static int dw_wdt_set_timeout(struct wat
 	return 0;
 }
 
+static void dw_wdt_arm_system_reset(struct dw_wdt *dw_wdt)
+{
+	u32 val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+
+	/* Disable interrupt mode; always perform system reset. */
+	val &= ~WDOG_CONTROL_REG_RESP_MODE_MASK;
+	/* Enable watchdog. */
+	val |= WDOG_CONTROL_REG_WDT_EN_MASK;
+	writel(val, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+}
+
 static int dw_wdt_start(struct watchdog_device *wdd)
 {
 	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 
 	dw_wdt_set_timeout(wdd, wdd->timeout);
-
-	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
-	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+	dw_wdt_arm_system_reset(dw_wdt);
 
 	return 0;
 }
@@ -152,16 +162,13 @@ static int dw_wdt_restart(struct watchdo
 			  unsigned long action, void *data)
 {
 	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
-	u32 val;
 
 	writel(0, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
-	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
-	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
+	if (dw_wdt_is_enabled(dw_wdt))
 		writel(WDOG_COUNTER_RESTART_KICK_VALUE,
 		       dw_wdt->regs + WDOG_COUNTER_RESTART_REG_OFFSET);
 	else
-		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
-		       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+		dw_wdt_arm_system_reset(dw_wdt);
 
 	/* wait for reset to assert... */
 	mdelay(500);
