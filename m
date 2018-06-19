Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A78420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YXq9bZp2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V6rQXKAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A78420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966550AbeFSNq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:46:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 609D560B18; Tue, 19 Jun 2018 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415984;
        bh=mKFYBUhQhFrxTII6ZEExCHQnN8fHIOHpTpjqVUDE0rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXq9bZp2xZNf3cE1UibJeOfLBTdC7KnBcY6sdpVn2v+f15j5qa2PX3HkDeMJ2VD7y
         P9QqsgnCUUzLNfT+LlPdlbmsLuyFHK2Mv+78XD09/VFbTgw4fv9AtmOnP1bP/lQ/c7
         GA1w4RLf80XIwsriPywgqvBbgJXM/zv7YbIV3csQ=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0577660B15;
        Tue, 19 Jun 2018 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415983;
        bh=mKFYBUhQhFrxTII6ZEExCHQnN8fHIOHpTpjqVUDE0rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6rQXKAkOhdNlflru/ML3qwZ+pz1B+wdS9O9+vGP5qxLIsYSrZB9P+QJn2gAmEbjm
         e2mMRGBRLWytF7orb6Vyd08QXvQZySjWjZfehgyB6/SQ26TZhW3/e5pZOKp98Vhmuc
         y/wgsZuKbHT997BdwfzBd4ZF/DUQqGoz3NuZSud4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0577660B15
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
Subject: [PATCH v10 08/14] clk: qcom: Add KPSS ACC/GCC driver
Date:   Tue, 19 Jun 2018 19:15:19 +0530
Message-Id: <1529415925-28915-9-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The ACC and GCC regions present in KPSSv1 contain registers to
control clocks and power to each Krait CPU and L2. For CPUfreq
purposes probe these devices and expose a mux clock that chooses
between PXO and PLL8.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Kconfig    |  8 +++++
 drivers/clk/qcom/Makefile   |  1 +
 drivers/clk/qcom/kpss-xcc.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/qcom/kpss-xcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 66894d2..b17f638 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -262,6 +262,14 @@ config QCOM_HFPLL
 	  Say Y if you want to support CPU frequency scaling on devices
 	  such as MSM8974, APQ8084, etc.
 
+config KPSS_XCC
+	tristate "KPSS Clock Controller"
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the Krait ACC and GCC clock controllers. Say Y
+	  if you want to support CPU frequency scaling on devices such
+	  as MSM8960, APQ8064, etc.
+
 config KRAIT_CLOCKS
 	bool
 	select KRAIT_L2_ACCESSORS
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82615ed..b9cf068 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -43,4 +43,5 @@ obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
+obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
new file mode 100644
index 0000000..8590b5e
--- /dev/null
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+static const char *aux_parents[] = {
+	"pll8_vote",
+	"pxo",
+};
+
+static unsigned int aux_parent_map[] = {
+	3,
+	0,
+};
+
+static const struct of_device_id kpss_xcc_match_table[] = {
+	{ .compatible = "qcom,kpss-acc-v1", .data = (void *)1UL },
+	{ .compatible = "qcom,kpss-gcc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
+
+static int kpss_xcc_driver_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct clk *clk;
+	struct resource *res;
+	void __iomem *base;
+	const char *name;
+
+	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (id->data) {
+		if (of_property_read_string_index(pdev->dev.of_node,
+						  "clock-output-names",
+						  0, &name))
+			return -ENODEV;
+		base += 0x14;
+	} else {
+		name = "acpu_l2_aux";
+		base += 0x28;
+	}
+
+	clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
+				     ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
+				     0, aux_parent_map, NULL);
+
+	platform_set_drvdata(pdev, clk);
+
+	return PTR_ERR_OR_ZERO(clk);
+}
+
+static int kpss_xcc_driver_remove(struct platform_device *pdev)
+{
+	clk_unregister_mux(platform_get_drvdata(pdev));
+	return 0;
+}
+
+static struct platform_driver kpss_xcc_driver = {
+	.probe = kpss_xcc_driver_probe,
+	.remove = kpss_xcc_driver_remove,
+	.driver = {
+		.name = "kpss-xcc",
+		.of_match_table = kpss_xcc_match_table,
+	},
+};
+module_platform_driver(kpss_xcc_driver);
+
+MODULE_DESCRIPTION("Krait Processor Sub System (KPSS) Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:kpss-xcc");
-- 
1.9.1

