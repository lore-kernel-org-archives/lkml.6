Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeCJCox (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:44:53 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46923 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932792AbeCJCou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:44:50 -0500
X-Google-Smtp-Source: AG47ELsQDxQ46+vo6fQc/bDE/wavRcWDecKaqvI4vgZ6xbpMAQY+R2MarCTngQRlYi1K7x9JztMh+A==
From: Brian Norris <briannorris@chromium.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] watchdog: dw: save/restore control and timeout across suspend/resume
Date: Fri,  9 Mar 2018 18:44:31 -0800
Message-Id: <20180310024431.160195-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180310024431.160195-1-briannorris@chromium.org>
References: <20180310024431.160195-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms lose this state in suspend. It should be safe to do this
unconditionally.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/watchdog/dw_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6925d3e6c6b3..094986047194 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -57,6 +57,9 @@ struct dw_wdt {
 	unsigned long		rate;
 	struct watchdog_device	wdd;
 	struct reset_control	*rst;
+	/* Save/restore */
+	u32			control;
+	u32			timeout;
 };
 
 #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
@@ -204,6 +207,9 @@ static int dw_wdt_suspend(struct device *dev)
 {
 	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
 
+	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+
 	clk_disable_unprepare(dw_wdt->clk);
 
 	return 0;
@@ -217,6 +223,9 @@ static int dw_wdt_resume(struct device *dev)
 	if (err)
 		return err;
 
+	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+
 	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
-- 
2.16.2.660.g709887971b-goog
