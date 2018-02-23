Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeBWVEI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:04:08 -0500
Received: from muru.com ([72.249.23.125]:58002 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbeBWVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:01:08 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] bus: ti-sysc: Add suspend and resume handling
Date: Fri, 23 Feb 2018 13:00:50 -0800
Message-Id: <20180223210100.86732-3-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to idle the module on suspend after the children
are suspended.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -58,6 +58,7 @@ static const char * const clock_names[] = { "fck", "ick", };
  * @cfg: interconnect target module configuration
  * @name: name if available
  * @revision: interconnect target module revision
+ * @needs_resume: runtime resume needed on resume from suspend
  */
 struct sysc {
 	struct device *dev;
@@ -71,6 +72,8 @@ struct sysc {
 	struct sysc_config cfg;
 	const char *name;
 	u32 revision;
+	bool enabled;
+	bool needs_resume;
 };
 
 static u32 sysc_read(struct sysc *ddata, int offset)
@@ -497,7 +500,38 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sysc_suspend(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (!ddata->enabled)
+		return 0;
+
+	ddata->needs_resume = true;
+
+	return sysc_runtime_suspend(dev);
+}
+
+static int sysc_resume(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->needs_resume) {
+		ddata->needs_resume = false;
+
+		return sysc_runtime_resume(dev);
+	}
+
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops sysc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sysc_suspend, sysc_resume)
 	SET_RUNTIME_PM_OPS(sysc_runtime_suspend,
 			   sysc_runtime_resume,
 			   NULL)
-- 
2.16.2
