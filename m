Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeE1SDS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:03:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41196 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbeE1SCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:02:08 -0400
X-Google-Smtp-Source: ADUXVKJhNgyBVbgQ+CbnTh2p7FNuC4JOBZGIK6rdMGIQ3qcHE31zHOlmgH2EMU+fLJ9FMywWNghUpg==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 4/6] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
Date: Mon, 28 May 2018 11:01:35 -0700
Message-Id: <1527530497-10392-5-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp805_wdt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 1484609..d662a6f 100644
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
@@ -74,6 +75,15 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Set to 1 to keep watchdog running after device release");
 
+/* returns true if wdt is running; otherwise returns false */
+static bool wdt_is_running(struct watchdog_device *wdd)
+{
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 wdtcontrol = readl_relaxed(wdt->base + WDTCONTROL);
+
+	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
+}
+
 /* This routine finds load value that will reset system in required timout */
 static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
@@ -239,6 +249,15 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
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
