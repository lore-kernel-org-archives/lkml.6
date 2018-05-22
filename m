Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEVSrs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:47:48 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41433 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeEVSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:47:44 -0400
X-Google-Smtp-Source: AB8JxZpvNL9w+WbQlmfp5gV6IIq7ifhFNw9IeZ79P0KTvpr7b2qm9jZ+kIb6fqhOCEcKQd/BZoJAwg==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 3/5] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
Date: Tue, 22 May 2018 11:47:18 -0700
Message-Id: <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the watchdog hardware is already enabled during the boot process,
when the Linux watchdog driver loads, it should reset the watchdog and
tell the watchdog framework. As a result, ping can be generated from
the watchdog framework, until the userspace watchdog daemon takes over
control

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 1484609..408ffbe 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -42,6 +42,7 @@
 	/* control register masks */
 	#define	INT_ENABLE	(1 << 0)
 	#define	RESET_ENABLE	(1 << 1)
+	#define	ENABLE_MASK	(INT_ENABLE | RESET_ENABLE)
 #define WDTINTCLR		0x00C
 #define WDTRIS			0x010
 #define WDTMIS			0x014
@@ -74,6 +75,18 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Set to 1 to keep watchdog running after device release");
 
+/* returns true if wdt is running; otherwise returns false */
+static bool wdt_is_running(struct watchdog_device *wdd)
+{
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	if ((readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK) ==
+	    ENABLE_MASK)
+		return true;
+	else
+		return false;
+}
+
 /* This routine finds load value that will reset system in required timout */
 static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
@@ -239,6 +252,15 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
 	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
 
+	/*
+	 * If HW is already running, enable/reset the wdt and set the running
+	 * bit to tell the wdt subsystem
+	 */
+	if (wdt_is_running(&wdt->wdd)) {
+		wdt_enable(&wdt->wdd);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
+	}
+
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
-- 
2.1.4
