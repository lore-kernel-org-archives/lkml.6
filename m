Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B872084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QJsh380Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aEIDypz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B872084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeGSGAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:00:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeGSGAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:00:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 663DB607EB; Thu, 19 Jul 2018 05:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531977538;
        bh=ZFvL1bgBRmiBmSME8gXls/pAHEjn4pMt2X/o1UWCuzo=;
        h=From:To:Cc:Subject:Date:From;
        b=QJsh380ZXHC/jRyljdmm+f2j59PmsYnT+Q316X/ryzVhkGw9iSQYUFB4cF9phbg0M
         zZU701IvRp5LLLvi795RuympN/DWLIx1U94xWA2+DYpGANh7qUMcXY74nsW0I5zXZk
         u/UQXwhb4hqmQT4rqJblEqvG06iwvuOHLt35C5ZQ=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9ACB1606DB;
        Thu, 19 Jul 2018 05:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531977537;
        bh=ZFvL1bgBRmiBmSME8gXls/pAHEjn4pMt2X/o1UWCuzo=;
        h=From:To:Cc:Subject:Date:From;
        b=aEIDypz49UxR9XnyKslJ3jQIJnXpZnJXVOzGbo/p4i3wJYd7YLVfbXQJBv5xdVYJU
         QuFgN7vo9oY2zidb3isyojyJkUqIo1qd8RGYqKAttl9T3nWEUF9iXgAjkhS4OsTRud
         RwqqUVN/DOBtBWpwvg4eYHFAarql8q8jZLV1mJ8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9ACB1606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     sre@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] power: reset: msm: Add support for download-mode control
Date:   Thu, 19 Jul 2018 10:48:49 +0530
Message-Id: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit '8c1b7dc9b: firmware: qcom: scm: Expose download-mode control'
added support for download-mode control using the scm firmware
driver for platforms which require a secure call to write the magic
cookie into the tcsr location.

For platforms which *do not* need an scm call and where the kernel can
write the cookie by a direct read/write, add similar support in the
msm-poweroff driver.
Similar to the scm driver, the msm-poweroff driver clears the cookie
during a clean reboot.

Download mode using msm-poweroff driver can be enabled by including
msm-poweroff.download_mode=1 on the command line.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../bindings/power/reset/msm-poweroff.txt          |  3 ++
 drivers/power/reset/Kconfig                        | 11 +++++++
 drivers/power/reset/msm-poweroff.c                 | 38 ++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
index ce44ad3..9dd489f 100644
--- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
@@ -8,6 +8,9 @@ settings.
 Required Properties:
 -compatible: "qcom,pshold"
 -reg: Specifies the physical address of the ps-hold register
+Optional Properties:
+-qcom,dload-mode: phandle to the TCSR hardware block and offset of the
+		 download mode control register
 
 Example:
 
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index df58fc8..0c97e34 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -104,6 +104,17 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
 
+config POWER_RESET_MSM_DOWNLOAD_MODE
+	bool "Qualcomm download mode enabled by default"
+	depends on POWER_RESET_MSM
+	help
+	  A device with "download mode" enabled will upon an unexpected
+	  warm-restart enter a special debug mode that allows the user to
+	  "download" memory content over USB for offline postmortem analysis.
+	  The feature can be enabled/disabled on the kernel command line.
+
+	  Say Y here to enable "download mode" by default.
+
 config POWER_RESET_OCELOT_RESET
 	bool "Microsemi Ocelot reset driver"
 	depends on MSCC_OCELOT || COMPILE_TEST
diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 01b8c71..c33eac5 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -18,11 +18,20 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
+#include <linux/regmap.h>
 #include <linux/pm.h>
 
+static bool download_mode = IS_ENABLED(CONFIG_POWER_RESET_MSM_DOWNLOAD_MODE);
+module_param(download_mode, bool, 0);
+
+#define QCOM_SET_DLOAD_MODE 0x10
 static void __iomem *msm_ps_hold;
+static struct regmap *tcsr_regmap;
+static unsigned int dload_mode_offset;
+
 static int deassert_pshold(struct notifier_block *nb, unsigned long action,
 			   void *data)
 {
@@ -44,9 +53,30 @@ static void do_msm_poweroff(void)
 
 static int msm_restart_probe(struct platform_device *pdev)
 {
+	int ret;
+	struct of_phandle_args args;
 	struct device *dev = &pdev->dev;
 	struct resource *mem;
 
+	if (download_mode) {
+		ret = of_parse_phandle_with_fixed_args(dev->of_node,
+						       "qcom,dload-mode", 1, 0,
+						       &args);
+		if (ret < 0)
+			return ret;
+
+		tcsr_regmap = syscon_node_to_regmap(args.np);
+		of_node_put(args.np);
+		if (IS_ERR(tcsr_regmap))
+			return PTR_ERR(tcsr_regmap);
+
+		dload_mode_offset = args.args[0];
+
+		/* Enable download mode by writing the cookie */
+		regmap_write(tcsr_regmap, dload_mode_offset,
+			     QCOM_SET_DLOAD_MODE);
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	msm_ps_hold = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(msm_ps_hold))
@@ -59,6 +89,13 @@ static int msm_restart_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void msm_restart_shutdown(struct platform_device *pdev)
+{
+	/* Clean shutdown, disable download mode to allow normal restart */
+	if (download_mode)
+		regmap_write(tcsr_regmap, dload_mode_offset, 0x0);
+}
+
 static const struct of_device_id of_msm_restart_match[] = {
 	{ .compatible = "qcom,pshold", },
 	{},
@@ -71,6 +108,7 @@ static int msm_restart_probe(struct platform_device *pdev)
 		.name = "msm-restart",
 		.of_match_table = of_match_ptr(of_msm_restart_match),
 	},
+	.shutdown = msm_restart_shutdown,
 };
 
 static int __init msm_restart_init(void)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

