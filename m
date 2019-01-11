Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F0B20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XgoQ2sdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfAKDJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:09:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14108 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfAKDJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:09:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3808d00001>; Thu, 10 Jan 2019 19:09:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 19:09:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 19:09:22 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 03:09:21 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 03:09:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 03:09:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3808e10001>; Thu, 10 Jan 2019 19:09:21 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V8 3/3] mmc: tegra: HW Command Queue Support for Tegra SDMMC
Date:   Thu, 10 Jan 2019 19:08:55 -0800
Message-ID: <1547176135-2470-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547176135-2470-1-git-send-email-skomatineni@nvidia.com>
References: <1547176135-2470-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547176144; bh=W+EMqhP4QQdJI2uJEKSGqKov2aT6TNiVOpJl6lu/rmQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XgoQ2sdFwHJ/wH+zxt6IUYqfy70kzkYM9A5uQwr6fIkBYQE3BcGSK4xbRlc+6aAur
         WP7ZRECJ5G+b5s/gpWKFSA7G7Ik3ykzsPYlytzSH3En3jY63GurIJeLudwvFd9RAYz
         I4ue0Rxw0tLS1RxBExtHYWTF3Lx++WkBiH/z/K7s5/WQY2nkHB3ECgAYDSjsFBrEC4
         6iMiQ0Z1ZC7ccbpHPNjNUey8qZe/Ju4ideCpke4CnHFAg2eejVMSmK73iITPGnZJ9w
         Keq/crXRVY3eQ/PSJShcY6EoykWrC6xW/Tg50/Y8cm3dmDa/CuVQ/Sq0S47/AQWXEQ
         psbGOA8CycfMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds HW Command Queue for supported Tegra SDMMC
controllers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/Kconfig       |   1 +
 drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c       |   9 +++-
 drivers/mmc/host/sdhci.h       |   2 +
 4 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..0739d26c001b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
 	depends on ARCH_TEGRA
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_CQHCI
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
 	  platform with SD or MMC devices, say Y or M here.
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e6ace31e2a41..94ea14651d86 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -33,6 +33,7 @@
 #include <linux/ktime.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 /* Tegra SDHOST controller vendor register definitions */
 #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
@@ -89,6 +90,9 @@
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 
+/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
+#define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
+
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 nvquirks;
@@ -128,6 +132,7 @@ struct sdhci_tegra {
 	u32 default_tap;
 	u32 default_trim;
 	u32 dqs_trim;
+	bool enable_hwcq;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -595,6 +600,20 @@ static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 		tegra_host->dqs_trim = 0x11;
 }
 
+static void tegra_sdhci_parse_dt(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (device_property_read_bool(host->mmc->parent, "supports-cqe"))
+		tegra_host->enable_hwcq = true;
+	else
+		tegra_host->enable_hwcq = false;
+
+	tegra_sdhci_parse_pad_autocal_dt(host);
+	tegra_sdhci_parse_tap_and_trim(host);
+}
+
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -836,6 +855,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 cqcfg = 0;
+
+	/*
+	 * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
+	 * registers when CQE is enabled.
+	 */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	if (cqcfg & CQHCI_ENABLE)
+		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
+
+	sdhci_cqe_enable(mmc);
+
+	if (cqcfg & CQHCI_ENABLE)
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+}
+
+static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
+	.enable	= sdhci_tegra_cqe_enable,
+	.disable = sdhci_cqe_disable,
+	.dumpregs = sdhci_tegra_dumpregs,
+};
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
@@ -989,6 +1051,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
 	.get_max_clock = tegra_sdhci_get_max_clock,
+	.irq = sdhci_tegra_cqhci_irq,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -1030,6 +1093,54 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
 
+static int sdhci_tegra_add_host(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	if (!tegra_host->enable_hwcq)
+		return sdhci_add_host(host);
+
+	host->v4_mode = true;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+
+	cq_host = devm_kzalloc(host->mmc->parent,
+				sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
+	cq_host->ops = &sdhci_tegra_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64)
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret)
+		goto cleanup;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1077,9 +1188,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-	tegra_sdhci_parse_pad_autocal_dt(host);
-
-	tegra_sdhci_parse_tap_and_trim(host);
+	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
@@ -1117,7 +1226,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	usleep_range(2000, 4000);
 
-	rc = sdhci_add_host(host);
+	rc = sdhci_tegra_add_host(host);
 	if (rc)
 		goto err_add_host;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..c6afe793399e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3353,7 +3353,14 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 	ctrl &= ~SDHCI_CTRL_DMA_MASK;
-	if (host->flags & SDHCI_USE_64_BIT_DMA)
+	/*
+	 * Host from V4.10 supports ADMA3 DMA type.
+	 * ADMA3 performs integrated descriptor which is more suitable
+	 * for cmd queuing to fetch both command and transfer descriptors.
+	 */
+	if (host->v4_mode && (host->caps1 & SDHCI_CAN_DO_ADMA3))
+		ctrl |= SDHCI_CTRL_ADMA3;
+	else if (host->flags & SDHCI_USE_64_BIT_DMA)
 		ctrl |= SDHCI_CTRL_ADMA64;
 	else
 		ctrl |= SDHCI_CTRL_ADMA32;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..4070be49d947 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -88,6 +88,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define   SDHCI_CTRL_ADMA3	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_CDTEST_INS	0x40
 #define  SDHCI_CTRL_CDTEST_EN	0x80
@@ -230,6 +231,7 @@
 #define  SDHCI_RETUNING_MODE_SHIFT		14
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
+#define  SDHCI_CAN_DO_ADMA3	0x08000000
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_CAPABILITIES_1	0x44
-- 
2.7.4

