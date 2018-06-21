Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFF5C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB04720837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vv2jxnRD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="affvvvRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB04720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeFUMYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:24:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:24:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3D6260714; Thu, 21 Jun 2018 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583855;
        bh=MGMS5nUq485DhDHCUhIEJ+I47Rtfa7lyO4zGhvG17p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vv2jxnRDg86NGNgnz+Zkw1tMjb1+A2RoEVpgtjnjUCOIZoxf0XB0LwtARLQDxUmu+
         I/PrbETmYNqA9KIsaY/vPA156nfB6RH86Xf7AMdeIKbxx9Ou0TFviR6GftDsMnnZ/7
         a8Ds+fomGCoXg5SYisPoRd3MQ0llNwUm6WndxjLU=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 610F7604A6;
        Thu, 21 Jun 2018 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583854;
        bh=MGMS5nUq485DhDHCUhIEJ+I47Rtfa7lyO4zGhvG17p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=affvvvREbXtgoC9j6/DrVwsGBgvanlsx/+2gIlpZmtQ5YdEIlVMHTkmOakHITHVfp
         DoM4qnLvZdlNGhLZJ5YAHDmZHSeg64y/+w+h7+GMfe5Djzq6YMi1W4+YccxwlTtSZ3
         grGJjG1bVxqfV+8JS/iVXNAaHR+UQJEtEGpLDrJk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 610F7604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH RFC 2/2] mmc: sdhci-msm: Use internal voltage control
Date:   Thu, 21 Jun 2018 17:53:46 +0530
Message-Id: <1529583826-42020-3-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sdhci-msm controllers require that voltage switching be done after
the HW is ready for it. The HW informs its readiness through power irq.
The voltage switching should happen only then.

Use the quirk for internal voltage switching and then control the
voltage switching using power irq.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 99 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a0dc3e1..ebdde29 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -43,7 +43,9 @@
 #define CORE_PWRCTL_IO_LOW	BIT(2)
 #define CORE_PWRCTL_IO_HIGH	BIT(3)
 #define CORE_PWRCTL_BUS_SUCCESS BIT(0)
+#define CORE_PWRCTL_BUS_FAIL    BIT(1)
 #define CORE_PWRCTL_IO_SUCCESS	BIT(2)
+#define CORE_PWRCTL_IO_FAIL     BIT(3)
 #define REQ_BUS_OFF		BIT(0)
 #define REQ_BUS_ON		BIT(1)
 #define REQ_IO_LOW		BIT(2)
@@ -258,6 +260,7 @@ struct sdhci_msm_host {
 	bool mci_removed;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
+	bool pltfm_init_done;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1314,8 +1317,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	u32 irq_status, irq_ack = 0;
-	int retry = 10;
+	int retry = 10, ret = 0;
 	u32 pwr_state = 0, io_level = 0;
 	u32 config;
 	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
@@ -1351,14 +1355,59 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
-		pwr_state = REQ_BUS_ON;
-		io_level = REQ_IO_HIGH;
-		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		if (mmc->supply.vmmc) {
+			ret = regulator_set_load(mmc->supply.vmmc, 800000);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					mmc->ios.vdd);
+			if (ret)
+				pr_err("%s: vmmc enable failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (mmc->supply.vqmmc && !ret) {
+			ret = regulator_set_load(mmc->supply.vqmmc, 22000);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vqmmc,
+					mmc->ios.vdd);
+			if (!ret)
+				ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret)
+				pr_err("%s: vqmmc enable failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (!ret) {
+			pwr_state = REQ_BUS_ON;
+			io_level = REQ_IO_HIGH;
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		} else {
+			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret, irq_status);
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		}
 	}
 	if (irq_status & CORE_PWRCTL_BUS_OFF) {
-		pwr_state = REQ_BUS_OFF;
-		io_level = REQ_IO_LOW;
-		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		if (mmc->supply.vmmc && msm_host->pltfm_init_done) {
+			ret = regulator_set_load(mmc->supply.vmmc, 0);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					mmc->ios.vdd);
+			if (ret)
+				pr_err("%s: vqmmc disabling failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (mmc->supply.vqmmc && msm_host->pltfm_init_done && !ret) {
+			ret = regulator_set_load(mmc->supply.vqmmc, 0);
+			ret |= regulator_disable(mmc->supply.vqmmc);
+			if (ret)
+				pr_err("%s: vqmmc disabling failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (!ret) {
+			pwr_state = REQ_BUS_OFF;
+			io_level = REQ_IO_LOW;
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		} else {
+			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret, irq_status);
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		}
 	}
 	/* Handle IO LOW/HIGH */
 	if (irq_status & CORE_PWRCTL_IO_LOW) {
@@ -1370,6 +1419,15 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
 	}
 
+	if (io_level && mmc->supply.vqmmc && !pwr_state) {
+		ret = mmc_regulator_set_vqmmc(mmc, &mmc->ios);
+		if (ret)
+			pr_err("%s: IO_level setting failed(%d). signal_voltage: %d, vdd: %d irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret,
+					mmc->ios.signal_voltage, mmc->ios.vdd,
+					irq_status);
+	}
+
 	/*
 	 * The driver has to acknowledge the interrupt, switch voltages and
 	 * report back if it succeded or not to this register. The voltage
@@ -1415,10 +1473,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		msm_host->curr_pwr_state = pwr_state;
 	if (io_level)
 		msm_host->curr_io_level = io_level;
-
 	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
-		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
-		irq_ack);
+			mmc_hostname(msm_host->mmc), __func__,
+			irq, irq_status, irq_ack);
 }
 
 static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
@@ -1605,6 +1662,19 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
+{
+	int ret = 0;
+
+	ret = mmc_regulator_get_supply(msm_host->mmc);
+	if (ret)
+		return ret;
+	sdhci_msm_set_regulator_caps(msm_host);
+
+	return 0;
+
+}
+
 static const struct sdhci_msm_variant_ops mci_var_ops = {
 	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
 	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
@@ -1650,7 +1720,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_INTERNAL_PWR_CTL,
 	.ops = &sdhci_msm_ops,
 };
 
@@ -1819,6 +1890,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 				msm_offset->core_vendor_spec_capabilities0);
 	}
 
+	ret = sdhci_msm_register_vreg(msm_host);
+	if (ret == -EPROBE_DEFER)
+		goto clk_disable;
+
 	/*
 	 * Power on reset state may trigger power irq if previous status of
 	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
@@ -1867,7 +1942,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-	sdhci_msm_set_regulator_caps(msm_host);
+	msm_host->pltfm_init_done = true;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

