Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8486E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IG8ypu0c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iV1IOlo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8486E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966417AbeFSNp7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:45:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:45:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A0D9602B6; Tue, 19 Jun 2018 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415955;
        bh=wJJMMLPMNXGqRNoAL/upSLLxbPcepBCaOTSNZOiP0oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG8ypu0c8KhUTV48U5WZrVfrJzbxUp2j7jUvwS8QJINxEKjszivQRINoFhz8QzoLn
         8SWEGEzfTaf83Z4S9j+LU1GgrUX6MjPXlKbobHEAPo1Zeq2g99IYD9rComTT0S8gs0
         NpCRTmi13KIvjUX0KbHTdARgkLsvoNCZ8h0KbVek=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD23860AD8;
        Tue, 19 Jun 2018 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415954;
        bh=wJJMMLPMNXGqRNoAL/upSLLxbPcepBCaOTSNZOiP0oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV1IOlo4G9yRFX1XS8OzZeDnhcrk2olPENjVpvVJYXT3rcEaOO8ZSC/KqCz41owY7
         yo4QKhEww9/DVHg3AfnUyCNfl4hlaT0vtTEU9MyHakDCi28SRbAHs8hcR2Y2l2DJBI
         VA3K8KZ+D+G5uuPAYLJVfIrmflyQ6p+C6bM7KkKM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD23860AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 03/14] clk: qcom: Add HFPLL driver
Date:   Tue, 19 Jun 2018 19:15:14 +0530
Message-Id: <1529415925-28915-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

On some devices (MSM8974 for example), the HFPLLs are
instantiated within the Krait processor subsystem as separate
register regions. Add a driver for these PLLs so that we can
provide HFPLL clocks for use by the system.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |  8 ++++
 drivers/clk/qcom/Makefile |  1 +
 drivers/clk/qcom/hfpll.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/qcom/hfpll.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9c3480d..95f9980 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -253,3 +253,11 @@ config SPMI_PMIC_CLKDIV
 	  Technologies, Inc. SPMI PMIC. It configures the frequency of
 	  clkdiv outputs of the PMIC. These clocks are typically wired
 	  through alternate functions on GPIO pins.
+
+config QCOM_HFPLL
+	tristate "High-Frequency PLL (HFPLL) Clock Controller"
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the high-frequency PLLs present on Qualcomm devices.
+	  Say Y if you want to support CPU frequency scaling on devices
+	  such as MSM8974, APQ8084, etc.
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1331ed7..d486aa3 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
+obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
new file mode 100644
index 0000000..a6de7101
--- /dev/null
+++ b/drivers/clk/qcom/hfpll.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "clk-regmap.h"
+#include "clk-hfpll.h"
+
+static const struct hfpll_data hdata = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x430405d,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.user_val = 0x8,
+	.user_vco_mask = 0x100000,
+	.low_vco_max_rate = 1248000000,
+	.min_rate = 537600000UL,
+	.max_rate = 2900000000UL,
+};
+
+static const struct of_device_id qcom_hfpll_match_table[] = {
+	{ .compatible = "qcom,hfpll" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
+
+static const struct regmap_config hfpll_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x30,
+	.fast_io	= true,
+};
+
+static int qcom_hfpll_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *regmap;
+	struct clk_hfpll *h;
+	struct clk_init_data init = {
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_ops_hfpll,
+	};
+
+	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, &hfpll_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (of_property_read_string_index(dev->of_node, "clock-output-names",
+					  0, &init.name))
+		return -ENODEV;
+
+	h->d = &hdata;
+	h->clkr.hw.init = &init;
+	spin_lock_init(&h->lock);
+
+	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
+}
+
+static struct platform_driver qcom_hfpll_driver = {
+	.probe		= qcom_hfpll_probe,
+	.driver		= {
+		.name	= "qcom-hfpll",
+		.of_match_table = qcom_hfpll_match_table,
+	},
+};
+module_platform_driver(qcom_hfpll_driver);
+
+MODULE_DESCRIPTION("QCOM HFPLL Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-hfpll");
-- 
1.9.1

