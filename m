Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D091AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E322507
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E322507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbeKPIMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:12:44 -0500
Received: from muru.com ([72.249.23.125]:54120 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeKPIMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:12:43 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BE3F08171;
        Thu, 15 Nov 2018 22:03:06 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] bus: ti-sysc: Add mcasp optional clocks flag
Date:   Thu, 15 Nov 2018 14:02:37 -0800
Message-Id: <20181115220237.32129-3-tony@atomide.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115220237.32129-1-tony@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have OPT_CLKS_NEEDED in legacy platform data, but it's missing
from the ti-sysc driver for device tree based configuration.

In order to pass OPT_CLKS_NEEDED quirk flag we need to update omap4 module
data and add a new compatible for dra7 as the module layout is different
from sysc_regbits_omap4_mcasp.

Fixes: 70a65240efb1 ("bus: ti-sysc: Add register bits for interconnect
target modules")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 drivers/bus/ti-sysc.c                             | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -35,6 +35,7 @@ Required standard properties:
 		"ti,sysc-omap3-sham"
 		"ti,sysc-omap-aes"
 		"ti,sysc-mcasp"
+		"ti,sysc-dra7-mcasp"
 		"ti,sysc-usb-host-fs"
 		"ti,sysc-dra7-mcan"
 
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1503,6 +1503,16 @@ static const struct sysc_regbits sysc_regbits_omap4_mcasp = {
 static const struct sysc_capabilities sysc_omap4_mcasp = {
 	.type = TI_SYSC_OMAP4_MCASP,
 	.regbits = &sysc_regbits_omap4_mcasp,
+	.mod_quirks = SYSC_QUIRK_OPT_CLKS_NEEDED,
+};
+
+/*
+ * McASP found on dra7 and later
+ */
+static const struct sysc_capabilities sysc_dra7_mcasp = {
+	.type = TI_SYSC_OMAP4_SIMPLE,
+	.regbits = &sysc_regbits_omap4_simple,
+	.mod_quirks = SYSC_QUIRK_OPT_CLKS_NEEDED,
 };
 
 /*
@@ -1731,6 +1741,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-omap3-sham", .data = &sysc_omap3_sham, },
 	{ .compatible = "ti,sysc-omap-aes", .data = &sysc_omap3_aes, },
 	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
+	{ .compatible = "ti,sysc-dra7-mcasp", .data = &sysc_dra7_mcasp, },
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
 	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
-- 
2.19.1
