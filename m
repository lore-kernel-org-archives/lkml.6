Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72EEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2092082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ikogvVIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbfBDP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:57:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58004 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbfBDP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:57:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14FsClj058478;
        Mon, 4 Feb 2019 09:54:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549295652;
        bh=sRfewLSOCmw7X5qCkG4/3mIaDUuGix6nNN9Q8VQTNZM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ikogvVIeA3JC9x0NIyrI7heL35FKKtW68Wzv7wehJbObbgbFK5Wur8uLWZ5L6xGNx
         apelH7Ln4bZerE3iwWsfdzThxtipE1iGqj8gwZaKzqLcNU0q/RsZOe0irXWyQi6PZF
         k8hIRZFyc9iMNqg6Sxvw5k9pw/WnhbE/hm8bPuWg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14FsBJt087388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:54:12 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:54:11 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:54:11 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14Fs1mN012077;
        Mon, 4 Feb 2019 09:54:08 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date:   Mon, 4 Feb 2019 17:53:55 +0200
Message-ID: <1549295637-24890-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRUSS module has a SYSCFG which is unique. Add
support for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/bus/ti-sysc.h     | 11 -----
 include/linux/platform_data/ti-sysc.h |  1 +
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index f94d335..5b9c81a 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -622,6 +622,50 @@ static void sysc_show_registers(struct sysc *ddata)
 		buf);
 }
 
+static int sysc_enable_pruss(struct sysc *sysc)
+{
+	int i;
+	u32 reg;
+	bool ready;
+
+	/* configure for Smart Idle & Smart Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg &= ~(SYSC_PRUSS_STANDBY_MASK | SYSC_PRUSS_IDLE_MASK);
+	reg |= SYSC_PRUSS_STANDBY_SMART | SYSC_IDLE_SMART;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+
+	/* bring out of Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg &= ~SYSC_PRUSS_STANDBY_INIT;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+
+	/* wait till we are ready for transactions - delay is arbitrary */
+	for (i = 0; i < 10; i++) {
+		reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+		ready = !(reg & SYSC_PRUSS_SUB_MWAIT);
+		if (ready)
+			break;
+		udelay(5);
+	}
+
+	if (!ready) {
+		dev_err(sysc->dev, "not ready for transaction\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void sysc_disable_pruss(struct sysc *sysc)
+{
+	u32 reg;
+
+	/* initiate Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg |= SYSC_PRUSS_STANDBY_INIT;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+}
+
 static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 {
 	struct ti_sysc_platform_data *pdata;
@@ -649,6 +693,9 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		goto idled;
 	}
 
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		sysc_disable_pruss(ddata);
+
 	for (i = 0; i < ddata->nr_clocks; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
@@ -704,6 +751,9 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 			return error;
 	}
 
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		sysc_enable_pruss(ddata);
+
 awake:
 	ddata->enabled = true;
 
@@ -1573,6 +1623,26 @@ static const struct sysc_capabilities sysc_dra7_mcan = {
 	.regbits = &sysc_regbits_dra7_mcan,
 };
 
+/*
+ * PRUSS on AM33x and later
+ */
+static const struct sysc_regbits sysc_regbits_pruss = {
+	.midle_shift = -ENODEV,
+	.clkact_shift = -ENODEV,
+	.sidle_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+	.dmadisable_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_pruss = {
+	.type = TI_SYSC_PRUSS,
+	.sysc_mask = SYSC_PRUSS_STANDBY_INIT | SYSC_PRUSS_SUB_MWAIT,
+	.regbits = &sysc_regbits_pruss,
+};
+
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
@@ -1702,6 +1772,10 @@ static int sysc_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
 
+	/* FIXME: how to ensure PRUSS stays enabled? */
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		goto skip_pm_put;
+
 	/* At least earlycon won't survive without deferred idle */
 	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
 				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
@@ -1710,6 +1784,8 @@ static int sysc_probe(struct platform_device *pdev)
 		pm_runtime_put(&pdev->dev);
 	}
 
+skip_pm_put:
+
 	if (!of_get_available_child_count(ddata->dev->of_node))
 		reset_control_assert(ddata->rsts);
 
@@ -1766,6 +1842,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
 	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
+	{ .compatible = "ti,sysc-pruss", .data = &sysc_pruss, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 8ec78e8..7138384 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -17,17 +17,6 @@
 
 #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
 
-/* SYSCONFIG specific to PRUSS */
-#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
-#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
-
-#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
-#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
-#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
-#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
-
-#define SYSC_PRUSS_IDLE_MASK		3
-
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 1ea3aab..56098e7 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -15,6 +15,7 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_MCASP,
 	TI_SYSC_OMAP4_USB_HOST_FS,
 	TI_SYSC_DRA7_MCAN,
+	TI_SYSC_PRUSS,
 };
 
 struct ti_sysc_cookie {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

