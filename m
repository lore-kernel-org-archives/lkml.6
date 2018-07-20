Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5264ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518AB20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PFCq8P2U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PFCq8P2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518AB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeGTLeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:34:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:34:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91C5C60452; Fri, 20 Jul 2018 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083589;
        bh=i0dHwrywsGlepkwBzxXQ5WOwcSMGz2tAahBjD6is1so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFCq8P2UGXc+isa0lIuf7EDVawEqdaSKGwZ9GKvtCFrlxmsYt07m8SSnTwka51mbB
         bIpV8mjsNDL9o32Il6z92g8VapW+mkka6CGHD9J6qVXMLBJoRjBB5/Pb+b0MnXM2Su
         sp4f7s7Vuhl2aKglychKcDoTRUnmLoRrESjTFSMM=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DB96606AC;
        Fri, 20 Jul 2018 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083589;
        bh=i0dHwrywsGlepkwBzxXQ5WOwcSMGz2tAahBjD6is1so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFCq8P2UGXc+isa0lIuf7EDVawEqdaSKGwZ9GKvtCFrlxmsYt07m8SSnTwka51mbB
         bIpV8mjsNDL9o32Il6z92g8VapW+mkka6CGHD9J6qVXMLBJoRjBB5/Pb+b0MnXM2Su
         sp4f7s7Vuhl2aKglychKcDoTRUnmLoRrESjTFSMM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DB96606AC
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
        evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V1 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date:   Fri, 20 Jul 2018 16:16:04 +0530
Message-Id: <1532083566-43215-2-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

During setup/cleanup of host, check whether regulator enable/disable
was already done by platform driver.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..494a1e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3472,6 +3472,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -3485,7 +3486,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
+	if (!mmc->supply.vmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		enable_vqmmc  = true;
+	} else {
+		ret = 0;
+	}
 	if (ret)
 		return ret;
 
@@ -3736,7 +3742,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc)
+			ret = regulator_enable(mmc->supply.vqmmc);
+		else
+			ret = 0;
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
@@ -3984,7 +3993,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) && enable_vqmmc)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4002,7 +4011,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) &&
+			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4135,7 +4145,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) &&
+			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

