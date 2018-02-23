Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBWVDe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:03:34 -0500
Received: from muru.com ([72.249.23.125]:58014 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeBWVBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:01:10 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] bus: ti-sysc: Improve handling for no-reset-on-init and no-idle-on-init
Date: Fri, 23 Feb 2018 13:00:52 -0800
Message-Id: <20180223210100.86732-5-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least earlycon needs a delayed idle before the 8250 driver probes
to avoid glitches in the console output. Let's handle the delayed idle
for devices tagged with ti,no-reset-on-init and ti,no-idle-on-init with
delayed_work. Others don't need it, and there should be no need to use
runtime PM autosuspend for the interconnect target driver as it's the
child device drivers that should configure it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -74,6 +74,7 @@ struct sysc {
 	u32 revision;
 	bool enabled;
 	bool needs_resume;
+	struct delayed_work idle_work;
 };
 
 static u32 sysc_read(struct sysc *ddata, int offset)
@@ -1028,6 +1029,16 @@ static int sysc_init_match(struct sysc *ddata)
 	return 0;
 }
 
+static void ti_sysc_idle(struct work_struct *work)
+{
+	struct sysc *ddata;
+
+	ddata = container_of(work, struct sysc, idle_work.work);
+
+	if (pm_runtime_active(ddata->dev))
+		pm_runtime_put_sync(ddata->dev);
+}
+
 static int sysc_probe(struct platform_device *pdev)
 {
 	struct sysc *ddata;
@@ -1081,8 +1092,6 @@ static int sysc_probe(struct platform_device *pdev)
 		goto unprepare;
 	}
 
-	pm_runtime_use_autosuspend(ddata->dev);
-
 	sysc_show_registers(ddata);
 
 	ddata->dev->type = &sysc_device_type;
@@ -1091,13 +1100,19 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto err;
 
-	pm_runtime_mark_last_busy(ddata->dev);
-	pm_runtime_put_autosuspend(ddata->dev);
+	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
+
+	/* At least earlycon won't survive without deferred idle */
+	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
+				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
+		schedule_delayed_work(&ddata->idle_work, 3000);
+	} else {
+		pm_runtime_put(&pdev->dev);
+	}
 
 	return 0;
 
 err:
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 unprepare:
@@ -1111,6 +1126,8 @@ static int sysc_remove(struct platform_device *pdev)
 	struct sysc *ddata = platform_get_drvdata(pdev);
 	int error;
 
+	cancel_delayed_work_sync(&ddata->idle_work);
+
 	error = pm_runtime_get_sync(ddata->dev);
 	if (error < 0) {
 		pm_runtime_put_noidle(ddata->dev);
@@ -1120,7 +1137,6 @@ static int sysc_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.16.2
