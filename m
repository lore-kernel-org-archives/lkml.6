Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D020838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="T5eaty4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAGCL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:11:58 -0500
Received: from onstation.org ([52.200.56.107]:46946 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfAGCLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:11:55 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 197454E3;
        Mon,  7 Jan 2019 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546827114;
        bh=MM9qmEaGPw2bUzeGdZnhId/Nid9sR2n/GCWDL3HdrlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5eaty4NY2RyhsHU93vrkAmNc2KfsWh8PeKyCPIFBJKDyTdSXB6RnFQzmjyxiFRB7
         gHJfsrTLQ1jFwIZM21yYp+FybOvA9+NjOJ/MHdIRbsmvcmRxK+psdGUxtQie4Q0jbO
         cIOkFiBASkw1Fg0fr78FEv/tVAfy3F0e/M1Cy7T0=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        lee.jones@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] mfd: qcom-spmi-pmic: use devm_mfd_add_devices instead of devm_of_platform_populate
Date:   Sun,  6 Jan 2019 21:11:42 -0500
Message-Id: <20190107021145.6370-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190107021145.6370-1-masneyb@onstation.org>
References: <20190107021145.6370-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmic_spmi_probe calls devm_of_platform_populate, which traverses all
of the children in device tree from the parent down to the children,
grandchildren, etc. of_irq_count is called on most of the nodes (via
of_device_alloc) and this initializes all of the IRQs. Further along in
the boot process, spmi-gpio is initialized as a hierarchical IRQ chip
in a later patch (with spmi-arb as the parent IRQ domain), and the same
hwirq is now associated with two Linux virqs and IRQs will not work as
expected. Correct this issue by using devm_mfd_add_devices to initialize
just the children so that IRQs are initialized on an as-needed basis.

This patch also selects CONFIG_MFD_CORE since this is required by
devm_mfd_add_devices.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/mfd/Kconfig          |  1 +
 drivers/mfd/qcom-spmi-pmic.c | 61 ++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..ef27b3927295 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -960,6 +960,7 @@ config MFD_SPMI_PMIC
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on OF
 	depends on SPMI
+	select MFD_CORE
 	select REGMAP_SPMI
 	help
 	  This enables support for the Qualcomm SPMI PMICs.
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index e2e95de649a4..21aa880e3503 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -12,10 +12,10 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/spmi.h>
 #include <linux/regmap.h>
-#include <linux/of_platform.h>
 
 #define PMIC_REV2		0x101
 #define PMIC_REV3		0x102
@@ -124,6 +124,61 @@ static const struct regmap_config spmi_regmap_config = {
 	.fast_io	= true,
 };
 
+static const struct mfd_cell pmic_spmi_cells[] = {
+	{
+		.name = "spmi-mpp",
+		.of_compatible = "qcom,spmi-mpp",
+	},
+	{
+		.name = "spmi-temp-alarm",
+		.of_compatible = "qcom,spmi-temp-alarm",
+	},
+	{
+		.name = "pm8941-rtc",
+		.of_compatible = "qcom,pm8941-rtc",
+	},
+	{
+		.name = "pm8941-pwrkey",
+		.of_compatible = "qcom,pm8941-pwrkey",
+	},
+	{
+		.name = "pm8941-misc",
+		.of_compatible = "qcom,pm8941-misc",
+	},
+	{
+		.name = "pm8941-charger",
+		.of_compatible = "qcom,pm8941-charger",
+	},
+	{
+		.name = "spmi-gpio",
+		.of_compatible = "qcom,spmi-gpio",
+	},
+	{
+		.name = "spmi-mpp",
+		.of_compatible = "qcom,spmi-mpp",
+	},
+	{
+		.name = "spmi-vadc",
+		.of_compatible = "qcom,spmi-vadc",
+	},
+	{
+		.name = "spmi-iadc",
+		.of_compatible = "qcom,spmi-iadc",
+	},
+	{
+		.name = "pm8941-coincell",
+		.of_compatible = "qcom,pm8941-coincell",
+	},
+	{
+		.name = "pm8941-wled",
+		.of_compatible = "qcom,pm8941-wled",
+	},
+	{
+		.name = "pm8941-regulators",
+		.of_compatible = "qcom,pm8941-regulators",
+	},
+};
+
 static int pmic_spmi_probe(struct spmi_device *sdev)
 {
 	struct regmap *regmap;
@@ -136,7 +191,9 @@ static int pmic_spmi_probe(struct spmi_device *sdev)
 	if (sdev->usid % 2 == 0)
 		pmic_spmi_show_revid(regmap, &sdev->dev);
 
-	return devm_of_platform_populate(&sdev->dev);
+	return devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_AUTO,
+				    pmic_spmi_cells,
+				    ARRAY_SIZE(pmic_spmi_cells), NULL, 0, NULL);
 }
 
 MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
-- 
2.17.2

