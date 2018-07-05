Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80774C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F3240BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QzrwA8BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F3240BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeGEOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:22:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeGEOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:22:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w65ELeWe054384;
        Thu, 5 Jul 2018 09:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530800500;
        bh=1hcz4JYQaJoTM2Q/b8QyenKJ6UGVNK4Wn5L4ovfGhEI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QzrwA8BQP+HE2npSBxH5UFMHRsJwGKLlTupldbh/MIxMZOujD+ISdq/bGxVMfI3w0
         FNwsXOIGRZ2eMZKBAMFH9QNT8iabTlwAVDtIHceFYbdvm9VfL7Xk5KWe+4i66mj5f+
         GYysa/pOXCJNX6O8ryoyIJn9PUvS6p7k1ANolU9Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELeIT004283;
        Thu, 5 Jul 2018 09:21:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 5 Jul
 2018 09:21:39 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 5 Jul 2018 09:21:39 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELPxi020259;
        Thu, 5 Jul 2018 09:21:36 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v4 3/6] bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
Date:   Thu, 5 Jul 2018 19:53:16 +0530
Message-ID: <20180705142319.19583-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180705142319.19583-1-faiz_abbas@ti.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index d8ed5b780ed9..91dc2333af01 100644
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
index 1cc29629d238..ad1cd6888757 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1552,6 +1552,23 @@ static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
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
@@ -1743,6 +1760,7 @@ static const struct of_device_id sysc_match[] = {
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
index 990aad477458..2efa3470a451 100644
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

