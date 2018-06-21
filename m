Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBECC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98F820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hgj+ASs1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcbrA3Ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98F820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeFUMYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:24:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:24:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F00E860B18; Thu, 21 Jun 2018 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583850;
        bh=QH29CoXGxxt+WyojtDDWTOGcOUbV9pRrTVFmCBbnuQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hgj+ASs1oIRgb0BYZuTwxZIiEIkzD2TG9gYNHKXYhQfQSE14trri7mOT+4FvXWept
         RQMghRaVQr4DbbibeQU3SelCoKykjZdjzE7eGNh0Fsqc4VeCb86EclVKSItfm7CuJs
         qbv7uFHOIlMgQkaecoWdPvQnYVKljvyX1lMXmVcE=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90C716060A;
        Thu, 21 Jun 2018 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583848;
        bh=QH29CoXGxxt+WyojtDDWTOGcOUbV9pRrTVFmCBbnuQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcbrA3AbYbpqjCGdvmFWDAnU/CdAUICujL09WPUCVCTU3bHz4T1CarojdGEXjCXQ9
         sDrzM2tlztliZVetEpIoC3tHrLSKTuYIPck2023y2gKClK2zoM6d0mDcUTgo4LMbgy
         hjcAaF+gxWItWLU8oGsMM+pyMiCPKbB+JE1bq030=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90C716060A
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
Subject: [PATCH RFC 1/2] mmc: sdhci: Allow platform controlled voltage switching
Date:   Thu, 21 Jun 2018 17:53:45 +0530
Message-Id: <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

Add a quirk, which can be used by drivers of such controllers.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..f0346d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1615,7 +1615,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd)
 {
-	if (IS_ERR(host->mmc->supply.vmmc))
+	if (IS_ERR(host->mmc->supply.vmmc) ||
+			(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
 		sdhci_set_power_noreg(host, mode, vdd);
 	else
 		sdhci_set_power_reg(host, mode, vdd);
@@ -2009,7 +2010,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		if (!IS_ERR(mmc->supply.vqmmc)) {
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				!(host->quirks2 &
+					SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
@@ -2032,7 +2035,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	case MMC_SIGNAL_VOLTAGE_180:
 		if (!(host->flags & SDHCI_SIGNALING_180))
 			return -EINVAL;
-		if (!IS_ERR(mmc->supply.vqmmc)) {
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+			!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
@@ -3485,7 +3489,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
+	if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
+		ret = mmc_regulator_get_supply(mmc);
+	else
+		ret = 0;
 	if (ret)
 		return ret;
 
@@ -3736,7 +3743,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
+			ret = regulator_enable(mmc->supply.vqmmc);
+		else
+			ret = 0;
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..3b0c97a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -450,6 +450,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Regulator voltage changes are being done from platform layer */
+#define SDHCI_QUIRK2_INTERNAL_PWR_CTL				(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

