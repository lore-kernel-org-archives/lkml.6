Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66CF20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jZRBbOFI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U+wW/if9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66CF20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJHUeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:34:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:34:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 004D960769; Mon,  8 Oct 2018 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004941;
        bh=fgqo74zOcHyf4Bte0NwVayfSzF1zdMXTrDJZBGbTJ0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZRBbOFI7t2MyxZgERgbNoV2L0TqCt33250JRhBZde46xImg1qCGa6LyGsSN6RpMS
         gn1e3hF50fhx/zKmYk8o9AZbGDckRbOMMMFy1fzjS8SfdRBGFAahwvOmoOdX54A2ZD
         xhNaDelmpGHuDZUW2G9JZtoSNDAclROVtwKsaKEQ=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2D5060769;
        Mon,  8 Oct 2018 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004940;
        bh=fgqo74zOcHyf4Bte0NwVayfSzF1zdMXTrDJZBGbTJ0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+wW/if9zpU+E8+uTtTtjHDnPtJCQ3frf8C8MfgBdYc/RURT+khl3grityVFeDPvU
         XF4L6wNADcFx+KXpqy8KMGWHbCGoURvOGf0Fi2NOBVDOAu2QKzVy4ZTmkVhE3L7+y/
         3tt9lj5Cv79ej6QqsRRcRDlNnNdxtfHkyWAhrIDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2D5060769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date:   Mon,  8 Oct 2018 18:48:57 +0530
Message-Id: <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

During setup/cleanup of host, check whether regulator enable/disable
was already done by platform driver.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae5..ea7ce1d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3616,6 +3616,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -3629,9 +3630,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
-	if (ret)
-		return ret;
+	if (!mmc->supply.vqmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		if (ret)
+			return ret;
+		enable_vqmmc  = true;
+	}
 
 	DBG("Version:   0x%08x | Present:  0x%08x\n",
 	    sdhci_readw(host, SDHCI_HOST_VERSION),
@@ -3880,7 +3884,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret) {
+				pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
+					mmc_hostname(mmc), ret);
+				mmc->supply.vqmmc = ERR_PTR(-EINVAL);
+			}
+			host->vqmmc_enabled = !ret;
+		}
 
 		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
@@ -3893,12 +3905,6 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
 						    3600000))
 			host->flags &= ~SDHCI_SIGNALING_330;
-
-		if (ret) {
-			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
-				mmc_hostname(mmc), ret);
-			mmc->supply.vqmmc = ERR_PTR(-EINVAL);
-		}
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
@@ -4136,7 +4142,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4154,7 +4160,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4287,7 +4293,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b001cf4..3c28152 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -524,6 +524,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool vqmmc_enabled;	/* Vqmmc is enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

