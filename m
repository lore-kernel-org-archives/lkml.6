Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEDGFU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:05:20 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:46947 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeEDGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:05:19 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: neidhard.kim@lge.com
X-Original-SENDERIP: 10.178.31.61
X-Original-MAILFROM: neidhard.kim@lge.com
From: Jongsung Kim <neidhard.kim@lge.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>, Jongsung Kim <neidhard.kim@lge.com>
Subject: [PATCH v3] watchdog: sp805: add restart handler
Date: Fri,  4 May 2018 15:05:03 +0900
Message-Id: <1525413903-7066-1-git-send-email-neidhard.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cf2f151a-06d7-368e-7ae5-68e992dfc3ea@roeck-us.net>
References: <cf2f151a-06d7-368e-7ae5-68e992dfc3ea@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add restart handler for SP805 watchdog so that the driver can be
used to reboot the system.

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp805_wdt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 03805bc..9849db0 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -121,6 +121,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 	return div_u64(load, rate);
 }
 
+static int
+wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
+{
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	writel_relaxed(0, wdt->base + WDTCONTROL);
+	writel_relaxed(0, wdt->base + WDTLOAD);
+	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
+
+	return 0;
+}
+
 static int wdt_config(struct watchdog_device *wdd, bool ping)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -197,6 +209,7 @@ static const struct watchdog_ops wdt_ops = {
 	.ping		= wdt_ping,
 	.set_timeout	= wdt_setload,
 	.get_timeleft	= wdt_timeleft,
+	.restart	= wdt_restart,
 };
 
 static int
@@ -230,6 +243,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
+	watchdog_set_restart_priority(&wdt->wdd, 128);
 	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
 
 	ret = watchdog_register_device(&wdt->wdd);
-- 
2.7.4
