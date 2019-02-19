Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A06C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F0521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfBSS6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:58:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:2618 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfBSS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:58:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 10:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="117434299"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 10:58:00 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
        mchehab@kernel.org, james.morse@arm.com
Cc:     thor.thayer@linux.intel.com, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] EDAC, altera: Add separate SDRAM EDAC config
Date:   Tue, 19 Feb 2019 12:59:58 -0600
Message-Id: <1550602799-22737-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
References: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The CONFIG_ALTERA_EDAC flag always enables the SDRAM
EDAC. On the newer architectures, there are cases where
the peripheral EDACs are enabled but SDRAM needs to be
disabled.
This change moves SDRAM functions so they can be contained
inside the conditional CONFIG.
Create new CONFIG option just for SDRAM.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/Kconfig       | 14 +++++++---
 drivers/edac/altera_edac.c | 67 +++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 102a47a09f25..47eb4d13ed5f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -391,9 +391,17 @@ config EDAC_ALTERA
 	depends on EDAC=y && (ARCH_SOCFPGA || ARCH_STRATIX10)
 	help
 	  Support for error detection and correction on the
-	  Altera SOCs. This must be selected for SDRAM ECC.
-	  Note that the preloader must initialize the SDRAM
-	  before loading the kernel.
+	  Altera SOCs. This is the global enable for the
+	  various Altera peripherals.
+
+config EDAC_ALTERA_SDRAM
+	bool "Altera SDRAM ECC"
+	depends on EDAC_ALTERA=y
+	help
+	  Support for error detection and correction on the
+	  Altera SDRAM Memory for Altera SoCs. Note that the
+	  preloader must initialize the SDRAM before loading
+	  the kernel.
 
 config EDAC_ALTERA_L2C
 	bool "Altera L2 Cache ECC"
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 98e0bd8d9f50..1bcf9aea0cdf 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -29,6 +29,7 @@
 #define EDAC_MOD_STR		"altera_edac"
 #define EDAC_DEVICE		"Altera"
 
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
 static const struct altr_sdram_prv_data c5_data = {
 	.ecc_ctrl_offset    = CV_CTLCFG_OFST,
 	.ecc_ctl_en_mask    = CV_CTLCFG_ECC_AUTO_EN,
@@ -468,6 +469,39 @@ static int altr_sdram_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * If you want to suspend, need to disable EDAC by removing it
+ * from the device tree or defconfig.
+ */
+#ifdef CONFIG_PM
+static int altr_sdram_prepare(struct device *dev)
+{
+	pr_err("Suspend not allowed when EDAC is enabled.\n");
+
+	return -EPERM;
+}
+
+static const struct dev_pm_ops altr_sdram_pm_ops = {
+	.prepare = altr_sdram_prepare,
+};
+#endif
+
+static struct platform_driver altr_sdram_edac_driver = {
+	.probe = altr_sdram_probe,
+	.remove = altr_sdram_remove,
+	.driver = {
+		.name = "altr_sdram_edac",
+#ifdef CONFIG_PM
+		.pm = &altr_sdram_pm_ops,
+#endif
+		.of_match_table = altr_sdram_ctrl_of_match,
+	},
+};
+
+module_platform_driver(altr_sdram_edac_driver);
+
+#endif	/* CONFIG_EDAC_ALTERA_SDRAM */
+
 /**************** Stratix 10 EDAC Memory Controller Functions ************/
 
 /**
@@ -530,37 +564,6 @@ static const struct regmap_config s10_sdram_regmap_cfg = {
 
 /************** </Stratix10 EDAC Memory Controller Functions> ***********/
 
-/*
- * If you want to suspend, need to disable EDAC by removing it
- * from the device tree or defconfig.
- */
-#ifdef CONFIG_PM
-static int altr_sdram_prepare(struct device *dev)
-{
-	pr_err("Suspend not allowed when EDAC is enabled.\n");
-
-	return -EPERM;
-}
-
-static const struct dev_pm_ops altr_sdram_pm_ops = {
-	.prepare = altr_sdram_prepare,
-};
-#endif
-
-static struct platform_driver altr_sdram_edac_driver = {
-	.probe = altr_sdram_probe,
-	.remove = altr_sdram_remove,
-	.driver = {
-		.name = "altr_sdram_edac",
-#ifdef CONFIG_PM
-		.pm = &altr_sdram_pm_ops,
-#endif
-		.of_match_table = altr_sdram_ctrl_of_match,
-	},
-};
-
-module_platform_driver(altr_sdram_edac_driver);
-
 /************************* EDAC Parent Probe *************************/
 
 static const struct of_device_id altr_edac_device_of_match[];
@@ -2143,11 +2146,13 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 
 			altr_edac_a10_device_add(edac, child);
 
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
 		else if ((of_device_is_compatible(child, "altr,sdram-edac-a10")) ||
 			 (of_device_is_compatible(child, "altr,sdram-edac-s10")))
 			of_platform_populate(pdev->dev.of_node,
 					     altr_sdram_ctrl_of_match,
 					     NULL, &pdev->dev);
+#endif
 	}
 
 	return 0;
-- 
2.7.4

