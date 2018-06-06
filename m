Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L+hokINg"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F0896037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeFFGHg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:07:36 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:35808 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeFFGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:07:28 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>,
        <mark.rutland@arm.com>
Subject: [PATCH v3 3/6] bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
Date: Wed, 6 Jun 2018 11:38:23 +0530
Message-ID: <20180606060826.14671-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dra76x MCAN generic interconnect module has a its own
format for the bits in the control registers.

Therefore add a new module type, new regbits and new capabilities
specific to the MCAN module.

Acked-by: Rob Herring <robh@kernel.org>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/bus/ti-sysc.txt        |  1 +
 drivers/bus/ti-sysc.c                          | 18 ++++++++++++++++++
 include/dt-bindings/bus/ti-sysc.h              |  2 ++
 include/linux/platform_data/ti-sysc.h          |  1 +
 4 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
index 2957a9ae291f..ebbb11144b7b 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -36,6 +36,7 @@ Required standard properties:
 		"ti,sysc-omap-aes"
 		"ti,sysc-mcasp"
 		"ti,sysc-usb-host-fs"
+		"ti,sysc-dra7-mcan"
 
 - reg		shall have register areas implemented for the interconnect
 		target module in question such as revision, sysc and syss
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 7cd2fd04b212..4a2244419b9b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1262,6 +1262,23 @@ static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
 	.regbits = &sysc_regbits_omap4_usb_host_fs,
 };
 
+static const struct sysc_regbits sysc_regbits_dra7_mcan = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = -ENODEV,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = 4,
+	.srst_shift = 0,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_dra7_mcan = {
+	.type = TI_SYSC_DRA7_MCAN,
+	.sysc_mask = SYSC_DRA7_MCAN_ENAWAKEUP | SYSC_OMAP4_SOFTRESET,
+	.regbits = &sysc_regbits_dra7_mcan,
+};
+
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
@@ -1441,6 +1458,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
+	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 2c005376ac0e..7138384e2ef9 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -15,6 +15,8 @@
 /* SmartReflex sysc found on 36xx and later */
 #define SYSC_OMAP3_SR_ENAWAKEUP		(1 << 26)
 
+#define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
+
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 80ce28d40832..1ea3aab972b4 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -14,6 +14,7 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_SR,
 	TI_SYSC_OMAP4_MCASP,
 	TI_SYSC_OMAP4_USB_HOST_FS,
+	TI_SYSC_DRA7_MCAN,
 };
 
 struct ti_sysc_cookie {
-- 
2.17.0
