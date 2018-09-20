Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BF2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YtspjF9y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hfWVQnLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22BF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeITMGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:06:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbeITMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:06:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37E1160C7E; Thu, 20 Sep 2018 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537424674;
        bh=EYz4slHTTVi/r4JaP/VX0K53/qSD3Vr9BucdMhLxGf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtspjF9yImuamdDBlhaXnrO2Z0yzf5lBWs3i9uU4GrYtCycoXl8WO7ZxWJZ0tyliz
         7G2jKF9yCgQerr4DfZ+K3uLDR64gsVKtHvJuqfLcBT+TjpfSS3NAR8CYKAzuxkjuOp
         d1MSTyg/bpgUP208E2GhAhvptA3sGDk5cGbFC01s=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C81AF60C5F;
        Thu, 20 Sep 2018 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537424671;
        bh=EYz4slHTTVi/r4JaP/VX0K53/qSD3Vr9BucdMhLxGf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfWVQnLI14s0lAbKi4aqR9ibC6aAKWX1PSD4vlTzdCAg0e4q2q9uGm8/fOj06wLbU
         JguBPt8MI0Xfvz/+sJRncQ1eGv8e82RtElWkOets69o/Pu4OAehQcC2oFkXOYtMW3y
         FRb+vfLzOiLAj5Hae94li9bICTsUnLl1yAHzmCDU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C81AF60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, evgreen@chromium.org, dianders@google.com,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date:   Thu, 20 Sep 2018 11:52:36 +0530
Message-Id: <1537424558-17989-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
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
 drivers/mmc/host/sdhci.c | 22 +++++++++++++++-------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae5..04b3fd2 100644
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
+	if (!mmc->supply.vmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		if (ret)
+			return ret;
+		enable_vqmmc  = true;
+	}
 
 	DBG("Version:   0x%08x | Present:  0x%08x\n",
 	    sdhci_readw(host, SDHCI_HOST_VERSION),
@@ -3880,7 +3884,11 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			host->vqmmc_enabled = !ret;
+		} else
+			ret = 0;
 
 		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
@@ -4136,7 +4144,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4154,7 +4162,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4287,7 +4295,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
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
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

