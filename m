Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JjMLH+cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 837036037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeFFGH5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:07:57 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27635 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeFFGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:07:51 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>,
        <mark.rutland@arm.com>
Subject: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Wed, 6 Jun 2018 11:38:24 +0530
Message-ID: <20180606060826.14671-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/bus/ti-sysc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4a2244419b9b..74d716a7bd6e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -22,11 +22,14 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include <linux/platform_data/ti-sysc.h>
 
 #include <dt-bindings/bus/ti-sysc.h>
 
+#define MAX_MODULE_SOFTRESET_WAIT		10000
+
 static const char * const reg_names[] = { "rev", "sysc", "syss", };
 
 enum sysc_clocks {
@@ -74,6 +77,11 @@ struct sysc {
 	struct delayed_work idle_work;
 };
 
+void sysc_write(struct sysc *ddata, int offset, u32 value)
+{
+	writel_relaxed(value, ddata->module_va + offset);
+}
+
 static u32 sysc_read(struct sysc *ddata, int offset)
 {
 	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
@@ -700,6 +708,26 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+static int sysc_reset(struct sysc *ddata)
+{
+	int offset = ddata->offsets[SYSC_SYSCONFIG];
+	int val = sysc_read(ddata, offset);
+
+	val |= (0x1 << ddata->cap->regbits->srst_shift);
+	sysc_write(ddata, offset, val);
+
+	/* Poll on reset status */
+	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
+		offset = ddata->offsets[SYSC_SYSSTATUS];
+
+		return readl_poll_timeout(ddata->module_va + offset, val,
+				(val & ddata->cfg.syss_mask) == 0x0,
+				100, MAX_MODULE_SOFTRESET_WAIT);
+	}
+
+	return 0;
+}
+
 /* At this point the module is configured enough to read the revision */
 static int sysc_init_module(struct sysc *ddata)
 {
@@ -716,6 +744,18 @@ static int sysc_init_module(struct sysc *ddata)
 
 		return 0;
 	}
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
+	    !ddata->legacy_mode) {
+		error = sysc_reset(ddata);
+		if (error) {
+			dev_err(ddata->dev, "Reset failed with %d\n", error);
+			pm_runtime_put_sync(ddata->dev);
+
+			return error;
+		}
+	}
+
 	ddata->revision = sysc_read_revision(ddata);
 	pm_runtime_put_sync(ddata->dev);
 
-- 
2.17.0
