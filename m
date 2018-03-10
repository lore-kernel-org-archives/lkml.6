Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCJDqW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:46:22 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40765 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeCJDqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:46:19 -0500
X-Google-Smtp-Source: AG47ELs4Dq4ZUbTHaCoONOOMSvHDhUG9hkLrCdfU51rUOcq0J3ssbTg7bDEXBdXJok99CDTiDoJrzw==
From: Brian Norris <briannorris@chromium.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] watchdog: dw: save/restore control and timeout across suspend/resume
Date: Fri,  9 Mar 2018 19:46:07 -0800
Message-Id: <20180310034607.254884-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180310034607.254884-1-briannorris@chromium.org>
References: <20180310034607.254884-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms lose this state in suspend. It should be safe to do this
unconditionally.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v2: no change
---
 drivers/watchdog/dw_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 918357bccf5e..501aebb5b81f 100644
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
@@ -205,6 +208,9 @@ static int dw_wdt_suspend(struct device *dev)
 {
 	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
 
+	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+
 	clk_disable_unprepare(dw_wdt->clk);
 
 	return 0;
@@ -218,6 +224,9 @@ static int dw_wdt_resume(struct device *dev)
 	if (err)
 		return err;
 
+	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+
 	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
-- 
2.16.2.660.g709887971b-goog
