Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B339C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86F520862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NK60s9Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86F520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGIQr0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:47:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45070 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933339AbeGIQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:47:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w69GlCBe092187;
        Mon, 9 Jul 2018 11:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531154832;
        bh=tQJsEaHyyv93K5m2A7LrG63PRcI7bXdM08KYTCpkeuE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NK60s9Dx7Qfz0Sk56tdxZG+gQKNrpy7NJFVN/ghect/DgCNJpL92X5SE/+5/MlTsd
         cT+itUAGtEHQdpwv5jY+63tDDPibmJIHW3Pv/5JsBVBPRhEdpXCgsLF80IK+qP1IIT
         TQdCXCXHsIXqOFxfx+kbQTG3OETX0BN8xU2C4h7E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69GlCJo018088;
        Mon, 9 Jul 2018 11:47:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 11:47:11 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 11:47:11 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69GkpWE001873;
        Mon, 9 Jul 2018 11:47:08 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>, <sboyd@kernel.org>
Subject: [PATCH v5 4/6] bus: ti-sysc: Add support for software reset
Date:   Mon, 9 Jul 2018 22:18:39 +0530
Message-ID: <20180709164841.14182-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/bus/ti-sysc.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ad1cd6888757..1b1b2ced3494 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -23,11 +23,14 @@
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
@@ -88,6 +91,11 @@ struct sysc {
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
@@ -943,6 +951,31 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+static int sysc_reset(struct sysc *ddata)
+{
+	int offset = ddata->offsets[SYSC_SYSCONFIG];
+	int val = sysc_read(ddata, offset);
+
+	/*
+	 * Currently only support reset status in sysstatus.
+	 * Warn and return error in all other cases
+	 */
+	if (!ddata->cfg.syss_mask) {
+		dev_err(ddata->dev, "No ti,syss-mask. Reset failed\n");
+		return -EINVAL;
+	}
+
+	val |= (0x1 << ddata->cap->regbits->srst_shift);
+	sysc_write(ddata, offset, val);
+
+	/* Poll on reset status */
+	offset = ddata->offsets[SYSC_SYSSTATUS];
+
+	return readl_poll_timeout(ddata->module_va + offset, val,
+				  (val & ddata->cfg.syss_mask) == 0x0,
+				  100, MAX_MODULE_SOFTRESET_WAIT);
+}
+
 /* At this point the module is configured enough to read the revision */
 static int sysc_init_module(struct sysc *ddata)
 {
@@ -960,6 +993,17 @@ static int sysc_init_module(struct sysc *ddata)
 		return 0;
 	}
 
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

