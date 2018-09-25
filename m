Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1F02098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jM89ZZ7E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GAt1yRzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeIYVNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:13:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:13:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E0FC60C83; Tue, 25 Sep 2018 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537887926;
        bh=Ue6xH2saKTxpo/fWKIeb3coyDoNCHOvLFInaHjhc2Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM89ZZ7Eo7CRg9LXtZLP5JdBS8A5SjAwWdiD7CyUN+xSWvOfiGGmv5HfdqgpPbKW5
         9WoVeQL59C6oSUA8vq42alOvwCSQw/HUAfkpxpkAQV+hQL8bdgQ9WS6ehKaSY6yPTV
         fmjjvMbgdYvJSJgI7L53Ic3xgjljE/ZGPFdv8IYc=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8DAA60C88;
        Tue, 25 Sep 2018 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537887921;
        bh=Ue6xH2saKTxpo/fWKIeb3coyDoNCHOvLFInaHjhc2Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAt1yRzF1DacKlkdBU1GPEetNG25liB1c6dnaQ4ZPk1TloWlW99eek2T95HT0JSep
         h/Qe4pNkenPhNI52We27gmJLXMW1Migy+5M35KlrX9DTcfW3Ngytgt2TCLIplYdQfb
         S4xfgH492IVAD20ESZxrn4F2nXlTdL4egtTIpQew=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8DAA60C88
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        evgreen@chromium.org, dianders@google.com,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
Date:   Tue, 25 Sep 2018 20:34:35 +0530
Message-Id: <1537887875-29494-3-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On few SDHCI-MSM controllers, the host controller's clock tuning
circuit may go out of sync if controller clocks are gated which
eventually will result in data CRC, command CRC/timeout errors.
To overcome this h/w limitation, the DLL needs to be re-initialized
and restored with its old settings once clocks are ungated.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 486462d..4a83850 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/iopoll.h>
@@ -264,6 +265,8 @@ struct sdhci_msm_host {
 	u32 vmmc_level[2];
 	bool vqmmc_load;
 	u32 vqmmc_level[2];
+	bool restore_dll_cfg_needed;
+	bool restore_dll_cfg;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1068,6 +1071,20 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (rc)
 		return rc;
 
+	/*
+	 * If restore dll config flag is set, then just program the DLL with
+	 * last saved tuning phase. If this operation fails, proceed with
+	 * full-fledged tuning.
+	 */
+	if (msm_host->restore_dll_cfg) {
+		rc = msm_config_cm_dll_phase(host,
+				msm_host->saved_tuning_phase);
+		msm_host->restore_dll_cfg = false;
+		if (!rc)
+			return rc;
+
+	}
+
 	phase = 0;
 	do {
 		/* Set the phase in delay line hw block */
@@ -1075,7 +1092,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (rc)
 			return rc;
 
-		msm_host->saved_tuning_phase = phase;
 		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
@@ -1100,6 +1116,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		rc = msm_config_cm_dll_phase(host, phase);
 		if (rc)
 			return rc;
+		msm_host->saved_tuning_phase = phase;
 		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
 			 mmc_hostname(mmc), phase);
 	} else {
@@ -2049,6 +2066,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	if (device_property_read_bool(&pdev->dev, "qcom,restore-dll-config"))
+		msm_host->restore_dll_cfg_needed = true;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -2124,6 +2144,15 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
+	/*
+	 * Whenever core-clock is gated dynamically, it's needed to
+	 * re-initialize the DLL when the clock is ungated.
+	 */
+	if (msm_host->restore_dll_cfg_needed && msm_host->clk_rate) {
+		msm_host->restore_dll_cfg = true;
+		mmc_retune_needed(host->mmc);
+	}
+
 	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				       msm_host->bulk_clks);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

