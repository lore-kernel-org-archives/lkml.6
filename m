Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeCJCos (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:44:48 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41822 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCJCoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:44:46 -0500
X-Google-Smtp-Source: AG47ELvvwQupKce3eRN6A+HjIBryOJMKgLBw4N+454/hveJ4ZwJar1VZ9KZdBPuxdhJbDSgMx6jbkQ==
From: Brian Norris <briannorris@chromium.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] watchdog: dw: RMW the control register
Date: Fri,  9 Mar 2018 18:44:30 -0800
Message-Id: <20180310024431.160195-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3399 has rst_pulse_length in CONTROL_REG[4:2], determining the length
of pulse to issue for system reset. We shouldn't clobber this value,
because that might make the system reset ineffective. On RK3399, we're
seeing that a value of 000b (meaning 2 cycles) yields an unreliable
(partial?) reset, and so we only fully reset after the watchdog fires a
second time. If we retain the system default (010b, or 8 clock cycles),
then the watchdog reset is much more reliable.

Read-modify-write retains the system value and improves reset
reliability.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/watchdog/dw_wdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c2f4ff516230..6925d3e6c6b3 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -34,6 +34,7 @@
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
 #define WDOG_CONTROL_REG_WDT_EN_MASK	    0x01
+#define WDOG_CONTROL_REG_RESP_MODE_MASK	    0x02
 #define WDOG_TIMEOUT_RANGE_REG_OFFSET	    0x04
 #define WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT    4
 #define WDOG_CURRENT_COUNT_REG_OFFSET	    0x08
@@ -124,11 +125,16 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
 static int dw_wdt_start(struct watchdog_device *wdd)
 {
 	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
+	u32 val;
 
 	dw_wdt_set_timeout(wdd, wdd->timeout);
 
-	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
-	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+	/* Disable interrupt mode; always perform system reset. */
+	val &= ~WDOG_CONTROL_REG_RESP_MODE_MASK;
+	/* Enable watchdog. */
+	val |= WDOG_CONTROL_REG_WDT_EN_MASK;
+	writel(val, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 
 	return 0;
 }
-- 
2.16.2.660.g709887971b-goog
