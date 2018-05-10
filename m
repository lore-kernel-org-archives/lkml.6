Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeEJSs3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:48:29 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55632 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEJSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:22 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/8] watchdog: JZ4740: Register a restart handler
Date: Thu, 10 May 2018 20:47:46 +0200
Message-Id: <20180510184751.13416-3-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog driver can restart the system by simply configuring the
hardware for a timeout of 0 seconds.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change
 v3: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 22136e3522b9..b8b015a7d045 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
+			      unsigned long action, void *data)
+{
+	wdt_dev->timeout = 0;
+	jz4740_wdt_start(wdt_dev);
+	return 0;
+}
+
 static const struct watchdog_info jz4740_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "jz4740 Watchdog",
@@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.stop = jz4740_wdt_stop,
 	.ping = jz4740_wdt_ping,
 	.set_timeout = jz4740_wdt_set_timeout,
+	.restart = jz4740_wdt_restart,
 };
 
 #ifdef CONFIG_OF
-- 
2.11.0
